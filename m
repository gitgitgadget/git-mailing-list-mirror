Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54C3C43334
	for <git@archiver.kernel.org>; Sun, 17 Jul 2022 22:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiGQWAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jul 2022 18:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGQWAp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jul 2022 18:00:45 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D2ACE3A
        for <git@vger.kernel.org>; Sun, 17 Jul 2022 15:00:43 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7BB67146F0A;
        Sun, 17 Jul 2022 18:00:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pUr5dptRR/REWnuhWu02Nh/lSrjvnPBE3DxHM8
        bCRYg=; b=PSwhYPSojXc8z7qscd4NeyIUpJdsiABoNutTjpVnq45hLJ8GeO5HGN
        Hlc6VsB/UVQIyTS01K3jhXhoZ9/mf61+hjcFNP2KfosJoqaeoLerLJkBQF/BQXvg
        a7/Ua2C5q3eI8O5htIJ+mcXrB4LR64IuX4NYy52eSKaHEAVBzD5Ro=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 72C5C146F09;
        Sun, 17 Jul 2022 18:00:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CD6BC146F08;
        Sun, 17 Jul 2022 18:00:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: Can I use CRoaring library in Git?
References: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
        <220716.86y1wtxhok.gmgdl@evledraar.gmail.com>
        <CAPOJW5zNsETYwD=MXCFLn91qaemgooPN-JB1sx7KagkKxOXTnQ@mail.gmail.com>
        <e574ac20-c287-c395-5bc3-b481d81764c7@gmail.com>
Date:   Sun, 17 Jul 2022 15:00:36 -0700
In-Reply-To: <e574ac20-c287-c395-5bc3-b481d81764c7@gmail.com> (Kaartic
        Sivaraam's message of "Sun, 17 Jul 2022 17:55:32 +0530")
Message-ID: <xmqqzgh7v1q3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E411C4A8-061B-11ED-8C1B-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> The EWAH case is a bit different. The original EWAH implementation
> [ewah-cpp] was in C++. It was then ported to C [ewah-c] by Git
> contributors [ewah-git]. The ported version has been relicensed under
> GPLv2 with Deniel Lemire's permission.
>
> The case with CRoaring is that the implementation already exists in C
> [croaring] and that is the one which is licensed under Apache V2. I'm
> not sure how relicensing works for already existing code.

As long as the author says they are willing to relicense, that would
"work".  It is entirely up to them.

> I suppose we could enquire Daniel Lemire about using the Apache licensed
> code for Git. Let's hope for the best.

Request to relicense it so that we can use it in our GPLv2 project.
Relicensing it under GPLv2, MIT, or BSD, would work for us.

Assuming that we can clear the licensing issues (or we can write our
own implementation from spec), how would the transition plan look
like?  Does our bitmap format carry enough metadata to allow
existing clients who never saw anything but ewah bitmaps to say "ah,
this bitmap file uses encoding I do not understand" and gracefully
fall back to not using the bitmap?

Thanks.
