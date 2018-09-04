Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D9E91F404
	for <e@80x24.org>; Tue,  4 Sep 2018 23:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeIED3i (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 23:29:38 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:48831 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeIED3i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 23:29:38 -0400
Received: by mail-vk0-f73.google.com with SMTP id g71-v6so2024382vke.15
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 16:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7FBRc43wdtavAcVxQgqeVJ/7ldLPrK9iFl9RZtarU0w=;
        b=A+0CwsXvJlN/GFAeJjbc7QURbJWBJ9GsfDC5CQbDPayhohIx0rBs1p+n+h9Kz6Zbpy
         VKkQ1DVy6Ki5IY7GUIKCx6XjSbRemnsIODuLwaG4vl/zKucwrkpXcMm8tp72V1HcS3L7
         VvDWQ6umSkzbDstSnbjOvtU01JUmEr8W96MSQjl6m1cM5o3GA/fvFYG4jivQhihpt5Is
         /AX2L0EscHhFKgtcyDP6Y9HJ4K4QFk1wgm8B4W2zKsFs7gC4nRvC2I9I/ft3jzc0vQPN
         r31FzBbaLYsxnBpsb9KAX22frxXKspsRcrNQbFtN2KFymXKONinSNIt+T91+n3d+WXs3
         S3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7FBRc43wdtavAcVxQgqeVJ/7ldLPrK9iFl9RZtarU0w=;
        b=FDXXLONtsbQDGTHw09YOEm0PVq6rNgvfV2NFCHHmd/KspmJ85dQC5DfGQ8t6Va99pQ
         oUhWIFGVOWq6EpxzyzhxNasqNW5P09Mt7QYYk2fYSyhvu9I8rJ0LrPKS322n75T7TqzD
         rwV+3pTPOqFVoAd6rZHGAELPUyBaGA5yLiD+JvzhEoPil8ERvpVQw+79bixkU/DO8v0x
         tde00wPXkZZeuhn2LTnReSPcvvtpY3bowJM3k65FBesmetKFw9oqOjmlmTqtAd/O0y/P
         q0yyK1YBWKca3VfWFxpwB128mavrynApge8Tstp1gaJSIvE9N5IRPz61MBTfxTcktXlC
         PG0g==
X-Gm-Message-State: APzg51CdpyRrH+BVH9RGz48V+dV2X5P0Mgny29sSelmcjtMWCk9lU1HJ
        SYlXB+KSCIP0O0YCIcSsvDlMg1qLc6CEPl0ZHu3K0+BiAy15+VBk8Mu2TzMwqVUw/NE1/wTgZa4
        W+PLokq8lVW0xKqeitG5XRDRGsH2rTaG/fUASHXdoUzLlLbvUETHCP4lXNjs0
X-Google-Smtp-Source: ANB0VdYRI5j69IVl0jXqBC3N/I1Lw+GZLRcpN57fp610kLGz2ebgLjmGoMpZkNmc5E/DBl1AQbUvB2wgvWk1
X-Received: by 2002:a1f:2115:: with SMTP id h21-v6mr14204427vkh.121.1536102141013;
 Tue, 04 Sep 2018 16:02:21 -0700 (PDT)
Date:   Tue,  4 Sep 2018 16:01:48 -0700
In-Reply-To: <20180904230149.180332-1-sbeller@google.com>
Message-Id: <20180904230149.180332-11-sbeller@google.com>
Mime-Version: 1.0
References: <20180904230149.180332-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
Subject: [PATCH 10/11] fetch: retry fetching submodules if sha1 were not fetched
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
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
own repository in their own ref (refs/changes/<int>).

Retry fetching a submodule if the object id that the superproject points
to, cannot be found.

Note: This is an RFC and doesn't support fetching to FETCH_HEAD yet, but
only into a local branch. To make fetching into FETCH_HEAD work, we need
some refactoring in builtin/fetch.c to adjust the calls to
'check_for_new_submodule_commits'.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fetch.c             |  9 ++--
 submodule.c                 | 87 ++++++++++++++++++++++++++++++++++++-
 t/t5526-fetch-submodules.sh | 16 +++++++
 3 files changed, 104 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 61bec5d213d..95c44bf6ffa 100644
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
index 8b67f086895..702cba138be 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1127,8 +1127,11 @@ struct submodule_parallel_fetch {
 	int result;
 
 	struct string_list changed_submodule_names;
+	struct string_list retry;
 };
-#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, STRING_LIST_INIT_DUP }
+#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, \
+		  STRING_LIST_INIT_DUP, \
+		  STRING_LIST_INIT_NODUP}
 
 static void calculate_changed_submodule_paths(
 	struct submodule_parallel_fetch *spf)
@@ -1259,8 +1262,10 @@ static int get_next_submodule(struct child_process *cp,
 {
 	int ret = 0;
 	struct submodule_parallel_fetch *spf = data;
+	struct string_list_item *it;
 
 	for (; spf->count < spf->r->index->cache_nr; spf->count++) {
+		int recurse_config;
 		struct strbuf submodule_prefix = STRBUF_INIT;
 		const struct cache_entry *ce = spf->r->index->cache[spf->count];
 		const char *git_dir, *default_argv;
@@ -1280,7 +1285,9 @@ static int get_next_submodule(struct child_process *cp,
 			}
 		}
 
-		switch (get_fetch_recurse_config(submodule, spf))
+		recurse_config = get_fetch_recurse_config(submodule, spf);
+
+		switch (recurse_config)
 		{
 		default:
 		case RECURSE_SUBMODULES_DEFAULT:
@@ -1318,9 +1325,50 @@ static int get_next_submodule(struct child_process *cp,
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
+
+	if (spf->retry.nr) {
+		struct strbuf submodule_prefix = STRBUF_INIT;
+		const struct submodule *sub;
+
+		it = string_list_last(&spf->retry);
+		sub = submodule_from_name(spf->r, &null_oid,
+					  it->string);
+
+		child_process_init(cp);
+		cp->dir = get_submodule_git_dir(spf->r, sub->path);
+		if (!cp->dir) {
+			string_list_pop(&spf->retry, 0);
+			goto retry_next;
+		}
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
+		oid_array_for_each_unique(it->util,
+					  append_oid_to_argv, &cp->args);
+
+		*task_cb = NULL; /* make sure we do not recurse forever */
+		strbuf_release(&submodule_prefix);
+		string_list_pop(&spf->retry, 0);
+		return 1;
+	}
+
 	return 0;
 }
 
@@ -1334,14 +1382,49 @@ static int fetch_start_failure(struct strbuf *err,
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
+		oid_array_filter(commits,
+				 commit_exists_in_sub,
+				 &subrepo);
+
+		if (commits->nr)
+			string_list_append(&spf->retry, sub->name)
+				->util = commits;
+	}
+
 	return 0;
 }
 
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 42692219a1a..af12c50e7dd 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -605,4 +605,20 @@ test_expect_success "fetch new commits when submodule got renamed" '
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
2.19.0.rc1.350.ge57e33dbd1-goog

