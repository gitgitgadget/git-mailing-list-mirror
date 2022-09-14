Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E15DECAAD8
	for <git@archiver.kernel.org>; Wed, 14 Sep 2022 06:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiINGJr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Sep 2022 02:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiINGJP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2022 02:09:15 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23AE72B64
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 23:08:45 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id w4so11002368qvp.2
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 23:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=uvXGdZ/2Eod1WECtEqAtisGuhq8SEN8TYzwOSkq320Y=;
        b=K2TZmO3GXpimpZ0WFiQ7utqLNd6RHVXtPhUrorxGh3eyJmQOtQNbhDYAhI57spFLc6
         xScK1OfumsmT3Ul+6AEP78HVM8ATHZ7SdD8OfFaTne4e38IeH01xNlwXUHkqoflaw+In
         FHdxc1LOZwrHjqtyrQvkgPp5CdVnzCgVuQcgPAtPJujCQqq72LwGD40gWFycj31PQy6X
         2twYsV7/hqnXloH4zHgV1Zn/6nE0LwlDJ0EVdZr1y9VsSuVEPc4zyBvM3LjniK0SUzh1
         cOrZEpl8j9b2DOwE2A+z/3JyRZI5h9yk1SfyXw5ygug80f1XisnTR1vO151WsN45Teo3
         Ifcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=uvXGdZ/2Eod1WECtEqAtisGuhq8SEN8TYzwOSkq320Y=;
        b=e9jHPY2RfNC30V4MdLlgHSgwt53nONNPLrU9pLeV0IiO7TRONEddi7QJx86By9zlfa
         rr4P9pjnaxiJ5j6Lzv445G4Cws/uzTiAuo9xnTLlZwryCPwudE0NkGEcgfdc0qcuZMmP
         hR3dNvsLg9K4r0FVu5pdPIxahw9OB+8R7iknxdgKofpNbPleuP31PjMnTFRbIO5rsikE
         8B9BKEJxm2c38Ae4jyblvqTd58Cjo9XbYRGPt5dhDfw8k4rURY0++Yofs7jvcR9spwbC
         2rHMOH93m9ESacz5taoOuQgJchvmMBff2SgcJi0PtAvii908p4mhtPbuKiBexJgTFhgO
         TWoQ==
X-Gm-Message-State: ACgBeo0ZzgGRnOZN0HeyLfpwCo/96g8cUJLic1gvu209fp3dSlzXH7cD
        udu1KubyTfaLF4//BP0HDshucuI/KC35u2Y3RFQ=
X-Google-Smtp-Source: AA6agR7zPjkM7cGOCBySoTjBjMosXDsZAOZ3+A9uIOQrjXoNpkHDFpPnBd9Qh5vBeow8baUnyOZ7l8G2r61J36U/v3s=
X-Received: by 2002:ad4:5bee:0:b0:4ac:d9d2:d630 with SMTP id
 k14-20020ad45bee000000b004acd9d2d630mr2726844qvc.65.1663135724127; Tue, 13
 Sep 2022 23:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220908001854.206789-1-shaoxuan.yuan02@gmail.com> <20220908001854.206789-2-shaoxuan.yuan02@gmail.com>
In-Reply-To: <20220908001854.206789-2-shaoxuan.yuan02@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 13 Sep 2022 23:08:32 -0700
Message-ID: <CABPp-BF-z72=hY_Jf8h3g95s+wwZOsV_S=+dDNs_AVskQxoaTw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] builtin/grep.c: add --sparse option
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shaoxuan,

Please note that it's customary to cc folks who have commented on
previous versions of your patch series when you re-roll.

On Wed, Sep 7, 2022 at 5:28 PM Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> wrote:
>
> Add a --sparse option to `git-grep`.

It's awesome you're working on this.  Adding more of "behavior A"
(restricting querying commands to the sparse cone) is something I've
wanted for a long time.

I think most of your code is beneficial, but I do have some issues
with high level direction you were implementing, which may require
some tweaks...

> When the '--cached' option is used with the 'git grep' command, the
> search is limited to the blobs found in the index, not in the worktree.
> If the user has enabled sparse-checkout, this might present more results
> than they would like, since the files outside of the sparse-checkout are
> unlikely to be important to them.

"files outside of the sparse-checkout are unlikely to be important to
[users]" is certainly an issue.  But it's *much* wider than this.
Beyond `grep --cached`, it also affects `grep REVISION`, `log`, `diff
[REVISION]`, and related things...perhaps even something like `blame`.
I think all those other commands probably deserve a mode where they
restrict output to the view associated with the user's cone.  I've
brought that up before[1].  I was skeptical of making it the default,
because it'd probably take a long time to implement it everywhere.
Slowly changing defaults of all commands over many git releases seems
like a poor strategy, but I'm afraid that's what it looks like we are
doing here.

I'm also worried that slowly changing the defaults without a
high-level plan will lead to users struggling to figure out what
flag(s) to pass.  Are we going to be stuck in a situation where users
have to remember that for a dense search, they use one flag for `grep
--cached`, a different one for  `grep [REVISION]`, no flag is needed
for `diff [REVISION]`, but yet a different flag is needed for `git
log`?

I'm also curious whether there shouldn't be a config option for
something like this, so folks don't have to specify it with every
invocation.  In particular, while I certainly have users that want to
just query git for information about the part of the history they are
interested in, there are other users who are fully aware they are
working in a bigger repository and want to search for additional
things to add to their sparse-checkout and predominantly use grep for
things like that.  They have even documented that `git grep --cached
<TERM>` can be used in sparse-checkouts for this purpose...and have
been using that for a few years.  (I did warn them at the time that
there was a risk they'd have to change their command, but it's still
going to be a behavioral change they might not expect.)  Further, when
I brought up changing the behavior of commands during sparse-checkouts
to limit to files matching the sparsity paths in that old thread at
[1], Stolee was a bit skeptical of making that the default.  That
suggests, at least, that two independent groups of users would want to
use the non-sparse searching frequently, and frequently enough that
they'd appreciate a config option.

I also brought up in that old thread that perhaps we want to avoid
adding a flag to every subcommand, and instead just having a
git-global flag for triggering this type of behavior.  (e.g. `git
--no-restrict grep --cached ...` or `git --dense grep --cached ...`).

[1] https://lore.kernel.org/git/CABPp-BGJ_Nvi5TmgriD9Bh6eNXE2EDq2f8e8QKXAeYG3BxZafA@mail.gmail.com/
and the responses to that email.

> Change the default behavior of 'git grep' to focus on the files within
> the sparse-checkout definition. To enable the previous behavior, add a
> '--sparse' option to 'git grep' that triggers the old behavior that
> inspects paths outside of the sparse-checkout definition when paired
> with the '--cached' option.

I still think the flag name of `--sparse` is totally backwards and
highly confusing for the described behavior.  I missed Stolee's email
at the time (wasn't cc'ed) where he brought up that "--sparse" had
already been added to "git-add" and "git-rm", but in those cases the
commands aren't querying and I just don't see how they lead to the
same level of user confusion.  This one seems glaringly wrong to me
and both Junio and I flagged it on v1 when we first saw it.  (Perhaps
it also helps that for the add/rm cases, that a user is often given an
error message with the suggested flag to use, which just doesn't make
sense here either.)  If there is concern that this flag should be the
same as add and rm, then I think we need to do the backward
compatibility dance and fix add and rm by adding an alias over there
so that grep's flag won't be so confusing.

I really don't want to have to deal with the backward compatibility
headache of "git grep --sparse" means do a non-sparse search for
backward compatibility reasons.  Here's the flag you should really
use..."

> Suggested-by: Victoria Dye <vdye@github.com>
> Helped-by: Derrick Stolee <derrickstolee@github.com>
> Helped-by: Victoria Dye <vdye@github.com>
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
>  Documentation/git-grep.txt      |  5 ++++-
>  builtin/grep.c                  | 10 +++++++++-
>  t/t7817-grep-sparse-checkout.sh | 34 +++++++++++++++++++++++++++------
>  3 files changed, 41 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index 58d944bd57..bdd3d5b8a6 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -28,7 +28,7 @@ SYNOPSIS
>            [-f <file>] [-e] <pattern>
>            [--and|--or|--not|(|)|-e <pattern>...]
>            [--recurse-submodules] [--parent-basename <basename>]
> -          [ [--[no-]exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
> +          [ [--[no-]exclude-standard] [--cached [--sparse] | --no-index | --untracked] | <tree>...]
>            [--] [<pathspec>...]
>
>  DESCRIPTION
> @@ -45,6 +45,9 @@ OPTIONS
>         Instead of searching tracked files in the working tree, search
>         blobs registered in the index file.
>
> +--sparse::
> +       Use with --cached. Search outside of sparse-checkout definition.
> +
>  --no-index::
>         Search files in the current directory that is not managed by Git.
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index e6bcdf860c..12abd832fa 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -96,6 +96,8 @@ static pthread_cond_t cond_result;
>
>  static int skip_first_line;
>
> +static int grep_sparse = 0;
> +
>  static void add_work(struct grep_opt *opt, struct grep_source *gs)
>  {
>         if (opt->binary != GREP_BINARY_TEXT)
> @@ -525,7 +527,11 @@ static int grep_cache(struct grep_opt *opt,
>         for (nr = 0; nr < repo->index->cache_nr; nr++) {
>                 const struct cache_entry *ce = repo->index->cache[nr];
>
> -               if (!cached && ce_skip_worktree(ce))
> +               /*
> +                * Skip entries with SKIP_WORKTREE unless both --sparse and
> +                * --cached are given.
> +                */
> +               if (!(grep_sparse && cached) && ce_skip_worktree(ce))
>                         continue;
>
>                 strbuf_setlen(&name, name_base_len);
> @@ -963,6 +969,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>                            PARSE_OPT_NOCOMPLETE),
>                 OPT_INTEGER('m', "max-count", &opt.max_count,
>                         N_("maximum number of results per file")),
> +               OPT_BOOL(0, "sparse", &grep_sparse,
> +                        N_("search the contents of files outside the sparse-checkout definition")),
>                 OPT_END()
>         };
>         grep_prefix = prefix;
> diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
> index eb59564565..a9879cc980 100755
> --- a/t/t7817-grep-sparse-checkout.sh
> +++ b/t/t7817-grep-sparse-checkout.sh
> @@ -118,13 +118,19 @@ test_expect_success 'grep searches unmerged file despite not matching sparsity p
>         test_cmp expect actual
>  '
>
> -test_expect_success 'grep --cached searches entries with the SKIP_WORKTREE bit' '
> +test_expect_success 'grep --cached and --sparse searches entries with the SKIP_WORKTREE bit' '
> +       cat >expect <<-EOF &&
> +       a:text
> +       EOF
> +       git grep --cached "text" >actual &&
> +       test_cmp expect actual &&
> +
>         cat >expect <<-EOF &&
>         a:text
>         b:text
>         dir/c:text
>         EOF
> -       git grep --cached "text" >actual &&
> +       git grep --cached --sparse "text" >actual &&
>         test_cmp expect actual
>  '
>
> @@ -143,7 +149,15 @@ test_expect_success 'grep --recurse-submodules honors sparse checkout in submodu
>         test_cmp expect actual
>  '
>
> -test_expect_success 'grep --recurse-submodules --cached searches entries with the SKIP_WORKTREE bit' '
> +test_expect_success 'grep --recurse-submodules --cached and --sparse searches entries with the SKIP_WORKTREE bit' '
> +       cat >expect <<-EOF &&
> +       a:text
> +       sub/B/b:text
> +       sub2/a:text
> +       EOF
> +       git grep --recurse-submodules --cached "text" >actual &&
> +       test_cmp expect actual &&
> +
>         cat >expect <<-EOF &&
>         a:text
>         b:text
> @@ -152,7 +166,7 @@ test_expect_success 'grep --recurse-submodules --cached searches entries with th
>         sub/B/b:text
>         sub2/a:text
>         EOF
> -       git grep --recurse-submodules --cached "text" >actual &&
> +       git grep --recurse-submodules --cached --sparse "text" >actual &&
>         test_cmp expect actual
>  '
>
> @@ -166,7 +180,15 @@ test_expect_success 'working tree grep does not search the index with CE_VALID a
>         test_cmp expect actual
>  '
>
> -test_expect_success 'grep --cached searches index entries with both CE_VALID and SKIP_WORKTREE' '
> +test_expect_success 'grep --cached and --sparse searches index entries with both CE_VALID and SKIP_WORKTREE' '
> +       cat >expect <<-EOF &&
> +       a:text
> +       EOF
> +       test_when_finished "git update-index --no-assume-unchanged b" &&
> +       git update-index --assume-unchanged b &&
> +       git grep --cached text >actual &&
> +       test_cmp expect actual &&
> +
>         cat >expect <<-EOF &&
>         a:text
>         b:text
> @@ -174,7 +196,7 @@ test_expect_success 'grep --cached searches index entries with both CE_VALID and
>         EOF
>         test_when_finished "git update-index --no-assume-unchanged b" &&
>         git update-index --assume-unchanged b &&
> -       git grep --cached text >actual &&
> +       git grep --cached --sparse text >actual &&
>         test_cmp expect actual
>  '
>
> --
> 2.37.0

I read over this patch and the other two patches.  Other than things
like variable names propagating the sparse/dense confusion, and the
high level goals already discussed, I didn't spot any other issues.
