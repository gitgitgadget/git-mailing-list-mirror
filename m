Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601F7C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 21:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43A1B61248
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 21:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbhFRVtE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 17:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhFRVtE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 17:49:04 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53528C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 14:46:54 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id c3-20020a37b3030000b02903ad0001a2e8so6818864qkf.3
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 14:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UMF7LBxJhkfNlB88nXTGP0fX8JakxL4sjvlNJRv2DbA=;
        b=pXh4WDlDlK9eNAsQOM5btnsQqATDCipN0CbPFivZYA9dm/ijdtIGcK9BHR/xXoxSjD
         Go6VX5XTl6Ly6ApARFiD6bomwymIiU3LVts7Ku97lVAxzkoyKX7QL7cH2ScQPRmwptk0
         xcMu0DBp9xFYYpUBHoyIf9fggOC4hSZbwz6zttQ2nmWQZ2h71SRPnt5aXQHdo+AVYvWF
         WVisKlSvVUAxMgQKuMjn5r2FzbVYOgYcaCZ62S84OOuhkO7gOSpDrQv+11rC0bHiNgaE
         P9obrv1IiK5OJL1uLS9Fre2E2wsgAWiRDZTkKCH0nEpSS+3ISGNi0t10RYya8rnwUr2k
         IEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UMF7LBxJhkfNlB88nXTGP0fX8JakxL4sjvlNJRv2DbA=;
        b=V2QcOlrwYKpyHv45vzujmEN32pyuia6UyBAClg02xBffZqwO9SyddFmZXwCzGlgKj2
         weE61aOf/CZm1iXr8MX4TsqmOE9En/uXXz9AZL/Ufzq5dG7SH7otcCpU04u1s8v4iluK
         FEEI+ZgTz5IY0fp+INVsmObyhPXJDGdTxV6bFoDXToSg09RCoiNMVT5JYKTR5CGSooFK
         GPJjVKTj9vjKQSgs4FM9l9/Qewb1szozhuTeT3Z9N9HZTCX9k9E046LfCeKMZp402+PW
         hU4TqnxjMyCkIoqIXGflJojqzDKvrqim46dqVALJLXCY7A3tkYzQ3Tp6D+5mp+iW5d0r
         M+KQ==
X-Gm-Message-State: AOAM531ymRmN42p6mdy/Ao8jIhQUAFk5Vo7Oh1eZizlTDy9/8ZetNGYu
        XJuLH8fCiON7YXYH9bs+GEICsjGn8Hd0v4qhkfVB
X-Google-Smtp-Source: ABdhPJwPSNmMESLnukhQdu0pD3WxZwskhuhDpCjHAKEgkEwfcf+aGb1PYMPTzUoTWpnmDyeBuz1x0GGgmaE8AtnjUFcO
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:1208:: with SMTP id
 s8mr17244734ybu.71.1624052813437; Fri, 18 Jun 2021 14:46:53 -0700 (PDT)
Date:   Fri, 18 Jun 2021 14:46:50 -0700
In-Reply-To: <xmqq35thnuqp.fsf@gitster.g>
Message-Id: <20210618214650.792661-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq35thnuqp.fsf@gitster.g>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: Re: [RFC PATCH 0/2] MVP implementation of remote-suggested hooks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> >  1. The remote repo administrator creates a new branch
> >     "refs/heads/suggested-hooks" pointing to a commit that has all the
> >     hooks that the administrator wants to suggest. The hooks are
> >     directly referenced by the commit tree (i.e. they are in the "/"
> >     directory).
> 
> wants to suggest?  They simply suggest ;-)

Ah yes :-)

> 
> >  2. When a user clones, Git notices that
> >     "refs/remotes/origin/suggested-hooks" is present and prints out a
> >     message about a command that can be run.
> 
> Can be run to install?  Or can be run to first inspect?  Or both?

Right now I only have a command that installs, but I can provide the
appropriate "cat-file" invocations to inspect them as well.

> >  3. If the user runs that command, Git will install the hooks pointed to
> >     by that ref, and set hook.autoupdate to true. This config variable
> >     is checked whenever "git fetch" is run: whenever it notices that
> >     "refs/remotes/origin/suggested-hooks" changes, it will reinstall the
> >     hooks.
> >
> >  4. To turn off autoupdate, set hook.autoupdate to false. Existing hooks
> >     will remain.
> 
> OK, so "verify even if you implicitly trust" is actively discouraged.

Yes I was thinking of the model in which we already trust upstream, but
I agree that verification can be useful. I think we can print the
"cat-file" commands needed to verify before installing, and add a mode
in which we tell the user that the hooks have been updated (but not
automatically install them).

> > Design choices:
> >
> >  1. Where should the suggested hooks be in the remote repo? A branch,
> >     a non-branch ref, a config? I think that a branch is best - it is
> >     relatively well-understood and any hooks there can be
> >     version-controlled (and its history is independent of the other
> >     branches).
> 
> As people mentioned in the previous discussions, "independent of the
> other branches" has advantages and disadvantages.  The most recent
> set of hooks may have some that would not work well with older
> codebase, so care must be taken to ensure any hook works on across
> versions of the main codebase.  Which may not be a huge downside,
> but something users must be aware of.

That's true - and on the flip side, I would presume that the
hook-introducing admin would usually want those hooks to apply
retroactively too (say, to someone updating a "maint" branch). I think
it's more flexible if hooks are in an independent branch, though - (if
independent branch) a hook can be written to tolerate an old codebase,
but if embedded in the code branch, such a hook cannot apply
retroactively to old code.

> >  2. When and how should the local repo update its record of the remote's
> >     suggested hooks? If we go with storing the hooks in a branch of a
> >     remote side, this would automatically mean (with the default
> >     refspec) that it would be in refs/remotes/<remote>/<name>. This
> >     incurs network and hard disk cost even if the local repo does not
> >     want to use the suggested hooks, but I think that typically they
> >     would want to use it if they're going to do any work on the repo
> >     (they would either have to trust or inspect Makefiles etc. anyway,
> >     so they can do the same for the hooks), and even if they don't want
> >     to use the remote's hooks, they probably still want to know what the
> >     remote suggests.
> 
> A way to see what changes are made to recommendation would be
> useful, and a branch that mostly linearly progresses is a good way
> to give it to the users.
> 
> Of course, that can be done with suggested hooks inline with the
> rest of the main codebase, too.

That's true.

> >  4. Should the local repo try to notice if the hooks have been changed
> >     locally before overwriting upon autoupdate? This would be nice to
> >     have, but I don't know how practical it would be. In particular, I
> >     don't know if we can trust that
> >     "refs/remotes/origin/suggested-hooks" has not been clobbered.
> 
> Meaning clobbered by malicious parties?  Then the whole thing is a
> no-go from security point of view.  Presumably you trust the main
> content enough to work on top of it, so as long as you can trust
> that refs/remotes/origin/hooks to the same degree that you would
> trust refs/remotes/origin/master, I do not think it is a problem.

I meant clobbered by the user - should have made that more clear. To
elaborate...

> Whatever mechanism you use to materialize an updated version of the
> hooks can and should record which commit on the suggested-hooks
> branch the .git/hooks/* file is based on.  Then when the user wants
> to update to a different version of suggested-hooks (either because
> you auto-detected, or the user issued a command to update), you have
> 
>  - The current version in .git/hooks/*
> 
>  - The old pristine version (you recorded the commit when you
>    updated the .git/hooks/* copy the last time)
> 
>  - The new pristine version (you have a remote-tracking branch).
> 
> and it is not a brain surgery to perform three-way merge to update
> the first using the difference between the second and the third.

...I was having a difficult time figuring out where to store such
information (ref? config? I wouldn't be surprised if a user saw a value
there and thought that they could change it). Perhaps it could be a
separate file like .git/shallow.

I'm not fully convinced that maintaining the ability to retain local
hook modifications by supporting three-way merges is important, but if
it is, it might be brain surgery to figure out the UX when merge
conflicts occur. Normally these conflicts can be written to the worktree
and index, but we don't have those in the case of hooks.

> >  5. Should we have a command that manually updates the hooks with what's
> >     in "refs/heads/suggested-hooks"? This is not in this patch set, but
> >     it sounds like a good idea.
> 
> I wonder if having it bound as a submodule to a known location in
> the main contents tree makes it easier to manage and more flexible.
> Just like you can update the working tree of a submodule to a
> version that is bound to the superproject tree, or to a more recent
> version of the "branch" in the submodule, you can support workflows
> that allow suggested hooks to advance independent of the main
> contents version and that uses a specific version of suggested hooks
> tied to the main contents.

This would make the hooks dependent on the commit checked out (with
perhaps a bit more leeway in that our implementation could be flexible
and use a commit later than what's in the gitlink), with its own pros
and cons (as you said earlier).
