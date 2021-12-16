Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27512C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 22:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239660AbhLPWFr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 17:05:47 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62250 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbhLPWFr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 17:05:47 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D548C1786BD;
        Thu, 16 Dec 2021 17:05:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GhhkAfpousbJ
        JaSkxkOqRslkyM7fRbrPc7xjk62XAOk=; b=eIoz3+39BjIffn3ylo3wsJqtG7j7
        XIbp7C+8Spi0PkB8WGxFXWea4uv9exeKs7WxGU+F0cRibp+9pyY8qSUm6XNlFm1M
        DtKwSoV4FsEpCRQ1ILdx0NcrqNsgx5kdIaSUTHlAC1NiCJlJj0HkEpzi6mUbOxjH
        y9rmjinecBV9ph8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CE4051786BC;
        Thu, 16 Dec 2021 17:05:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 395231786BB;
        Thu, 16 Dec 2021 17:05:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH v3] stash: don't show "git stash push" usage on bad "git
 stash" usage
References: <patch-v2-1.1-d1b9790904c-20210921T134436Z-avarab@gmail.com>
        <patch-v3-1.1-6b33b104c84-20211216T125317Z-avarab@gmail.com>
Date:   Thu, 16 Dec 2021 14:05:40 -0800
In-Reply-To: <patch-v3-1.1-6b33b104c84-20211216T125317Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 16 Dec
 2021 13:54:21
        +0100")
Message-ID: <xmqq8rwk8atn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 501BD4FC-5EBC-11EC-88E0-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This still leaves e.g. "git stash push -h" emitting the
> "git_stash_usage" output, instead of "git_stash_push_usage". That
> should be fixed, but is a much deeper misbehavior in parse_options()
> not being aware of subcommands at all. I.e. in how
> PARSE_OPT_KEEP_UNKNOWN and PARSE_OPT_NO_INTERNAL_HELP combine in
> commands such as "git stash".

I do not necessarily think that is misbehaviour to begin with, but
in any case, it is good to keep the initial fix focused on a small
and clear case, like the one the patch addresses.
