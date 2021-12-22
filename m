Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55718C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbhLVEHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239040AbhLVEHN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 23:07:13 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5357FC06173F
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:07:13 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i22so2013791wrb.13
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GWH8AVog9g/zRPvjEFI0bX0cLQZvP0BWrmNVm0/qxG4=;
        b=hJ0QQ5nrQdjD1gCkflJra4DDfoeVQ75G79u5tQeIvj8MsFdOA/1tVzOIRR1//PKA3F
         VAp+3vy+/HCUr6HvB52kFEcpAmFvu69RXdTy1f8rVbuyGdPh6uYtoldf7N4P4IdHR9BF
         JDEq/5vyvZg+s5AifFA30P0DMgI32wvoQgzxZnKXsXVNJB6SJId6cbk6viZvxchTzHk9
         qVJozlfTvtziEyAtemZRs3pHofZnZ20rXG2y1MhGFuVfTD28G7hFXgjB9VJUiBn9ueWg
         DEE+6fGDazH0r6rWZSOyF4oDenyuHtjwlaOsni+pw0cXMfSX1cRY80y2aVeAwuqq9krp
         lfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GWH8AVog9g/zRPvjEFI0bX0cLQZvP0BWrmNVm0/qxG4=;
        b=k7AKc2psLQ+4IsWNyeptXB5D6ylgVzfTaQaI19wMxp5GL9KbHPh3RBZMkCA7EBZqPV
         ARxGlyllsej3XH48RCS2/PKBrw9+MOvyP5J7Ca1Lp1MVlzRgrf1cEnFpYWASgZyJL+RQ
         5PBEOhxlaOYYkMicib8mgfYQLuUKazCs2DG0OK1ZSYUwSqT4kowQsf2IZp4d8Zone6gN
         ySoyuyxcfa6Cvexz8DqhUMYtUvd69HqundpBBCiWtnjEMTOx70FOwC3Mv3sfb6IFahXF
         IpgnaK/OSzX/k4ztWBbt6zz8Hp6NmSKqY+Wlb0LWOs1jSq3sYfYaajNASJlmnbECoxcn
         +lKw==
X-Gm-Message-State: AOAM533nEreSgjHynPSjpc4UDcmi5GvM6WkfvnwAHPZydVJe4kxk8IP8
        jaKiRo8MvHMg95FaPKzc1q8mLRC2fYFlsg==
X-Google-Smtp-Source: ABdhPJy/9HLnr0DhA5cpaiH4V55tzA8aEFpPSaceTdTVW0Od9Vm1SaN8BCpGQmFImJil2ZOKmDqeQA==
X-Received: by 2002:a5d:6d8a:: with SMTP id l10mr706597wrs.527.1640146031719;
        Tue, 21 Dec 2021 20:07:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z5sm710484wru.87.2021.12.21.20.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 20:07:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 9/9] reflog + refs-backend: move "verbose" out of the backend
Date:   Wed, 22 Dec 2021 05:06:48 +0100
Message-Id: <patch-v3-9.9-2fb9de8ae51-20211222T040557Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v3-0.9-00000000000-20211222T040557Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20211222T040557Z-avarab@gmail.com>
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
 builtin/reflog.c     | 56 +++++++++++++++++++++++++++++++++++++-------
 refs.h               |  3 +--
 refs/files-backend.c | 44 ++++++++++++++++------------------
 3 files changed, 68 insertions(+), 35 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 4ff63846058..a4b1dd27e13 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -45,6 +45,7 @@ struct expire_reflog_policy_cb {
 	struct cmd_reflog_expire_cb cmd;
 	struct commit *tip_commit;
 	struct commit_list *tips;
+	unsigned int dry_run:1;
 };
 
 struct worktree_reflogs {
@@ -319,6 +320,28 @@ static int should_expire_reflog_ent(struct object_id *ooid, struct object_id *no
 	return 0;
 }
 
+static int should_expire_reflog_ent_verbose(struct object_id *ooid,
+					    struct object_id *noid,
+					    const char *email,
+					    timestamp_t timestamp, int tz,
+					    const char *message, void *cb_data)
+{
+	struct expire_reflog_policy_cb *cb = cb_data;
+	int expire;
+
+	expire = should_expire_reflog_ent(ooid, noid, email, timestamp, tz,
+					  message, cb);
+
+	if (!expire)
+		printf("keep %s", message);
+	else if (cb->dry_run)
+		printf("would prune %s", message);
+	else
+		printf("prune %s", message);
+
+	return expire;
+}
+
 static int push_tip_to_list(const char *refname, const struct object_id *oid,
 			    int flags, void *cb_data)
 {
@@ -539,6 +562,8 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	int i, status, do_all, all_worktrees = 1;
 	int explicit_expiry = 0;
 	unsigned int flags = 0;
+	int verbose = 0;
+	reflog_expiry_should_prune_fn *should_prune_fn = should_expire_reflog_ent;
 
 	default_reflog_expire_unreachable = now - 30 * 24 * 3600;
 	default_reflog_expire = now - 90 * 24 * 3600;
@@ -576,7 +601,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(arg, "--single-worktree"))
 			all_worktrees = 0;
 		else if (!strcmp(arg, "--verbose"))
-			flags |= EXPIRE_REFLOGS_VERBOSE;
+			verbose = 1;
 		else if (!strcmp(arg, "--")) {
 			i++;
 			break;
@@ -587,6 +612,9 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 			break;
 	}
 
+	if (verbose)
+		should_prune_fn = should_expire_reflog_ent_verbose;
+
 	/*
 	 * We can trust the commits and objects reachable from refs
 	 * even in older repository.  We cannot trust what's reachable
@@ -599,10 +627,10 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
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
 
@@ -624,12 +652,15 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		free_worktrees(worktrees);
 
 		for_each_string_list_item(item, &collected.reflogs) {
-			struct expire_reflog_policy_cb cb = { .cmd = cmd };
+			struct expire_reflog_policy_cb cb = {
+				.cmd = cmd,
+				.dry_run = !!(flags & EXPIRE_REFLOGS_DRY_RUN),
+			};
 
 			set_reflog_expiry_param(&cb.cmd, explicit_expiry, item->string);
 			status |= reflog_expire(item->string, flags,
 						reflog_expiry_prepare,
-						should_expire_reflog_ent,
+						should_prune_fn,
 						reflog_expiry_cleanup,
 						&cb);
 		}
@@ -647,7 +678,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		set_reflog_expiry_param(&cb.cmd, explicit_expiry, ref);
 		status |= reflog_expire(ref, flags,
 					reflog_expiry_prepare,
-					should_expire_reflog_ent,
+					should_prune_fn,
 					reflog_expiry_cleanup,
 					&cb);
 		free(ref);
@@ -670,6 +701,8 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 	struct cmd_reflog_expire_cb cmd = { 0 };
 	int i, status = 0;
 	unsigned int flags = 0;
+	int verbose = 0;
+	reflog_expiry_should_prune_fn *should_prune_fn = should_expire_reflog_ent;
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -680,7 +713,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(arg, "--updateref"))
 			flags |= EXPIRE_REFLOGS_UPDATE_REF;
 		else if (!strcmp(arg, "--verbose"))
-			flags |= EXPIRE_REFLOGS_VERBOSE;
+			verbose = 1;
 		else if (!strcmp(arg, "--")) {
 			i++;
 			break;
@@ -691,6 +724,9 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 			break;
 	}
 
+	if (verbose)
+		should_prune_fn = should_expire_reflog_ent_verbose;
+
 	if (argc - i < 1)
 		return error(_("no reflog specified to delete"));
 
@@ -698,7 +734,9 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 		const char *spec = strstr(argv[i], "@{");
 		char *ep, *ref;
 		int recno;
-		struct expire_reflog_policy_cb cb = { 0 };
+		struct expire_reflog_policy_cb cb = {
+			.dry_run = !!(flags & EXPIRE_REFLOGS_DRY_RUN),
+		};
 
 		if (!spec) {
 			status |= error(_("not a reflog: %s"), argv[i]);
@@ -723,7 +761,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 		cb.cmd = cmd;
 		status |= reflog_expire(ref, flags,
 					reflog_expiry_prepare,
-					should_expire_reflog_ent,
+					should_prune_fn,
 					reflog_expiry_cleanup,
 					&cb);
 		free(ref);
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
2.34.1.1146.gb52885e7c44

