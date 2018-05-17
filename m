Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 371011F51C
	for <e@80x24.org>; Thu, 17 May 2018 22:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752141AbeEQWww (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 18:52:52 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43794 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbeEQWw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 18:52:26 -0400
Received: by mail-pl0-f66.google.com with SMTP id c41-v6so3386228plj.10
        for <git@vger.kernel.org>; Thu, 17 May 2018 15:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FOJqu7oCjndTclKjoziRuQcKCCJkSKm2MiCOe83LcGo=;
        b=oL0j4mvK1+6VHJ6GYtRjN3DkXbGkHDTNI+qnBS5L7pIs7WtSBVMxKo/szNDakNCo9O
         9Jfsh18V4m0zG1A64ShdqVNjnWF843YA1mCEq/t9QGOxOVzFbWuxFRHJQxqjvTA+80yk
         R5wT+W6MEYFHPiYxN0NIPmXVyEPWlDrWQem2LzX+IEBf6JjxA5PoxctvLebmJU1lmqUx
         V6tI84290XI5SNcNmoPlZwMo3VeuxuwIFXXgYjExBva3achNkGAmkgLpXubH+Se41sYL
         m5vpmuHaGOWUtf9g49jrYNz1++eFJs+n4skdAuMu85571ZESfChZQgYPtBTrHk6j9bGP
         Y5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FOJqu7oCjndTclKjoziRuQcKCCJkSKm2MiCOe83LcGo=;
        b=YB+uIOdpCJon4a55EuanAA0VBWBvMEExSPWInH319+eti7tY0QoWs6K0AERpFzmXmI
         bs9yyvfKK//o+MVF9zv72IiHQScmf6ojxVu0DGuiiBf/wA6TtfZ5UsuIY/Bj8pMEroZK
         BPht3rn10iAJ2hUD/Z8h3b1M7Q2y0gyIuxMBGvYj5SlVKifRPddayDtXZ34dx/mAU/7l
         TivMzzwGCXrHQgM8QmEs5t0S7Ej8FtNnPlenJnnVcfiRTxkWMLJE5Mg0fPVTWbafBBjz
         MFGP9xe5SEYLZExWHPgvRlQxpLIGhdfoGlSVqSs+8zjSoZuYVQURguMcO9fugvnInx4n
         nnjw==
X-Gm-Message-State: ALKqPwfhItq9B5NzORrn28LZvtVMkJOtwVx1+a4rZK8AVHHAjZBY6lUT
        5SCZY+0JPOEMbsHlGd5P/nGkeQ==
X-Google-Smtp-Source: AB8JxZq78lf64tq1Smh/Vqiv0p0sbELtT2wuRnWP0ai9M+4mLHidAQA/tNDS1jJGGtXmh3xoAWtMFw==
X-Received: by 2002:a17:902:5952:: with SMTP id e18-v6mr7006263plj.351.1526597545124;
        Thu, 17 May 2018 15:52:25 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id x71-v6sm16501998pfe.47.2018.05.17.15.52.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 15:52:24 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Subject: [PATCH 11/19] shallow: add repository argument to is_repository_shallow
Date:   Thu, 17 May 2018 15:51:46 -0700
Message-Id: <20180517225154.9200-12-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180517225154.9200-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
 <20180517225154.9200-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow callers of is_repository_shallow
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fetch.c        | 2 +-
 builtin/pack-objects.c | 4 ++--
 builtin/prune.c        | 2 +-
 builtin/rev-parse.c    | 3 ++-
 commit.c               | 2 +-
 commit.h               | 3 ++-
 fetch-pack.c           | 4 ++--
 send-pack.c            | 6 +++---
 shallow.c              | 8 ++++----
 upload-pack.c          | 2 +-
 10 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index c1f2df97965..55140671ef3 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1445,7 +1445,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (unshallow) {
 		if (depth)
 			die(_("--depth and --unshallow cannot be used together"));
-		else if (!is_repository_shallow())
+		else if (!is_repository_shallow(the_repository))
 			die(_("--unshallow on a complete repository does not make sense"));
 		else
 			depth = xstrfmt("%d", INFINITE_DEPTH);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 97a5963efb6..0f1eec2eecd 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2857,7 +2857,7 @@ static void get_object_list(int ac, const char **av)
 	setup_revisions(ac, av, &revs, NULL);
 
 	/* make sure shallows are read */
-	is_repository_shallow();
+	is_repository_shallow(the_repository);
 
 	while (fgets(line, sizeof(line), stdin) != NULL) {
 		int len = strlen(line);
@@ -3142,7 +3142,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		use_bitmap_index = use_bitmap_index_default;
 
 	/* "hard" reasons not to use bitmaps; these just won't work at all */
-	if (!use_internal_rev_list || (!pack_to_stdout && write_bitmap_index) || is_repository_shallow())
+	if (!use_internal_rev_list || (!pack_to_stdout && write_bitmap_index) || is_repository_shallow(the_repository))
 		use_bitmap_index = 0;
 
 	if (pack_to_stdout || !rev_list_all)
diff --git a/builtin/prune.c b/builtin/prune.c
index 8cc8659612f..70ec35aa058 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -160,7 +160,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	remove_temporary_files(s);
 	free(s);
 
-	if (is_repository_shallow())
+	if (is_repository_shallow(the_repository))
 		prune_shallow(show_only);
 
 	return 0;
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 36b20877828..a8a9b506ff6 100644
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
index c832133f055..684eeaa2ccd 100644
--- a/commit.c
+++ b/commit.c
@@ -208,7 +208,7 @@ static void prepare_commit_graft_the_repository(void)
 	graft_file = get_graft_file();
 	read_graft_file(the_repository, graft_file);
 	/* make sure shallows are read */
-	is_repository_shallow();
+	is_repository_shallow(the_repository);
 	commit_graft_prepared = 1;
 }
 
diff --git a/commit.h b/commit.h
index 59346de5512..c7f25d6490a 100644
--- a/commit.h
+++ b/commit.h
@@ -195,7 +195,8 @@ struct ref;
 extern int register_shallow_the_repository(const struct object_id *oid);
 extern int unregister_shallow(const struct object_id *oid);
 extern int for_each_commit_graft(each_commit_graft_fn, void *);
-extern int is_repository_shallow(void);
+#define is_repository_shallow(r) is_repository_shallow_##r()
+extern int is_repository_shallow_the_repository(void);
 extern struct commit_list *get_shallow_commits(struct object_array *heads,
 		int depth, int shallow_flag, int not_shallow_flag);
 extern struct commit_list *get_shallow_commits_by_rev_list(
diff --git a/fetch-pack.c b/fetch-pack.c
index e3e99e44962..90befd370fe 100644
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
@@ -986,7 +986,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	sort_ref_list(&ref, ref_compare_name);
 	QSORT(sought, nr_sought, cmp_ref_by_name);
 
-	if ((args->depth > 0 || is_repository_shallow()) && !server_supports("shallow"))
+	if ((args->depth > 0 || is_repository_shallow(the_repository)) && !server_supports("shallow"))
 		die(_("Server does not support shallow clients"));
 	if (args->depth > 0 || args->deepen_since || args->deepen_not)
 		args->deepen = 1;
diff --git a/send-pack.c b/send-pack.c
index 71600028cdd..e920ca57df4 100644
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
@@ -221,7 +221,7 @@ static int advertise_shallow_grafts_cb(const struct commit_graft *graft, void *c
 
 static void advertise_shallow_grafts_buf(struct strbuf *sb)
 {
-	if (!is_repository_shallow())
+	if (!is_repository_shallow(the_repository))
 		return;
 	for_each_commit_graft(advertise_shallow_grafts_cb, sb);
 }
@@ -538,7 +538,7 @@ int send_pack(struct send_pack_args *args,
 	}
 
 	if (args->stateless_rpc) {
-		if (!args->dry_run && (cmds_sent || is_repository_shallow())) {
+		if (!args->dry_run && (cmds_sent || is_repository_shallow(the_repository))) {
 			packet_buf_flush(&req_buf);
 			send_sideband(out, -1, req_buf.buf, req_buf.len, LARGE_PACKET_MAX);
 		}
diff --git a/shallow.c b/shallow.c
index 0028e4ea776..e903651202b 100644
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
@@ -108,7 +108,7 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 		parse_commit_or_die(commit);
 		cur_depth++;
 		if ((depth != INFINITE_DEPTH && cur_depth >= depth) ||
-		    (is_repository_shallow() && !commit->parents &&
+		    (is_repository_shallow(the_repository) && !commit->parents &&
 		     (graft = lookup_commit_graft(the_repository, &commit->object.oid)) != NULL &&
 		     graft->nr_parent < 0)) {
 			commit_list_insert(commit, &result);
@@ -167,7 +167,7 @@ struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
 	 */
 	clear_object_flags(both_flags);
 
-	is_repository_shallow(); /* make sure shallows are read */
+	is_repository_shallow(the_repository); /* make sure shallows are read */
 
 	init_revisions(&revs, NULL);
 	save_commit_buffer = 0;
@@ -345,7 +345,7 @@ static int advertise_shallow_grafts_cb(const struct commit_graft *graft, void *c
 
 void advertise_shallow_grafts(int fd)
 {
-	if (!is_repository_shallow())
+	if (!is_repository_shallow(the_repository))
 		return;
 	for_each_commit_graft(advertise_shallow_grafts_cb, &fd);
 }
diff --git a/upload-pack.c b/upload-pack.c
index 4e4ac0f0d95..51b9038111e 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -707,7 +707,7 @@ static void send_unshallow(const struct object_array *shallows)
 static void deepen(int depth, int deepen_relative,
 		   struct object_array *shallows)
 {
-	if (depth == INFINITE_DEPTH && !is_repository_shallow()) {
+	if (depth == INFINITE_DEPTH && !is_repository_shallow(the_repository)) {
 		int i;
 
 		for (i = 0; i < shallows->nr; i++) {
-- 
2.17.0.582.gccdcbd54c44.dirty

