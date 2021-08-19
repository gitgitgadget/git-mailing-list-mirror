Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A026BC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 17:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78B446109F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 17:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhHSRxv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 13:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhHSRxt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 13:53:49 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB2CC061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 10:53:13 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id oc2-20020a17090b1c0200b00179e56772d6so2008259pjb.4
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 10:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HsGGfGI2ra637bgQEomMw+zxG5vR4VAitGIV5nTFuuc=;
        b=IXUXCS6ql23OPhcDOlNIKmSwr8t4YBFWJE0JTuvClsBcZAJqMYkxdKIzcnzkGmqT5M
         I7hMns3EwSyf/DpsRbj1Tww8G+DuQqyfa31BkOB+CbBXP5mzySE1Y7sChtSbFQhbM9B5
         1doJR5yXzkwO01Nn+11mBky5//bB2VuxSpgXrLacqf6tKtz3ajk3Uraq4LV0fX4SJXRL
         gIGwwwd92ompM920YBV6eFUHH4EERfke3DSB6VH1rKFJWcnpTsiIKNxb9jE8WgAgLQvF
         59zoql5uYM15Mu1lf3sVqxUq7EYoyFpcQCONEo1rH7pOmFSz3S+CX5upDNKv9Jdc6Qns
         xXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HsGGfGI2ra637bgQEomMw+zxG5vR4VAitGIV5nTFuuc=;
        b=DABRdNxxSWpQreky4g4aNP3CXHZ+FuAQMLyrI9MaNC/haaYfGzQfd6yPTaffNg/XmB
         niWNcQiJCvMRqO7kUXyliJuqxiYdosP5jtfXqzEyH7Pfdp57YvmNrpKBXCB0CobdRqlj
         ZfbEM3HMYlbb+D6zuJfSZavId1SemGLc8tIFkiZQeJt+61IRTBrwQJP9uDHZgs+pJryd
         g1L5E0zwMe82Bzph40DAeeskTa9fAfWVC/sNtivgqBv6bYKnJFhvxxfC8pHB0W7laJId
         U9LsxpLXVU1FE8yDijK8j6pwWDI3WdOYSWJM5rn5fOVauL/oWn6me4ffplTsnPzeEnCJ
         S/JA==
X-Gm-Message-State: AOAM533JX2GxE/mmpEaZUQUZJAKC6LCmgpFmHnbvuCveVsDChIr/dovJ
        zZpQlw8YovaSi5QRS8osuXdkYA==
X-Google-Smtp-Source: ABdhPJwPZ4eYMt4l2L6w8zL4sMAEaLDmmLidIAZMKL3puDQEETsBG3tJPOmlQ/BkZWec46ys3zAXQg==
X-Received: by 2002:a17:90b:2311:: with SMTP id mt17mr15819620pjb.201.1629395592612;
        Thu, 19 Aug 2021 10:53:12 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a999:9b6d:55c3:b66c])
        by smtp.gmail.com with ESMTPSA id j6sm4115994pfn.107.2021.08.19.10.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 10:53:11 -0700 (PDT)
Date:   Thu, 19 Aug 2021 10:53:04 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] introduce submodule.superprojectGitDir cache
Message-ID: <YR6agG3pwNJpCakh@google.com>
References: <20210616004508.87186-3-emilyshaffer@google.com>
 <20210727174650.2462099-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727174650.2462099-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 10:46:50AM -0700, Jonathan Tan wrote:
> 
> > Teach submodules a reference to their superproject's gitdir. This allows
> > us to A) know that we're running from a submodule, and B) have a
> > shortcut to the superproject's vitals, for example, configs.
> 
> The first sentence is probably better "Introduce a new config variable
> storing a submodule's reference to its superproject's gitdir, and teach
> 'git submodule add' to write it".
> 
> Also, I think there should be more detail about the planned use both
> here in the commit message and in the config documentation. Is the plan
> just to use it for best-effort explanatory messages? (Using it as a true
> cache is probably too performance-intensive, I would think, since in its
> absence, we have no idea whether the repo is a submodule and would
> always have to search to the root of the filesystem.) If it is just for
> best-effort explanatory messages, maybe write:
> 
>   If present, commands like "git status" in this submodule may print
>   additional information about this submodule's status with respect to
>   its superproject.
> 
> This would further reinforce that this variable being missing is OK.

Ok, I'll expand the commit message. The first use case for this extra
pointer is for a shared config between superproject and submodule, which
I've sent a series for already; I'll mention that in the commit message
too.

> 
> > diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
> > index d7a63c8c12..7c459cc19e 100644
> > --- a/Documentation/config/submodule.txt
> > +++ b/Documentation/config/submodule.txt
> > @@ -90,3 +90,15 @@ submodule.alternateErrorStrategy::
> >  	`ignore`, `info`, `die`. Default is `die`. Note that if set to `ignore`
> >  	or `info`, and if there is an error with the computed alternate, the
> >  	clone proceeds as if no alternate was specified.
> > +
> > +submodule.superprojectGitDir::
> > +	The relative path from the submodule's worktree  to the superproject's
> > +	gitdir. This config should only be present in projects which are
> > +	submodules, but is not guaranteed to be present in every submodule. It
> > +	is set automatically during submodule creation.
> > ++
> > +	In situations where more than one superproject references the same
> > +	submodule worktree, the value of this config and the behavior of
> > +	operations which use it are undefined. To reference a single project
> > +	from multiple superprojects, it is better to create a worktree of the
> > +	submodule for each superproject.
> 
> So my suggestion would be:
> 
>   The relative path from this repository's worktree to its
>   superproject's gitdir. When Git is run in a repository, it usually
>   makes no difference whether this repository is standalone or a
>   submodule, but if this configuration variable is present, commands
>   like "git status" in this submodule may print additional information
>   about this submodule's status with respect to its superproject.
> 
> (I believe Junio has commented on the second paragraph - I don't have
> additional comments on that.)

The spirit of this suggestion seems to be "describe a possible side
effect of this config", so I'll do that, although the wording may not be
exactly the same. Thanks.

 - Emily
