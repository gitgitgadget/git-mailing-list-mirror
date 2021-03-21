Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D04C433F4
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C49A6193A
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhCUACS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 20:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhCUABi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 20:01:38 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BECC061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:37 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e9so12850690wrw.10
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dSsKHOwKvAaAvQHyBfVfx9V3Tq8uWNBUvqTe54FP6UU=;
        b=TdwZB9RdK1A74XT/9jtChIAwQReOxArugdXKeZAWYDI5IDXWxgbrUuI6+2h1VXcRbk
         sgxMo35eJV5WSakCLvf1411onmVkpAo+leItkGbWAuushqD5HssRj3gD29b47bdHggqz
         EZBQUGYryMRPashtyM7uGSm8xX3ra72vSGgAD0Kckdhn9Fs1fg8mdZHBxNHRr+tS3yks
         jrVglEspdVXivR5VjGblWUpLpsMvWT37eACTz1AkHiEWzOTdO5dWA/Q4qEKT61MiDxev
         4CnHYPy26v/9RluG9C+DK0H/3Ns9Zmi84Rn5ttMHJGt6ELdnT1eFbp1rx7S6Zmz+xhMi
         2xQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dSsKHOwKvAaAvQHyBfVfx9V3Tq8uWNBUvqTe54FP6UU=;
        b=N640LqIg0dEDpdWbyWFTeXE18C+zQ09q8ZCd1c2XJlaLMAKzvxdeCrRoqbdf1E7FyO
         /PCU+eixGVQZqvmpdKZkvrbzhFHYTChrgyaIa3wvLD7PBlPGKTajxL0o8+g/JUHMxTUf
         fzvJIjKk0vWcK6SXet0Jwe7tSpBXYBxkYp3BRWEVaDJcxHO7zAi7/wgViS0Oj7FLapWc
         SY98ElHwVixbqJulJQ666HqDNPBmvKqI6ZHbZSx6Z4YHsXVGMQnW/6P5pvScGUTAZBHI
         6KKVWAo893e2lEY3VLd7lRx2XKSamrhit1HdpaKSmwh/SbZpxBke6dGbiq2jx+uMaRWN
         lTKQ==
X-Gm-Message-State: AOAM532T4lOSoMnbHkZ+JEPjS5zS2uNYuM+/6CzFTHkDUE+3ztyiqhc1
        eEcW4m9eXY+jr1DOSQF+QAmT65JaPIzxsA==
X-Google-Smtp-Source: ABdhPJxowwWjNb/STA0R3wqXNU19n4J2pv0CfgFO9ecyDrwb20It2q393YOY9AlnVyBsa4tAkdhhSw==
X-Received: by 2002:a5d:61c9:: with SMTP id q9mr11051670wrv.219.1616284896302;
        Sat, 20 Mar 2021 17:01:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g5sm15304834wrq.30.2021.03.20.17.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 17:01:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 13/29] tree-walk.h users: refactor chained "mode" if/else into switch
Date:   Sun, 21 Mar 2021 01:00:46 +0100
Message-Id: <163922d427c69d6fb62dea0ed8bb3a112379c7e7.1616282534.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <cover.1616282533.git.avarab@gmail.com>
References: <20210316155829.31242-1-avarab@gmail.com> <cover.1616282533.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor a couple of "switch" statements that previously relied on
"entry.mode" to switch on "entry.object_type" instead.

This is more obvious, and allows us to explicitly handle all the OBJ_*
cases, not just have a wildcard "else". That doesn't matter for the
behavior of this code, but for its readability and maintainability.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 list-objects.c | 20 ++++++++++++++------
 walker.c       | 22 +++++++++++++---------
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index e19589baa04..37434ba89d3 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -111,6 +111,9 @@ static void process_tree_contents(struct traversal_context *ctx,
 	init_tree_desc(&desc, tree->buffer, tree->size);
 
 	while (tree_entry(&desc, &entry)) {
+		struct tree *t;
+		struct blob *b;
+
 		if (match != all_entries_interesting) {
 			match = tree_entry_interesting(ctx->revs->repo->index,
 						       &entry, base, 0,
@@ -121,8 +124,9 @@ static void process_tree_contents(struct traversal_context *ctx,
 				continue;
 		}
 
-		if (S_ISDIR(entry.mode)) {
-			struct tree *t = lookup_tree(ctx->revs->repo, &entry.oid);
+		switch (entry.object_type) {
+		case OBJ_TREE:
+			t = lookup_tree(ctx->revs->repo, &entry.oid);
 			if (!t) {
 				die(_("entry '%s' in tree %s has tree mode, "
 				      "but is not a tree"),
@@ -130,12 +134,13 @@ static void process_tree_contents(struct traversal_context *ctx,
 			}
 			t->object.flags |= NOT_USER_GIVEN;
 			process_tree(ctx, t, base, entry.path);
-		}
-		else if (S_ISGITLINK(entry.mode))
+			break;
+		case OBJ_COMMIT:
 			process_gitlink(ctx, entry.oid.hash,
 					base, entry.path);
-		else {
-			struct blob *b = lookup_blob(ctx->revs->repo, &entry.oid);
+			break;
+		case OBJ_BLOB:
+			b = lookup_blob(ctx->revs->repo, &entry.oid);
 			if (!b) {
 				die(_("entry '%s' in tree %s has blob mode, "
 				      "but is not a blob"),
@@ -143,6 +148,9 @@ static void process_tree_contents(struct traversal_context *ctx,
 			}
 			b->object.flags |= NOT_USER_GIVEN;
 			process_blob(ctx, b, base, entry.path);
+			break;
+		default:
+			BUG("unreachable");
 		}
 	}
 }
diff --git a/walker.c b/walker.c
index 4984bf8b3d6..7ba757244e6 100644
--- a/walker.c
+++ b/walker.c
@@ -45,21 +45,25 @@ static int process_tree(struct walker *walker, struct tree *tree)
 	init_tree_desc(&desc, tree->buffer, tree->size);
 	while (tree_entry(&desc, &entry)) {
 		struct object *obj = NULL;
+		struct tree *tree;
+		struct blob *blob;
 
-		/* submodule commits are not stored in the superproject */
-		if (S_ISGITLINK(entry.mode))
+		switch (entry.object_type) {
+		case OBJ_COMMIT:
+			/* submodule commits are not stored in the superproject */
 			continue;
-		if (S_ISDIR(entry.mode)) {
-			struct tree *tree = lookup_tree(the_repository,
-							&entry.oid);
+		case OBJ_TREE:
+			tree = lookup_tree(the_repository, &entry.oid);
 			if (tree)
 				obj = &tree->object;
-		}
-		else {
-			struct blob *blob = lookup_blob(the_repository,
-							&entry.oid);
+			break;
+		case OBJ_BLOB:
+			blob = lookup_blob(the_repository, &entry.oid);
 			if (blob)
 				obj = &blob->object;
+			break;
+		default:
+			BUG("unreachable");
 		}
 		if (!obj || process(walker, obj))
 			return -1;
-- 
2.31.0.286.gc175f2cb894

