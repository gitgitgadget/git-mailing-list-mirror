Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 864EA1F406
	for <e@80x24.org>; Tue, 15 May 2018 23:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbeEOXnO (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 19:43:14 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:39598 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752002AbeEOXnC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 19:43:02 -0400
Received: by mail-pl0-f43.google.com with SMTP id c19-v6so962166pls.6
        for <git@vger.kernel.org>; Tue, 15 May 2018 16:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8l7CKJk5Wm26bL4mMNB3mN1+OQdY9lkIFAlhSV9p4u4=;
        b=uuTPIsRFILyuv6ULIqjVnxaBNrVy6Dgc09r8Uw79mbQ4ozsqDUtTvxumiA8XxajT2P
         BecwyrPTgC9sGhvNMHfsscJMQTYK00sZzYl2ZSFTIU0NZRxTzaRWbLKSuFfnPGH2tBju
         c5y+TdMTYBVvxaDyHV3/lbOKBGJnTo8xAi3eehT4DTULhV0PlMmqfSgSagdbs5a9w3wk
         jxauc0BW7M48SI97F/Mmjmu8w7HQ4jwffuiMsgl8YbojJ6xH3n4wr5FbKMIqhF5MLGZ3
         vP/iwB50XAfVrFKx7l8utYKMEHd2u+ujM+060uW7Kimst+0QpApb7VHLBG6vvJxdgHz7
         16aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8l7CKJk5Wm26bL4mMNB3mN1+OQdY9lkIFAlhSV9p4u4=;
        b=P9L7Jgn4DM4IHuJl4vQ888JfRZini9WWzNiIOjIyFgVvYHveCKQEImorD45GDzYT7d
         41cEPgo3vmVXz0danK1s4Duf3Qx+VXk7l6u4mU2ISdw55Er/KfDliamRt7a2QnnDK09X
         EmJI6RcSOmS8qwxx2Tuo+YX4cGHQF4V9RiGQ69WAP/nOw1J7iptJNSQOPJbjwNiJyHpQ
         Jlzmsdllm125OadxIxGAcbjkgKLbRG02533P8r6hmjQf4SdhV11BUpETqcJylAz0fX2k
         hbCTw6oz9yjjBucI55CX2znwYZHqeFTv2cwsyibn6n9GM4cSFTEyt8It3leI7AlF9Vlh
         Bc1w==
X-Gm-Message-State: ALKqPwfUdQ8umevX2VbpBc974Z8pjNDrqClDauNzUaQPLc4czul5BUrl
        6m5rlzdxvjZdqOaBCs0rdTOzJYUV5kU=
X-Google-Smtp-Source: AB8JxZoAQ2tRQtciCmkCcY8zBB2+0U9UTnGe9MNLbXzXIMvFFRvRtvBn4YvvkxdhbjlGpO272dfDvw==
X-Received: by 2002:a17:902:5610:: with SMTP id h16-v6mr2942383pli.140.1526427780941;
        Tue, 15 May 2018 16:43:00 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id z131-v6sm993213pgz.86.2018.05.15.16.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 16:42:59 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 17/19] shallow: migrate shallow information into the object parser
Date:   Tue, 15 May 2018 16:42:31 -0700
Message-Id: <20180515234233.143708-18-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180515234233.143708-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.h  |  9 +++------
 object.c  |  3 +++
 object.h  |  4 ++++
 shallow.c | 50 ++++++++++++++++++++++++--------------------------
 4 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/commit.h b/commit.h
index d04bbed81cf..45114a95b25 100644
--- a/commit.h
+++ b/commit.h
@@ -190,18 +190,15 @@ extern struct commit_list *get_merge_bases_many_dirty(struct commit *one, int n,
 
 struct oid_array;
 struct ref;
-#define register_shallow(r, o) register_shallow_##r(o);
-extern int register_shallow_the_repository(const struct object_id *oid);
+extern int register_shallow(struct repository *r, const struct object_id *oid);
 extern int unregister_shallow(const struct object_id *oid);
 extern int for_each_commit_graft(each_commit_graft_fn, void *);
-#define is_repository_shallow(r) is_repository_shallow_##r()
-extern int is_repository_shallow_the_repository(void);
+extern int is_repository_shallow(struct repository *r);
 extern struct commit_list *get_shallow_commits(struct object_array *heads,
 		int depth, int shallow_flag, int not_shallow_flag);
 extern struct commit_list *get_shallow_commits_by_rev_list(
 		int ac, const char **av, int shallow_flag, int not_shallow_flag);
-#define set_alternate_shallow_file(r, p, o) set_alternate_shallow_file_##r(p, o)
-extern void set_alternate_shallow_file_the_repository(const char *path, int override);
+extern void set_alternate_shallow_file(struct repository *r, const char *path, int override);
 extern int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
 				 const struct oid_array *extra);
 extern void setup_alternate_shallow(struct lock_file *shallow_lock,
diff --git a/object.c b/object.c
index 0116ed6529a..30b8a721cf6 100644
--- a/object.c
+++ b/object.c
@@ -464,6 +464,9 @@ struct parsed_object_pool *parsed_object_pool_new(void)
 	o->tag_state = allocate_alloc_state();
 	o->object_state = allocate_alloc_state();
 
+	o->is_shallow = -1;
+	o->shallow_stat = xcalloc(1, sizeof(*o->shallow_stat));
+
 	return o;
 }
 
diff --git a/object.h b/object.h
index ec908f9bcc1..a314331acaf 100644
--- a/object.h
+++ b/object.h
@@ -16,6 +16,10 @@ struct parsed_object_pool {
 	/* parent substitutions from .git/info/grafts and .git/shallow */
 	struct commit_graft **grafts;
 	int grafts_alloc, grafts_nr;
+
+	int is_shallow;
+	struct stat_validity *shallow_stat;
+	char *alternate_shallow_file;
 };
 
 struct parsed_object_pool *parsed_object_pool_new(void);
diff --git a/shallow.c b/shallow.c
index a0e338459f9..560329d53a8 100644
--- a/shallow.c
+++ b/shallow.c
@@ -14,22 +14,21 @@
 #include "commit-slab.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "repository.h"
 
-static int is_shallow = -1;
-static struct stat_validity shallow_stat;
-static char *alternate_shallow_file;
+struct stat_validity the_repository_shallow_stat;
 
-void set_alternate_shallow_file_the_repository(const char *path, int override)
+void set_alternate_shallow_file(struct repository *r, const char *path, int override)
 {
-	if (is_shallow != -1)
+	if (r->parsed_objects->is_shallow != -1)
 		die("BUG: is_repository_shallow must not be called before set_alternate_shallow_file");
-	if (alternate_shallow_file && !override)
+	if (r->parsed_objects->alternate_shallow_file && !override)
 		return;
-	free(alternate_shallow_file);
-	alternate_shallow_file = xstrdup_or_null(path);
+	free(r->parsed_objects->alternate_shallow_file);
+	r->parsed_objects->alternate_shallow_file = xstrdup_or_null(path);
 }
 
-int register_shallow_the_repository(const struct object_id *oid)
+int register_shallow(struct repository *r, const struct object_id *oid)
 {
 	struct commit_graft *graft =
 		xmalloc(sizeof(struct commit_graft));
@@ -39,41 +38,41 @@ int register_shallow_the_repository(const struct object_id *oid)
 	graft->nr_parent = -1;
 	if (commit && commit->object.parsed)
 		commit->parents = NULL;
-	return register_commit_graft(the_repository, graft, 0);
+	return register_commit_graft(r, graft, 0);
 }
 
-int is_repository_shallow_the_repository(void)
+int is_repository_shallow(struct repository *r)
 {
 	FILE *fp;
 	char buf[1024];
-	const char *path = alternate_shallow_file;
+	const char *path = r->parsed_objects->alternate_shallow_file;
 
-	if (is_shallow >= 0)
-		return is_shallow;
+	if (r->parsed_objects->is_shallow >= 0)
+		return r->parsed_objects->is_shallow;
 
 	if (!path)
-		path = git_path_shallow(the_repository);
+		path = git_path_shallow(r);
 	/*
 	 * fetch-pack sets '--shallow-file ""' as an indicator that no
 	 * shallow file should be used. We could just open it and it
 	 * will likely fail. But let's do an explicit check instead.
 	 */
 	if (!*path || (fp = fopen(path, "r")) == NULL) {
-		stat_validity_clear(&shallow_stat);
-		is_shallow = 0;
-		return is_shallow;
+		stat_validity_clear(r->parsed_objects->shallow_stat);
+		r->parsed_objects->is_shallow = 0;
+		return r->parsed_objects->is_shallow;
 	}
-	stat_validity_update(&shallow_stat, fileno(fp));
-	is_shallow = 1;
+	stat_validity_update(r->parsed_objects->shallow_stat, fileno(fp));
+	r->parsed_objects->is_shallow = 1;
 
 	while (fgets(buf, sizeof(buf), fp)) {
 		struct object_id oid;
 		if (get_oid_hex(buf, &oid))
 			die("bad shallow line: %s", buf);
-		register_shallow(the_repository, &oid);
+		register_shallow(r, &oid);
 	}
 	fclose(fp);
-	return is_shallow;
+	return r->parsed_objects->is_shallow;
 }
 
 struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
@@ -217,13 +216,12 @@ struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
 	return result;
 }
 
-#define check_shallow_file_for_update(r) check_shallow_file_for_update_##r()
-static void check_shallow_file_for_update_the_repository(void)
+static void check_shallow_file_for_update(struct repository *r)
 {
-	if (is_shallow == -1)
+	if (r->parsed_objects->is_shallow == -1)
 		die("BUG: shallow must be initialized by now");
 
-	if (!stat_validity_check(&shallow_stat, git_path_shallow(the_repository)))
+	if (!stat_validity_check(r->parsed_objects->shallow_stat, git_path_shallow(the_repository)))
 		die("shallow file has changed since we read it");
 }
 
-- 
2.17.0.582.gccdcbd54c44.dirty

