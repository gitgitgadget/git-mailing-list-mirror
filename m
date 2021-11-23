Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B04C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 19:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239946AbhKWTRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 14:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236239AbhKWTRr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 14:17:47 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FC7C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 11:14:38 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x15so96031006edv.1
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 11:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QfMagdFRFSVe0P8d3rqL3aPb+OsyRU051xp3opCnx/4=;
        b=YD7EwFHmz000nnqVsAkReyTmYrl4lq9rjwLaanqXCn169zeVefGc8Tk0EVkLKETWoG
         NlZfNZdKItaOAf56YGhG89FKJ+beE3ojYuOGLSqnvOTyyEKSJFeYl1qNNZ5b3chwQliF
         /QdE0Q2wppDdPpb6VArBHGsunZjzi+R8jM4UW01512U2vh5nd63yTwt/muTwU+0O7bn2
         ygnP7j39U/n7ULSgRNqzL/RIqmjkTuAPdDHQ4LTbGQZMRrrENfvIio1F8ZRmDG7zZfuD
         jmjIyuXKXzxtHGEYLCouxz/k5UJsq2tXhS6rHsKw4ZrNxECZcjKPUzzwJ1yEU+NH7WYp
         eZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QfMagdFRFSVe0P8d3rqL3aPb+OsyRU051xp3opCnx/4=;
        b=iXk4C1is1ajZdcLT6eAUhETrJM5qQ9Yi80AQDDUD3leP8lBeJrts9pUpQ6g+fuYoVt
         mwYJLDG71hEhoVgCeOOQwtKhuHCJRXUpdL9m8FnBnLlZ5QQ2T7lwcLqHW312I0ngCM6+
         ALngbOPjCQbjht08RTMlDFEzIMb3zNGayjb8D+fM/zkk1dCBY2fxYJVcnm6RB8kNn0Ic
         3BNmnfbc7+/nfN+EIv/l4bep62uO+ZcPYH3CmrgNJqlXw2Q1T3vALNrZD3fZvycIVRgb
         KDkWfgGw0eAoMkVgFgsDa99xPPgjfB6awhAOUB1qFFaoWNldCcqbpLWCA4Ungps+WHBO
         1u8w==
X-Gm-Message-State: AOAM533xTzcuos3YhPAkHC2Ge//rfv+q4/zLvBfIqPgTQjvtMxIuS7wi
        /fk2Rksv86cLv5WoAwJ2ij0thjYQUIyWH18pzFY=
X-Google-Smtp-Source: ABdhPJw4Om9YR+npptSNbUI/aUkQaZNUIseLi8DKjcIXIJdX+bWFenanhUbdpWvw4j5tywd96Xb89V/wJ+qegF7MQ2E=
X-Received: by 2002:a05:6402:405:: with SMTP id q5mr13059906edv.62.1637694877354;
 Tue, 23 Nov 2021 11:14:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.1084.git.1637666927224.gitgitgadget@gmail.com>
In-Reply-To: <pull.1084.git.1637666927224.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 Nov 2021 11:14:26 -0800
Message-ID: <CABPp-BGm0VtU=z0r0oGc48J020Meh_xdibnagNeDmBGQ-RVu+g@mail.gmail.com>
Subject: Re: [PATCH] fast-export: fix surprising behavior with --first-parent
To:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        William Sprent <williams@unity3d.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 23, 2021 at 5:25 AM William Sprent via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: William Sprent <williams@unity3d.com>
>
> When invoking git-fast-export with the --first-parent flag on a branch
> with merges, fast-export would early-out on processing the first merge
> on the branch. If combined with --reverse, fast-export would instead
> output all single parent commits on the branch.
>
> This commit makes fast-export output the same commits as rev-list
> --first-parent, and makes --reverse not have an effect on which commits
> are output.
>
> The fix involves removing logic within fast-export which was responsible
> for ensuring that parents are processed before their children, which was
> what was exiting early due to missing second parents. This is replaced
> by setting 'reverse =3D 1' before revision walking, which, in conjuction
> with topo_order, allows for delegating the ordering of commits to
> revision.c. The reverse flag is set after parsing rev-list arguments to
> avoid having it disabled.
>
> Signed-off-by: William Sprent <williams@unity3d.com>
> ---
>     fast-export: fix surprising behavior with --first-parent
>
>     Hi,
>
>     This is my first time patching git, so I probably need some guidance =
on
>     my approach. :)
>
>     I've noticed that git fast-export exhibits some odd behavior when pas=
sed
>     the --first-parent flag. In the repository I was working on, it would
>     only output the initial commit before exiting. Moreover, adding the
>     --reverse flag causes it to behave differently and instead output all
>     commits in the first parent line that only have one parent. My
>     expectation is more or less that git fast-export should output the sa=
me
>     set of commits as git rev-list would output given the same arguments,
>     which matches how it acts when given revision ranges.
>
>     It seems like this behavior comes from the fact that has_unshown_pare=
nts
>     will never be false for any merge commits encountered when fast-expor=
t
>     is called with --first-parent. This causes the while loop to follow t=
he
>     pattern of pushing all commits into the "commits" queue until the
>     initial commit is encountered, at which point it calls handle_tail wh=
ich
>     falls through on the first merge commit, causing most of the commits =
to
>     be unhandled.
>
>     My impression is that this logic only serves to ensure that parents a=
re
>     processed before their children, so in my patch I've opted to fix the
>     issue by delegating that responsibility to revision.c by adding the
>     reverse flag before performing the revision walk. From what I can see=
,
>     this should be equivalent to what the previous logic is trying to
>     achieve, but I can also see that there could be risk in these changes=
.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1084%2F=
williams-unity%2Ffast-export%2Ffirst-parent-issues-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1084/willi=
ams-unity/fast-export/first-parent-issues-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1084
>
>  builtin/fast-export.c  | 36 ++----------------------------------
>  t/t9350-fast-export.sh | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+), 34 deletions(-)
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 8e2caf72819..50f8c224b6e 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -107,18 +107,6 @@ static int parse_opt_reencode_mode(const struct opti=
on *opt,
>
>  static struct decoration idnums;
>  static uint32_t last_idnum;
> -
> -static int has_unshown_parent(struct commit *commit)
> -{
> -       struct commit_list *parent;
> -
> -       for (parent =3D commit->parents; parent; parent =3D parent->next)
> -               if (!(parent->item->object.flags & SHOWN) &&
> -                   !(parent->item->object.flags & UNINTERESTING))
> -                       return 1;
> -       return 0;
> -}
> -
>  struct anonymized_entry {
>         struct hashmap_entry hash;
>         const char *anon;
> @@ -752,20 +740,6 @@ static char *anonymize_tag(void *data)
>         return strbuf_detach(&out, NULL);
>  }
>
> -static void handle_tail(struct object_array *commits, struct rev_info *r=
evs,
> -                       struct string_list *paths_of_changed_objects)
> -{
> -       struct commit *commit;
> -       while (commits->nr) {
> -               commit =3D (struct commit *)object_array_pop(commits);
> -               if (has_unshown_parent(commit)) {
> -                       /* Queue again, to be handled later */
> -                       add_object_array(&commit->object, NULL, commits);
> -                       return;
> -               }
> -               handle_commit(commit, revs, paths_of_changed_objects);
> -       }
> -}
>
>  static void handle_tag(const char *name, struct tag *tag)
>  {
> @@ -1185,7 +1159,6 @@ static int parse_opt_anonymize_map(const struct opt=
ion *opt,
>  int cmd_fast_export(int argc, const char **argv, const char *prefix)
>  {
>         struct rev_info revs;
> -       struct object_array commits =3D OBJECT_ARRAY_INIT;
>         struct commit *commit;
>         char *export_filename =3D NULL,
>              *import_filename =3D NULL,
> @@ -1281,19 +1254,14 @@ int cmd_fast_export(int argc, const char **argv, =
const char *prefix)
>
>         get_tags_and_duplicates(&revs.cmdline);
>
> +       revs.reverse =3D 1;
>         if (prepare_revision_walk(&revs))
>                 die("revision walk setup failed");
>         revs.diffopt.format_callback =3D show_filemodify;
>         revs.diffopt.format_callback_data =3D &paths_of_changed_objects;
>         revs.diffopt.flags.recursive =3D 1;
>         while ((commit =3D get_revision(&revs))) {
> -               if (has_unshown_parent(commit)) {
> -                       add_object_array(&commit->object, NULL, &commits)=
;
> -               }
> -               else {
> -                       handle_commit(commit, &revs, &paths_of_changed_ob=
jects);
> -                       handle_tail(&commits, &revs, &paths_of_changed_ob=
jects);
> -               }
> +               handle_commit(commit, &revs, &paths_of_changed_objects);

Wow, interesting.  I did some related work that I never submitted at
https://github.com/newren/git/commit/08f799b4667de1c755c78e1ea1657f946b5885=
56
-- in that commit, I also noticed that fast-export did not seem
careful enough about making sure to process all commits, and came up
with a much different fix.  However, in my case, I didn't know how to
trigger the problems in fast-export without some additional changes I
was trying to make, and since I never got those other changes working,
I didn't think it was worth submitting my fix.  My solution is more
complex, in part because it was designed to handle ordering
requirements & recommendations other than just ancestry.  However, we
don't currently have any additional ordering requirements (the current
code only considers ancestry), so your solution is much simpler.  If I
do at some point get my other changes working, I'd need to
re-introduce the queue and handle_tail() and my changes to these, but
that can always be done later if and when I get those other changes
working.

Interestingly, Dscho added both the --reverse ability to revision.c
and the commits object_array and the handle_tail() stuff in
fast-export.c.  Both were done in the same year, and --reverse came
first.  See 9c5e66e97da8 (Teach revision machinery about --reverse,
2007-01-20) and f2dc849e9c5f (Add 'git fast-export', the sister of
'git fast-import', 2007-12-02).  It's not clear why revs.reverse =3D 1
wasn't used previously, although it certainly didn't occur to me
either and I think it would have been an alternative solution to my
first ever git.git contribution -- 784f8affe4df (fast-export: ensure
we traverse commits in topological order, 2009-02-10).  (Though
rev.reverse =3D 1 wouldn't have provided the same speedups that
rev.topo_order=3D1 provided.)

I can't think of any cases where this would cause any problems, and it
seems like using rev.reverse is a pretty clean solution.  Just in case
I'm missing something, though, it would be nice to get Dscho to also
comment on this.  I'm cc'ing him.

(Also, I see that =C3=86var has already provided some good feedback on the
testcase, so I'll stop here.)

>         }
>
>         handle_tags_and_duplicates(&extra_refs);
> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> index 409b48e2442..bd08101b81d 100755
> --- a/t/t9350-fast-export.sh
> +++ b/t/t9350-fast-export.sh
> @@ -750,4 +750,34 @@ test_expect_success 'merge commit gets exported with=
 --import-marks' '
>         )
>  '
>
> +
> +test_expect_success 'fast-export --first-parent outputs all revisions ou=
tput by revision walk' '
> +       git init first-parent &&
> +       cd first-parent &&
> +       test_commit init &&
> +       git checkout -b topic1 &&
> +       test_commit file2 file2.txt &&
> +       git checkout main &&
> +       git merge topic1 --no-ff &&
> +
> +       git checkout -b topic2 &&
> +       test_commit file3 file3.txt &&
> +       git checkout main &&
> +       git merge topic2 --no-ff &&
> +
> +       test_commit branch-head &&
> +
> +       git rev-list --format=3D"%ad%B" --first-parent --topo-order --no-=
commit-header main > expected &&
> +
> +       git fast-export main -- --first-parent > first-parent-export &&
> +       git fast-export main -- --first-parent --reverse > first-parent-r=
everse-export &&
> +       git init import && cd import &&
> +       cat ../first-parent-export | git fast-import &&
> +
> +       git rev-list --format=3D"%ad%B" --topo-order --all --no-commit-he=
ader > actual &&
> +       test $(git rev-list --all | wc -l) -eq 4 &&
> +       test_cmp ../expected actual &&
> +       test_cmp ../first-parent-export ../first-parent-reverse-export
> +'
> +
>  test_done
>
> base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
> --
> gitgitgadget
