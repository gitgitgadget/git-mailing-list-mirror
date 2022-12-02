Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79020C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 21:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbiLBVpj convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 2 Dec 2022 16:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiLBVpf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 16:45:35 -0500
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA22F1CC5
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 13:45:33 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id x11so6792992ljh.7
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 13:45:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvNFurKy6mHu8ooZ4gzYK3iPXmCtCJHBKGgb5IbTm8w=;
        b=XrGT2DckWl6Fa45BnerIw5UYZ037p8OgCrGptdqucfd1heBENqR7PGQQGjybgyLGQP
         fyJJxJKT6pCDVfTNYbRpVsSVwb7zEpeT7BnvVATjpP2MKjpWADWe4voWhmq8eRwYIiyj
         tovhTsmDb5SAjtIS6M940Nh7EILJ/iOCZu+xUyMAltAasJxShPwdsSMH/4fiZsCCdnTC
         voXjDJV1Sqj6UGPondKv5sa/kNtNUZ3Pab3IVKe90d0YArQrrTRvbJ78N09BWkYTKLgC
         an8MfXrdUPGG82dVPUxUxPqu7gJmFN7Tsge8p7vXzjh/adWjQ8J7y+GYXj+RYgIg+2eo
         xORw==
X-Gm-Message-State: ANoB5pnc8bOA10Z/xGVsZ7eXzDaHuclawL/2EeTo6hFwZqYtPYlZgiNL
        r/gpfZwNilgkaZKfNUmLGBBamMpAFdJe/pbRFe/f8A==
X-Google-Smtp-Source: AA0mqf5qbgYpiYY58EJNeqaPtuk2DgF8HjRjchQPIVjtU35vcDUhdKuv9NpFGWthd3Wnjoz84COiYTFdXe9V/F/+4ec=
X-Received: by 2002:a2e:a90b:0:b0:277:794:ae09 with SMTP id
 j11-20020a2ea90b000000b002770794ae09mr22693163ljq.286.1670017532142; Fri, 02
 Dec 2022 13:45:32 -0800 (PST)
MIME-Version: 1.0
References: <pull.1436.git.1669991072393.gitgitgadget@gmail.com>
 <221202.86o7slfzot.gmgdl@evledraar.gmail.com> <3e2bd865-3ca5-b0f7-095e-f8b97ec8822c@jeffhostetler.com>
 <221202.867cz9fwnf.gmgdl@evledraar.gmail.com> <4711d955-02b2-f599-7f89-b442dd0b6215@github.com>
 <221202.86359xfs5c.gmgdl@evledraar.gmail.com> <1b090929-f2da-f075-01d4-458804fc0717@github.com>
In-Reply-To: <1b090929-f2da-f075-01d4-458804fc0717@github.com>
From:   Stefan Sundin <git@stefansundin.com>
Date:   Fri, 2 Dec 2022 13:44:55 -0800
Message-ID: <CAMDaVWGKx3YMuzRvqGTvvcwh1y9CotFtOCpyAzm=QW3YLy5ROg@mail.gmail.com>
Subject: Re: [PATCH] fsmonitor: eliminate call to deprecated FSEventStream function
To:     Victoria Dye <vdye@github.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jeff Hostetler <jeffhostetler@github.com>,
        Eric DeCosta <edecosta@mathworks.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 2, 2022 at 6:24 AM Jeff Hostetler via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The MacOS version of the builtin FSMonitor feature uses the
> `FSEventStreamScheduleWithRunLoop()` function to drive the event loop
> and process FSEvents from the system.  This routine has now been
> deprecated by Apple.  The MacOS 13 (Ventana) compiler tool chain now
> generates a warning when compiling calls to this function.  In
> DEVELOPER=1 mode, this now causes a compile error.

Typo here, MacOS 13 is Ventura not Ventana.


On Fri, Dec 2, 2022 at 1:17 PM Victoria Dye <vdye@github.com> wrote:
> My point is that such a user for this scenario is so unlikely to exist that
> holding up this patch - which provides a real, tangible benefit to
> developers *right now* - to implement your suggestion or modify the commit
> message is, at best, an unnecessary distraction.
>
> If, somewhere, there is a user that 1) keeps up-to-date with the latest
> version of Git, 2) uses FSMonitor, and 3) is working on the sole version of
> MacOS that was theoretically compatible with FSMonitor before this change
> but now is not, we can accommodate that once such a need is shown to exist.

Looking at config.mak.uname it seems quite easy to keep git working on
old MacOS versions by adding a check like Ævar suggested.

Something like this:

--- a/config.mak.uname
+++ b/config.mak.uname
@@ -161,12 +161,15 @@ ifeq ($(uname_S),Darwin)

        # The builtin FSMonitor on MacOS builds upon Simple-IPC.  Both require
        # Unix domain sockets and PThreads.
+       # FSMonitor on Darwin requires MacOS 10.6 or later.
        ifndef NO_PTHREADS
        ifndef NO_UNIX_SOCKETS
+       ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`"
-ge 10 && echo 1),1)
        FSMONITOR_DAEMON_BACKEND = darwin
        FSMONITOR_OS_SETTINGS = darwin
        endif
        endif
+       endif

        BASIC_LDFLAGS += -framework CoreServices
 endif


Looking at that file it seems like a lot of care has gone into keeping
compatibility with older MacOS versions so in my mind it seems
appropriate to continue that legacy, especially since it is so easy.

Great work Jeff.
