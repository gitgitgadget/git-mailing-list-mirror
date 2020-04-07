Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E60C2BA2B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2572206F7
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/iy9DNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgDGOQF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:16:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41296 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbgDGOQF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:16:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id m13so1787022pgd.8
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 07:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v3egR05qPuNY0s3KwBfqKCT8967630ZxhszthKj+J48=;
        b=l/iy9DNnkgg6IxZsE86u3afsQxrlU1mWz1hvyazOsdA6mxDs0cI8ZuT+L4fCJg2t1A
         S3hLvT/D43oievy/jRH4Y1c4so8uc4PfIERBmhMkjMJ2qWSkdQq+IGOzODNyUgSntb7X
         ZSmEor4oSjDISJ0WISiSNA4yjPbQWa77wUOCdF0aazUPSQEdrnjvSuDJW4JjfkqU8IKA
         Tp0ux1NlROBEZLA3M005R11I0wP7IPT/aJHPzNgM8fVXF9ifXM/Wn/72ajck0jAoNOEu
         gyONJNDmLGmJuqMn0uwZb1fUGL8B2NAXq6R/3ztZEwZfbpS1rl55++x+Egxme0uf0yON
         HHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v3egR05qPuNY0s3KwBfqKCT8967630ZxhszthKj+J48=;
        b=Ug6qEQWMTvZZofUDLziHdKyJJVNql7wvhX+K7xBD2nAjfwHTRwVUYVoO2Xg5lz1LOM
         hbdrrxZAOHfmWVUtYn17laNB2LRjugGPZieB72NIJ9svQE6rd3gytLxERRaxJRaJqXVE
         +QnM8ydX+mi+H1hqVRU5mmqeRc6LfdFtrcdhGmf0rkkkfoXsmXaZbs0WjOeK24jtyFt5
         Rw79Yk5JSsU9d/2sW/umqa8FYakkqHAOTUCrx/TVo0PS1kx+xRacSqI41pL19/pFgDHA
         XKxa/oJqOTVj3FY/Y956fg0FROOJxh7Kmey/Xa/MSzKEC7uC9H/CHXxXtNzry7oDPAZd
         3UOA==
X-Gm-Message-State: AGi0PuY//ZoiFXVUeKnwVxcJaF1U6ZUEAGz0bnwSS8o0kzO6sXDOM2bA
        PhdNBRrKOOGhL3j5AXialHfNG/KUnyk=
X-Google-Smtp-Source: APiQypKSr1/FT5rFf6PXYGpl8HcfditVGrRasjwuwSSeB7h6VrBCTK5xZ6gp4BxaqQRoi9ESJNSWzA==
X-Received: by 2002:a63:dd0a:: with SMTP id t10mr2224366pgg.229.1586268963869;
        Tue, 07 Apr 2020 07:16:03 -0700 (PDT)
Received: from localhost ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id v4sm14167717pfb.31.2020.04.07.07.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:16:02 -0700 (PDT)
Date:   Tue, 7 Apr 2020 21:16:00 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 01/15] run-job: create barebones builtin
Message-ID: <20200407141600.GA1963@danh.dev>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
 <665da239774419074a9bae49b9c92b340885bfa3.1585946894.git.gitgitgadget@gmail.com>
 <fc5e6823-ebb3-df58-d7fc-6fb2b58cffe8@gmail.com>
 <xmqqimidybzu.fsf@gitster.c.googlers.com>
 <208bdbc7-9c8e-5105-0627-7db86135db7b@gmail.com>
 <20200407005828.GC2568@danh.dev>
 <806dc7e9-9980-2c05-461f-9f3a62598244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <806dc7e9-9980-2c05-461f-9f3a62598244@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-07 06:54:33-0400, Derrick Stolee <stolee@gmail.com> wrote:
> On 4/6/2020 8:58 PM, Danh Doan wrote:
> > On 2020-04-06 10:42:23-0400, Derrick Stolee <stolee@gmail.com> wrote:
> >> Of course, not every platform has "cron" but that just means we need a
> >> cross-platform way to launch Git processes on some schedule. That could
> >> be a command that creates a cron job on platforms that have it, and on
> > 
> > There's Unix system that doesn't have cron.
> > People could use other scheduler mechanism.
> > 
> > A lot of systemd users uses systemd-timer.
> > I'm using snooze.
> 
> Thanks for listing some alternatives. I'll look into these.

I didn't mean to list those alternatives as only possible
alternatives.

The point is people have their own preference to choose a scheduler
that suites their need.

Someone could use their own supervisor system with things like:

	#/bin/sh

	sleep 3600 # 1 hour
	exec git cmd

When "git cmd" exit, the supervisor will start the job again (because
it's down and it needs to be run).

> > Each of those set of utilities have different grammar and
> > configuration.
> > 
> >> Windows it could create a scheduled task instead.
> 
> >> 2. "run-on-repos" uses command-line arguments or config to launch "git
> >>    -C <dir> maintenance run" for all configured directories. The
> >>    intention is that this is launched on some schedule by a platform-
> >>    specific scheduling mechanism (i.e. cron).
> > 
> > So, IIUC, Git will have a _hard_ dependencies on cron on *nix?
> > Else, we're gonna received a bug-report that some tools doesn't work?
> 
> No. Such a dependency would be unacceptable. I'm just using cron
> as an example when available.

That will be too many possible solutions out there,
I'm still not convinced on adding a scheduler to Git.

> > I've seen some bug report in our distro that "git add -p" doesn't work
> > like documented, because it's in "git-perl" packages.
> > When we merge "git-perl" back to git, other people (who never use
> > "git add -p" and git-sendemail) complain why does we add a hard dependencies
> > on perl to git.
> 
> Good news: "git add -p" is becoming a builtin with a lot of work by
> some determined contributors.

Yeah, I knew it. t3701.{44,46} is also fixed with the builtin.
But, it will be some version into the future to be enabled by default.

The point is there're people that don't want to see a new hard
dependencies for Git.

-- 
Danh
