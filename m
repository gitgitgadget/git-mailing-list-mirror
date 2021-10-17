Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FA3C433F5
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 04:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71999610E8
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 04:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244965AbhJQEhW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Oct 2021 00:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbhJQEhT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Oct 2021 00:37:19 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F034C061765
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 21:35:10 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id v8so7872355pfu.11
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 21:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Vm/DZuJk2mJK9ypJq0kf8uj72TTQhdh7ydL3OT8bOs=;
        b=U9SVlZOfUxnDuJrzkbhqaDYsxkjNl56MfgcV6BHhtnE1fsPWn7r4c3MTAOHSHY2ggR
         Q/FWUJ44J7jyOBt+f0y0n5vZmtETpF13AVmXS9so69HqVOqGeR4LdaAQfI+fnmmZIyno
         EgxHJYyHhoUgPVLo7AK4xFMpk+F1GBAR4bG8WxtWIJZwbp/c1Wgz5fhy/jYLzVX8jGQX
         H5yYon4tLQIRLfZQ4u6AYt/Ie/zDvIC7TK+r/IuyRTidSTxsj7D5EnEHKeW76yifZEve
         cXA0av9Y9sBhaIaI0r0letBI645SwHFoqDolU90A7V62aY61R1IzXF3GajO8EISwJpwZ
         Wncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=0Vm/DZuJk2mJK9ypJq0kf8uj72TTQhdh7ydL3OT8bOs=;
        b=vCXsTqrENtjThWSs+ZeuWa0Pg7xVFTAwvzXLojOR18KdH5nfaeR+6xRR8VlFp5hLII
         S19kzmbX76eWB5ysdRmpco51Z7ZmKIjFnqcRHBRmssLoOUEDZ3cZ5o07RegdRCVaoCHt
         o+9ABlefnHjxkMjfEYtyituijC7NodMK363yQM4KvBFr3NcGwHZ0UXNU4dqYo9uoGgDf
         pNbZSJdgPT+MvRczCnLrSQDJj38FEBcyaQOISbdirv1tP6azGXkCZUjBSYyBVs9QXLh8
         E2A68OQI0/4IPkUuz4g4wCCvsHh3m+ZjZny/NUxPpMbPXnfWkhJUlw49h7t5DJfjx6Xf
         37KA==
X-Gm-Message-State: AOAM532JusdEW2lJawOvxLGZp3rSoeuhPn7AbETpl+x8RpWkszIVnKxz
        FsG8oSth1dtW6b3k10dgkVZiUQ==
X-Google-Smtp-Source: ABdhPJwCtY6gTCKMplzrZOW4kDIOE2m+cBE9YFuEPOPG4VvfmWQu4amc8PzGHIEdH1BotK5ZJB/ovg==
X-Received: by 2002:a05:6a00:1a8e:b0:44c:f3cb:2a77 with SMTP id e14-20020a056a001a8e00b0044cf3cb2a77mr20825113pfv.53.1634445309627;
        Sat, 16 Oct 2021 21:35:09 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:553d:e281:cf74:8cfc])
        by smtp.gmail.com with ESMTPSA id r14sm8514686pgf.49.2021.10.16.21.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 21:35:08 -0700 (PDT)
Date:   Sat, 16 Oct 2021 21:35:02 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] branch: add "inherit" option for branch.autoSetupMerge
Message-ID: <YWun9j7L5uNlVHkW@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <0346f447548cfd11307173aaa3284d86a2ef689c.1631319742.git.steadmon@google.com>
 <xmqqwnnondba.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwnnondba.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.09.10 17:52, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > It can be helpful when creating a new branch to use the existing
> > tracking configuration from the branch point. However, there is
> > currently not a method to automatically do so.
> >
> > Teach branch.autoSetupMerge a new "inherit" option. When this is set,
> > creating a new branch will cause the tracking configuration to default
> > to the configuration of the branch point, if set.
> 
> So, when a new branch N is forked from an existing branch A that
> builds on branch B (which could be a local branch under refs/heads/
> or a remote-tracking branch under refs/remotes/), a plain-vanilla
> auto-setup-merge makes N build on A but with 'inherit', N is marked
> to build on B instead?
> 
> I do not think it is wise to hide this useful feature behind a
> configuration variable.  
> 
> Rather, this should be made available first to users who do not even
> set the configuration and then as a convenience measure, made usable
> via the configuration mechanism as well.
> 
> The current "git branch --track N A" makes N build on A, so perhaps
> "git branch --track=inherit N A" should make N build on whatever A
> builds on.  We may need to give a synonym --track=direct to the
> traditional "build on the original branch that was used to specfy
> the fork point" while doing so.
> 
> And then on top of that, we can add configuration variable handling.
> 
> Depending on the value of branch.autoSetupMerge, "git branch -b" and
> "git checkout -b" would pretend as if "--track" or "--track=inherit"
> were given, or something along that line.  The end result may be the
> same for those who only use the configuration variables, but it
> would give us some flexibility to countermand the configuration from
> the command line.  Those who set branch.autoSetupMerge to 'inherit'
> cannot say "git checkout -b N --track=direct A" to express "With
> this single invocation alone I am making N build on A, even though I
> know I usually make N build on whatever A builds on" if you give
> only the configuration variable.
> 
> Thanks.

Thanks for the feedback. I've added "--track=direct" and
"--track=inherit" flags in V3, which I'll send out shortly. I am a bit
skeptical of the value of having "--track=direct" when just "--track"
still works, but I'll leave it up to the list to decide.
