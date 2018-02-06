Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 485B71F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752460AbeBFA0r (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:26:47 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46850 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752302AbeBFA0m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:26:42 -0500
Received: by mail-pg0-f66.google.com with SMTP id s9so159228pgq.13
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oaMUdLgm9XfYemLGukwcvaCjZuINVveKl7x9+HFpQag=;
        b=gfjjoSNuhxUR//8IwdHBdtoMAxqU3JJvYavEVeZ9khHA4eLLhQC9hfDm0oD/srjak2
         XFh88AkiZEjqUuyhNaq6qDUiPtDXgvL6YZ+xQsWIo7BGoyXzB9piw5ekrJDzHCffk6TG
         sUdPi2+3LNevDHRriiOwTpGyXXy2TQAv+WMqTM07IQO+PEGT56NNzAOfnflLsjOS5t08
         /ZJfOlBgKwdzPLmSUKz6ZqGcnNZI/uaOtExsnYq7nv93RlJPni7ECc2S2aOeenri68CT
         eYPtUn88JrwEk8+ZQV5pbIWJ+Oh/YAeE+hFyyth0A6YrTLvso4MqFSnPEi3t2Ix348gS
         gdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oaMUdLgm9XfYemLGukwcvaCjZuINVveKl7x9+HFpQag=;
        b=XvZtFwJ0VRxPPsDTN3QkyRwhwel7vEFDoFY/UwW6srXckBzJXMHdqHlkHWZDErBsGZ
         xPBNCBUfOMSE6INdjuoc47WYdRgVtxNx0LOBWCZGxDMjl+NBrCJriCLADHbj0El6iV7w
         kLF5qjiKdCAYWPKYAEleRc58TEX3vHywgu3iSW3UiyLFJOX1xs2F66vbAv0NZnQw+0du
         YoeiJ4WXkJizyZK89kYG/pt1kFqcZl9xax5zoZF7Xfc/6A8GXoW3dNMziZr+TKQ32b9H
         C3qBPgH7UyfttJrba/dU5T23RH6KL6ilnRtdY0tPXM22COgfDUpB2SFwRqqSr+JLIe/J
         kFpg==
X-Gm-Message-State: APf1xPA8iqWO8DuMxahosUIyA4J4GhVIpqTsSlG9u3lyPIgTXMgQNObE
        8nA5b8R0YXY8iSzzya7JIVXUDkiSdJewB9cXwc5OrWwRLfTX8H64Lkr6GQfPEBr7wJUa769/Jz9
        0kRFvnfmy
X-Google-Smtp-Source: AH8x225QVuWcAISmRb7BBKmW5hEK1twlXuymYJ9pMcd9MsMlYhQIDfS4rpFRjZ8z99sv72Enl77m7w==
X-Received: by 10.99.7.83 with SMTP id 80mr445189pgh.111.1517876801184;
        Mon, 05 Feb 2018 16:26:41 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id k14sm18823178pfb.15.2018.02.05.16.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:26:40 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 155/194] shallow: add repository argument to is_repository_shallow
Date:   Mon,  5 Feb 2018 16:17:10 -0800
Message-Id: <20180206001749.218943-57-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
X-ccpol: medium
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fetch.c                       | 2 +-
 builtin/pack-objects.c                | 4 ++--
 builtin/prune.c                       | 2 +-
 builtin/rev-parse.c                   | 3 ++-
 commit.c                              | 2 +-
 commit.h                              | 2 ++
 contrib/coccinelle/object_store.cocci | 5 +++++
 fetch-pack.c                          | 4 ++--
 send-pack.c                           | 6 +++---
 shallow.c                             | 8 ++++----
 upload-pack.c                         | 2 +-
 11 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 904496fa33..da99363067 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1352,7 +1352,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (unshallow) {
 		if (depth)
 			die(_("--depth and --unshallow cannot be used together"));
-		else if (!is_repository_shallow())
+		else if (!is_repository_shallow(the_repository))
 			die(_("--unshallow on a complete repository does not make sense"));
 		else
 			depth = xstrfmt("%d", INFINITE_DEPTH);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a16ecc3fe0..9a98154ec4 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2846,7 +2846,7 @@ static void get_object_list(int ac, const char **av)
 	setup_revisions(ac, av, &revs, NULL);
 
 	/* make sure shallows are read */
-	is_repository_shallow();
+	is_repository_shallow(the_repository);
 
 	while (fgets(line, sizeof(line), stdin) != NULL) {
 		int len = strlen(line);
@@ -3123,7 +3123,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		use_bitmap_index = use_bitmap_index_default;
 
 	/* "hard" reasons not to use bitmaps; these just won't work at all */
-	if (!use_internal_rev_list || (!pack_to_stdout && write_bitmap_index) || is_repository_shallow())
+	if (!use_internal_rev_list || (!pack_to_stdout && write_bitmap_index) || is_repository_shallow(the_repository))
 		use_bitmap_index = 0;
 
 	if (pack_to_stdout || !rev_list_all)
diff --git a/builtin/prune.c b/builtin/prune.c
index 06e6de45b5..9a5f231b3a 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -153,7 +153,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	remove_temporary_files(s);
 	free(s);
 
-	if (is_repository_shallow())
+	if (is_repository_shallow(the_repository))
 		prune_shallow(show_only);
 
 	return 0;
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index b5515df1ae..5911714441 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -879,7 +879,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--is-shallow-repository")) {
-				printf("%s\n", is_repository_shallow() ? "true"
+				printf("%s\n",
+						is_repository_shallow(the_repository) ? "true"
 						: "false");
 				continue;
 			}
diff --git a/commit.c b/commit.c
index 32eda5f7c9..63dac3e601 100644
--- a/commit.c
+++ b/commit.c
@@ -208,7 +208,7 @@ static void prepare_commit_graft_the_repository(void)
 	graft_file = get_graft_file(the_repository);
 	read_graft_file(the_repository, graft_file);
 	/* make sure shallows are read */
-	is_repository_shallow();
+	is_repository_shallow(the_repository);
 	commit_graft_prepared = 1;
 }
 
diff --git a/commit.h b/commit.h
index 0c854d3679..06795f0684 100644
--- a/commit.h
+++ b/commit.h
@@ -201,6 +201,8 @@ extern int register_shallow_the_repository(const struct object_id *oid);
 extern int unregister_shallow(const struct object_id *oid);
 extern int for_each_commit_graft(each_commit_graft_fn, void *);
 extern int is_repository_shallow(void);
+#define is_repository_shallow(r) is_repository_shallow_##r()
+extern int is_repository_shallow_the_repository(void);
 extern struct commit_list *get_shallow_commits(struct object_array *heads,
 		int depth, int shallow_flag, int not_shallow_flag);
 extern struct commit_list *get_shallow_commits_by_rev_list(
diff --git a/contrib/coccinelle/object_store.cocci b/contrib/coccinelle/object_store.cocci
index b56ebef884..b22c57ed43 100644
--- a/contrib/coccinelle/object_store.cocci
+++ b/contrib/coccinelle/object_store.cocci
@@ -67,3 +67,8 @@ expression F;
  unuse_commit_buffer(
 +the_repository,
  E, F)
+
+@@ @@
+ is_repository_shallow(
++the_repository
+ )
diff --git a/fetch-pack.c b/fetch-pack.c
index 1cd738fd62..01e5b36661 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -397,7 +397,7 @@ static int find_common(struct fetch_pack_args *args,
 		return 1;
 	}
 
-	if (is_repository_shallow())
+	if (is_repository_shallow(the_repository))
 		write_shallow_commits(&req_buf, 1, NULL);
 	if (args->depth > 0)
 		packet_buf_write(&req_buf, "deepen %d", args->depth);
@@ -927,7 +927,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	sort_ref_list(&ref, ref_compare_name);
 	QSORT(sought, nr_sought, cmp_ref_by_name);
 
-	if ((args->depth > 0 || is_repository_shallow()) && !server_supports("shallow"))
+	if ((args->depth > 0 || is_repository_shallow(the_repository)) && !server_supports("shallow"))
 		die(_("Server does not support shallow clients"));
 	if (args->depth > 0 || args->deepen_since || args->deepen_not)
 		args->deepen = 1;
diff --git a/send-pack.c b/send-pack.c
index c2856dcfd5..b6080b9c35 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -76,7 +76,7 @@ static int pack_objects(int fd, struct ref *refs, struct oid_array *extra, struc
 		argv_array_push(&po.args, "-q");
 	if (args->progress)
 		argv_array_push(&po.args, "--progress");
-	if (is_repository_shallow())
+	if (is_repository_shallow(the_repository))
 		argv_array_push(&po.args, "--shallow");
 	po.in = -1;
 	po.out = args->stateless_rpc ? -1 : fd;
@@ -219,7 +219,7 @@ static int advertise_shallow_grafts_cb(const struct commit_graft *graft, void *c
 
 static void advertise_shallow_grafts_buf(struct strbuf *sb)
 {
-	if (!is_repository_shallow())
+	if (!is_repository_shallow(the_repository))
 		return;
 	for_each_commit_graft(advertise_shallow_grafts_cb, sb);
 }
@@ -536,7 +536,7 @@ int send_pack(struct send_pack_args *args,
 	}
 
 	if (args->stateless_rpc) {
-		if (!args->dry_run && (cmds_sent || is_repository_shallow())) {
+		if (!args->dry_run && (cmds_sent || is_repository_shallow(the_repository))) {
 			packet_buf_flush(&req_buf);
 			send_sideband(out, -1, req_buf.buf, req_buf.len, LARGE_PACKET_MAX);
 		}
diff --git a/shallow.c b/shallow.c
index 2a7685fa7c..18c6f063c1 100644
--- a/shallow.c
+++ b/shallow.c
@@ -42,7 +42,7 @@ int register_shallow_the_repository(const struct object_id *oid)
 	return register_commit_graft(the_repository, graft, 0);
 }
 
-int is_repository_shallow(void)
+int is_repository_shallow_the_repository(void)
 {
 	FILE *fp;
 	char buf[1024];
@@ -110,7 +110,7 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 		parse_commit_or_die(commit);
 		cur_depth++;
 		if ((depth != INFINITE_DEPTH && cur_depth >= depth) ||
-		    (is_repository_shallow() && !commit->parents &&
+		    (is_repository_shallow(the_repository) && !commit->parents &&
 		     (graft = lookup_commit_graft(the_repository, &commit->object.oid)) != NULL &&
 		     graft->nr_parent < 0)) {
 			commit_list_insert(commit, &result);
@@ -169,7 +169,7 @@ struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
 	 */
 	clear_object_flags(both_flags);
 
-	is_repository_shallow(); /* make sure shallows are read */
+	is_repository_shallow(the_repository); /* make sure shallows are read */
 
 	init_revisions(&revs, NULL);
 	save_commit_buffer = 0;
@@ -347,7 +347,7 @@ static int advertise_shallow_grafts_cb(const struct commit_graft *graft, void *c
 
 void advertise_shallow_grafts(int fd)
 {
-	if (!is_repository_shallow())
+	if (!is_repository_shallow(the_repository))
 		return;
 	for_each_commit_graft(advertise_shallow_grafts_cb, &fd);
 }
diff --git a/upload-pack.c b/upload-pack.c
index ed2d394ace..5bf761518f 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -690,7 +690,7 @@ static void send_unshallow(const struct object_array *shallows)
 static void deepen(int depth, int deepen_relative,
 		   struct object_array *shallows)
 {
-	if (depth == INFINITE_DEPTH && !is_repository_shallow()) {
+	if (depth == INFINITE_DEPTH && !is_repository_shallow(the_repository)) {
 		int i;
 
 		for (i = 0; i < shallows->nr; i++) {
-- 
2.15.1.433.g936d1b9894.dirty

