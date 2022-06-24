Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73176C43334
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 15:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiFXPzw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 11:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiFXPzu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 11:55:50 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE174FC6A
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 08:55:48 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z7so4042457edm.13
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 08:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=eGzffoNI08DLyw1mBhX5iCjfq3XL1W91KTVi8TUzNd8=;
        b=b9Lcl/xEL+XZKyNWlgUleo86i0pKcGoj1e4iHBH6sWj1YzIJjgaStLIjU2RvV0gZQA
         P8o0hqF0ibrfV0ZPTUmOQ13z4gbeZLKTjoi0gNuh1d/WcSzVyZydz7Wg5Q0hCStLlTdq
         diKbhEHf6SJu2NO9AqNNoTCBzvWHBSJAnpGhmgHO4nOEpaUUrqmNlU98qomwDm0DBKPR
         jUXEcqWjsMGl6wmHoBR/xgIj5WPbGsQZmZQbuWXm+ErPESlnWerSyuYDNBPiHUedW6eJ
         KEIJ3gNgw2RuVTBpQGlWcOfjDxvLMMz/V381b256VzrsudCr2KG2BBMMfm3rVq3Idqxd
         MTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=eGzffoNI08DLyw1mBhX5iCjfq3XL1W91KTVi8TUzNd8=;
        b=J9FQ3PldmCsD9soTdbzn8KGTwQyjfIX4hIWKJWntKd1vKxc916ew/I5bmHVWvl+q4U
         My8evgRJi+12/+Iqkid/emxg9Ms5ycpbpBIUyO/5FjaQ8VWO8zthLPtAxMBKGBLWscYs
         lfBoDb3YMbBqW7cYUIY4shmwEvI+J0l0YVAKuZkTQwiRkoPtq8pl1lW2TTy80idMxBRN
         0XXfyxAXHl5YA9Zi4jj1/I4Wm2SIBRJrlMRgbA+jvbwm0SKn/JqP/3hoEF1ZglaOCAr0
         KY6A3rOeNydxbQnt4JvUaIAIouVADxcwqLvYVMo/Z3yavJc0mo/M5AaS0+YtCUuQANxL
         185g==
X-Gm-Message-State: AJIora+DQMOca7JYME3iVfpzn4H7Pq3pn7KbnmXyzgVC7qOym9WJ6GPY
        Wr5RYxK9FF+OzMB95n+0kdo=
X-Google-Smtp-Source: AGRyM1u7ystZXCig9fc7fmpGMIo44VynF2MoZjRw652IZmEwQz+xMPjY5aA7OYktpzbTZDycBnYFuw==
X-Received: by 2002:a05:6402:2812:b0:437:6235:adbe with SMTP id h18-20020a056402281200b004376235adbemr2458725ede.416.1656086147003;
        Fri, 24 Jun 2022 08:55:47 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id hz11-20020a1709072ceb00b00722fc014e8csm1314326ejc.104.2022.06.24.08.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 08:55:46 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o4ler-001ONk-EX;
        Fri, 24 Jun 2022 17:55:45 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stephen Smith <ischis2@cox.net>, git <git@vger.kernel.org>
Subject: Re: SHA-256 transition
Date:   Fri, 24 Jun 2022 17:49:22 +0200
References: <12011256.O9o76ZdvQC@thunderbird>
 <220621.86sfnyuvt0.gmgdl@evledraar.gmail.com>
 <YrI9dvfoc5NYgVDq@tapette.crustytoothpaste.net>
 <YrWXdNGZGN7gXL40@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YrWXdNGZGN7gXL40@coredump.intra.peff.net>
Message-ID: <220624.868rpmhx8e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 24 2022, Jeff King wrote:

> On Wed, Jun 22, 2022 at 12:29:59AM +0000, brian m. carlson wrote:
>
>> > We've since migrated our default hash function from SHA-1 to SHA-1DC
>> > (except on vanilla OSX, see [2]). It's a variant SHA-1 that detects the
>> > SHAttered attack implemented by the same researchers. I'm not aware of a
>> > current viable SHA-1 collision against the variant of SHA-1 that we
>> > actually use these days.
>> 
>> That's true, but that still doesn't let you store the data.  There is
>> some data that you can't store in a SHA-1 repository, and SHA-1DC is
>> extremely slow.  Using SHA-256 can make things like indexing packs
>> substantially faster.
>
> I'm curious if you have numbers on this. I naively converted linux.git
> to sha256 by doing "fast-export | fast-import" (the latter in a sha256
> repo, of course, and then both repacked with "-f --window=250" to get
> reasonable apples-to-apples packs).
>
> Running "index-pack --verify" on the result takes about the same time
> (this is on an 8-core system, hence the real/user differences):
>
>   [sha1dc]
>   real	2m43.754s
>   user	10m52.452s
>   sys	0m36.745s
>
>   [sha256]
>   real	2m41.884s
>   user	12m23.344s
>   sys	0m35.222s
>
> The sha256 repo actually has about 10% fewer objects (I didn't
> investigate, but this is perhaps due to cutting out tags and a few other
> things to convince fast-export to finish running). I'm not sure about
> the extra user time (multicore timings here are funny because of
> frequency scaling, so I think the "real" line is more interesting). So
> sha256 actually comes out a bit worse here. On the other hand, this is
> just using our blk_SHA256 implementation. There may be faster
> alternatives (including ones with hardware support).
>
> I wouldn't be at all surprised if the difference isn't substantial in
> the long run, though. The repo is on the order of 100GB of object data.
> That's a lot to hash, but it's also just a lot to deal with at all (zlib
> inflating, applying deltas, etc).
>
> Anyway, this is a pretty rough cut at an experiment. I was mostly
> curious if you had done something more advanced, and/or gotten different
> results.

I haven't checked or verified this, but
https://www.marc-stevens.nl/research/#software claims:

    Counter-cryptanalysis: New improved release SHA-1 collision
    detection library, which protects against twice as many SHA-1 attack
    classes (disturbance vectors), but is 9 times faster than previous
    version. Speed is now 1.87 times normal SHA-1. It is currently used
    among others by Git, GitHub, GMail, Google Drive and Microsoft
    OneDrive.

And looking at the OID you initially imported for sha1dc (and my later
submodule import) we've always had what seems to have been that
performance improvement, which I think (but I didn't have time to
benchmark) is:
https://github.com/cr-marcstevens/sha1collisiondetection/pull/20

*But* there was also this later performance work:
https://github.com/cr-marcstevens/sha1collisiondetection/pull/30; see
also this comment:
https://github.com/cr-marcstevens/sha1collisiondetection/commit/33a694a9ee1b79c24be45f9eab5ac0e1aeeaf271

And then if you look at the sha1collisiondetection repo the latest tag
is stable-v1.0.3, which pre-dates that (but not the original perf work),
and was tagged in 2017. There were a lot of commits since then.

I wasn't able to find any third party package using DC_SHA1_EXTERNAL,
but I wonder if any performance tests with sha1dc in the wild are using
some older version, which from the looks of it might have had a
performance regression on x86...


