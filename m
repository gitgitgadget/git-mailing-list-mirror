Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BA2C433DB
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 18:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6DA764EE6
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 18:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhCJSYa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 13:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbhCJSY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 13:24:27 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E410C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 10:24:27 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d23so5684686plq.2
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 10:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oFkoLsFKFC0y6pkOYTU496+hsfJJgt+u/469MZiwL+k=;
        b=ag5v64sy8LtxdATC1kYMisZ2NjAxyjcQCbxMyEikOhfnSZ54wQw+6xiHUXRaJL9kTI
         aFHfHxktJDSwKO6vd2KCY7hSt0dkUhtef0h6z/wC6jk8T5z6XekvkDBQ2vMO0cbseCxL
         FSQDu78rL6BHlb63zkZHS3riYtIBn4Gw7/CT/ol3ZSZ35wWA67Tw4jD5I8VVOoeMpNg+
         uQj2a430B1en4vb57Dh61xI6a4q3Ar8IcmQBBfha/Wj+oHNXRmmpsEggGAEHzut7pNZC
         H6jnt2QHYX3gXOJF2mxQgkkBl6ZFFMAbrf8tvZbzq41jFmptfp88abwEah49rhyPsHle
         +LVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oFkoLsFKFC0y6pkOYTU496+hsfJJgt+u/469MZiwL+k=;
        b=AhCNM6XBsK0zOKFmOSb/03+ZcYUAS0PVHO7zOJcdfCadFiYyS8sTHASkEFHT5zYJ6E
         4xdKlnYpQ+sOmIcm/84Cf4U2YPeeGVjgqv3Zb1K6IoiuHCKItJQHULz5ycnvHvTgLH7r
         37CPWtrdR1mMQJnu0wpmrPRyWWvd9vFf09oRgo4krNbdbUWYsWBV+3oLLAWQX2dXECxa
         uGOV0NoWLpdCNVxax1CgNLYII2ezcUr7gIgeAjLtvzqgyGdhr5JLZEpYmQJjVPrYqGe+
         VcX9Gd0PVblfPIsjX/B8ZMOCIY6ovEFFQIXDnp9QdHFkuTdRUcVwco4wt4AQ7jef55GG
         RQNg==
X-Gm-Message-State: AOAM5318WLHhVL0kM5DX6ARR5b6OlmFO/y1lrFc1lh0/1oMPWJJ5rxqZ
        92Le+P/zbcntzMMj6enfPE32dA==
X-Google-Smtp-Source: ABdhPJzLimyh3Dst89eyReHseUvd/UnQqQG1R8XE1sCyaDbRev7dqjOALBYcd6FIK7xZ/9HSaoxEGw==
X-Received: by 2002:a17:90a:f986:: with SMTP id cq6mr4852380pjb.175.1615400666588;
        Wed, 10 Mar 2021 10:24:26 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
        by smtp.gmail.com with ESMTPSA id l3sm201249pfc.81.2021.03.10.10.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 10:24:25 -0800 (PST)
Date:   Wed, 10 Mar 2021 10:24:20 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 14/17] run-command: add stdin callback for
 parallelization
Message-ID: <YEkO1CGw0nD7/69w@google.com>
References: <YDRAbcqtWRpVn703@google.com>
 <20210223193324.1660502-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223193324.1660502-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 11:33:24AM -0800, Jonathan Tan wrote:
> 
> > > > +/**
> > > > + * This callback is called repeatedly on every child process who requests
> > > > + * start_command() to create a pipe by setting child_process.in < 0.
> > > > + *
> > > > + * pp_cb is the callback cookie as passed into run_processes_parallel, and
> > > > + * pp_task_cb is the callback cookie as passed into get_next_task_fn.
> > > > + * The contents of 'send' will be read into the pipe and passed to the pipe.
> > > > + *
> > > > + * Return nonzero to close the pipe.
> > > > + */
> > > > +typedef int (*feed_pipe_fn)(struct strbuf *pipe,
> > > > +			    void *pp_cb,
> > > > +			    void *pp_task_cb);
> > > > +
> > > 
> > > As you mention above in the commit message, I think the clearest API to
> > > support what we need is to just have a callback (that has access to
> > > child_process) that is executed between process start and finish.
> > > 
> > > As it is, I think this callback is too specific in that it takes a
> > > struct strbuf. I think that this struct strbuf will just end up being
> > > unnecessary copying much of the time, when the user could have just
> > > written to the fd directly.
> > 
> > Since the rest of the run_processes_parallel() API passes strings around
> > with strbufs, I'd prefer to leave it as-is to match the general API
> > expectations and style.
> > 
> >  - Emily
> 
> By the rest of the run_processes_parallel() API, do you mean
> get_next_task_fn, start_failure_fn, and task_finished_fn? If yes, I
> think that it makes sense for them to be strbuf, because buffering is
> needed to avoid outputs from individual child processes interleaving,
> but that's not true here.
> 
> Having said that, this is an internal API so we could just leave it
> as-is and then refactor it if we ever need something more flexible.

Yeah, with that in mind I'll leave it as it is. I don't like the idea of
directly exposing the child's pipe via callback; to me it feels like bad
object-oriented design, but that maybe doesn't apply here :)

Anyway, like you say, we can change it later if someone doesn't like
this, no problem.
