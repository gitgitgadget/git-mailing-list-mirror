Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB97C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 00:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50D4160F58
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 00:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbhHQAiX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 20:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237247AbhHQAht (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 20:37:49 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69523C0612AB
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 17:36:31 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so1887183pjb.3
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 17:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aQ0+LPWQm84VYFZ9UJrE/JmlZeQPJDBh+trZ5MNgkFs=;
        b=M75QFZMOOsy1yPYVYHsRN0fH7/ohWSzW5PbnZ9/D4pTvlu3x3ZBJNMth1R91cEpamr
         79/aV6c9tz+6ElrDg7OfLBDKVuUlYJPrPR6hsyJepAVcI3MN68woleQlWxQaFRtKJy/9
         EjVNCahFHH1GMX/i1TyN6ItDfUtZMorgpVyXP/hkXpqcCXa5aEMfyf++U5FSCLsQjUD1
         xxvwLFYWfRrf3YnEhqLCjBUhnOR6p2e6nrSKP1czFGoJQ5GwxaJSrnDEnO7WWPgycfnt
         2woqKK61dGWMS88cipaqw2d7UKcwBJwm5Q1osHVhAOVD1eQ3gD4/32YmIYPhmM80Z1Xm
         lDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aQ0+LPWQm84VYFZ9UJrE/JmlZeQPJDBh+trZ5MNgkFs=;
        b=B2Vea65BpOCGnT2UUxJUTAT/iq0V5E/9dOjC1Z/BYG0srzNgrdIUc09ryjHMl5PRak
         6i2nyZ1qq3Cul6VRWkkS7YzUNx7BvkofFt6i1yvnbJ3lY/eSUGzkgp/NlzGMUHlRzmQd
         ayxWljw6Og9pnUTrMej8cUEmfbQszntJiwE0Z69xlnLDADCdwx/nsAX4JJtEZDfYrm8J
         UCy6YMAsWfypHjUH0DP1GZQTj+ZdQgCaMa4xLeAD3R1JTY7Xs4hMlYYUEJ+biiRW4mQ0
         gQsV9TfroeA6UmJrGojNO1uzdZGnKndWwGmlImz6Ssdkz8DmdM13zm8G8/g/HCYHQd5C
         581Q==
X-Gm-Message-State: AOAM530G4UlHYf6EpVs3BayNKV5iAcxAw8CyGuxk9RLWG2SQBlrKWnwx
        inQ8Ur34x27yk6O3pzw9unF2v5a90B89pg==
X-Google-Smtp-Source: ABdhPJxmsBON8Q9mW8rmFpOyGl81TEkO9/oRTKGTFydnAJoSOS2rUuR0IqQbwicBnPkcNBH50QNmuw==
X-Received: by 2002:a17:903:22c2:b0:12d:a7ad:aceb with SMTP id y2-20020a17090322c200b0012da7adacebmr714080plg.33.1629160590755;
        Mon, 16 Aug 2021 17:36:30 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:aa0c:5f92:878f:e03a])
        by smtp.gmail.com with ESMTPSA id a17sm318188pff.30.2021.08.16.17.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 17:36:30 -0700 (PDT)
Date:   Mon, 16 Aug 2021 17:36:22 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/6] hook: introduce "git hook list"
Message-ID: <YRsEhidmf54bdEJE@google.com>
References: <20210812004258.74318-1-emilyshaffer@google.com>
 <20210812004258.74318-4-emilyshaffer@google.com>
 <xmqq5ywa4hg8.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5ywa4hg8.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 12, 2021 at 11:59:51AM -0700, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > +static int list(int argc, const char **argv, const char *prefix)
> > +{
> > +	struct list_head *head, *pos;
> > +	const char *hookname = NULL;
> > +	struct strbuf hookdir_annotation = STRBUF_INIT;
> > +
> > +	struct option list_options[] = {
> > +		OPT_END(),
> > +	};
> > +
> > +	argc = parse_options(argc, argv, prefix, list_options,
> > +			     builtin_hook_list_usage, 0);
> > +
> > +	if (argc < 1)
> > +		usage_msg_opt(_("You must specify a hook event name to list."),
> > +			      builtin_hook_list_usage, list_options);
> > +
> > +	hookname = argv[0];
> > +
> > +	head = hook_list(hookname);
> > +
> > +	if (list_empty(head)) {
> 
> The same "can't hook_list() signal an error by returning NULL?"
> comment applies here.
> 
> 	head = hook_list(hookname);
> 	if (!head)
> 		die(_("no such hook '%s'"), hookname);
> 
> or something?
> 
> > +		printf(_("no commands configured for hook '%s'\n"),
> > +		       hookname);
> > +		return 0;
> 
> If it is a normally expected state that there is no hook for the
> given name, signalling success by returning 0 here may be sensible,
> but then the message should at least go to the standard error stream
> to leave the standard output empty, so that a caller can reasonably
> do something like
> 
> 	for path in $(git hooks list "$1")
> 	do
> 		ls -l "$path"
> 	done
> 
> If we really want to show such a message, perhaps
> 
> 	if (list_empty(head)) {
>         	if (!quiet)
> 			warning(_("no commands configured"));
> 		return 0;
> 	}
> 
> The normal display just shows the path without saying "command %s
> will run for hook %s"; the warning probably should do the same.
> 
> Having said that, if it truly is a normal and expected state that no
> hook is defined for the given name, I actually think there should be
> no message.

Ah, I think you are saying "either return an error code and be chatty if you
want, or return an empty list and a success code, but pick one". Makes
sense to me.

No message + well-defined return code sounds fine. I'll do that.

> 
> > +	}
> > +
> > +	list_for_each(pos, head) {
> > +		struct hook *item = list_entry(pos, struct hook, list);
> > +		item = list_entry(pos, struct hook, list);
> > +		if (item)
> > +			printf("%s\n", item->hook_path);
> > +	}
> 
> > diff --git a/hook.c b/hook.c
> > index 37f682c6d8..2714b63473 100644
> > --- a/hook.c
> > +++ b/hook.c
> > @@ -96,22 +96,20 @@ int hook_exists(const char *name)
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
> >  	}
> 
> I do not think this belongs to the step to add "list" command.  The
> log message does not explain or justify why have-git-dir goes away,
> either.

Ah, sure.


It seems like I also didn't update the documentation for 'git hook'
command during this commit. Will fix that as well.
