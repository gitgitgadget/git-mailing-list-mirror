Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B2EC00140
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 00:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbiG2AYv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 20:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiG2AYu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 20:24:50 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABD17B1DC
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 17:24:48 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id e16so2654800qka.5
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 17:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UuqSqaDy+dJMkE1pkLMtmBJYjRh8B5MpMFOzcKpwLnI=;
        b=XjNhWmh+iOdWwSxxj/hi5DAomMvMUZDDr6nhyfQV8nGdM0bBa00qA5CwiBo2jPWoZ1
         8xZT9gjoFi/a2E/km5G/pH1P/XL7S8E8aPecH6e6QvEAV+JMzQQOngcoajxs9dmXhEwx
         KEEXDTa94O9BRtb1rh/ppQD6HMJ5VP4/FgoQ8h42fmMqQs8M/Z/aCuktvnIBf6j36OFm
         LYVQewYyxf1BQ8ACj2uS2Joe698dLGRr1irg7lgIv7hRufAsToFald9S0533p+a7qv0K
         wbhpsqU3kfg7MgJX1JRjs4e4GuMShT/DR+FMf0RPDwvfsKZ9Eop53oYiozH2OVfvg79a
         5XuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UuqSqaDy+dJMkE1pkLMtmBJYjRh8B5MpMFOzcKpwLnI=;
        b=vVmIejII93uZ9pFXA5Zk5eBODIb4bg5C9qfAH/6dje77SRCgCTJdXWkm1n7oMdOKpm
         u3A7uo6C1UW2hJgiA9BBRMPH+6olWNGr8KF4ohfx0OabfxHG6S+k3nsZlQiAP7GvwN5F
         NbeBMeORgYcSVEtVMwZB3xEHlpREPonL++XOqAsab9d/iw7T5EcDKhzLdOPlO0lod2v4
         JxeiKh1DPhR7ju/3lGGk3sfLZmPAvuOsg+b5e5xoiJ4lFAecrZsx/Pcd9UELCSG1B+yw
         kMyqAkJ0fmA+U/ieTWAqYxH3X5HqOL7zYKrSJeAUtWVN4eI506w7y+z3APK48f9zqMUl
         UbpQ==
X-Gm-Message-State: AJIora9gHi1AB2R0TW22O/bX9ThRX+daQoFHXDAz/hOOGs7/hBMdb2fG
        iSfO5Qiixn9tUrkoAV24uGiKbmwu21K32/U5iyA=
X-Google-Smtp-Source: AGRyM1uW3xphtwR4oyHrKjhe7Xty4yUnDA1DkiDSs1WSEVnxG8OkJUQrbhFyaua30cndZFPH5aoMuYmPO/QaPfYUkog=
X-Received: by 2002:a05:620a:754:b0:6b5:eb92:42e5 with SMTP id
 i20-20020a05620a075400b006b5eb9242e5mr1066754qki.183.1659054287357; Thu, 28
 Jul 2022 17:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220726210020.3397249-1-calvinwan@google.com> <20220728211221.2913928-1-calvinwan@google.com>
In-Reply-To: <20220728211221.2913928-1-calvinwan@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 28 Jul 2022 17:24:35 -0700
Message-ID: <CABPp-BE9hdzn_8fqSa-JYXS14xbXDEvKi=yupvWDFAUnALhD9A@mail.gmail.com>
Subject: Re: [PATCH v7] submodule merge: update conflict error message
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

On Thu, Jul 28, 2022 at 2:12 PM Calvin Wan <calvinwan@google.com> wrote:
>
> When attempting to merge in a superproject with conflicting submodule
> pointers that cannot be fast-forwarded or trivially resolved, the merge
> fails and Git prints an error message that accurately describes the
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
> submodule commit that needs to be merged, which could be useful
> information for the user.
>
> Additionally, 4 merge failures that resulted in an early return have
> been updated to reflect the status of the merge.
> 1. Null merge base (null o): CONFLICT_SUBMODULE_NULL_MERGE_BASE added
>    as a new conflict type and will print updated error message.
> 2. Null merge side a (null a): BUG(). See [1] for discussion
> 3. Null merge side b (null b): BUG(). See [1] for discussion
> 4. Submodule not checked out: Still returns early, but added a
>    NEEDSWORK bit since current error message does not reflect the
>    correct resolution

s/does not reflect the correct resolution/also deserves a more
detailed explanation of how to resolve/ ?

>
> [1] https://lore.kernel.org/git/CABPp-BE0qGwUy80dmVszkJQ+tcpfLRW0OZyErymz=
hZ9+HWY1mw@mail.gmail.com/
>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>
> For Elijah: Cleaned up the small nits and updated resolutions for
> those 4 cases we discussed.

Thanks.  Including a range-diff in the cover letter would be really
helpful, for future reference.

>
> For =C3=86var: Apologies for misunderstanding your suggestions to make
> my messages easier for translators to work with. I have reformatted
> all of the messages to separate text vs formatting translations. Let
> me know if this is what you were expecting.
>
>  merge-ort.c                 | 112 ++++++++++++++++++++++++++++++++++--
>  t/t6437-submodule-merge.sh  |  78 +++++++++++++++++++++++--
>  t/t7402-submodule-rebase.sh |   9 ++-
>  3 files changed, 185 insertions(+), 14 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 01f150ef3b..4302e900ee 100644
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
> @@ -517,6 +520,7 @@ enum conflict_and_info_types {
>         CONFLICT_SUBMODULE_NOT_INITIALIZED,
>         CONFLICT_SUBMODULE_HISTORY_NOT_AVAILABLE,
>         CONFLICT_SUBMODULE_MAY_HAVE_REWINDS,
> +       CONFLICT_SUBMODULE_NULL_MERGE_BASE,
>
>         /* Keep this entry _last_ in the list */
>         NB_CONFLICT_TYPES,
> @@ -570,6 +574,8 @@ static const char *type_short_descriptions[] =3D {
>                 "CONFLICT (submodule history not available)",
>         [CONFLICT_SUBMODULE_MAY_HAVE_REWINDS] =3D
>                 "CONFLICT (submodule may have rewinds)",
> +       [CONFLICT_SUBMODULE_NULL_MERGE_BASE] =3D
> +               "CONFLICT (submodule no merge base)"
>  };
>
>  struct logical_conflict_info {
> @@ -686,6 +692,8 @@ static void clear_or_reinit_internal_opts(struct merg=
e_options_internal *opti,
>
>         mem_pool_discard(&opti->pool, 0);
>
> +       string_list_clear(&opti->conflicted_submodules, 1);
> +
>         /* Clean out callback_data as well. */
>         FREE_AND_NULL(renames->callback_data);
>         renames->callback_data_nr =3D renames->callback_data_alloc =3D 0;
> @@ -1744,26 +1752,40 @@ static int merge_submodule(struct merge_options *=
opt,
>
>         int i;
>         int search =3D !opt->priv->call_depth;
> +       int sub_initialized =3D 1;
>
>         /* store fallback answer in result in case we fail */
>         oidcpy(result, opt->priv->call_depth ? o : a);
>
>         /* we can not handle deletion conflicts */
> -       if (is_null_oid(o))
> -               return 0;
>         if (is_null_oid(a))
> -               return 0;
> +               BUG("submodule deleted on one side; this should be handle=
d outside of merge_submodule()");
>         if (is_null_oid(b))
> -               return 0;
> +               BUG("submodule deleted on one side; this should be handle=
d outside of merge_submodule()");
>
> -       if (repo_submodule_init(&subrepo, opt->repo, path, null_oid())) {
> +       if ((sub_initialized =3D repo_submodule_init(&subrepo,
> +                                                                       o=
pt->repo, path, null_oid()))) {

Um, repo_submodule_init() returns 0 on success, non-zero upon failure.
So !sub_initialized means "submodule IS initialized", though it
appears to read to mean the opposite.  Can you consider renaming your
variable (maybe just to "sub_not_initialized")?

>                 path_msg(opt, CONFLICT_SUBMODULE_NOT_INITIALIZED, 0,
>                          path, NULL, NULL, NULL,
>                          _("Failed to merge submodule %s (not checked out=
)"),
>                          path);
> +               /*
> +                * NEEDSWORK: Since the steps to resolve this error are
> +                * more involved than what is currently in
> +                * print_submodule_conflict_suggestion(), we return
> +                * immediately rather than generating an error message
> +                */

Technically, we just did generate an error message ("Failed to merge
submodule %s (not checked out)").

Maybe replace "immediately rather than generating an error message"
with "immediately.  It would be better to "goto cleanup" here, after
setting some flag requesting a more detailed message be saved for
print_submodule_conflict_suggetion()".  Or something like that.

>                 return 0;
>         }
>
> +       if (is_null_oid(o)) {
> +               path_msg(opt, CONFLICT_SUBMODULE_NULL_MERGE_BASE, 0,
> +                        path, NULL, NULL, NULL,
> +                        _("Failed to merge submodule %s (no merge base)"=
),
> +                        path);
> +               goto cleanup;
> +       }

Does this need to be moved after initializing the submodule?  I
thought that was the point of introducing the sub_initialized
variable, and we're clearly not going to use it, so it would seem to
make more sense to not initialize it for this case.

> +
>         if (!(commit_o =3D lookup_commit_reference(&subrepo, o)) ||
>             !(commit_a =3D lookup_commit_reference(&subrepo, a)) ||
>             !(commit_b =3D lookup_commit_reference(&subrepo, b))) {
> @@ -1849,7 +1871,15 @@ static int merge_submodule(struct merge_options *o=
pt,
>
>         object_array_clear(&merges);
>  cleanup:
> -       repo_clear(&subrepo);
> +       if (!opt->priv->call_depth && !ret) {
> +               struct string_list *csub =3D &opt->priv->conflicted_submo=
dules;
> +
> +               string_list_append(csub, path)->util =3D
> +                               xstrdup(repo_find_unique_abbrev(&subrepo,=
 b, DEFAULT_ABBREV));
> +       }
> +
> +       if (!sub_initialized)
> +               repo_clear(&subrepo);
>         return ret;
>  }
>
> @@ -4412,6 +4442,73 @@ static int record_conflicted_index_entries(struct =
merge_options *opt)
>         return errs;
>  }
>
> +static void print_submodule_conflict_suggestion(struct string_list *csub=
) {
> +       if (csub->nr > 0) {
> +               struct string_list_item *item;
> +               struct strbuf msg =3D STRBUF_INIT;
> +               struct strbuf tmp =3D STRBUF_INIT;
> +
> +               strbuf_addf(&tmp, _("Recursive merging with submodules cu=
rrently only supports trivial cases."));
> +               strbuf_addf(&msg, "%s\n", tmp.buf);
> +               strbuf_release(&tmp);

Instead of these three lines, why not just
    strbuf_addstr(&msg, "%s\n", _("Recursive merging with submodules
currently only supports trivial cases."));
?

Same applies for some of the messages below too.

> +               strbuf_addf(&tmp, _("Please manually handle the merging o=
f each conflicted submodule."));
> +               strbuf_addf(&msg, "%s\n", tmp.buf);
> +               strbuf_release(&tmp);
> +
> +               strbuf_addf(&tmp, _("This can be accomplished with the fo=
llowing steps:"));
> +               strbuf_addf(&msg, "%s\n", tmp.buf);
> +               strbuf_release(&tmp);
> +
> +               for_each_string_list_item(item, csub) {
> +                       const char *abbrev=3D item->util;
> +                       /*
> +                        * TRANSLATORS: This is a line of advice to resol=
ve a merge conflict
> +                        * in a submodule. The second argument is the abb=
reviated id of the
> +                        * commit that needs to be merged.
> +                        * E.g. - go to submodule (sub), and either merge=
 commit abc1234"
> +                        */
> +                       strbuf_addf(&tmp, _("go to submodule (%s), and ei=
ther merge commit %s"),
> +                                                                        =
                               item->string, abbrev);
> +                       strbuf_addf(&msg, _(" - %s"), tmp.buf);
> +                       strbuf_addf(&msg, "\n");
> +                       strbuf_release(&tmp);
> +                       strbuf_addf(&tmp, _("or update to an existing com=
mit which has merged those changes"));
> +                       strbuf_addf(&msg, _("   %s"), tmp.buf);
> +                       strbuf_addf(&msg, "\n");
> +                       strbuf_release(&tmp);
> +               }
> +               strbuf_addf(&tmp, _("come back to superproject and run:")=
);
> +               strbuf_addf(&msg, _(" - %s"), tmp.buf);
> +               strbuf_addf(&msg, "\n\n");
> +               strbuf_release(&tmp);
> +
> +               strbuf_addf(&tmp, "git add ");
> +               strbuf_add_separated_string_list(&tmp, " ", csub);
> +               strbuf_addf(&msg, _("       %s"), tmp.buf);
> +               strbuf_addf(&msg, "\n\n");
> +               strbuf_release(&tmp);
> +
> +               strbuf_addf(&tmp, _("to record the above merge or update"=
));
> +               strbuf_addf(&msg, _("   %s"), tmp.buf);
> +               strbuf_addf(&msg, "\n");
> +               strbuf_release(&tmp);
> +
> +               strbuf_addf(&tmp, _("resolve any other conflicts in the s=
uperproject"));
> +               strbuf_addf(&msg, _(" - %s"), tmp.buf);
> +               strbuf_addf(&msg, "\n");
> +               strbuf_release(&tmp);
> +
> +               strbuf_addf(&tmp, _("commit the resulting index in the su=
perproject"));
> +               strbuf_addf(&msg, _(" - %s"), tmp.buf);
> +               strbuf_addf(&msg, "\n");
> +               strbuf_release(&tmp);
> +
> +               printf("%s", msg.buf);
> +               strbuf_release(&msg);

Yuck.  I'm not a translator, so maybe what you are doing is preferred.
But wouldn't translators find it annoying to have to translate " - %s"
and "  %s" in all these places (and wouldn't there need to be a
TRANSLATORS comment before each and every one)?  Also, are we running
the risk of these short strings needing to be translated differently
here than in other places?  For example, what if someone is trying to
align output nicely:

    Name:   John Johnson
    Date:   2022-07-28
    Gender: Male

and uses _("  %s") when printing the name to get the indent right, and
expects other languages to add or remove spaces accordingly?  Or has
other built up messages without hyphens but uses _("  %s") for
whatever reason that may not match what you are doing here?

If there are multiple _("  %s") in the code, that string can only be
translated once.  Not once per codepath, but once total.  I'm afraid
this lego building of messages seems to risk needing
translation-per-codepath when that just isn't possible.

I also find the big block of code somewhat painful to read.  Could we
instead do something like (note, I have both a tmp and tmp2):

    strbuf_add_separated_string_list(&tmp2, " ", csub);

    for_each_string_list_item(item, csub) {
        const char *abbrev=3D item->util;
        /*
         * TRANSLATORS: This is a line of advice to resolve a merge conflic=
t
         * in a submodule. The second argument is the abbreviated id of the
         * commit that needs to be merged.
         * E.g. - go to submodule (sub), and either merge commit abc1234
         */
        strbuf_addf(&tmp, _(" - go to submodule %s, and either merge
commit %s\n"
                            "   or update to an existing commit which
has merged those changes\n"),
                            item->string, abbrev);
    }

    strbuf_addf(&msg,
                _("Recursive merging with submodules currently only
supports trivial cases.\n"
                  "Please manually handle the merging of each
conflicted submodule.\n"
                  "This can be accomplished with the following steps:\n"
                  "%s"
                  " - come back to superproject and run:\n\n"
                  "      git add %s\n\n"
                  "   to record the above merge or update\n"
                  " - resolve any other conflicts in the superproject\n"
                  " - commit the resulting index in the superproject\n"),
                  tmp.buf, tmp2.buf);

This will give translators precisely two messages to translate (and we
can't drop it to one since one of the two is repeated a variable
number of times), and provide more built-in context about how to
translate since the whole message is involved.  If one of the messages
translates into something especially long, they can even add line
breaks and reflow the paragraph in ways that make sense for them,
which your current version just doesn't permit.


> +       }
> +}
> +
>  void merge_display_update_messages(struct merge_options *opt,
>                                    int detailed,
>                                    struct merge_result *result)
> @@ -4461,6 +4558,8 @@ void merge_display_update_messages(struct merge_opt=
ions *opt,
>         }
>         string_list_clear(&olist, 0);
>
> +       print_submodule_conflict_suggestion(&opti->conflicted_submodules)=
;
> +
>         /* Also include needed rename limit adjustment now */
>         diff_warn_rename_limit("merge.renamelimit",
>                                opti->renames.needed_limit, 0);
> @@ -4657,6 +4756,7 @@ static void merge_start(struct merge_options *opt, =
struct merge_result *result)
>         trace2_region_enter("merge", "allocate/init", opt->repo);
>         if (opt->priv) {
>                 clear_or_reinit_internal_opts(opt->priv, 1);
> +               string_list_init_nodup(&opt->priv->conflicted_submodules)=
;
>                 trace2_region_leave("merge", "allocate/init", opt->repo);
>                 return;
>         }
> diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
> index c253bf759a..414597a420 100755
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
> @@ -476,4 +502,44 @@ test_expect_failure 'directory/submodule conflict; m=
erge --abort works afterward
>         )
>  '
>
> +# Setup:
> +#   - Submodule has 2 commits: a and b
> +#   - Superproject branch 'a' adds and commits submodule pointing to 'co=
mmit a'
> +#   - Superproject branch 'b' adds and commits submodule pointing to 'co=
mmit b'
> +# If these two branches are now merged, there is no merge base
> +test_expect_success 'setup for null merge base' '
> +       mkdir no-merge-base &&
> +       (cd no-merge-base &&
> +       git init &&
> +       mkdir sub &&
> +       (cd sub &&
> +        git init &&
> +        echo "file-a" > file-a &&
> +        git add file-a &&
> +        git commit -m "commit a") &&
> +       git commit --allow-empty -m init &&
> +       git branch init &&
> +       git checkout -b a init &&
> +       git add sub &&
> +       git commit -m "a" &&
> +       git switch main &&
> +       (cd sub &&
> +        echo "file-b" > file-b &&
> +        git add file-b &&
> +        git commit -m "commit b"))
> +'
> +
> +test_expect_success 'merging should fail with no merge base' '
> +       (cd no-merge-base &&
> +       git checkout -b b init &&
> +       git add sub &&
> +       git commit -m "b" &&
> +       test_must_fail git merge a >actual &&
> +       if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
> +    then
> +               sub_expect=3D"go to submodule (sub), and either merge com=
mit $(git -C sub rev-parse --short HEAD^1)" &&
> +               grep "$sub_expect" actual
> +       fi)
> +'
> +
>  test_done
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
> 2.37.1.455.g008518b4e5-goog
>
