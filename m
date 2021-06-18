Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAF1C48BE8
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 21:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5782C6127C
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 21:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhFRWBB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 18:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhFRWBB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 18:01:01 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E76C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 14:58:51 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id m133-20020a37a38b0000b02903adaf1dd081so6820784qke.14
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 14:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=//7gFOiq4aL93duC1LlT67dSuIZBYcdCTl1stKlqw5Y=;
        b=UZzLM2flTfvhtp+9S927UimSt2ARa9Eaff8PVTzEUhUrpIW01wbDRj85kQPOadYETI
         OOiqBTiqDMWEAz/aTOyn9G4P677RwrvJ1TbVTtpKp/6wuVuXf3JOtUthpy/4dj4N7J4V
         Ywv/b6iFpfalgknfLPfQZOBVJIJyWdO6fpL4fumkGzNL9DTjt5hjErMrNEy/rQJPAc92
         M1tOJnExmeYvDROzhDFviyQcwBrSviQsWi0c7ShTWhoqSj0kWdwQwGh57WELdx34qUAh
         w5AuaB7afFwabjEkwp1jQUthDR8HMlxLH6H8F5ecXMuQPqDCMH57oeqddl3RUe12351k
         Ei9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=//7gFOiq4aL93duC1LlT67dSuIZBYcdCTl1stKlqw5Y=;
        b=Rekxtt74suzCIzum+RxWDslz1tK3xuGHSAdvoGcM+iQT/FmpNaCQ+E65bfzWZNCFME
         R2HlO4VPpM9WwlPaMfa04++vHvFBF8KnB+cLHLnevmBtluliGCYfhe/WzKqzabu052P3
         E1qvXYucV/UsYKOyIVfqXYVVv1MlFJiHyobY39nv7uJ7wrrqO4zuPGc5bn9cJvR7kwK0
         z1UVcDCP+X1hWdN1nOotVvHUdAc/YNdk+jWtXsp903cdjXgfNvY+e/CYvZDokZJdO3rM
         VBqgZmJ45sAcWIRlLuxbrDqxEQIgwAoQJpadxJmtmH2lKM6Bx6YuDaiirOuVHn887EYc
         F+Fg==
X-Gm-Message-State: AOAM530edrMgqTlItIJdSAq40PaQLvkd1abrUbWkSvAfkebCgo5QUD8E
        xPWjQyYL1xKBlAFDhOfnos2nsruFdumBiuTk0lrI
X-Google-Smtp-Source: ABdhPJy5iXBz33XPf3E78cXNMD798IOHszqlR1oN3IUAx/CWvBTB5XTTwb7MLxi6bMeWQvXCrnDars0wle23Za4sj1pU
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:150:: with SMTP id
 x16mr679418qvs.42.1624053530390; Fri, 18 Jun 2021 14:58:50 -0700 (PDT)
Date:   Fri, 18 Jun 2021 14:58:48 -0700
In-Reply-To: <YM0IpOFH4Sy9wWaE@google.com>
Message-Id: <20210618215848.794617-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YM0IpOFH4Sy9wWaE@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: Re: [RFC PATCH 0/2] MVP implementation of remote-suggested hooks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Wed, Jun 16, 2021 at 04:31:47PM -0700, Jonathan Tan wrote:
> > 
> > I have had to make several design choices (which I will discuss later),
> > but now with this implementation, the following workflow is possible:
> > 
> >  1. The remote repo administrator creates a new branch
> >     "refs/heads/suggested-hooks" pointing to a commit that has all the
> >     hooks that the administrator wants to suggest. The hooks are
> >     directly referenced by the commit tree (i.e. they are in the "/"
> >     directory).
> 
> I don't really like that this is in the same namespace as branches users
> could create themselves. Hm, I think for 'git maintenance' prefetching
> we put those refs in some special namespace, right? Can we do something
> similar in this case? Would that prevent us from treating that ref like
> a normal branch?

Do you mean that the server should put it in a different place, the
client should put it in a different place, or both?

> >  2. When a user clones, Git notices that
> >     "refs/remotes/origin/suggested-hooks" is present and prints out a
> >     message about a command that can be run.
> > 
> >  3. If the user runs that command, Git will install the hooks pointed to
> >     by that ref, and set hook.autoupdate to true. This config variable
> >     is checked whenever "git fetch" is run: whenever it notices that
> >     "refs/remotes/origin/suggested-hooks" changes, it will reinstall the
> >     hooks.
> 
> I think this is where most people will have a lot to say from security
> perspective. It will be important to make sure that:
>  - "git fetch" only automatically updates these scripts when fetching
>    from the same remote they were initially fetched from, over some
>    secure protocol

Putting the hooks in a branch does mean that "git fetch" gets these
scripts from the same remote (as opposed to, say, putting them in a
submodule or referring to them by URL), and I think it's easier to
understand (from the user point of view) that branch equals same remote
(rather than say that a submodule or URL is considered to be from the
same remote if $CRITERIA).

>  - hook.autoupdate setting maybe should not be default, or should at
>    least be able to override during the install command. (One suggestion
>    was to also set some experimental.suggestedHooks setting, or
>    something, to turn on "automatically set up autoupdate" behavior?)

OK, this makes sense.

>  - we should notify the user that their hooks were updated/reinstalled
>    when that happens later on. (Maybe you did this, I didn't look at the
>    diff quite yet)

I didn't do this, but this is a good idea.

> > Design choices:
> > 
> >  1. Where should the suggested hooks be in the remote repo? A branch,
> >     a non-branch ref, a config? I think that a branch is best - it is
> >     relatively well-understood and any hooks there can be
> >     version-controlled (and its history is independent of the other
> >     branches).
> 
> I agree - a branch without any prior parent sounds ideal to me, that is,
> the repo owner setting up the hooks can say 'git checkout --orphan
> suggested-hooks'. I guess if they want the branch to have history
> shared with the rest of the project there's no reason not to do that,
> either.

How would the branch share history with the rest of the project? If you
mean that we should allow the users to store hooks as part of the main
codebase (within a configurable path, say, /suggested_hooks) and then
point both "main" (or whatever the default branch is) and
"refs/remotes/origin/suggested-hooks" to the same place, then that
makes sense (although I would say that it still sounds better to have
separate histories).

> Do we want to provide helpful tooling for the administrator to create
> this magic branch? At the very least I guess we want some documentation,
> but I wonder if it's possible to make a helper (maybe a 'git hook'
> subcommand) without being more prescriptive than Git project usually is.

This sounds like the equivalent of "git checkout --orphan", as you
suggested above. We could just write it out in the documentation. I'm
not completely opposed to a special command, though.

> >  3. How should the local repo detect when the remote has updated its
> >     suggested hooks? I'm thinking when a certain local ref is updated.
> >     Right now it's hardcoded, but perhaps "git clone" could detect what
> >     "refs/heads/suggested-hooks" would correspond to, and then set it in
> >     a config accordingly. Other options include remembering what the
> >     remote's "refs/heads/suggested-hooks" used to be and always
> >     comparing it upon every "ls-refs" call, but I think that the local
> >     ref method is more straightforward.
> 
> Hm, I like that idea as it's analogous to remote tracking branch + local
> tracking branch (which is a pretty common pattern for people to use).

Yeah - that is partly why I like the branch idea (something already
generally understood by people).

> >  4. Should the local repo try to notice if the hooks have been changed
> >     locally before overwriting upon autoupdate? This would be nice to
> >     have, but I don't know how practical it would be. In particular, I
> >     don't know if we can trust that
> >     "refs/remotes/origin/suggested-hooks" has not been clobbered.
> 
> I think it would be nice to have, yeah. It seems important to notify the
> users that they are executing something different from yesterday, so
> noticing when we're making changes to the hook sounds useful.

Junio suggested [1] that we store more information about what's going
on, so this might be practical.

[1] https://lore.kernel.org/git/xmqq35thnuqp.fsf@gitster.g/

> >  5. Should we have a command that manually updates the hooks with what's
> >     in "refs/heads/suggested-hooks"? This is not in this patch set, but
> >     it sounds like a good idea.
> 
> Yeah, I think so - that lets a user say "no, I don't need those hooks
> (or this update)" at first, but later change their mind.

OK.

> One thing that sounds useful to me, even at this RFC stage, is
> documentation showing what this feature looks like to use - for both
> the administrator setting up the magic hook branch, and the developer
> cloning and using hooks. I think we want that in some Git manpage
> eventually anyways, and it would help to see the workflow you're trying
> to achieve.
> 
> Thanks for sending - will review the diffs today too.
> 
>  - Emily

Agreed - at the very least, we would need to write this workflow as a
test, and we can just reuse the same workflow in documentation. We just
need to discuss what the workflow should be :-) (as it is, one thing
that is becoming obvious is that currently people prefer to have
verify-before-update instead of auto-update by default).
