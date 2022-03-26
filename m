Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB880C433EF
	for <git@archiver.kernel.org>; Sat, 26 Mar 2022 00:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiCZAwY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 20:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiCZAwW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 20:52:22 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B987E270844
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 17:50:46 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b15so10975008edn.4
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 17:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=1ValKFT8Z4ff1YeMiRPSXYijhYeD/rgklL8ZOGUNycU=;
        b=LtJp6fNe2VI8/GMDeRc8uFbxrIKTZCwuwlv6by57wDIa58iHBVyGjFjgQO9nandvUx
         8PfJjsbQd3o9LCti4q41NW4TJHLEhX/W2OubvG7eRiTfIJNTTNiwjs38NG2p833AgZcj
         lHcNPN0UZ48mcfJTynT4j6prJhaijYRMz03JTqjrIHBnBvNjcVDpHQ9P2o2RE6+kD2jO
         OaxC4j2sDzELDEJNcv8RfxlTCuV1La3CetpLg1KPds3jylPvpCr2pb2vlfCyaLZgJ/WO
         +KprFYFkTTQDvs3BhHmGWOEf9f5UKc+O5P1aLcXCwUVHPNo1+Uu12Hq7cm8UpyJO28Wx
         L2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=1ValKFT8Z4ff1YeMiRPSXYijhYeD/rgklL8ZOGUNycU=;
        b=gJtXDZ8OrDtAkFhMLo9yaBQIJykH0fzFuV4tHeZjjpq3w/55Xe27LjrR4BcYSehAUP
         S/m18Kmcb5y8lvBZ2WudFs/2fFrU7rPNZtyHeh0ie8EF1J51czVZw+bvSF5UCQIBZPBk
         T/FRCKKEar6j3Hsqqx0i6BakZMdckE6YrGbRG9vNK8WyJM8u6QgWos/vkOX4lXumeDEa
         jaznwkFkII/RZTh33E2RcNB4WAWJv1eapLkXEEZFF88JxZGFTr1nUk6JFw7eVrOZy5hZ
         GdqYDYJ/Dx6s9IpGes+meQuuN092oNjDJy7iErh64DFa49CDNVHDVTn9usulkdSIph1F
         qj7w==
X-Gm-Message-State: AOAM530F3Dm9Y/iOgAqEogox1cbKVEWRRnVKOfXExO2pXIw+woxbJUVI
        TGDSkz/g/xzG4Row45ztZh8=
X-Google-Smtp-Source: ABdhPJxh7YrslZg4rwY3UZUJvmkR78FBsg8iPOkngfsNyhM1hvt2Xh/kbCO5gdpCpvCIg/rm7wi6IA==
X-Received: by 2002:a05:6402:4305:b0:419:2aeb:2a9b with SMTP id m5-20020a056402430500b004192aeb2a9bmr1692382edc.346.1648255845167;
        Fri, 25 Mar 2022 17:50:45 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x12-20020aa7d6cc000000b00419812ecd2csm3422349edr.74.2022.03.25.17.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 17:50:44 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nXudf-002KCZ-VK;
        Sat, 26 Mar 2022 01:50:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     rsbecker@nexbridge.com,
        'Jeff Hostetler via GitGitGadget' <gitgitgadget@gmail.com>,
        git@vger.kernel.org, 'Bagas Sanjaya' <bagasdotme@gmail.com>,
        'Eric Sunshine' <sunshine@sunshineco.com>,
        'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
        'Tao Klerks' <tao@klerks.biz>,
        'Jeff Hostetler' <jeffhost@microsoft.com>
Subject: Re: [PATCH v9 00/30] Builtin FSMonitor Part 2
Date:   Sat, 26 Mar 2022 01:48:10 +0100
References: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
 <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
 <001701d8407a$d2a29dd0$77e7d970$@nexbridge.com>
 <acfa4815-dd4a-3f35-2586-fa1ec55bca3c@jeffhostetler.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <acfa4815-dd4a-3f35-2586-fa1ec55bca3c@jeffhostetler.com>
Message-ID: <220326.86a6ddleos.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 25 2022, Jeff Hostetler wrote:

> On 3/25/22 3:02 PM, rsbecker@nexbridge.com wrote:
>> On March 25, 2022 2:03 PM, Jeff Hostetler wrote:
> [...]
>> So that we can plan for next time, would you mind giving some
>> thought to what would be required for Linux and whether it makes
>> sense to extend this. No urgency, but I would not mind participating
>> - assuming my $DAYJOB lets me. I have a backlog for git that I need
>> to get done first anyway.
>> Kind Regards,
>> Randall
>> 
>
> A Linux backend would need to:
>
> (1) stub in compat/fsmonitor/fsm-listen-linux.c (see commits
>     8/30 and 9/30 in this series).  That gives you enough for
>     the builtin/fsmonitor--daemon.c to link with your new
>     backend.
>
> (2) populate those 4 routines.
>
> (2a) __ctor() and __dtor() will be called from the main thread
>      before and after the listener thread is created.  You can
>      do anything you need there to register/deregister a watch
>      on the FS.
>
>      See inotify() and/or fanotify().  I haven't looked at those
>      routines for a while, so all I can say is google it.
>
> (2b) __stop_async() will be called by "some" thread to request
>      that the listener thread stop listening.  This is an async
>      request, so just notify the listener thread and return.
>      (There is an example of this for Unix in
>       compat/simple-ipc/ipc-unix-sockets.c)
>
> (2c) __loop() will be called (once) by the "listener" thread-proc
>      to process/service events from the FS until a shutdown event
>      is received.  This runs in the body of the "listener" thread.
>      It should probably use poll()/select()/whatever on fd's from
>      inotify()/fsnotify() *and* whatever you set up in (2b) to
>      wait for a shutdown event.
>
>      (There are examples of this wait-loop in the Windows and Mac
>      backends, but they have *very* different FS event and wait
>      models, so they might not be very helpful here.)
>
>      When you get a "batch" of one or more paths from the FS,
>      use the fsmonitor_classify_*() routines to classify or
>      discard them and then use fsmonitor_publish() to publish
>      newly changed paths to the other threads.
>
>      The core code will handle path de-dup and all locking so
>      you don't have to.
>
> It is important that you figure out how to get recursive data
> from the FS.  We want to watch the complete worktree.  Windows
> and Mac let you register the root directory of the watch and
> automatically give me events for anything under it.  IIRC,
> inotify() only gave you a single directory and you had to
> readdir() and recurse to get fd's to the subdirs.  I haven't
> looked to see if fanotify() solves that or not.  So there may
> be some fd juggling and tree walking required.  That could/should
> all be hidden inside the __ctor() and/or __loop() routines.
>
> (3) stub in compat/fsmonitor/fsm-settings-linux.c (see the
>     peers.  This is needed to link.
>
> (4) fill in any platform-specific reasons why you might want
>     to reject a worktree.  for example, when they are remote
>     (NFS/SMB might support it, but do you trust it....)
>
> (5) stub in compat/fsmonitor/fsm-health-linux.c (see
>     fsm-health-*.c in part 3).  That will give you enough
>     to link the health thread.
>
> (6) this part is probably optional (at least for now).  we
>     can use this if we want to add platform-specific things
>     like auto-shutdown after idle.  The mac version is currently
>     empty, but the Windows version needs to watch the worktree
>     root separately (because the FS watch is limited to what
>     is *within* watched directory root).
>
> That should help get you get started.
> Let me know if you have questions.

Wouldn't it be much simpler POC in this case to write "watchman
backend"?  Then we'd both get a Linux backend, and an alternate backend
for the other platforms to validate their implementation.

Some past references to that:
https://lore.kernel.org/git/871r8c73ej.fsf@evledraar.gmail.com/ &
https://lore.kernel.org/git/87h7lgfchm.fsf@evledraar.gmail.com/
