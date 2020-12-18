Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24703C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 06:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD0B9207AB
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 06:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732670AbgLRGNE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 01:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbgLRGND (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 01:13:03 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A51CC0617A7
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 22:12:23 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id l200so1706106oig.9
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 22:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ggx17cs85ytm6+RfeaYCIfIrVZnEk2AzKlxbEOFnsZc=;
        b=Ipt63zKg8gA25VS8515MDzBqTE8+cNtLGFjjDc0O4jdvRrg6yzB+CSwvP8oJm8JOCE
         FsSpTqGTz+IKE7ByV9XH/sHKzQWEX7LjzQcMWr+ELH8XQTXibVfTrJMfO/eqq1r0WGqI
         A/DozGZC/h+guKwjoq9a2MF9aqQv8s4Ly8h+6ERQH1IwLSR8Gwt7orUFSH7cfckjVFYB
         iLQR4z/1vZFh3U2Ry1Jq833QHbP4BXmiks08kDI0iQlUL+AzE0Lz+cKtCtStc6RJDPUJ
         y8Qb5HUWh1jJYt2+fyLNreYlj5+78LEz8XNzKsa2QSdtkRSb0rpqgJKfjU0y8jLk2v9w
         o0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ggx17cs85ytm6+RfeaYCIfIrVZnEk2AzKlxbEOFnsZc=;
        b=a+qHM9BXEoSugg/sIL9HAuB3jVcilv6pTRuAMKlmnj0bm2R68G3uoEj1dGzp+Nb4Ez
         Cr+A7/wtlNDm2PNp2kvSqs1a+lv3gwrdAA+zxpWHi39BOu51KaUb1sHL3HEqe1pErx6o
         YZFLrEkvu5Phk3FShkBJuLoOUGwmmju62RPwK0HvMjVYQRFqrxLB8E2wVpVX5y8WajIb
         Sn/4UgPeqWtTuRhTbrbtret7NDc/aSBmInQWL2TO0OWJdfx4wbdJFqcN52KDTIHnuwfM
         o+9vyfXbtM6kNpmKKkrtaF0q5yKqxj0HJ6ugv9Cjb8xQVBrFkebVGKTPUlHf2JSo8uf+
         X/jw==
X-Gm-Message-State: AOAM533TWMF+fzSlzpmAfkp8i95HQA0NvZR9e05c7U7w7tdMARW9raxf
        cg/DKk/9TtBpzCWUGljswIN1LlPoSHX3/pkXCVY=
X-Google-Smtp-Source: ABdhPJw+LVQENUM5jjHZLATlMWNzppMuarQf76sHMSZ+842dBeSG58Ij7t/9OUwrUxrMfGAvtYkk4D/flo0ehNug8xI=
X-Received: by 2002:aca:3151:: with SMTP id x78mr1784658oix.39.1608271942755;
 Thu, 17 Dec 2020 22:12:22 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <20201216184929.3924-1-sorganov@gmail.com>
 <20201216184929.3924-27-sorganov@gmail.com>
In-Reply-To: <20201216184929.3924-27-sorganov@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 17 Dec 2020 22:12:11 -0800
Message-ID: <CABPp-BHu2xLZLfwBg+hzNEKQ0K=EyT1HLqJO9=pNzBFf4MqR=A@mail.gmail.com>
Subject: Re: [PATCH v2 26/33] diff-merges: let new options enable diff without -p
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> New options don't have any visible effect unless -p is either given or
> implied, as unlike -c/-cc we don't imply -p with --diff-merges. To fix
> this, this patch adds new functionality by letting new options enable
> output of diffs for merge commits only.
>
> Add 'merges_need_diff' field and set it whenever diff output for merges is
> enabled by any of the new options.
>
> Extend diff output logic accordingly, to output diffs for merges when
> 'merges_need_diff' is set even when no -p has been provided.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  diff-merges.c | 16 ++++++++++------
>  log-tree.c    | 13 +++++++++----
>  revision.h    |  1 +
>  3 files changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/diff-merges.c b/diff-merges.c
> index 725db2312074..ffe20d8daa4a 100644
> --- a/diff-merges.c
> +++ b/diff-merges.c
> @@ -10,6 +10,7 @@ static void suppress(struct rev_info *revs)
>         revs->dense_combined_merges = 0;
>         revs->combined_all_paths = 0;
>         revs->combined_imply_patch = 0;
> +       revs->merges_need_diff = 0;
>  }
>
>  static void set_separate(struct rev_info *revs)
> @@ -51,9 +52,11 @@ static void set_dense_combined(struct rev_info *revs)
>
>  static void set_diff_merges(struct rev_info *revs, const char *optarg)
>  {

> +       if (!strcmp(optarg, "off") || !strcmp(optarg, "none")) {
> +               suppress(revs);
> +               return;
> +       }
>         if (0) ;
> -       else if (!strcmp(optarg, "off")   || !strcmp(optarg, "none"))
> -               suppress(revs);

The "if (0) ;" is still really weird.

>         else if (!strcmp(optarg, "first") || !strcmp(optarg, "first-parent"))
>                 set_first_parent(revs);
>         else if (!strcmp(optarg, "sep")   || !strcmp(optarg, "separate"))
> @@ -64,6 +67,7 @@ static void set_diff_merges(struct rev_info *revs, const char *optarg)
>                 set_dense_combined(revs);
>         else
>                 die(_("unknown value for --diff-merges: %s"), optarg);
> +       revs->merges_need_diff = 1;

I'd put this above the if-else-else block, to make it clearer why you
are returning early for the "off"/"none" case.

>  }
>
>  /*
> @@ -132,12 +136,12 @@ void diff_merges_setup_revs(struct rev_info *revs)
>                 revs->first_parent_merges = 0;
>         if (revs->combined_all_paths && !revs->combine_merges)
>                 die("--combined-all-paths makes no sense without -c or --cc");
> -       if (revs->combine_merges)
> +
> +       if (revs->combined_imply_patch)
>                 revs->diff = 1;
> -       if (revs->combined_imply_patch) {
> -               /* Turn --cc/-c into -p --cc/-c when -p was not given */
> +
> +       if (revs->combined_imply_patch || revs->merges_need_diff) {
>                 if (!revs->diffopt.output_format)
>                         revs->diffopt.output_format = DIFF_FORMAT_PATCH;
>         }
> -

The random space changes squashed in here instead of being combined
with the earlier patches that introduced the relevant areas break up
the reading.  Would be nice to clean this up.

>  }
> diff --git a/log-tree.c b/log-tree.c
> index f9385b1dae6f..67060492ca0a 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -899,15 +899,21 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
>         int showed_log;
>         struct commit_list *parents;
>         struct object_id *oid;
> +       int is_merge;
> +       int regulars_need_diff = opt->diff || opt->diffopt.flags.exit_with_status;

So rev_info.diff has changed in meaning from
commits-need-to-show-a-diff, to non-merge-commits-need-to-show-a-diff.
That's a somewhat subtle semantic shift.  Perhaps it's worth adding a
comment to the declaration of rev_info.diff to highlight this?  (And
perhaps even rename the flag?)

> -       if (!opt->diff && !opt->diffopt.flags.exit_with_status)
> +       if (!regulars_need_diff && !opt->merges_need_diff)
>                 return 0;
>
>         parse_commit_or_die(commit);
>         oid = get_commit_tree_oid(commit);
>
> -       /* Root commit? */
>         parents = get_saved_parents(opt, commit);
> +       is_merge = parents && parents->next;
> +       if(!is_merge && !regulars_need_diff)
> +               return 0;
> +
> +       /* Root commit? */
>         if (!parents) {
>                 if (opt->show_root_diff) {
>                         diff_root_tree_oid(oid, "", &opt->diffopt);
> @@ -916,8 +922,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
>                 return !opt->loginfo;
>         }
>
> -       /* More than one parent? */
> -       if (parents->next) {
> +       if (is_merge) {
>                 if (opt->combine_merges)
>                         return do_diff_combined(opt, commit);
>                 if (opt->separate_merges) {
> diff --git a/revision.h b/revision.h
> index bfbae526ad6e..494d86142454 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -194,6 +194,7 @@ struct rev_info {
>                         always_show_header:1,
>                         /* Diff-merge flags */
>                         explicit_diff_merges: 1,
> +                       merges_need_diff: 1,
>                         separate_merges: 1,
>                         combine_merges:1,
>                         combined_all_paths:1,
> --
> 2.25.1

The rest makes sense.
