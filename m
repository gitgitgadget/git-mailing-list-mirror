Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21692C48BE8
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 20:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEB4060E09
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 20:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbhFRU70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 16:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbhFRU7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 16:59:25 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3150C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 13:57:15 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id q192so2074668pfc.7
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 13:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tAzNZT9copZSFuO1ghP1Du22HTwv01MxxMwCU+LGMXo=;
        b=b0VqvUyrx1H5bvLfXrc1oavzYHrMeS+riSM4iUTn19X3ls9mXnOb8atjulBbq6a65D
         tbqAJbpkST09PKE4I5XP3dRoTmihCBLuWylRXxM+dfsoLw4KmjAoZap/1MqCV+T5klXg
         Pp9/qVxSHHUy3lgPn2Ux0DuQnfowQmBl12ETI3eX+UKKzCDlUtwCd828qD4S6rybOJws
         FfFlZ0wiEq15UOjYnmmvbJnw6/nwh3pCHjyG4ueENJgb6/Mk5JZLwbDfhJ6BfsNdBAPO
         wmvbX6XnBGydmA45uQurxbsYoriMzm15lTQtpuFi0khxYsItZ/+y58UrYKKO+XErG//M
         AFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tAzNZT9copZSFuO1ghP1Du22HTwv01MxxMwCU+LGMXo=;
        b=fnoVJhCnPwIOkTzSTz/YWFVqziqKJnQC9cON7xhy7ZmRDpJUdsD7zhFHlUBTh7t/oV
         Om3bJDGKQyHF/Cb8VcSQkzhZNlZbuLJiU2645QXKcygHGF+vrWNJi+t6ic60eeJLLsmq
         PDtwrqaeT7dNlLYsl31xxq8GyL4+DN8DoSE3w/bWOzWjKiz38XkCd6pCEOBPV7Im7c4s
         3SP6e+wZ7WKjIaK0Jr+xFkaZwMl/GA6+oxaqWfXlxNp9ZDZDCchV42WG2aUZfnW1of0Z
         bQDwmGXPY9DNHDNL0JtWTHQ8FYtpat7JBqsoQlxZpzMKJBuU+yVAlnBd3gMbuDFIlwIc
         AF7g==
X-Gm-Message-State: AOAM531Dsv5I2HXZwLzv/yfFZY3AAf1yIlOKAw8BL4NSnO0JYiqW5/7c
        zB+nfTrP1T+rQb5UZnKwYkELDXS6RjvI7w==
X-Google-Smtp-Source: ABdhPJxse5z0Wl/HZyfe8gPipm2fTnwP0oX6LIsLteqpJiPF5BOudwDLURDbIoMbJkEn/qsf6PjIRg==
X-Received: by 2002:a63:6547:: with SMTP id z68mr11732614pgb.341.1624049835047;
        Fri, 18 Jun 2021 13:57:15 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:551d:e7ea:4a2f:6667])
        by smtp.gmail.com with ESMTPSA id x2sm8969540pfp.155.2021.06.18.13.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 13:57:14 -0700 (PDT)
Date:   Fri, 18 Jun 2021 13:57:08 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] MVP implementation of remote-suggested hooks
Message-ID: <YM0IpOFH4Sy9wWaE@google.com>
References: <cover.1623881977.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1623881977.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 16, 2021 at 04:31:47PM -0700, Jonathan Tan wrote:
> 
> I have had to make several design choices (which I will discuss later),
> but now with this implementation, the following workflow is possible:
> 
>  1. The remote repo administrator creates a new branch
>     "refs/heads/suggested-hooks" pointing to a commit that has all the
>     hooks that the administrator wants to suggest. The hooks are
>     directly referenced by the commit tree (i.e. they are in the "/"
>     directory).

I don't really like that this is in the same namespace as branches users
could create themselves. Hm, I think for 'git maintenance' prefetching
we put those refs in some special namespace, right? Can we do something
similar in this case? Would that prevent us from treating that ref like
a normal branch?

> 
>  2. When a user clones, Git notices that
>     "refs/remotes/origin/suggested-hooks" is present and prints out a
>     message about a command that can be run.
> 
>  3. If the user runs that command, Git will install the hooks pointed to
>     by that ref, and set hook.autoupdate to true. This config variable
>     is checked whenever "git fetch" is run: whenever it notices that
>     "refs/remotes/origin/suggested-hooks" changes, it will reinstall the
>     hooks.

I think this is where most people will have a lot to say from security
perspective. It will be important to make sure that:
 - "git fetch" only automatically updates these scripts when fetching
   from the same remote they were initially fetched from, over some
   secure protocol
 - hook.autoupdate setting maybe should not be default, or should at
   least be able to override during the install command. (One suggestion
   was to also set some experimental.suggestedHooks setting, or
   something, to turn on "automatically set up autoupdate" behavior?)
 - we should notify the user that their hooks were updated/reinstalled
   when that happens later on. (Maybe you did this, I didn't look at the
   diff quite yet)

>  4. To turn off autoupdate, set hook.autoupdate to false. Existing hooks
>     will remain.
> 
> Design choices:
> 
>  1. Where should the suggested hooks be in the remote repo? A branch,
>     a non-branch ref, a config? I think that a branch is best - it is
>     relatively well-understood and any hooks there can be
>     version-controlled (and its history is independent of the other
>     branches).

I agree - a branch without any prior parent sounds ideal to me, that is,
the repo owner setting up the hooks can say 'git checkout --orphan
suggested-hooks'. I guess if they want the branch to have history
shared with the rest of the project there's no reason not to do that,
either.

Do we want to provide helpful tooling for the administrator to create
this magic branch? At the very least I guess we want some documentation,
but I wonder if it's possible to make a helper (maybe a 'git hook'
subcommand) without being more prescriptive than Git project usually is.

>  3. How should the local repo detect when the remote has updated its
>     suggested hooks? I'm thinking when a certain local ref is updated.
>     Right now it's hardcoded, but perhaps "git clone" could detect what
>     "refs/heads/suggested-hooks" would correspond to, and then set it in
>     a config accordingly. Other options include remembering what the
>     remote's "refs/heads/suggested-hooks" used to be and always
>     comparing it upon every "ls-refs" call, but I think that the local
>     ref method is more straightforward.

Hm, I like that idea as it's analogous to remote tracking branch + local
tracking branch (which is a pretty common pattern for people to use).

> 
>  4. Should the local repo try to notice if the hooks have been changed
>     locally before overwriting upon autoupdate? This would be nice to
>     have, but I don't know how practical it would be. In particular, I
>     don't know if we can trust that
>     "refs/remotes/origin/suggested-hooks" has not been clobbered.

I think it would be nice to have, yeah. It seems important to notify the
users that they are executing something different from yesterday, so
noticing when we're making changes to the hook sounds useful.

> 
>  5. Should we have a command that manually updates the hooks with what's
>     in "refs/heads/suggested-hooks"? This is not in this patch set, but
>     it sounds like a good idea.

Yeah, I think so - that lets a user say "no, I don't need those hooks
(or this update)" at first, but later change their mind.

One thing that sounds useful to me, even at this RFC stage, is
documentation showing what this feature looks like to use - for both
the administrator setting up the magic hook branch, and the developer
cloning and using hooks. I think we want that in some Git manpage
eventually anyways, and it would help to see the workflow you're trying
to achieve.

Thanks for sending - will review the diffs today too.

 - Emily

> 
> There are perhaps other points that I haven't thought of, of course.
> 
> [1] https://lore.kernel.org/git/pull.908.git.1616105016055.gitgitgadget@gmail.com/
> 
> Jonathan Tan (2):
>   hook: move list of hooks
>   clone,fetch: remote-suggested auto-updating hooks
> 
>  builtin/bugreport.c |  38 ++------------
>  builtin/clone.c     |  10 ++++
>  builtin/fetch.c     |  21 ++++++++
>  builtin/hook.c      |  13 +++--
>  hook.c              | 118 ++++++++++++++++++++++++++++++++++++++++++++
>  hook.h              |   5 ++
>  t/t5601-clone.sh    |  36 ++++++++++++++
>  7 files changed, 202 insertions(+), 39 deletions(-)
> 
> -- 
> 2.32.0.272.g935e593368-goog
> 
