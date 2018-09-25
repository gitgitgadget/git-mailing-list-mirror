Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8E091F453
	for <e@80x24.org>; Tue, 25 Sep 2018 19:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeIZB5N (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 21:57:13 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:54564 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbeIZB5M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 21:57:12 -0400
Received: by mail-yb1-f201.google.com with SMTP id y67-v6so4214101ybe.21
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 12:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=KKedbUO15+CFyww2rk5D9TV2Q2b4V1CKqWDE0ozayKw=;
        b=VIYeZsrcEBiXoc9sLV/REMmRJplcuEEaxwcoqXEOnwoh+kzq2ykTeO93UOiqteEUpP
         4mZexKXSel7ToMNDK2wqS2zIBAx0CFKRryY2EF2QYmc9ie4GnKV0uAHYElNgHACRzk97
         PcJSoeHsAmxC94vefIGSu6ejmeu7/jO3/uMio4MmhcnvQls8OgwidBkxWRCkO6nnZrpH
         3f3hCAL7uHzG7LWTIDjPjuQrF7fktgWXsHekLkJobaGlOji6v8Uj9qnxkHK/e7O6xyZH
         t4eMEDcZjrEfp0hU0DEfSNR95HElWi/D0jQ6Cc1T1m+w6fxiuxvWAijbPf/LhUNHTRd7
         FVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=KKedbUO15+CFyww2rk5D9TV2Q2b4V1CKqWDE0ozayKw=;
        b=sNDZxu6lxyE0MOhUP70qeTTP4LlIBu3HuDXW8wXiyzLmCbSgvbqa1qrg2s46fXxyHH
         +sa/QQicotNpH45D06qLfUupkw93StN2bZsPlk4eMmLA85IXCDMhEjuCOcqAuWdp1PCY
         Xxo5Qu5Cv7jfzKMrQzIHyqHCrPZf/o36NPbwficPz9GnzmfNnkPR7Cy9hArqkTRQSQc+
         qHOnkabl+DBUIKqpJvmdfqYMZP+ULrmP9gojaJ36ceuZrEkLRzQV6MjTezuAP8m0tTT5
         NOwtaxxHoQn6AldW9lsUg0l4ZfqF639TOCHafFA9QLl9423CICrwRem/fCBv/zifsSeO
         8eFA==
X-Gm-Message-State: ABuFfogE6Retfz3ZEE+tYgzSPz2ciGgMvG7mJuXdUuXLbW96hjxtMyWP
        V5JjPFzhaUEoiBnzW7GBnsvvfPKXnYRxmo2hiKr3+aCsZkimz13lvcisxjqZfeHmug2k6IB1RAs
        dcoEI/rfxfRL/HUnJ1iMDvJi8RmJfUAMaeSht8OAJEY1kjEomaD21Evm4zblm
X-Google-Smtp-Source: ACcGV62YYnqZIKLK3ZCs83bWoXFjnQ1y7pVMK5Ei11bDFlci1VYOh7+PJAe3TTWkz2Eoq4PK3ELyoUEqA0MK
X-Received: by 2002:a25:8382:: with SMTP id t2-v6mr164758ybk.18.1537904883273;
 Tue, 25 Sep 2018 12:48:03 -0700 (PDT)
Date:   Tue, 25 Sep 2018 12:47:46 -0700
Message-Id: <20180925194755.105578-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v4 0/9] fetch: make sure submodule oids are fetched
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v4:
* Per =C3=86vars comment, moved the docs for oid_array_filter into
  Documentation/technical/...
* addressed all outstanding comment as noted in "What's cooking" email,
* below is a range-diff against the currently queued version of the
  series.

v3:
* I discovered some issues with v2 after sending,
  which is why I rewrote the later patches completely
  and now we pass around a "task" struct that contains everything to know
  about the things to work on and what needs free()ing afterwards.
* as it is no longer string list based, this drops adding string_list_{pop,=
 last}

v2:
* extended commit messages,
* plugged a memory leak
* rewrote the patch "sha1-array: provide oid_array_filter" to be much more =
like=20
  object_array_fiter
* fixed a typo pointed out by Ramsay.

The range diff is below.
 =20
Thanks,
Stefan

v1:
Currently when git-fetch is asked to recurse into submodules, it dispatches
a plain "git-fetch -C <submodule-dir>" (and some submodule related options
such as prefix and recusing strategy, but) without any information of the
remote or the tip that should be fetched.

This works surprisingly well in some workflows, not so well in others,
which this series aims to fix.

The first patches provide new basic functionality and do some refactoring;
the interesting part is in the two last patches.

This was discussed in
https://public-inbox.org/git/20180808221752.195419-1-sbeller@google.com/
and I think I addressed all feedback so far.

Stefan Beller (9):
  sha1-array: provide oid_array_filter
  submodule.c: fix indentation
  submodule.c: sort changed_submodule_names before searching it
  submodule: move global changed_submodule_names into fetch submodule
    struct
  submodule.c: do not copy around submodule list
  repository: repo_submodule_init to take a submodule struct
  submodule: fetch in submodules git directory instead of in worktree
  fetch: retry fetching submodules if needed objects were not fetched
  builtin/fetch: check for submodule updates for non branch fetches

 Documentation/technical/api-oid-array.txt |   5 +
 builtin/fetch.c                           |  14 +-
 builtin/grep.c                            |  17 +-
 builtin/ls-files.c                        |  12 +-
 builtin/submodule--helper.c               |   2 +-
 repository.c                              |  27 +--
 repository.h                              |  11 +-
 sha1-array.c                              |  17 ++
 sha1-array.h                              |   3 +
 submodule.c                               | 275 +++++++++++++++++-----
 t/t5526-fetch-submodules.sh               |  23 +-
 11 files changed, 311 insertions(+), 95 deletions(-)

git range-diff  origin/sb/submodule-recursive-fetch-gets-the-tip...

  1:  6fecf7cd01a <   -:  ----------- string-list: add string_list_{pop, la=
st} functions
  2:  7007a318a68 <   -:  ----------- sha1-array: provide oid_array_filter

    [ ... snip ... I rebased onto: ]

  -:  ----------- > 215:  fe8321ec057 Second batch post 2.19
  -:  ----------- > 216:  a9b49d4cfe9 sha1-array: provide oid_array_filter
  3:  807429234ac ! 217:  813205700d1 submodule.c: fix indentation
    @@ -6,7 +6,6 @@
         Fix it while we are here.
    =20
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
      diff --git a/submodule.c b/submodule.c
      --- a/submodule.c
  4:  f6fa5273af9 ! 218:  b4aa77f72ba submodule.c: sort changed_submodule_n=
ames before searching it
    @@ -12,7 +12,6 @@
         appropriate.
    =20
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
      diff --git a/submodule.c b/submodule.c
      --- a/submodule.c
  5:  adf7a2fd203 ! 219:  df4da0e18e4 submodule: move global changed_submod=
ule_names into fetch submodule struct
    @@ -6,13 +6,12 @@
         part of the struct that is passed around for fetching submodules.
    =20
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
      diff --git a/submodule.c b/submodule.c
      --- a/submodule.c
      +++ b/submodule.c
     @@
    - #include "object-store.h"
    + #include "commit-reach.h"
     =20
      static int config_update_recurse_submodules =3D RECURSE_SUBMODULES_OF=
F;
     -static struct string_list changed_submodule_names =3D STRING_LIST_INI=
T_DUP;
  6:  56c9398589a ! 220:  b9f5d06c134 submodule.c: do not copy around submo=
dule list
    @@ -9,12 +9,11 @@
         Instead use the result list directly and prune items afterwards
         using string_list_remove_empty_items.
    =20
    -    By doin so we'll have access to the util pointer for longer that
    +    By doing so we'll have access to the util pointer for longer that
         contains the commits that we need to fetch, which will be
         useful in a later patch.
    =20
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
      diff --git a/submodule.c b/submodule.c
      --- a/submodule.c
  -:  ----------- > 221:  e5ff287a0a2 repository: repo_submodule_init to ta=
ke a submodule struct
  7:  9f70a5f32c9 ! 222:  8acd734b5f5 submodule: fetch in submodules git di=
rectory instead of in worktree
    @@ -3,14 +3,24 @@
         submodule: fetch in submodules git directory instead of in worktre=
e
    =20
         This patch started as a refactoring to make 'get_next_submodule' m=
ore
    -    readable, but upon doing so, I realized that git-fetch actually do=
esn't
    -    need to be run in the worktree. So let's run it in the git dir ins=
tead.
    +    readable, but upon doing so, I realized that "git fetch" of the su=
bmodule
    +    actually doesn't need to be run in the submodules worktree. So let=
's run
    +    it in its git dir instead.
    =20
         That should pave the way towards fetching submodules that are curr=
ently
         not checked out.
    =20
    +    This patch leaks the cp->dir in get_next_submodule, as any further
    +    callback in run_processes_parallel doesn't have access to the chil=
d
    +    process any more. In an early iteration of this patch, the functio=
n
    +    get_submodule_repo_for directly returned the string containing the
    +    git directory, which would be a better design choice for this patc=
h.
    +
    +    However the next patch both fixes the memory leak of cp->dir and a=
lso has
    +    a use case for using the full repository handle of the submodule, =
so
    +    it makes sense to introduce the get_submodule_repo_for here alread=
y.
    +
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
      diff --git a/submodule.c b/submodule.c
      --- a/submodule.c
    @@ -32,24 +42,26 @@
      	return spf->default_option;
      }
     =20
    -+static const char *get_submodule_git_dir(struct repository *r, const =
char *path)
    ++static struct repository *get_submodule_repo_for(struct repository *r=
,
    ++						 const struct submodule *sub)
     +{
    -+	struct repository subrepo;
    -+	const char *ret;
    ++	struct repository *ret =3D xmalloc(sizeof(*ret));
     +
    -+	if (repo_submodule_init(&subrepo, r, path)) {
    -+		/* no entry in .gitmodules? */
    ++	if (repo_submodule_init(ret, r, sub)) {
    ++		/*
    ++		 * No entry in .gitmodules? Technically not a submodule,
    ++		 * but historically we supported repositories that happen to be
    ++		 * in-place where a gitlink is. Keep supporting them.
    ++		 */
     +		struct strbuf gitdir =3D STRBUF_INIT;
    -+		strbuf_repo_worktree_path(&gitdir, r, "%s/.git", path);
    -+		if (repo_init(&subrepo, gitdir.buf, NULL)) {
    ++		strbuf_repo_worktree_path(&gitdir, r, "%s/.git", sub->path);
    ++		if (repo_init(ret, gitdir.buf, NULL)) {
     +			strbuf_release(&gitdir);
     +			return NULL;
     +		}
    ++		strbuf_release(&gitdir);
     +	}
     +
    -+	ret =3D xstrdup(subrepo.gitdir);
    -+	repo_clear(&subrepo);
    -+
     +	return ret;
     +}
     +
    @@ -64,7 +76,13 @@
     -		struct strbuf submodule_git_dir =3D STRBUF_INIT;
      		struct strbuf submodule_prefix =3D STRBUF_INIT;
      		const struct cache_entry *ce =3D spf->r->index->cache[spf->count];
    - 		const char *git_dir, *default_argv;
    +-		const char *git_dir, *default_argv;
    ++		const char *default_argv;
    + 		const struct submodule *submodule;
    ++		struct repository *repo;
    + 		struct submodule default_submodule =3D SUBMODULE_INIT;
    +=20
    + 		if (!S_ISGITLINK(ce->ce_mode))
     @@
      			continue;
      		}
    @@ -76,18 +94,23 @@
     -		if (!git_dir)
     -			git_dir =3D submodule_git_dir.buf;
     -		if (is_directory(git_dir)) {
    -+		git_dir =3D get_submodule_git_dir(spf->r, ce->name);
    -+		if (git_dir) {
    ++		repo =3D get_submodule_repo_for(spf->r, submodule);
    ++		if (repo) {
      			child_process_init(cp);
     -			cp->dir =3D strbuf_detach(&submodule_path, NULL);
     -			prepare_submodule_repo_env(&cp->env_array);
     +			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
    -+			cp->dir =3D git_dir;
    ++			cp->dir =3D xstrdup(repo->gitdir);
      			cp->git_cmd =3D 1;
      			if (!spf->quiet)
      				strbuf_addf(err, "Fetching submodule %s%s\n",
     @@
    + 			argv_array_push(&cp->args, default_argv);
    + 			argv_array_push(&cp->args, "--submodule-prefix");
      			argv_array_push(&cp->args, submodule_prefix.buf);
    ++
    ++			repo_clear(repo);
    ++			free(repo);
      			ret =3D 1;
      		}
     -		strbuf_release(&submodule_path);
  8:  bab609b4dc1 ! 223:  5752ba212a7 fetch: retry fetching submodules if s=
ha1 were not fetched
    @@ -1,9 +1,9 @@
     Author: Stefan Beller <sbeller@google.com>
    =20
    -    fetch: retry fetching submodules if sha1 were not fetched
    +    fetch: retry fetching submodules if needed objects were not fetche=
d
    =20
         Currently when git-fetch is asked to recurse into submodules, it d=
ispatches
    -    a plain "git-fetch -C <submodule-dir>" (and some submodule related=
 options
    +    a plain "git-fetch -C <submodule-dir>" (with some submodule relate=
d options
         such as prefix and recusing strategy, but) without any information=
 of the
         remote or the tip that should be fetched.
    =20
    @@ -16,16 +16,22 @@
         topic downloaded as well. However these submodule changes reside i=
n their
         own repository in their own ref (refs/changes/<int>).
    =20
    -    Retry fetching a submodule if the object id that the superproject =
points
    -    to, cannot be found.
    +    Retry fetching a submodule by object name if the object id that th=
e
    +    superproject points to, cannot be found.
    =20
    -    This doesn't support fetching to FETCH_HEAD yet, but only into a l=
ocal
    -    branch. To make fetching into FETCH_HEAD work, we need some refact=
oring
    -    in builtin/fetch.c to adjust the calls to 'check_for_new_submodule=
_commits'
    -    that is coming in the next patch.
    +    This retrying does not happen when the "git fetch" done at the
    +    superproject is not storing the fetched results in remote
    +    tracking branches (i.e. instead just recording them to
    +    FETCH_HEAD) in this step. A later patch will fix this.
    +
    +    builtin/fetch used to only inspect submodules when they were fetch=
ed
    +    "on-demand", as in either on/off case it was clear whether the sub=
module
    +    needs to be fetched. However to know whether we need to try fetchi=
ng the
    +    object ids, we need to identify the object names, which is done in=
 this
    +    function check_for_new_submodule_commits(), so we'll also run that=
 code
    +    in case the submodule recursion is set to "on".
    =20
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
      diff --git a/builtin/fetch.c b/builtin/fetch.c
      --- a/builtin/fetch.c
    @@ -68,68 +74,181 @@
      	int result;
     =20
      	struct string_list changed_submodule_names;
    -+	struct string_list retry;
    ++	struct get_next_submodule_task **retry;
    ++	int retry_nr, retry_alloc;
      };
     -#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, STRING_=
LIST_INIT_DUP }
     +#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, \
     +		  STRING_LIST_INIT_DUP, \
    -+		  STRING_LIST_INIT_NODUP}
    ++		  NULL, 0, 0}
     =20
      static void calculate_changed_submodule_paths(
      	struct submodule_parallel_fetch *spf)
     @@
    + 	return spf->default_option;
    + }
    +=20
    ++struct get_next_submodule_task {
    ++	struct repository *repo;
    ++	const struct submodule *sub;
    ++	unsigned free_sub : 1; /* Do we need to free the submodule? */
    ++	struct oid_array *commits;
    ++};
    ++
    ++static const struct submodule *get_default_submodule(const char *path=
)
    ++{
    ++	struct submodule *ret =3D NULL;
    ++	const char *name =3D default_name_or_path(path);
    ++
    ++	if (!name)
    ++		return NULL;
    ++
    ++	ret =3D xmalloc(sizeof(*ret));
    ++	memset(ret, 0, sizeof(*ret));
    ++	ret->path =3D name;
    ++	ret->name =3D name;
    ++
    ++	return (const struct submodule *) ret;
    ++}
    ++
    ++static struct get_next_submodule_task *get_next_submodule_task_create=
(
    ++	struct repository *r, const char *path)
    ++{
    ++	struct get_next_submodule_task *task =3D xmalloc(sizeof(*task));
    ++	memset(task, 0, sizeof(*task));
    ++
    ++	task->sub =3D submodule_from_path(r, &null_oid, path);
    ++	if (!task->sub) {
    ++		task->sub =3D get_default_submodule(path);
    ++		task->free_sub =3D 1;
    ++	}
    ++
    ++	return task;
    ++}
    ++
    ++static void get_next_submodule_task_release(struct get_next_submodule=
_task *p)
    ++{
    ++	if (p->free_sub)
    ++		free((void*)p->sub);
    ++	p->free_sub =3D 0;
    ++	p->sub =3D NULL;
    ++
    ++	if (p->repo)
    ++		repo_clear(p->repo);
    ++	FREE_AND_NULL(p->repo);
    ++}
    ++
    + static struct repository *get_submodule_repo_for(struct repository *r=
,
    + 						 const struct submodule *sub)
    + {
    +@@
    + static int get_next_submodule(struct child_process *cp,
    + 			      struct strbuf *err, void *data, void **task_cb)
      {
    - 	int ret =3D 0;
    +-	int ret =3D 0;
      	struct submodule_parallel_fetch *spf =3D data;
    -+	struct string_list_item *it;
     =20
      	for (; spf->count < spf->r->index->cache_nr; spf->count++) {
    +-		struct strbuf submodule_prefix =3D STRBUF_INIT;
     +		int recurse_config;
    - 		struct strbuf submodule_prefix =3D STRBUF_INIT;
      		const struct cache_entry *ce =3D spf->r->index->cache[spf->count];
    - 		const char *git_dir, *default_argv;
    -@@
    - 			}
    + 		const char *default_argv;
    +-		const struct submodule *submodule;
    +-		struct repository *repo;
    +-		struct submodule default_submodule =3D SUBMODULE_INIT;
    ++		struct get_next_submodule_task *task;
    +=20
    + 		if (!S_ISGITLINK(ce->ce_mode))
    + 			continue;
    +=20
    +-		submodule =3D submodule_from_path(spf->r, &null_oid, ce->name);
    +-		if (!submodule) {
    +-			const char *name =3D default_name_or_path(ce->name);
    +-			if (name) {
    +-				default_submodule.path =3D name;
    +-				default_submodule.name =3D name;
    +-				submodule =3D &default_submodule;
    +-			}
    ++		task =3D get_next_submodule_task_create(spf->r, ce->name);
    ++
    ++		if (!task->sub) {
    ++			free(task);
    ++			continue;
      		}
     =20
     -		switch (get_fetch_recurse_config(submodule, spf))
    -+		recurse_config =3D get_fetch_recurse_config(submodule, spf);
    ++		recurse_config =3D get_fetch_recurse_config(task->sub, spf);
     +
     +		switch (recurse_config)
      		{
      		default:
      		case RECURSE_SUBMODULES_DEFAULT:
    + 		case RECURSE_SUBMODULES_ON_DEMAND:
    +-			if (!submodule ||
    ++			if (!task->sub ||
    + 			    !string_list_lookup(
    + 					&spf->changed_submodule_names,
    +-					submodule->name))
    ++					task->sub->name))
    + 				continue;
    + 			default_argv =3D "on-demand";
    + 			break;
    +@@
    + 			continue;
    + 		}
    +=20
    +-		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix, ce->name);
    +-		repo =3D get_submodule_repo_for(spf->r, submodule);
    +-		if (repo) {
    ++		task->repo =3D get_submodule_repo_for(spf->r, task->sub);
    ++		if (task->repo) {
    ++			struct strbuf submodule_prefix =3D STRBUF_INIT;
    + 			child_process_init(cp);
    + 			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
    +-			cp->dir =3D xstrdup(repo->gitdir);
    ++			cp->dir =3D task->repo->gitdir;
    + 			cp->git_cmd =3D 1;
    + 			if (!spf->quiet)
    + 				strbuf_addf(err, "Fetching submodule %s%s\n",
     @@
    - 		strbuf_release(&submodule_prefix);
    - 		if (ret) {
    + 			argv_array_pushv(&cp->args, spf->args.argv);
    + 			argv_array_push(&cp->args, default_argv);
    + 			argv_array_push(&cp->args, "--submodule-prefix");
    ++
    ++			strbuf_addf(&submodule_prefix, "%s%s/",
    ++						       spf->prefix,
    ++						       task->sub->path);
    + 			argv_array_push(&cp->args, submodule_prefix.buf);
    +=20
    +-			repo_clear(repo);
    +-			free(repo);
    +-			ret =3D 1;
    +-		}
    +-		strbuf_release(&submodule_prefix);
    +-		if (ret) {
      			spf->count++;
    -+			if (submodule !=3D &default_submodule)
    -+				/* discard const-ness: */
    -+				*task_cb =3D (void*)submodule;
    ++			*task_cb =3D task;
    ++
    ++			strbuf_release(&submodule_prefix);
      			return 1;
    ++		} else {
    ++			get_next_submodule_task_release(task);
    ++			free(task);
      		}
      	}
     +
    -+retry_next:
    -+
    -+	if (spf->retry.nr) {
    ++	if (spf->retry_nr) {
    ++		struct get_next_submodule_task *task =3D spf->retry[spf->retry_nr -=
 1];
     +		struct strbuf submodule_prefix =3D STRBUF_INIT;
    -+		const struct submodule *sub;
    ++		spf->retry_nr--;
     +
    -+		it =3D string_list_last(&spf->retry);
    -+		sub =3D submodule_from_name(spf->r, &null_oid,
    -+					  it->string);
    ++		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix, task->sub->pat=
h);
     +
     +		child_process_init(cp);
    -+		cp->dir =3D get_submodule_git_dir(spf->r, sub->path);
    -+		if (!cp->dir) {
    -+			string_list_pop(&spf->retry, 0);
    -+			goto retry_next;
    -+		}
     +		prepare_submodule_repo_env_in_gitdir(&cp->env_array);
     +		cp->git_cmd =3D 1;
    ++		cp->dir =3D task->repo->gitdir;
     +
    -+		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix, sub->path);
     +		argv_array_init(&cp->args);
     +		argv_array_pushv(&cp->args, spf->args.argv);
     +		argv_array_push(&cp->args, "on-demand");
    @@ -138,12 +257,11 @@
     +
     +		/* NEEDSWORK: have get_default_remote from s--h */
     +		argv_array_push(&cp->args, "origin");
    -+		oid_array_for_each_unique(it->util,
    ++		oid_array_for_each_unique(task->commits,
     +					  append_oid_to_argv, &cp->args);
     +
    -+		*task_cb =3D NULL; /* make sure we do not recurse forever */
    ++		*task_cb =3D task;
     +		strbuf_release(&submodule_prefix);
    -+		string_list_pop(&spf->retry, 0);
     +		return 1;
     +	}
     +
    @@ -151,6 +269,14 @@
      }
     =20
     @@
    + 			       void *cb, void *task_cb)
    + {
    + 	struct submodule_parallel_fetch *spf =3D cb;
    ++	struct get_next_submodule_task *task =3D task_cb;
    +=20
    + 	spf->result =3D 1;
    +=20
    ++	get_next_submodule_task_release(task);
      	return 0;
      }
     =20
    @@ -167,35 +293,46 @@
      			void *cb, void *task_cb)
      {
      	struct submodule_parallel_fetch *spf =3D cb;
    -+	struct submodule *sub =3D task_cb;
    -+	struct repository subrepo;
    ++	struct get_next_submodule_task *task =3D task_cb;
    ++	const struct submodule *sub;
    ++
    ++	struct string_list_item *it;
    ++	struct oid_array *commits;
     =20
      	if (retvalue)
      		spf->result =3D 1;
     =20
    -+	if (!sub)
    ++	if (!task)
     +		return 0;
     +
    -+	if (repo_submodule_init(&subrepo, spf->r, sub->path) < 0)
    -+		warning(_("Could not get submodule repository for submodule '%s' in=
 repository '%s'"),
    -+			  sub->path, spf->r->worktree);
    -+	else {
    -+		struct string_list_item *it;
    -+		struct oid_array *commits;
    ++	sub =3D task->sub;
    ++	if (!sub)
    ++		goto out;
     +
    -+		it =3D string_list_lookup(&spf->changed_submodule_names, sub->name)=
;
    -+		if (!it)
    -+			return 0;
    ++	it =3D string_list_lookup(&spf->changed_submodule_names, sub->name);
    ++	if (!it)
    ++		goto out;
    ++
    ++	commits =3D it->util;
    ++	oid_array_filter(commits,
    ++			 commit_exists_in_sub,
    ++			 task->repo);
     +
    -+		commits =3D it->util;
    -+		oid_array_filter(commits,
    -+				 commit_exists_in_sub,
    -+				 &subrepo);
    ++	/* Are there commits that do not exist? */
    ++	if (commits->nr) {
    ++		/* We already tried fetching them, do not try again. */
    ++		if (task->commits)
    ++			return 0;
     +
    -+		if (commits->nr)
    -+			string_list_append(&spf->retry, sub->name)
    -+				->util =3D commits;
    ++		task->commits =3D commits;
    ++		ALLOC_GROW(spf->retry, spf->retry_nr + 1, spf->retry_alloc);
    ++		spf->retry[spf->retry_nr] =3D task;
    ++		spf->retry_nr++;
    ++		return 0;
     +	}
    ++
    ++out:
    ++	get_next_submodule_task_release(task);
     +
      	return 0;
      }
  9:  c16d21313f6 ! 224:  d02ee9ef485 builtin/fetch: check for submodule up=
dates for non branch fetches
    @@ -2,11 +2,29 @@
    =20
         builtin/fetch: check for submodule updates for non branch fetches
    =20
    -    For Gerrit users that use submodules the invocation of fetch witho=
ut a
    -    branch is their main use case.
    +    Gerrit, the code review tool, has a different workflow than our ma=
iling
    +    list based approach. Usually users upload changes to a Gerrit serv=
er and
    +    continuous integration and testing happens by bots. Sometimes howe=
ver a
    +    user wants to checkout a change locally and look at it locally. Fo=
r this
    +    use case, Gerrit offers a command line snippet to copy and paste t=
o your
    +    terminal, which looks like
    +
    +      git fetch https://<host>/gerrit refs/changes/<id> &&
    +      git checkout FETCH_HEAD
    +
    +    For Gerrit changes that contain changing submodule gitlinks, it wo=
uld be
    +    easy to extend both the fetch and checkout with the '--recurse-sub=
modules'
    +    flag, such that this command line snippet would produce the state =
of a
    +    change locally.
    +
    +    However the functionality added in the previous patch, which would
    +    ensure that we fetch the objects in the submodule that the gitlink=
 pointed
    +    at, only works for remote tracking branches so far, not for FETCH_=
HEAD.
    +
    +    Make sure that fetching a superproject to its FETCH_HEAD, also res=
pects
    +    the existence checks for objects in the submodule recursion.
    =20
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
      diff --git a/builtin/fetch.c b/builtin/fetch.c
      --- a/builtin/fetch.c
