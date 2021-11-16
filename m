Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521BEC433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 20:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3051E61BBD
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 20:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhKPUyS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 15:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhKPUyR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 15:54:17 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CD0C061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 12:51:19 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z10so531480edc.11
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 12:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=SxTPZH+3bSuObyzN8wo28wERUBUjIvMnbBMXYNbq3/M=;
        b=OKYpbn9Zrqusb+ROvAd02SUTIGSTD2pu6aLK+DdvR7yIXlvsQlBx0LSIy3rf8vMDsd
         FNf7kdgfWkWV88smc4EQsfNKnMK6/YqCRrgHhLhtxBMXjougFnb9tgyJO1iJ+wavVxUg
         OCWMcwvpHGAu7o5PNGjKCGxhEKZ8q2ti3SGbskMSa/a6uQea5ozGrZ1tBhGtNE6bxmBA
         S10Rtacuh+EVwkKxQaKrWKkMT0Zod1xOruL05eKGReQyfDUnIsv4M9/5gG0t2saxWDAn
         +7usYdBx+7a+IQnZxdE0IoSLTChXK079fp/DPgJbbFINvI/5NYzhqR0oONTVldSHWft0
         dmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=SxTPZH+3bSuObyzN8wo28wERUBUjIvMnbBMXYNbq3/M=;
        b=UlSMWiHNXorDJHlWD8RS5TVulMuR2R0FInEs8ELWshiAxS8yzNZQ4hqwttdgqM1Zu7
         dhf1F3OYaXewE6xj0DF3aynm4fIPz5aWmM8pKk1FCELR0oLarUHDxe5m2WvMEECTESVX
         ZXN63jnh7qBVL3D9jtSEbF7rYwCUtB5JmSwQJbCQVQWMSH46yDGcbWNnjUT3lnSh4a56
         i1Z+TsQGjzM0WoNpktD44VXn2GDti+dZIzU3r/EuUHuubiVlYvCEmwiU7S9OPbQFdhRr
         p4R9COdKBGS15X0SJI/WnDgYyc4VNb5DE+xj8bxAlu9pikgjfOHn204jPWfX/KOvRuyE
         sI3g==
X-Gm-Message-State: AOAM5321gL48E9a6hZvXc2d4iGq10IJenzvVgsQpSWRNsTsfd1po/zVE
        ZmXgWep27sr7pDb6bL+GfoIIdv9nQSrW9g==
X-Google-Smtp-Source: ABdhPJwfflV7N0a45Y2qjgerJ1ZtamOtkHLz/tRZbTu+jAX6YMrvxjxAWdgXjcUraVi3elGykjPaeQ==
X-Received: by 2002:a05:6402:2790:: with SMTP id b16mr14001180ede.24.1637095877917;
        Tue, 16 Nov 2021 12:51:17 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x15sm6044134edq.65.2021.11.16.12.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 12:51:17 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mn5QD-001gki-3F;
        Tue, 16 Nov 2021 21:51:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] Generate temporary files using a CSPRNG
Date:   Tue, 16 Nov 2021 21:35:59 +0100
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
Message-ID: <211116.864k8bq0xm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 16 2021, brian m. carlson wrote:

> Currently, when we generate a temporary file name, we use the seconds,
> microseconds, and the PID to generate a unique value.  The resulting
> value, while changing frequently, is actually predictable and on some
> systems, it may be possible to cause a DoS by creating all potential
> temporary files when the temporary file is being created in TMPDIR.
>
> The solution to this is to use the system CSPRNG to generate the
> temporary file name.  This is the approach taken by FreeBSD, NetBSD, and
> OpenBSD, and glibc also recently switched to this approach from an
> approach that resembled ours in many ways.
>
> Even if this is not practically exploitable on many systems, it seems
> prudent to be at least as careful about temporary file generation as
> libc is.
>    
> This issue was mentioned on the security list and it was decided that
> this was not sensitive enough to warrant a coordinated disclosure, a
> sentiment with which I agree.  This is difficult to exploit on most
> systems, but I think it's still worth fixing.

I skimmed that report on the security list, and having skimmed this
patch series I think what's missing is something like this summary of
yours there (which I hope you don't mind me quoting):

    Now, in Git's case, I don't think our security model allows untrusted
    users to write directly into the repository, so I don't think this
    constitutes a vulnerability there.  We have a function that uses TMPDIR,
    which appears to be used for prepping temporary blobs in diffs and in
    GnuPG verification, which is definitely more questionable.

I tried testing this codepath real quick now with:
    
    diff --git a/wrapper.c b/wrapper.c
    index 36e12119d76..2f3755886fb 100644
    --- a/wrapper.c
    +++ b/wrapper.c
    @@ -497,6 +497,7 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
                            v /= num_letters;
                    }
     
    +               BUG("%s", pattern);
                    fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
                    if (fd >= 0)
                            return fd;
    
And then doing:

    grep BUG test-results/*.out

And the resulting output is all of the form:

    .git/objects/9f/tmp_obj_FOzEcZ
    .git/objects/pack/tmp_pack_fJC0RI

And a couple of:

    .git/info/refs_Lctaew

I.e. these are all cases where we're creating in-repo tempfiles, we're
not racing someone in /tmp/ for these, except perhaps in some cases I've
missed (but you allude to) where we presumably should just move those
into .git/tmp/, at least by default.

Doesn't that entirely solve this security problem going forward? If a
hostile actor can write into your .git/ they don't need to screw with
you in this way, they can just write executable aliases, or the same in
.git/hook/.

Unless that is we do have some use-case for potentially racing others in
/tmp/, but then we could make that specifically configurable etc.

I really don't mind us having a better tempfile() function principle,
but so far this sort of hardening just seems entirely unnecessary to me.

As seen from your implementation requires us top dip our toes into
seeding random data, which I'd think from a security maintenance
perspective we'd be much better offloading to the OS going forward if at
all possible.

If there are cases where we actually need this hardening because we're
writing in a shared /tmp/ and not .git/, then surely we're better having
those API users call a differently named function, or to move those
users to using a .git/tmp/ unless they configure things otherwise?
