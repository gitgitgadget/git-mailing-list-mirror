Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08BDC43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 22:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354792AbiFUWoM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 18:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245024AbiFUWoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 18:44:09 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C6D3192F
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:44:08 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z17so8241392wmi.1
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xylkUyyOC7NZcZNRJw2DnAsFHjqjO4yhaK2khcc0Cc8=;
        b=fgL0chAGW4XmtI+Hp/CAQSfpdN7JGWXoPCN2gXhf0kZgVdtD+NPvWWfdx2/gi0w5Td
         1stPTAj7F11ls2Nj0njwiwh6DDcehq3TB1fNshNFcfCcjocugP/LHHIXvD6OjNcPvhjF
         cH6nC78pzZiJYrSWNfzBLBROAHFe0kt1tsOd6BWEnLurYlMWXH7muTD5iJz+3kViv8hA
         DfINaBq03px6dSbQ63qFLM02nRp3xQCDrrDoJijG8n5EgWOn9UtHlSG7rKAqqv60TJO3
         UDZ66xRKRgOKw3ao5+K52cJc0+SX4EPFQr6W6pQnMclcxmrSjQUak+MIvqAkTi+fVC8/
         Fkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xylkUyyOC7NZcZNRJw2DnAsFHjqjO4yhaK2khcc0Cc8=;
        b=TCvHmBebUjxuUltuW5uRspFRepl8nVOnXqBS1yfNbKpvKnkrOxR4AiA7PCkFfiuGmb
         /8EvahHvSzWQO/KgPkjnqNOwe3ZJEnE8P1z27em9biE7gakK3WOJLH9/Oqgbn2e5cc0e
         sqhz7qdY7XovWR9KrmrW3A7VFnoqLFTkB0gI489D6sKWMkjjtCUz+fA50wTUb8VS0Ktd
         fd52VGhi2jUWv/ADrQuHN3hbcb6FSx4ApNvfVkQaDc7gppPO9rNfXBy/SVWgYvDu8sDn
         1FpOAFKLLrKsWrQtqpLScpUYrHBZK893yQMDm84GUIAOLC/jQr7lxMf013V5tZjbxU5U
         rQ5Q==
X-Gm-Message-State: AOAM531cGZwgrLTECmE8npE7DHPQMfIyMiYlZhhprXk0/ewsdGl7beWH
        p2d5Tc2U8c9UlL2o4EKw/B77mV7y7tFS/Q==
X-Google-Smtp-Source: ABdhPJyhO5r1GVWrxbNBblMBXmmY5B55U8bPlrpc/GEyJa/V5lGAkiGxtn/7r4fnXGvQ4y9lCHzWaw==
X-Received: by 2002:a05:600c:4ed2:b0:397:7493:53e6 with SMTP id g18-20020a05600c4ed200b00397749353e6mr42135221wmq.61.1655851446959;
        Tue, 21 Jun 2022 15:44:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j12-20020a5d564c000000b0021b9585276dsm4024261wrw.101.2022.06.21.15.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 15:44:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] cocci: add and apply a rule to find "unused" variables
Date:   Wed, 22 Jun 2022 00:44:02 +0200
Message-Id: <patch-v2-1.2-d14036521ab-20220621T223954Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-v2-0.2-00000000000-20220621T223954Z-avarab@gmail.com>
References: <patch-1.1-7d90f26b73f-20220520T115426Z-avarab@gmail.com> <cover-v2-0.2-00000000000-20220621T223954Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a coccinelle rule to remove variable initialization followed by
calling a "release" function. See extensive commentary in the new
"unused.cocci" for how it works, and what it's intended to find and
replace.

The inclusion of "contrib/scalar/scalar.c" is because "spatch" was
manually run on it (we don't usually run spatch on contrib).

The use of "with strict" here will be explained and amended in the
following commit.

1. https://lore.kernel.org/git/042d624b8159364229e95d35e9309f12b67f8173.1652977582.git.gitgitgadget@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fetch.c                 |  3 +-
 builtin/merge.c                 |  2 -
 contrib/coccinelle/unused.cocci | 66 +++++++++++++++++++++++++++++++++
 contrib/scalar/scalar.c         |  3 +-
 diff.c                          |  2 -
 5 files changed, 68 insertions(+), 8 deletions(-)
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
index 00000000000..45452f8979a
--- /dev/null
+++ b/contrib/coccinelle/unused.cocci
@@ -0,0 +1,66 @@
+// This rule finds sequences of "unused" declerations, init and
+// release(). E.g.:
+//
+//	struct strbuf buf = STRBUF_INIT;
+//      [.. no other use of "buf" in the function ..]
+//	strbuf_release(&buf)
+//
+// To do do this we find (continued below)...
+@@
+type T;
+identifier I;
+// STRBUF_INIT, but also e.g. STRING_LIST_INIT_DUP (so no anchoring)
+constant INIT =~ "_INIT";
+// I = get_worktrees() etc.
+identifier INIT_ASSIGN1 =~ "^get_worktrees$";
+// strbuf_init(&I, ...) etc.
+identifier INIT_CALL1 =~ "^[a-z_]*_init$";
+// stbuf_release(), string_list_clear() etc.
+identifier REL1 =~ "^[a-z_]*_(release|clear|free)$";
+// release_patch(), clear_pathspec() etc.
+identifier REL2 =~ "^(release|clear|free)_[a-z_]*$";
+@@
+
+// .. A declaration like "struct strbuf buf;"...
+(
+- T I;
+// ... or "struct STRBUF buf = STRBUF_INIT;" ...
+|
+- T I = INIT;
+)
+
+// ... Optionally followed by lines that make no use of "buf", "&buf"
+// etc., but which ...
+<... when != \( I \| &I \)
+     when strict
+// .. (only) make use of "buf" or "&buf" to call something like
+// "strbuf_init(&buf, ...)" ...
+(
+- \( INIT_CALL1 \)( \( I \| &I \), ...);
+|
+// .. or e.g. "worktrees = get_worktrees();", i.e. a known "assignment
+// init" ...
+- I = \( INIT_ASSIGN1 \)(...);
+)
+...>
+
+// ... and then no mention of "buf" or "&buf" until we get to a
+// strbuf_release(&buf) at the end ...
+(
+- \( REL1 \| REL2 \)( \( I \| &I \), ...);
+|
+- \( REL1 \| REL2 \)( \( &I \| I \) );
+)
+// ... and no use *after* either, e.g. we don't want to delete
+// init/strbuf_release() patterns, where "&buf" could be used
+// afterwards.
+  ... when != \( I \| &I \)
+      when strict
+// Note that we're intentionally loose in accepting e.g. a
+// "strbuf_init(&buf)" followed by a "string_list_clear(&buf,
+// 0)". It's assumed that the compiler will catch any such invalid
+// code, i.e. that our constructors/destructors don't take a "void *".
+//
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
2.36.1.1239.gfba91521d90

