Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437E4C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 13:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbhLPNpj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 08:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237743AbhLPNpf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 08:45:35 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702D5C061757
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 05:45:31 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t18so44243394wrg.11
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 05:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RV4ixeqOZUgs91PsaI2Hd7qxloH8K5NDairHqGP5tBI=;
        b=kdP2H2Uk/cKuhzGzDZssY8+ZQM6dRVcrYxKHhSQ2H+MvyS26lGea/LAk9TtFzllzNH
         uRVuLz3UfVFYaJ8sArPi7L3Gxjn+QhGk/PXK3B9qRT1do31ftqLlkwEWjtbq4S23XPW5
         /YnUQbL/XuSIWX3BAuQ5lIcd17A0dfd9hMGjLTNqDq86s8aSZuM+7Oc51+Ho/y3dwVHg
         wJuBCeU80Tx25040/PsYjaQ2h4jnIqJUc1Dp0TDSS6C/Pihs87BRmq6YQPT3I2Sk10BV
         ZkLSc683+kYSCKNcRDTE8lg5+Ojjpn8b6uluj4c5yXuQrSaGr3cqHYQScHGIkKTnr6TL
         Vsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RV4ixeqOZUgs91PsaI2Hd7qxloH8K5NDairHqGP5tBI=;
        b=waRdTXVVC/XjKPr+N3vhTSbcuQBDtX2AidwVX6EnzusYZipSvTFvu2jOoXjQNwh7Od
         0czuB66Et3r1XOm2l0wm9dmoUjNF0VpR13n2gd3bHp/wgHNuUcsJkzLJAOIiK46Cnzpf
         Mb/okJhfWZm6DxNPAumOFpSgsBjZaFWEOHJwiuHsUQVFcSQoMuoeTHkS658aa87lm3mF
         0kftuR3xYaVvnS/HM7srKMP+blI/OAMzsHbq+IRc4ndcYR6s2jQ09YEFaVh2ORMwlKkX
         lpZkuJfT532h2dWyMagK7PBgOY1At/tCkkZFETqdKhL2MMXcIkgSc6VH4Yhc2UP4L783
         W6WQ==
X-Gm-Message-State: AOAM532+sF8YPiVzyCX1rNClXvz5Y0oiBVRcJ2k1mibSQ8RxaYLdYGMK
        dEB8d46ASwai1O1HHKL7pUMnuAYCdFnWSQ==
X-Google-Smtp-Source: ABdhPJwR59KjBGjlVgJVi0AgrP+zDDmtOjiW8hqGn5GraVTTOWBnsgYNSqQfW9QA07327qX5X1lYeA==
X-Received: by 2002:adf:dc52:: with SMTP id m18mr8715428wrj.216.1639662329718;
        Thu, 16 Dec 2021 05:45:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y12sm4866821wrn.73.2021.12.16.05.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 05:45:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 9/9] reflog + refs-backend: move "verbose" out of the backend
Date:   Thu, 16 Dec 2021 14:45:18 +0100
Message-Id: <patch-v2-9.9-28aa0aa6e30-20211216T134028Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1020.gc80c40b6642
In-Reply-To: <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the handling of the "verbose" flag entirely out of
"refs/files-backend.c" and into "builtin/reflog.c". This allows the
backend to stop knowing about the EXPIRE_REFLOGS_VERBOSE flag.

The expire_reflog_ent() function shouldn't need to deal with the
implementation detail of whether or not we're emitting verbose output,
by doing this the --verbose output becomes backend-agnostic, so
reftable will get the same output.

I think the output is rather bad currently, and should e.g. be
implemented with some better future mode of progress.[ch], but that's
a topic for another improvement.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c     | 42 +++++++++++++++++++++++++++++++-----------
 refs.h               |  3 +--
 refs/files-backend.c | 44 ++++++++++++++++++++------------------------
 3 files changed, 52 insertions(+), 37 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 48e4f5887b0..a77c0d96dce 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -45,6 +45,8 @@ struct expire_reflog_policy_cb {
 	struct cmd_reflog_expire_cb cmd;
 	struct commit *tip_commit;
 	struct commit_list *tips;
+	unsigned int dry_run:1,
+		     verbose:1;
 };
 
 struct worktree_reflogs {
@@ -294,29 +296,38 @@ static int should_expire_reflog_ent(struct object_id *ooid, struct object_id *no
 	struct commit *old_commit, *new_commit;
 
 	if (timestamp < cb->cmd.expire_total)
-		return 1;
+		goto expire;
 
 	old_commit = new_commit = NULL;
 	if (cb->cmd.stalefix &&
 	    (!keep_entry(&old_commit, ooid) || !keep_entry(&new_commit, noid)))
-		return 1;
+		goto expire;
 
 	if (timestamp < cb->cmd.expire_unreachable) {
 		switch (cb->unreachable_expire_kind) {
 		case UE_ALWAYS:
-			return 1;
+			goto expire;
 		case UE_NORMAL:
 		case UE_HEAD:
 			if (unreachable(cb, old_commit, ooid) || unreachable(cb, new_commit, noid))
-				return 1;
+				goto expire;
 			break;
 		}
 	}
 
 	if (cb->cmd.recno && --(cb->cmd.recno) == 0)
-		return 1;
+		goto expire;
+
+	if (cb->verbose)
+		printf("keep %s", message);
 
 	return 0;
+expire:
+	if (cb->dry_run)
+		printf("would prune %s", message);
+	else if (cb->verbose)
+		printf("prune %s", message);
+	return 1;
 }
 
 static int push_tip_to_list(const char *refname, const struct object_id *oid,
@@ -539,6 +550,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	int i, status, do_all, all_worktrees = 1;
 	int explicit_expiry = 0;
 	unsigned int flags = 0;
+	int verbose = 0;
 
 	default_reflog_expire_unreachable = now - 30 * 24 * 3600;
 	default_reflog_expire = now - 90 * 24 * 3600;
@@ -576,7 +588,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(arg, "--single-worktree"))
 			all_worktrees = 0;
 		else if (!strcmp(arg, "--verbose"))
-			flags |= EXPIRE_REFLOGS_VERBOSE;
+			verbose = 1;
 		else if (!strcmp(arg, "--")) {
 			i++;
 			break;
@@ -599,10 +611,10 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		revs.do_not_die_on_missing_tree = 1;
 		revs.ignore_missing = 1;
 		revs.ignore_missing_links = 1;
-		if (flags & EXPIRE_REFLOGS_VERBOSE)
+		if (verbose)
 			printf(_("Marking reachable objects..."));
 		mark_reachable_objects(&revs, 0, 0, NULL);
-		if (flags & EXPIRE_REFLOGS_VERBOSE)
+		if (verbose)
 			putchar('\n');
 	}
 
@@ -624,7 +636,11 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		free_worktrees(worktrees);
 
 		for_each_string_list_item(item, &collected.reflogs) {
-			struct expire_reflog_policy_cb cb = { .cmd = cmd };
+			struct expire_reflog_policy_cb cb = {
+				.cmd = cmd,
+				.dry_run = !!(flags & EXPIRE_REFLOGS_DRY_RUN),
+				.verbose = verbose,
+			};
 
 			set_reflog_expiry_param(&cb.cmd, explicit_expiry, item->string);
 			status |= reflog_expire(item->string, flags,
@@ -671,6 +687,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 	struct cmd_reflog_expire_cb cmd = { 0 };
 	int i, status = 0;
 	unsigned int flags = 0;
+	int verbose = 0;
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -681,7 +698,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(arg, "--updateref"))
 			flags |= EXPIRE_REFLOGS_UPDATE_REF;
 		else if (!strcmp(arg, "--verbose"))
-			flags |= EXPIRE_REFLOGS_VERBOSE;
+			verbose = 1;
 		else if (!strcmp(arg, "--")) {
 			i++;
 			break;
@@ -699,7 +716,10 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 		const char *spec = strstr(argv[i], "@{");
 		char *ep, *ref;
 		int recno;
-		struct expire_reflog_policy_cb cb = { 0 };
+		struct expire_reflog_policy_cb cb = {
+			.verbose = verbose,
+			.dry_run = !!(flags & EXPIRE_REFLOGS_DRY_RUN),
+		};
 
 		if (!spec) {
 			status |= error(_("not a reflog: %s"), argv[i]);
diff --git a/refs.h b/refs.h
index 92360e55a20..8f91a7f9ff2 100644
--- a/refs.h
+++ b/refs.h
@@ -820,8 +820,7 @@ enum ref_type ref_type(const char *refname);
 enum expire_reflog_flags {
 	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
 	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
-	EXPIRE_REFLOGS_VERBOSE = 1 << 2,
-	EXPIRE_REFLOGS_REWRITE = 1 << 3
+	EXPIRE_REFLOGS_REWRITE = 1 << 2,
 };
 
 /*
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5f8586a36e3..6178ad8c77c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3086,11 +3086,12 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 }
 
 struct expire_reflog_cb {
-	unsigned int flags;
 	reflog_expiry_should_prune_fn *should_prune_fn;
 	void *policy_cb;
 	FILE *newlog;
 	struct object_id last_kept_oid;
+	unsigned int rewrite:1,
+		     dry_run:1;
 };
 
 static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
@@ -3098,33 +3099,27 @@ static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
 			     const char *message, void *cb_data)
 {
 	struct expire_reflog_cb *cb = cb_data;
-	struct expire_reflog_policy_cb *policy_cb = cb->policy_cb;
+	reflog_expiry_should_prune_fn *fn = cb->should_prune_fn;
 
-	if (cb->flags & EXPIRE_REFLOGS_REWRITE)
+	if (cb->rewrite)
 		ooid = &cb->last_kept_oid;
 
-	if ((*cb->should_prune_fn)(ooid, noid, email, timestamp, tz,
-				   message, policy_cb)) {
-		if (cb->flags & EXPIRE_REFLOGS_DRY_RUN)
-			printf("would prune %s", message);
-		else if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
-			printf("prune %s", message);
-	} else {
-		if (!(cb->flags & EXPIRE_REFLOGS_DRY_RUN)) {
-			fprintf(cb->newlog, "%s %s %s %"PRItime" %+05d\t%s",
-				oid_to_hex(ooid), oid_to_hex(noid),
-				email, timestamp, tz, message);
-			oidcpy(&cb->last_kept_oid, noid);
-		}
-		if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
-			printf("keep %s", message);
-	}
+	if (fn(ooid, noid, email, timestamp, tz, message, cb->policy_cb))
+		return 0;
+
+	if (cb->dry_run)
+		return 0; /* --dry-run */
+
+	fprintf(cb->newlog, "%s %s %s %"PRItime" %+05d\t%s", oid_to_hex(ooid),
+		oid_to_hex(noid), email, timestamp, tz, message);
+	oidcpy(&cb->last_kept_oid, noid);
+
 	return 0;
 }
 
 static int files_reflog_expire(struct ref_store *ref_store,
 			       const char *refname,
-			       unsigned int flags,
+			       unsigned int expire_flags,
 			       reflog_expiry_prepare_fn prepare_fn,
 			       reflog_expiry_should_prune_fn should_prune_fn,
 			       reflog_expiry_cleanup_fn cleanup_fn,
@@ -3142,7 +3137,8 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	const struct object_id *oid;
 
 	memset(&cb, 0, sizeof(cb));
-	cb.flags = flags;
+	cb.rewrite = !!(expire_flags & EXPIRE_REFLOGS_REWRITE);
+	cb.dry_run = !!(expire_flags & EXPIRE_REFLOGS_DRY_RUN);
 	cb.policy_cb = policy_cb_data;
 	cb.should_prune_fn = should_prune_fn;
 
@@ -3178,7 +3174,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 
 	files_reflog_path(refs, &log_file_sb, refname);
 	log_file = strbuf_detach(&log_file_sb, NULL);
-	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
+	if (!cb.dry_run) {
 		/*
 		 * Even though holding $GIT_DIR/logs/$reflog.lock has
 		 * no locking implications, we use the lock_file
@@ -3205,7 +3201,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	refs_for_each_reflog_ent(ref_store, refname, expire_reflog_ent, &cb);
 	(*cleanup_fn)(cb.policy_cb);
 
-	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
+	if (!cb.dry_run) {
 		/*
 		 * It doesn't make sense to adjust a reference pointed
 		 * to by a symbolic ref based on expiring entries in
@@ -3215,7 +3211,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 		 */
 		int update = 0;
 
-		if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
+		if ((expire_flags & EXPIRE_REFLOGS_UPDATE_REF) &&
 		    !is_null_oid(&cb.last_kept_oid)) {
 			int ignore_errno;
 			int type;
-- 
2.34.1.1020.gc80c40b6642

