Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C301C4338F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 22:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE3E760EB4
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 22:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhGVViK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 17:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbhGVViJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 17:38:09 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BF8C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 15:18:44 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id pf12-20020a17090b1d8cb0290175c085e7a5so6314993pjb.0
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 15:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7bwdFnrmzQPaqBcyBXMmBq1F5g0GaZ3BZnPkL/oT7AQ=;
        b=mJLmxs7t+eRoj4vSWvArockXtg1GmqVJouW9meu5ug6h1HJRduG90a8P1YyPxZCbI6
         QZvHm5iBMuamCk+GXEiG4TXGjm8sp5CFGKmadIGa68W9/UOrNeIsLn4lxqSPOrzpuNhC
         5eKL6taTwvjRWLfz4Fm2rWjDMRUzz4N+ipQWKXNc0YLDOu13IvxTK5sL2lzkK5Fnr1Mr
         yzNWDy4vx949fZTdOyTeQC5jCelVOkqyEzwpgDaTqd4I7F+5F4ESRD2Rxywv1xR/x0K6
         DBmcdHqFY3SqsLXknWYa/qbUFd51rhmc2o514XKn9/8/0disTE4AV4j907cWhNV+2kBf
         ja5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7bwdFnrmzQPaqBcyBXMmBq1F5g0GaZ3BZnPkL/oT7AQ=;
        b=CiDQaf5Jj1VRHq2rmL3EycpSS/riHDqe+4JM7J8/c3FTjfk2y7TRCZ6Y682d8b4nVV
         l5le7LkkWrP5VNwjWwHgQFDlvD2NPPYZ0OhNLSqdfDI7x3xysjF6KSR3Bo67rvsIpqkd
         Y4WGFZfi50rg6P4yyb063zRNL7ZZ/lnULViwQvtd2qEn0kOgY976jcK7sAamBl346YoE
         mDhy4XVLKg35gG+u54oVhJQY2oy1aoRlLk0jPZXJ8HYY+eBfXTDhjGJkMfIzmr8RtLj2
         D5n4duodjtJ8X/s4I6ozdO++7EMIu3b/qUk7MhxKlkfBQcc9/JrfZESmFrpr/D1A3Qjg
         XWpg==
X-Gm-Message-State: AOAM531jxIiHPOr2Ff8N4sykGG6Jup3rjWY/ZF3xL2mJvOnmd4nEHQnj
        CMUKBP8oqUs8K1nTiBqvnvGSuj4jfYY4IA==
X-Google-Smtp-Source: ABdhPJxSLva85b+o1vinzjsdL5STOo3bd56TDYKGqxbR+Uhx0PopJkYJ6N3aDjgXAYLYKdZgnzqJkA==
X-Received: by 2002:a62:e50c:0:b029:2f9:b9b1:d44f with SMTP id n12-20020a62e50c0000b02902f9b9b1d44fmr1869495pff.42.1626992323535;
        Thu, 22 Jul 2021 15:18:43 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:3c03:6226:e12f:afc9])
        by smtp.gmail.com with ESMTPSA id b17sm28125540pfm.54.2021.07.22.15.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 15:18:42 -0700 (PDT)
Date:   Thu, 22 Jul 2021 15:18:37 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/9] hook: introduce "git hook list"
Message-ID: <YPnuvRQLzKa6h9kk@google.com>
References: <20210715232603.3415111-1-emilyshaffer@google.com>
 <20210715232603.3415111-4-emilyshaffer@google.com>
 <87o8b2y6u1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o8b2y6u1.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 10:52:27AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Thu, Jul 15 2021, Emily Shaffer wrote:
> 
> >  static const char * const builtin_hook_usage[] = {
> >  	N_("git hook <command> [...]"),
> > +	N_("git hook list <hookname>"),
> >  	N_("git hook run [<args>] <hook-name> [-- <hook-args>]"),
> >  	NULL
> 
> Uses <hook-name> already, let's use that too. I can't remember if it's
> something I changed myself, or if your original version used both and I
> picked one for consistency, or...
> 
> Anyway, I can re-roll the base topic or whatever, but let's have the end
> result use one or the other.

'hook-name' is fine, I'll use that. Thanks for pointing it out.

> 
> > +	if (argc < 1) {
> > +		usage_msg_opt(_("You must specify a hook event name to list."),
> > +			      builtin_hook_usage, list_options);
> > +	}
> 
> {} braces not needed.
ACK
> 
> 
> > +	if (!strcmp(argv[0], "list"))
> > +		return list(argc, argv, prefix);
> >  	if (!strcmp(argv[0], "run"))
> 
> This should be "else if" now.
> 
> (Doesn't matter for code execution, just IMO readability, but I'll leave
> that to you ... :)

Eh, I think it's easier to read in the strcmps line up, so I will leave
it this way ;)

> 
> >  		return run(argc, argv, prefix);
> >  	else
> > diff --git a/hook.c b/hook.c
> > index 935751fa6c..19138a8290 100644
> > --- a/hook.c
> > +++ b/hook.c
> > @@ -104,22 +104,20 @@ int hook_exists(const char *name)
> >  struct list_head* hook_list(const char* hookname)
> >  {
> >  	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
> > +	const char *hook_path = find_hook(hookname);
> > +
> >  
> >  	INIT_LIST_HEAD(hook_head);
> >  
> >  	if (!hookname)
> >  		return NULL;
> >  
> > -	if (have_git_dir()) {
> > -		const char *hook_path = find_hook(hookname);
> > -
> > -		/* Add the hook from the hookdir */
> > -		if (hook_path) {
> > -			struct hook *to_add = xmalloc(sizeof(*to_add));
> > -			to_add->hook_path = hook_path;
> > -			to_add->feed_pipe_cb_data = NULL;
> > -			list_add_tail(&to_add->list, hook_head);
> > -		}
> > +	/* Add the hook from the hookdir */
> > +	if (hook_path) {
> > +		struct hook *to_add = xmalloc(sizeof(*to_add));
> > +		to_add->hook_path = hook_path;
> > +		to_add->feed_pipe_cb_data = NULL;
> > +		list_add_tail(&to_add->list, hook_head);
> 
> Maybe we should have a INIT for "struct hook" too? This also needlessly
> leaves behind an un-free'd hook struct in a way that it wouldn't if we
> just had this on the stack, no?

I can clean it up here, but I don't think we need an initializer for
struct hook. This code chunk gets moved into one of the list
manipulators (append_or_move() or something) after the config is
introduced.

I don't think it leaves an unfreed hook laying around, does it?
list_add_tail() uses the malloc'd pointer, and we free() in
clear_hook_list(). What am I missing?

 - Emily
