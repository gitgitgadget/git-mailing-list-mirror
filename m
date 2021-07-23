Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCBEC4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 12:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 671A460E53
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 12:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbhGWMLc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 08:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbhGWMLb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 08:11:31 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B023C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 05:52:04 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id u10so1706022oiw.4
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 05:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YVl9V8AT6EW2+6XDF33t5KS4K0LyHnHF7dLav80mBR4=;
        b=Z8GJLAD0pTSHUqjdUtvxoqDRDAAV01Dze4WXXILHb8jl4S8u4hpLsZvowF8EGc7pGl
         zoGAhyrhyCXkFiRU18QA/fraXVyuy7AMffIhjl7hfOD4h/irqxKgmHos2I7teN/UFADj
         Y6Bq+Pa1f69yEQ811ONWOhsNF9O7FYaJzmJ6SMV42jhQ3BJZy+8VtHcdhi1oS+/Qpdhu
         5H+1PW5nEHeZtMrY0q6+KnmOfvr64Pee9y3nMmg1HOmLyakIW6fykQzOKfeEi6Cg/I23
         OqNhBL/yac5512n+DUdBE/JNK6uyTWDIvZdlBu/lp7big+6DzIxbLej+iVxJu47KRUtG
         gFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YVl9V8AT6EW2+6XDF33t5KS4K0LyHnHF7dLav80mBR4=;
        b=MzzwCN3DugqQXad8+LgDO1SD8ybDR/NrmbKxG5pBcmIf0AKXr4uI1N3txwKOI36lmU
         h5aBYxY/ybsr0VRiV9RiNkP/8ScFuy+o/y8e0QLhjv7XKqnW8p3lqYBlKFuHt2CQVaPO
         2pQgaUATDnEO+0WjtL9R4l7zQKpr9tqr9UxRzy3L9u8EJSSkqoztWYy77ERBzxdaguDx
         8bX/jtHGEW9m9Blv44rVpa5iwTjXYr2Te5uFDCoprzZF+eFEz90xLVE/Gsua2g59dGtg
         CXx0oeU8pauEQV41ZySptVq9Dxc6RwNQSK1gljxxKHL5hZV867D7mA76L1u4Wrd21xQE
         HUHQ==
X-Gm-Message-State: AOAM532KDDIaA1esJSnYwH7sBqiIbter2qoRBklzgX9UiRyN/CQEgoRB
        KCvihTB7gqPuAdl/ZPp5Pksmzcz15HhmhvoLj1s=
X-Google-Smtp-Source: ABdhPJz48haeXSpGlVjudyr8M+DiWmvNxL4sufwo2JiBFDQDTyvQVfZj8Qeh+UNqBVjLijNj5daOQBD2MQXX6bhiW3o=
X-Received: by 2002:aca:38c3:: with SMTP id f186mr8516882oia.39.1627044723361;
 Fri, 23 Jul 2021 05:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <pull.999.git.1626901619.gitgitgadget@gmail.com>
In-Reply-To: <pull.999.git.1626901619.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 23 Jul 2021 05:51:52 -0700
Message-ID: <CABPp-BGBwbV7x8i=OVbPnMgWcfdLrEh3-yUi=Amw+XBwpf7A6Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] Sparse Index: Integrate with 'git add'
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I haven't read the series yet (I'm going to try to read them all
today), but wanted to comment on a couple things in your cover
letter...

On Wed, Jul 21, 2021 at 2:07 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This patch series re-submits the 'git add' integration with sparse-index.
> The performance gains are the same as before.
>
> It is based on ds/commit-and-checkout-with-sparse-index.
>
> This series was delayed from its initial submission for a couple reasons.
>
> The first was because it was colliding with some changes in
> mt/add-rm-in-sparse-checkout, so now we are far enough along that that
> branch is in our history and we can work forwards.
>
> The other concern was about how 'git add ' should respond when a path
> outside of the sparse-checkout cone exists. One recommendation (that I am
> failing to find a link to the message, sorry) was to disallow adding files
> that would become index entries with SKIP_WORKTREE on. However, as I worked

I think the recommendation was:
  * Permitted: running git add on tracked files with the SKIP_WORKTREE
bit *clear*
  * Disallowed: running git add on tracked files with the
SKIP_WORKTREE bit *set*
  * Disallowed: running git add on untracked files that would become
index entries with the SKIP_WORKTREE bit set

where the latter two exit with an error message that suggests changing
the sparsity specification first.  I think this is what has existed
for some time, other than Matheus adding some error messages to help
the user when their add command doesn't match anything otherwise.

> towards that goal I found that change would cause problems for a realistic
> scenario: merge conflicts outside of the sparse-checkout cone.

...which wouldn't be a problem because these are tracked files whose
SKIP_WORKTREE bit was cleared by the merge machinery (when it marked
them as conflicted and wrote them to the working tree).

> The first patch of this series adds tests that create merge conflicts
> outside of the sparse cone and then presents different ways a user could
> resolve the situation. We want all of them to be feasible, and this
> includes:
>
>  1. Reverting the file to a known version in history.
>  2. Adding the file with its contents on disk.
>  3. Moving the file to a new location in the sparse directory.
>
> Without maintaining the behavior of adding files outside of the
> sparse-checkout cone, we risk confusing users who get into this state. The
> only workaround they would have is to modify their sparse-checkout
> definition which might lead to expanding much more data than they need to
> resolve the conflicts.
>
> For that reason, I stopped trying to limit 'git add' to be within the cone.
> I'm open to suggestions here, but we need an approach that works for
> out-of-cone conflicts.

I believe my above suggestion works for out-of-cone conflicts.  Some
important other details to keep in mind in regards to how we make add
behave:

* We don't want "git add -A [GLOB_OR_DIRECTORY]" to accidentally be
treated as a directive to remove files from the repository (and
naively noticing that SKIP_WORKTREE files are missing but attempting
to operate on them anyway would give this problematic result).
* We don't want "git rm [GLOB_OR_DIRECTORY]" to nuke SKIP_WORKTREE
files; it should only operate on files that are present.
* We need add and rm to be consistent with each other in terms of how
SKIP_WORKTREE files and the sparsity cone are treated

and more generally about not-SKIP_WORKTREE-despite-not-matching-sparsity-paths:

* These files that aren't SKIP_WORKTREE but normally would be are
prone to "disappear" at some random later time after they are made to
match the index.  The disappearing can happen either with an explicit
"git sparse-checkout reapply" (which is fine since it was explicit) or
as a side-effect of various other commands that run through
unpack_trees() since it attempts to heed the sparsity rules.  Users
tend to get confused by the latter case; they'll understand at some
point that it was because the file was outside the sparsity paths, but
the randomness in when it's pulled out as a side-effect of other
commands can be slightly jarring.  So, I'd like to avoid that where we
can easily do so, which I think the recommendation above does.  (As a
side note to these kinds of cases, maybe we want to consider having
the sparsification logic in unpack_trees() first check whether paths
being removed from the working tree and having their SKIP_WORKTREE bit
set not only match the index but also match HEAD?  That'd be a bit
more expensive to check in the sparsification paths, and I'm not sure
they all have the relevant information, but it's an idea...)

> The one place I did continue to update is 'git add --refresh ' to match the
> behavior added by mt/add-rm-in-sparse-checkout which outputs an error
> message. This happens even when the file exists in the working directory,
> but that seems appropriate enough.
>
> Thanks, -Stolee
>
> Derrick Stolee (5):
>   t1092: test merge conflicts outside cone
>   add: allow operating on a sparse-only index
>   pathspec: stop calling ensure_full_index
>   t1092: 'git add --refresh' difference with sparse-index
>   add: ignore outside the sparse-checkout in refresh()
>
>  builtin/add.c                            | 13 ++++-
>  pathspec.c                               |  2 -
>  t/t1092-sparse-checkout-compatibility.sh | 71 ++++++++++++++++++++----
>  3 files changed, 72 insertions(+), 14 deletions(-)
>
>
> base-commit: 71e301501c88399711a1bf8515d1747e92cfbb9b
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-999%2Fderrickstolee%2Fsparse-index%2Fadd-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-999/derrickstolee/sparse-index/add-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/999
> --
> gitgitgadget
