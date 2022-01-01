Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9060C433F5
	for <git@archiver.kernel.org>; Sat,  1 Jan 2022 13:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiAANvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jan 2022 08:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiAANvH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jan 2022 08:51:07 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3E0C06173E
        for <git@vger.kernel.org>; Sat,  1 Jan 2022 05:51:07 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so27905837pjq.4
        for <git@vger.kernel.org>; Sat, 01 Jan 2022 05:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GUvYzVB4cQw1FLm5YyU7PNKurJ532d3yDoFS0YyM2ig=;
        b=QZnfdFnA4te/cEMR5ZXe9QuM/ajOxVSAJ3vWjgr3b5nka08f7ZavghqLintg3O6L/7
         IqUVy/trVhO8wAC4oECuLTJi3PHKmmhCtcIkHxUAKifKUOMBiOrRqMEuqpDWa2HndzTL
         D3Ow6y7lEPB6rK02uri1Kg35dxo5+EFy0SlBiA7SguPQb3OlUfjdTEjlCnsb9ZLonVjP
         E82nmuKDd2mw6AjEb9llXMxQ0aMxj1CVOimQLE4lXbrOaF/foszHpV2MJ8Kt8SD8ghLT
         IIPaUtXee8k9mD7v8NzTdrcopZwltPGNITwIYpYwNFTfArQKljO19PN3csGVR0awljor
         T2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GUvYzVB4cQw1FLm5YyU7PNKurJ532d3yDoFS0YyM2ig=;
        b=i0fJXe1DuaVagMV44l4C2FIqSa6kxB6WnkBrLCbZojlY9O7hrikeTUG8lTAnfG2dXP
         9LGNVs7HIG1yLXmI3K013pHiNF80BPErMv15jYa6YGTseUvwkHZLYZx81KSm8uIJKu3x
         78sh2K1u+mK9B1D3D1X4UzhQLjvSwJdtTqiXbYBHDFQymLItqjlgw73/upvqC+ie2yE0
         /g6cSzOc3kxCW3iqoFSF/8+A53pd+PNkW5/lszM6eHnB64F8rZ9KJhO7o27kkLIKsZop
         Gs5BwHPUXa0RI1oCdjJfNzY49hoPQACi1rbpTYXd4ex4xLK2+C50Y+MCRqd/fsdYDalc
         ADEg==
X-Gm-Message-State: AOAM530VGZrf6bt/Z2ERV0c/rY272u3Tqx+0JFaA5/uyfA8KrFOc/CN1
        9M/LnAPiVmTSmScEkcUZJOE=
X-Google-Smtp-Source: ABdhPJz1bsdln2lUbscuVVesOEu8p9IIPrncW8+tBFo2d0jNWnY0kMvr4J9ijamaQM2l/3RahOT09A==
X-Received: by 2002:a17:90b:3889:: with SMTP id mu9mr41607218pjb.215.1641045066645;
        Sat, 01 Jan 2022 05:51:06 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.41])
        by smtp.gmail.com with ESMTPSA id o11sm34022039pfu.150.2022.01.01.05.51.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jan 2022 05:51:06 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v8 3/8] ls-tree: use "enum object_type", not {blob,tree,commit}_type
Date:   Sat,  1 Jan 2022 21:50:26 +0800
Message-Id: <208654b5e2aebbe988b5a8f478869253a0166e9b.1641043500.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.1802.gbb1c3936fb.dirty
In-Reply-To: <cover.1641043500.git.dyroneteng@gmail.com>
References: <cover.1641043500.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Change the ls-tree.c code to use type_name() on the enum instead of
using the string constants. This doesn't matter either way for
performance, but makes this a bit easier to read as we'll no longer
need a strcmp() here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 0a28f32ccb..3f0225b097 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -66,17 +66,17 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 {
 	int retval = 0;
 	int baselen;
-	const char *type = blob_type;
+	enum object_type type = OBJ_BLOB;
 
 	if (S_ISGITLINK(mode)) {
-		type = commit_type;
+		type = OBJ_COMMIT;
 	} else if (S_ISDIR(mode)) {
 		if (show_recursive(base->buf, base->len, pathname)) {
 			retval = READ_TREE_RECURSIVE;
 			if (!(ls_options & LS_SHOW_TREES))
 				return retval;
 		}
-		type = tree_type;
+		type = OBJ_TREE;
 	}
 	else if (ls_options & LS_TREE_ONLY)
 		return 0;
@@ -84,7 +84,7 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 	if (!(ls_options & LS_NAME_ONLY)) {
 		if (ls_options & LS_SHOW_SIZE) {
 			char size_text[24];
-			if (!strcmp(type, blob_type)) {
+			if (type == OBJ_BLOB) {
 				unsigned long size;
 				if (oid_object_info(the_repository, oid, &size) == OBJ_BAD)
 					xsnprintf(size_text, sizeof(size_text),
@@ -95,11 +95,11 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 			} else {
 				xsnprintf(size_text, sizeof(size_text), "-");
 			}
-			printf("%06o %s %s %7s\t", mode, type,
+			printf("%06o %s %s %7s\t", mode, type_name(type),
 			       find_unique_abbrev(oid, abbrev),
 			       size_text);
 		} else {
-			printf("%06o %s %s\t", mode, type,
+			printf("%06o %s %s\t", mode, type_name(type),
 			       find_unique_abbrev(oid, abbrev));
 		}
 	}
-- 
2.33.0.rc1.1802.gbb1c3936fb.dirty

