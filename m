Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0743AC433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 23:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7DFB60187
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 23:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhJ2XUs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 19:20:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50582 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhJ2XUr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 19:20:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 16818FD1BB;
        Fri, 29 Oct 2021 19:18:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=IS+mDHM9HdRtIf8b+TTxxHHn8
        aK4+qp6v5hRnhrtyTY=; b=Hh6xT7aJqQhXhR6svok2dO9ejt5zDRQr8eNz5YOsG
        O3EbHa9elwepXuVs1B4fisWQ8YkU8/4wgTny1ra0Sl07ykbHei0IDEXroOmgPI+7
        iI+rIIQ+/S9JwgGeGQGeMxj1pvXtRKobMz4fZjDWeAhcKwz/WS392tzPFSbztuvL
        zQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0CB75FD1B9;
        Fri, 29 Oct 2021 19:18:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 629CDFD1B8;
        Fri, 29 Oct 2021 19:18:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Ivan Frade via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Ivan Frade <ifrade@google.com>
Subject: Re: [PATCH v4 2/2] http-fetch: redact url on die() message
References: <pull.1052.v3.git.1634684260142.gitgitgadget@gmail.com>
        <pull.1052.v4.git.1635288599.gitgitgadget@gmail.com>
        <c7f0977cabd4ba7311b8045bc57e9e30198651fd.1635288599.git.gitgitgadget@gmail.com>
        <211028.86sfwlw10o.gmgdl@evledraar.gmail.com>
Date:   Fri, 29 Oct 2021 16:18:16 -0700
Message-ID: <xmqqpmrnfmiv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7F91AFA0-390E-11EC-9552-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> +			if (!git_env_bool("GIT_TRACE_REDACT", 1) || !nurl) {
>> +				die("Unable to get pack file %s\n%s", preq->url,
>> +				    curl_errorstr);
>
> small nit: arrange if's from "if (cheap || expensive)", i.e. no need fo=
r
> getenv() if !nurl, but maybe compilers are smart enough for that...

They typically do not see what happens inside git_env_bool() while
compling this compilation unit, and cannot tell if the programmer
wanted to call it first for its side effects, hence they cannot
swap them safely.

