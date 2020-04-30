Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B39C47247
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 19:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A573207DD
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 19:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Ye5L98xC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgD3Tsy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgD3Tsx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 15:48:53 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55B9C035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 12:48:53 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f8so2697427plt.2
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 12:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=StdJs8SBwTdSKDUsq0n3LDE3QUv2BNI7rFfvsP73dWU=;
        b=Ye5L98xC+PXu+eF0zU6ojBfapjdQIjxSJNbOoMxXRL407M+2U/YHhLnThoQDuHSli6
         dSax0KjB7kuxrH6ZkS2Tjs8EWVoNfIJggEP4Oj5CjmHr5w7oUA98IxpQONb+cDv0HdME
         FAl8Lg9NAuL4bZ2JkzMM8RCpljs9fj4sS+q4T2XOOuYfjDO80hRteviH5jb4bA3woRlS
         0ba+Pv/0byguL/ZxQUCbIy44wZ7+jFcFYQmrbxYAawr+ox2DZIDjG0oX0qm17Eifv8+3
         wIEIe3FOcnj1MKZBZeT56UsHTU4VVcZmnG5WTF1kZ3/9cyau0Uio6VPBH+ADrCV/orQk
         9mDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=StdJs8SBwTdSKDUsq0n3LDE3QUv2BNI7rFfvsP73dWU=;
        b=Sbb86eUAt8kmKEUruJinU5n/Qi3Y5qMfNG3Jkxy2goTV7OXp83uFK5qS3oFvxu1LOq
         UOyyGcqvKU1oYLFqCPqE2QPtvF0bi7ooZ1TSDxCkfCYmsi2kBzW+9Lb6D99WxL57e9PV
         7VkiBpTMJgIRd8xSOXU04Wq2CNcFW+f3aS4XWYmPxqEWoGf4JPdYiCysdoKE/gidI/L8
         EDFgik0N8cjo9sDrIKQBLWVj/DyDERh/RkSwdV8XqXwrkMHcCws6iJXLIava28AxAx0Q
         UtGCbyG7X7luttmM1VB3mX50PogpGlUNLZNNGMfFSs2wadQm5NW+F472DY7R3wOz4cdz
         uqHw==
X-Gm-Message-State: AGi0PubDBh0nydcIrtkVSbqCkGogYRU9XmgqaWE+KgGauhlz/WKizD9m
        dc7YDQu/hkUNg8mlz9hpR6MHZAfRUwl5Zw==
X-Google-Smtp-Source: APiQypJ8ymckxJI2tCJWvi+llUIPaJi8Goy4D5/zYb/QN12jFYYiAl8slMRB6eyA7FWnEDhSj1htfw==
X-Received: by 2002:a17:902:7207:: with SMTP id ba7mr632482plb.204.1588276132627;
        Thu, 30 Apr 2020 12:48:52 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id b8sm503939pft.11.2020.04.30.12.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 12:48:51 -0700 (PDT)
Date:   Thu, 30 Apr 2020 13:48:50 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com, jrnieder@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v2 2/4] shallow: extract a header file for shallow-related
 functions
Message-ID: <0631e2a87dc83220af27f7be7d7d8cd2bbb117fc.1588275891.git.me@ttaylorr.com>
References: <cover.1588275891.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588275891.git.me@ttaylorr.com>
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

This patch extracts a 'shallow.h', which takes all of the declarations
from 'commit.h' for functions which already exist in 'shallow.c'. We
will bring the remaining shallow-related functions defined in 'commit.c'
in a subsequent patch.

For now, move only the ones that already are implemented in 'shallow.c',
and update the necessary includes.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/fetch.c        |  1 +
 builtin/pack-objects.c |  1 +
 builtin/prune.c        |  1 +
 builtin/receive-pack.c |  1 +
 builtin/repack.c       |  1 +
 builtin/rev-parse.c    |  1 +
 commit-graph.c         |  1 +
 commit.c               | 14 +--------
 commit.h               | 48 -------------------------------
 environment.c          |  1 +
 fetch-pack.c           |  1 +
 git.c                  |  1 +
 send-pack.c            |  1 +
 shallow.c              | 14 +++++++++
 shallow.h              | 64 ++++++++++++++++++++++++++++++++++++++++++
 upload-pack.c          |  1 +
 16 files changed, 91 insertions(+), 61 deletions(-)
 create mode 100644 shallow.h

diff --git a/builtin/fetch.c b/builtin/fetch.c
index bf6bab80fa..a292acd1c0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -27,6 +27,7 @@
 #include "branch.h"
 #include "promisor-remote.h"
 #include "commit-graph.h"
+#include "shallow.h"
 
 #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index dc7c58ce3f..303ae312a9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -34,6 +34,7 @@
 #include "dir.h"
 #include "midx.h"
 #include "trace2.h"
+#include "shallow.h"
 
 #define IN_PACK(obj) oe_in_pack(&to_pack, obj)
 #define SIZE(obj) oe_size(&to_pack, obj)
diff --git a/builtin/prune.c b/builtin/prune.c
index 2b76872ad2..028ff786d6 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -7,6 +7,7 @@
 #include "parse-options.h"
 #include "progress.h"
 #include "object-store.h"
+#include "shallow.h"
 
 static const char * const prune_usage[] = {
 	N_("git prune [-n] [-v] [--progress] [--expire <time>] [--] [<head>...]"),
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 652661fa99..8e3f9bc35f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -28,6 +28,7 @@
 #include "protocol.h"
 #include "commit-reach.h"
 #include "worktree.h"
+#include "shallow.h"
 
 static const char * const receive_pack_usage[] = {
 	N_("git receive-pack <git-dir>"),
diff --git a/builtin/repack.c b/builtin/repack.c
index 0781763b06..2550603608 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -12,6 +12,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "promisor-remote.h"
+#include "shallow.h"
 
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 06056434ed..669dd2fd6f 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -16,6 +16,7 @@
 #include "split-index.h"
 #include "submodule.h"
 #include "commit-reach.h"
+#include "shallow.h"
 
 #define DO_REVS		1
 #define DO_NOREV	2
diff --git a/commit-graph.c b/commit-graph.c
index f013a84e29..d316de5021 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -16,6 +16,7 @@
 #include "hashmap.h"
 #include "replace-object.h"
 #include "progress.h"
+#include "shallow.h"
 
 #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
 #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
diff --git a/commit.c b/commit.c
index b76f7d72be..87686a7055 100644
--- a/commit.c
+++ b/commit.c
@@ -20,6 +20,7 @@
 #include "refs.h"
 #include "commit-reach.h"
 #include "run-command.h"
+#include "shallow.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -245,19 +246,6 @@ int for_each_commit_graft(each_commit_graft_fn fn, void *cb_data)
 	return ret;
 }
 
-int unregister_shallow(const struct object_id *oid)
-{
-	int pos = commit_graft_pos(the_repository, oid->hash);
-	if (pos < 0)
-		return -1;
-	if (pos + 1 < the_repository->parsed_objects->grafts_nr)
-		MOVE_ARRAY(the_repository->parsed_objects->grafts + pos,
-			   the_repository->parsed_objects->grafts + pos + 1,
-			   the_repository->parsed_objects->grafts_nr - pos - 1);
-	the_repository->parsed_objects->grafts_nr--;
-	return 0;
-}
-
 struct commit_buffer {
 	void *buffer;
 	unsigned long size;
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
diff --git a/environment.c b/environment.c
index 10c9061c43..aaca0e91ac 100644
--- a/environment.c
+++ b/environment.c
@@ -17,6 +17,7 @@
 #include "argv-array.h"
 #include "object-store.h"
 #include "chdir-notify.h"
+#include "shallow.h"
 
 int trust_executable_bit = 1;
 int trust_ctime = 1;
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
diff --git a/git.c b/git.c
index b07198fe03..9b689143c6 100644
--- a/git.c
+++ b/git.c
@@ -4,6 +4,7 @@
 #include "help.h"
 #include "run-command.h"
 #include "alias.h"
+#include "shallow.h"
 
 #define RUN_SETUP		(1<<0)
 #define RUN_SETUP_GENTLY	(1<<1)
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
index 5010a6c732..76e00893fe 100644
--- a/shallow.c
+++ b/shallow.c
@@ -14,6 +14,7 @@
 #include "commit-slab.h"
 #include "list-objects.h"
 #include "commit-reach.h"
+#include "shallow.h"
 
 void set_alternate_shallow_file(struct repository *r, const char *path, int override)
 {
@@ -38,6 +39,19 @@ int register_shallow(struct repository *r, const struct object_id *oid)
 	return register_commit_graft(r, graft, 0);
 }
 
+int unregister_shallow(const struct object_id *oid)
+{
+	int pos = commit_graft_pos(the_repository, oid->hash);
+	if (pos < 0)
+		return -1;
+	if (pos + 1 < the_repository->parsed_objects->grafts_nr)
+		MOVE_ARRAY(the_repository->parsed_objects->grafts + pos,
+			   the_repository->parsed_objects->grafts + pos + 1,
+			   the_repository->parsed_objects->grafts_nr - pos - 1);
+	the_repository->parsed_objects->grafts_nr--;
+	return 0;
+}
+
 int is_repository_shallow(struct repository *r)
 {
 	FILE *fp;
diff --git a/shallow.h b/shallow.h
new file mode 100644
index 0000000000..b50a85ed7e
--- /dev/null
+++ b/shallow.h
@@ -0,0 +1,64 @@
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
+int unregister_shallow(const struct object_id *oid);
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

