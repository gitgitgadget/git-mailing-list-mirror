Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FE131F405
	for <e@80x24.org>; Wed,  8 Aug 2018 22:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbeHIAkO (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 20:40:14 -0400
Received: from mail-oi0-f74.google.com ([209.85.218.74]:38703 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHIAkO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 20:40:14 -0400
Received: by mail-oi0-f74.google.com with SMTP id t138-v6so3642856oih.5
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 15:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jmw++n1BoCg84PdXk+yj/6R3Sb8HGAW06HAXWQR/uYI=;
        b=UYVI1ZySBFYGBERf+c/vEXQ/us8dp+c1e2KKEm0BzGycMeby+Vca96ERj69kKl2AKg
         zkur33U4g0veCjiSWnnEE4clgulAaJWLGhNa2DvXfuswGAqvTfI9QJWLI9xi5N2Q+TY7
         XivOw4zwKsofJeb73F6ruhGAGQfA+H7JArd1d7VIg02JCLv1PY+Z8Kd6TmzK/23k8Iw5
         QeihAmhMnXedw6kBXOQCHj7yPBd10wA1By/yiDTjnjG4H7Giv7dAs8shYyTsrC50Icx7
         PCpIiCi7muGqom5hz89ee29qelBi3X9iqCaOT0asU6hDsD+j8U+i5OrbMchpa1VT5V3Y
         JYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jmw++n1BoCg84PdXk+yj/6R3Sb8HGAW06HAXWQR/uYI=;
        b=BVtW3wBfJ4QFCimXvnRz/AMw+TbwgxGC9gQQk0WdS9jKuA7aEWiAzVK1dTJythRNR1
         irbsdvbwNyqi3wdr+YZd80mwgVeumMk3F1DW9RhR/hvfjxhPnUWvP+PT31bYeozoIiDk
         qnQaEWxwMRTcQ5nmrsy892IlLwBThgyCCokYVBRr3/Efe1sIbEh4tGJg/apNEeSeRP+x
         gr0eBg1A+f8m/xPaRjzgDwUy/ByeCsNW9YHTERpzIgSRAromIe4+5EWepmO7pKBDDZe0
         hOkaT80ufC7vMw88oYqU7GQiDWPxva8GvT2jXNGXhwIMsALL3kW5k/hyCGdUIZyw029P
         h13Q==
X-Gm-Message-State: AOUpUlGLp3dgpuhKjRZspoWrzV7EZEGPeoFCiSp9zE2PtrT86w5Eo+iZ
        QTXtAu6u2Kb7Gh1AGb6Peeg5zdOiW1BoVkwrlrNsbK4i0/pY6HF3KWbVheBYeKyClZqBQW014du
        9H6Kc6Y7Wfog73ssspE5yIr5ZVEHT/NoJvi70qhjfShjGomYp9P3Vdf3tHQ2Z
X-Google-Smtp-Source: AA+uWPyiIgzf2aWe2RYdwEZZxhnC5M1+AFSCkReNy73Ffp+FTaLvvarNzb3lLkSJ+MJFFUy0n6Ec3iQ2r0G7
X-Received: by 2002:aca:37c5:: with SMTP id e188-v6mr2700251oia.113.1533766712680;
 Wed, 08 Aug 2018 15:18:32 -0700 (PDT)
Date:   Wed,  8 Aug 2018 15:17:52 -0700
In-Reply-To: <20180808221752.195419-1-sbeller@google.com>
Message-Id: <20180808221752.195419-11-sbeller@google.com>
Mime-Version: 1.0
References: <20180808221752.195419-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 10/10] fetch: retry fetching submodules if sha1 were not fetched
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     hvoigt@hvoigt.net, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently when git-fetch is asked to recurse into submodules, it dispatches
a plain "git-fetch -C <submodule-dir>" (and some submodule related options
such as prefix and recusing strategy, but) without any information of the
remote or the tip that should be fetched.

This works surprisingly well in some workflows (such as using submodules
as a third party library), while not so well in other scenarios, such
as in a Gerrit topic-based workflow, that can tie together changes
(potentially across repositories) on the server side. One of the parts
of such a Gerrit workflow is to download a change when wanting to examine
it, and you'd want to have its submodule changes that are in the same
topic downloaded as well. However these submodule changes reside in their
own repository in their on ref (refs/changes/<int>).

Retry fetching a submodule if the object id that the superproject points
to, cannot be found.

Note: This is an RFC and doesn't support fetching to FETCH_HEAD yet, but
only into a local branch. To make fetching into FETCH_HEAD work, we need
some refactoring in builtin/fetch.c to adjust the calls to
'check_for_new_submodule_commits'.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fetch.c             |  9 ++---
 submodule.c                 | 79 ++++++++++++++++++++++++++++++++++++-
 t/t5526-fetch-submodules.sh | 16 ++++++++
 3 files changed, 97 insertions(+), 7 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 34d2bd123b3..9396e6a44c6 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -700,8 +700,7 @@ static int update_local_ref(struct ref *ref,
 			what = _("[new ref]");
 		}
 
-		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
-		    (recurse_submodules != RECURSE_SUBMODULES_ON))
+		if (recurse_submodules != RECURSE_SUBMODULES_OFF)
 			check_for_new_submodule_commits(&ref->new_oid);
 		r = s_update_ref(msg, ref, 0);
 		format_display(display, r ? '!' : '*', what,
@@ -716,8 +715,7 @@ static int update_local_ref(struct ref *ref,
 		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV);
 		strbuf_addstr(&quickref, "..");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
-		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
-		    (recurse_submodules != RECURSE_SUBMODULES_ON))
+		if (recurse_submodules != RECURSE_SUBMODULES_OFF)
 			check_for_new_submodule_commits(&ref->new_oid);
 		r = s_update_ref("fast-forward", ref, 1);
 		format_display(display, r ? '!' : ' ', quickref.buf,
@@ -731,8 +729,7 @@ static int update_local_ref(struct ref *ref,
 		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV);
 		strbuf_addstr(&quickref, "...");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
-		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
-		    (recurse_submodules != RECURSE_SUBMODULES_ON))
+		if (recurse_submodules != RECURSE_SUBMODULES_OFF)
 			check_for_new_submodule_commits(&ref->new_oid);
 		r = s_update_ref("forced-update", ref, 1);
 		format_display(display, r ? '!' : '+', quickref.buf,
diff --git a/submodule.c b/submodule.c
index ec7ea6f8c2d..6cbd0b1a470 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1127,6 +1127,7 @@ struct submodule_parallel_fetch {
 	int result;
 
 	struct string_list changed_submodule_names;
+	struct string_list retry;
 };
 #define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, STRING_LIST_INIT_DUP }
 
@@ -1259,8 +1260,10 @@ static int get_next_submodule(struct child_process *cp,
 {
 	int ret = 0;
 	struct submodule_parallel_fetch *spf = data;
+	struct string_list_item *retry_it;
 
 	for (; spf->count < spf->r->index->cache_nr; spf->count++) {
+		int recurse_config;
 		struct strbuf submodule_prefix = STRBUF_INIT;
 		const struct cache_entry *ce = spf->r->index->cache[spf->count];
 		const char *git_dir, *default_argv;
@@ -1280,7 +1283,9 @@ static int get_next_submodule(struct child_process *cp,
 			}
 		}
 
-		switch (get_fetch_recurse_config(submodule, spf))
+		recurse_config = get_fetch_recurse_config(submodule, spf);
+
+		switch (recurse_config)
 		{
 		default:
 		case RECURSE_SUBMODULES_DEFAULT:
@@ -1318,9 +1323,46 @@ static int get_next_submodule(struct child_process *cp,
 		strbuf_release(&submodule_prefix);
 		if (ret) {
 			spf->count++;
+			if (submodule != &default_submodule)
+				/* discard const-ness: */
+				*task_cb = (void*)submodule;
 			return 1;
 		}
 	}
+
+retry_next:
+	retry_it = string_list_pop(&spf->retry);
+	if (retry_it) {
+		struct strbuf submodule_prefix = STRBUF_INIT;
+		const struct submodule *sub =
+				submodule_from_name(spf->r,
+						    &null_oid,
+						    retry_it->string);
+
+		child_process_init(cp);
+		cp->dir = get_submodule_git_dir(spf->r, sub->path);
+		if (!cp->dir)
+			goto retry_next;
+		prepare_submodule_repo_env_in_gitdir(&cp->env_array);
+		cp->git_cmd = 1;
+
+		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix, sub->path);
+		argv_array_init(&cp->args);
+		argv_array_pushv(&cp->args, spf->args.argv);
+		argv_array_push(&cp->args, "on-demand");
+		argv_array_push(&cp->args, "--submodule-prefix");
+		argv_array_push(&cp->args, submodule_prefix.buf);
+
+		/* NEEDSWORK: have get_default_remote from s--h */
+		argv_array_push(&cp->args, "origin");
+		oid_array_for_each_unique(retry_it->util,
+					  append_oid_to_argv, &cp->args);
+
+		*task_cb = NULL; /* make sure we do not recurse forever */
+		strbuf_release(&submodule_prefix);
+		return 1;
+	}
+
 	return 0;
 }
 
@@ -1334,14 +1376,49 @@ static int fetch_start_failure(struct strbuf *err,
 	return 0;
 }
 
+static int commit_exists_in_sub(const struct object_id *oid, void *data)
+{
+	struct repository *subrepo = data;
+
+	enum object_type type = oid_object_info(subrepo, oid, NULL);
+
+	return type == OBJ_COMMIT;
+}
+
 static int fetch_finish(int retvalue, struct strbuf *err,
 			void *cb, void *task_cb)
 {
 	struct submodule_parallel_fetch *spf = cb;
+	struct submodule *sub = task_cb;
+	struct repository subrepo;
 
 	if (retvalue)
 		spf->result = 1;
 
+	if (!sub)
+		return 0;
+
+	if (repo_submodule_init(&subrepo, spf->r, sub->path) < 0)
+		warning(_("Could not get submodule repository for submodule '%s' in repository '%s'"),
+			  sub->path, spf->r->worktree);
+	else {
+		struct string_list_item *it;
+		struct oid_array *commits;
+
+		it = string_list_lookup(&spf->changed_submodule_names, sub->name);
+		if (!it)
+			return 0;
+
+		commits = it->util;
+		oid_array_remove_if(commits,
+				    commit_exists_in_sub,
+				    &subrepo);
+
+		if (commits->nr)
+			string_list_append(&spf->retry, sub->name)
+				->util = commits;
+	}
+
 	return 0;
 }
 
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 4437cb17698..ade4bf6d0bc 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -606,4 +606,20 @@ test_expect_success "fetch new commits when submodule got renamed" '
 	test_cmp expect actual
 '
 
+test_expect_success "fetch new commits on-demand when they are not reachable" '
+	git checkout --detach &&
+	C=$(git -C submodule commit-tree -m "new change outside refs/heads" HEAD^{tree}) &&
+	git -C submodule update-ref refs/changes/1 $C &&
+	git update-index --cacheinfo 160000 $C submodule &&
+	git commit -m "updated submodule outside of refs/heads" &&
+	D=$(git rev-parse HEAD) &&
+	git update-ref refs/changes/2 $D &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules --recurse-submodules-default on-demand origin refs/changes/2:refs/heads/my_branch &&
+		git -C submodule cat-file -t $C &&
+		git checkout --recurse-submodules FETCH_HEAD
+	)
+'
+
 test_done
-- 
2.18.0.597.ga71716f1ad-goog

