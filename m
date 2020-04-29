Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3188C83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 22:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D4B208E0
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 22:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="mANlSWf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgD2Wji (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 18:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726164AbgD2Wji (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 18:39:38 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE5DC03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 15:39:37 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x77so1836328pfc.0
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 15:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WqJi3XiGTmdEV4DQZK3YFDBkKYU4DufX8SKsAF47NQU=;
        b=mANlSWf0HPVW38xL0CQBiWooX8/q2vDBfs7X9fTbM456AbmGZBaI02yep8WwsugUnw
         R3i+hL6KyFwZrI4UBqBEnrRY2Pxy+483NFANn3827Fkz15ikRR9MuZJirfxiiOmmXfq8
         wFZVl6Vjibht4De/xyTgsP9Xgr4O9t3Jn2tC4p8KC1MvRGCNxlORLR+PGTJGDb8JxW1S
         d0ycSZ46Y9Pi2hyU4BLT7LPbaowMB5JFgzYVvU5nIasQOKUKVJq0L6HD/0jjPp6yST8U
         ewgDK2RoI2o+Zw44s+HK8rWy8GQqaC+lxylGXkU4XU616409AbKWwhZ8PnCps6TKc2bD
         eQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WqJi3XiGTmdEV4DQZK3YFDBkKYU4DufX8SKsAF47NQU=;
        b=bjtao77egObraXLinvcEqYfrn6hu4AA6CTiwadeNez4EF8SanhHjbUxG5WHoAVI/CL
         oLEF1PUwxHbzLpKGf045Lu/qKQPvxAscwBoGAaBTWIet8EIZApoDXUIaOkvh2frM7vB5
         tvsRNeKSs9BtwI+InV140uIR7PrX3wLdKybZOFX5rHDPbYjETCSjXlCrJ3BuxqtKqF4W
         3VxOHcOk4uwdaeg80eohJQasYc4nUfe6aQySpbcZ5Hqh9ieAAZeja/wLEH/CAv4RgIhH
         O/tOcrjGaoRrQni6S9Zpza0AU7lLZSYaHKnLKkrWzd5VYxtncmNyuNw7q8jFGjCoQkm0
         p5xw==
X-Gm-Message-State: AGi0PuanVP1rduFWizPABLZRUEaExMhTq+QO31POjTytcJ+5cdvG8RUe
        ja79i8fnBP/RBUVCIGzEtwwwdqI9Sv5aZSnJ
X-Google-Smtp-Source: APiQypKJFTtayesRBbpTUt52FF4yUYLdNLnBLTJP8WHdfM5+3VtOGd3HnLGZzUfUbwoPWz9KwcpjUg==
X-Received: by 2002:a62:17c3:: with SMTP id 186mr366909pfx.159.1588199976198;
        Wed, 29 Apr 2020 15:39:36 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id a136sm1875390pfa.99.2020.04.29.15.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 15:39:35 -0700 (PDT)
Date:   Wed, 29 Apr 2020 16:39:34 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com, jrnieder@gmail.com
Subject: [PATCH 2/5] shallow: extract a header file for shallow-related
 functions
Message-ID: <0b93abe072aa35ab96ba3b97118caa8ffe8e439d.1588199705.git.me@ttaylorr.com>
References: <cover.1588199705.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588199705.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are many functions in commit.h that are more related to shallow
repositories than they are to any sort of generic commit machinery.
Likely this began when there were only a few shallow-related functions,
and commit.h seemed a reasonable enough place to put them.

But, now there are a good number of shallow-related functions, and
placing them all in 'commit.h' doesn't make sense.

This patch extracts a 'shallow.h', which takes all of the headers from
'commit.h' for functions which already exist in 'shallow.c'. We will
bring the remaining shallow-related functions defined in 'commit.c' in a
subsequent patch.

For now, move only the ones that already are implemented in 'shallow.c',
and update the necessary includes.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin.h     |  1 +
 commit.c      |  1 +
 commit.h      | 48 ---------------------------------------
 fetch-pack.c  |  1 +
 send-pack.c   |  1 +
 shallow.c     |  1 +
 shallow.h     | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++
 upload-pack.c |  1 +
 8 files changed, 69 insertions(+), 48 deletions(-)
 create mode 100644 shallow.h

diff --git a/builtin.h b/builtin.h
index 2b25a80cde..2e701a023c 100644
--- a/builtin.h
+++ b/builtin.h
@@ -5,6 +5,7 @@
 #include "strbuf.h"
 #include "cache.h"
 #include "commit.h"
+#include "shallow.h"
 
 /*
  * builtin API
diff --git a/commit.c b/commit.c
index b76f7d72be..eebfbeb45d 100644
--- a/commit.c
+++ b/commit.c
@@ -20,6 +20,7 @@
 #include "refs.h"
 #include "commit-reach.h"
 #include "run-command.h"
+#include "shallow.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
diff --git a/commit.h b/commit.h
index eb42e8b6d2..5cd984939b 100644
--- a/commit.h
+++ b/commit.h
@@ -248,55 +248,7 @@ struct commit *get_fork_point(const char *refname, struct commit *commit);
 
 struct oid_array;
 struct ref;
-int register_shallow(struct repository *r, const struct object_id *oid);
-int unregister_shallow(const struct object_id *oid);
-int commit_shallow_file(struct repository *r, struct lock_file *lk);
-void rollback_shallow_file(struct repository *r, struct lock_file *lk);
 int for_each_commit_graft(each_commit_graft_fn, void *);
-int is_repository_shallow(struct repository *r);
-struct commit_list *get_shallow_commits(struct object_array *heads,
-					int depth, int shallow_flag, int not_shallow_flag);
-struct commit_list *get_shallow_commits_by_rev_list(
-		int ac, const char **av, int shallow_flag, int not_shallow_flag);
-void set_alternate_shallow_file(struct repository *r, const char *path, int override);
-int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
-			  const struct oid_array *extra);
-void setup_alternate_shallow(struct lock_file *shallow_lock,
-			     const char **alternate_shallow_file,
-			     const struct oid_array *extra);
-const char *setup_temporary_shallow(const struct oid_array *extra);
-void advertise_shallow_grafts(int);
-
-/*
- * Initialize with prepare_shallow_info() or zero-initialize (equivalent to
- * prepare_shallow_info with a NULL oid_array).
- */
-struct shallow_info {
-	struct oid_array *shallow;
-	int *ours, nr_ours;
-	int *theirs, nr_theirs;
-	struct oid_array *ref;
-
-	/* for receive-pack */
-	uint32_t **used_shallow;
-	int *need_reachability_test;
-	int *reachable;
-	int *shallow_ref;
-	struct commit **commits;
-	int nr_commits;
-};
-
-void prepare_shallow_info(struct shallow_info *, struct oid_array *);
-void clear_shallow_info(struct shallow_info *);
-void remove_nonexistent_theirs_shallow(struct shallow_info *);
-void assign_shallow_commits_to_refs(struct shallow_info *info,
-				    uint32_t **used,
-				    int *ref_status);
-int delayed_reachability_test(struct shallow_info *si, int c);
-#define PRUNE_SHOW_ONLY 1
-#define PRUNE_QUICK 2
-void prune_shallow(unsigned options);
-extern struct trace_key trace_shallow;
 
 int interactive_add(int argc, const char **argv, const char *prefix, int patch);
 int run_add_interactive(const char *revision, const char *patch_mode,
diff --git a/fetch-pack.c b/fetch-pack.c
index a618f3b029..401d028e41 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -22,6 +22,7 @@
 #include "connected.h"
 #include "fetch-negotiator.h"
 #include "fsck.h"
+#include "shallow.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
diff --git a/send-pack.c b/send-pack.c
index 0407841ae8..e0ccfef75a 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -15,6 +15,7 @@
 #include "sha1-array.h"
 #include "gpg-interface.h"
 #include "cache.h"
+#include "shallow.h"
 
 int option_parse_push_signed(const struct option *opt,
 			     const char *arg, int unset)
diff --git a/shallow.c b/shallow.c
index 5010a6c732..d0191c7609 100644
--- a/shallow.c
+++ b/shallow.c
@@ -14,6 +14,7 @@
 #include "commit-slab.h"
 #include "list-objects.h"
 #include "commit-reach.h"
+#include "shallow.h"
 
 void set_alternate_shallow_file(struct repository *r, const char *path, int override)
 {
diff --git a/shallow.h b/shallow.h
new file mode 100644
index 0000000000..14dd748625
--- /dev/null
+++ b/shallow.h
@@ -0,0 +1,63 @@
+#ifndef SHALLOW_H
+#define SHALLOW_H
+
+#include "lockfile.h"
+#include "object.h"
+#include "repository.h"
+#include "strbuf.h"
+
+void set_alternate_shallow_file(struct repository *r, const char *path, int override);
+int register_shallow(struct repository *r, const struct object_id *oid);
+int is_repository_shallow(struct repository *r);
+int commit_shallow_file(struct repository *r, struct lock_file *lk);
+void rollback_shallow_file(struct repository *r, struct lock_file *lk);
+
+struct commit_list *get_shallow_commits(struct object_array *heads,
+					int depth, int shallow_flag, int not_shallow_flag);
+struct commit_list *get_shallow_commits_by_rev_list(
+		int ac, const char **av, int shallow_flag, int not_shallow_flag);
+int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
+			  const struct oid_array *extra);
+
+void setup_alternate_shallow(struct lock_file *shallow_lock,
+			     const char **alternate_shallow_file,
+			     const struct oid_array *extra);
+
+const char *setup_temporary_shallow(const struct oid_array *extra);
+
+void advertise_shallow_grafts(int);
+
+#define PRUNE_SHOW_ONLY 1
+#define PRUNE_QUICK 2
+void prune_shallow(unsigned options);
+
+/*
+ * Initialize with prepare_shallow_info() or zero-initialize (equivalent to
+ * prepare_shallow_info with a NULL oid_array).
+ */
+struct shallow_info {
+	struct oid_array *shallow;
+	int *ours, nr_ours;
+	int *theirs, nr_theirs;
+	struct oid_array *ref;
+
+	/* for receive-pack */
+	uint32_t **used_shallow;
+	int *need_reachability_test;
+	int *reachable;
+	int *shallow_ref;
+	struct commit **commits;
+	int nr_commits;
+};
+
+void prepare_shallow_info(struct shallow_info *, struct oid_array *);
+void clear_shallow_info(struct shallow_info *);
+void remove_nonexistent_theirs_shallow(struct shallow_info *);
+void assign_shallow_commits_to_refs(struct shallow_info *info,
+				    uint32_t **used,
+				    int *ref_status);
+int delayed_reachability_test(struct shallow_info *si, int c);
+
+extern struct trace_key trace_shallow;
+
+#endif /* SHALLOW_H */
diff --git a/upload-pack.c b/upload-pack.c
index c53249cac1..e71b068291 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -26,6 +26,7 @@
 #include "serve.h"
 #include "commit-graph.h"
 #include "commit-reach.h"
+#include "shallow.h"
 
 /* Remember to update object flag allocation in object.h */
 #define THEY_HAVE	(1u << 11)
-- 
2.26.0.113.ge9739cdccc

