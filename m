Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2D1C43334
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 21:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350810AbiFGVGp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 17:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378605AbiFGVBh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 17:01:37 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F4520E51D
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 11:45:19 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id gd1so16415689pjb.2
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 11:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=ehukybJmazOdInbXpK+qKj8rAYtxofFPSukMIT0OkX4=;
        b=myFnQmlAobIMo2AEJca+wy5kPuRZB7kPLco0m83vWP4ugSuPbeM+R/cVxdHto58uVv
         xKy+ZmfuaZdtPyy+/S/djNqOIwIBlyhO3AQbeOufsRhvk3DQhSy7wJ9XmxNSe2hee9Gr
         YbLKMyc8zkaOgftCdaPOw2GTHzGHD/9d6yJsjC1pk4t6VnUxSqF79kn2CAYUr3jttoI5
         /Su6a7pdbtKsoOUQOziPO1QhInd/8wYIjJCXWL1LLm4ViCZ0QG6NHEmbS0FtwGYFwJQ8
         YbH8Su28M8qNQyjVRqm/NTaYDjLZ8Ps/gGlsO8QJ0f0fO33fK8fOdkEg7bBLoeHW8KSU
         XcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=ehukybJmazOdInbXpK+qKj8rAYtxofFPSukMIT0OkX4=;
        b=dH9UTa+M0oHmhClRDSVTW7i6wcqNNrwhDHVDMxXM7sufTNK063swI0Eog6wqoun19A
         0D50jJl/fqhkmW2vsbphdGP3MYdTUxAkN+SxXnzZOlrlPY6IzUkE0CSMe6arRuXAgpEE
         x7xhc56UHZX1Bd7U5rhF+Pqq5BXPgkrA4bPgRlEVJoIyTfRVZG/94EWLLLjJE9kwfePC
         9GtcJOwjeSJFrFOngm1/e54uLfm9Dh6J84EMyA233hUEnbXUMDVdhvmdZldz34m32NwR
         iQfR9oBCBzr7ixl9Kx//Vaj8blYSd83s4/0vUesRr9inIfE/3J74kvF1+Aj5AtJLpD3u
         uK+g==
X-Gm-Message-State: AOAM5302MxkI/3qzpXD2E18H4vTq0PyZsw+LZOPF4dIfS9n6W3S+zsku
        YS4QMbT56/eYlVjTh6PwwDxXwd7U8Cxc2A==
X-Google-Smtp-Source: ABdhPJzE/he7Ncpc/mFbwn7agZmvfHH98JKeBuJckf+r+XQRWCBeQYbhj0bgESdYaEDkEGwfSXN7bg==
X-Received: by 2002:a17:902:b10e:b0:161:a747:7683 with SMTP id q14-20020a170902b10e00b00161a7477683mr31363562plr.151.1654627519139;
        Tue, 07 Jun 2022 11:45:19 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:f2b8:26fd:5644:ff19])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902d14a00b0015e8d4eb1dbsm12740355plt.37.2022.06.07.11.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 11:45:17 -0700 (PDT)
Date:   Tue, 7 Jun 2022 11:45:11 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] run-command: don't spam trace2_child_exit()
Message-ID: <Yp+ctyKvKGR2aZ/s@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <4616d09ffa632bd2c9e308a713c4bdf2a1328c3c.1651179450.git.steadmon@google.com>
 <xmqqr15gev94.fsf@gitster.g>
 <75f62c9e-e083-d333-6339-2d12e0788400@jeffhostetler.com>
 <YnQsTckTqRaKLABM@google.com>
 <ef011c3d-dd4b-f982-aa66-9167bf3e6c91@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef011c3d-dd4b-f982-aa66-9167bf3e6c91@jeffhostetler.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.05.10 16:37, Jeff Hostetler wrote:
> 
> 
> On 5/5/22 3:58 PM, Josh Steadmon wrote:
> > On 2022.05.03 10:59, Jeff Hostetler wrote:
> > > 
> > > 
> > > On 4/28/22 5:46 PM, Junio C Hamano wrote:
> > > > Josh Steadmon <steadmon@google.com> writes:
> > > > 
> > > > > In rare cases, wait_or_whine() cannot determine a child process's exit
> > > > > status (and will return -1 in this case). This can cause Git to issue
> > > > > trace2 child_exit events despite the fact that the child is still
> > > > > running.
> > > 
> > > I'm curious what is causing the spurious return values.
> > > Could you instrument wait_or_whine() and see which of the
> > > if/else arms are causing the -1 to be returned?
> > > 
> > > That routine is rather complicated and looks like it has 3
> > > different ways that a -1 could be returned.
> > 
> > Unfortunately we haven't been able to reproduce the issue, so
> > instrumentation won't clarify the cause unless we randomly hit another
> > instance.
> > 
> > 
> > > > 
> > > > Rather, we do not even know if the child is still running when it
> > > > happens, right?  It is curious what "rare cases" makes the symptom
> > > > appear.  Do we know?
> > > > 
> > > > The patch looks OK from the "we do not know the child exited in this
> > > > case, so we shouldn't be reporting the child exit" point of view, of
> > > > course.  Having one event that started a child in the log and then
> > > > having millions of events that reports the exit of the (same) child
> > > > is way too broken.  With this change, we remove these phoney exit
> > > > events from the log.
> > > > 
> > > > Do we know, for such a child process that caused these millions
> > > > phoney exit events, we got a real exit event at the end?  Otherwise,
> > > > we'd still have a similar problem in the opposite direction, i.e. a
> > > > child has a start event recorded, many exit event discarded but the
> > > > log lacks the true exit event for the child, implying that the child
> > > > is still running because we failed to log its exit?
> > > > 
> > > > >    int finish_command_in_signal(struct child_process *cmd)
> > > > >    {
> > > > >    	int ret = wait_or_whine(cmd->pid, cmd->args.v[0], 1);
> > > > > -	trace2_child_exit(cmd, ret);
> > > > > +	if (ret != -1)
> > > > > +		trace2_child_exit(cmd, ret);
> > > > >    	return ret;
> > > > >    }
> > > 
> > > Since this is only called from pager.c and is used to setup the
> > > pager, I have to wonder if you're only getting these spurious events
> > > for the pager process or for any of the other random child processes.
> > > 
> > > And whether they are received while the pager is alive and working
> > > properly, or when you're trying to quit the pager or when the pager
> > > is trying to signal eof.
> > 
> > It was for a pager run by `git diff`. The only other child process in
> > this instance was `git status`. I believe the events were generated
> > while the user was not interacting with the process; IIRC the pager was
> > left running in a terminal overnight and they discovered the next
> > morning that their disk was filled up by trace logs.
> > 
> 
> This worries me that you've found a race or infinite loop here
> and the only symptom is the child exit messages.  Suppressing
> them solves the disk-fill problem, but might mean that there's
> a lurking infinite loop or something.
> 
> Can you (privately) send me the part of the log before the
> infinite loop?  And maybe the parent and child processes too?
> I'd kinda like to understand what's happening here.
> 
> Jeff

Unfortunately we no longer have the relevant logs. This incident
happened in 2020 and the logs have expired. I can share some general
details though:

The session started on a Friday when the user ran `git diff`. Presumably
the user left the pager open after they left for the weekend. On the
following Saturday we started getting ~30M child_exit events per day
until their disk filled up early Monday morning.

The process was running on a VM, and I have reason to believe that the
user's SSH connection to the VM was broken at some point on the Saturday
that the spammy events started appearing. I don't know whether or not
the user was using any sort of session manager / terminal multiplexer
such as screen or tmux. I am curious whether or not the broken SSH
connection could have created some kind of signal loop that caused the
pager to continuously trigger our wait_for_pager_signal() handler.

I don't have any useful info beyond that, sorry. Thanks for taking a
look though!
