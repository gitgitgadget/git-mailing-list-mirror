Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395CBC433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 10:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbiGAKb3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbiGAKb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 06:31:27 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780A476953
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 03:31:26 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r20so2591923wra.1
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 03:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2PoG9QTpcWSA71vLqn1P2r/dL7HHpCVJw0aWdAz3UAE=;
        b=JfCH1NrPp+Sh4GhmBNq1ZMuC9nYpcxEO+F8Dmch6UjfrSruHMHT/vJl0RxvKoGrGE+
         X/X9K6ZqvStCyeAtzcEMrIyUCy6SgKtZrt8E0t6164w4FHExVgu2taKKxCyPEoCkJn8A
         MKymx4HkjT+WJgbGLxyKgNYMqlpt0kUls+hwtmWtPUxIG1IKdv0jj+kOOJYYagJtj4VV
         44oMJn4IC/mDM6oyWdhmyCq0dWUHtz2N8ekuecTynB9AG5yjaEZfdBQRjE2/AFdeL0Qd
         /c4tdE6NHEqewPczxSOLrgaLFqJx1UF8+0c/UEA5A9ZGlbnBXi04fhps9xJgocXAwr3d
         QKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2PoG9QTpcWSA71vLqn1P2r/dL7HHpCVJw0aWdAz3UAE=;
        b=enFCnbMmuryptxhA0VF1Mj2uF5otky42gCDfafm90EZ1p2mW+ec8xDV2yyIzvl36nW
         fbsU8ogHDrtLsQPcruVdsscI3OAIDUgOa8xIXWZmGNp34FhdF1r8ODatt2FUlVPjcBW1
         sLVZ/qnC9qPMC8E5dph+caHyMFWj1JL6bKjWDJHkhxgpKBp+gA3NxLP3d7VshUJfFJNO
         YX0ED4RFCxOweUKH1zrhkmnSa14RPzdsscGQE0FiCTgrASrvjao2bAM+fQsbdqNMD7mh
         S2Hsbc9iHOietTg8/vKbT/23Ll9kZzgjR5NRQ93lys87QIXufX+3gb7kog8kcA0cOlnQ
         djag==
X-Gm-Message-State: AJIora9JP3kzz51Q5VXCm5tWDOufPy/7GrHht+1e53WeefoOv4Ahu8J8
        IrPO3ZT6VwNkz0/0Xc+Jtv/wHcUAOU65yA==
X-Google-Smtp-Source: AGRyM1vm+JN2yZyny6YIN6bjv+WQkRO88PAGpny6wvkQ7fsIZBSrXmFMw7GPn/DsL7l7sAymNOjq+w==
X-Received: by 2002:adf:dd41:0:b0:21b:8201:4b66 with SMTP id u1-20020adfdd41000000b0021b82014b66mr12550582wrm.706.1656671484469;
        Fri, 01 Jul 2022 03:31:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c12c600b0039c811077d3sm9712790wmd.22.2022.07.01.03.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:31:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/4] cocci: add and apply a rule to find "unused" strbufs
Date:   Fri,  1 Jul 2022 12:30:56 +0200
Message-Id: <patch-v3-1.4-49e9ccb5819-20220701T102506Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-v3-0.4-00000000000-20220701T102506Z-avarab@gmail.com>
References: <cover-v2-0.2-00000000000-20220621T223954Z-avarab@gmail.com> <cover-v3-0.4-00000000000-20220701T102506Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a coccinelle rule to remove "struct strbuf" initialization
followed by calling "strbuf_release()" function.

See extensive commentary in the new "unused.cocci" for how it works,
and what it's intended to find and replace.

The inclusion of "contrib/scalar/scalar.c" is because "spatch" was
manually run on it (we don't usually run spatch on contrib).

The use of "with strict" here will be explained and amended in the
following commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fetch.c                 |  3 +-
 builtin/merge.c                 |  2 --
 contrib/coccinelle/unused.cocci | 61 +++++++++++++++++++++++++++++++++
 contrib/scalar/scalar.c         |  3 +-
 diff.c                          |  2 --
 5 files changed, 63 insertions(+), 8 deletions(-)
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
index d9784d4891c..bbd70b17bc6 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -502,7 +502,6 @@ static void merge_name(const char *remote, struct strbuf *msg)
 {
 	struct commit *remote_head;
 	struct object_id branch_head;
-	struct strbuf buf = STRBUF_INIT;
 	struct strbuf bname = STRBUF_INIT;
 	struct merge_remote_desc *desc;
 	const char *ptr;
@@ -590,7 +589,6 @@ static void merge_name(const char *remote, struct strbuf *msg)
 		oid_to_hex(&remote_head->object.oid), remote);
 cleanup:
 	free(found_ref);
-	strbuf_release(&buf);
 	strbuf_release(&bname);
 }
 
diff --git a/contrib/coccinelle/unused.cocci b/contrib/coccinelle/unused.cocci
new file mode 100644
index 00000000000..bc26d39b313
--- /dev/null
+++ b/contrib/coccinelle/unused.cocci
@@ -0,0 +1,61 @@
+// This rule finds sequences of "unused" declerations and uses of
+// "struct strbuf".
+//
+// I.e. this finds cases where we only declare the variable, and then
+// release it, e.g.:
+//
+//	struct strbuf buf = STRBUF_INIT;
+//      [.. no other use of "buf" in the function ..]
+//	strbuf_release(&buf)
+//
+// Or:
+//
+//	struct strbuf buf;
+//	[.. no other use of "buf" in the function ..]
+//	strbuf_init(&buf, 0);
+//	[.. no other use of "buf" in the function ..]
+//	strbuf_release(&buf)
+//
+// To do do this we find (continued below)...
+@@
+type T;
+identifier I;
+// STRBUF_INIT
+constant INIT_MACRO =~ "^STRBUF_INIT$";
+// strbuf_init(&I, ...) etc.
+identifier INIT_CALL1 =~ "^strbuf_init$";
+// strbuf_release()
+identifier REL1 =~ "^strbuf_release$";
+@@
+
+// .. A declaration like "struct strbuf buf;"...
+(
+- T I;
+// ... or "struct strbuf buf = { 0 };" ...
+|
+- T I = { 0 };
+// ... or "struct STRBUF buf = STRBUF_INIT;" ...
+|
+- T I = INIT_MACRO;
+)
+
+// ... Optionally followed by lines that make no use of "buf", "&buf"
+// etc., but which ...
+<... when != \( I \| &I \)
+     when strict
+// .. (only) make use of "buf" or "&buf" to call something like
+// "strbuf_init(&buf, ...)" ...
+- \( INIT_CALL1 \)( \( I \| &I \), ...);
+...>
+
+// ... and then no mention of "buf" or "&buf" until we get to a
+// strbuf_release(&buf) at the end ...
+- \( REL1 \)( \( &I \| I \) );
+// ... and no use *after* either, e.g. we don't want to delete
+// init/strbuf_release() patterns, where "&buf" could be used
+// afterwards.
+  ... when != \( I \| &I \)
+      when strict
+// This rule also isn't capable of finding cases where &buf is used,
+// but only to e.g. pass that variable to a static function which
+// doesn't use it. The analysis is only function-local.
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
2.37.0.900.g4d0de1cceb2

