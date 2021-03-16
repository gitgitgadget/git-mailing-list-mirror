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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A2EC433E9
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B24B0650FD
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238286AbhCPP7k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238262AbhCPP6y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:58:54 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3652C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:53 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id d191so10369266wmd.2
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iCYR4UnUBybvwWKfU2mGCHe39W9o9ieG+hvRE1W+5DU=;
        b=Uottwc5lEJ8KGL3GNTRU0LbZEpWF/qS9sAyH+y3qZptpw9arrI9TrIBxHqtgchqirG
         l+hJbUSixYO76sLKCO6TYjRra3fMC7JTGEo+ZF60p58no0WytVYIWrSmpKBRF67yaS7W
         8G/IpCUE3WAtCXkEYNSyDUxPob+KeQaDXQCt3xFUc08HIsOEgy65rj7Ef85wmkOGmDXB
         hj7JylQzg9RhmP81+hQzLpA1f8nw3uL/PHTJCrPaBrStgFgPvUEtljiw4lT/StYfxT+K
         wjBB9DA4XCokXbkqNoKZ6y8h29Oy4wd7SvMZp2GAKFIGoOSVQu/ibpg4LSNexwwjW58a
         EgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iCYR4UnUBybvwWKfU2mGCHe39W9o9ieG+hvRE1W+5DU=;
        b=fzpQ3reSBguquFD1DxlAcqlieZ4/J4fqsk/ZtTg0RdljgGHdOdbsLbTX7VuOvSpk5N
         WCltNWDJWfyYQ4v/XSGad84RohMqW2wyELVtLo/JRdii75xYSY0/yUHNcmGZDG1o6XiX
         lo44WV3+MwO2PM1htJwKNaMktaGC2G8TFO4YE7vYtco8cLRS7bqmGXvU2DXC/zmjFXm9
         L8DLvoXc5rAyg362eelklkCYjkhWgfyRZzpxUcclIdp5vyS7JxzuGyXp8lPrspr4Txz1
         S+NevK8HLbWq1HMfH7c7It8O3Dqiz8PH+YfcOtdwmoHjZ8xDpj25WvMdVMHZyywse0BU
         aWiw==
X-Gm-Message-State: AOAM530r9D8tUls7SAwQMUdPo0Ihtd7/6BM82EcIfI839v3nPMNE3CNu
        Z/PQra+/dFCXFFvny6ImRF+j9zjgZ7d98g==
X-Google-Smtp-Source: ABdhPJxaAUl0tH1GSBudONbFUul0p/36aZgg8ZA03M2eBdCz1/pelKkhNf2VhMEvigCPGAD5trwBVA==
X-Received: by 2002:a05:600c:4f4f:: with SMTP id m15mr303402wmq.29.1615910332477;
        Tue, 16 Mar 2021 08:58:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m132sm3439060wmf.45.2021.03.16.08.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:58:51 -0700 (PDT)
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
Subject: [PATCH v3 16/32] tree-walk.h users: refactor chained "mode" if/else into switch
Date:   Tue, 16 Mar 2021 16:58:13 +0100
Message-Id: <20210316155829.31242-17-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210316021312.13927-1-avarab@gmail.com>
References: <20210316021312.13927-1-avarab@gmail.com>
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
index e19589baa0..37434ba89d 100644
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
index 4984bf8b3d..7ba757244e 100644
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
2.31.0.256.gf0ddda3145

