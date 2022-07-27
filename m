Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F356C00144
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 01:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240118AbiG0BNc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 21:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240104AbiG0BNb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 21:13:31 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262F3357FC
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 18:13:30 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id e5so11731600qts.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 18:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ir5ErVpPL5rxYMAokoBToAngmz9UH93rNZq+8kagdlc=;
        b=bVjpTrcC0IwEYZfASr2XHn52+4AFhcgKvcujPG/F1TQATcVojhWPGJOvbg1Ypw8uet
         oB0GRix713A6mI9t5xKNpcpwruslxoO6IlzOuSQq1Os2T8Pg9IBG1hR8RCn5iZKooZaM
         qnZFNO3NxldTi1KGNRLNwy8hyQjEuVVDBQ+vPD6E55ImuaDFmQaJ0kA5utUINS39Gil8
         4Z+Afusx6r1tzYTs0o3IT217vdUXlcWgZUHJqzdQW/L0/uCrVpcH+U0Y5v2SKRAAov5l
         Bhvx0SZPCJwKgROMI7vQXuxukAlB0jPLaXstZUTXDWWeOB6gKOPEjNvsJSWnUUGDm7gx
         0ZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ir5ErVpPL5rxYMAokoBToAngmz9UH93rNZq+8kagdlc=;
        b=Y34Quvf1oOyCfcRePT677N7sjJcNA0fLzp44N7I5jHU2wy4f0yYq0hMVF+5cKWN+Y4
         6mqF983dGdG2CdXiC9JNnrUMyROQ5+ocvVpGI8jiIdNwbd3eD75xnhFuZW0/UT+KIg6P
         DRaraeiiIE40RSTvZOWf6sWXrNpJzzp5Dbv5YmwE0wlcVtfKKFOg/wiHTlvqRnYPkTSN
         aUrk67nIAPEQyvJLzPrGrVHZJzR2iy5rZjL+UcdtCF6997e/ah/aIlccJYlMjKn1hDnh
         aqZV+EFpR6wC2H36Lw185lK/YseVlnacNZPQdKXg8PYwpt1DjKY0OqSHajZ4jsLt42FL
         k/XA==
X-Gm-Message-State: AJIora/5g4KkHJ8BSfI/ubLRB460gYHUzl9hOnkz9e3Hl4hv6HvVlhcA
        IYrE9bV9Qg8654Lk1lJi3NtA4hIfXtVVw4A7b9g=
X-Google-Smtp-Source: AGRyM1vWGAnAYSaZ3l9CZCfzxapHEAL5em+1XUDLjjkMi7dBdUCjzEvW535p3vdhM5hrFnQ7XLvCDzLix3bHh2M55nc=
X-Received: by 2002:a05:622a:1391:b0:31e:f6b2:d3aa with SMTP id
 o17-20020a05622a139100b0031ef6b2d3aamr16425467qtk.523.1658884409072; Tue, 26
 Jul 2022 18:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220718214349.3379328-1-calvinwan@google.com> <20220726210020.3397249-1-calvinwan@google.com>
In-Reply-To: <20220726210020.3397249-1-calvinwan@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 26 Jul 2022 18:13:17 -0700
Message-ID: <CABPp-BGvDLvmj720PFzsjrZrYuYauprL6JeOQhiQ4BjtfjF7Dg@mail.gmail.com>
Subject: Re: [PATCH v6] submodule merge: update conflict error message
To:     Calvin Wan <calvinwan@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 26, 2022 at 2:00 PM Calvin Wan <calvinwan@google.com> wrote:
>
> When attempting to merge in a superproject with conflicting submodule
> pointers that cannot be fast-forwarded or trivially resolved, the merge
> fails and git prints an error message that accurately describes the

micro nit: s/git/Git/  (feel free to ignore since you're already at v6)

> failure, but does not provide steps for the user to resolve the error.
>
> Git is left in a conflicted state, which requires the user to:
>  1. merge submodules or update submodules to an already existing
>         commit that reflects the merge
>  2. add submodules changes to the superproject
>  3. finish merging superproject
> These steps are non-obvious for newer submodule users to figure out
> based on the error message and neither `git submodule status` nor `git
> status` provide any useful pointers.
>
> Update error message to provide steps to resolve submodule merge
> conflict. Future work could involve adding an advice flag to the
> message. Although the message is long, it also has the id of the
> commit that needs to be merged, which could be useful information
> for the user.

Well explained.  One very minor suggestion: perhaps change "id of the
commit" to "id of the submodule commit" just to make it slightly
clearer that this information would take work for the user to discover
on their own?  (When I first read it, I was thinking, "but they have
the commit, it's what they passed to merge", before I realized my
error.)

> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>
> I'm a little unsure on the code style for the `git add` section of
> the error message. It works, but is tricky for a code reviewer
> to decipher the formatting. I don't think it should affect
> translation since the text is only a git command and folder names.
>
> Changes since v5:
>  - Fixed memory leak reported by =C3=86var
>  - Fixed error message formatting and addded TRANSLATOR tags
>  - Removed "resolution exists"
>
>  merge-ort.c                 | 61 +++++++++++++++++++++++++++++++++++++
>  t/t6437-submodule-merge.sh  | 38 +++++++++++++++++++----
>  t/t7402-submodule-rebase.sh |  9 ++++--
>  3 files changed, 100 insertions(+), 8 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 01f150ef3b..147be0ce31 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -387,6 +387,9 @@ struct merge_options_internal {
>
>         /* call_depth: recursion level counter for merging merge bases */
>         int call_depth;
> +
> +       /* field that holds submodule conflict information */
> +       struct string_list conflicted_submodules;
>  };
>
>  struct version_info {
> @@ -686,6 +689,8 @@ static void clear_or_reinit_internal_opts(struct merg=
e_options_internal *opti,
>
>         mem_pool_discard(&opti->pool, 0);
>
> +       string_list_clear(&opti->conflicted_submodules, 1);
> +
>         /* Clean out callback_data as well. */
>         FREE_AND_NULL(renames->callback_data);
>         renames->callback_data_nr =3D renames->callback_data_alloc =3D 0;
> @@ -1849,6 +1854,17 @@ static int merge_submodule(struct merge_options *o=
pt,

Sorry for not catching this in an earlier round, but merge_submodule()
has four "return 0" cases, for particular types of conflicts.  Those
should probably be switched to "goto cleanup" or something like that,
so that these messages you are adding are also provided if one of
those conflict cases are hit.

>         object_array_clear(&merges);
>  cleanup:
> +       if (!ret) {

And here's another item I have to apologize for not catching in an
earlier round.  We should also require !opt->priv->call_depth as well
in this if-condition.  If merging of merge bases produced a submodule
conflict, but the outer merge involves two sides that resolved the
inner conflict the exact same way, then there's no conflict at the
outer level and nothing for the user to resolve.  If users don't have
any conflicts to resolve, we don't want to print messages telling them
how to resolve their non-existent conflicts.  And if there is still a
conflict in the submodule for the outer merge as well as in the
recursive merge(s), we don't want to list the module twice (or more)
when we tell the user to fix conflicts in their submodules (especially
since that means we'd be telling them to merge multiple different
commits for the single submodule, which could get confusing).

> +               struct string_list *csub =3D &opt->priv->conflicted_submo=
dules;
> +               char *util;
> +               const char *abbrev;
> +
> +               abbrev =3D repo_find_unique_abbrev(&subrepo, b, DEFAULT_A=
BBREV);
> +               util =3D xstrdup(abbrev);
> +
> +               string_list_append(csub, path)->util =3D util;
> +       }
> +
>         repo_clear(&subrepo);
>         return ret;
>  }
> @@ -4412,6 +4428,47 @@ static int record_conflicted_index_entries(struct =
merge_options *opt)
>         return errs;
>  }
>
> +static void print_submodule_conflict_suggestion(struct string_list *csub=
) {
> +       int first =3D 1;
> +       if (csub->nr > 0) {
> +               struct string_list_item *item;
> +               printf(_("Recursive merging with submodules currently onl=
y supports trivial cases.\n"
> +                       "Please manually handle the merging of each confl=
icted submodule.\n"
> +                       "This can be accomplished with the following step=
s:\n"));
> +
> +               for_each_string_list_item(item, csub) {
> +            const char *abbrev=3D item->util;

Messed up indent here?

> +                       /*
> +                        * TRANSLATORS: This is a line of advice to resol=
ve a merge conflict
> +                        * in a submodule. The second argument is the abb=
reviated id of the
> +                        * commit that needs to be merged.
> +                        * E.g. - go to submodule (sub), and either merge=
 commit abc1234"
> +                        */
> +                       printf(_(" - go to submodule (%s), and either mer=
ge commit %s\n"
> +                                   "   or update to an existing commit w=
hich has merged those changes\n"),

Indent may be wrong here too, at least if you're trying to get the
leftmost quote marks to align.  (Maybe the non-alignment was
intentional, it was just unclear because of the earlier strange
indent.)

> +                                       item->string, abbrev);
> +               }
> +               printf(_(" - come back to superproject and run:\n\n"));
> +               for_each_string_list_item(item, csub)
> +                       /*
> +                        * TRANSLATORS: This is a line of a recommended `=
git add` command
> +                        * with multiple lines of submodule folders.
> +                        * E.g.:     git add sub \
> +                        *                   sub2 \
> +                        *                   sub3

Why does such a message need to be translated?  It's literal text the
user should type, right?  I'm not sure what a translator would do with
the message other than regurgitate it.

> +                        */
> +                       if (first) {
> +                               printf("       git add %s", item->string)=
;

But if you did mean for there to be a translation and a TRANSLATORS
note, then did you forget to translate it by calling _()?

> +                               first =3D 0;
> +                       } else {
> +                               printf(" \\\n               %s", item->st=
ring);
> +                       }

Can we put braces around this for_each_string_list_item() block?  Or,
as an alternative to the whole block, do you want to consider:

   strub strbuf tmp =3D STRBUF_INIT;
   strbuf_add_separated_string_list(&tmp, ' ', csub);
   printf(_("    git add %s"), tmp.buf);   /* or maybe remove the
translation; not sure what the point is */
   strbuf_release(&tmp);

?  It is likely easier to copy & paste, and might be understood by
more users (I'm not sure how many are aware that command lines can use
backslashes for line continuation), but on the negative side, if you
have a lot of submodules it might make it harder to read.  Even if you
don't like space separated, though, you could still use this strategy
by changing the second line to

    strbuf_add_separated_string_list(&tmp, " \\\n               ", csub);

> +               printf(_("\n\n   to record the above merge or update\n"
> +                       " - resolve any other conflicts in the superproje=
ct\n"
> +                       " - commit the resulting index in the superprojec=
t\n"));
> +       }
> +}
> +
>  void merge_display_update_messages(struct merge_options *opt,
>                                    int detailed,
>                                    struct merge_result *result)
> @@ -4461,6 +4518,9 @@ void merge_display_update_messages(struct merge_opt=
ions *opt,
>         }
>         string_list_clear(&olist, 0);
>
> +       print_submodule_conflict_suggestion(&opti->conflicted_submodules)=
;
> +       string_list_clear(&opti->conflicted_submodules, 1);
> +

It would be more consistent to have things allocated in merge_start()
continue to be cleared out in clear_or_reinit_internal_opts().  This
kind of breaks that pairing, and you're already making sure to clear
it there, so I'd rather remove this duplicate string_list_clear()
call.

>         /* Also include needed rename limit adjustment now */
>         diff_warn_rename_limit("merge.renamelimit",
>                                opti->renames.needed_limit, 0);
> @@ -4657,6 +4717,7 @@ static void merge_start(struct merge_options *opt, =
struct merge_result *result)
>         trace2_region_enter("merge", "allocate/init", opt->repo);
>         if (opt->priv) {
>                 clear_or_reinit_internal_opts(opt->priv, 1);
> +               string_list_init_dup(&opt->priv->conflicted_submodules);

This works, but there is a minor optimization available here if you're
interested (I understand if you're not since you're already at v6).
Assuming you make the important opt->priv->call_depth fix, you can
replace string_list_init_dup() with string_list_init_nodup() here.
The paths aren't freed until clear_or_reinit_internal_opts() which
(under the assumption previously stated) isn't called until
merge_finalize(), which comes after the call to
merge_display_update_messages(), which is where you use the data.

(As repository paths are used all over merge-ort.c, the optimization
to store them in one place (opt->priv->paths) and avoid duplicating
them is used pretty heavily.  It's more important for a lot of the
other strmaps since they'll have a lot more paths in them, but it is
kind of nice to use this optimization where possible.)

>                 trace2_region_leave("merge", "allocate/init", opt->repo);
>                 return;
>         }
> diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
> index c253bf759a..84913525cf 100755
> --- a/t/t6437-submodule-merge.sh
> +++ b/t/t6437-submodule-merge.sh
> @@ -103,8 +103,25 @@ test_expect_success 'setup for merge search' '
>          echo "file-c" > file-c &&
>          git add file-c &&
>          git commit -m "sub-c") &&
> -       git commit -a -m "c" &&
> +       git commit -a -m "c")
> +'
>
> +test_expect_success 'merging should conflict for non fast-forward' '
> +       test_when_finished "git -C merge-search reset --hard" &&
> +       (cd merge-search &&
> +        git checkout -b test-nonforward-a b &&
> +         if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
> +         then
> +               test_must_fail git merge c >actual &&
> +               sub_expect=3D"go to submodule (sub), and either merge com=
mit $(git -C sub rev-parse --short sub-c)" &&
> +               grep "$sub_expect" actual
> +         else
> +               test_must_fail git merge c 2> actual
> +         fi)
> +'
> +
> +test_expect_success 'finish setup for merge-search' '
> +       (cd merge-search &&
>         git checkout -b d a &&
>         (cd sub &&
>          git checkout -b sub-d sub-b &&
> @@ -129,14 +146,16 @@ test_expect_success 'merge with one side as a fast-=
forward of the other' '
>          test_cmp expect actual)
>  '
>
> -test_expect_success 'merging should conflict for non fast-forward' '
> +test_expect_success 'merging should conflict for non fast-forward (resol=
ution exists)' '
>         (cd merge-search &&
> -        git checkout -b test-nonforward b &&
> +        git checkout -b test-nonforward-b b &&
>          (cd sub &&
>           git rev-parse --short sub-d > ../expect) &&
>           if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
>           then
> -               test_must_fail git merge c >actual
> +               test_must_fail git merge c >actual &&
> +               sub_expect=3D"go to submodule (sub), and either merge com=
mit $(git -C sub rev-parse --short sub-c)" &&
> +               grep "$sub_expect" actual
>           else
>                 test_must_fail git merge c 2> actual
>           fi &&
> @@ -161,7 +180,9 @@ test_expect_success 'merging should fail for ambiguou=
s common parent' '
>          ) &&
>          if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
>          then
> -               test_must_fail git merge c >actual
> +               test_must_fail git merge c >actual &&
> +               sub_expect=3D"go to submodule (sub), and either merge com=
mit $(git -C sub rev-parse --short sub-c)" &&
> +               grep "$sub_expect" actual
>          else
>                 test_must_fail git merge c 2> actual
>          fi &&
> @@ -205,7 +226,12 @@ test_expect_success 'merging should fail for changes=
 that are backwards' '
>         git commit -a -m "f" &&
>
>         git checkout -b test-backward e &&
> -       test_must_fail git merge f)
> +       test_must_fail git merge f >actual &&
> +       if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
> +    then
> +               sub_expect=3D"go to submodule (sub), and either merge com=
mit $(git -C sub rev-parse --short sub-d)" &&
> +               grep "$sub_expect" actual
> +       fi)
>  '
>
>
> diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
> index 8e32f19007..ebeca12a71 100755
> --- a/t/t7402-submodule-rebase.sh
> +++ b/t/t7402-submodule-rebase.sh
> @@ -104,7 +104,7 @@ test_expect_success 'rebasing submodule that should c=
onflict' '
>         test_tick &&
>         git commit -m fourth &&
>
> -       test_must_fail git rebase --onto HEAD^^ HEAD^ HEAD^0 &&
> +       test_must_fail git rebase --onto HEAD^^ HEAD^ HEAD^0 >actual_outp=
ut &&
>         git ls-files -s submodule >actual &&
>         (
>                 cd submodule &&
> @@ -112,7 +112,12 @@ test_expect_success 'rebasing submodule that should =
conflict' '
>                 echo "160000 $(git rev-parse HEAD^^) 2  submodule" &&
>                 echo "160000 $(git rev-parse HEAD) 3    submodule"
>         ) >expect &&
> -       test_cmp expect actual
> +       test_cmp expect actual &&
> +       if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
> +    then
> +               sub_expect=3D"go to submodule (submodule), and either mer=
ge commit $(git -C submodule rev-parse --short HEAD^0)" &&
> +               grep "$sub_expect" actual_output
> +       fi
>  '
>
>  test_done
>
> base-commit: 9dd64cb4d310986dd7b8ca7fff92f9b61e0bd21a
> --
> 2.37.1.359.gd136c6c3e2-goog
