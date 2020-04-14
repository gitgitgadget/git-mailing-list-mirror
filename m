Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3ACC2BB1D
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 20:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E83B20656
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 20:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E021FCKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505483AbgDNUD4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2505445AbgDNUDx (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 16:03:53 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6FCC061A10
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 13:03:53 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id z9so5669347pjd.2
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 13:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IIgeGyq+q0NKtoPutqMgRP60z0nGdYPV0O0PNa4Xjl0=;
        b=E021FCKAlk3BAJ1a8hrVsM5EyATHufen4hiMU3LV1icqJ1yOYYXQTiOsJbdI0JUFz8
         NS4zmObd5oCi4DmKBxgUY8LP0KrgXuD+jt417i14x0rJKS+q3eaI8/e9g68hzvvJZZpE
         ZbMruhK81cm3CI8s5M714ZPDV96XRW98kaIHW8+Ywga6D+lvsfmlUlUhdCniDxTCjwEX
         TvJJR0X5LduhNI8fbUr308S5xGy0/RGXjKdz9Q9MVmQDrWq9wNoQRAJ41p17ObehnKld
         22BqMo5DFYSMr3vLlVys17o+rRYi0Bemgw59OIsdh5A0gQzvV7dPVCFfK+TLedoUYpOl
         TLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=IIgeGyq+q0NKtoPutqMgRP60z0nGdYPV0O0PNa4Xjl0=;
        b=QUoRkSezgJyxK4sqaQuddUlpKcLZ3RPM5pMuOJ/aQFQueEpbVqemg+w6xZ/aaLY2Py
         iHBvFCmDK5OtzkVf6EOJUk3url3bYtRNgkGwS74pwqw/MKLkyqQyhnvbk8rob+ndaB6G
         s5nDR1sms/+p9asmoWcj4hOKCQBbaLJur/Kr5ybGkwSkxBAdrUct0o90J4149JWO5461
         WT8OaRtAAiDC022J18mDXuiLmScZqpqw+jGQ6XjRniMDZ4OfAl2L8qxotgI5OekBY6mD
         KyKLGgr5BRUHud47wY9sLEXQADASgUuOV4VA5X+0cTBqcLC2rWx9kAESHbNX2qLkULUl
         D+aw==
X-Gm-Message-State: AGi0PubSnwB6Ueo7vws+6Dj+0VmF1LBGa5n2MB/e+bHA+eCbkWMhL4Bl
        Rd3LhwoeNlVR8HNgu4jPwzo/hA==
X-Google-Smtp-Source: APiQypIlNldaumVqYUJu58aOR5MfKWtRAZN7sxkD4Dpkvpg2Jg9j2Vj1/K/7/BQY/JMKxr/pH6XWDQ==
X-Received: by 2002:a17:90b:4c45:: with SMTP id np5mr2016671pjb.19.1586894633055;
        Tue, 14 Apr 2020 13:03:53 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ece8:7fe:c1f1:a20f])
        by smtp.gmail.com with ESMTPSA id c15sm11644974pfo.139.2020.04.14.13.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:03:52 -0700 (PDT)
Date:   Tue, 14 Apr 2020 13:03:47 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>, Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH v2 0/2] configuration-based hook management
Message-ID: <20200414200347.GD12694@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        phillip.wood@dunelm.org.uk, Emily Shaffer <emilyshaffer@google.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>, Jeff King <peff@peff.net>
References: <20191210023335.49987-1-emilyshaffer@google.com>
 <20200414005457.3505-1-emilyshaffer@google.com>
 <efad3927-1d8f-5545-48e9-9a58c2308273@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efad3927-1d8f-5545-48e9-9a58c2308273@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.04.14 16:15, Phillip Wood wrote:
> Hi Emily
> 
> Thanks for working on this, having a way to manage multiple commands per
> hook without using an external framework would be really useful
> 
> On 14/04/2020 01:54, Emily Shaffer wrote:
> > Not much to look at compared to the original RFC I sent some months ago.
> > This implements Peff's suggestion of using the "hookcmd" section as a
> > layer of indirection.
> 
> I'm not really clear what the advantage of this indirection is. It seems
> unlikely to me that different hooks will share exactly the same command line
> or other options. In the 'git secrets' example earlier in this thread each
> hook needs to use a different command line. In general a command cannot tell
> which hook it is being invoked as without a flag of some kind. (In some
> cases it can use the number of arguments if that is different for each hook
> that it handles but that is not true in general)
> 
> Without the redirection one could have
>   hook.pre-commit.linter.command = my-command
>   hook.pre-commit.check-whitespace.command = 'git diff --check --cached'
> 
> and other keys can be added for ordering etc. e.g.
>   hook.pre-commit.linter.before = check-whitespace
> 
> With the indirection one needs to set
>   hook.pre-commit.command = linter
>   hook.pre-commit.check-whitespace = 'git diff --check --cached'
>   hookcmd.linter.command = my-command
>   hookcmd.linter.pre-commit-before = check-whitespace
> 
> which involves setting an extra key and checking it each time the hook is
> invoked without any benefit that I can see. I suspect which one seems more
> logical depends on how one thinks of setting hooks - I tend to think "I want
> to set a pre-commit hook" not "I want to set a git-secrets hook". If you've
> got an example where this indirection is helpful or necessary that would be
> really useful to see.
> 
> Best Wishes
> 
> Phillip

Indexing repo content (see [1] for a detailed discussion) is one use
case where you have a single command that runs identically from
post-commit, post-merge, and post-checkout.

Also, I suspect that many users don't have a firm enough grasp on the
various git hooks options to know ahead of time which ones they want to
set to accomplish a given task (without diving into the docs first). I'm
not trying to say that your workflow is incorrect, but my gut feeling is
that most Git users would work in the opposite direction. Every time I
have needed to automate something, I generally had a rough script in
place first, and then looked up which hook(s) would be appropriate
triggers for the script.


[1]: https://tbaggery.com/2011/08/08/effortless-ctags-with-git.html
