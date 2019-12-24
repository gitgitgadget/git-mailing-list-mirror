Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65527C2D0CF
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247BB20643
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SikrTzGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfLXLGA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:06:00 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46585 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfLXLF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 06:05:57 -0500
Received: by mail-qt1-f193.google.com with SMTP id g1so10956470qtr.13
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 03:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7m/yseedTabB0Td9/VTva/ztPXJmlmciz+vE2ytao/E=;
        b=SikrTzGh7OaFMoBs4t9RdRfoLDgH+TSgARCyA+n4acXUeHAIAuUs7/1PqjMitaALd5
         MQvgulwrSWq8/pHFzCEoJmgZWP8znhMwwEcgNdkYsTPsz9KcVIVoI0yN0zAulTTOcTEI
         VgDqcyESKbcGjWmkIf5MhM3/HF3zpG52iWbHrYf/mjUJkgLDni8B3T9PYAM4zHQMzIgU
         Y37FtgK7e4EUjO2tJ1+4hSs+zDhJ2cSPwDwDNJvmwODg2YN0oJN2DvCBzqo8I95d/T7K
         z7OuP3R/uWVdknKKy+q8wwIKGdKvRf9CGMS15IyDBxBtfVPFlf4c7MGWjW/CDiUjaQVN
         Deyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7m/yseedTabB0Td9/VTva/ztPXJmlmciz+vE2ytao/E=;
        b=gVk0ZI2VtIqRQc4/8mDkL3uyCjkCAhNqjt9ARPvd9GLmqrNPXUW22OeX1lMV9otswj
         1aIyzanElYczCegBEsoKbJAeoznj0G7a8CwPC+OGEA1U09KK2pJMB46mjZyMQdOtcSwY
         YIrHV6kPHcbSShLzif20kGclmdks7auFxVvKYJeQYyO80JVfjJom+LmzYkBMRPzVoOVF
         O51Vdkc7Ss7CDusJdQazP/W7/01nFEL7hJPM5zA4qG0U6gdUGpvLN8ZXwr8u3Jh2jfVG
         J1/pLWkFa72tZYjjXeS1I9CeG8/AeDVR94zyHVS6Idg9JA/tl7hgsUVhNx6d0ZAn1gZ4
         N5kw==
X-Gm-Message-State: APjAAAVgMmHBl5rtDxDdHKfzpF4v6F+4l7BvuMw0LSenq48qFYn0WhLg
        SY7YGHAytvKQPDhQ8W3AeuKsxeLQ
X-Google-Smtp-Source: APXvYqzMLd4tdILi/InmkHTsFV2xl+Sz3wz51j04hjHoX5IL9B1PsANg+J9Rf8pwDS5rpNfsHo3PJQ==
X-Received: by 2002:ac8:5241:: with SMTP id y1mr25843616qtn.373.1577185556075;
        Tue, 24 Dec 2019 03:05:56 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id o19sm7446944qtb.43.2019.12.24.03.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 03:05:55 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 10/17] reset: extract reset_head() from rebase
Date:   Tue, 24 Dec 2019 06:05:07 -0500
Message-Id: <981969d23024e1b49c9efbcffe4f05a8c36bcd54.1577185374.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577185374.git.liu.denton@gmail.com>
References: <cover.1571246693.git.liu.denton@gmail.com> <cover.1577185374.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue the process of lib-ifying the autostash code. In a future
commit, this will be used to implement `--autostash` in other builtins.

This patch is best viewed with `--color-moved`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Makefile         |   1 +
 builtin/rebase.c | 139 +---------------------------------------------
 reset.c          | 140 +++++++++++++++++++++++++++++++++++++++++++++++
 reset.h          |  20 +++++++
 4 files changed, 162 insertions(+), 138 deletions(-)
 create mode 100644 reset.c
 create mode 100644 reset.h

diff --git a/Makefile b/Makefile
index de149947f6..8d3aa4153e 100644
--- a/Makefile
+++ b/Makefile
@@ -967,6 +967,7 @@ LIB_OBJS += replace-object.o
 LIB_OBJS += repo-settings.o
 LIB_OBJS += repository.o
 LIB_OBJS += rerere.o
+LIB_OBJS += reset.o
 LIB_OBJS += resolve-undo.o
 LIB_OBJS += revision.o
 LIB_OBJS += run-command.o
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 4e3cb0852d..a6d7527f4c 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -27,6 +27,7 @@
 #include "branch.h"
 #include "sequencer.h"
 #include "rebase-interactive.h"
+#include "reset.h"
 
 #define DEFAULT_REFLOG_ACTION "rebase"
 
@@ -754,144 +755,6 @@ static void add_var(struct strbuf *buf, const char *name, const char *value)
 	}
 }
 
-#define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
-
-#define RESET_HEAD_DETACH (1<<0)
-#define RESET_HEAD_HARD (1<<1)
-#define RESET_HEAD_RUN_POST_CHECKOUT_HOOK (1<<2)
-#define RESET_HEAD_REFS_ONLY (1<<3)
-#define RESET_ORIG_HEAD (1<<4)
-
-static int reset_head(struct repository *r, struct object_id *oid, const char *action,
-		      const char *switch_to_branch, unsigned flags,
-		      const char *reflog_orig_head, const char *reflog_head,
-		      const char *default_reflog_action)
-{
-	unsigned detach_head = flags & RESET_HEAD_DETACH;
-	unsigned reset_hard = flags & RESET_HEAD_HARD;
-	unsigned run_hook = flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
-	unsigned refs_only = flags & RESET_HEAD_REFS_ONLY;
-	unsigned update_orig_head = flags & RESET_ORIG_HEAD;
-	struct object_id head_oid;
-	struct tree_desc desc[2] = { { NULL }, { NULL } };
-	struct lock_file lock = LOCK_INIT;
-	struct unpack_trees_options unpack_tree_opts;
-	struct tree *tree;
-	const char *reflog_action;
-	struct strbuf msg = STRBUF_INIT;
-	size_t prefix_len;
-	struct object_id *orig = NULL, oid_orig,
-		*old_orig = NULL, oid_old_orig;
-	int ret = 0, nr = 0;
-
-	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
-		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
-
-	if (!refs_only && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
-		ret = -1;
-		goto leave_reset_head;
-	}
-
-	if ((!oid || !reset_hard) && get_oid("HEAD", &head_oid)) {
-		ret = error(_("could not determine HEAD revision"));
-		goto leave_reset_head;
-	}
-
-	if (!oid)
-		oid = &head_oid;
-
-	if (refs_only)
-		goto reset_head_refs;
-
-	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
-	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
-	unpack_tree_opts.head_idx = 1;
-	unpack_tree_opts.src_index = r->index;
-	unpack_tree_opts.dst_index = r->index;
-	unpack_tree_opts.fn = reset_hard ? oneway_merge : twoway_merge;
-	unpack_tree_opts.update = 1;
-	unpack_tree_opts.merge = 1;
-	if (!detach_head)
-		unpack_tree_opts.reset = 1;
-
-	if (repo_read_index_unmerged(r) < 0) {
-		ret = error(_("could not read index"));
-		goto leave_reset_head;
-	}
-
-	if (!reset_hard && !fill_tree_descriptor(r, &desc[nr++], &head_oid)) {
-		ret = error(_("failed to find tree of %s"),
-			    oid_to_hex(&head_oid));
-		goto leave_reset_head;
-	}
-
-	if (!fill_tree_descriptor(r, &desc[nr++], oid)) {
-		ret = error(_("failed to find tree of %s"), oid_to_hex(oid));
-		goto leave_reset_head;
-	}
-
-	if (unpack_trees(nr, desc, &unpack_tree_opts)) {
-		ret = -1;
-		goto leave_reset_head;
-	}
-
-	tree = parse_tree_indirect(oid);
-	prime_cache_tree(r, r->index, tree);
-
-	if (write_locked_index(r->index, &lock, COMMIT_LOCK) < 0) {
-		ret = error(_("could not write index"));
-		goto leave_reset_head;
-	}
-
-reset_head_refs:
-	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
-	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : default_reflog_action);
-	prefix_len = msg.len;
-
-	if (update_orig_head) {
-		if (!get_oid("ORIG_HEAD", &oid_old_orig))
-			old_orig = &oid_old_orig;
-		if (!get_oid("HEAD", &oid_orig)) {
-			orig = &oid_orig;
-			if (!reflog_orig_head) {
-				strbuf_addstr(&msg, "updating ORIG_HEAD");
-				reflog_orig_head = msg.buf;
-			}
-			update_ref(reflog_orig_head, "ORIG_HEAD", orig,
-				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
-		} else if (old_orig)
-			delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
-	}
-
-	if (!reflog_head) {
-		strbuf_setlen(&msg, prefix_len);
-		strbuf_addstr(&msg, "updating HEAD");
-		reflog_head = msg.buf;
-	}
-	if (!switch_to_branch)
-		ret = update_ref(reflog_head, "HEAD", oid, orig,
-				 detach_head ? REF_NO_DEREF : 0,
-				 UPDATE_REFS_MSG_ON_ERR);
-	else {
-		ret = update_ref(reflog_head, switch_to_branch, oid,
-				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
-		if (!ret)
-			ret = create_symref("HEAD", switch_to_branch,
-					    reflog_head);
-	}
-	if (run_hook)
-		run_hook_le(NULL, "post-checkout",
-			    oid_to_hex(orig ? orig : &null_oid),
-			    oid_to_hex(oid), "1", NULL);
-
-leave_reset_head:
-	strbuf_release(&msg);
-	rollback_lock_file(&lock);
-	while (nr)
-		free((void *)desc[--nr].buffer);
-	return ret;
-}
-
 static int move_to_original_branch(struct rebase_options *opts)
 {
 	struct strbuf orig_head_reflog = STRBUF_INIT, head_reflog = STRBUF_INIT;
diff --git a/reset.c b/reset.c
new file mode 100644
index 0000000000..79b683bffa
--- /dev/null
+++ b/reset.c
@@ -0,0 +1,140 @@
+#include "git-compat-util.h"
+#include "cache-tree.h"
+#include "lockfile.h"
+#include "refs.h"
+#include "reset.h"
+#include "run-command.h"
+#include "tree-walk.h"
+#include "tree.h"
+#include "unpack-trees.h"
+
+int reset_head(struct repository *r, struct object_id *oid, const char *action,
+	       const char *switch_to_branch, unsigned flags,
+	       const char *reflog_orig_head, const char *reflog_head,
+	       const char *default_reflog_action)
+{
+	unsigned detach_head = flags & RESET_HEAD_DETACH;
+	unsigned reset_hard = flags & RESET_HEAD_HARD;
+	unsigned run_hook = flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
+	unsigned refs_only = flags & RESET_HEAD_REFS_ONLY;
+	unsigned update_orig_head = flags & RESET_ORIG_HEAD;
+	struct object_id head_oid;
+	struct tree_desc desc[2] = { { NULL }, { NULL } };
+	struct lock_file lock = LOCK_INIT;
+	struct unpack_trees_options unpack_tree_opts;
+	struct tree *tree;
+	const char *reflog_action;
+	struct strbuf msg = STRBUF_INIT;
+	size_t prefix_len;
+	struct object_id *orig = NULL, oid_orig,
+		*old_orig = NULL, oid_old_orig;
+	int ret = 0, nr = 0;
+
+	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
+		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
+
+	if (!refs_only && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
+		ret = -1;
+		goto leave_reset_head;
+	}
+
+	if ((!oid || !reset_hard) && get_oid("HEAD", &head_oid)) {
+		ret = error(_("could not determine HEAD revision"));
+		goto leave_reset_head;
+	}
+
+	if (!oid)
+		oid = &head_oid;
+
+	if (refs_only)
+		goto reset_head_refs;
+
+	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
+	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
+	unpack_tree_opts.head_idx = 1;
+	unpack_tree_opts.src_index = r->index;
+	unpack_tree_opts.dst_index = r->index;
+	unpack_tree_opts.fn = reset_hard ? oneway_merge : twoway_merge;
+	unpack_tree_opts.update = 1;
+	unpack_tree_opts.merge = 1;
+	if (!detach_head)
+		unpack_tree_opts.reset = 1;
+
+	if (repo_read_index_unmerged(r) < 0) {
+		ret = error(_("could not read index"));
+		goto leave_reset_head;
+	}
+
+	if (!reset_hard && !fill_tree_descriptor(r, &desc[nr++], &head_oid)) {
+		ret = error(_("failed to find tree of %s"),
+			    oid_to_hex(&head_oid));
+		goto leave_reset_head;
+	}
+
+	if (!fill_tree_descriptor(r, &desc[nr++], oid)) {
+		ret = error(_("failed to find tree of %s"), oid_to_hex(oid));
+		goto leave_reset_head;
+	}
+
+	if (unpack_trees(nr, desc, &unpack_tree_opts)) {
+		ret = -1;
+		goto leave_reset_head;
+	}
+
+	tree = parse_tree_indirect(oid);
+	prime_cache_tree(r, r->index, tree);
+
+	if (write_locked_index(r->index, &lock, COMMIT_LOCK) < 0) {
+		ret = error(_("could not write index"));
+		goto leave_reset_head;
+	}
+
+reset_head_refs:
+	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
+	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : default_reflog_action);
+	prefix_len = msg.len;
+
+	if (update_orig_head) {
+		if (!get_oid("ORIG_HEAD", &oid_old_orig))
+			old_orig = &oid_old_orig;
+		if (!get_oid("HEAD", &oid_orig)) {
+			orig = &oid_orig;
+			if (!reflog_orig_head) {
+				strbuf_addstr(&msg, "updating ORIG_HEAD");
+				reflog_orig_head = msg.buf;
+			}
+			update_ref(reflog_orig_head, "ORIG_HEAD", orig,
+				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
+		} else if (old_orig)
+			delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
+	}
+
+	if (!reflog_head) {
+		strbuf_setlen(&msg, prefix_len);
+		strbuf_addstr(&msg, "updating HEAD");
+		reflog_head = msg.buf;
+	}
+	if (!switch_to_branch)
+		ret = update_ref(reflog_head, "HEAD", oid, orig,
+				 detach_head ? REF_NO_DEREF : 0,
+				 UPDATE_REFS_MSG_ON_ERR);
+	else {
+		ret = update_ref(reflog_head, switch_to_branch, oid,
+				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
+		if (!ret)
+			ret = create_symref("HEAD", switch_to_branch,
+					    reflog_head);
+	}
+	if (run_hook)
+		run_hook_le(NULL, "post-checkout",
+			    oid_to_hex(orig ? orig : &null_oid),
+			    oid_to_hex(oid), "1", NULL);
+
+leave_reset_head:
+	strbuf_release(&msg);
+	rollback_lock_file(&lock);
+	while (nr)
+		free((void *)desc[--nr].buffer);
+	return ret;
+
+}
diff --git a/reset.h b/reset.h
new file mode 100644
index 0000000000..12f83c78e2
--- /dev/null
+++ b/reset.h
@@ -0,0 +1,20 @@
+#ifndef RESET_H
+#define RESET_H
+
+#include "hash.h"
+#include "repository.h"
+
+#define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
+
+#define RESET_HEAD_DETACH (1<<0)
+#define RESET_HEAD_HARD (1<<1)
+#define RESET_HEAD_RUN_POST_CHECKOUT_HOOK (1<<2)
+#define RESET_HEAD_REFS_ONLY (1<<3)
+#define RESET_ORIG_HEAD (1<<4)
+
+int reset_head(struct repository *r, struct object_id *oid, const char *action,
+	       const char *switch_to_branch, unsigned flags,
+	       const char *reflog_orig_head, const char *reflog_head,
+	       const char *default_reflog_action);
+
+#endif
-- 
2.24.1.810.g65a2f617f4

