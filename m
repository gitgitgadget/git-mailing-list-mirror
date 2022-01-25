Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7341CC433EF
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 21:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbiAYVIf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 16:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiAYVIc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 16:08:32 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77117C06173B
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 13:08:32 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r10so34585054edt.1
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 13:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IXEdseP9SP73quOlclAT3aF2Vu3B5O4zFjFoeloQhAE=;
        b=BfqARfdwi5u1j/l2FBoL0gmw+2MDgi3xJ9dE7PsP3d/bxIq8ecnY9KQs8174UNErSO
         qs2/XvD9EKkUDoHUcVQBFGyrltm55hVT3eVYMjJFJ8XQl6kyoqVY/OmXuaU2JySSvAct
         83k5083eJ6CGAUlMjATSVVYVFxRaLSg40XKX6gsdjmIDynlcKNBqLRAWFJ8F5zfOnmLK
         R7hGhLiuidKtuFSJ0DsT0pjM1vagYLGz5wYYT99CMymW1CeF94UAd42/ekfCHVR08nnk
         vZe/23wkhWv2Ud6NPpv1/IRrOotNB1Bz0/ARS1z7gjMLObpXluqZeVisAocQUBpxhnbQ
         jZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IXEdseP9SP73quOlclAT3aF2Vu3B5O4zFjFoeloQhAE=;
        b=WNTfVZvFmShIdfF0yBlggXobEcLsMs+lq/qVRR/MCBuXwD6tmTPqpq10naKQ9lcdlj
         zocWnVsrfNV9XpV7qbaP4YyizW4N7uSCDtii8hnxI9cNSI7mvT3UP+EAxKXeLc9Sb6qh
         t7n/bK5Fk3ytdtHP/g2b92UbiYfSgY1y1beuTE5oME43PkNbZcEUysf0XFEAVQZ28/f6
         oo1/WdvzymRqiwhIud3XMkHuWK7+76c2X8u8AG62bG7a6JKez7h8No8jGXrn/BeFkbtK
         5PLD5z6k4Yom81ScY/Kart4eSO+fGg3wg8etYRv1IY1Mdw1rVkpKQr8EDA+ovXFgimNt
         BnZg==
X-Gm-Message-State: AOAM533YDqGotXqrUH4UWu6IG7ctQ0kDwHqZiNk1XpU5fkJ8oFKssYVb
        Fj15ifKnNjCQV0wXU2dyDMiBgkx/Hcey9XP9wyeqtrno
X-Google-Smtp-Source: ABdhPJwv04daQZK9UZhXdf3QuhdUImtYFqMwLQLp06jfsRfsmNykgHl1T4x0x32/UHJ4tXD9FYMLLZwMG/Z0D8t80sc=
X-Received: by 2002:a50:d799:: with SMTP id w25mr22557602edi.33.1643144910809;
 Tue, 25 Jan 2022 13:08:30 -0800 (PST)
MIME-Version: 1.0
References: <50ebf7bd39adf34fa4ada27cd433d81b5381abe5.1642735881.git.steadmon@google.com>
In-Reply-To: <50ebf7bd39adf34fa4ada27cd433d81b5381abe5.1642735881.git.steadmon@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 25 Jan 2022 13:08:19 -0800
Message-ID: <CABPp-BHf7audy2X=q14BM5PgLhkuqDCb+vcASVqRDRfdAUewpQ@mail.gmail.com>
Subject: Re: [PATCH] clone, submodule: pass partial clone filters to submodules
To:     Josh Steadmon <steadmon@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 21, 2022 at 4:31 PM Josh Steadmon <steadmon@google.com> wrote:
>
> When cloning a repo with a --filter and with --recurse-submodules
> enabled, the partial clone filter only applies to
> the top-level repo. This can lead to unexpected bandwidth and disk
> usage for projects which include large submodules. For example, a user
> might wish to make a partial clone of Gerrit and would run:
> `git clone --recurse-submodules --filter=blob:5k
> https://gerrit.googlesource.com/gerrit`. However, only the superproject
> would be a partial clone; all the submodules would have all blobs
> downloaded regardless of their size. With this change, the same filter
> applies to submodules, meaning the expected bandwidth and disk savings
> apply consistently.
>
> Plumb the --filter argument from git-clone through git-submodule and
> git-submodule--helper, such that submodule clones also have the filter
> applied.
>
> This applies the same filter to the superproject and all submodules.
> Users who prefer the current behavior (i.e., a filter only on the
> superproject) would need to clone with `--no-recurse-submodules` and
> then manually initialize each submodule.
>
> Applying filters to submodules should be safe thanks to Jonathan Tan's
> recent work [1, 2, 3] eliminating the use of alternates as a method of
> accessing submodule objects, so any submodule object access now triggers
> a lazy fetch from the submodule's promisor remote if the accessed object
> is missing. This patch is an updated version of [4], which was created
> prior to Jonathan Tan's work.
>
> [1]: 8721e2e (Merge branch 'jt/partial-clone-submodule-1', 2021-07-16)
> [2]: 11e5d0a (Merge branch 'jt/grep-wo-submodule-odb-as-alternate',
>         2021-09-20)
> [3]: 162a13b (Merge branch 'jt/no-abuse-alternate-odb-for-submodules',
>         2021-10-25)
> [4]: https://lore.kernel.org/git/52bf9d45b8e2b72ff32aa773f2415bf7b2b86da2.1563322192.git.steadmon@google.com/
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  builtin/clone.c                    |  4 ++++
>  builtin/submodule--helper.c        | 30 ++++++++++++++++++++++---
>  git-submodule.sh                   | 17 +++++++++++++-
>  t/t5617-clone-submodules-remote.sh | 17 ++++++++++++++
>  t/t7814-grep-recurse-submodules.sh | 36 ++++++++++++++++++++++++++++++
>  5 files changed, 100 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 727e16e0ae..196e947714 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -729,6 +729,10 @@ static int checkout(int submodule_progress)
>                         strvec_push(&args, "--no-fetch");
>                 }
>
> +               if (filter_options.choice)
> +                       strvec_pushf(&args, "--filter=%s",
> +                                    expand_list_objects_filter_spec(&filter_options));
> +
>                 if (option_single_branch >= 0)
>                         strvec_push(&args, option_single_branch ?
>                                                "--single-branch" :
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index c5d3fc3817..11552970f2 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -20,6 +20,7 @@
>  #include "diff.h"
>  #include "object-store.h"
>  #include "advice.h"
> +#include "list-objects-filter-options.h"
>
>  #define OPT_QUIET (1 << 0)
>  #define OPT_CACHED (1 << 1)
> @@ -1630,6 +1631,7 @@ struct module_clone_data {
>         const char *name;
>         const char *url;
>         const char *depth;
> +       struct list_objects_filter_options *filter_options;
>         struct string_list reference;
>         unsigned int quiet: 1;
>         unsigned int progress: 1;
> @@ -1796,6 +1798,10 @@ static int clone_submodule(struct module_clone_data *clone_data)
>                         strvec_push(&cp.args, "--dissociate");
>                 if (sm_gitdir && *sm_gitdir)
>                         strvec_pushl(&cp.args, "--separate-git-dir", sm_gitdir, NULL);
> +               if (clone_data->filter_options && clone_data->filter_options->choice)
> +                       strvec_pushf(&cp.args, "--filter=%s",
> +                                    expand_list_objects_filter_spec(
> +                                            clone_data->filter_options));
>                 if (clone_data->single_branch >= 0)
>                         strvec_push(&cp.args, clone_data->single_branch ?
>                                     "--single-branch" :
> @@ -1852,6 +1858,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>  {
>         int dissociate = 0, quiet = 0, progress = 0, require_init = 0;
>         struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
> +       struct list_objects_filter_options filter_options;
>
>         struct option module_clone_options[] = {
>                 OPT_STRING(0, "prefix", &clone_data.prefix,
> @@ -1881,17 +1888,19 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>                            N_("disallow cloning into non-empty directory")),
>                 OPT_BOOL(0, "single-branch", &clone_data.single_branch,
>                          N_("clone only one branch, HEAD or --branch")),
> +               OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
>                 OPT_END()
>         };
>
>         const char *const git_submodule_helper_usage[] = {
>                 N_("git submodule--helper clone [--prefix=<path>] [--quiet] "
>                    "[--reference <repository>] [--name <name>] [--depth <depth>] "
> -                  "[--single-branch] "
> +                  "[--single-branch] [--filter <filter-spec>]"
>                    "--url <url> --path <path>"),
>                 NULL
>         };
>
> +       memset(&filter_options, 0, sizeof(filter_options));
>         argc = parse_options(argc, argv, prefix, module_clone_options,
>                              git_submodule_helper_usage, 0);
>
> @@ -1899,12 +1908,14 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>         clone_data.quiet = !!quiet;
>         clone_data.progress = !!progress;
>         clone_data.require_init = !!require_init;
> +       clone_data.filter_options = &filter_options;
>
>         if (argc || !clone_data.url || !clone_data.path || !*(clone_data.path))
>                 usage_with_options(git_submodule_helper_usage,
>                                    module_clone_options);
>
>         clone_submodule(&clone_data);
> +       list_objects_filter_release(&filter_options);
>         return 0;
>  }
>
> @@ -1994,6 +2005,7 @@ struct submodule_update_clone {
>         const char *recursive_prefix;
>         const char *prefix;
>         int single_branch;
> +       struct list_objects_filter_options *filter_options;
>
>         /* to be consumed by git-submodule.sh */
>         struct update_clone_data *update_clone;
> @@ -2154,6 +2166,9 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
>                 strvec_pushl(&child->args, "--prefix", suc->prefix, NULL);
>         if (suc->recommend_shallow && sub->recommend_shallow == 1)
>                 strvec_push(&child->args, "--depth=1");
> +       if (suc->filter_options && suc->filter_options->choice)
> +               strvec_pushf(&child->args, "--filter=%s",
> +                            expand_list_objects_filter_spec(suc->filter_options));
>         if (suc->require_init)
>                 strvec_push(&child->args, "--require-init");
>         strvec_pushl(&child->args, "--path", sub->path, NULL);
> @@ -2498,6 +2513,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
>         const char *update = NULL;
>         struct pathspec pathspec;
>         struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
> +       struct list_objects_filter_options filter_options;
> +       int ret;
>
>         struct option module_update_clone_options[] = {
>                 OPT_STRING(0, "prefix", &prefix,
> @@ -2528,6 +2545,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
>                            N_("disallow cloning into non-empty directory")),
>                 OPT_BOOL(0, "single-branch", &suc.single_branch,
>                          N_("clone only one branch, HEAD or --branch")),
> +               OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
>                 OPT_END()
>         };
>
> @@ -2540,20 +2558,26 @@ static int update_clone(int argc, const char **argv, const char *prefix)
>         update_clone_config_from_gitmodules(&suc.max_jobs);
>         git_config(git_update_clone_config, &suc.max_jobs);
>
> +       memset(&filter_options, 0, sizeof(filter_options));
>         argc = parse_options(argc, argv, prefix, module_update_clone_options,
>                              git_submodule_helper_usage, 0);
> +       suc.filter_options = &filter_options;
>
>         if (update)
>                 if (parse_submodule_update_strategy(update, &suc.update) < 0)
>                         die(_("bad value for update parameter"));
>
> -       if (module_list_compute(argc, argv, prefix, &pathspec, &suc.list) < 0)
> +       if (module_list_compute(argc, argv, prefix, &pathspec, &suc.list) < 0) {
> +               list_objects_filter_release(&filter_options);
>                 return 1;
> +       }
>
>         if (pathspec.nr)
>                 suc.warn_if_uninitialized = 1;
>
> -       return update_submodules(&suc);
> +       ret = update_submodules(&suc);
> +       list_objects_filter_release(&filter_options);
> +       return ret;
>  }
>
>  static int run_update_procedure(int argc, const char **argv, const char *prefix)
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 652861aa66..926f6873d3 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -10,7 +10,7 @@ USAGE="[--quiet] [--cached]
>     or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
>     or: $dashless [--quiet] init [--] [<path>...]
>     or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
> -   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--[no-]single-branch] [--] [<path>...]
> +   or: $dashless [--quiet] update [--init [--filter=<filter-spec>]] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--[no-]single-branch] [--] [<path>...]
>     or: $dashless [--quiet] set-branch (--default|--branch <branch>) [--] <path>
>     or: $dashless [--quiet] set-url [--] <path> <newurl>
>     or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
> @@ -49,6 +49,7 @@ dissociate=
>  single_branch=
>  jobs=
>  recommend_shallow=
> +filter=
>
>  die_if_unmatched ()
>  {
> @@ -347,6 +348,14 @@ cmd_update()
>                 --no-single-branch)
>                         single_branch="--no-single-branch"
>                         ;;
> +               --filter)
> +                       case "$2" in '') usage ;; esac
> +                       filter="--filter=$2"
> +                       shift
> +                       ;;
> +               --filter=*)
> +                       filter=$1

Shouldn't this be
     filter="$1"
?  I think it'd work currently without the quotes, but seeing the
discussion of special characters for --filter=combine in
git-rev-list(1) make me worry that this could become unsafe in the
future.

> +                       ;;
>                 --)
>                         shift
>                         break
> @@ -361,6 +370,11 @@ cmd_update()
>                 shift
>         done
>
> +       if test -n "$filter" && test "$init" != "1"
> +       then
> +               usage
> +       fi
> +
>         if test -n "$init"
>         then
>                 cmd_init "--" "$@" || return
> @@ -379,6 +393,7 @@ cmd_update()
>                 $single_branch \
>                 $recommend_shallow \
>                 $jobs \
> +               $filter \
>                 -- \
>                 "$@" || echo "#unmatched" $?
>         } | {
> diff --git a/t/t5617-clone-submodules-remote.sh b/t/t5617-clone-submodules-remote.sh
> index e2dbb4eaba..bc4fa11d51 100755
> --- a/t/t5617-clone-submodules-remote.sh
> +++ b/t/t5617-clone-submodules-remote.sh
> @@ -28,6 +28,13 @@ test_expect_success 'setup' '
>         )
>  '
>
> +# bare clone giving "srv.bare" for use as our server.
> +test_expect_success 'setup bare clone for server' '
> +       git clone --bare "file://$(pwd)/." srv.bare &&
> +       git -C srv.bare config --local uploadpack.allowfilter 1 &&
> +       git -C srv.bare config --local uploadpack.allowanysha1inwant 1
> +'
> +
>  test_expect_success 'clone with --no-remote-submodules' '
>         test_when_finished "rm -rf super_clone" &&
>         git clone --recurse-submodules --no-remote-submodules "file://$pwd/." super_clone &&
> @@ -65,4 +72,14 @@ test_expect_success 'clone with --single-branch' '
>         )
>  '
>
> +# do basic partial clone from "srv.bare"
> +# confirm partial clone was registered in the local config for super and sub.
> +test_expect_success 'clone with --filter' '
> +       git clone --recurse-submodules --filter blob:none "file://$pwd/srv.bare" super_clone &&
> +       test_cmp_config -C super_clone 1 core.repositoryformatversion &&
> +       test_cmp_config -C super_clone blob:none remote.origin.partialclonefilter &&
> +       test_cmp_config -C super_clone/sub 1 core.repositoryformatversion &&
> +       test_cmp_config -C super_clone/sub blob:none remote.origin.partialclonefilter
> +'
> +
>  test_done
> diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
> index 058e5d0c96..f7452af262 100755
> --- a/t/t7814-grep-recurse-submodules.sh
> +++ b/t/t7814-grep-recurse-submodules.sh
> @@ -544,4 +544,40 @@ test_expect_failure 'grep saves textconv cache in the appropriate repository' '
>         test_path_is_file "$sub_textconv_cache"
>  '
>
> +test_expect_success 'grep partially-cloned submodule' '
> +       # Set up clean superproject and submodule for partial cloning.
> +       git init super &&
> +       git init super/sub &&
> +       (
> +               cd super &&
> +               test_commit --no-tag "Add file in superproject" super-file "Some content for super-file" &&
> +               test_commit -C sub --no-tag "Add file in submodule" sub-file "Some content for sub-file" &&
> +               git submodule add ./sub &&
> +               git commit -m "Add other as submodule sub" &&
> +               test_tick &&
> +               test_commit -C sub --no-tag --append "Update file in submodule" sub-file "Some more content for sub-file" &&
> +               git add sub &&
> +               git commit -m "Update submodule" &&
> +               test_tick &&
> +               git config --local uploadpack.allowfilter 1 &&
> +               git config --local uploadpack.allowanysha1inwant 1 &&
> +               git -C sub config --local uploadpack.allowfilter 1 &&
> +               git -C sub config --local uploadpack.allowanysha1inwant 1
> +       ) &&
> +       # Clone the superproject & submodule, then make sure we can lazy-fetch submodule objects.
> +       git clone --filter=blob:none --recurse-submodules "file://$(pwd)/super" partial &&
> +       (
> +               cd partial &&
> +               cat >expect <<-\EOF &&
> +               HEAD^:sub/sub-file:Some content for sub-file
> +               HEAD^:super-file:Some content for super-file
> +               EOF
> +
> +               GIT_TRACE2_EVENT="$(pwd)/trace2.log" git grep -e content --recurse-submodules HEAD^ >actual &&
> +               test_cmp expect actual &&
> +               # Verify that we actually fetched data from the promisor remote:
> +               grep \"category\":\"promisor\",\"key\":\"fetch_count\",\"value\":\"1\" trace2.log >/dev/null
> +       )
> +'
> +
>  test_done
>
> base-commit: b56bd95bbc8f716cb8cbb5fdc18b9b0f00323c6a
> --
> 2.35.0.rc0.227.g00780c9af4-goog

I didn't spot anything else in the patch implementation, though I
commented in response to Junio about my concerns about how this might
interact with future filters.
