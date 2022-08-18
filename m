Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6456C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 07:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243733AbiHRHBV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 03:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243728AbiHRHBT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 03:01:19 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1D486B6C
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 00:01:17 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id j1so602419qvv.8
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 00:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5IgoViy2iHSnjluLxAbtERIC47H1GerAGkBYZ8ijfOo=;
        b=U9u83P8tEVtCwx4xvnpRL7lQEB9AdW260s+ktdshUeAr9zIP+G2J8MAPp3fUhpBCMY
         hxdlkZ2HBMMmdjckZRIVkhgQqc6d5WVjulgSFc3e1ZtorQXao22Kf1Fk9Clzr5AQdiIh
         YVP84Acj6nixpDWJ9SLDmQ8Q2VAM+MVFypaKDMvQnFWmph0U2tdc0tbcx5is2mrMZQUJ
         C/PolHFG9aaUJbpYcSetEzJIGR6qiMrBEYQkt005P8aWYMXVPszGcv2VnKhzIt71vWov
         DbLeff9hDDy97IQw3iRUXbY23uBOCbv1qanLz6hheRXSfc7h82Y4SFzXEmCbHiKNfdQ8
         126Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5IgoViy2iHSnjluLxAbtERIC47H1GerAGkBYZ8ijfOo=;
        b=DpWFHTQAadf8po707JZQdaVkv5VUcClyLHvPSul9eUaOyTegCdDoT8MErT5MMcSAcV
         lnc5iB0+AqO4ctcOFjeS/c5+ZzrVqUtD4rh3cumjbmf7BcPPQ6SYk8TscQ4HWajwp7EU
         UJA4jGoLFNLLG+p2RcWCb7UlyvpGiWhTswthHLY6Ai2tqOxrU6im/RHXB5EfbK0QIXvE
         Y2Mp0NeUPu8hCQtpIu/nuFNBzathZZIVFRFSpk6/VrfRtIS2ESNZVK/aCgzFKxtRHSb6
         iq04LR1OkH0W3MCSkPqDmDDJ/oNNeJ+UcVg4eYRCOrjsPDoUdAJPSgd3GHoHx0m4ct+3
         t1BQ==
X-Gm-Message-State: ACgBeo2ZIax6b3PEyBwb3ZNZCFKEbZhigoQVVjXLWP1a7Bmw6ZlYZEoM
        ct0Kkx9GQW0Bob0c5GVV3IEQ5DAjHKK863LY0awLs4B0
X-Google-Smtp-Source: AA6agR4HvwvUwTRKCful/6xF4vvgw7LrA9KD8hT1edWlXdxc8WzR7wvf32oneWaB6mRVDx69vehS8XS3Y+ygcu53yA8=
X-Received: by 2002:a05:6214:27e4:b0:476:be6a:91c1 with SMTP id
 jt4-20020a05621427e400b00476be6a91c1mr1278866qvb.39.1660806076489; Thu, 18
 Aug 2022 00:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com> <cced4a48360b4e4a8ce791e9404ac6b37bae4eba.1660576283.git.gitgitgadget@gmail.com>
In-Reply-To: <cced4a48360b4e4a8ce791e9404ac6b37bae4eba.1660576283.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 18 Aug 2022 00:01:05 -0700
Message-ID: <CABPp-BHu0tt25Be6aAqGNwNYNLMyp-L7=J9XT9H-oFMmZhPLqw@mail.gmail.com>
Subject: Re: [PATCH 2/5] rebase: store orig_head as a commit
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 15, 2022 at 8:14 AM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Using a struct commit rather than a struct oid to hold orig_head means
> that we error out straight away if branch being rebased does not point
> to a commit. It also simplifies the code than handles finding the

s/than/that/ ?


> merge base and fork point as it not longer has to convert from an oid
> to a commit.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/rebase.c | 62 ++++++++++++++++++++++--------------------------
>  1 file changed, 28 insertions(+), 34 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 56e4214b441..6cf9c95f4e1 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -68,7 +68,7 @@ struct rebase_options {
>         const char *upstream_name;
>         const char *upstream_arg;
>         char *head_name;
> -       struct object_id orig_head;
> +       struct commit *orig_head;
>         struct commit *onto;
>         const char *onto_name;
>         const char *revisions;
> @@ -261,13 +261,13 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
>         struct replay_opts replay = get_replay_opts(opts);
>         struct string_list commands = STRING_LIST_INIT_DUP;
>
> -       if (get_revision_ranges(opts->upstream, opts->onto, &opts->orig_head,
> +       if (get_revision_ranges(opts->upstream, opts->onto, &opts->orig_head->object.oid,
>                                 &revisions, &shortrevisions))
>                 return -1;
>
>         if (init_basic_state(&replay,
>                              opts->head_name ? opts->head_name : "detached HEAD",
> -                            opts->onto, &opts->orig_head)) {
> +                            opts->onto, &opts->orig_head->object.oid)) {
>                 free(revisions);
>                 free(shortrevisions);
>
> @@ -298,9 +298,8 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
>                 split_exec_commands(opts->cmd, &commands);
>                 ret = complete_action(the_repository, &replay, flags,
>                         shortrevisions, opts->onto_name, opts->onto,
> -                       &opts->orig_head, &commands, opts->autosquash,
> -                       opts->update_refs,
> -                       &todo_list);
> +                       &opts->orig_head->object.oid, &commands,
> +                       opts->autosquash, opts->update_refs, &todo_list);
>         }
>
>         string_list_clear(&commands, 0);
> @@ -448,7 +447,8 @@ static int read_basic_state(struct rebase_options *opts)
>         } else if (!read_oneliner(&buf, state_dir_path("head", opts),
>                                   READ_ONELINER_WARN_MISSING))
>                 return -1;
> -       if (get_oid(buf.buf, &opts->orig_head))
> +       opts->orig_head = lookup_commit_reference_by_name(buf.buf);
> +       if (!opts->orig_head)
>                 return error(_("invalid orig-head: '%s'"), buf.buf);
>
>         if (file_exists(state_dir_path("quiet", opts)))
> @@ -517,7 +517,7 @@ static int rebase_write_basic_state(struct rebase_options *opts)
>         write_file(state_dir_path("onto", opts), "%s",
>                    opts->onto ? oid_to_hex(&opts->onto->object.oid) : "");
>         write_file(state_dir_path("orig-head", opts), "%s",
> -                  oid_to_hex(&opts->orig_head));
> +                  oid_to_hex(&opts->orig_head->object.oid));
>         if (!(opts->flags & REBASE_NO_QUIET))
>                 write_file(state_dir_path("quiet", opts), "%s", "");
>         if (opts->flags & REBASE_VERBOSE)
> @@ -646,7 +646,7 @@ static int run_am(struct rebase_options *opts)
>                                /* this is now equivalent to !opts->upstream */
>                                &opts->onto->object.oid :
>                                &opts->upstream->object.oid),
> -                   oid_to_hex(&opts->orig_head));
> +                   oid_to_hex(&opts->orig_head->object.oid));
>
>         rebased_patches = xstrdup(git_path("rebased-patches"));
>         format_patch.out = open(rebased_patches,
> @@ -680,7 +680,7 @@ static int run_am(struct rebase_options *opts)
>                 free(rebased_patches);
>                 strvec_clear(&am.args);
>
> -               ropts.oid = &opts->orig_head;
> +               ropts.oid = &opts->orig_head->object.oid;
>                 ropts.branch = opts->head_name;
>                 ropts.default_reflog_action = DEFAULT_REFLOG_ACTION;
>                 reset_head(the_repository, &ropts);
> @@ -833,7 +833,7 @@ static int checkout_up_to_date(struct rebase_options *options)
>         strbuf_addf(&buf, "%s: checkout %s",
>                     getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
>                     options->switch_to);
> -       ropts.oid = &options->orig_head;
> +       ropts.oid = &options->orig_head->object.oid;
>         ropts.branch = options->head_name;
>         ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
>         if (!ropts.branch)
> @@ -866,15 +866,11 @@ static int is_linear_history(struct commit *from, struct commit *to)
>
>  static int can_fast_forward(struct commit *onto, struct commit *upstream,
>                             struct commit *restrict_revision,
> -                           struct object_id *head_oid, struct object_id *merge_base)
> +                           struct commit *head, struct object_id *merge_base)
>  {
> -       struct commit *head = lookup_commit(the_repository, head_oid);
>         struct commit_list *merge_bases = NULL;
>         int res = 0;
>
> -       if (!head)
> -               goto done;
> -
>         merge_bases = get_merge_bases(onto, head);
>         if (!merge_bases || merge_bases->next) {
>                 oidcpy(merge_base, null_oid());
> @@ -1312,13 +1308,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>
>                 if (read_basic_state(&options))
>                         exit(1);
> -               ropts.oid = &options.orig_head;
> +               ropts.oid = &options.orig_head->object.oid;
>                 ropts.branch = options.head_name;
>                 ropts.flags = RESET_HEAD_HARD;
>                 ropts.default_reflog_action = DEFAULT_REFLOG_ACTION;
>                 if (reset_head(the_repository, &ropts) < 0)
>                         die(_("could not move back to %s"),
> -                           oid_to_hex(&options.orig_head));
> +                           oid_to_hex(&options.orig_head->object.oid));
>                 remove_branch_state(the_repository, 0);
>                 ret = finish_rebase(&options);
>                 goto cleanup;
> @@ -1610,17 +1606,17 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>                 /* Is it a local branch? */
>                 strbuf_reset(&buf);
>                 strbuf_addf(&buf, "refs/heads/%s", branch_name);
> -               if (!read_ref(buf.buf, &options.orig_head)) {
> +               options.orig_head = lookup_commit_reference_by_name(buf.buf);
> +               if (options.orig_head) {
>                         die_if_checked_out(buf.buf, 1);
>                         options.head_name = xstrdup(buf.buf);
>                 /* If not is it a valid ref (branch or commit)? */
>                 } else {
> -                       struct commit *commit =
> +                       options.orig_head =
>                                 lookup_commit_reference_by_name(branch_name);
> -                       if (!commit)
> +                       if (!options.orig_head)
>                                 die(_("no such branch/commit '%s'"),
>                                     branch_name);
> -                       oidcpy(&options.orig_head, &commit->object.oid);
>                         options.head_name = NULL;
>                 }
>         } else if (argc == 0) {
> @@ -1639,8 +1635,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>                         FREE_AND_NULL(options.head_name);
>                         branch_name = "HEAD";
>                 }
> -               if (get_oid("HEAD", &options.orig_head))
> -                       die(_("Could not resolve HEAD to a revision"));
> +               options.orig_head = lookup_commit_reference_by_name("HEAD");
> +               if (!options.orig_head)
> +                       die(_("Could not resolve HEAD to a commit"));
>         } else
>                 BUG("unexpected number of arguments left to parse");
>
> @@ -1672,13 +1669,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>                                 options.onto_name);
>         }
>
> -       if (options.fork_point > 0) {
> -               struct commit *head =
> -                       lookup_commit_reference(the_repository,
> -                                               &options.orig_head);
> +       if (options.fork_point > 0)
>                 options.restrict_revision =
> -                       get_fork_point(options.upstream_name, head);
> -       }
> +                       get_fork_point(options.upstream_name, options.orig_head);
> +
>
>         if (repo_read_index(the_repository) < 0)
>                 die(_("could not read index"));
> @@ -1708,7 +1702,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>          * call it before checking allow_preemptive_ff.
>          */
>         if (can_fast_forward(options.onto, options.upstream, options.restrict_revision,
> -                   &options.orig_head, &merge_base) &&
> +                   options.orig_head, &merge_base) &&
>             allow_preemptive_ff) {
>                 int flag;
>
> @@ -1785,7 +1779,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>         strbuf_addf(&msg, "%s: checkout %s",
>                     getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
>         ropts.oid = &options.onto->object.oid;
> -       ropts.orig_head = &options.orig_head,
> +       ropts.orig_head = &options.orig_head->object.oid,
>         ropts.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
>                         RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
>         ropts.head_msg = msg.buf;
> @@ -1799,7 +1793,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>          * we just fast-forwarded.
>          */
>         strbuf_reset(&msg);
> -       if (oideq(&merge_base, &options.orig_head)) {
> +       if (oideq(&merge_base, &options.orig_head->object.oid)) {
>                 printf(_("Fast-forwarded %s to %s.\n"),
>                         branch_name, options.onto_name);
>                 strbuf_addf(&msg, "rebase finished: %s onto %s",
> @@ -1820,7 +1814,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>                     (options.restrict_revision ?
>                      oid_to_hex(&options.restrict_revision->object.oid) :
>                      oid_to_hex(&options.upstream->object.oid)),
> -                   oid_to_hex(&options.orig_head));
> +                   oid_to_hex(&options.orig_head->object.oid));
>
>         options.revisions = revisions.buf;
>
> --
> gitgitgadget
>
