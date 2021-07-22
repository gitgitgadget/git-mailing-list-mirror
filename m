Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551D0C4338F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 22:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 393EB60EB9
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 22:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhGVVnl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 17:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhGVVnj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 17:43:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C20C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 15:24:12 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p9so8076468pjl.3
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 15:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kgB770LPBnG3bwWjPGYGOA+5ctRh3Lcr/aTWidGVSfo=;
        b=gMYP2fTPv1awedAO9eBB3RYqDAxDMA9dR5jwL8DqZ1LP+cajqhXqaka3YLiRLsZabO
         mmxbB053OcnmK/+fPsdl4o67yFtXPcF4rlni603Hj87SmHSPUvDtw6XW1aTI88z3Wx4A
         y5skigLp5dnUkV8KLCIbZi6oSIJM0ecVZyN3v2wAp4jaC0W3/kZ8AD1I1D0zMpjOEZ4J
         sIIXks2Lu04fmHAeRZD/gEtp9R0bCzwEj0zI05HlJeJt+CKR8Bxmg2xZi8ZS2AJAKgYf
         yTBuSvriFPjB6kE8TqJI6sPPSl17tKF2hNtTcbm3oFlCJSW1ft3290G5zm0PjPcYNzKT
         Xe6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kgB770LPBnG3bwWjPGYGOA+5ctRh3Lcr/aTWidGVSfo=;
        b=AGFHv/8nVtYTf2Qco+1lPq+/EfDyG3XNeuahbL2i4tPywbhzD3tcHUZtlafX29rm6M
         rI3UreOA41KLRuYG8sgCcYrqHDKfL/+WU/H3s+fYnUkpm9Dgr8/Ju97qdBKINh5FWKcq
         LGPemX/4rhX/4Ugn9tCV57nxQDQtrCuOxdpExBUuUHN2MQjFs88gtUrJbhrUnWaxY5ni
         M1pHZLctpTEuYJMXhiX6ZiWsLf0JLn9ABm/hxwdrQrlqTsFXixx0JSG8Q4LB4PSn6o8o
         bVVljbNny8L6ebzDrCeEQCpGZK6Bh826ct3CBN3zBpR7earm8g8fnZYGjdpmKVC47C6G
         /jfg==
X-Gm-Message-State: AOAM532uvpqG1oOu6ZSosphaGHdFXTKMpVzeQVD7WbsCBQXlGR0HT3vU
        32M0VMiwbXEZPrb6owQuIn42fH6RdkCtrg==
X-Google-Smtp-Source: ABdhPJxfsTH63jzvSVieM3xa1jGtZO33iCttp9dELLwklSLkWqOyRC73pvs21pXprlCleWora9JCgw==
X-Received: by 2002:a17:90a:6a01:: with SMTP id t1mr1808686pjj.10.1626992652193;
        Thu, 22 Jul 2021 15:24:12 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:3c03:6226:e12f:afc9])
        by smtp.gmail.com with ESMTPSA id f3sm26608803pjt.19.2021.07.22.15.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 15:24:11 -0700 (PDT)
Date:   Thu, 22 Jul 2021 15:24:06 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/9] hook: treat hookdir hook specially
Message-ID: <YPnwBu4oMA9K445J@google.com>
References: <20210715232603.3415111-1-emilyshaffer@google.com>
 <20210715232603.3415111-5-emilyshaffer@google.com>
 <87lf66y6pd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lf66y6pd.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 10:58:34AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Thu, Jul 15 2021, Emily Shaffer wrote:
> 
> > Soon, we will allow users to specify hooks using the config. These
> > config-specified hooks may require different child_process options than
> > hook executables in the gitdir. So, let's differentiate between hooks
> > coming from the gitdir and hooks coming from the config.
> >
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> >  hook.c | 3 ++-
> >  hook.h | 2 ++
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/hook.c b/hook.c
> > index 19138a8290..3a588cb055 100644
> > --- a/hook.c
> > +++ b/hook.c
> > @@ -117,6 +117,7 @@ struct list_head* hook_list(const char* hookname)
> >  		struct hook *to_add = xmalloc(sizeof(*to_add));
> >  		to_add->hook_path = hook_path;
> >  		to_add->feed_pipe_cb_data = NULL;
> > +		to_add->from_hookdir = 1;
> >  		list_add_tail(&to_add->list, hook_head);
> >  	}
> >  
> > @@ -200,7 +201,7 @@ static int pick_next_hook(struct child_process *cp,
> >  	cp->dir = hook_cb->options->dir;
> >  
> >  	/* add command */
> > -	if (hook_cb->options->absolute_path)
> > +	if (run_me->from_hookdir && hook_cb->options->absolute_path)
> >  		strvec_push(&cp->args, absolute_path(run_me->hook_path));
> >  	else
> >  		strvec_push(&cp->args, run_me->hook_path);
> > diff --git a/hook.h b/hook.h
> > index 586ddf40bb..60389cd8cd 100644
> > --- a/hook.h
> > +++ b/hook.h
> > @@ -22,6 +22,8 @@ struct hook {
> >  	/* The path to the hook */
> >  	const char *hook_path;
> >  
> > +	unsigned from_hookdir : 1;
> > +
> >  	/*
> >  	 * Use this to keep state for your feed_pipe_fn if you are using
> >  	 * run_hooks_opt.feed_pipe. Otherwise, do not touch it.
> 
> The "from_hookdir" looks like it isn't used until 6/9, and maybe the
> absolute_path change too? In any case this seems like a carried-forward
> rebase of
> https://lore.kernel.org/git/20210311021037.3001235-5-emilyshaffer@google.com/
> or some version thereof.
> 
> At this point I tihnk it would be way better to squash this and other
> such changes that basically add a field to a struct that isn't used yet
> into whatever commit use/need them.

I think at this point we run into you and me having different
patch-storytelling styles - which probably is what led to the big topic
restart in the first place ;)

I'd prefer to see the "start using config too" patch stay as small as it
can; that's why I ended up with a handful of minor setup commits and
then one "and now here's config" commit.

Even if it's different from how you would tell it - is it wrong? (And if
it is, that's fine, and I'll change it, but I don't think it is - that's
why I structured the series this way.)

 - Emily
