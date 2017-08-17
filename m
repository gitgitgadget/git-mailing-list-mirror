Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA48720899
	for <e@80x24.org>; Thu, 17 Aug 2017 17:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753563AbdHQRUR (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 13:20:17 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:35924 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752820AbdHQRUP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 13:20:15 -0400
Received: by mail-yw0-f174.google.com with SMTP id u207so45050393ywc.3
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 10:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=q6gIv3iP84MdUZPlogum65Wr9PjYxzzmsH2hxsd1vIQ=;
        b=VwANmULuEfeBBlHRtavcnJPL3z89bWCjc5fGrjosP+2eaQVQASWvgxyHbYKckfyMyF
         TTH0Q+0N/iaV63cRL+2+D3w06tw4EU9ObT1ZqV1N3wqxN7YFTQ/mOYsW0mJg76xYWje5
         aByv2lAP1eIHo/XlL2v9E5StAuFd3+h6P2uoPxVSvzFDQswCoMnN7ir5zp7td6+J5THz
         c/43k5lu8hZodalAB/A+kII1SOaa1zlrgmvReCl6UeCv10Q2mF0qkSC7ohy7lvpmIxgk
         1E8U+hMqOpp0S8cVZ8XoyjBoR2ZASjrkdyenMmKimi3YtDt7854wU3k1aEhJ0TurXWw/
         oXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=q6gIv3iP84MdUZPlogum65Wr9PjYxzzmsH2hxsd1vIQ=;
        b=mEJUTvY5SLKXuu8YX9bsKC5jrfY8qRbEDdQxf+FPmU5LMvszA6HvEXLuLRCKcSsFhx
         a3+lpxYP01e/cICpQ6mFZDTf2yJx39YcglkNFagvydxgqLuikA65hEi0CHvVSv54IQTD
         5bUI1tINe2L4J5/Z2sCq82Iffff61JgJiEfYstJ8mNj3rvf1cZU5kziA0Sbd11o2jWWl
         n94kS9+Sqxk4raeBX1Xam3B865BkZPcPtCeCHVuiK34GepQ22DDg0S0WxSVDDwvEA5hl
         KsRShTOyiVi3WvwwT+Cd8ASQ+QiIgpMaqT0WnhJpcmRCFyhGWC5E0qZHm2QcIHxRTh5A
         +arw==
X-Gm-Message-State: AHYfb5j79JMdI/XRndvLtzw74n9iZ+1HUUD9xTa97GozBK+aSJtN7MuY
        jaSBoVUSskHkLej4dOC0wW8U84cuDymx
X-Received: by 10.37.183.130 with SMTP id n2mr5025536ybh.353.1502990413701;
 Thu, 17 Aug 2017 10:20:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Thu, 17 Aug 2017 10:20:13 -0700 (PDT)
In-Reply-To: <20170817105349.GC52233@book.hvoigt.net>
References: <20170817105349.GC52233@book.hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 17 Aug 2017 10:20:13 -0700
Message-ID: <CAGZ79kY41A--4j6bkeKE=vOVVLXDcFc6BhBgz0G-4jQ2bVjyBw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] implement fetching of moved submodules
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2017 at 3:53 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> We store the changed submodules paths to calculate which submodule needs
> fetching. This does not work for moved submodules since their paths do
> not stay the same in case of a moved submodules. In case of new
> submodules we do not have a path in the current checkout, since they
> just appeared in this fetch.
>
> It is more general to collect the submodule names for changes instead of
> their paths to include the above cases.
>
> With the change described above we implement 'on-demand' fetching of
> changes in moved submodules.

This sounds as if this would also enable fetching new submodules
eventually?

> Note: This does only work when repositories have a .gitmodules file. In
> other words: It breaks if we do not get a name for a repository.
> IIRC, consensus was that this is a requirement to get nice submodule
> handling these days?

I think that should have been the consensus since ~1.7.8 (since the
submodules git dir can live inside the superprojects
<gitdir>/module/<name>).

A gitlink entry without corresponding .gitmodules entry is just a gitlink.
If we happen to have a repository at that path of the gitlink, we can
be nice and pretend like it is a functional submodule, but it really is
not. It's just another repo inside the superproject that happen to live
at the path of a gitlink.

> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
>
> I updated the leftover code from my series implementing recursive fetch
> for moved submodules[1] to the current master.
>
> This breaks t5531 and t5545 because they do not use a .gitmodules file.
>
> I also have some code leftover that does fallback on paths in case no
> submodule names can be found. But I do not really like it. The question
> here is how far do we support not using .gitmodules. Is it e.g.
> reasonable to say: "For --recurse-submodules=on-demand you need a
> .gitmodules file?"

I would not intentionally break users here, but any new functionality can
safely assume (a) we have a proper .gitmodules entry or (b) it is not a
submodule, so do nothing/be extra careful.

For example in recursive diff sort of makes sense to also handle
non-submodule gitlinks, but fetch is harder to tell.

(just last night I was rereading
https://public-inbox.org/git/CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com/
which I think is a super cute application of gitlinks. If you happen
to checkout such
a tree, you don't want to fetch all of the fake submodules)

>
> [1] https://public-inbox.org/git/f5baa2acc09531a16f4f693eebbe60706bb8ed1e.1361751905.git.hvoigt@hvoigt.net/

Oha, that is from way back in the time. :)

>  submodule.c                 | 92 +++++++++++++++++++++++++--------------------
>  t/t5526-fetch-submodules.sh | 35 +++++++++++++++++
>  2 files changed, 86 insertions(+), 41 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 27de65a..3ed78ac 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -23,7 +23,7 @@
>  static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
>  static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
>  static int parallel_jobs = 1;
> -static struct string_list changed_submodule_paths = STRING_LIST_INIT_DUP;
> +static struct string_list changed_submodule_names = STRING_LIST_INIT_DUP;
>  static int initialized_fetch_ref_tips;
>  static struct oid_array ref_tips_before_fetch;
>  static struct oid_array ref_tips_after_fetch;
> @@ -742,11 +742,11 @@ const struct submodule *submodule_from_ce(const struct cache_entry *ce)
>  }
>
>  static struct oid_array *submodule_commits(struct string_list *submodules,
> -                                          const char *path)
> +                                          const char *name)
>  {
>         struct string_list_item *item;
>
> -       item = string_list_insert(submodules, path);
> +       item = string_list_insert(submodules, name);
>         if (item->util)
>                 return (struct oid_array *) item->util;
>
> @@ -755,39 +755,34 @@ static struct oid_array *submodule_commits(struct string_list *submodules,
>         return (struct oid_array *) item->util;
>  }
>
> +struct collect_changed_submodules_cb_data {
> +       struct string_list *changed;

Here a comment would be helpful or a more concise variable name.
(What is changed?)

> +       const struct object_id *commit_oid;
> +};
> +
>  static void collect_changed_submodules_cb(struct diff_queue_struct *q,
>                                           struct diff_options *options,
>                                           void *data)
>  {
> +       struct collect_changed_submodules_cb_data *me = data;
> +       struct string_list *changed = me->changed;
> +       const struct object_id *commit_oid = me->commit_oid;
>         int i;
> -       struct string_list *changed = data;
>
>         for (i = 0; i < q->nr; i++) {
>                 struct diff_filepair *p = q->queue[i];
>                 struct oid_array *commits;
> +               const struct submodule *submodule;

(optional style nit, personal opinion, feel free to ignore)
I personally prefer to not name variables exactly as their type.
Also most (all) of the struct submodule uses used 'sub' as
the variable name, maybe keep it consistent?

> +
>                 if (!S_ISGITLINK(p->two->mode))
>                         continue;
>
> -               if (S_ISGITLINK(p->one->mode)) {
> -                       /*
> -                        * NEEDSWORK: We should honor the name configured in
> -                        * the .gitmodules file of the commit we are examining
> -                        * here to be able to correctly follow submodules
> -                        * being moved around.
> -                        */
> -                       commits = submodule_commits(changed, p->two->path);
> -                       oid_array_append(commits, &p->two->oid);
> -               } else {
> -                       /* Submodule is new or was moved here */
> -                       /*
> -                        * NEEDSWORK: When the .git directories of submodules
> -                        * live inside the superprojects .git directory some
> -                        * day we should fetch new submodules directly into
> -                        * that location too when config or options request
> -                        * that so they can be checked out from there.
> -                        */
> +               submodule = submodule_from_path(commit_oid, p->two->path);
> +               if (!submodule)
>                         continue;
> -               }
> +
> +               commits = submodule_commits(changed, submodule->name);
> +               oid_array_append(commits, &p->two->oid);
>         }
>  }
>
> @@ -810,11 +805,14 @@ static void collect_changed_submodules(struct string_list *changed,
>
>         while ((commit = get_revision(&rev))) {
>                 struct rev_info diff_rev;
> +               struct collect_changed_submodules_cb_data data;
> +               data.changed = changed;
> +               data.commit_oid = &commit->object.oid;
>
>                 init_revisions(&diff_rev, NULL);
>                 diff_rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
>                 diff_rev.diffopt.format_callback = collect_changed_submodules_cb;
> -               diff_rev.diffopt.format_callback_data = changed;
> +               diff_rev.diffopt.format_callback_data = &data;
>                 diff_tree_combined_merge(commit, 1, &diff_rev);
>         }
>
> @@ -871,6 +869,7 @@ static int submodule_has_commits(const char *path, struct oid_array *commits)
>         oid_array_for_each_unique(commits, check_has_commit, &has_commit);
>
>         if (has_commit) {
> +

stray new line

>                 /*
>                  * Even if the submodule is checked out and the commit is
>                  * present, make sure it exists in the submodule's object store
> @@ -945,7 +944,7 @@ int find_unpushed_submodules(struct oid_array *commits,
>                 const char *remotes_name, struct string_list *needs_pushing)
>  {
>         struct string_list submodules = STRING_LIST_INIT_DUP;
> -       struct string_list_item *submodule;
> +       struct string_list_item *name;
>         struct argv_array argv = ARGV_ARRAY_INIT;
>
>         /* argv.argv[0] will be ignored by setup_revisions */
> @@ -956,12 +955,16 @@ int find_unpushed_submodules(struct oid_array *commits,
>
>         collect_changed_submodules(&submodules, &argv);
>
> -       for_each_string_list_item(submodule, &submodules) {
> -               struct oid_array *commits = submodule->util;
> -               const char *path = submodule->string;
> +       for_each_string_list_item(name, &submodules) {
> +               struct oid_array *commits = name->util;
> +               const struct submodule *submodule;
> +
> +               submodule = submodule_from_name(&null_oid, name->string);
> +               if (!submodule)
> +                       continue;
>
> -               if (submodule_needs_pushing(path, commits))
> -                       string_list_insert(needs_pushing, path);
> +               if (submodule_needs_pushing(submodule->path, commits))
> +                       string_list_insert(needs_pushing, submodule->path);

eventually we can also migrate to name here as well.
In a later patch.

>         }
>
>         free_submodules_oids(&submodules);
> @@ -1104,7 +1107,7 @@ static void calculate_changed_submodule_paths(void)
>  {
>         struct argv_array argv = ARGV_ARRAY_INIT;
>         struct string_list changed_submodules = STRING_LIST_INIT_DUP;
> -       const struct string_list_item *item;
> +       const struct string_list_item *name;
>
>         /* No need to check if there are no submodules configured */
>         if (!submodule_from_path(NULL, NULL))
> @@ -1119,16 +1122,20 @@ static void calculate_changed_submodule_paths(void)
>
>         /*
>          * Collect all submodules (whether checked out or not) for which new
> -        * commits have been recorded upstream in "changed_submodule_paths".
> +        * commits have been recorded upstream in "changed_submodule_names".
>          */
>         collect_changed_submodules(&changed_submodules, &argv);
>
> -       for_each_string_list_item(item, &changed_submodules) {
> -               struct oid_array *commits = item->util;
> -               const char *path = item->string;
> +       for_each_string_list_item(name, &changed_submodules) {
> +               struct oid_array *commits = name->util;
> +               const struct submodule *submodule;
> +
> +               submodule = submodule_from_name(&null_oid, name->string);
> +               if (!submodule)
> +                       continue;
>
> -               if (!submodule_has_commits(path, commits))
> -                       string_list_append(&changed_submodule_paths, path);
> +               if (!submodule_has_commits(submodule->path, commits))
> +                       string_list_append(&changed_submodule_names, name->string);
>         }
>
>         free_submodules_oids(&changed_submodules);
> @@ -1206,7 +1213,8 @@ static int get_next_submodule(struct child_process *cp,
>                                         continue;
>                                 if (submodule->fetch_recurse ==
>                                                 RECURSE_SUBMODULES_ON_DEMAND) {
> -                                       if (!unsorted_string_list_lookup(&changed_submodule_paths, ce->name))
> +                                       if (!unsorted_string_list_lookup(&changed_submodule_names,
> +                                                                        submodule->name))
>                                                 continue;
>                                         default_argv = "on-demand";
>                                 }
> @@ -1215,13 +1223,15 @@ static int get_next_submodule(struct child_process *cp,
>                                     gitmodules_is_unmerged)
>                                         continue;
>                                 if (config_fetch_recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) {
> -                                       if (!unsorted_string_list_lookup(&changed_submodule_paths, ce->name))
> +                                       if (!unsorted_string_list_lookup(&changed_submodule_names,
> +                                                                        submodule->name))
>                                                 continue;
>                                         default_argv = "on-demand";
>                                 }
>                         }
>                 } else if (spf->command_line_option == RECURSE_SUBMODULES_ON_DEMAND) {
> -                       if (!unsorted_string_list_lookup(&changed_submodule_paths, ce->name))
> +                       if (!unsorted_string_list_lookup(&changed_submodule_names,
> +                                                        submodule->name))
>                                 continue;
>                         default_argv = "on-demand";
>                 }
> @@ -1315,7 +1325,7 @@ int fetch_populated_submodules(const struct argv_array *options,
>
>         argv_array_clear(&spf.args);
>  out:
> -       string_list_clear(&changed_submodule_paths, 1);
> +       string_list_clear(&changed_submodule_names, 1);
>         return spf.result;
>  }
>
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index 162baf1..ce788e9 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -530,4 +530,39 @@ test_expect_success 'fetching submodule into a broken repository' '
>         test_must_fail git -C dst fetch --recurse-submodules
>  '
>
> +test_expect_success "fetch new commits when submodule got renamed" '
> +       git clone . downstream_rename &&
> +       (
> +               cd downstream_rename &&
> +               git submodule update --init &&
> +# NEEDSWORK: we omitted --recursive for the submodule update here since
> +# that does not work. See test 7001 for mv "moving nested submodules"
> +# for details. Once that is fixed we should add the --recursive option
> +# here.
> +               git checkout -b rename &&
> +               git mv submodule submodule_renamed &&
> +               (
> +                       cd submodule_renamed &&
> +                       git checkout -b rename_sub &&
> +                       echo a >a &&
> +                       git add a &&
> +                       git commit -ma &&
> +                       git push origin rename_sub &&
> +                       git rev-parse HEAD >../../expect
> +               ) &&
> +               git add submodule_renamed &&
> +               git commit -m "update renamed submodule" &&
> +               git push origin rename
> +       ) &&
> +       (
> +               cd downstream &&
> +               git fetch --recurse-submodules=on-demand &&
> +               (
> +                       cd submodule &&
> +                       git rev-parse origin/rename_sub >../../actual
> +               )
> +       ) &&
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.0.0.274.g6b2cd91
>
