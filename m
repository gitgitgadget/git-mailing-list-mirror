Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D45120A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 10:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbeLIKp0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 05:45:26 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41358 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbeLIKpU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 05:45:20 -0500
Received: by mail-lf1-f68.google.com with SMTP id c16so5940222lfj.8
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 02:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MWvEHOySCpKm8z9TQIw4V7ZH6KUchZGPooFpL1cA98c=;
        b=YM6UcHi0bzkNisx7cFS9xtdF8dDmtpkPOIpUXtNMvjkEDzvGUW6Ntr6M16436j/lMZ
         o+SB5UpLB2emD7t2gkYGjDElDOPYsvmhNpacIQCc0wy+IcUamDYBDCPvUuZ4xumEkNBu
         t1ZRzb4PDYoi+iijVCGDHgCl3Uq+7Tor2LdBjqe3qaTHtA4qOuUlMPD79nNqQLw637I6
         tjlsWQLnQYLu2QSjFPJ31rU1cHNW+cxip9HfxeQb4OleINJ8Hc3sUAXXRPxjyc+nVcJL
         5jVs9qNO53pV1DkN229TxuLyiFNudehlD8ccRMdu+j8J8W4HVXn5i59w3cJ85lRr0SqH
         y6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MWvEHOySCpKm8z9TQIw4V7ZH6KUchZGPooFpL1cA98c=;
        b=q0rhVplDwt8t/9gJTxZAle185BOI0EqItG7j4h70hjVyEE5n+owbvJ+5tHoD/KNCEw
         wz9UjBYIuyWVm8xury+aCXpeS9ZauunUubuxiKOdgCdlFUNItwTTweOVZuT2kFC0km2j
         7CeGW+FvTXPWt2jmQrB79h8qc333N1AWpCq30+d4bbjMnNdxhKjszLtL4MEzns0gCwXh
         ZSPLdLnekQ+eP0C1loKdLeqdqUL/CpyM23SQCSgWMQjcMv21VY2NfqGFdXwr7G1T3XfS
         5xw4ZJJ9Lg7uIWXNp8hWUVrLbkUjFWvS2FWED6SIG0h+hy4C1+hX8n6KUiGGtn8oof2O
         D5Vg==
X-Gm-Message-State: AA+aEWb2RdJDeZmAOYykgfF4MNdsW5Eoz1eyiy2lQtlpi8MvaJOJHCuK
        b0k0zOhrLlFr7RfhiT19GGhAijUd
X-Google-Smtp-Source: AFSGD/VL588NMPQPLdxgIdUGZ9FfHEXoHmoJnE9LUnURYCV9wGm0RjFRxGfdmezIRhZqZwCdYLQBRw==
X-Received: by 2002:a19:a086:: with SMTP id j128mr4416221lfe.93.1544352317767;
        Sun, 09 Dec 2018 02:45:17 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id s3-v6sm1564938lje.73.2018.12.09.02.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 02:45:16 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 15/24] backup-log: keep all blob references around
Date:   Sun,  9 Dec 2018 11:44:10 +0100
Message-Id: <20181209104419.12639-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.486.g9832c05c3d
In-Reply-To: <20181209104419.12639-1-pclouds@gmail.com>
References: <20181209104419.12639-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The four commands prune, rev-list, pack-objects and repack are updated
to not consider backup-log's blobs as unreachable and either delete
them outright or not repack them.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 backup-log.c           | 65 ++++++++++++++++++++++++++++++++++++++++++
 backup-log.h           |  2 ++
 builtin/pack-objects.c |  9 +++++-
 builtin/repack.c       |  1 +
 reachable.c            |  3 ++
 revision.c             |  3 ++
 6 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/backup-log.c b/backup-log.c
index dbb6d5487e..37fa71e4e0 100644
--- a/backup-log.c
+++ b/backup-log.c
@@ -3,6 +3,7 @@
 #include "blob.h"
 #include "lockfile.h"
 #include "object-store.h"
+#include "revision.h"
 #include "strbuf.h"
 #include "worktree.h"
 
@@ -321,3 +322,67 @@ void bkl_prune_all_or_die(struct repository *r, timestamp_t expire)
 	}
 	free_worktrees(worktrees);
 }
+
+struct pending_cb {
+	struct rev_info *revs;
+	unsigned flags;
+};
+
+static void add_blob_to_pending(const struct object_id *oid,
+				const char *path,
+				struct pending_cb *cb)
+{
+	struct blob *blob;
+
+	if (!good_oid(cb->revs->repo, oid))
+		return;
+
+	blob = lookup_blob(cb->revs->repo, oid);
+	blob->object.flags |= cb->flags;
+	add_pending_object(cb->revs, &blob->object, path);
+}
+
+static int add_pending(struct strbuf *line, void *cb)
+{
+	struct bkl_entry entry;
+
+	if (bkl_parse_entry(line, &entry))
+		return -1;
+
+	add_blob_to_pending(&entry.old_oid, entry.path, cb);
+	add_blob_to_pending(&entry.new_oid, entry.path, cb);
+	return 0;
+}
+
+static void add_backup_log_to_pending(const char *path, struct pending_cb *cb)
+{
+	bkl_parse_file(path, add_pending, cb);
+}
+
+void add_backup_logs_to_pending(struct rev_info *revs, unsigned flags)
+{
+	struct worktree **worktrees, **p;
+	char *path;
+	struct pending_cb cb;
+
+	cb.revs = revs;
+	cb.flags = flags;
+
+	worktrees = get_worktrees(0);
+	for (p = worktrees; *p; p++) {
+		struct worktree *wt = *p;
+
+		path = xstrdup(worktree_git_path(wt, "index.bkl"));
+		add_backup_log_to_pending(path, &cb);
+		free(path);
+
+		path = xstrdup(worktree_git_path(wt, "worktree.bkl"));
+		add_backup_log_to_pending(path, &cb);
+		free(path);
+	}
+	free_worktrees(worktrees);
+
+	path = git_pathdup("common/gitdir.bkl");
+	add_backup_log_to_pending(path, &cb);
+	free(path);
+}
diff --git a/backup-log.h b/backup-log.h
index 6572ce9c93..aaa76b7fe2 100644
--- a/backup-log.h
+++ b/backup-log.h
@@ -4,6 +4,7 @@
 #include "cache.h"
 
 struct repository;
+struct rev_info;
 struct strbuf;
 
 struct bkl_entry
@@ -30,6 +31,7 @@ int bkl_parse_file(const char *path,
 		   int (*parse)(struct strbuf *line, void *data),
 		   void *data);
 
+void add_backup_logs_to_pending(struct rev_info *revs, unsigned flags);
 int bkl_prune(struct repository *r, const char *id, timestamp_t expire);
 void bkl_prune_all_or_die(struct repository *r, timestamp_t expire);
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 411aefd687..940eb0c768 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3230,7 +3230,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	int all_progress_implied = 0;
 	struct argv_array rp = ARGV_ARRAY_INIT;
 	int rev_list_unpacked = 0, rev_list_all = 0, rev_list_reflog = 0;
-	int rev_list_index = 0;
+	int rev_list_index = 0, rev_list_backuplog = 0;
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	struct option pack_objects_options[] = {
 		OPT_SET_INT('q', "quiet", &progress,
@@ -3278,6 +3278,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT_F(0, "reflog", &rev_list_reflog,
 			      N_("include objects referred by reflog entries"),
 			      1, PARSE_OPT_NONEG),
+		OPT_SET_INT_F(0, "backup-log", &rev_list_backuplog,
+			      N_("include objects referred by backup-log entries"),
+			      1, PARSE_OPT_NONEG),
 		OPT_SET_INT_F(0, "indexed-objects", &rev_list_index,
 			      N_("include objects referred to by the index"),
 			      1, PARSE_OPT_NONEG),
@@ -3366,6 +3369,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		use_internal_rev_list = 1;
 		argv_array_push(&rp, "--reflog");
 	}
+	if (rev_list_backuplog) {
+		use_internal_rev_list = 1;
+		argv_array_push(&rp, "--backup-log");
+	}
 	if (rev_list_index) {
 		use_internal_rev_list = 1;
 		argv_array_push(&rp, "--indexed-objects");
diff --git a/builtin/repack.c b/builtin/repack.c
index 45583683ee..a8a9fad9c6 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -365,6 +365,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	argv_array_push(&cmd.args, "--non-empty");
 	argv_array_push(&cmd.args, "--all");
 	argv_array_push(&cmd.args, "--reflog");
+	argv_array_push(&cmd.args, "--backup-log");
 	argv_array_push(&cmd.args, "--indexed-objects");
 	if (repository_format_partial_clone)
 		argv_array_push(&cmd.args, "--exclude-promisor-objects");
diff --git a/reachable.c b/reachable.c
index 6e9b810d2a..61f6560b54 100644
--- a/reachable.c
+++ b/reachable.c
@@ -12,6 +12,7 @@
 #include "packfile.h"
 #include "worktree.h"
 #include "object-store.h"
+#include "backup-log.h"
 
 struct connectivity_progress {
 	struct progress *progress;
@@ -185,6 +186,8 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 	if (mark_reflog)
 		add_reflogs_to_pending(revs, 0);
 
+	add_backup_logs_to_pending(revs, 0);
+
 	cp.progress = progress;
 	cp.count = 0;
 
diff --git a/revision.c b/revision.c
index 13e0519c02..755edea61e 100644
--- a/revision.c
+++ b/revision.c
@@ -27,6 +27,7 @@
 #include "commit-reach.h"
 #include "commit-graph.h"
 #include "prio-queue.h"
+#include "backup-log.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -2286,6 +2287,8 @@ static int handle_revision_pseudo_opt(const char *submodule,
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--reflog")) {
 		add_reflogs_to_pending(revs, *flags);
+	} else if (!strcmp(arg, "--backup-log")) {
+		add_backup_logs_to_pending(revs, *flags);
 	} else if (!strcmp(arg, "--indexed-objects")) {
 		add_index_objects_to_pending(revs, *flags);
 	} else if (!strcmp(arg, "--not")) {
-- 
2.20.0.rc2.486.g9832c05c3d

