Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F39C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 21:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F629611C7
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 21:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbhJVVXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 17:23:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51561 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhJVVXo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 17:23:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59DCBF6D9F;
        Fri, 22 Oct 2021 17:21:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YOsY1Em9k/He
        SUV3FMaozlVvntNP2YBlNlyVu6cYFtg=; b=Y1GJV08qqL7BBPwEEt5w0Oc6AO6J
        XbzkS3K3Tbo6YN7QNr1k6ccwjW8T1MZrWrgzTjbLV4c8W2nladGw1NAFs5doRr88
        aZn9f4gG4DU/tMdsETTZPUNxCO7FccmLBWWXUv9xqpNc/BPnHK9iUvpkD1wubefh
        AwayT4wzHNJKI8k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 507AFF6D9E;
        Fri, 22 Oct 2021 17:21:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B7A59F6D9D;
        Fri, 22 Oct 2021 17:21:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 2/3] config.c: don't leak memory in
 handle_path_include()
References: <patch-1.1-5a47bf2e9c9-20211021T114223Z-avarab@gmail.com>
        <cover-v2-0.3-00000000000-20211021T195133Z-avarab@gmail.com>
        <patch-v2-2.3-d6d04da1d9d-20211021T195133Z-avarab@gmail.com>
        <xmqqmtn2gdlv.fsf@gitster.g>
        <211022.86ilxpj7si.gmgdl@evledraar.gmail.com>
Date:   Fri, 22 Oct 2021 14:21:24 -0700
In-Reply-To: <211022.86ilxpj7si.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 22 Oct 2021 19:19:26 +0200")
Message-ID: <xmqqh7d8eox7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 03683F6A-337E-11EC-A625-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Not a problem introduced by this function, but if you look at this
>> change with "git show -W", we'd notice that the function name on the
>> hunk header looks strange.  I think we should add a blank line
>> before the beginning of the function.
>
> I think this is a bug in -W, after all if without it we we show the
> function context line, but with it we advance further, then that means
> that -W didn't find the correct function boundary.

That's a chicken-and-egg argument, and I do not think it is a bug in
"-W" nor the funcname regular expression pattern we use.  We expect
a blank line there and the pattern reflects that expectation, so not
having an expected blank line is what causes this problem.

In any case, we should add a blank linke before the beginning of the
function, and of course that is obviously outside the scope of these
patches.
