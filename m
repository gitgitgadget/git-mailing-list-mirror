Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B82C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 21:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD6C3610E5
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 21:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbhHRVPL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 17:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhHRVPL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 17:15:11 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FC5C061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 14:14:36 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso9789836pjh.5
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 14:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5tHIDUsq4LL+IoBwMCzGzVl9HZ1csiUmdQYlYcAcCDM=;
        b=A7sJftSOPDJbs5vTv08qGt0LViY3E2qV+OkcWZlzti8gm7veKhwTwosM/xbJl6S+pd
         nOlc4roOMVJFXCFpXHr38b04C4vLxiwu7fV+tlWQRfZQ11MhR1nDg+GTpaZyBpmhNw7W
         cDybtPVo601ZuxBhXTXY5S/Xxvn11jkgMtnoSfhA4hNwk5hZ8SqxWXv0fEDFp/KbLAxh
         UeEwiwm0KtRvs5Lnmn7FNQDAwaW8dZENCPnh/kcJj8BInFwnuVk4agR5fAq8RhaV/FD1
         O2INqqHWSW1H4sdluw4xndBtf0OQ56/4CWi2IutujOSh5m9yCR06fymIOdC+a7w8/ctR
         R+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5tHIDUsq4LL+IoBwMCzGzVl9HZ1csiUmdQYlYcAcCDM=;
        b=oDXRMuBaBlUqvp+MAL/c4RJg1Pn9iAiDOoJeyBXNxYSuhs04HHqSr/Zk1ld83owcCM
         IeN5WlZkYLIgXTgktSiywgSVDG51w6QjiPyUwKG/ByOoReC5CMbHGO3rI/MKR5J6wTpL
         39kx5stAtyw2waxLPzFWffLk/oi8+g7FLXYLXZPM0D3lap9uVHwdY6sJOi55xU8iGEml
         3//MF8acukdmWBjy4F/S3sXmHyQ2VJ752S67YqPeWTSJK53dR5TDwX6hGZp+3HJiGCry
         z/Gd2hi703NHU7bt1WwxpKTFThtc+g9o0uX96MEhWRAiQbx2LoUfEkZXISUUFERCmc1i
         Rd9w==
X-Gm-Message-State: AOAM533TSj4Hb4i10BD92azLcr2ADT76QJpszcVBI9Ihbqe4AsGvTk+r
        qEx50ZqyarstYz1EHDmGW9qPuA==
X-Google-Smtp-Source: ABdhPJwFAM0nEeUSw6UrKQ0gcXzNJ34EVnC/+rSYjKcBiuJFic8c7v2ehsBwGCYh4JbwO3kAAH1D5Q==
X-Received: by 2002:a17:902:ecca:b029:12d:1a3b:571f with SMTP id a10-20020a170902eccab029012d1a3b571fmr8719944plh.37.1629321275432;
        Wed, 18 Aug 2021 14:14:35 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a999:9b6d:55c3:b66c])
        by smtp.gmail.com with ESMTPSA id z3sm660337pjn.43.2021.08.18.14.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 14:14:34 -0700 (PDT)
Date:   Wed, 18 Aug 2021 14:14:27 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 4/6] hook: allow running non-native hooks
Message-ID: <YR14M7IJ9SoSwFDU@google.com>
References: <20210812004258.74318-1-emilyshaffer@google.com>
 <20210812004258.74318-5-emilyshaffer@google.com>
 <xmqqy29632hx.fsf@gitster.g>
 <YR1y7jxhGmnTJKyH@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR1y7jxhGmnTJKyH@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 18, 2021 at 01:51:58PM -0700, Emily Shaffer wrote:
> 
> On Thu, Aug 12, 2021 at 12:08:10PM -0700, Junio C Hamano wrote:
> > 
> > Emily Shaffer <emilyshaffer@google.com> writes:
> > 
> > > diff --git a/builtin/hook.c b/builtin/hook.c
> > > index c36b05376c..3aa65dd791 100644
> > > --- a/builtin/hook.c
> > > +++ b/builtin/hook.c
> > > @@ -46,7 +46,7 @@ static int list(int argc, const char **argv, const char *prefix)
> > >  
> > >  	hookname = argv[0];
> > >  
> > > -	head = hook_list(hookname);
> > > +	head = hook_list(hookname, 1);
> > >  
> > >  	if (list_empty(head)) {
> > >  		printf(_("no commands configured for hook '%s'\n"),
> > > @@ -108,7 +108,7 @@ static int run(int argc, const char **argv, const char *prefix)
> > >  	git_config(git_default_config, NULL);
> > >  
> > >  	hook_name = argv[0];
> > > -	hooks = hook_list(hook_name);
> > > +	hooks = hook_list(hook_name, 1);
> > >  	if (list_empty(hooks)) {
> > >  		/* ... act like run_hooks_oneshot() under --ignore-missing */
> > >  		if (ignore_missing)
> > 
> > This is minor, as I expect that the callers of hook_list() will
> > always confined in builtin/hook.c, but it probably is easier to read
> > if you gave two functions, just like you have the pair of helpers
> > find_hook() and find_hook_gently(), as the literal "1" forces the
> > readers to remember if that means "die if not found", or "ok if it
> > is a bogus name".
> 
> Yes, I see what you mean. Ok. I have been wanting to change the naming
> anyways - most functions in hook.h are verb-y ("find hook", "run hooks",
> so on) but hook_list stands out as the only noun-y function.
> 
> So I considered changing it to "list_hooks" and "list_hooks_gently", to align
> with find_hook(_gently)....
> 
> > 
> > In addition, it may make more sense to keep hook_list() signal
> > failure by returning NULL and leave the dying to the caller.
> > In-code callers (as opposed to "git hook run" that can throw any
> > random string that came from the user at the API) will never throw a
> > bogus name unless there is a bug, and they'll have to check for an
> > error return from hook_list() anyway and the error message they
> > would give may have to be different from the one that is given
> > against a hook name randomly thrown at us by the user.
> 
> Sure, that makes sense enough... but then I wonder if it would be better
> to let the caller check whether the name is allowed at all, first,
> separately from the hook_list() call.
> 
> On the one hand, having hook_list() do the validation of the hook name
> makes it harder for a hook doing something very unusual to neglect to
> add documentation. (I'm thinking of, for example, a hook doing something
> equally weird to the proc-receive hook, which cannot use the hook
> library because it needs to be able to do this weird two-way
> communication thing.
> (https://lore.kernel.org/git/20210527000856.695702-31-emilyshaffer%40google.com))
> It would be pretty bad for a hook which is already complicated to also
> forget to include documentation.
> 
> On the other hand, as it is now - builtin/hook.c hardcodes "I don't care
> if the hook is unknown" and hook.c hardcodes "reject if the hook is
> unknown" and nobody else calls hook_list at all - it isn't so bad to
> bail early, before even calling hook_list() in the first place, if the
> hook is unknown.
> 
> I also think that approach would make a callsite easier to understand
> than checking for null from hook_list().
> 
>   const char *hookname = "my-new-hook";
> 
>   /* Here it's pretty clear what the reason for the error was... */
>   if (!known_hook(hookname))
>     BUG("is hook '%s' in Documentation/githooks.txt?", hookname);
> 
>   hooks = hook_list(hookname);
>   ...
> 
> vs.
> 
>   const char *hookname = "my-new-hook";
>   hooks = hook_list(hookname);
>   /*
>    * But here, I have to go and look at the hook_list() source to
>    * understand why null 'hooks' means I missed some doc step.
>    */
>   if (!hookname)
>     BUG("is hook '%s' in Documentation/githooks.txt?", hookname);
>   ...
> 
> Maybe others disagree with me, but I would guess the first example is
> more easily understandable to someone unfamiliar with the hook code. So
> I think I will go with that approach, and include some notice in the doc
> comment over hook_list().

Hm. Now that I sit to type it, I guess putting the onus on the
strange-new-hook caller to also type "if known_hook()" is about the same
as just expecting the strange-new-hook caller to know they are supposed
to document their hook. Plus, known_hook() is static right now.

I think it still makes sense to BUG() instead of error() or die() in
'list_hooks()' (non-gently) - the failure of that call is a developer
error, either in not having documented their hook correctly or in
calling 'list_hooks()' instead of 'list_hooks_gently()' when they meant
the latter. So I will not take the NULL return approach.

 - Emily
