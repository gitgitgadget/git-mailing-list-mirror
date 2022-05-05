Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0015CC433EF
	for <git@archiver.kernel.org>; Thu,  5 May 2022 19:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385486AbiEEUBz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 16:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385484AbiEEUBx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 16:01:53 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6235E76D
        for <git@vger.kernel.org>; Thu,  5 May 2022 12:58:12 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id x18so5382094plg.6
        for <git@vger.kernel.org>; Thu, 05 May 2022 12:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=EY8yB2KrxStwdTQAW19iAoeo+kagmcKmhiQTgqz8DXA=;
        b=bb3jSWtiDgLrnxK3BRHHa9x7P48tF9Uw6RkAFDiCO4O5PNBqodCZc2lglV2KnB1C/c
         FMvY6OfBUAkZ+VqXjYTSSH6IrqbEmSta4hTfAxOwN5QrfylexmroLc1F4VoJv27i3Op3
         5rg2gx8WPKhgoe4QHzpZfJgwdS/6Wa6KxwpQPDQxrd43sRMUeIUVOM0UuR3LseBZRROS
         fEu2ATLb7fLFUV9stsk79JJeK1dLqBTXrWrYVopVc7ty6tzFSwEg2xoJCKYHuyWkTIIw
         i/GS6xV1p/sneXHFe1/CNF7l62XTdtmzRSY3siJVTcztkpPe2kydaVw0zqd1X+4HIuRx
         M24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=EY8yB2KrxStwdTQAW19iAoeo+kagmcKmhiQTgqz8DXA=;
        b=W9cYci9nsFrJpXRx8Ahw9ckwon3ntzsh5+YNw+FEGAsG5ZMSxNfiQahFGf9xdG5loo
         RHxh/iXG1V7rnLZnH3IE17yTUn+aTwXJdtBQrjEB0xWz7HOpaozTSJDcPeJ65HdjivW9
         08rxOoFqE3ox2jLCDsI5HR9Bqj5NJCvrG0febp7qq2KXiRbqfJ/tQphQM8B+2O7UYSs6
         akRWBysmO0VvVXscDNLM2ucBrnBvMOjCN7f9i0rVDG+D6dqmAbqlGA2hDssEnM6wlVuj
         OauhC0H1uNinSgaB2YB7eUG2xYYMghfF/3zEIsXeayZPyrInkzTIO4cohQSixylNENYX
         L1uA==
X-Gm-Message-State: AOAM531yP0eFdMmNtEbCF1ff46lb1OyHLbv2DMniGUuMf1dBhPFa48ok
        Hg2OCguQfwvnEC8tpjnMbp80kYlVNwt3Ww==
X-Google-Smtp-Source: ABdhPJyslK+qyx1rrp8pRRv4l2NJzTsnOVFFmqNYUUkKJH5dgzmVPY69u/BTcpcNQPVxZJn3mUsGlQ==
X-Received: by 2002:a17:902:e94e:b0:15b:22a7:f593 with SMTP id b14-20020a170902e94e00b0015b22a7f593mr29151529pll.148.1651780692209;
        Thu, 05 May 2022 12:58:12 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:faab:4bc4:f0f5:44a6])
        by smtp.gmail.com with ESMTPSA id s189-20020a625ec6000000b0050dc7628168sm1772336pfb.66.2022.05.05.12.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 12:58:11 -0700 (PDT)
Date:   Thu, 5 May 2022 12:58:05 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] run-command: don't spam trace2_child_exit()
Message-ID: <YnQsTckTqRaKLABM@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <4616d09ffa632bd2c9e308a713c4bdf2a1328c3c.1651179450.git.steadmon@google.com>
 <xmqqr15gev94.fsf@gitster.g>
 <75f62c9e-e083-d333-6339-2d12e0788400@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75f62c9e-e083-d333-6339-2d12e0788400@jeffhostetler.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.05.03 10:59, Jeff Hostetler wrote:
> 
> 
> On 4/28/22 5:46 PM, Junio C Hamano wrote:
> > Josh Steadmon <steadmon@google.com> writes:
> > 
> > > In rare cases, wait_or_whine() cannot determine a child process's exit
> > > status (and will return -1 in this case). This can cause Git to issue
> > > trace2 child_exit events despite the fact that the child is still
> > > running.
> 
> I'm curious what is causing the spurious return values.
> Could you instrument wait_or_whine() and see which of the
> if/else arms are causing the -1 to be returned?
> 
> That routine is rather complicated and looks like it has 3
> different ways that a -1 could be returned.

Unfortunately we haven't been able to reproduce the issue, so
instrumentation won't clarify the cause unless we randomly hit another
instance.


> > 
> > Rather, we do not even know if the child is still running when it
> > happens, right?  It is curious what "rare cases" makes the symptom
> > appear.  Do we know?
> > 
> > The patch looks OK from the "we do not know the child exited in this
> > case, so we shouldn't be reporting the child exit" point of view, of
> > course.  Having one event that started a child in the log and then
> > having millions of events that reports the exit of the (same) child
> > is way too broken.  With this change, we remove these phoney exit
> > events from the log.
> > 
> > Do we know, for such a child process that caused these millions
> > phoney exit events, we got a real exit event at the end?  Otherwise,
> > we'd still have a similar problem in the opposite direction, i.e. a
> > child has a start event recorded, many exit event discarded but the
> > log lacks the true exit event for the child, implying that the child
> > is still running because we failed to log its exit?
> > 
> > >   int finish_command_in_signal(struct child_process *cmd)
> > >   {
> > >   	int ret = wait_or_whine(cmd->pid, cmd->args.v[0], 1);
> > > -	trace2_child_exit(cmd, ret);
> > > +	if (ret != -1)
> > > +		trace2_child_exit(cmd, ret);
> > >   	return ret;
> > >   }
> 
> Since this is only called from pager.c and is used to setup the
> pager, I have to wonder if you're only getting these spurious events
> for the pager process or for any of the other random child processes.
> 
> And whether they are received while the pager is alive and working
> properly, or when you're trying to quit the pager or when the pager
> is trying to signal eof.

It was for a pager run by `git diff`. The only other child process in
this instance was `git status`. I believe the events were generated
while the user was not interacting with the process; IIRC the pager was
left running in a terminal overnight and they discovered the next
morning that their disk was filled up by trace logs.
