Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF29C433F5
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 00:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343957AbiFAAOJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 20:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244193AbiFAAOF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 20:14:05 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEF7286D0
        for <git@vger.kernel.org>; Tue, 31 May 2022 17:14:03 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id y15-20020a17090a16cf00b001e03ac27c30so213386pje.5
        for <git@vger.kernel.org>; Tue, 31 May 2022 17:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9NRnEVJTtyZ9tbcoI4dOnCnw+gf7h1p3+2+F8DEx650=;
        b=L92iQohJqBrU8RNZRFkpdFSBcNRL8v+K0nA9AkKOGiWisK7ZBcIsIB5Khr3XAA5KtA
         vL0bQ9ZU+Uq7quYhlOh3S7U23DJUQBeLTvIK/aKpYE2PJd7So8f8U+8oGkv0t68Tiy5i
         7ryQIzOGJvWyI8NvO1eQuLtJKLhqPO2h/alFVMXa8MuZcHMUwy2eXrRkBatsyzygOqxg
         gwVnaS6btWxzVCNdCFvxKbRE2W6PvkIwMyO70ff52b7pbAlIR99WwhpCrgcxkFBXFdCg
         LgbEU6CXTZGS84z3MIBM/JYLhZ/58MokE+grcC5vbaTxpNRpSMHgwhBGUAZheA28Zpje
         cT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9NRnEVJTtyZ9tbcoI4dOnCnw+gf7h1p3+2+F8DEx650=;
        b=IN8ODJGe5GTE3QgUew/JEDk3Jo/72tNHCvb4GSijUGwxHsEhRmi9oVC64h9K5UKr0f
         JWS+G9MdimI/X/57ir0luA1Dy7u3Mqu4IPswnlE0BmO9a63qUwAgWuDbzVRMIPO1HqbW
         uoOy9kkcTKB+ZAGFtcQFkaj6RpHMK/V/iEXNvxFm63MlCI2ILEYuhErFPrXS/zXm+3Rk
         rVuy1KIzHJ2Q4qsd+VgeUM2rq9i+J21Gp+IDpRj9OFu4/dUYW3AoGwiCnIWk66669L+G
         zQL8y2zPwNb4ZGkVneUGlHn7ZSz1EWNdD26c9bVrR+sU0UfWiZq3X9GWodgCQhZ1bm19
         SzyQ==
X-Gm-Message-State: AOAM530UaUpZOn1ko34sRZhHrYxSLJgt31GGZyqsKjJzzxQnDklrI6k6
        KXoF9EAytHAROHNDdV99WI3tw0XPNWq4FA==
X-Google-Smtp-Source: ABdhPJx0LC12SA2M+uGaGD9dEnnphCT5ucIqLLyySo9late9lHWLvCxqLzlxorzKUv5wVpDesVbnrCk59GXW5A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:2389:b0:518:be44:f3c8 with SMTP
 id f9-20020a056a00238900b00518be44f3c8mr40633443pfc.8.1654042443109; Tue, 31
 May 2022 17:14:03 -0700 (PDT)
Date:   Tue, 31 May 2022 17:13:54 -0700
In-Reply-To: <eb2d8ce45e556afd81216746f190bc5c883cdb81.camel@xlumurb.eu>
Message-Id: <kl6lleuhdyv1.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <eb2d8ce45e556afd81216746f190bc5c883cdb81.camel@xlumurb.eu>
Subject: Re: git pull --recurse-submodules wipes uncommitted submodule changes
 without warning
From:   Glen Choo <chooglen@google.com>
To:     Guillaume Girol <symphorien@xlumurb.eu>, git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Thanks for the report!

Guillaume Girol <symphorien@xlumurb.eu> writes:

> What did you do before the bug happened? (Steps to reproduce your
> issue)
>
> The repository has a submodule bar.
> In the current checkout, bar has new commits, but this is not commited:
>
> ----------------------------
>
> $ git status
> On branch master
> Your branch is behind 'origin/master' by 1 commit, and can be fast-
> forwarded.
>   (use "git pull" to update your local branch)
>
> Changes not staged for commit:
>   (use "git add <file>..." to update what will be committed)
>   (use "git restore <file>..." to discard changes in working directory)
> 	modified:   bar (new commits)
>
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
> 	git-bugreport-2022-05-31-2142.txt
>
> no changes added to commit (use "git add" and/or "git commit -a")
>
> ----------------------------
>
> There is one commit to pull. It affects a file in the superproject, but
> not the submodule.
>
> The issue arises with:
>
> $ git pull --recurse-submodule=on-demand --no-rebase
>
> What did you expect to happen? (Expected behavior)
>
> The file affected by the pulled commit is modified, but the submodule
> is left untouched.
> The output of git status should look like:
>
> ----------------------------
>
> $ git status
> On branch master
> Your branch up to date with 'origin/master'.
>
> Changes not staged for commit:
>   (use "git add <file>..." to update what will be committed)
>   (use "git restore <file>..." to discard changes in working directory)
> 	modified:   bar (new commits)
>
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
> 	git-bugreport-2022-05-31-2142.txt
>
> no changes added to commit (use "git add" and/or "git commit -a")
>
> ----------------------------
>
> What happened instead? (Actual behavior)
>
> --------------------------
>
> $  git pull --recurse-submodule=on-demand --no-rebase
> Updating 67627dd..80f5c51
> Fast-forward
>  foo | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> Submodule path 'bar': checked out
> 'ef3c0711fedca48b0b43aadfd01b7bb94b519a13'
>
> $  git status
> On branch master
> Your branch is up to date with 'origin/master'.
>
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
> 	git-bugreport-2022-05-31-2142.txt
>
> nothing added to commit but untracked files present (use "git add" to
> track)
>
> -----------------------
>
> my uncommitted changes to the submodule have been wiped, and the commit
> of the pulled revision was checked out.

This is very clear, thank you.

So basically, because you made a commit in your submodule but did not
commit it back to the superproject, you have 'uncommitted changes'. When
doing "git pull --recurse-submodules", you expect your 'uncommitted
changes' to be left alone, but instead, your submodule has now checked
out an older version.

i.e. your starting state and desired end state is:

  superproject                submodule 
  B (origin/master)           D (HEAD)
  | \                         |
  |  \                        |
  |   ---------               |
  |            \              |
  A (master) ---------------- C

Where you had submodule commit D checked out and it stays checked out.

However your actual end state is:

  superproject                submodule 
  B (origin/master)           D
  | \                         |
  |  \                        |
  |   ---------               |
  |            \              |
  A (master) ---------------- C (HEAD)

where you've checked out submodule commit C, and submodule commit D has
been 'abandoned'.

"checkout --recurse-submodules" is known to abandon commits in a similar
way; the same thing can happen if you had done "git fetch && git
checkout --recurse-submodules origin/master". This is because we only
check for uncommitted changes in the _submodule_, even though the
submodule itself is not committed to the superproject.

But oddly enough, "pull --recurse-submodules" actually abandons the
commits in a _different_ way. After fetching (recursively) and merging
(non-recursively), "git pull" updates the submodules using "git
submodule update --recursive --checkout". This makes each submodule do a
"git checkout <version in merged superproject commit>" (in the example
above, this is commit C). This obviously doesn't actually merge
anything, and presumably we only do this because we want to update the
submodule working tree at the end of "git pull" (see
t/t5572-pull-submodule.sh for examples of how this works).

One way we _might_ be able fix this is to teach "git submodule update"
to notice if the submodule has changed and to abort the checkout if so
(maybe the option could be named --no-abandon?)

> Anything else you want to add:
>
> git pull is able to detect conflicts on submodules, so why not non-
> conflicts on submodules?

IIUC, part of the problem is that we do a very basic job of merging
submodules:

- we check to if the two superproject commits point to the same
  submodule commit
- if they are the same, there is no conflict
- if they are different, there is a merge conflict

In your case, the submodule is not changed (both superproject commits
point to submodule commit C), so there is no merge conflict.

I don't see why we couldn't tighten up our submodule conflict detection
though. This is like a fast-forward/two-way merge, but when we do a
two-way merge, we also check the index to make sure we don't abandon any
local changes. We could do the same for submodules to make sure we don't
abandon any new submodule commits.

What's nice about this idea is that we might be able to reuse this
two-way merge logic to teach "git checkout" not to abandon submodule
commits.
