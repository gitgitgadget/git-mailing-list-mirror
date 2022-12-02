Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44321C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 18:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbiLBSGR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 13:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbiLBSGP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 13:06:15 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C998E590
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 10:06:14 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id gu23so13288042ejb.10
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 10:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xLR/ozYMNsKPPGrG/HsOkia/GYbMFnQV3OqOTe6mDMI=;
        b=ktt+fVLyBQu16QSncEZLDhcenCKJCMM9sw4kZ7JOJ66yyNLveDhPI2iiF/Mj+57T5L
         W1EHaFtogIWBdxVY8ipwiwzgdH4QWRs/1hb1ytO9k4LL40JS35l2Te7/v32bXGXNaa4B
         xYPHQuLys0L6uKOs959dztgg/bv41Jetyqd9/KqaH86aI6s6ZzvR2rWuhMrF77gwAzg3
         LIAUZr0+wH526fujrKbm1osQXYFG5yA1mzT44ygToZ8QTLyw+ue+QBaPlj9GDxLRzQNY
         HGvSEgj96l4S4MMd5ZVcXB6fPxXFh/652HvVahDrQu/+8+ul2Sg+iGacf4WfMF0wKMet
         2qTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLR/ozYMNsKPPGrG/HsOkia/GYbMFnQV3OqOTe6mDMI=;
        b=SYzqcCeXo1xtdc/XLjvBbzk2P+kP/kou5F6NQlMKORrojdk8ZCCQ7bVeFYiPbb9chb
         lWvIzZrxHWkR3lRZccULwU+Lls0XSTNHP6yqYajGdVH3YFA18EVyYdBrAMgu07o9tnbe
         9fvgyjla/mhriCSkVdRrl+l+AusejqW4z8nm/lnuMmetravxH/qpgdd5O/R3DDNqToqs
         x19YxcyXPcWFLS/28Jacvgr8sS3UZ/CW/pQmz3nwL9VLOM7tepPmbWODgTEcwBkF6aDg
         6XuJnRU3Ar5nFRN/qAY7EL0cYtqYh5xz6zFia1s7cDfYv4YXXBYjuxJfNatK/fhRxjqT
         fCig==
X-Gm-Message-State: ANoB5pnRCKgmNlPiX4jCg/7KgBDOKM5eakKMuo356RIugABeenO1KbxQ
        TH3nOsdR9xcumNHo92+rVTaKRImWfmQ2dg==
X-Google-Smtp-Source: AA0mqf5m+PvMISfzqAyp5CO0BCXAeBz6yg5YT35yWJ5J9OQ+hNIwHBZJc5UpLW9VsB3e8+j/rKpG+A==
X-Received: by 2002:a17:907:365:b0:7be:a7f5:28a0 with SMTP id rs5-20020a170907036500b007bea7f528a0mr25779367ejb.421.1670004372790;
        Fri, 02 Dec 2022 10:06:12 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id op4-20020a170906bce400b0078df3b4464fsm3358734ejb.19.2022.12.02.10.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 10:06:11 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p1AQM-002nee-0L;
        Fri, 02 Dec 2022 19:06:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Stefan Sundin <git@stefansundin.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH] fsmonitor: eliminate call to deprecated FSEventStream
 function
Date:   Fri, 02 Dec 2022 19:02:13 +0100
References: <pull.1436.git.1669991072393.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1436.git.1669991072393.gitgitgadget@gmail.com>
Message-ID: <221202.86o7slfzot.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 02 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhostetler@github.com>
>
> Replace the call to `FSEventStreamScheduleWithRunLoop()` function with
> the suggested `FSEventStreamSetDispatchQueue()` function.
>
> The MacOS version of the builtin FSMonitor feature uses the
> `FSEventStreamScheduleWithRunLoop()` function to drive the event loop
> and process FSEvents from the system.  This routine has now been
> deprecated by Apple.  The MacOS 13 (Ventana) compiler tool chain now
> generates a warning when compiling calls to this function.  In
> DEVELOPER=1 mode, this now causes a compile error.
>
> The `FSEventStreamSetDispatchQueue()` function is conceptually similar
> and is the suggested replacement.  However, there are some subtle
> thread-related differences.
>
> Previously, the event stream would be processed by the
> `fsm_listen__loop()` thread while it was in the `CFRunLoopRun()`
> method.  (Conceptually, this was a blocking call on the lifetime of
> the event stream where our thread drove the event loop and individual
> events were handled by the `fsevent_callback()`.)
>
> With the change, a "dispatch queue" is created and FSEvents will be
> processed by a hidden queue-related thread (that calls the
> `fsevent_callback()` on our behalf).  Our `fsm_listen__loop()` thread
> maintains the original blocking model by waiting on a mutex/condition
> variable pair while the hidden thread does all of the work.

I just skimmed the code change and didn't see anything out of place, but
one thing that's missing about this explanation is:

Ok, it's deprecated, but when was it introduced? I.e. we now presumably
have a hard dependency on a newer API released with a newer version of
OSX?

Is it OK that we're going to throw compilation errors on older versions
that don't have it? What version is that? Is that older or newer than
our oldest supported OSX version in general, or is the plan to support
older OSX, but those users would need to compile without fsmonitor?

Depending on the answers to the above (hopefully in a re-rolled commit
message): Should we patch the bit in config.mak.uname where we do the
OSX version detection? I.e. if we're deprecating an older version anyone
still on it would be much better off with a straight-up "$(error)" from
the Makefile, rather than running into a compilation error, only to find
that we've stopped supporting that older version.
