Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB39EC433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbhK2WO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhK2WMa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:12:30 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAEFC0E52F4
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 13:01:43 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id x30-20020a637c1e000000b00324ab629735so9105742pgc.17
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 13:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lpr/91NpYYhu8sGuM30a18Ycbh+6ZNV2wirrF3oGlqY=;
        b=CweRGWlNQKv6BPdsf7+VqwGPyCbtjGtwShe99itV82uYR7U4FMYYZ1bFdobTHkumR8
         D9577vzLxHKhgtSgguXbJB+fbMIMoID7UIAnS8tI5IAE3NHys5EPISH9e3ItLQpMmYOf
         fGQejNfaj7zWzAVrHSTDpp1iz+nZ+zBS/hS9DbSqP/iSNrF78r5tNApUWI9r6C/+Xy5Q
         W52lRTID9EeXZOokwXAWNmGTVEFmfycjDL6YEwz2dxxSWAgVjLsOieW1OAY66Akvr49F
         XqmSN0OVfOja9nB0L8xMqN9Dg/LezSJKwRBZ+FuHzxqRoZ67SlmEYW988HEUbaD8PfIo
         1zMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lpr/91NpYYhu8sGuM30a18Ycbh+6ZNV2wirrF3oGlqY=;
        b=VR0DcfgRn5cqjL+qlHa7OZSl7O693i6ouIs5+GD6u3f414SLymWgRncTyTYxPw8oOx
         OyGMJkujyNW6MH+Ib1RtZckqorghd7+JgRRjThIt28uzrEx2zi6a/NHOel7KTU5y7Tv+
         RhlJX6CobS4UL2oU5mL9Y9qCB7xSkdKT8uBXf0JWtnVNV1fVHyyJZyTjF82r0ItQZmAM
         DiUUZhk30BCQaRtFudeQ2ewiPpfujSDUxEkiq1HTN8D1f+b+RncmLey5djOWArz+/G/0
         WSj6mwTEz7Zz3C+M2gxelFrG4xbmBJHWDRbe2MPUQ3VXX7T1tPFehs9PgbcBx29g99UI
         3CrA==
X-Gm-Message-State: AOAM533dVECK6XXtBNGLj6tQHXFwsdlPinD6ZR1MCAM1XGrWlpQ8PtRY
        ELUXA1qBflOxFI3wdOl/zMXjcbW5Sa2BMlr/PtKH
X-Google-Smtp-Source: ABdhPJz20BKypSJBV2bXPKeh+LsFhZue0bmkpE5PkqRLfaV4ajOfJr2AkGYkH/ndLo9z9wOx88ugM8ht30akKq5W6ZRw
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:b20b:b0:141:a92c:a958 with
 SMTP id t11-20020a170902b20b00b00141a92ca958mr63476636plr.24.1638219702832;
 Mon, 29 Nov 2021 13:01:42 -0800 (PST)
Date:   Mon, 29 Nov 2021 13:01:40 -0800
In-Reply-To: <kl6lmtltto1l.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <20211129210140.937875-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <kl6lmtltto1l.fsf@chooglen-macbookpro.roam.corp.google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: Re: [PATCH 4/4] branch: add --recurse-submodules option for branch creation
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, steadmon@google.com,
        emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> > Before this function is a function that calls "git branch" directly -
> > couldn't this function do the same? (And then you can make both of them
> > into one function.) The functionality should be exactly the same except
> > that one has "--dry-run" and the other doesn't.
> 
> I see two somewhat valid interpretations, so I will address both.
> 
> If you are suggesting that I should call "git branch" instead of a new
> "git submodule--helper create-branch", that unfortunately does not work.
> Because of how we've defined the semantics, we want the submodule to
> branch off the commit in the superproject tree (which is a bare object
> id), but we want to set up tracking based off the ref that the user gave
> (evaluating it in the context of the submodule). This is why
> submodule--helper.c:module_create_branch() makes two calls like so:
> 
> 	create_branch(the_repository, "<branch name>", "<object id>", force, 0, reflog, quiet,
> 		      BRANCH_TRACK_NEVER);
> 	setup_tracking("<branch name>", "<tracking name>", track, quiet, 0);

Ah, I meant this interpretation. In that case, could we do it like this:

 - Add a dry_run parameter to submodule_create_branch(). It should stay
   exactly the same (except passing dry_run), so that the same code path
   is executed with and without dry_run. Delete
   submodule_validate_branchname(). (This makes sense conceptually
   because we're validating that we can later create the branches with
   the exact same parameters.)

 - When actually creating the branches, call submodule_create_branch(),
   then another command to set up tracking. I think it makes more sense
   if this is done directly through a Git command. If you want to use
   setup_tracking() through submodule--helper, I think that needs an
   explanation as to why a Git command wouldn't work.

> On the other hand, you might be suggesting that I should just add
> --dry-run to "git submodule--helper create-branch". That way, the
> dry-run form of the command is validating the non dry-run form (instead
> of using "git branch --dry-run" to validate "git submodule--helper
> create-branch"). That's a reasonable suggestion that avoids
> bikeshedding around "git branch --dry-run".

I didn't mean this interpretation, but this idea is reasonable if we
needed such functionality.

> >> +test_expect_success 'should create branch when submodule is in .git/modules but not .gitmodules' '
> >> +	test_when_finished "cleanup_branches super branch-a branch-b branch-c" &&
> >> +	(
> >> +		cd super &&
> >> +		git branch branch-a &&
> >> +		git checkout -b branch-b &&
> >> +		git submodule add ../sub-upstream sub2 &&
> >> +		# branch-b now has a committed submodule not in branch-a
> >> +		git commit -m "add second submodule" &&
> >> +		git checkout branch-a &&
> >> +		git branch --recurse-submodules branch-c branch-b &&
> >> +		git rev-parse branch-c &&
> >> +		git -C sub rev-parse branch-c &&
> >> +		git checkout --recurse-submodules branch-c &&
> >> +		git -C sub2 rev-parse branch-c
> >> +	)
> >> +'
> >
> > Hmm...how is this submodule in .git/modules but not .gitmodules? It
> > looks like a normal submodule to me.
> 
> The test title is probably too terse - the submodule is not in the
> working tree's .gitmodules, but it is in branch-b's .gitmodules. I'll
> reword the title.

Ah, I see. I think just delete the "is in .git/modules" part, so
something like "should create branch when submodule is not in HEAD's
.gitmodules".

> >> +test_expect_success 'should not create branch when submodule is not in .git/modules' '
> >
> > The title of this test contradicts the title of the test that I quoted
> > previously.
> 
> I'm not sure how this is a contradiction, from before..

[snip]

Ah...yes you're right.

> >> +test_expect_success 'should not fail when unable to set up tracking in submodule' '
> >> +	test_when_finished "cleanup_branches super-clone branch-b" &&
> >> +	(
> >> +		cd super-clone &&
> >> +		git branch --recurse-submodules branch-b origin/branch-b
> >> +	)
> >> +'
> >
> > Is there a warning printed that we can check?
> 
> "git branch" does not warn if tracking is not set up when it is not
> explicitly required, so this does not warn. However, I can imagine that
> if the superproject branch has tracking set up, a user might expect that
> all submodules would also have tracking set up, and thus a warning might
> be useful. I don't think it will be _that_ useful for most users, but at
> least some users would probably appreciate it.
> 
> For slightly unrelated reasons, I tried to get the tracking info of a
> newly created branch and it is tedious. For this reason and the fact
> that I'm not sure if the benefit is that great, I'm tempted *not* to add
> the warning, but perhaps you feel more strongly than I do?

In that case, maybe explain why tracking cannot be set up and verify in
the test that no tracking was set up.

> > Also, this patch set doesn't discuss the case in which the branch in a
> > submodule already exists, but it points to the exact commit that we
> > want. What is the functionality in that case?
> 
> The behavior is identical to the general case where the branch already
> exists - branch validation (git branch --dry-run) fails.
> 
> > I would say that the user should be able to recursively create the
> > branch in this case, but am open to other opinions.
> 
> I'm inclined to disagree. To illustrate this in the real world, say a
> user wants to create a 'new-feature' branch recursively, but there is
> already a 'new-feature in a submodule. Here are two possible sets of
> events that could lead to this situation:
> 
> 1) the 'new-feature' branch was intended for the same work as the new
>    branch but the user just happened to create the 'new-feature'
>    subomdule branch first
> 2) the existing 'new-feature' branch doesn't actually contain the same
>    work (maybe it's an overloaded term, or maybe the user used a branch
>    to bookmark a commit before starting work on it)
> 
> What would happen if we allowed the branch to be created? In case 1,
> the user would be more than happy (because we read their mind! woohoo!)
> But in case 2, the user might not realize that their bookmark is getting
> clobbered by the new recursive branch - they might try revisiting their
> bookmark only to realize that they've accidentally committed on top of
> it.
> 
> I think the incidence of case 2 is far lower than case 1's, but I think
> it's reasonable to be defensive by default. In any case, we can change
> the default after more user testing.

OK, this makes sense.
