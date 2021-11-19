Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58665C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 22:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbhKSWRN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 17:17:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52226 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbhKSWRL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 17:17:11 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 71D12F29C4;
        Fri, 19 Nov 2021 17:14:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sduXXago2OAO
        qrOEHjDE4cSlvmc7uSFvIzfEmeluzwo=; b=Ms34t4MOMb8BAabCZM8dh4xF9BNR
        eGv75EUQe5nbe6jZcUGjgUIjArbblT9f3PkUuRphdvaT33aBaxiJ6Q2klsYgWHTx
        3xKepxpuwyoozWs94hk8qJyd0RPUmTJp9+SOMOt2rmnBdnboXpcgoqWuEcrefsJB
        sJsQeHW+lIC96no=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67E66F29C3;
        Fri, 19 Nov 2021 17:14:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C88B3F29C2;
        Fri, 19 Nov 2021 17:14:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH 1/2] CI: use shorter names that fit in UX tooltips
References: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com>
        <patch-1.2-26f80c87c8d-20211119T135343Z-avarab@gmail.com>
        <b9da6658-2b00-cc13-e1ae-124d8222dab8@github.com>
Date:   Fri, 19 Nov 2021 14:14:05 -0800
In-Reply-To: <b9da6658-2b00-cc13-e1ae-124d8222dab8@github.com> (Victoria Dye's
        message of "Fri, 19 Nov 2021 11:02:53 -0500")
Message-ID: <xmqq35nrpzde.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 03B68B8E-4986-11EC-AF90-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> Tooltips like the ones you've pointed out here appear intended to be an=
 "at
> a glance" view of the jobs (mostly for showing pass/fail/skip status) -=
 each
> job in the tooltip has a "Details" link that takes you to the job summa=
ry
> and logs. In the current state, although the names of the are truncated=
 in
> the tooltip, the information is still easily accessible in the full wor=
kflow
> details (one click away). For example, the details for the "linux-leaks=
" job
> [1] tell me the image, compiler, and job name right at the top of the p=
age.

While that is all true, if the truncated one does not allow viewers
to easily tell between linux-leaks and linux-gcc and what these are
about, there is not much value to have the "tooltips" in the first
place.  The user will be forced to always visit the details, that
defeats the whole point of having an "at a glance" view.

> By optimizing for the tooltip, this patch shortens names to the point t=
hat
> they're more difficult to interpret (w32 vs. w32/VS) and/or removes val=
uable
> context about platform/image/etc. When a user *does* want more informat=
ion
> on the job, they now have to:=20
>
> 1) know that the "CI/PR" job definition is in ".github/workflows/main.y=
ml"
> 2) parse through the file to find the job they want
> 3) correlate that back to the job in the workflow details they're
>    investigating.=20

That is something I have to do with the current scheme, too.  I do
not think "windows" -> "w32" makes it much worse.

> If the only problem this patch really "solves" is making some job names=
 fit
> a bit better into the tooltip and, I think the costs (namely the loss o=
f
> accessible contextual info) outweigh any potential benefits you gain.=20

I think "fits in the limited space" is a mere approximation of what
renaming effort can achieve.  If we can cram what matters more in
the tight display space we have there, so that we do not have to go
to the details page or to (eek!) the YAML file all the time, that
would be a welcome change.  Between "vs-test (4)" and "w32/vs test
(4)", for example, I do not think there is much difference as both
are equally opaque and I cannot guess what the particular job is
testing.  But if we can have a more informative label, "at a glance"
view would become much more useful, no?

Having said that, I do agree with you that this iteration does a
fairly poor job at it. The only thing that I found very much better
in =C3=86var's sample run over the current one is the "linux-leaks" Job.
All the other changes were "Meh" to me.

If do you think "what matters" is purely personal taste, and we will
not be able to gain a concensus on which part of the whole string
(before truncation) is more important, then it is a different story.
