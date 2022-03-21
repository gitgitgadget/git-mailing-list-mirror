Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28B3C433FE
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 07:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344928AbiCUHfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 03:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344933AbiCUHfL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 03:35:11 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AA9140BB
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:33:46 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i11so11281413plr.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YqhkHQi2ES/1xSYog9B6VjOokqU4c3bhxV8BlGZFTis=;
        b=aAzOQ0N0BiIQzuDhMT5SWabmCsWeUx2hM8UeNmhXJzEbTK05ZjWCUkyCun2sw2Cvex
         dh6EoUzc2BqCyTL8CeOtcKFojRBcBUFRnkFzX746WRuWf49olW3gBAAABZ/+5v9T3v7j
         5zN4Gltw9zf8VKQ/vipJ62KQ4E619Uk5Ik/pmi2P4RatDUs+OMbOF4NoCOWXNk8m0gtR
         jyr4zDshC/moJTC9LVv99Jk43DR6TtG4OB+YdTLtLTpaXaekTAm5aQqVLaOb80RS+k1p
         HuS7VXQuNJZKEyfRAEXEYv5ykz7PSeEh8VwNuVDQe5KLzlqz9iU06PtaOwZ6Stw9lsVs
         A8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YqhkHQi2ES/1xSYog9B6VjOokqU4c3bhxV8BlGZFTis=;
        b=0ooRCe5HBfa6/eNUZUyzWV5xD1CVeJWkkaZNlGgT731m8LwNannnPJxgwp1CZZ3vrs
         IYlZIrBxCfwDn2k/edxRPiv4MBG7QhbN3BT1OYV1Opuv91noxJlwZaLP2vyOj8H0HDt/
         xoh+v0FmoKKmGyXVm5b0LoN00spYAwrgGP4FCg03zfvgaZ+QVEefV3Rq4/Rbw5/gy19v
         NT3tVXODUg1tytNb3ALlyO7VlTB9PHuee7gQNPE3o/NnV0ZrAnOBMyNEEhneqgH9zKSP
         dzhd04Cc8lpD56h2hkYs0Pp5u0dPYkII2gx2XJ4oeBhD0mVZIyFv7Mxcr4kbYuzyMf2K
         ns1g==
X-Gm-Message-State: AOAM533ncmJGqSkM39IMhLOgnqBZum6uLgNEAuoEhG7r48yPSjb36OHo
        9ScFjWDLC+miv3R8s5jegdQ=
X-Google-Smtp-Source: ABdhPJy/Jb1TjmMQ3jba3F7wyfJrCa7jtxnK6woGwVaPAT24cosjSq2ySBZdKmNpaj60IWXb4WMoKg==
X-Received: by 2002:a17:902:7613:b0:151:6e1c:c49c with SMTP id k19-20020a170902761300b001516e1cc49cmr11588073pll.109.1647848026126;
        Mon, 21 Mar 2022 00:33:46 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.46])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090ad20600b001b8d01566ccsm18914422pju.8.2022.03.21.00.33.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2022 00:33:45 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v13 03/16] ls-tree: use "enum object_type", not {blob,tree,commit}_type
Date:   Mon, 21 Mar 2022 15:33:17 +0800
Message-Id: <208654b5e2aebbe988b5a8f478869253a0166e9b.1647846935.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.406.g2e0e55130e
In-Reply-To: <cover.1647846935.git.dyroneteng@gmail.com>
References: <cover.1647846935.git.dyroneteng@gmail.com>
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
2.34.1.406.g2e0e55130e

