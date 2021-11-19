Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5154EC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 19:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F362610A1
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 19:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbhKSUBG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 15:01:06 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56480 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbhKSUBD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 15:01:03 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6556615999C;
        Fri, 19 Nov 2021 14:58:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bVwQh7KR339e
        FDLwRm4nJqFdez/IZGTDKpErh8PMoDo=; b=q2mtlReVfQXmk87Wr2l5YGeDmOW/
        xOSudztCMFLLR2g/OuHf4Ra19ObS62NUVM2fqRKM+qXTjYIzJFJg7e25RFq4+XXX
        qa8km+Mo0DGjMgaTD9ePsv8ru5s/oYcb/J+IhfRZdLnsr4atti9aG7fSauMaOB+L
        NofcflEoCsF/Wy4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5EC0915999B;
        Fri, 19 Nov 2021 14:58:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AD6E0159996;
        Fri, 19 Nov 2021 14:57:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 0/2] CI: use shorter names for CI jobs, less truncation
References: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com>
Date:   Fri, 19 Nov 2021 11:57:57 -0800
In-Reply-To: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 19 Nov
 2021 14:56:05 +0100")
Message-ID: <xmqqbl2fq5oa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FE8A80D8-4972-11EC-83B0-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This changes the names used in GitHub CI to be shorter, because the
> current ones are so long that they overflow the pop-up tooltips in the
> GitHub UI.
>
> New pop-up visible at: https://github.com/avar/git/tree/avar/ci-shorter=
-names
>
> Full CI run at (currently pending, I had a trivial last-minute
> update):
> https://github.com/avar/git/runs/4264929546?check_suite_focus=3Dtrue

I have found the labels on "Jobs" on the left hand side pane
irritatingly unhelpful.  For example, "regular (linux-gcc-default,
gcc..."  does not tell me much about how it is different from
"regular (linux-gcc, gcc, ubunt...".

The question I ask most often is "which one of these ones is the job
that runs tests twice, the second time with nonstandard settings?",
or "Only windows-test(4) is failing, but not vs-test(4); what area
did we break?  What is in (4)?".

I do not think relabelling "windows" -> "w32" (why not "win", by the
way?), "vs" -> "w32/VS", or "regular (\(.*\))" -> "\1" helps me very
much in these questions.  I however think the blame for it lies
mostly on the original naming, not your effort in this series.

The job that is now called "linux-leaks" used to be "regular
(linux-leaks, gcc, ubu...", and there definitely is an improvement,
so "regular (\(.*\))" -> "\1" could help if the original was named
properly.  It is easier to spot what the job is about for that
particular one.

I find this of mixed value, ranging from "Meh" to "Hmm...nice?".
