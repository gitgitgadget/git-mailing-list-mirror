Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC270C2BA1A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 00:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A3A20768
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 00:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KY02CgeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgDGA6d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:58:33 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41209 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbgDGA6d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 20:58:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id d24so569154pll.8
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 17:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wpqZaP362RTbH8Ws9oB2PiCALCS5ZL6rsOd5FIcihdM=;
        b=KY02CgeUv3V2U+/3Ek+9gtCyvo/5odfxL2LAAkxvHwalqrNEa/2pENJgyoZh4fBTqe
         Wb/tbwZMrjT5BVD8aqHbHDyVwgmdB+8HhH7BMGraxsiy4KUz2inPYrZEkBnVTRic0prX
         LJh2Dqyk/XyY2E/cW6/P5UD1wbkMbxsFR29HkEwxYjqIpXtLQ8dkVAD7IaFfoy6RE8bU
         Areo9ZdEsI6fNFpcBD6z1umihRX64UsCZaC8FvYWcjy/172zO2F0esgQSqCL6K11SC2o
         tyXoTn5efR2mrAzbT32aGFoGp9eRizdv5pzDSalmQgt+bEqGmHHSoR5gbXNuNpiRculC
         gfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wpqZaP362RTbH8Ws9oB2PiCALCS5ZL6rsOd5FIcihdM=;
        b=RQDxyziiKA+2tgymEo6UZO9nuBWJFTzDYOuQ5AvMTrxVfV2sXrsNiryo4FXLq7i3vM
         QjBp5zcLnvRglnVCXu/GFhk8PU7D0EY4p5h495wWY8ylRIXsrhJCuD4sPTCvIP8aFDcn
         3qZClbsf0Kupm5vELEdiy0ixoS1GZpOlxSpOA2811LeTKGUKAqr4DFzsl+1cGuntHGyq
         LB/CMb6S13dl/d1t52WheuhV9U1KsoDNm3r9ogiUmsNZNsWsOZwcJPfSGAItEXBaM/E7
         6DeqGpp/pK+OiLBK30rbxMIi3qGSKr7X5/YWUXdHKPtmEP58uxFmDCluPDqr4MoRKcmW
         eM8g==
X-Gm-Message-State: AGi0Pubn95+RH3abN8eEJPxOL47gPjJ5HI6xrkTCXL4wZ4DVIsiK49lp
        /FA6udc4SVR65doTIRjBI3U=
X-Google-Smtp-Source: APiQypLF1PWN7noLl29xfdnjLz6s4oy+rSRBZYEj6LCW2UjbJmkdZnHxlGwzu+QEDGRnBYONkI8+gg==
X-Received: by 2002:a17:902:5a44:: with SMTP id f4mr28236plm.306.1586221110931;
        Mon, 06 Apr 2020 17:58:30 -0700 (PDT)
Received: from localhost ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id i13sm12479089pfa.113.2020.04.06.17.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 17:58:30 -0700 (PDT)
Date:   Tue, 7 Apr 2020 07:58:28 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 01/15] run-job: create barebones builtin
Message-ID: <20200407005828.GC2568@danh.dev>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
 <665da239774419074a9bae49b9c92b340885bfa3.1585946894.git.gitgitgadget@gmail.com>
 <fc5e6823-ebb3-df58-d7fc-6fb2b58cffe8@gmail.com>
 <xmqqimidybzu.fsf@gitster.c.googlers.com>
 <208bdbc7-9c8e-5105-0627-7db86135db7b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <208bdbc7-9c8e-5105-0627-7db86135db7b@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-06 10:42:23-0400, Derrick Stolee <stolee@gmail.com> wrote:
> Of course, not every platform has "cron" but that just means we need a
> cross-platform way to launch Git processes on some schedule. That could
> be a command that creates a cron job on platforms that have it, and on

There's Unix system that doesn't have cron.
People could use other scheduler mechanism.

A lot of systemd users uses systemd-timer.
I'm using snooze.
Each of those set of utilities have different grammar and
configuration.

> Windows it could create a scheduled task instead.
> 
> But what should we launch? It should probably be a Git command that
> checks config for a list of repositories, then runs "the maintenance
> command" on each of those repos.
> 
> I'm inserting a break here to draw the eye to a new proposed design:
> 
> ---
> 
> Create a "git maintenance" builtin. This has a few subcommands:
> 
> 1. "run" will run the configured maintenance on the current repo. This
>    should become the single entry point for users to say "please clean
>    up my repo." What _exactly_ it does can be altered with config. I'll
>    list some possibilities after listing the subcommands.
> 
> 2. "run-on-repos" uses command-line arguments or config to launch "git
>    -C <dir> maintenance run" for all configured directories. The
>    intention is that this is launched on some schedule by a platform-
>    specific scheduling mechanism (i.e. cron).

So, IIUC, Git will have a _hard_ dependencies on cron on *nix?
Else, we're gonna received a bug-report that some tools doesn't work?

I've seen some bug report in our distro that "git add -p" doesn't work
like documented, because it's in "git-perl" packages.
When we merge "git-perl" back to git, other people (who never use
"git add -p" and git-sendemail) complain why does we add a hard dependencies
on perl to git.

>    (This subcommand could use a better name.)
> 
> 3. "schedule" adds the current repository to the configured list of
>    repositories for running with "run-on-repos". It will also initialize
>    the platform-specific scheduling mechanism. This may be to start the
>    schedule for the first time OR to update how frequent "run-on-repos"
>    is run, as appropriate.
> 
> 4. (OPTIONAL) "mode <mode>" adjusts the config for the current repo to
>    change the type of maintenance requested for this repo. For example,
>    "simple" could just run "git gc --auto" using a normal range.
>    "incremental" could run the maintenance tasks from this series.
>    Finally, "server" could run maintenance tasks as if we are serving
>    the repo to others, so we repack aggressively with full bitmaps, and
>    more frequently.

-- 
Danh
