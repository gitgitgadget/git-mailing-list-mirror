Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E9DE200B9
	for <e@80x24.org>; Sun,  6 May 2018 14:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751711AbeEFOLV (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 10:11:21 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33143 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbeEFOLU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 10:11:20 -0400
Received: by mail-wr0-f195.google.com with SMTP id o4-v6so25364595wrm.0
        for <git@vger.kernel.org>; Sun, 06 May 2018 07:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bkLKc6cWI9xg6wl2GX/DA8dnoQ+faZH+MLgwuwxi6Nc=;
        b=LzntNLN75Vqk+EhGefdmk70EHwAQU50DN21Q3xZsfJpaBaQTmstJYBvtmoNTP1xzVI
         F9OHMz/JXAdLw+oB/3HGOkncAEb2o+4LjvRzbheaANC4plQHd8Yhn/JluCOcID2p8XRi
         8BMDs41AfnX1dvEA3fNhrX7c5Gt6H+bhhhLyuOI16ifqO6JORBXP6YGbdAe6gXL2CNQM
         gBHuyKjtxAv46y8K7AxHPxFGId4tqgka46KLgqtXjsTYVKGU//Onhws2cJYhHu+1qYan
         zaVH99TrDP9cOyleUBZ4zszVb91TxJVLoMLWGe7yFqwFUSq5l2NiX+J/nU9Isv5F8bnl
         ZyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bkLKc6cWI9xg6wl2GX/DA8dnoQ+faZH+MLgwuwxi6Nc=;
        b=Pqn8qCr4keDuNN5/EDDWydUPPGNUEKhFo0tGLySDekEzDPES4R9MaqwtdaQjQWUfI8
         8A2gq/NX4UZJfWQl21e2Q2vy6ABU61QGWRRwp6Om5JASolsrf0OWeRgepjpSoPP9qr/Y
         u3z4PJYb0frP5cCRBoldtYrURBAFvBAWRf+IoJkcwzJq0h402XnR2nCWGpE87Aun4IdY
         w8Np7PmcHl7BOeFNW81QsdNh4Z8512i2bLn52ypQ8Cf1KrKbsm26AgG5XFG+l0c2w4Ad
         LeEkq4DNf9dkWrP7UP3rtEZmTjsEm1toaHjJjoQywmko4IbVvlhT/UN1bleLeKigKQMg
         335Q==
X-Gm-Message-State: ALQs6tCT9TylfgcmnqUFRl1T72AS/j9KkTaA2dvv5sthEiGXDbagLw5/
        METUEaTOeXNZhe8WL7h/+rts52Wm
X-Google-Smtp-Source: AB8JxZoICAP6a0Jp3AXKYWWNdxvHXqcyoDU7auGXc6HumcPZwagNB3TrDwA16fIWwWZAZ1iqM4BKiw==
X-Received: by 2002:adf:ea01:: with SMTP id q1-v6mr28678961wrm.50.1525615878456;
        Sun, 06 May 2018 07:11:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id p17sm4914857wmc.17.2018.05.06.07.11.17
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 May 2018 07:11:17 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 4/5] lock_file: make function-local locks non-static
Date:   Sun,  6 May 2018 16:10:30 +0200
Message-Id: <20180506141031.30204-5-martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.411.g9fd64c8e46
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These `struct lock_file`s are local to their respective functions and we
can drop their staticness.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 apply.c                | 2 +-
 builtin/describe.c     | 2 +-
 builtin/difftool.c     | 2 +-
 builtin/gc.c           | 2 +-
 builtin/merge.c        | 4 ++--
 builtin/receive-pack.c | 2 +-
 bundle.c               | 2 +-
 fast-import.c          | 2 +-
 refs/files-backend.c   | 2 +-
 shallow.c              | 2 +-
 10 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/apply.c b/apply.c
index 7e5792c996..07b14d1127 100644
--- a/apply.c
+++ b/apply.c
@@ -4058,7 +4058,7 @@ static int build_fake_ancestor(struct apply_state *state, struct patch *list)
 {
 	struct patch *patch;
 	struct index_state result = { NULL };
-	static struct lock_file lock;
+	struct lock_file lock = LOCK_INIT;
 	int res;
 
 	/* Once we start supporting the reverse patch, it may be
diff --git a/builtin/describe.c b/builtin/describe.c
index b5afc45846..8bd95cf371 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -612,7 +612,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 				suffix = broken;
 			}
 		} else if (dirty) {
-			static struct lock_file index_lock;
+			struct lock_file index_lock = LOCK_INIT;
 			struct rev_info revs;
 			struct argv_array args = ARGV_ARRAY_INIT;
 			int fd, result;
diff --git a/builtin/difftool.c b/builtin/difftool.c
index aad0e073ee..162806f238 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -610,7 +610,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 			continue;
 
 		if (!indices_loaded) {
-			static struct lock_file lock;
+			struct lock_file lock = LOCK_INIT;
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "%s/wtindex", tmpdir);
 			if (hold_lock_file_for_update(&lock, buf.buf, 0) < 0 ||
diff --git a/builtin/gc.c b/builtin/gc.c
index 3e67124eaa..274660d9dc 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -234,7 +234,7 @@ static int need_to_gc(void)
 /* return NULL on success, else hostname running the gc */
 static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 {
-	static struct lock_file lock;
+	struct lock_file lock = LOCK_INIT;
 	char my_host[HOST_NAME_MAX + 1];
 	struct strbuf sb = STRBUF_INIT;
 	struct stat st;
diff --git a/builtin/merge.c b/builtin/merge.c
index 9db5a2cf16..de62b2c5c6 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -647,7 +647,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 			      struct commit_list *remoteheads,
 			      struct commit *head)
 {
-	static struct lock_file lock;
+	struct lock_file lock = LOCK_INIT;
 	const char *head_arg = "HEAD";
 
 	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
@@ -805,7 +805,7 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
 {
 	struct object_id result_tree, result_commit;
 	struct commit_list *parents, **pptr = &parents;
-	static struct lock_file lock;
+	struct lock_file lock = LOCK_INIT;
 
 	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
 	refresh_cache(REFRESH_QUIET);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 4b68a28e92..d3cf36cef5 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -876,7 +876,7 @@ static void refuse_unconfigured_deny_delete_current(void)
 static int command_singleton_iterator(void *cb_data, struct object_id *oid);
 static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 {
-	static struct lock_file shallow_lock;
+	struct lock_file shallow_lock = LOCK_INIT;
 	struct oid_array extra = OID_ARRAY_INIT;
 	struct check_connected_options opt = CHECK_CONNECTED_INIT;
 	uint32_t mask = 1 << (cmd->index % 32);
diff --git a/bundle.c b/bundle.c
index 902c9b5448..160bbfdc64 100644
--- a/bundle.c
+++ b/bundle.c
@@ -409,7 +409,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 int create_bundle(struct bundle_header *header, const char *path,
 		  int argc, const char **argv)
 {
-	static struct lock_file lock;
+	struct lock_file lock = LOCK_INIT;
 	int bundle_fd = -1;
 	int bundle_to_stdout;
 	int ref_count = 0;
diff --git a/fast-import.c b/fast-import.c
index 05d1079d23..09443c1a9d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1817,7 +1817,7 @@ static void dump_marks_helper(FILE *f,
 
 static void dump_marks(void)
 {
-	static struct lock_file mark_lock;
+	struct lock_file mark_lock = LOCK_INIT;
 	FILE *f;
 
 	if (!export_marks_file || (import_marks_file && !import_marks_file_done))
diff --git a/refs/files-backend.c b/refs/files-backend.c
index a92a2aa821..7b2da7b8c9 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2995,7 +2995,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_WRITE, "reflog_expire");
-	static struct lock_file reflog_lock;
+	struct lock_file reflog_lock = LOCK_INIT;
 	struct expire_reflog_cb cb;
 	struct ref_lock *lock;
 	struct strbuf log_file_sb = STRBUF_INIT;
diff --git a/shallow.c b/shallow.c
index df4d44ea7a..85313619ea 100644
--- a/shallow.c
+++ b/shallow.c
@@ -353,7 +353,7 @@ void advertise_shallow_grafts(int fd)
  */
 void prune_shallow(int show_only)
 {
-	static struct lock_file shallow_lock;
+	struct lock_file shallow_lock = LOCK_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	int fd;
 
-- 
2.17.0.411.g9fd64c8e46

