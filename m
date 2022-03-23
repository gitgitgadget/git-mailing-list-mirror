Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E796BC433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 09:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243061AbiCWJPJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 05:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243065AbiCWJPD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 05:15:03 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2450275C24
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:33 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id o8so617218pgf.9
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7FH2A4tRQ1zxvREu2whUFYnsHPfNFPPnefDubuKWt2s=;
        b=maw+mFuVe0MXZ3Sf9Y7WA8WnxDTDr/vlHdMZuPA42bKnahbPTjJlcSil8woGWVMZLb
         rPiGZWjEGh6FM1z6DfZ2hSJOi3JcWlb+s0HRQQVeVFmq/z22lezylj128myB9mglbvkJ
         PqyOn5iybfu203hWzTj2m2iBG13W7Wj9lRNDcTitJLHPYySvFI3m0y7KGeSAn2V+7LUp
         9lMebD0qpSEXRpOthzk64YAdhykRn0MOgxdzZI+no0+iPAvUpSmia6mh8gKW8hcCSs24
         qCMQM07En87+sQGYJy4g0zj3vHAUi5Zc0JTIqWtBkpyPgZIFsogQLk1HN2U0v4auqbmA
         cujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7FH2A4tRQ1zxvREu2whUFYnsHPfNFPPnefDubuKWt2s=;
        b=AH6h+kS5ckOv5xKkAl2OuiMRAr916/o/qf9XoxP+bHMR6WkNjB6yNS1U1FN+Y+FCr4
         W9UigwSZpbKe9oYtzaVm5yZGpj7VXJNFTvKzbZdD5eOhOy1iNHMvRuutUm3MuEMvmH1v
         4xz//f3FeHAbcx48MVIuVDjGbh8gWGk2fj03PmmWpmWAqrVhaXWv4IGejvzoVcbZcjnw
         2JB7EYamRcdjwbhgfVs6c3/QrJXqZipiFrs7snsFHv1x+y2L3H9L1fvBMvtpr+37jPtc
         IWVtOGt5FHxL5j/2FB5WV0+TEj7HRPA4WeqIVshYT6jHjIbMEMsPUkrafMuhBl8lVqEE
         jq1g==
X-Gm-Message-State: AOAM530fkrf5sheP9A/b+5IgSdeQJX2klafe3wSoIAdcKWmBHCmMWS3W
        aC8asK6lCXImKs79gJPNnxU=
X-Google-Smtp-Source: ABdhPJwXV/ykdHzUxPHQmsXYhZxcXGp0/sx+D+FPTQwWipPaHcNRVtFuu9VrPLmcFC8al/4WRyCS4Q==
X-Received: by 2002:aa7:8104:0:b0:4fa:2091:d200 with SMTP id b4-20020aa78104000000b004fa2091d200mr33494392pfi.17.1648026812583;
        Wed, 23 Mar 2022 02:13:32 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.39])
        by smtp.gmail.com with ESMTPSA id s135-20020a63778d000000b0038259e54389sm10224261pgc.19.2022.03.23.02.13.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Mar 2022 02:13:32 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v14 04/15] ls-tree: use "enum object_type", not {blob,tree,commit}_type
Date:   Wed, 23 Mar 2022 17:13:04 +0800
Message-Id: <2b746624ece8525000c6abe3f600696ee8bd0685.1648026472.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.404.g92931a4a2c.dirty
In-Reply-To: <cover.1648026472.git.dyroneteng@gmail.com>
References: <cover.1648026472.git.dyroneteng@gmail.com>
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
2.34.1.404.g92931a4a2c.dirty

