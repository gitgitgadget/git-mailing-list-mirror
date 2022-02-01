Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D74C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 21:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbiBAVeK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 16:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiBAVeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 16:34:09 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DE7C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 13:34:09 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id g20so16527480pgn.10
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 13:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=clJyMklAkEeP4bfSlykpS1QfLBzQizWK7ZRmMptkKow=;
        b=rpxh0lFt05/t+rlROEeHc5mo0AhIaM96iAJ7MKPsTPp0Zwx07XNAOGRV+95NE23ZNV
         dlWvK0e9QXlsUZVQSUG8HlamWR2ss+v4CTGVVAze/XpHxYSGR2djVhaOzI7HuZ2bYR0/
         lK7vS3oW4bqjpxy2eLlAxZ+zPb2wG8e+T/C2FpWLGBCHyVzGSvjWbcOKmoIpDGFvFLXy
         T6AhakvjL802H+K0/FJWZ/LPpAfI3D120W1SCTfEVZjXnlc5eLvr47CTF2zctqzYElCJ
         UM8JFALCV/P460l5BRxfvNUYD1S8WJUACaRuZZsngdbCt2WjBt5V9tNYxFHakEyHtfmG
         Gbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=clJyMklAkEeP4bfSlykpS1QfLBzQizWK7ZRmMptkKow=;
        b=Wep0Tylia233IQjA38Xo7aWY0g2krrmYMDvnQPwjkXDjpHiSkzEf3mn1ai1VF5/DWz
         d+zLRw0iRfFJGZgsVUrVTTl7in3F+v46SOK7czdwsCWphLXweAYDP7xNpr7pkCCic95M
         ZUztu+vSDQvBXCU/ldRjWF3Mh7AyhEY1ixQtRtcZVkheUb/te+zOu4vvWBr9tWfkKJ20
         jrSqRp4vy3wnxL9SXyp7YayfRsAOq1h9fONALIHVW3TDB2npvuYtli/qlbxQngvLD2En
         8hjLnABZqEOOBybmgeohB0P3w/FPXcWSYGAvUM/8R04J7qrBIYZqy2I58pPScrgW0QaP
         3pfQ==
X-Gm-Message-State: AOAM531hzu6b3z29a1tapD5PLGu8DJRdi8rdyQ6Igqn3VXy4mGRfAxSc
        inMKqhtm24K70tbTn0wzqR2SSeSdekNgFQ==
X-Google-Smtp-Source: ABdhPJxB/uednKqEt31cUEiRdfhQCw3lEd0Wniu2NlYyTxE6sqAFqupcHHVhd6J5rcPyKXcSLAbJdA==
X-Received: by 2002:a63:1d07:: with SMTP id d7mr22100481pgd.414.1643751248929;
        Tue, 01 Feb 2022 13:34:08 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:b721:7974:9ebe:afb2])
        by smtp.gmail.com with ESMTPSA id j14sm23770516pfj.218.2022.02.01.13.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 13:34:08 -0800 (PST)
Date:   Tue, 1 Feb 2022 13:34:02 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] clone, submodule: pass partial clone filters to
 submodules
Message-ID: <YfmnSkrIMgDd2nbL@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <50ebf7bd39adf34fa4ada27cd433d81b5381abe5.1642735881.git.steadmon@google.com>
 <CABPp-BHf7audy2X=q14BM5PgLhkuqDCb+vcASVqRDRfdAUewpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BHf7audy2X=q14BM5PgLhkuqDCb+vcASVqRDRfdAUewpQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.01.25 13:08, Elijah Newren wrote:
> On Fri, Jan 21, 2022 at 4:31 PM Josh Steadmon <steadmon@google.com> wrote:
> >
> > When cloning a repo with a --filter and with --recurse-submodules
> > enabled, the partial clone filter only applies to
> > the top-level repo. This can lead to unexpected bandwidth and disk
> > usage for projects which include large submodules. For example, a user
> > might wish to make a partial clone of Gerrit and would run:
> > `git clone --recurse-submodules --filter=blob:5k
> > https://gerrit.googlesource.com/gerrit`. However, only the superproject
> > would be a partial clone; all the submodules would have all blobs
> > downloaded regardless of their size. With this change, the same filter
> > applies to submodules, meaning the expected bandwidth and disk savings
> > apply consistently.
> >
> > Plumb the --filter argument from git-clone through git-submodule and
> > git-submodule--helper, such that submodule clones also have the filter
> > applied.
> >
> > This applies the same filter to the superproject and all submodules.
> > Users who prefer the current behavior (i.e., a filter only on the
> > superproject) would need to clone with `--no-recurse-submodules` and
> > then manually initialize each submodule.
> >
> > Applying filters to submodules should be safe thanks to Jonathan Tan's
> > recent work [1, 2, 3] eliminating the use of alternates as a method of
> > accessing submodule objects, so any submodule object access now triggers
> > a lazy fetch from the submodule's promisor remote if the accessed object
> > is missing. This patch is an updated version of [4], which was created
> > prior to Jonathan Tan's work.
> >
> > [1]: 8721e2e (Merge branch 'jt/partial-clone-submodule-1', 2021-07-16)
> > [2]: 11e5d0a (Merge branch 'jt/grep-wo-submodule-odb-as-alternate',
> >         2021-09-20)
> > [3]: 162a13b (Merge branch 'jt/no-abuse-alternate-odb-for-submodules',
> >         2021-10-25)
> > [4]: https://lore.kernel.org/git/52bf9d45b8e2b72ff32aa773f2415bf7b2b86da2.1563322192.git.steadmon@google.com/
> >
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > ---
> >  builtin/clone.c                    |  4 ++++
> >  builtin/submodule--helper.c        | 30 ++++++++++++++++++++++---
> >  git-submodule.sh                   | 17 +++++++++++++-
> >  t/t5617-clone-submodules-remote.sh | 17 ++++++++++++++
> >  t/t7814-grep-recurse-submodules.sh | 36 ++++++++++++++++++++++++++++++
> >  5 files changed, 100 insertions(+), 4 deletions(-)
> >
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index 727e16e0ae..196e947714 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -729,6 +729,10 @@ static int checkout(int submodule_progress)
> >                         strvec_push(&args, "--no-fetch");
> >                 }
> >
> > +               if (filter_options.choice)
> > +                       strvec_pushf(&args, "--filter=%s",
> > +                                    expand_list_objects_filter_spec(&filter_options));
> > +
> >                 if (option_single_branch >= 0)
> >                         strvec_push(&args, option_single_branch ?
> >                                                "--single-branch" :
> > diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> > index c5d3fc3817..11552970f2 100644
> > --- a/builtin/submodule--helper.c
> > +++ b/builtin/submodule--helper.c
> > @@ -20,6 +20,7 @@
> >  #include "diff.h"
> >  #include "object-store.h"
> >  #include "advice.h"
> > +#include "list-objects-filter-options.h"
> >
> >  #define OPT_QUIET (1 << 0)
> >  #define OPT_CACHED (1 << 1)
> > @@ -1630,6 +1631,7 @@ struct module_clone_data {
> >         const char *name;
> >         const char *url;
> >         const char *depth;
> > +       struct list_objects_filter_options *filter_options;
> >         struct string_list reference;
> >         unsigned int quiet: 1;
> >         unsigned int progress: 1;
> > @@ -1796,6 +1798,10 @@ static int clone_submodule(struct module_clone_data *clone_data)
> >                         strvec_push(&cp.args, "--dissociate");
> >                 if (sm_gitdir && *sm_gitdir)
> >                         strvec_pushl(&cp.args, "--separate-git-dir", sm_gitdir, NULL);
> > +               if (clone_data->filter_options && clone_data->filter_options->choice)
> > +                       strvec_pushf(&cp.args, "--filter=%s",
> > +                                    expand_list_objects_filter_spec(
> > +                                            clone_data->filter_options));
> >                 if (clone_data->single_branch >= 0)
> >                         strvec_push(&cp.args, clone_data->single_branch ?
> >                                     "--single-branch" :
> > @@ -1852,6 +1858,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
> >  {
> >         int dissociate = 0, quiet = 0, progress = 0, require_init = 0;
> >         struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
> > +       struct list_objects_filter_options filter_options;
> >
> >         struct option module_clone_options[] = {
> >                 OPT_STRING(0, "prefix", &clone_data.prefix,
> > @@ -1881,17 +1888,19 @@ static int module_clone(int argc, const char **argv, const char *prefix)
> >                            N_("disallow cloning into non-empty directory")),
> >                 OPT_BOOL(0, "single-branch", &clone_data.single_branch,
> >                          N_("clone only one branch, HEAD or --branch")),
> > +               OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
> >                 OPT_END()
> >         };
> >
> >         const char *const git_submodule_helper_usage[] = {
> >                 N_("git submodule--helper clone [--prefix=<path>] [--quiet] "
> >                    "[--reference <repository>] [--name <name>] [--depth <depth>] "
> > -                  "[--single-branch] "
> > +                  "[--single-branch] [--filter <filter-spec>]"
> >                    "--url <url> --path <path>"),
> >                 NULL
> >         };
> >
> > +       memset(&filter_options, 0, sizeof(filter_options));
> >         argc = parse_options(argc, argv, prefix, module_clone_options,
> >                              git_submodule_helper_usage, 0);
> >
> > @@ -1899,12 +1908,14 @@ static int module_clone(int argc, const char **argv, const char *prefix)
> >         clone_data.quiet = !!quiet;
> >         clone_data.progress = !!progress;
> >         clone_data.require_init = !!require_init;
> > +       clone_data.filter_options = &filter_options;
> >
> >         if (argc || !clone_data.url || !clone_data.path || !*(clone_data.path))
> >                 usage_with_options(git_submodule_helper_usage,
> >                                    module_clone_options);
> >
> >         clone_submodule(&clone_data);
> > +       list_objects_filter_release(&filter_options);
> >         return 0;
> >  }
> >
> > @@ -1994,6 +2005,7 @@ struct submodule_update_clone {
> >         const char *recursive_prefix;
> >         const char *prefix;
> >         int single_branch;
> > +       struct list_objects_filter_options *filter_options;
> >
> >         /* to be consumed by git-submodule.sh */
> >         struct update_clone_data *update_clone;
> > @@ -2154,6 +2166,9 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
> >                 strvec_pushl(&child->args, "--prefix", suc->prefix, NULL);
> >         if (suc->recommend_shallow && sub->recommend_shallow == 1)
> >                 strvec_push(&child->args, "--depth=1");
> > +       if (suc->filter_options && suc->filter_options->choice)
> > +               strvec_pushf(&child->args, "--filter=%s",
> > +                            expand_list_objects_filter_spec(suc->filter_options));
> >         if (suc->require_init)
> >                 strvec_push(&child->args, "--require-init");
> >         strvec_pushl(&child->args, "--path", sub->path, NULL);
> > @@ -2498,6 +2513,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
> >         const char *update = NULL;
> >         struct pathspec pathspec;
> >         struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
> > +       struct list_objects_filter_options filter_options;
> > +       int ret;
> >
> >         struct option module_update_clone_options[] = {
> >                 OPT_STRING(0, "prefix", &prefix,
> > @@ -2528,6 +2545,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
> >                            N_("disallow cloning into non-empty directory")),
> >                 OPT_BOOL(0, "single-branch", &suc.single_branch,
> >                          N_("clone only one branch, HEAD or --branch")),
> > +               OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
> >                 OPT_END()
> >         };
> >
> > @@ -2540,20 +2558,26 @@ static int update_clone(int argc, const char **argv, const char *prefix)
> >         update_clone_config_from_gitmodules(&suc.max_jobs);
> >         git_config(git_update_clone_config, &suc.max_jobs);
> >
> > +       memset(&filter_options, 0, sizeof(filter_options));
> >         argc = parse_options(argc, argv, prefix, module_update_clone_options,
> >                              git_submodule_helper_usage, 0);
> > +       suc.filter_options = &filter_options;
> >
> >         if (update)
> >                 if (parse_submodule_update_strategy(update, &suc.update) < 0)
> >                         die(_("bad value for update parameter"));
> >
> > -       if (module_list_compute(argc, argv, prefix, &pathspec, &suc.list) < 0)
> > +       if (module_list_compute(argc, argv, prefix, &pathspec, &suc.list) < 0) {
> > +               list_objects_filter_release(&filter_options);
> >                 return 1;
> > +       }
> >
> >         if (pathspec.nr)
> >                 suc.warn_if_uninitialized = 1;
> >
> > -       return update_submodules(&suc);
> > +       ret = update_submodules(&suc);
> > +       list_objects_filter_release(&filter_options);
> > +       return ret;
> >  }
> >
> >  static int run_update_procedure(int argc, const char **argv, const char *prefix)
> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index 652861aa66..926f6873d3 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > @@ -10,7 +10,7 @@ USAGE="[--quiet] [--cached]
> >     or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
> >     or: $dashless [--quiet] init [--] [<path>...]
> >     or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
> > -   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--[no-]single-branch] [--] [<path>...]
> > +   or: $dashless [--quiet] update [--init [--filter=<filter-spec>]] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--[no-]single-branch] [--] [<path>...]
> >     or: $dashless [--quiet] set-branch (--default|--branch <branch>) [--] <path>
> >     or: $dashless [--quiet] set-url [--] <path> <newurl>
> >     or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
> > @@ -49,6 +49,7 @@ dissociate=
> >  single_branch=
> >  jobs=
> >  recommend_shallow=
> > +filter=
> >
> >  die_if_unmatched ()
> >  {
> > @@ -347,6 +348,14 @@ cmd_update()
> >                 --no-single-branch)
> >                         single_branch="--no-single-branch"
> >                         ;;
> > +               --filter)
> > +                       case "$2" in '') usage ;; esac
> > +                       filter="--filter=$2"
> > +                       shift
> > +                       ;;
> > +               --filter=*)
> > +                       filter=$1
> 
> Shouldn't this be
>      filter="$1"
> ?  I think it'd work currently without the quotes, but seeing the
> discussion of special characters for --filter=combine in
> git-rev-list(1) make me worry that this could become unsafe in the
> future.

Yes, thanks for the catch. Will fix in V2.
