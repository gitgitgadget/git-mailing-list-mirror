Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3ACC43334
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 14:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiGEOCW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 10:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiGEOBw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 10:01:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB072C10C
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 06:47:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id cl1so17658925wrb.4
        for <git@vger.kernel.org>; Tue, 05 Jul 2022 06:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wntJtuIY0Of0EOdhkg0OIOENcvYpJajdqVBM8qM7ZZY=;
        b=Z/N1re5vTK7DBzRbJJO20q2CZLOjuWev/uWTvJmljhZLpSn8sMOIS+y0JloKnSBXtr
         AA/LycGCYCK7yZhgTgVinkkXDEngGngqre52Uw2S8QHECT13dtzz5oC3+J/RhV2RyNNT
         WmxZE8aPUFwD1xEjQG9N/EEykjE863x61qG2gqyAGK2THFWt9zJgwoK4yLAc0uAw51AE
         yoq1t8gikBjR5WTuv5yQd+DevbOyhqVWDheWJRcQBTXZ0tTbtUSkO1FQS8sQTeOwcQTS
         6VxOGTYiRjqpHbMdr5IxE7/hMy8OvFgEVxHf+7kLikQ+lFDNOrJbE9kdQMKOxxy9zaID
         XjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wntJtuIY0Of0EOdhkg0OIOENcvYpJajdqVBM8qM7ZZY=;
        b=H1xEiaR+CENi2V0i0dYb/TEX/1ZzoNTHBDhjonH/f1/+BNFDiR4ILgodfxWwWfq5Wu
         kbUT8jpbrEuO43v0wFhxR6ZuPj/vPV8Mk8PdWHMY160K7T7hp/kFhla33TqJgpoAFNYP
         +TqLR+V5A+2BYdiOz8lDfW3fKvdnDzgQKklIpUIL8Kv344WjjCK5QULZgXp+xT1AC3uE
         KHZHc9PxzZunwFrkWOe9A9nfM6QwCpYdX4Za3ahaluRWNF+2QqV7+gfbWSJsDYHWyEvW
         Y16jHsPoEtp0f+Kv3XDsLbBJrbC+gCgtHFu0FhXncmV54/Tbu2EdhLGtVoqN7imTUZqO
         tjxg==
X-Gm-Message-State: AJIora/4KEyF/LsLBmPwHkX0s3EL38vd6kyddtwzsZZbnGHjtq650lsq
        lYB1tv78DflzNs5gvqoHUIi7LO9EIOayfg==
X-Google-Smtp-Source: AGRyM1tbu1aOHq5XuPfYqBH/LnE2u3Ytacoof2UHe/EZtoe9MN4zqfPtUidBBbDMQn+GYk2tnnkXqw==
X-Received: by 2002:adf:ec0f:0:b0:21d:7771:c3cb with SMTP id x15-20020adfec0f000000b0021d7771c3cbmr1159481wrn.81.1657028832459;
        Tue, 05 Jul 2022 06:47:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x11-20020adff0cb000000b0021b92171d28sm40786942wro.54.2022.07.05.06.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 06:47:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 5/6] cocci: add and apply a rule to find "unused" strbufs
Date:   Tue,  5 Jul 2022 15:46:59 +0200
Message-Id: <patch-v4-5.6-d1c6833c8d5-20220705T134033Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.913.g50625c3f077
In-Reply-To: <cover-v4-0.6-00000000000-20220705T134033Z-avarab@gmail.com>
References: <cover-v3-0.4-00000000000-20220701T102506Z-avarab@gmail.com> <cover-v4-0.6-00000000000-20220705T134033Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a coccinelle rule to remove "struct strbuf" initialization
followed by calling "strbuf_release()" function, without any uses of
the strbuf in the same function.

See the tests in contrib/coccinelle/tests/unused.{c,res} for what it's
intended to find and replace.

The inclusion of "contrib/scalar/scalar.c" is because "spatch" was
manually run on it (we don't usually run spatch on contrib).

Per the "buggy code" comment we also match a strbuf_init() before the
xmalloc(), but we're not seeking to be so strict as to make checks
that the compiler will catch for us redundant. Saying we'll match
either "init" or "xmalloc" lines makes the rule simpler.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fetch.c                     |  3 +-
 builtin/merge.c                     |  4 ---
 contrib/coccinelle/tests/unused.c   | 55 +++++++++++++++++++++++++++++
 contrib/coccinelle/tests/unused.res | 30 ++++++++++++++++
 contrib/coccinelle/unused.cocci     | 32 +++++++++++++++++
 contrib/scalar/scalar.c             |  3 +-
 diff.c                              |  2 --
 7 files changed, 119 insertions(+), 10 deletions(-)
 create mode 100644 contrib/coccinelle/tests/unused.c
 create mode 100644 contrib/coccinelle/tests/unused.res
 create mode 100644 contrib/coccinelle/unused.cocci

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ac29c2b1ae3..8a3ae71fed0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1113,7 +1113,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 			      struct fetch_head *fetch_head, struct worktree **worktrees)
 {
 	int url_len, i, rc = 0;
-	struct strbuf note = STRBUF_INIT, err = STRBUF_INIT;
+	struct strbuf note = STRBUF_INIT;
 	const char *what, *kind;
 	struct ref *rm;
 	char *url;
@@ -1281,7 +1281,6 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 
  abort:
 	strbuf_release(&note);
-	strbuf_release(&err);
 	free(url);
 	return rc;
 }
diff --git a/builtin/merge.c b/builtin/merge.c
index d9784d4891c..23170f2d2a6 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -375,7 +375,6 @@ static void reset_hard(const struct object_id *oid, int verbose)
 static void restore_state(const struct object_id *head,
 			  const struct object_id *stash)
 {
-	struct strbuf sb = STRBUF_INIT;
 	const char *args[] = { "stash", "apply", NULL, NULL };
 
 	if (is_null_oid(stash))
@@ -391,7 +390,6 @@ static void restore_state(const struct object_id *head,
 	 */
 	run_command_v_opt(args, RUN_GIT_CMD);
 
-	strbuf_release(&sb);
 	refresh_cache(REFRESH_QUIET);
 }
 
@@ -502,7 +500,6 @@ static void merge_name(const char *remote, struct strbuf *msg)
 {
 	struct commit *remote_head;
 	struct object_id branch_head;
-	struct strbuf buf = STRBUF_INIT;
 	struct strbuf bname = STRBUF_INIT;
 	struct merge_remote_desc *desc;
 	const char *ptr;
@@ -590,7 +587,6 @@ static void merge_name(const char *remote, struct strbuf *msg)
 		oid_to_hex(&remote_head->object.oid), remote);
 cleanup:
 	free(found_ref);
-	strbuf_release(&buf);
 	strbuf_release(&bname);
 }
 
diff --git a/contrib/coccinelle/tests/unused.c b/contrib/coccinelle/tests/unused.c
new file mode 100644
index 00000000000..495ae58ccf1
--- /dev/null
+++ b/contrib/coccinelle/tests/unused.c
@@ -0,0 +1,55 @@
+void test_strbuf(void)
+{
+	struct strbuf sb1 = STRBUF_INIT;
+	struct strbuf sb2 = STRBUF_INIT;
+	struct strbuf sb3 = STRBUF_INIT;
+	struct strbuf sb4 = STRBUF_INIT;
+	struct strbuf sb5;
+	struct strbuf sb6 = { 0 };
+	struct strbuf sb7 = STRBUF_INIT;
+	struct strbuf sb8 = STRBUF_INIT;
+	struct strbuf *sp1;
+	struct strbuf *sp2;
+	struct strbuf *sp3;
+	struct strbuf *sp4 = xmalloc(sizeof(struct strbuf));
+	struct strbuf *sp5 = xmalloc(sizeof(struct strbuf));
+	struct strbuf *sp6 = xmalloc(sizeof(struct strbuf));
+	struct strbuf *sp7;
+
+	strbuf_init(&sb5, 0);
+	strbuf_init(sp1, 0);
+	strbuf_init(sp2, 0);
+	strbuf_init(sp3, 0);
+	strbuf_init(sp4, 0);
+	strbuf_init(sp5, 0);
+	strbuf_init(sp6, 0);
+	strbuf_init(sp7, 0);
+	sp7 = xmalloc(sizeof(struct strbuf));
+
+	use_before(&sb3);
+	use_as_str("%s", sb7.buf);
+	use_as_str("%s", sp1->buf);
+	use_as_str("%s", sp6->buf);
+	pass_pp(&sp3);
+
+	strbuf_release(&sb1);
+	strbuf_reset(&sb2);
+	strbuf_release(&sb3);
+	strbuf_release(&sb4);
+	strbuf_release(&sb5);
+	strbuf_release(&sb6);
+	strbuf_release(&sb7);
+	strbuf_release(sp1);
+	strbuf_release(sp2);
+	strbuf_release(sp3);
+	strbuf_release(sp4);
+	strbuf_release(sp5);
+	strbuf_release(sp6);
+	strbuf_release(sp7);
+
+	use_after(&sb4);
+
+	if (when_strict())
+		return;
+	strbuf_release(&sb8);
+}
diff --git a/contrib/coccinelle/tests/unused.res b/contrib/coccinelle/tests/unused.res
new file mode 100644
index 00000000000..b3b71053ed6
--- /dev/null
+++ b/contrib/coccinelle/tests/unused.res
@@ -0,0 +1,30 @@
+void test_strbuf(void)
+{
+	struct strbuf sb3 = STRBUF_INIT;
+	struct strbuf sb4 = STRBUF_INIT;
+	struct strbuf sb7 = STRBUF_INIT;
+	struct strbuf *sp1;
+	struct strbuf *sp3;
+	struct strbuf *sp6 = xmalloc(sizeof(struct strbuf));
+	strbuf_init(sp1, 0);
+	strbuf_init(sp3, 0);
+	strbuf_init(sp6, 0);
+
+	use_before(&sb3);
+	use_as_str("%s", sb7.buf);
+	use_as_str("%s", sp1->buf);
+	use_as_str("%s", sp6->buf);
+	pass_pp(&sp3);
+
+	strbuf_release(&sb3);
+	strbuf_release(&sb4);
+	strbuf_release(&sb7);
+	strbuf_release(sp1);
+	strbuf_release(sp3);
+	strbuf_release(sp6);
+
+	use_after(&sb4);
+
+	if (when_strict())
+		return;
+}
diff --git a/contrib/coccinelle/unused.cocci b/contrib/coccinelle/unused.cocci
new file mode 100644
index 00000000000..56530498d17
--- /dev/null
+++ b/contrib/coccinelle/unused.cocci
@@ -0,0 +1,32 @@
+// This rule finds sequences of "unused" declerations and uses of a
+// variable, where "unused" is defined to include only calling the
+// equivalent of alloc, init & free functions on the variable.
+@@
+type T;
+identifier I;
+constant INIT_MACRO =~ "^STRBUF_INIT$";
+identifier MALLOC1 =~ "^x?[mc]alloc$";
+identifier INIT_CALL1 =~ "^strbuf_init$";
+identifier REL1 =~ "^strbuf_(release|reset)$";
+@@
+
+(
+- T I;
+|
+- T I = { 0 };
+|
+- T I = INIT_MACRO;
+|
+- T I = MALLOC1(...);
+)
+
+<... when != \( I \| &I \)
+(
+- \( INIT_CALL1 \)( \( I \| &I \), ...);
+|
+- I = MALLOC1(...);
+)
+...>
+
+- \( REL1 \)( \( &I \| I \) );
+  ... when != \( I \| &I \)
diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 28176914e57..97e71fe19cd 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -687,7 +687,7 @@ static int cmd_diagnose(int argc, const char **argv)
 	int stdout_fd = -1, archiver_fd = -1;
 	time_t now = time(NULL);
 	struct tm tm;
-	struct strbuf path = STRBUF_INIT, buf = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT;
 	int res = 0;
 
 	argc = parse_options(argc, argv, NULL, options,
@@ -779,7 +779,6 @@ static int cmd_diagnose(int argc, const char **argv)
 	free(argv_copy);
 	strvec_clear(&archiver_args);
 	strbuf_release(&zip_path);
-	strbuf_release(&path);
 	strbuf_release(&buf);
 
 	return res;
diff --git a/diff.c b/diff.c
index e71cf758861..d4290615aaa 100644
--- a/diff.c
+++ b/diff.c
@@ -1289,7 +1289,6 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 {
 	static const char *nneof = " No newline at end of file\n";
 	const char *context, *reset, *set, *set_sign, *meta, *fraginfo;
-	struct strbuf sb = STRBUF_INIT;
 
 	enum diff_symbol s = eds->s;
 	const char *line = eds->line;
@@ -1521,7 +1520,6 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 	default:
 		BUG("unknown diff symbol");
 	}
-	strbuf_release(&sb);
 }
 
 static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
-- 
2.37.0.913.g50625c3f077

