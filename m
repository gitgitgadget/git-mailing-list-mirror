Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0953C6FD1F
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 06:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjCSGUJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 02:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCSGUI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 02:20:08 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73548E1B5
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:20:04 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id g18so9038777ljl.3
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679206803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgCJhGKW2szwP0ptQhrPWyH/d7xhCix4Nl+Wi5/rtIo=;
        b=cVzEbXP04iXSG7oxfrOYlBMXG7bzkoluOkkJrUm8vnFM/kTGzqzb7HhojEpO2lIkIo
         1ff9QQBq6ObiUJXpjFQadNJP2fLFjGPq8Bn0Wkdje6C2su6VjdFGqhLNycTex/v7z84C
         gzqUxe4wJrbkedEsS3DX2LiDXpA4ud0VaCQfi0O8Jq+1uHqJQLqEYja5cU9dB42Zm+RW
         IgDOePBiN62tOkr1l83XVIJgEVc4gnthhjN4R1pH2PWb4+C9ozMWDIHlriZJBOERk7tU
         9UCc7+1tW2VXkueZ16PXGL77FulnLWij4SBJ3gr6s/2D7zpz4yHa649/ape8e6oHfSDV
         hQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679206803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgCJhGKW2szwP0ptQhrPWyH/d7xhCix4Nl+Wi5/rtIo=;
        b=Z4FWyQXKCyVsemBZadeLiRvYphIwu4cBbkuuNsR9+HtiOHixm0RzttBvtMFFIZwWML
         QfQ8OsPSJGxKGKIS6auWZ8kqg1JWn6/lJFJS243P2XDetv0IgZFi2oFON7V6dfkgTLad
         Sp2w0Kd92h2YQCNpXtCx1sv6vFZ3CkkWW2TnPNUrAdVbg1ic2qrkg8es0CkrvfZNjjJ9
         iEfg253xi/JOqKT0MHDeWqaZiJAc9mfYDyNu3Os2GpKopKzbZ44SXEe0LPC2tIZCe1+V
         uOPP5uTTKfr8+Fj5p3BnjLbPp3p8HBJ5ANS3y3W91i4lP/K0Nrr7HTLfIRtd23tnPO2L
         ylGA==
X-Gm-Message-State: AO0yUKUSVhETsOX4IjEe0iuJfwK5T59inp8+1J+Xb4me1xL4PJXoo3iK
        zwCt7lyNVnoveDntfiO7Y+oKBPgngkO4srrOBs56xpyR8W0=
X-Google-Smtp-Source: AK7set8ikryYxBCvNQ859UNc77saD2hxSYzIvelICUB4L+aHyzGFCiZk0jMDM3ZalV1nQnglXyNg7bsy1K79W/PYSOU=
X-Received: by 2002:a2e:b4a3:0:b0:295:93eb:e796 with SMTP id
 q3-20020a2eb4a3000000b0029593ebe796mr4664547ljm.1.1679206802431; Sat, 18 Mar
 2023 23:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com> <patch-17.17-6f86a34bf8b-20230317T152725Z-avarab@gmail.com>
In-Reply-To: <patch-17.17-6f86a34bf8b-20230317T152725Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 18 Mar 2023 23:19:50 -0700
Message-ID: <CABPp-BEdpTO=DRjLq_p+dgX68M0HUVB--3yQR4Sdp8rnFYeyfA@mail.gmail.com>
Subject: Re: [PATCH 17/17] libs: use "struct repository *" argument, not "the_repository"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2023 at 8:55=E2=80=AFAM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
<avarab@gmail.com> wrote:
>
> As can easily be seen from grepping in our sources, we had these uses
> of "the_repository" in various library code in cases where the
> function in question was already getting a "struct repository *"
> argument. Let's use that argument instead.
>
> Out of these changes only the changes to "cache-tree.c",
> "commit-reach.c", "shallow.c" and "upload-pack.c" would have cleanly
> applied before the migration away from the "repo_*()" wrapper macros
> in the preceding commits.
>
> The rest aren't new, as we'd previously implicitly refer to
> "the_repository", but it's now more obvious that we were doing the
> wrong thing all along, and should have used the parameter instead.

YES!  I love seeing fixes like this.  I noticed some a while back in
the merge code, and had some patches somewhere that I think I never
got around to submitting, but which have been in the back of my mind
bugging me.  Nice to see lots of these kinds of cases getting fixed.

> The change to change "get_index_format_default(the_repository)" in
> "read-cache.c" to use the "r" variable instead should arguably have
> been part of [1], or in the subsequent cleanup in [2]. Let's do it
> here, as can be seen from the initial code in [3] it's not important
> that we use "the_repository" there, but would prefer to always use the
> current repository.
>
> This change excludes the "the_repository" use in "upload-pack.c"'s
> upload_pack_advertise(), as the in-flight [4] makes that change.
>
> 1. ee1f0c242ef (read-cache: add index.skipHash config option,
>    2023-01-06)
> 2. 6269f8eaad0 (treewide: always have a valid "index_state.repo"
>    member, 2023-01-17)
> 3. 7211b9e7534 (repo-settings: consolidate some config settings,
>    2019-08-13)
> 4. <Y/hbUsGPVNAxTdmS@coredump.intra.peff.net>
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  add-interactive.c |   2 +-
>  branch.c          |   8 ++--
>  builtin/replace.c |   2 +-
>  cache-tree.c      |   4 +-
>  combine-diff.c    |   2 +-
>  commit-graph.c    |   2 +-
>  commit-reach.c    |   2 +-
>  merge-recursive.c |   2 +-

Doh, doesn't fix up the ones I had.  I don't remember the exact issue
and can't find the patches right now, but looking around a little I
see a write_object_file() which should be a repo_write_object_file(),
but it's in a function that doesn't take a repository argument.
However, the caller has access to a repository argument, in the form
of opt->repo, so we've got some low-hanging fruit that could be fixed
up.  Doesn't need to be part of your series, but it's nice that your
series has done some of the groundwork to make these issues more
obvious.

>  notes-cache.c     |   2 +-
>  notes-utils.c     |   2 +-
>  object-name.c     |   8 ++--
>  read-cache.c      |   4 +-
>  reset.c           |   2 +-
>  sequencer.c       | 102 ++++++++++++++++++++++------------------------
>  shallow.c         |   2 +-
>  tree.c            |   2 +-
>  wt-status.c       |  10 ++---
>  17 files changed, 76 insertions(+), 82 deletions(-)
>
> diff --git a/add-interactive.c b/add-interactive.c
> index 33f41d65a47..02bf6fc15cb 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -551,7 +551,7 @@ static int get_modified_files(struct repository *r,
>                 opt.def =3D is_initial ?
>                         empty_tree_oid_hex() : oid_to_hex(&head_oid);
>
> -               repo_init_revisions(the_repository, &rev, NULL);
> +               repo_init_revisions(r, &rev, NULL);
>                 setup_revisions(0, NULL, &rev, &opt);
>
>                 rev.diffopt.output_format =3D DIFF_FORMAT_CALLBACK;
> diff --git a/branch.c b/branch.c
> index a01e465b114..2b266e6fcb9 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -531,7 +531,7 @@ static void dwim_branch_start(struct repository *r, c=
onst char *start_name,
>                 explicit_tracking =3D 1;
>
>         real_ref =3D NULL;
> -       if (repo_get_oid_mb(the_repository, start_name, &oid)) {
> +       if (repo_get_oid_mb(r, start_name, &oid)) {
>                 if (explicit_tracking) {
>                         int code =3D die_message(_(upstream_missing), sta=
rt_name);
>                         advise_if_enabled(ADVICE_SET_UPSTREAM_FAILURE,
> @@ -541,8 +541,8 @@ static void dwim_branch_start(struct repository *r, c=
onst char *start_name,
>                 die(_("not a valid object name: '%s'"), start_name);
>         }
>
> -       switch (repo_dwim_ref(the_repository, start_name, strlen(start_na=
me),
> -                             &oid, &real_ref, 0)) {
> +       switch (repo_dwim_ref(r, start_name, strlen(start_name), &oid,
> +                             &real_ref, 0)) {
>         case 0:
>                 /* Not branching from any existing branch */
>                 if (explicit_tracking)
> @@ -773,7 +773,7 @@ void create_branches_recursively(struct repository *r=
, const char *name,
>                             name);
>         }
>
> -       create_branch(the_repository, name, start_commitish, force, 0, re=
flog, quiet,
> +       create_branch(r, name, start_commitish, force, 0, reflog, quiet,
>                       BRANCH_TRACK_NEVER, dry_run);
>         if (dry_run)
>                 return;
> diff --git a/builtin/replace.c b/builtin/replace.c
> index 85f0b79c924..bd67107a7c7 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -54,7 +54,7 @@ static int show_reference(struct repository *r, const c=
har *refname,
>                         struct object_id object;
>                         enum object_type obj_type, repl_type;
>
> -                       if (repo_get_oid(the_repository, refname, &object=
))
> +                       if (repo_get_oid(r, refname, &object))
>                                 return error(_("failed to resolve '%s' as=
 a valid ref"), refname);
>
>                         obj_type =3D oid_object_info(r, &object, NULL);
> diff --git a/cache-tree.c b/cache-tree.c
> index ab2cc1edf29..b0e490b5aa4 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -814,14 +814,14 @@ void prime_cache_tree(struct repository *r,
>  {
>         struct strbuf tree_path =3D STRBUF_INIT;
>
> -       trace2_region_enter("cache-tree", "prime_cache_tree", the_reposit=
ory);
> +       trace2_region_enter("cache-tree", "prime_cache_tree", r);
>         cache_tree_free(&istate->cache_tree);
>         istate->cache_tree =3D cache_tree();
>
>         prime_cache_tree_rec(r, istate->cache_tree, tree, &tree_path);
>         strbuf_release(&tree_path);
>         istate->cache_changed |=3D CACHE_TREE_CHANGED;
> -       trace2_region_leave("cache-tree", "prime_cache_tree", the_reposit=
ory);
> +       trace2_region_leave("cache-tree", "prime_cache_tree", r);
>  }
>
>  /*
> diff --git a/combine-diff.c b/combine-diff.c
> index 20f8a03924f..fa5967a5be6 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -332,7 +332,7 @@ static char *grab_blob(struct repository *r,
>                 *size =3D fill_textconv(r, textconv, df, &blob);
>                 free_filespec(df);
>         } else {
> -               blob =3D repo_read_object_file(the_repository, oid, &type=
, size);
> +               blob =3D repo_read_object_file(r, oid, &type, size);
>                 if (type !=3D OBJ_BLOB)
>                         die("object '%s' is not a blob!", oid_to_hex(oid)=
);
>         }
> diff --git a/commit-graph.c b/commit-graph.c
> index 268410e913c..035816f4d8c 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -2549,7 +2549,7 @@ int verify_commit_graph(struct repository *r, struc=
t commit_graph *g, int flags)
>
>                 graph_commit =3D lookup_commit(r, &cur_oid);
>                 odb_commit =3D (struct commit *)create_object(r, &cur_oid=
, alloc_commit_node(r));
> -               if (repo_parse_commit_internal(the_repository, odb_commit=
, 0, 0)) {
> +               if (repo_parse_commit_internal(r, odb_commit, 0, 0)) {
>                         graph_report(_("failed to parse commit %s from ob=
ject database for commit-graph"),
>                                      oid_to_hex(&cur_oid));
>                         continue;
> diff --git a/commit-reach.c b/commit-reach.c
> index c88faf7e7b2..01eb11b5957 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -448,7 +448,7 @@ int repo_is_descendant_of(struct repository *r,
>         if (!with_commit)
>                 return 1;
>
> -       if (generation_numbers_enabled(the_repository)) {
> +       if (generation_numbers_enabled(r)) {
>                 struct commit_list *from_list =3D NULL;
>                 int result;
>                 commit_list_insert(commit, &from_list);
> diff --git a/merge-recursive.c b/merge-recursive.c
> index d83ce19bb1f..20aa18e2203 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -3798,7 +3798,7 @@ static struct commit *get_ref(struct repository *re=
po,
>                 return make_virtual_commit(repo, (struct tree*)object, na=
me);
>         if (object->type !=3D OBJ_COMMIT)
>                 return NULL;
> -       if (repo_parse_commit(the_repository, (struct commit *)object))
> +       if (repo_parse_commit(repo, (struct commit *)object))
>                 return NULL;
>         return (struct commit *)object;
>  }
> diff --git a/notes-cache.c b/notes-cache.c
> index e5e9092d367..1a6e214ea79 100644
> --- a/notes-cache.c
> +++ b/notes-cache.c
> @@ -23,7 +23,7 @@ static int notes_cache_match_validity(struct repository=
 *r,
>                 return 0;
>
>         memset(&pretty_ctx, 0, sizeof(pretty_ctx));
> -       repo_format_commit_message(the_repository, commit, "%s", &msg,
> +       repo_format_commit_message(r, commit, "%s", &msg,
>                                    &pretty_ctx);
>         strbuf_trim(&msg);
>
> diff --git a/notes-utils.c b/notes-utils.c
> index 0550cfded86..4be0aaa6de9 100644
> --- a/notes-utils.c
> +++ b/notes-utils.c
> @@ -23,7 +23,7 @@ void create_notes_commit(struct repository *r,
>                 struct object_id parent_oid;
>                 if (!read_ref(t->ref, &parent_oid)) {
>                         struct commit *parent =3D lookup_commit(r, &paren=
t_oid);
> -                       if (repo_parse_commit(the_repository, parent))
> +                       if (repo_parse_commit(r, parent))
>                                 die("Failed to find/parse commit %s", t->=
ref);
>                         commit_list_insert(parent, &parents);
>                 }
> diff --git a/object-name.c b/object-name.c
> index df31f192ce3..c7bc311dcef 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -1038,7 +1038,7 @@ static enum get_oid_result get_parent(struct reposi=
tory *r,
>         if (ret)
>                 return ret;
>         commit =3D lookup_commit_reference(r, &oid);
> -       if (repo_parse_commit(the_repository, commit))
> +       if (repo_parse_commit(r, commit))
>                 return MISSING_OBJECT;
>         if (!idx) {
>                 oidcpy(result, &commit->object.oid);
> @@ -1072,7 +1072,7 @@ static enum get_oid_result get_nth_ancestor(struct =
repository *r,
>                 return MISSING_OBJECT;
>
>         while (generation--) {
> -               if (repo_parse_commit(the_repository, commit) || !commit-=
>parents)
> +               if (repo_parse_commit(r, commit) || !commit->parents)
>                         return MISSING_OBJECT;
>                 commit =3D commit->parents->item;
>         }
> @@ -1363,10 +1363,10 @@ static int get_oid_oneline(struct repository *r,
>                 commit =3D pop_most_recent_commit(&list, ONELINE_SEEN);
>                 if (!parse_object(r, &commit->object.oid))
>                         continue;
> -               buf =3D repo_get_commit_buffer(the_repository, commit, NU=
LL);
> +               buf =3D repo_get_commit_buffer(r, commit, NULL);
>                 p =3D strstr(buf, "\n\n");
>                 matches =3D negative ^ (p && !regexec(&regex, p + 2, 0, N=
ULL, 0));
> -               repo_unuse_commit_buffer(the_repository, commit, buf);
> +               repo_unuse_commit_buffer(r, commit, buf);
>
>                 if (matches) {
>                         oidcpy(oid, &commit->object.oid);
> diff --git a/read-cache.c b/read-cache.c
> index 1548e886684..892fede6b41 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2628,7 +2628,7 @@ int repo_index_has_changes(struct repository *repo,
>
>         if (tree)
>                 cmp =3D tree->object.oid;
> -       if (tree || !repo_get_oid_tree(the_repository, "HEAD", &cmp)) {
> +       if (tree || !repo_get_oid_tree(repo, "HEAD", &cmp)) {
>                 struct diff_options opt;
>
>                 repo_diff_setup(repo, &opt);
> @@ -2947,7 +2947,7 @@ static int do_write_index(struct index_state *istat=
e, struct tempfile *tempfile,
>         }
>
>         if (!istate->version)
> -               istate->version =3D get_index_format_default(the_reposito=
ry);
> +               istate->version =3D get_index_format_default(r);
>
>         /* demote version 3 to version 2 when the latter suffices */
>         if (istate->version =3D=3D 3 || istate->version =3D=3D 2)
> diff --git a/reset.c b/reset.c
> index 3a9c6dfdd0a..65f8138c78b 100644
> --- a/reset.c
> +++ b/reset.c
> @@ -106,7 +106,7 @@ int reset_head(struct repository *r, const struct res=
et_head_opts *opts)
>                 goto leave_reset_head;
>         }
>
> -       if (!repo_get_oid(the_repository, "HEAD", &head_oid)) {
> +       if (!repo_get_oid(r, "HEAD", &head_oid)) {
>                 head =3D &head_oid;
>         } else if (!oid || !reset_hard) {
>                 ret =3D error(_("could not determine HEAD revision"));
> diff --git a/sequencer.c b/sequencer.c
> index fb5a540fa04..f8f4e72112c 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -694,8 +694,8 @@ static int do_recursive_merge(struct repository *r,
>         o.show_rename_progress =3D 1;
>
>         head_tree =3D parse_tree_indirect(head);
> -       next_tree =3D next ? repo_get_commit_tree(the_repository, next) :=
 empty_tree(r);
> -       base_tree =3D base ? repo_get_commit_tree(the_repository, base) :=
 empty_tree(r);
> +       next_tree =3D next ? repo_get_commit_tree(r, next) : empty_tree(r=
);
> +       base_tree =3D base ? repo_get_commit_tree(r, base) : empty_tree(r=
);
>
>         for (i =3D 0; i < opts->xopts_nr; i++)
>                 parse_merge_opt(&o, opts->xopts[i]);
> @@ -773,7 +773,7 @@ static int is_index_unchanged(struct repository *r)
>          * the commit is invalid, repo_parse_commit() will complain.  So
>          * there is nothing for us to say here.  Just return failure.
>          */
> -       if (repo_parse_commit(the_repository, head_commit))
> +       if (repo_parse_commit(r, head_commit))
>                 return -1;
>
>         if (!(cache_tree_oid =3D get_cache_tree_oid(istate)))
> @@ -1338,15 +1338,15 @@ void print_commit_summary(struct repository *r,
>         commit =3D lookup_commit(r, oid);
>         if (!commit)
>                 die(_("couldn't look up newly created commit"));
> -       if (repo_parse_commit(the_repository, commit))
> +       if (repo_parse_commit(r, commit))
>                 die(_("could not parse newly created commit"));
>
>         strbuf_addstr(&format, "format:%h] %s");
>
> -       repo_format_commit_message(the_repository, commit, "%an <%ae>",
> -                                  &author_ident, &pctx);
> -       repo_format_commit_message(the_repository, commit, "%cn <%ce>",
> -                                  &committer_ident, &pctx);
> +       repo_format_commit_message(r, commit, "%an <%ae>", &author_ident,
> +                                  &pctx);
> +       repo_format_commit_message(r, commit, "%cn <%ce>", &committer_ide=
nt,
> +                                  &pctx);
>         if (strbuf_cmp(&author_ident, &committer_ident)) {
>                 strbuf_addstr(&format, "\n Author: ");
>                 strbuf_addbuf_percentquote(&format, &author_ident);
> @@ -1354,8 +1354,7 @@ void print_commit_summary(struct repository *r,
>         if (flags & SUMMARY_SHOW_AUTHOR_DATE) {
>                 struct strbuf date =3D STRBUF_INIT;
>
> -               repo_format_commit_message(the_repository, commit, "%ad",
> -                                          &date, &pctx);
> +               repo_format_commit_message(r, commit, "%ad", &date, &pctx=
);
>                 strbuf_addstr(&format, "\n Date: ");
>                 strbuf_addbuf_percentquote(&format, &date);
>                 strbuf_release(&date);
> @@ -1385,7 +1384,7 @@ void print_commit_summary(struct repository *r,
>         rev.diffopt.detect_rename =3D DIFF_DETECT_RENAME;
>         diff_setup_done(&rev.diffopt);
>
> -       refs =3D get_main_ref_store(the_repository);
> +       refs =3D get_main_ref_store(r);
>         head =3D refs_resolve_ref_unsafe(refs, "HEAD", 0, NULL, NULL);
>         if (!head)
>                 die(_("unable to resolve HEAD after creating commit"));
> @@ -1411,7 +1410,7 @@ static int parse_head(struct repository *r, struct =
commit **head)
>         struct commit *current_head;
>         struct object_id oid;
>
> -       if (repo_get_oid(the_repository, "HEAD", &oid)) {
> +       if (repo_get_oid(r, "HEAD", &oid)) {
>                 current_head =3D NULL;
>         } else {
>                 current_head =3D lookup_commit_reference(r, &oid);
> @@ -1421,7 +1420,7 @@ static int parse_head(struct repository *r, struct =
commit **head)
>                         warning(_("HEAD %s is not a commit!"),
>                                 oid_to_hex(&oid));
>                 }
> -               if (repo_parse_commit(the_repository, current_head))
> +               if (repo_parse_commit(r, current_head))
>                         return error(_("could not parse HEAD commit"));
>         }
>         *head =3D current_head;
> @@ -1464,9 +1463,8 @@ static int try_to_commit(struct repository *r,
>         if (flags & AMEND_MSG) {
>                 const char *exclude_gpgsig[] =3D { "gpgsig", "gpgsig-sha2=
56", NULL };
>                 const char *out_enc =3D get_commit_output_encoding();
> -               const char *message =3D repo_logmsg_reencode(the_reposito=
ry,
> -                                                          current_head, =
NULL,
> -                                                          out_enc);
> +               const char *message =3D repo_logmsg_reencode(r, current_h=
ead,
> +                                                          NULL, out_enc)=
;
>
>                 if (!msg) {
>                         const char *orig_message =3D NULL;
> @@ -1477,7 +1475,7 @@ static int try_to_commit(struct repository *r,
>                         hook_commit =3D "HEAD";
>                 }
>                 author =3D amend_author =3D get_author(message);
> -               repo_unuse_commit_buffer(the_repository, current_head,
> +               repo_unuse_commit_buffer(r, current_head,
>                                          message);
>                 if (!author) {
>                         res =3D error(_("unable to parse commit author"))=
;
> @@ -2004,18 +2002,18 @@ static int update_squash_messages(struct reposito=
ry *r,
>                 struct commit *head_commit;
>                 const char *head_message, *body;
>
> -               if (repo_get_oid(the_repository, "HEAD", &head))
> +               if (repo_get_oid(r, "HEAD", &head))
>                         return error(_("need a HEAD to fixup"));
>                 if (!(head_commit =3D lookup_commit_reference(r, &head)))
>                         return error(_("could not read HEAD"));
> -               if (!(head_message =3D repo_logmsg_reencode(the_repositor=
y, head_commit, NULL, encoding)))
> +               if (!(head_message =3D repo_logmsg_reencode(r, head_commi=
t, NULL,
> +                                                         encoding)))
>                         return error(_("could not read HEAD's commit mess=
age"));
>
>                 find_commit_subject(head_message, &body);
>                 if (command =3D=3D TODO_FIXUP && !flag && write_message(b=
ody, strlen(body),
>                                                         rebase_path_fixup=
_msg(), 0) < 0) {
> -                       repo_unuse_commit_buffer(the_repository, head_com=
mit,
> -                                                head_message);
> +                       repo_unuse_commit_buffer(r, head_commit, head_mes=
sage);
>                         return error(_("cannot write '%s'"), rebase_path_=
fixup_msg());
>                 }
>                 strbuf_addf(&buf, "%c ", comment_line_char);
> @@ -2030,11 +2028,10 @@ static int update_squash_messages(struct reposito=
ry *r,
>                 else
>                         strbuf_addstr(&buf, body);
>
> -               repo_unuse_commit_buffer(the_repository, head_commit,
> -                                        head_message);
> +               repo_unuse_commit_buffer(r, head_commit, head_message);
>         }
>
> -       if (!(message =3D repo_logmsg_reencode(the_repository, commit, NU=
LL, encoding)))
> +       if (!(message =3D repo_logmsg_reencode(r, commit, NULL, encoding)=
))
>                 return error(_("could not read commit message of %s"),
>                              oid_to_hex(&commit->object.oid));
>         find_commit_subject(message, &body);
> @@ -2049,7 +2046,7 @@ static int update_squash_messages(struct repository=
 *r,
>                 strbuf_add_commented_lines(&buf, body, strlen(body));
>         } else
>                 return error(_("unknown command: %d"), command);
> -       repo_unuse_commit_buffer(the_repository, commit, message);
> +       repo_unuse_commit_buffer(r, commit, message);
>
>         if (!res)
>                 res =3D write_message(buf.buf, buf.len, rebase_path_squas=
h_msg(),
> @@ -2162,7 +2159,7 @@ static int do_pick_commit(struct repository *r,
>                 if (write_index_as_tree(&head, r->index, r->index_file, 0=
, NULL))
>                         return error(_("your index file is unmerged."));
>         } else {
> -               unborn =3D repo_get_oid(the_repository, "HEAD", &head);
> +               unborn =3D repo_get_oid(r, "HEAD", &head);
>                 /* Do we want to generate a root commit? */
>                 if (is_pick_or_similar(command) && opts->have_squash_onto=
 &&
>                     oideq(&head, &opts->squash_onto)) {
> @@ -2224,7 +2221,7 @@ static int do_pick_commit(struct repository *r,
>                 msg_file =3D NULL;
>                 goto fast_forward_edit;
>         }
> -       if (parent && repo_parse_commit(the_repository, parent) < 0)
> +       if (parent && repo_parse_commit(r, parent) < 0)
>                 /* TRANSLATORS: The first %s will be a "todo" command lik=
e
>                    "revert" or "pick", the second %s a SHA1. */
>                 return error(_("%s: cannot parse parent commit %s"),
> @@ -2616,7 +2613,7 @@ static int parse_insn_line(struct repository *r, st=
ruct todo_item *item,
>         end_of_object_name =3D (char *) bol + strcspn(bol, " \t\n");
>         saved =3D *end_of_object_name;
>         *end_of_object_name =3D '\0';
> -       status =3D repo_get_oid(the_repository, bol, &commit_oid);
> +       status =3D repo_get_oid(r, bol, &commit_oid);
>         if (status < 0)
>                 error(_("could not parse '%s'"), bol); /* return later */
>         *end_of_object_name =3D saved;
> @@ -3531,12 +3528,12 @@ static int make_patch(struct repository *r,
>         strbuf_addf(&buf, "%s/message", get_dir(opts));
>         if (!file_exists(buf.buf)) {
>                 const char *encoding =3D get_commit_output_encoding();
> -               const char *commit_buffer =3D repo_logmsg_reencode(the_re=
pository,
> +               const char *commit_buffer =3D repo_logmsg_reencode(r,
>                                                                  commit, =
NULL,
>                                                                  encoding=
);
>                 find_commit_subject(commit_buffer, &subject);
>                 res |=3D write_message(subject, strlen(subject), buf.buf,=
 1);
> -               repo_unuse_commit_buffer(the_repository, commit,
> +               repo_unuse_commit_buffer(r, commit,
>                                          commit_buffer);
>         }
>         strbuf_release(&buf);
> @@ -3716,7 +3713,7 @@ static int do_label(struct repository *r, const cha=
r *name, int len)
>         if (!transaction) {
>                 error("%s", err.buf);
>                 ret =3D -1;
> -       } else if (repo_get_oid(the_repository, "HEAD", &head_oid)) {
> +       } else if (repo_get_oid(r, "HEAD", &head_oid)) {
>                 error(_("could not read HEAD"));
>                 ret =3D -1;
>         } else if (ref_transaction_update(transaction, ref_name.buf, &hea=
d_oid,
> @@ -4004,8 +4001,7 @@ static int do_merge(struct repository *r,
>
>         if (commit) {
>                 const char *encoding =3D get_commit_output_encoding();
> -               const char *message =3D repo_logmsg_reencode(the_reposito=
ry,
> -                                                          commit, NULL,
> +               const char *message =3D repo_logmsg_reencode(r, commit, N=
ULL,
>                                                            encoding);
>                 const char *body;
>                 int len;
> @@ -4019,7 +4015,7 @@ static int do_merge(struct repository *r,
>                 find_commit_subject(message, &body);
>                 len =3D strlen(body);
>                 ret =3D write_message(body, len, git_path_merge_msg(r), 0=
);
> -               repo_unuse_commit_buffer(the_repository, commit, message)=
;
> +               repo_unuse_commit_buffer(r, commit, message);
>                 if (ret) {
>                         error_errno(_("could not write '%s'"),
>                                     git_path_merge_msg(r));
> @@ -4119,8 +4115,7 @@ static int do_merge(struct repository *r,
>         }
>
>         merge_commit =3D to_merge->item;
> -       bases =3D repo_get_merge_bases(the_repository, head_commit,
> -                                    merge_commit);
> +       bases =3D repo_get_merge_bases(r, head_commit, merge_commit);
>         if (bases && oideq(&merge_commit->object.oid,
>                            &bases->item->object.oid)) {
>                 ret =3D 0;
> @@ -4475,7 +4470,7 @@ void create_autostash(struct repository *r, const c=
har *path)
>                 if (capture_command(&stash, &buf, GIT_MAX_HEXSZ))
>                         die(_("Cannot autostash"));
>                 strbuf_trim_trailing_newline(&buf);
> -               if (repo_get_oid(the_repository, buf.buf, &oid))
> +               if (repo_get_oid(r, buf.buf, &oid))
>                         die(_("Unexpected stash response: '%s'"),
>                             buf.buf);
>                 strbuf_reset(&buf);
> @@ -4600,9 +4595,9 @@ static int stopped_at_head(struct repository *r)
>         struct commit *commit;
>         struct commit_message message;
>
> -       if (repo_get_oid(the_repository, "HEAD", &head) ||
> +       if (repo_get_oid(r, "HEAD", &head) ||
>             !(commit =3D lookup_commit(r, &head)) ||
> -           repo_parse_commit(the_repository, commit) || get_message(comm=
it, &message))
> +           repo_parse_commit(r, commit) || get_message(commit, &message)=
)
>                 fprintf(stderr, _("Stopped at HEAD\n"));
>         else {
>                 fprintf(stderr, _("Stopped at %s\n"), message.label);
> @@ -4750,7 +4745,7 @@ static int pick_commits(struct repository *r,
>                                  * otherwise we do not.
>                                  */
>                                 if (item->command =3D=3D TODO_REWORD &&
> -                                   !repo_get_oid(the_repository, "HEAD",=
 &oid) &&
> +                                   !repo_get_oid(r, "HEAD", &oid) &&
>                                     (oideq(&item->commit->object.oid, &oi=
d) ||
>                                      (opts->have_squash_onto &&
>                                       oideq(&opts->squash_onto, &oid))))
> @@ -4839,7 +4834,7 @@ static int pick_commits(struct repository *r,
>                         struct object_id head, orig;
>                         int res;
>
> -                       if (repo_get_oid(the_repository, "HEAD", &head)) =
{
> +                       if (repo_get_oid(r, "HEAD", &head)) {
>                                 res =3D error(_("cannot read HEAD"));
>  cleanup_head_ref:
>                                 strbuf_release(&head_ref);
> @@ -4886,8 +4881,8 @@ static int pick_commits(struct repository *r,
>                         log_tree_opt.disable_stdin =3D 1;
>
>                         if (read_oneliner(&buf, rebase_path_orig_head(), =
0) &&
> -                           !repo_get_oid(the_repository, buf.buf, &orig)=
 &&
> -                           !repo_get_oid(the_repository, "HEAD", &head))=
 {
> +                           !repo_get_oid(r, buf.buf, &orig) &&
> +                           !repo_get_oid(r, "HEAD", &head)) {
>                                 diff_tree_oid(&orig, &head, "",
>                                               &log_tree_opt.diffopt);
>                                 log_tree_diff_flush(&log_tree_opt);
> @@ -4979,7 +4974,7 @@ static int commit_staged_changes(struct repository =
*r,
>                 struct strbuf rev =3D STRBUF_INIT;
>                 struct object_id head, to_amend;
>
> -               if (repo_get_oid(the_repository, "HEAD", &head))
> +               if (repo_get_oid(r, "HEAD", &head))
>                         return error(_("cannot amend non-existing commit"=
));
>                 if (!read_oneliner(&rev, rebase_path_amend(), 0))
>                         return error(_("invalid file: '%s'"), rebase_path=
_amend());
> @@ -5059,14 +5054,13 @@ static int commit_staged_changes(struct repositor=
y *r,
>                                 const char *encoding =3D get_commit_outpu=
t_encoding();
>
>                                 if (parse_head(r, &commit) ||
> -                                   !(p =3D repo_logmsg_reencode(the_repo=
sitory, commit, NULL, encoding)) ||
> +                                   !(p =3D repo_logmsg_reencode(r, commi=
t, NULL, encoding)) ||
>                                     write_message(p, strlen(p), path, 0))=
 {
> -                                       repo_unuse_commit_buffer(the_repo=
sitory,
> -                                                                commit, =
p);
> +                                       repo_unuse_commit_buffer(r, commi=
t, p);
>                                         return error(_("could not write f=
ile: "
>                                                        "'%s'"), path);
>                                 }
> -                               repo_unuse_commit_buffer(the_repository,
> +                               repo_unuse_commit_buffer(r,
>                                                          commit, p);
>                         }
>                 }
> @@ -5206,7 +5200,7 @@ int sequencer_pick_revisions(struct repository *r,
>                 if (!strlen(name))
>                         continue;
>
> -               if (!repo_get_oid(the_repository, name, &oid)) {
> +               if (!repo_get_oid(r, name, &oid)) {
>                         if (!lookup_commit_reference_gently(r, &oid, 1)) =
{
>                                 enum object_type type =3D oid_object_info=
(r,
>                                                                         &=
oid,
> @@ -5249,7 +5243,7 @@ int sequencer_pick_revisions(struct repository *r,
>         if (walk_revs_populate_todo(&todo_list, opts) ||
>                         create_seq_dir(r) < 0)
>                 return -1;
> -       if (repo_get_oid(the_repository, "HEAD", &oid) && (opts->action =
=3D=3D REPLAY_REVERT))
> +       if (repo_get_oid(r, "HEAD", &oid) && (opts->action =3D=3D REPLAY_=
REVERT))
>                 return error(_("can't revert as initial commit"));
>         if (save_head(oid_to_hex(&oid)))
>                 return -1;
> @@ -5944,7 +5938,7 @@ static int skip_unnecessary_picks(struct repository=
 *r,
>                         continue;
>                 if (item->command !=3D TODO_PICK)
>                         break;
> -               if (repo_parse_commit(the_repository, item->commit)) {
> +               if (repo_parse_commit(r, item->commit)) {
>                         return error(_("could not parse commit '%s'"),
>                                 oid_to_hex(&item->commit->object.oid));
>                 }
> @@ -6115,7 +6109,7 @@ int complete_action(struct repository *r, struct re=
play_opts *opts, unsigned fla
>         struct object_id oid =3D onto->object.oid;
>         int res;
>
> -       repo_find_unique_abbrev_r(the_repository, shortonto, &oid,
> +       repo_find_unique_abbrev_r(r, shortonto, &oid,
>                                   DEFAULT_ABBREV);
>
>         if (buf->len =3D=3D 0) {
> @@ -6395,8 +6389,8 @@ int sequencer_determine_whence(struct repository *r=
, enum commit_whence *whence)
>                 if (file_exists(git_path_seq_dir()))
>                         *whence =3D FROM_CHERRY_PICK_MULTI;
>                 if (file_exists(rebase_path()) &&
> -                   !repo_get_oid(the_repository, "REBASE_HEAD", &rebase_=
head) &&
> -                   !repo_get_oid(the_repository, "CHERRY_PICK_HEAD", &ch=
erry_pick_head) &&
> +                   !repo_get_oid(r, "REBASE_HEAD", &rebase_head) &&
> +                   !repo_get_oid(r, "CHERRY_PICK_HEAD", &cherry_pick_hea=
d) &&
>                     oideq(&rebase_head, &cherry_pick_head))
>                         *whence =3D FROM_REBASE_PICK;
>                 else
> diff --git a/shallow.c b/shallow.c
> index 07278467e47..fbafc4b30e9 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -30,7 +30,7 @@ int register_shallow(struct repository *r, const struct=
 object_id *oid)
>  {
>         struct commit_graft *graft =3D
>                 xmalloc(sizeof(struct commit_graft));
> -       struct commit *commit =3D lookup_commit(the_repository, oid);
> +       struct commit *commit =3D lookup_commit(r, oid);
>
>         oidcpy(&graft->oid, oid);
>         graft->nr_parent =3D -1;
> diff --git a/tree.c b/tree.c
> index 1b403c4b5ce..8643b734642 100644
> --- a/tree.c
> +++ b/tree.c
> @@ -58,7 +58,7 @@ int read_tree_at(struct repository *r,
>                                     oid_to_hex(&entry.oid),
>                                     base->buf, entry.path);
>
> -                       if (repo_parse_commit(the_repository, commit))
> +                       if (repo_parse_commit(r, commit))
>                                 die("Invalid commit %s in submodule path =
%s%s",
>                                     oid_to_hex(&entry.oid),
>                                     base->buf, entry.path);
> diff --git a/wt-status.c b/wt-status.c
> index dcd1d0cee4c..28e35a2165a 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1664,7 +1664,7 @@ static void wt_status_get_detached_from(struct repo=
sitory *r,
>                 return;
>         }
>
> -       if (repo_dwim_ref(the_repository, cb.buf.buf, cb.buf.len, &oid, &=
ref,
> +       if (repo_dwim_ref(r, cb.buf.buf, cb.buf.len, &oid, &ref,
>                           1) =3D=3D 1 &&
>             /* oid is a commit? match without further lookup */
>             (oideq(&cb.noid, &oid) ||
> @@ -1677,9 +1677,9 @@ static void wt_status_get_detached_from(struct repo=
sitory *r,
>                 state->detached_from =3D xstrdup(from);
>         } else
>                 state->detached_from =3D
> -                       xstrdup(repo_find_unique_abbrev(the_repository, &=
cb.noid, DEFAULT_ABBREV));
> +                       xstrdup(repo_find_unique_abbrev(r, &cb.noid, DEFA=
ULT_ABBREV));
>         oidcpy(&state->detached_oid, &cb.noid);
> -       state->detached_at =3D !repo_get_oid(the_repository, "HEAD", &oid=
) &&
> +       state->detached_at =3D !repo_get_oid(r, "HEAD", &oid) &&
>                              oideq(&oid, &state->detached_oid);
>
>         free(ref);
> @@ -1770,13 +1770,13 @@ void wt_status_get_state(struct repository *r,
>         } else if (wt_status_check_rebase(NULL, state)) {
>                 ;               /* all set */
>         } else if (refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HE=
AD") &&
> -                  !repo_get_oid(the_repository, "CHERRY_PICK_HEAD", &oid=
)) {
> +                  !repo_get_oid(r, "CHERRY_PICK_HEAD", &oid)) {
>                 state->cherry_pick_in_progress =3D 1;
>                 oidcpy(&state->cherry_pick_head_oid, &oid);
>         }
>         wt_status_check_bisect(NULL, state);
>         if (refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD") &&
> -           !repo_get_oid(the_repository, "REVERT_HEAD", &oid)) {
> +           !repo_get_oid(r, "REVERT_HEAD", &oid)) {
>                 state->revert_in_progress =3D 1;
>                 oidcpy(&state->revert_head_oid, &oid);
>         }
> --
> 2.40.0.rc1.1034.g5867a1b10c5

I started looking through it closely, but after a bit I realized that
the only kind of error you would likely to be make here would be the
kind caught by the compiler, so then I started just skimming over it.
But I think that's safe for this kind of change.  I'm a big fan of
these kinds of cleanups and fixups, though.

I'm not sure I can give a Reviewed-by since I just don't know cocci,
but it all looked pretty logical.  You definitely have my Acked-by on
the series, though.
