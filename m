Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E6AC433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 01:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbiFMByb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jun 2022 21:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiFMBy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jun 2022 21:54:28 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C30065A7
        for <git@vger.kernel.org>; Sun, 12 Jun 2022 18:54:27 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id s8so6242128oib.6
        for <git@vger.kernel.org>; Sun, 12 Jun 2022 18:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Alrm981pFauS881lRF28dEMhCEOw2F/vLR/PXxRcfY=;
        b=JOB7BaYKdLuQS67AOMW6VsolQFj+ruCql5HNStCGrczk0CKWy4gl5HQHNToCQxrOwk
         84xvNAng9iev14+a9SKrODZKIUXyk0lDIeqVT5SbnJV78M/KJ22r8nPF3csK2vQNo+ii
         Yho2gV7lIk7kbflhbBwKj+oLWin289hI8MwT/tWH/hY9Sj5xZOqwfDeD9VbB8jLMgetU
         GiH7spC1M2Hqre8VxS70d6zOznJTuBGdvYHFHf/HaZzoDlmsRiatOlDcBnGUuor2YMuK
         0LeZ5duRhWHzu01JDlHPQLYzemM8pxjYgbfair2GU4V8BFZGShZepef22ECWfW7m1UxP
         puPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Alrm981pFauS881lRF28dEMhCEOw2F/vLR/PXxRcfY=;
        b=ylasKvyrDDRVH6vL/Or0KcMQIKCrPzx7unUmCPTni8FUUmh8TG0tc2LWRDfakdVmsL
         ob/ql0Pf3Tc/p0BPyoDRdE2BWXGNfimvI2KxAJUVT/VZNohTNlpNBiUkYOWkSBKNAOhN
         uEcifcCnxISzmKmGbFnPF5oheuVreFlkIo08DRYyRAhOF5SM5p/LmNlZWniZUUASN3Mm
         EFNWRjzPsEucInKkSA0h3Xbo3ME9jwAW3nJ2/eDqwt1sVe/P65bLi+4Fp92fKS8Kbs78
         P+W3tKyuPjukYqvNVaO3dEKXt5AJmf8OPcHpZqGoeVxDZPSS/pcfBob74JOkl1loD2IK
         /fKg==
X-Gm-Message-State: AOAM532cGDWM73RuVo2JjFgY8RgesVDip+MohnfhVNOCAF69xYYhVndz
        Ta08Oi6Xved56Pvl1BcrbohzSv5Ue5h/whjDdegtVeHKWq5NlQ==
X-Google-Smtp-Source: ABdhPJwmx1sjfy5cmCtp3Dgj0hiYA/GUYHfaVHI/famuK9MCJq0FoDU6wo10/j9DB2xCAJIUQnkEl1lmchj7GSI/xPA=
X-Received: by 2002:a05:6808:6d3:b0:32f:2735:40a2 with SMTP id
 m19-20020a05680806d300b0032f273540a2mr3724718oih.213.1655085266524; Sun, 12
 Jun 2022 18:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220606235449.2890858-1-calvinwan@google.com>
 <20220610231152.2594428-1-calvinwan@google.com> <CABPp-BHe7wdd3LMYtZ83ZgapvUxzQYcK-3=sdMAD5Ozs4YmKyw@mail.gmail.com>
In-Reply-To: <CABPp-BHe7wdd3LMYtZ83ZgapvUxzQYcK-3=sdMAD5Ozs4YmKyw@mail.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Sun, 12 Jun 2022 18:54:15 -0700
Message-ID: <CAFySSZDtHbFV92bLPrE4U7LCX+232zNVETZaOb2qLvyQmucEnQ@mail.gmail.com>
Subject: Re: [PATCH v2] submodule merge: update conflict error message
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think we may need to tweak these steps a bit:

>    1. merge submodules OR update submodules to an already existing
> commit that reflects the merge (i.e. as submodules they may well be
> independently actively developed.  Someone may have already merged the
> appropriate branch/commit and the already extant merges should be used
> in preference to creating new ones.)
>    2. <just as you said>
>    3. FINISH merging the superproject (i.e. don't redo the merge)

> I might be off on step 1; I have only used submodules extremely
> lightly and usually only for a limited time, so I'm not really sure
> what the expected workflow is.  I could also imagine it potentially
> being repository-dependent whether you would want to merge or select
> an appropriate commit to update to.

You are correct that either merging or selecting an appropriate commit to
update to (if it exists) are the two ways to fix a submodule conflict. As
Phillippe mentions below, if merge detects a possible merge resolution,
that merge resolution is printed out as in the suggestion. I wonder if it's
easy to pull out the exact reason for why the submodule merge failed. If
that is the case, then I think changing the first step to something like:

(If no merge resolution already exists, the suggestion stays the same)
  1. - go to submodule (<submodule>) and merge commit <commit>
(If a merge resolution exists)
  1. - go to submodule (<submodule>). Either update the submodule
        to one of the possible merge commits or merge commit <commit>

If it is not easy to pull out the merge fail reason, then I think we can
generalize the first step to:

1. - go to submodule (<submodule>). Merge commit <commit> or if
      a possible merge resolution exists, then you have the option to
      update the submodule to one of the merge commits

> However, this implementation does have a drawback: these messages
> won't appear for rebases, cherry-picks, reverts, attempted unstashing
> (git stash apply/pop), or other actions unless you update the relevant
> porcelains for those as well.

> A possible alternative here would be to move it to the level of
> merge-recursive and merge-ort that is only called when the working
> tree and index are updated.  For example, placing it in
> merge_finalize() in merge-recursive.c and merge_switch_to_result() in
> merge-ort.c -- next to the diff_warn_rename_limit() call in each case.
> However, I'm also fine with keeping it at the porcelain level, it just
> may need to be in a function that is called from several porcelains
> that way.

You make a good point here. I'm inclined to keep it at the porcelain level
since this is a temporary holdover until `merge --recurse-submodules` is
implemented.

> test_i18ngrep is apparently on the way out:

ack

On Fri, Jun 10, 2022 at 9:53 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Fri, Jun 10, 2022 at 4:29 PM Calvin Wan <calvinwan@google.com> wrote:
> >
> > When attempting to do a non-fast-forward merge in a project with
> > conflicts in the submodules, the merge fails and git prints the
> > following error:
> >
> > Failed to merge submodule <submodules>
> > CONFLICT (submodule):Merge conflict in <submodule>
> > Automatic merge failed; fix conflicts and then commit the result.
> >
> > Git is left in a conflicted state, which requires the user to:
> >  1. merge submodules
> >  2. add submodules changes to the superproject
> >  3. merge superproject
>
> I think we may need to tweak these steps a bit:
>
>    1. merge submodules OR update submodules to an already existing
> commit that reflects the merge (i.e. as submodules they may well be
> independently actively developed.  Someone may have already merged the
> appropriate branch/commit and the already extant merges should be used
> in preference to creating new ones.)
>    2. <just as you said>
>    3. FINISH merging the superproject (i.e. don't redo the merge)
>
> I might be off on step 1; I have only used submodules extremely
> lightly and usually only for a limited time, so I'm not really sure
> what the expected workflow is.  I could also imagine it potentially
> being repository-dependent whether you would want to merge or select
> an appropriate commit to update to.
>
> > These steps are non-obvious for newer submodule users to figure out
> > based on the error message and neither `git submodule status` nor `git
> > status` provide any useful pointers.
> >
> > Update error message to the following when attempting to do a
> > non-fast-forward merge in a project with conflicts in the submodules.
>
> Make sense.
>
> > The error message is based off of what would happen when `merge
> > --recurse-submodules` is eventually supported
> >
> > Failed to merge submodule <submodule>
> > CONFLICT (submodule): Merge conflict in <submodule>
> > Automatic merge failed; recursive merging with submodules is currently
> > not supported. To manually complete the merge:
> >  - go to submodule (<submodule>), and merge commit <commit>
> >  - come back to superproject, and `git add <submodule>` to record the above merge
> >  - resolve any other conflicts in the superproject
> >  - commit the resulting index in the superproject
>
> Ah, I see you've fixed step 3 here; that's good.
>
> However, these steps miss out on the merge-or-update submodule
> possibility...and since you mention these steps are potentially the
> basis for some future work, I think it's worth calling that out again.
> I'm slightly worried that the 'update' part of merge-or-update may
> throw a wrench in the plans for `merge --recurse-submodules`.
>
> (Also, continuing on the `merge --recurse-submodules` talent but
> discussing a different aspect of it, I'm curious if you need to add
> extra dirty-worktree/dirty-index checks for each submodule at the
> start of a merge, whether you need to try to lock N indexes before
> starting, and what other extra details are necessary.  But those are
> probably questions to address whenever work on the future series to
> implement this option is underway.)
>
> > Changes since v1:
> >  - Removed advice to abort merge
> >  - Error message updated to contain more commit/submodule information
> >
> > Signed-off-by: Calvin Wan <calvinwan@google.com>
> >
> > ---
> >  builtin/merge.c            | 23 ++++++++++++++++++++++-
> >  merge-ort.c                |  7 ++++++-
> >  merge-recursive.c          |  7 ++++++-
> >  merge-recursive.h          |  4 ++++
> >  t/t6437-submodule-merge.sh |  5 ++++-
> >  5 files changed, 42 insertions(+), 4 deletions(-)
>
> So you're modifying the "git merge" porcelain level (builtin/merge.c),
> the two merges strategies, their common header, and adding some tests.
> No other porcelains are modified...
>
> > diff --git a/builtin/merge.c b/builtin/merge.c
> > index f178f5a3ee..7e2deea7fb 100644
> > --- a/builtin/merge.c
> > +++ b/builtin/merge.c
> > @@ -88,6 +88,8 @@ static const char *sign_commit;
> >  static int autostash;
> >  static int no_verify;
> >  static char *into_name;
> > +static struct oid_array conflicted_submodule_oids = OID_ARRAY_INIT;
> > +static struct string_list conflicted_submodule_paths = STRING_LIST_INIT_DUP;
> >
> >  static struct strategy all_strategy[] = {
> >         { "recursive",  NO_TRIVIAL },
> > @@ -734,6 +736,8 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
> >                 }
> >
> >                 init_merge_options(&o, the_repository);
> > +               o.conflicted_submodule_oids = &conflicted_submodule_oids;
> > +               o.conflicted_submodule_paths = &conflicted_submodule_paths;
> >                 if (!strcmp(strategy, "subtree"))
> >                         o.subtree_shift = "";
> >
> > @@ -973,8 +977,25 @@ static int suggest_conflicts(void)
> >         strbuf_release(&msgbuf);
> >         fclose(fp);
> >         repo_rerere(the_repository, allow_rerere_auto);
> > -       printf(_("Automatic merge failed; "
> > +       if (conflicted_submodule_oids.nr > 0) {
> > +               int i;
> > +               printf(_("Automatic merge failed; recursive merging with submodules is currently\n"
> > +                       "not supported. To manually complete the merge:\n"));
> > +               for (i = 0; i < conflicted_submodule_oids.nr; i++) {
> > +                       printf(_(" - go to submodule (%s), and merge commit %s\n"),
> > +                               conflicted_submodule_paths.items[i].string,
> > +                               oid_to_hex(&conflicted_submodule_oids.oid[i]));
> > +               }
> > +               printf(_(" - come back to superproject, and `git add"));
> > +               for (i = 0; i < conflicted_submodule_paths.nr; i++)
> > +                       printf(_(" %s"), conflicted_submodule_paths.items[i].string);
> > +               printf(_("` to record the above merge \n"
> > +               " - resolve any other conflicts in the superproject\n"
> > +               " - commit the resulting index in the superproject\n"));
> > +       } else {
> > +               printf(_("Automatic merge failed; "
> >                         "fix conflicts and then commit the result.\n"));
> > +       }
> >         return 1;
> >  }
>
> This is kind of nice.  I was worried you were going to embed these
> messages in the merge strategies, which could cause problems for other
> users of the merge strategies such as the --remerge-diff options to
> git log and git show (your new messages would be unwanted noise or
> even cause confusion there), and to the merge-tree work.  In fact, a
> current submodule-merging message (search for "--cacheinfo") that is
> potentially similar to what you are adding here but which was added at
> the merge strategy level already feels highly problematic to me.  I've
> been considering nuking it from the codebase for some time because of
> those issues, though I guess just moving it out elsewhere may also
> work.
>
> However, this implementation does have a drawback: these messages
> won't appear for rebases, cherry-picks, reverts, attempted unstashing
> (git stash apply/pop), or other actions unless you update the relevant
> porcelains for those as well.
>
> A possible alternative here would be to move it to the level of
> merge-recursive and merge-ort that is only called when the working
> tree and index are updated.  For example, placing it in
> merge_finalize() in merge-recursive.c and merge_switch_to_result() in
> merge-ort.c -- next to the diff_warn_rename_limit() call in each case.
> However, I'm also fine with keeping it at the porcelain level, it just
> may need to be in a function that is called from several porcelains
> that way.
>
> > diff --git a/merge-ort.c b/merge-ort.c
> > index 0d3f42592f..c86ee11614 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -3866,8 +3866,13 @@ static void process_entry(struct merge_options *opt,
> >                         const char *reason = _("content");
> >                         if (ci->filemask == 6)
> >                                 reason = _("add/add");
> > -                       if (S_ISGITLINK(merged_file.mode))
> > +                       if (S_ISGITLINK(merged_file.mode)) {
> >                                 reason = _("submodule");
> > +                               if (opt->conflicted_submodule_oids && opt->conflicted_submodule_paths) {
> > +                                       oid_array_append(opt->conflicted_submodule_oids, &merged_file.oid);
> > +                                       string_list_append(opt->conflicted_submodule_paths, path);
> > +                               }
> > +                       }
> >                         path_msg(opt, path, 0,
> >                                  _("CONFLICT (%s): Merge conflict in %s"),
> >                                  reason, path);
> > diff --git a/merge-recursive.c b/merge-recursive.c
> > index fd1bbde061..ff7cdbefe9 100644
> > --- a/merge-recursive.c
> > +++ b/merge-recursive.c
> > @@ -3149,8 +3149,13 @@ static int handle_content_merge(struct merge_file_info *mfi,
> >         }
> >
> >         if (!mfi->clean) {
> > -               if (S_ISGITLINK(mfi->blob.mode))
> > +               if (S_ISGITLINK(mfi->blob.mode)) {
> >                         reason = _("submodule");
> > +                       if (opt->conflicted_submodule_oids && opt->conflicted_submodule_paths) {
> > +                               oid_array_append(opt->conflicted_submodule_oids, &mfi->blob.oid);
> > +                               string_list_append(opt->conflicted_submodule_paths, path);
> > +                       }
> > +               }
> >                 output(opt, 1, _("CONFLICT (%s): Merge conflict in %s"),
> >                                 reason, path);
> >                 if (ci && !df_conflict_remains)
>
> Nice that the changes needed to both the ort and recursive strategies
> are so localized.  :-)
>
> > diff --git a/merge-recursive.h b/merge-recursive.h
> > index b88000e3c2..5d267e7a43 100644
> > --- a/merge-recursive.h
> > +++ b/merge-recursive.h
> > @@ -51,6 +51,10 @@ struct merge_options {
> >
> >         /* internal fields used by the implementation */
> >         struct merge_options_internal *priv;
> > +
> > +       /* fields that hold submodule conflict information */
> > +       struct oid_array *conflicted_submodule_oids;
> > +       struct string_list *conflicted_submodule_paths;
> >  };
>
> Make sense.
>
> >  void init_merge_options(struct merge_options *opt, struct repository *repo);
> > diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
> > index 178413c22f..5b384dedc1 100755
> > --- a/t/t6437-submodule-merge.sh
> > +++ b/t/t6437-submodule-merge.sh
> > @@ -141,6 +141,7 @@ test_expect_success 'merging should conflict for non fast-forward' '
> >                 test_must_fail git merge c 2> actual
> >           fi &&
> >          grep $(cat expect) actual > /dev/null &&
> > +        test_i18ngrep "go to submodule (sub), and merge commit $(git -C sub rev-parse sub-b)" actual &&
> >          git reset --hard)
> >  '
> >
> > @@ -167,6 +168,7 @@ test_expect_success 'merging should fail for ambiguous common parent' '
> >          fi &&
> >         grep $(cat expect1) actual > /dev/null &&
> >         grep $(cat expect2) actual > /dev/null &&
> > +       test_i18ngrep "go to submodule (sub), and merge commit $(git -C sub rev-parse sub-b)" actual &&
> >         git reset --hard)
> >  '
> >
> > @@ -205,7 +207,8 @@ test_expect_success 'merging should fail for changes that are backwards' '
> >         git commit -a -m "f" &&
> >
> >         git checkout -b test-backward e &&
> > -       test_must_fail git merge f)
> > +       test_must_fail git merge f >actual &&
> > +       test_i18ngrep "go to submodule (sub), and merge commit $(git -C sub rev-parse sub-a)" actual)
>
> test_i18ngrep is apparently on the way out:
>
>     $ grep -B 3 ^test_i18ngrep t/test-lib-functions.sh
>     # Wrapper for grep which used to be used for
>     # GIT_TEST_GETTEXT_POISON=false. Only here as a shim for other
>     # in-flight changes. Should not be used and will be removed soon.
>     test_i18ngrep () {
>
> I think you just want to use grep instead here for each of these hunks.
