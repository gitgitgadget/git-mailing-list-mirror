Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C2FC433E1
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 23:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF18A21D82
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 23:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VI1WFdkb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbgFSXgf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 19:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730500AbgFSXgd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 19:36:33 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8802BC06174E
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 16:36:33 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id 9so10858307ilg.12
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 16:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G97LmBGfV0fjjIl4U7x8zlEK5rE+kSBFNNHRVp6QFZY=;
        b=VI1WFdkboMzU7fNb9gmwW6IvqATGFn4lUH0Nc7oOWqqFH/i6revvvnz0680v+cMFCG
         EWJRp46RdiBNgADxTstHD0CBntWZ8kN4a3rxFIKiiV3LzWv/zpz/tM4BDGOTNl3VzZg0
         Xsxbpo826Bf48WNZx+XNjJWZE7gK4Y08jmHhJKAvdpHTqpv8PsBUTPseLQKAFIIp5LWQ
         ixF1dQJ1SUSHt+Mrms5eQQ1/ADMNSEINzC1LrFeQhtbLzl3WB8/2euvM8OSNbZhCV6Ie
         C3bbNSdG6tTC06+wARbwUa3zXFxVM1NDTAEPlxabCYnxLllsM5SWIyTKBD8brzQ8A7Xk
         aEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=G97LmBGfV0fjjIl4U7x8zlEK5rE+kSBFNNHRVp6QFZY=;
        b=qQXbbnHzRz4RyTnlZXgvhiIjh+W1V0qXXkdh/eAEaUYJwUt0vPaFC680Bd9MxTcltK
         7YrpjK6o5NsuTGpikkclqQ1IgFEJAEcxVvNm0xSH2bEjzHAuYGqOBKxmg7a0dgI8rIwJ
         GUoXALjy7Z71x9DkOJqt3fChITtBPbwHzsnv21Ee6D6b4KXrTvsDgP7iXJpGAR+kllr2
         XepuECKQpsWRABynE6rwq2ycyQBHDtYwgbnjDoyeAJScaVTwABoY9KioMm+sKpjGTwX3
         P59obg23iI5JrntSQAhD5X58pGOOlFr1H0bWY3IsyAA0ovif8CB37smLrN+/IgKKjLWy
         YBuQ==
X-Gm-Message-State: AOAM531Ef1+5FWoH0xjYNTpnujnvAmWxmSCtUhbFF906yvmSkc13Oa/k
        QpkvqSmF6O7Qq2sTtZfmrUXQUWsxPZg=
X-Google-Smtp-Source: ABdhPJyRjcU0Kdr1sJkN1JoLswv/bCy19QtWT9IHiI5UUfUdKGJMioZuBgLQgnv05HmIhMA/3cQgAQ==
X-Received: by 2002:a05:6e02:cd:: with SMTP id r13mr447609ilq.119.1592609792419;
        Fri, 19 Jun 2020 16:36:32 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id q5sm3890723ile.37.2020.06.19.16.36.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2020 16:36:31 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/2] worktree: drop get_worktrees() unused 'flags' argument
Date:   Fri, 19 Jun 2020 19:35:44 -0400
Message-Id: <20200619233544.42025-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.27.0.221.g4d328a12d9
In-Reply-To: <20200619233544.42025-1-sunshine@sunshineco.com>
References: <20200619233544.42025-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

get_worktrees() accepts a 'flags' argument, however, there are no
existing flags (the lone flag GWT_SORT_LINKED was recently retired) and
no behavior which can be tweaked. Therefore, drop the 'flags' argument.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 branch.c                  |  2 +-
 builtin/branch.c          |  2 +-
 builtin/config.c          |  2 +-
 builtin/fsck.c            |  2 +-
 builtin/reflog.c          |  2 +-
 builtin/worktree.c        | 12 ++++++------
 ref-filter.c              |  2 +-
 revision.c                |  4 ++--
 t/helper/test-ref-store.c |  2 +-
 worktree.c                |  6 +++---
 worktree.h                |  2 +-
 11 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/branch.c b/branch.c
index 2d9e7675a6..7095f78058 100644
--- a/branch.c
+++ b/branch.c
@@ -370,7 +370,7 @@ int replace_each_worktree_head_symref(const char *oldref, const char *newref,
 				      const char *logmsg)
 {
 	int ret = 0;
-	struct worktree **worktrees = get_worktrees(0);
+	struct worktree **worktrees = get_worktrees();
 	int i;
 
 	for (i = 0; worktrees[i]; i++) {
diff --git a/builtin/branch.c b/builtin/branch.c
index accb61b1aa..d1649e4595 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -468,7 +468,7 @@ static void print_current_branch_name(void)
 
 static void reject_rebase_or_bisect_branch(const char *target)
 {
-	struct worktree **worktrees = get_worktrees(0);
+	struct worktree **worktrees = get_worktrees();
 	int i;
 
 	for (i = 0; worktrees[i]; i++) {
diff --git a/builtin/config.c b/builtin/config.c
index ee4aef6a35..5e39f61885 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -672,7 +672,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		given_config_source.file = git_pathdup("config");
 		given_config_source.scope = CONFIG_SCOPE_LOCAL;
 	} else if (use_worktree_config) {
-		struct worktree **worktrees = get_worktrees(0);
+		struct worktree **worktrees = get_worktrees();
 		if (repository_format_worktree_config)
 			given_config_source.file = git_pathdup("config.worktree");
 		else if (worktrees[0] && worktrees[1])
diff --git a/builtin/fsck.c b/builtin/fsck.c
index f02cbdb439..82332e0e86 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -577,7 +577,7 @@ static void get_default_heads(void)
 
 	for_each_rawref(fsck_handle_ref, NULL);
 
-	worktrees = get_worktrees(0);
+	worktrees = get_worktrees();
 	for (p = worktrees; *p; p++) {
 		struct worktree *wt = *p;
 		struct strbuf ref = STRBUF_INIT;
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 52ecf6d43c..ca1d8079f3 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -615,7 +615,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		int i;
 
 		memset(&collected, 0, sizeof(collected));
-		worktrees = get_worktrees(0);
+		worktrees = get_worktrees();
 		for (p = worktrees; *p; p++) {
 			if (!all_worktrees && !(*p)->is_current)
 				continue;
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 13b94d36d9..f0cbdef718 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -325,7 +325,7 @@ static int add_worktree(const char *path, const char *refname,
 	struct strbuf sb_name = STRBUF_INIT;
 	struct worktree **worktrees;
 
-	worktrees = get_worktrees(0);
+	worktrees = get_worktrees();
 	check_candidate_path(path, opts->force, worktrees, "add");
 	free_worktrees(worktrees);
 	worktrees = NULL;
@@ -727,7 +727,7 @@ static int list(int ac, const char **av, const char *prefix)
 	if (ac)
 		usage_with_options(worktree_usage, options);
 	else {
-		struct worktree **worktrees = get_worktrees(0);
+		struct worktree **worktrees = get_worktrees();
 		int path_maxlen = 0, abbrev = DEFAULT_ABBREV, i;
 
 		/* sort worktrees by path but keep main worktree at top */
@@ -761,7 +761,7 @@ static int lock_worktree(int ac, const char **av, const char *prefix)
 	if (ac != 1)
 		usage_with_options(worktree_usage, options);
 
-	worktrees = get_worktrees(0);
+	worktrees = get_worktrees();
 	wt = find_worktree(worktrees, prefix, av[0]);
 	if (!wt)
 		die(_("'%s' is not a working tree"), av[0]);
@@ -794,7 +794,7 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
 	if (ac != 1)
 		usage_with_options(worktree_usage, options);
 
-	worktrees = get_worktrees(0);
+	worktrees = get_worktrees();
 	wt = find_worktree(worktrees, prefix, av[0]);
 	if (!wt)
 		die(_("'%s' is not a working tree"), av[0]);
@@ -868,7 +868,7 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 	strbuf_addstr(&dst, path);
 	free(path);
 
-	worktrees = get_worktrees(0);
+	worktrees = get_worktrees();
 	wt = find_worktree(worktrees, prefix, av[0]);
 	if (!wt)
 		die(_("'%s' is not a working tree"), av[0]);
@@ -994,7 +994,7 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
 	if (ac != 1)
 		usage_with_options(worktree_usage, options);
 
-	worktrees = get_worktrees(0);
+	worktrees = get_worktrees();
 	wt = find_worktree(worktrees, prefix, av[0]);
 	if (!wt)
 		die(_("'%s' is not a working tree"), av[0]);
diff --git a/ref-filter.c b/ref-filter.c
index bf7b70299b..8447cb09be 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1579,7 +1579,7 @@ static void lazy_init_worktree_map(void)
 	if (ref_to_worktree_map.worktrees)
 		return;
 
-	ref_to_worktree_map.worktrees = get_worktrees(0);
+	ref_to_worktree_map.worktrees = get_worktrees();
 	hashmap_init(&(ref_to_worktree_map.map), ref_to_worktree_map_cmpfnc, NULL, 0);
 	populate_worktree_map(&(ref_to_worktree_map.map), ref_to_worktree_map.worktrees);
 }
diff --git a/revision.c b/revision.c
index ebb4d2a0f2..f20d545ed5 100644
--- a/revision.c
+++ b/revision.c
@@ -1609,7 +1609,7 @@ static void add_other_reflogs_to_pending(struct all_refs_cb *cb)
 {
 	struct worktree **worktrees, **p;
 
-	worktrees = get_worktrees(0);
+	worktrees = get_worktrees();
 	for (p = worktrees; *p; p++) {
 		struct worktree *wt = *p;
 
@@ -1697,7 +1697,7 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 	if (revs->single_worktree)
 		return;
 
-	worktrees = get_worktrees(0);
+	worktrees = get_worktrees();
 	for (p = worktrees; *p; p++) {
 		struct worktree *wt = *p;
 		struct index_state istate = { NULL };
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 799fc00aa1..759e69dc54 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -37,7 +37,7 @@ static const char **get_store(const char **argv, struct ref_store **refs)
 
 		*refs = get_submodule_ref_store(gitdir);
 	} else if (skip_prefix(argv[0], "worktree:", &gitdir)) {
-		struct worktree **p, **worktrees = get_worktrees(0);
+		struct worktree **p, **worktrees = get_worktrees();
 
 		for (p = worktrees; *p; p++) {
 			struct worktree *wt = *p;
diff --git a/worktree.c b/worktree.c
index 8f24fbdc1e..ff9b7d847f 100644
--- a/worktree.c
+++ b/worktree.c
@@ -123,7 +123,7 @@ static void mark_current_worktree(struct worktree **worktrees)
 	free(git_dir);
 }
 
-struct worktree **get_worktrees(unsigned flags)
+struct worktree **get_worktrees(void)
 {
 	struct worktree **list = NULL;
 	struct strbuf path = STRBUF_INIT;
@@ -404,7 +404,7 @@ const struct worktree *find_shared_symref(const char *symref,
 
 	if (worktrees)
 		free_worktrees(worktrees);
-	worktrees = get_worktrees(0);
+	worktrees = get_worktrees();
 
 	for (i = 0; worktrees[i]; i++) {
 		struct worktree *wt = worktrees[i];
@@ -563,7 +563,7 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
 	struct worktree **worktrees, **p;
 	int ret = 0;
 
-	worktrees = get_worktrees(0);
+	worktrees = get_worktrees();
 	for (p = worktrees; *p; p++) {
 		struct worktree *wt = *p;
 		struct object_id oid;
diff --git a/worktree.h b/worktree.h
index bd2235abe0..516744c433 100644
--- a/worktree.h
+++ b/worktree.h
@@ -25,7 +25,7 @@ struct worktree {
  * The caller is responsible for freeing the memory from the returned
  * worktrees by calling free_worktrees().
  */
-struct worktree **get_worktrees(unsigned flags);
+struct worktree **get_worktrees(void);
 
 /*
  * Returns 1 if linked worktrees exist, 0 otherwise.
-- 
2.27.0.221.g4d328a12d9

