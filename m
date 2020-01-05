Return-Path: <SRS0=oqjl=22=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EABEC33C99
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 13:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2892C207FD
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 13:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="QvLKvJkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgAEN4c (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jan 2020 08:56:32 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37221 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgAEN4c (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jan 2020 08:56:32 -0500
Received: by mail-pg1-f195.google.com with SMTP id q127so25618390pga.4
        for <git@vger.kernel.org>; Sun, 05 Jan 2020 05:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=55nLchzx6IvJkp2UYdZ7M7nLUmQQOWhlZhMA3jCnvQw=;
        b=QvLKvJkhPzLsjBcHq8/NHLy1Lh/9UeOhnHxqgQ8Kb4/ZPTiPv8QRgrzZpvB4vHwBs2
         SlTOvtQb+sUxn9cOonaH0RWLOqune1kJBTjvgWFi4oBHi8UL7dviy1w0w+CaUj1ar0K2
         Bi2ScPB0G97zgWsdJsttc8R5A9/OObDdJKXhcaAuyUHsJ9GO5qhZScbxB4Myhha+WT7E
         tnwsMKqn6PzGlGoMP0CK8VHuiiu6Ra+b53Ofccn0/Q+/LUqwfMa8YrWT9ShMypxAzVoE
         a3eT3Y2yN364OwBq37XxQimIPX1d68jMd3BuMGQPZzqI2sswBdiJcWqEQTs1Eu0BlvsN
         3HTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=55nLchzx6IvJkp2UYdZ7M7nLUmQQOWhlZhMA3jCnvQw=;
        b=HIZ8DNWgAQcF9vO4Fq1aQX/usYgrUsEYuXZ8cyAq62dJgxCvDb03+CLO9Bop2Ha1HJ
         YSvZBumAbRrK7xaEByfdaEiUBmUE2czxx9cK39N7LURrfBkvk0tktQ8Y3xJxBY453ulT
         ziVqKaTPZU5kOof7ryNhhnDkSBb5EpO6DtfRIuwUHrsA1/WAEB7BCdYZprKFwgHQKWPe
         uVp4V9/CCsk+th69y1EwTehyG5gO2xdGDRufjT26WSX3uwyaeDEgExt5U9yHvLkvYxHv
         QPkTJyJEKSGFh08o0LXLyo9K+J+OzWSj+nk6m9uHIpdkoQIwb5z9VtTCPBZSepbtrkUI
         Uhdg==
X-Gm-Message-State: APjAAAUvCjuDueeOGFWKW+g/nx6PyIE7cgP4kGo/rPl6+SosE99jSYTW
        Ea4i0h2ZlrrzRdGUdzceps9odfSOUC0=
X-Google-Smtp-Source: APXvYqzeJmJlDhChfNximn1IKj8eD1T1V9RYAFR3ePi4H8GR1Bs9R2/nPksz+cXSyVp6j1PUtgYEGQ==
X-Received: by 2002:a65:6914:: with SMTP id s20mr104318646pgq.44.1578232589569;
        Sun, 05 Jan 2020 05:56:29 -0800 (PST)
Received: from localhost ([202.62.47.81])
        by smtp.gmail.com with ESMTPSA id u2sm69052959pgc.19.2020.01.05.05.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 05:56:29 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH 3/5] commit: refactor signature verification helpers
Date:   Sun,  5 Jan 2020 13:56:14 +0000
Message-Id: <20200105135616.19102-4-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200105135616.19102-1-hji@dyntopia.com>
References: <20200105135616.19102-1-hji@dyntopia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, signature verification for commits had a number of helper
functions with slightly different behaviors:

- builtin/verify-commit.c had a file-local helper, so it wasn't reusable
  outside of the verify-commit builtin.
- commit.c had verify_merge_signature() that die()d on errors, making it
  difficult to reuse in parts of Git that mustn't (immediately) die on
  failure.
- commit.c also had check_commit_signature().  It's flexible enough to
  be used anywhere, but it isn't as nice as gpg_verify_tag().  More
  specifically, it doesn't take care of printing the result; nor does it
  accept and parse arbitrary object IDs.

This commit changes check_commit_signature() to file-local scope.  It
also introduces a gpg_verify_commit() function modelled after
gpg_verify_tag().  It is written with the intent of removing the need to
implement local helpers for operations that verifies commit signatures.
This should hopefully make the code paths to the GPG interface easier to
follow.

Signed-off-by: Hans Jerry Illikainen <hji@dyntopia.com>
---
 builtin/merge.c         | 16 ++++++++------
 builtin/pull.c          | 18 +++++-----------
 builtin/verify-commit.c | 25 +---------------------
 commit.c                | 47 ++++++++++++++++++++++++++++++-----------
 commit.h                | 31 ++++++---------------------
 gpg-interface.h         |  1 +
 pretty.c                |  3 ++-
 7 files changed, 60 insertions(+), 81 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index d127d2225f..e472f17738 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -62,8 +62,8 @@ static int show_diffstat = 1, shortlog_len = -1, squash;
 static int option_commit = -1;
 static int option_edit = -1;
 static int allow_trivial = 1, have_message, verify_signatures;
-static int check_trust_level = 1;
 static int overwrite_ignore = 1;
+static unsigned gpg_flags = GPG_VERIFY_SHORT | GPG_VERIFY_COMPAT;
 static struct strbuf merge_msg = STRBUF_INIT;
 static struct strategy **use_strategies;
 static size_t use_strategies_nr, use_strategies_alloc;
@@ -633,7 +633,7 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		sign_commit = git_config_bool(k, v) ? "" : NULL;
 		return 0;
 	} else if (!strcmp(k, "gpg.mintrustlevel")) {
-		check_trust_level = 0;
+		gpg_flags ^= GPG_VERIFY_COMPAT;
 	}
 
 	status = fmt_merge_msg_config(k, v, cb);
@@ -1399,9 +1399,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		if (remoteheads->next)
 			die(_("Can merge only exactly one commit into empty head"));
 
-		if (verify_signatures)
-			verify_merge_signature(remoteheads->item, verbosity,
-					       check_trust_level);
+		if (verify_signatures &&
+		    gpg_verify_commit(&remoteheads->item->object.oid, NULL,
+				      NULL, gpg_flags))
+			die(_("Signature verification failed"));
 
 		remote_head_oid = &remoteheads->item->object.oid;
 		read_empty(remote_head_oid, 0);
@@ -1424,8 +1425,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 	if (verify_signatures) {
 		for (p = remoteheads; p; p = p->next) {
-			verify_merge_signature(p->item, verbosity,
-					       check_trust_level);
+			if (gpg_verify_commit(&p->item->object.oid, NULL, NULL,
+					      gpg_flags))
+				die(_("Signature verification failed"));
 		}
 	}
 
diff --git a/builtin/pull.c b/builtin/pull.c
index d4e3e77c8e..e41c4032ae 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -107,11 +107,11 @@ static char *opt_ff;
 static char *opt_verify_signatures;
 static int opt_autostash = -1;
 static int config_autostash;
-static int check_trust_level = 1;
 static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
 static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
 static char *opt_gpg_sign;
 static int opt_allow_unrelated_histories;
+static unsigned gpg_flags = GPG_VERIFY_SHORT | GPG_VERIFY_COMPAT;
 
 /* Options passed to git-fetch */
 static char *opt_all;
@@ -366,7 +366,7 @@ static int git_pull_config(const char *var, const char *value, void *cb)
 			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
 		return 0;
 	} else if (!strcmp(var, "gpg.mintrustlevel")) {
-		check_trust_level = 0;
+		gpg_flags ^= GPG_VERIFY_COMPAT;
 	}
 
 	status = git_gpg_config(var, value, cb);
@@ -589,17 +589,9 @@ static int run_fetch(const char *repo, const char **refspecs)
 static int pull_into_void(const struct object_id *merge_head,
 		const struct object_id *curr_head)
 {
-	if (opt_verify_signatures) {
-		struct commit *commit;
-
-		commit = lookup_commit(the_repository, merge_head);
-		if (!commit)
-			die(_("unable to access commit %s"),
-			    oid_to_hex(merge_head));
-
-		verify_merge_signature(commit, opt_verbosity,
-				       check_trust_level);
-	}
+	if (opt_verify_signatures)
+		if (gpg_verify_commit(merge_head, NULL, NULL, gpg_flags))
+			return 1;
 
 	/*
 	 * Two-way merge: we treat the index as based on an empty tree,
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index acc01a7be9..3f392654dd 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -20,37 +20,14 @@ static const char * const verify_commit_usage[] = {
 		NULL
 };
 
-static int run_gpg_verify(struct commit *commit, unsigned flags)
-{
-	struct signature_check signature_check;
-	int ret;
-
-	memset(&signature_check, 0, sizeof(signature_check));
-
-	ret = check_commit_signature(commit, &signature_check);
-	print_signature_buffer(&commit->object.oid, &signature_check, ret,
-			       flags);
-
-	signature_check_clear(&signature_check);
-	return ret;
-}
-
 static int verify_commit(const char *name, unsigned flags)
 {
 	struct object_id oid;
-	struct object *obj;
 
 	if (get_oid(name, &oid))
 		return error("commit '%s' not found.", name);
 
-	obj = parse_object(the_repository, &oid);
-	if (!obj)
-		return error("%s: unable to read file.", name);
-	if (obj->type != OBJ_COMMIT)
-		return error("%s: cannot verify a non-commit object of type %s.",
-				name, type_name(obj->type));
-
-	return run_gpg_verify((struct commit *)obj, flags);
+	return gpg_verify_commit(&oid, NULL, NULL, flags);
 }
 
 static int git_verify_commit_config(const char *var, const char *value, void *cb)
diff --git a/commit.c b/commit.c
index 519599469b..f8339916a6 100644
--- a/commit.c
+++ b/commit.c
@@ -1116,7 +1116,8 @@ static void handle_signed_tag(struct commit *parent, struct commit_extra_header
 	free(buf);
 }
 
-int check_commit_signature(const struct commit *commit, struct signature_check *sigc)
+static int check_commit_signature(const struct commit *commit,
+				  struct signature_check *sigc)
 {
 	struct strbuf payload = STRBUF_INIT;
 	struct strbuf signature = STRBUF_INIT;
@@ -1136,21 +1137,43 @@ int check_commit_signature(const struct commit *commit, struct signature_check *
 	return ret;
 }
 
-void verify_merge_signature(struct commit *commit, int verbosity,
-			    int check_trust)
+int gpg_verify_commit(const struct object_id *oid, const char *name_to_report,
+		      struct signature_check *sigc, unsigned flags)
 {
-	struct signature_check signature_check;
+	struct object *obj;
+	struct signature_check tmp = { 0 };
 	int ret;
-	memset(&signature_check, 0, sizeof(signature_check));
 
-	ret = check_commit_signature(commit, &signature_check);
-	ret |= check_trust && signature_check.trust_level < TRUST_MARGINAL;
-	print_signature_buffer(&commit->object.oid, &signature_check, ret,
-			       GPG_VERIFY_SHORT);
-	if (ret)
-		die(_("Signature verification failed"));
+	if (!sigc)
+		sigc = &tmp;
 
-	signature_check_clear(&signature_check);
+	obj = parse_object(the_repository, oid);
+	if (!obj)
+		return error("%s: unable to read file.",
+			     name_to_report ?
+			     name_to_report :
+			     find_unique_abbrev(oid, DEFAULT_ABBREV));
+
+	if (obj->type != OBJ_COMMIT)
+		return error("%s: cannot verify a non-commit object of type %s.",
+			     name_to_report ?
+			     name_to_report :
+			     find_unique_abbrev(oid, DEFAULT_ABBREV),
+			     type_name(obj->type));
+
+	ret = check_commit_signature((struct commit *)obj, sigc);
+	/*
+	 * Merge operations has historically required a trust level of
+	 * 'marginal' or higher as a default.  Backward-compatibility is
+	 * maintained here -- however, new users of this function should
+	 * delegate trust level verification to the GPG interface.
+	 */
+	ret |= flags & GPG_VERIFY_COMPAT && sigc->trust_level < TRUST_MARGINAL;
+
+	print_signature_buffer(oid, sigc, ret, flags);
+	signature_check_clear(&tmp);
+
+	return ret;
 }
 
 void append_merge_tag_headers(struct commit_list *parents,
diff --git a/commit.h b/commit.h
index 008a0fa4a0..a31aaa7304 100644
--- a/commit.h
+++ b/commit.h
@@ -364,13 +364,14 @@ int parse_signed_commit(const struct commit *commit,
 int remove_signature(struct strbuf *buf);
 
 /*
- * Check the signature of the given commit. The result of the check is stored
- * in sig->check_result, 'G' for a good signature, 'U' for a good signature
- * from an untrusted signer, 'B' for a bad signature and 'N' for no signature
- * at all.  This may allocate memory for sig->gpg_output, sig->gpg_status,
- * sig->signer and sig->key.
+ * Check the signature of the given commit.  The result is stored in sigc if it
+ * is non-NULL.  However, note that a return code of 0 from this function
+ * should be used to determine if the signature verified successfully, because
+ * multiple members in the signature_check structure are needed to sufficiently
+ * determine the outcome.
  */
-int check_commit_signature(const struct commit *commit, struct signature_check *sigc);
+int gpg_verify_commit(const struct object_id *oid, const char *name_to_report,
+		      struct signature_check *sigc, unsigned flags);
 
 /* record author-date for each commit object */
 struct author_date_slab;
@@ -378,24 +379,6 @@ void record_author_date(struct author_date_slab *author_date,
 			struct commit *commit);
 
 int compare_commits_by_author_date(const void *a_, const void *b_, void *unused);
-
-/*
- * Verify a single commit with check_commit_signature() and die() if it is not
- * a good signature. This isn't really suitable for general use, but is a
- * helper to implement consistent logic for pull/merge --verify-signatures.
- *
- * The check_trust parameter is meant for backward-compatibility.  The GPG
- * interface verifies key trust with a default trust level that is below the
- * default trust level for merge operations.  Its value should be non-zero if
- * the user hasn't set a minimum trust level explicitly in their configuration.
- *
- * If the user has set a minimum trust level, then that value should be obeyed
- * and check_trust should be zero, even if the configured trust level is below
- * the default trust level for merges.
- */
-void verify_merge_signature(struct commit *commit, int verbose,
-			    int check_trust);
-
 int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused);
 int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused);
 
diff --git a/gpg-interface.h b/gpg-interface.h
index 2f349f8ed5..3f619cce0e 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -7,6 +7,7 @@ struct strbuf;
 #define GPG_VERIFY_RAW (1 << 1)
 #define GPG_VERIFY_FULL (1 << 2)
 #define GPG_VERIFY_SHORT (1 << 3)
+#define GPG_VERIFY_COMPAT (1 << 4)
 
 enum signature_trust_level {
 	TRUST_UNDEFINED,
diff --git a/pretty.c b/pretty.c
index f5fbbc5ffb..c19620ffe6 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1302,7 +1302,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
 	if (placeholder[0] == 'G') {
 		if (!c->signature_check.result)
-			check_commit_signature(c->commit, &(c->signature_check));
+			gpg_verify_commit(&c->commit->object.oid, NULL,
+					  &(c->signature_check), 0);
 		switch (placeholder[1]) {
 		case 'G':
 			if (c->signature_check.gpg_output)
-- 
2.25.0.rc1.302.gc71d20beed

