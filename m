Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B8EC433EF
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 02:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240070AbhLKCQy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 21:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhLKCQy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 21:16:54 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED44C061714
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 18:13:18 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v1so35689983edx.2
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 18:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=A2uYDteFcDIQCpOhhkOoNoG+KNsv0eUvxPYw1Gy1qmU=;
        b=l/LIHe3yQ3EHVZn80s2x83Wn0UPt8ttPKGRq8lsRLoAk+JcHkHOpcs6mFnIc0VsQ4R
         LxvNad2upZ2Y9hZHM3PRjrWMimyD0h8KUvlx9cgEk2JnqIuuVkuXWjw0DY6FCrpbla99
         A+0L951fI/aG8CtYTxy9gC1IieC/cmvZoqtHtGpXgLz1iVuMVJpER/Lnba8hJzOqHJWx
         BR81RhtoQ1iwFIvj4IlQ9tNKwbCtkLk4NNupRrm0ANvUA+/lV6lNXUj1pJlsj0ClZCqI
         FrUSQh+Be9f75I8gvk50G9LGOFyonLuX1Qhe/DgvScBRKrUL0HcDbJK6Idpdjg1dGHsq
         afRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=A2uYDteFcDIQCpOhhkOoNoG+KNsv0eUvxPYw1Gy1qmU=;
        b=xJo3Wqo6OxdTaqkmW52q12eOrxukmo70KHjcDx4q73WQ9l4ohOhKmZahusfxgxY6JT
         OzS+3leMwamQtNpwS6iopnxT1lH4ZuyrqEui1P2jPgAW/FpglKHC5DOW5Lpn8EN+pJuV
         9FrRH2sCoWBgRDFpp4MuHdLEe5teBOEfENyYxsN5IEp5eqA6T0Tc3ARJ4O+S/BWgwVeY
         wbfXK8uUBXd3j/OgUw5S+Edn/+6hvM2BgClwhR87IzIXJNEuusFYqcI15Bjv2Uo92RaG
         Y+mTjwGRSDdLpBzREgJrNSCt2lNSVj94OBtAK+/3P1cqPzRZ8DR6cNzIsuGjg4cjQ6dU
         Do1g==
X-Gm-Message-State: AOAM532sUDiEXM/i4I/TnMHP1V7XInMV5WMR+IExMIxmCfbRBWqmSbbE
        2FVnRLxSPRa6dPiC+6RYLtq5DFpZ+VC5IvvzehNNtcP2YQA=
X-Google-Smtp-Source: ABdhPJzm5WAC6Us9jKDz8ABDxD9bu8ZWANzXZ3Bni5qqkik/DJkKECYSWMGjl/wZGd97X7HlQpo8hv0EYqQYlJ1rXrI=
X-Received: by 2002:a17:906:54d:: with SMTP id k13mr27242945eja.545.1639188796405;
 Fri, 10 Dec 2021 18:13:16 -0800 (PST)
MIME-Version: 1.0
References: <20210421004817.22536-1-jerry@skydio.com> <20210728032033.24233-1-jerry@skydio.com>
In-Reply-To: <20210728032033.24233-1-jerry@skydio.com>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Fri, 10 Dec 2021 18:13:05 -0800
Message-ID: <CAMKO5Cui30=sY0CUmAAUg+eyW0_BsByVK2tK9rPzaqhnW=pcwg@mail.gmail.com>
Subject: Re: [PATCH V3] git-rev-list: add --first-parent-not flag
To:     git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 8:20 PM Jerry Zhang <jerry@skydio.com> wrote:
>
> Add the --path-first-parent-not flag, which
> causes the traversal of any "not" commits
> to visit only the first parent upon encountering
> a merge commit.
>
>    -A-----E-F-G--main
>      \   / /
>       B-C-D--topic
>
> In this example, the goal is to return the
> set {B, C, D} which represents a topic
> branch that has been merged into main branch.
> `git rev-list topic ^main` will end up returning
> no commits since excluding main will end up
> traversing the commits on topic as well.
> `git rev-list --first-parent-not topic ^main`
> however will return {B, C, D} as desired.
>
> Add docs for the new flag, and clarify the
> doc for --first-parent to indicate that it
> applies to traversing the set of included
> commits only. The semantics of existing flags
> however have not changed.
>
> Signed-off-by: Jerry Zhang <jerry@skydio.com>
> ---
> V2->V3: rebase on master and rerun tests
>
> Most recent discussion was relating to the specific
> flag name. If you have a specific suggestion for
> what the name should be I'm happy to use that.
>
>  Documentation/rev-list-options.txt | 21 ++++++++++++++-------
>  blame.c                            |  2 +-
>  revision.c                         | 30 ++++++++++++++++++++----------
>  revision.h                         |  3 ++-
>  shallow.c                          |  2 +-
>  t/t6012-rev-list-simplify.sh       | 18 ++++++++++++------
>  6 files changed, 50 insertions(+), 26 deletions(-)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 24569b06d1..8e8b1e7c9b 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -122,19 +122,26 @@ again.  Equivalent forms are `--min-parents=0` (any commit has 0 or more
>  parents) and `--max-parents=-1` (negative numbers denote no upper limit).
>
>  --first-parent::
> -       Follow only the first parent commit upon seeing a merge
> -       commit.  This option can give a better overview when
> -       viewing the evolution of a particular topic branch,
> -       because merges into a topic branch tend to be only about
> -       adjusting to updated upstream from time to time, and
> -       this option allows you to ignore the individual commits
> -       brought in to your history by such a merge.
> +       When finding commits to include, follow only the first
> +       parent commit upon seeing a merge commit.  This option
> +       can give a better overview when viewing the evolution of
> +       a particular topic branch, because merges into a topic
> +       branch tend to be only about adjusting to updated upstream
> +       from time to time, and this option allows you to ignore
> +       the individual commits brought in to your history by such
> +       a merge.
>  ifdef::git-log[]
>  +
>  This option also changes default diff format for merge commits
>  to `first-parent`, see `--diff-merges=first-parent` for details.
>  endif::git-log[]
>
> +--first-parent-not::
> +       When finding commits to exclude, follow only the first
> +       parent commit upon seeing a merge commit.  This causes
> +       "not" commits to exclude only commits on that branch itself
> +       and not those brought in by a merge.
> +
>  --not::
>         Reverses the meaning of the '{caret}' prefix (or lack thereof)
>         for all following revision specifiers, up to the next `--not`.
> diff --git a/blame.c b/blame.c
> index 206c295660..083d99fdbc 100644
> --- a/blame.c
> +++ b/blame.c
> @@ -2615,7 +2615,7 @@ void assign_blame(struct blame_scoreboard *sb, int opt)
>                 else {
>                         commit->object.flags |= UNINTERESTING;
>                         if (commit->object.parsed)
> -                               mark_parents_uninteresting(commit);
> +                               mark_parents_uninteresting(sb->revs, commit);
>                 }
>                 /* treat root commit as boundary */
>                 if (!commit->parents && !sb->show_root)
> diff --git a/revision.c b/revision.c
> index cddd0542a6..60b78b4dce 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -268,7 +268,7 @@ static void commit_stack_clear(struct commit_stack *stack)
>         stack->nr = stack->alloc = 0;
>  }
>
> -static void mark_one_parent_uninteresting(struct commit *commit,
> +static void mark_one_parent_uninteresting(struct rev_info *revs, struct commit *commit,
>                                           struct commit_stack *pending)
>  {
>         struct commit_list *l;
> @@ -285,20 +285,26 @@ static void mark_one_parent_uninteresting(struct commit *commit,
>          * wasn't uninteresting), in which case we need
>          * to mark its parents recursively too..
>          */
> -       for (l = commit->parents; l; l = l->next)
> +       for (l = commit->parents; l; l = l->next) {
>                 commit_stack_push(pending, l->item);
> +               if (revs && revs->first_parent_not)
> +                       break;
> +       }
>  }
>
> -void mark_parents_uninteresting(struct commit *commit)
> +void mark_parents_uninteresting(struct rev_info *revs, struct commit *commit)
>  {
>         struct commit_stack pending = COMMIT_STACK_INIT;
>         struct commit_list *l;
>
> -       for (l = commit->parents; l; l = l->next)
> -               mark_one_parent_uninteresting(l->item, &pending);
> +       for (l = commit->parents; l; l = l->next) {
> +               mark_one_parent_uninteresting(revs, l->item, &pending);
> +               if (revs && revs->first_parent_not)
> +                       break;
> +       }
>
>         while (pending.nr > 0)
> -               mark_one_parent_uninteresting(commit_stack_pop(&pending),
> +               mark_one_parent_uninteresting(revs, commit_stack_pop(&pending),
>                                               &pending);
>
>         commit_stack_clear(&pending);
> @@ -438,7 +444,7 @@ static struct commit *handle_commit(struct rev_info *revs,
>                 if (repo_parse_commit(revs->repo, commit) < 0)
>                         die("unable to parse commit %s", name);
>                 if (flags & UNINTERESTING) {
> -                       mark_parents_uninteresting(commit);
> +                       mark_parents_uninteresting(revs, commit);
>
>                         if (!revs->topo_order || !generation_numbers_enabled(the_repository))
>                                 revs->limited = 1;
> @@ -1121,7 +1127,7 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
>                         if (repo_parse_commit_gently(revs->repo, p, 1) < 0)
>                                 continue;
>                         if (p->parents)
> -                               mark_parents_uninteresting(p);
> +                               mark_parents_uninteresting(revs, p);
>                         if (p->object.flags & SEEN)
>                                 continue;
>                         p->object.flags |= (SEEN | NOT_USER_GIVEN);
> @@ -1129,6 +1135,8 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
>                                 commit_list_insert_by_date(p, list);
>                         if (queue)
>                                 prio_queue_put(queue, p);
> +                       if (revs->first_parent_not)
> +                               break;
>                 }
>                 return 0;
>         }
> @@ -1419,7 +1427,7 @@ static int limit_list(struct rev_info *revs)
>                 if (process_parents(revs, commit, &original_list, NULL) < 0)
>                         return -1;
>                 if (obj->flags & UNINTERESTING) {
> -                       mark_parents_uninteresting(commit);
> +                       mark_parents_uninteresting(revs, commit);
>                         slop = still_interesting(original_list, date, slop, &interesting_cache);
>                         if (slop)
>                                 continue;
> @@ -2220,6 +2228,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>                 return argcount;
>         } else if (!strcmp(arg, "--first-parent")) {
>                 revs->first_parent_only = 1;
> +       } else if (!strcmp(arg, "--first-parent-not")) {
> +               revs->first_parent_not = 1;
>         } else if (!strcmp(arg, "--ancestry-path")) {
>                 revs->ancestry_path = 1;
>                 revs->simplify_history = 0;
> @@ -3347,7 +3357,7 @@ static void explore_walk_step(struct rev_info *revs)
>                 return;
>
>         if (c->object.flags & UNINTERESTING)
> -               mark_parents_uninteresting(c);
> +               mark_parents_uninteresting(revs, c);
>
>         for (p = c->parents; p; p = p->next)
>                 test_flag_and_insert(&info->explore_queue, p->item, TOPO_WALK_EXPLORED);
> diff --git a/revision.h b/revision.h
> index fbb068da9f..cec6898c2c 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -161,6 +161,7 @@ struct rev_info {
>                         bisect:1,
>                         ancestry_path:1,
>                         first_parent_only:1,
> +                       first_parent_not:1,
>                         line_level_traverse:1,
>                         tree_blobs_in_commit_order:1,
>
> @@ -404,7 +405,7 @@ const char *get_revision_mark(const struct rev_info *revs,
>  void put_revision_mark(const struct rev_info *revs,
>                        const struct commit *commit);
>
> -void mark_parents_uninteresting(struct commit *commit);
> +void mark_parents_uninteresting(struct rev_info *revs, struct commit *commit);
>  void mark_tree_uninteresting(struct repository *r, struct tree *tree);
>  void mark_trees_uninteresting_sparse(struct repository *r, struct oidset *trees);
>
> diff --git a/shallow.c b/shallow.c
> index 9ed18eb884..71e5876f37 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -603,7 +603,7 @@ static int mark_uninteresting(const char *refname, const struct object_id *oid,
>         if (!commit)
>                 return 0;
>         commit->object.flags |= UNINTERESTING;
> -       mark_parents_uninteresting(commit);
> +       mark_parents_uninteresting(NULL, commit);
>         return 0;
>  }
>
> diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
> index 4f7fa8b6c0..7da8542e58 100755
> --- a/t/t6012-rev-list-simplify.sh
> +++ b/t/t6012-rev-list-simplify.sh
> @@ -16,13 +16,12 @@ unnote () {
>  }
>
>  #
> -# Create a test repo with interesting commit graph:
> +# Create a test repo with an interesting commit graph:
>  #
> -# A--B----------G--H--I--K--L
> -#  \  \           /     /
> -#   \  \         /     /
> -#    C------E---F     J
> -#        \_/
> +# A-----B-----G--H--I--K--L
> +#  \     \      /     /
> +#   \     \    /     /
> +#    C--D--E--F     J
>  #
>  # The commits are laid out from left-to-right starting with
>  # the root commit A and terminating at the tip commit L.
> @@ -142,6 +141,13 @@ check_result 'I B A' --author-date-order -- file
>  check_result 'H' --first-parent -- another-file
>  check_result 'H' --first-parent --topo-order -- another-file
>
> +check_result 'L K I H G B A' --first-parent L
> +check_result 'F E D C' --first-parent-not F ^L
> +check_result '' F ^L
> +check_result 'L K I H G J' L ^F
> +check_result 'L K I H G B J' --first-parent-not L ^F
> +check_result 'L K I H G B' --first-parent-not --first-parent L ^F
> +
>  check_result 'E C B A' --full-history E -- lost
>  test_expect_success 'full history simplification without parent' '
>         printf "%s\n" E C B A >expect &&
> --
> 2.32.0.1314.g6ed4fcc4cc
>
Any updates on this patch? This is used in our automatic base
branch detection logic, which aims to find the original branch the
user branched off of, regardless of however many branches they
may have merged in since. There is no other way to achieve this
functionality with git so far.
