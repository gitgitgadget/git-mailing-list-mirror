Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24543C2B9F4
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 02:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5CE3613F5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 02:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhFOCfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 22:35:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58704 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhFOCfB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 22:35:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1507613BA30;
        Mon, 14 Jun 2021 22:32:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xYPQJ68ODgA0
        uewkSjOa8Jj6vGlAsQJwijLck72jP/A=; b=iJ//95q7E+fxYDy1nScgG8lP0QWo
        qmkE+ZBPIvc/Fgd0f8bVY9E1IKJwN1/srtyrK3RVRNdSt1aPnUIaJSXdZFca1Idy
        6k4vdtAZLt8JSOLk+v3fmUTtbJGl6P27QqWJ0puR9zO6TQm2kfsjF0G5r1wkrbRN
        yKQo6iy567nxBbg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0D73E13BA2F;
        Mon, 14 Jun 2021 22:32:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5910213BA2E;
        Mon, 14 Jun 2021 22:32:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] read-cache: fix incorrect count and progress bar
 stalling
References: <cover-0.2-0000000000-20210607T144206Z-avarab@gmail.com>
        <patch-2.2-042f598826-20210607T144206Z-avarab@gmail.com>
        <8f336b1b-6cb7-8277-79d5-0f331159b00c@gmail.com>
        <87k0n54qb6.fsf@evledraar.gmail.com>
        <eaf2b6b0-4202-d5ea-87a2-b828fdbc60a1@web.de>
        <8735tt4fhx.fsf@evledraar.gmail.com> <xmqqczsxtf8g.fsf@gitster.g>
        <87wnr4394y.fsf@evledraar.gmail.com>
        <74183ce6-e17f-1b11-1ceb-7a8d873bc1c7@web.de>
        <87lf7k2bem.fsf@evledraar.gmail.com>
        <f5e181fc-af94-bccf-051f-a58a04fe1ffc@web.de>
        <87zgvszo8i.fsf@evledraar.gmail.com>
        <4f251a35-8b5e-30f0-c742-960cb7c30b57@web.de>
        <87o8c8z105.fsf@evledraar.gmail.com>
Date:   Tue, 15 Jun 2021 11:32:53 +0900
In-Reply-To: <87o8c8z105.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 14 Jun 2021 21:08:11 +0200")
Message-ID: <xmqqy2bbyi0a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FD94E410-CD81-11EB-B20C-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> How does the idea that we show "has been done" make sense when you
> combine the progress.c API with the display_throughput(). I.e. output
> like:
> =09
> 	+Working hard:  50% (1/2)<CR>
> 	+Working hard:  50% (1/2), 1.91 MiB | 195.00 KiB/s<CR>
> 	+Working hard:  50% (1/2), 2.86 MiB | 146.00 KiB/s<CR>
> 	+Working hard:  50% (1/2), 3.81 MiB | 130.00 KiB/s<CR>
> 	+Working hard:  50% (1/2), 3.81 MiB | 97.00 KiB/s, done.
> ...
> That's another reason I'm maintaining that reporting progress as "is
> being done" is the only sane way to look at it, because if you think it=
's
> "has been done" you preclude the API from being used for cases where yo=
u
> e.g. want to download 2 files, each file takes 1 minute, and you want t=
o
> show progress on the item itself.

Sorry, but I do not understand your argument here at all.

If you show "has been completed", when such a thing starts, I'd see
for a minute this:

 Downloading (0/2) ... X MiB | Y kiB/s

and then it will switch to

 Downloading (1/2) ... progress ...

and after staring at it for another minute, I'd see

 Downloading (2/2) ... done.

And such an output makes sense to me.  It is obvious, at least to
me, that the output during the first minute is telling me that it
hasn't finished but working hard to turn that "0" into "1" at the
pace the throughput thing is showing.
