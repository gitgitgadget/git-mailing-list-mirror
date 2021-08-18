Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43C5C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 20:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5BB360FBF
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 20:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhHRUwp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 16:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhHRUwm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 16:52:42 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9451FC061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 13:52:07 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id y190so3423436pfg.7
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 13:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5ADQNqIuCkMyzrxQMMOxIBxinTCf+R/NhC6VYaPDDaY=;
        b=qdkyCJgBBQo+qT9xD+CZaiJVpJFDr5gFJLTGLFq2fS+8bdLfDL+q7dhtXFJq8Yb7Vs
         pLEoFAhLaNLf3HNjtBGbioiPYjGj5XrYsQlITXz8gAWlgrFirRnPumoDhg33XL+rTtMB
         xBjpbRhHXtbH3ZgsR6M96nuzCc17CrE9IcdQXAFlWZz4XrCgQVjWUhp5FO0NXNUt2qpn
         t+hZsdgzHcB/vmcdIg+OEA/jWfP4CN06QXah7iqhXg/+FUuCQnbNSHP1Q9m385ZUByY2
         Dm9+mhhgiL78vr5hWJZrAWiIVatHMdDqd7onyVKMitHP+4grvTN9zHuBsSRtRNdbK+J+
         ngNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5ADQNqIuCkMyzrxQMMOxIBxinTCf+R/NhC6VYaPDDaY=;
        b=W2w2QQcUxmNvqQCJKfehTOLZtIYAKDFIrxM+KxZFg3sV0GrIjB2YCrf3ZwqIxjGUrS
         939i/yz0Y4DwczGSXSO+XT3cJP8vS4JoWnNlCYF0cg40eg1lgLOE8f4Oa8/gb7oqRSyN
         bzsRRW49uZOlmq2kU0RPU9WHRhXKT9fnyzJk1d3TyU2VhIDvPm20goPvRLHhiuomNxyk
         2xNqmpu7EaQKJaXJTqwlKUZDuZG53eZMf0SPp4yh/scKHFl8uiVk7WP9i2eTApN6nf8U
         pX/A2nO3B6CQ0gSVSI8twgfwSbePo4HKN4sM4qGdyRU+w9txtM75mArdWr/HwIKUEycK
         RWmg==
X-Gm-Message-State: AOAM533Szc/5PQXY6R8PCvwkTMzTESHHJzhf0LOdXU2CfslrXRskXxcp
        +45lgm3VNSgIvHZP5l5eYsMtug==
X-Google-Smtp-Source: ABdhPJwvOZHxxMzO/3Wkci+oGUjTd7wHKT706PQVqdNqCDXLN9OMquN7HiDOTE+d0Wy8GZdj7oSLkw==
X-Received: by 2002:a65:5a0d:: with SMTP id y13mr10621120pgs.22.1629319926749;
        Wed, 18 Aug 2021 13:52:06 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a999:9b6d:55c3:b66c])
        by smtp.gmail.com with ESMTPSA id t38sm699546pfg.207.2021.08.18.13.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 13:52:06 -0700 (PDT)
Date:   Wed, 18 Aug 2021 13:51:58 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 4/6] hook: allow running non-native hooks
Message-ID: <YR1y7jxhGmnTJKyH@google.com>
References: <20210812004258.74318-1-emilyshaffer@google.com>
 <20210812004258.74318-5-emilyshaffer@google.com>
 <xmqqy29632hx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy29632hx.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 12, 2021 at 12:08:10PM -0700, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > diff --git a/builtin/hook.c b/builtin/hook.c
> > index c36b05376c..3aa65dd791 100644
> > --- a/builtin/hook.c
> > +++ b/builtin/hook.c
> > @@ -46,7 +46,7 @@ static int list(int argc, const char **argv, const char *prefix)
> >  
> >  	hookname = argv[0];
> >  
> > -	head = hook_list(hookname);
> > +	head = hook_list(hookname, 1);
> >  
> >  	if (list_empty(head)) {
> >  		printf(_("no commands configured for hook '%s'\n"),
> > @@ -108,7 +108,7 @@ static int run(int argc, const char **argv, const char *prefix)
> >  	git_config(git_default_config, NULL);
> >  
> >  	hook_name = argv[0];
> > -	hooks = hook_list(hook_name);
> > +	hooks = hook_list(hook_name, 1);
> >  	if (list_empty(hooks)) {
> >  		/* ... act like run_hooks_oneshot() under --ignore-missing */
> >  		if (ignore_missing)
> 
> This is minor, as I expect that the callers of hook_list() will
> always confined in builtin/hook.c, but it probably is easier to read
> if you gave two functions, just like you have the pair of helpers
> find_hook() and find_hook_gently(), as the literal "1" forces the
> readers to remember if that means "die if not found", or "ok if it
> is a bogus name".

Yes, I see what you mean. Ok. I have been wanting to change the naming
anyways - most functions in hook.h are verb-y ("find hook", "run hooks",
so on) but hook_list stands out as the only noun-y function.

So I considered changing it to "list_hooks" and "list_hooks_gently", to align
with find_hook(_gently)....

> 
> In addition, it may make more sense to keep hook_list() signal
> failure by returning NULL and leave the dying to the caller.
> In-code callers (as opposed to "git hook run" that can throw any
> random string that came from the user at the API) will never throw a
> bogus name unless there is a bug, and they'll have to check for an
> error return from hook_list() anyway and the error message they
> would give may have to be different from the one that is given
> against a hook name randomly thrown at us by the user.

Sure, that makes sense enough... but then I wonder if it would be better
to let the caller check whether the name is allowed at all, first,
separately from the hook_list() call.

On the one hand, having hook_list() do the validation of the hook name
makes it harder for a hook doing something very unusual to neglect to
add documentation. (I'm thinking of, for example, a hook doing something
equally weird to the proc-receive hook, which cannot use the hook
library because it needs to be able to do this weird two-way
communication thing.
(https://lore.kernel.org/git/20210527000856.695702-31-emilyshaffer%40google.com))
It would be pretty bad for a hook which is already complicated to also
forget to include documentation.

On the other hand, as it is now - builtin/hook.c hardcodes "I don't care
if the hook is unknown" and hook.c hardcodes "reject if the hook is
unknown" and nobody else calls hook_list at all - it isn't so bad to
bail early, before even calling hook_list() in the first place, if the
hook is unknown.

I also think that approach would make a callsite easier to understand
than checking for null from hook_list().

  const char *hookname = "my-new-hook";

  /* Here it's pretty clear what the reason for the error was... */
  if (!known_hook(hookname))
    BUG("is hook '%s' in Documentation/githooks.txt?", hookname);

  hooks = hook_list(hookname);
  ...

vs.

  const char *hookname = "my-new-hook";
  hooks = hook_list(hookname);
  /*
   * But here, I have to go and look at the hook_list() source to
   * understand why null 'hooks' means I missed some doc step.
   */
  if (!hookname)
    BUG("is hook '%s' in Documentation/githooks.txt?", hookname);
  ...

Maybe others disagree with me, but I would guess the first example is
more easily understandable to someone unfamiliar with the hook code. So
I think I will go with that approach, and include some notice in the doc
comment over hook_list().

 - Emily
