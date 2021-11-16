Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EAFC433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 18:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67AFC63212
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 18:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbhKPSvg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 13:51:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63933 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239581AbhKPSvg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 13:51:36 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CAE3CFA4D2;
        Tue, 16 Nov 2021 13:48:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qEgE0Qk2j0h1
        SS2aPIdYyKLxNyXLGs7+xratii+hIdk=; b=USBQW4sG5pV8snoac+Ap1Bxs2Kr+
        axBIGrnbF2IVxKhHr51J/juOyhwI50PMZMajwOuhYkGCPT2BMXS8pMiljpdfvr4v
        SyrAkyq1pY3x18fGOAlDNcNMh9AUfasC7ap7uV5He0DrDrJGfr2VPNEAIzfbfHbR
        DJZGVQ8oipwgaWw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C08B7FA4D1;
        Tue, 16 Nov 2021 13:48:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 269C7FA4D0;
        Tue, 16 Nov 2021 13:48:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, someguy@effective-light.com,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] grep: avoid setting UTF mode when not needed
References: <87bl2kv309.fsf@igel.home>
        <20211116110035.22140-1-carenas@gmail.com>
        <211116.86tugcp8mg.gmgdl@evledraar.gmail.com>
Date:   Tue, 16 Nov 2021 10:48:36 -0800
In-Reply-To: <211116.86tugcp8mg.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 16 Nov 2021 13:32:17 +0100")
Message-ID: <xmqq35nwaqd7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CF6C4302-470D-11EC-B4C1-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> In the context of this being a pretty urgent post-release fix (but I
> don't know if Junio would consider a point-release, so perhaphs it's
> not) I'd be OK with either of:
>
>  A. Let's back out this new log grep color thing entirely while we
>     reconsider this. The gitster/hm/paint-hits-in-log-grep topic
>     currently reverts cleanly.
>
>  B. Don't break the new log grep color thing, and also fix the 'greppin=
g
>     binary' regression (which is much more important than having A)
>
> But let's not go for some in-between where we break the new feature to
> the point of it being worse than the state of not having it at all in
> v2.33.0.
>
> I.e. without the that log grep color feature we wouldn't screw up the
> display of non-ASCII characters in log output (yay), in v2.34.0 we
> don't, but also color the match (yay), but we broke grepping binary
> *files* (boo!).

Sorry, but with too many new patches on the list that are not
urgent, while we wanted to see us work solely on post-release
regression fixes, I do not seem to be able to locate the reports of
this "breakage" and the other binary-file breakage.

But in any case, yes, since the 2.33.0 cycle was run deliberately
loosely to take undercooked topics to 'next' without much reviews
(no, "I looked at some part and they looked OK" is not a review),
and because any topic in 'next', by default, graduates to 'master'
solely on time basis, I am fully expecting that we'd have to issue
2.33.1 (and possibly .2) during the first two or three weeks of this
cycle.  So let's make sure we fix any iffy ones.

Downthread Carlo seem to agree with you that it would be better to
revert the paint-hits-in-log-grep topic wholesale; I have not yet
formed an opinion, as I haven't seen the breakage reports as I said.

As I will be offline most of the day and perhaps tomorrow, nothing
may happen in the meantime on my end, but hopefully we'll see a
reviewed and ready-to-be-applied patchset that people are happy with
by the time I look at the list again ;-)?

Thanks.
