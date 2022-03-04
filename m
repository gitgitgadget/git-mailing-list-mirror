Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F25EC433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 10:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbiCDKn5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 05:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbiCDKnz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 05:43:55 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2301AAFD7
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 02:43:08 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gj15-20020a17090b108f00b001bef86c67c1so7489092pjb.3
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 02:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u4mT1w8IjJ/aU+qFaSkCiTjcZvoTAWMzGcwVXfgZrOA=;
        b=E3O88OU6wpU9+YpfkyK5PPKs+7icj0DaQW8ZOIxtZJAhOXBnMb8/gI/R/DQ2vAgVPS
         6R1xsWONzLCXJhcX/DbOnONzCcd/r8Jiav56B+j4GlJG4mT2cS4r7pm6tl17EfecIyKY
         bU1tzdel0eBKi+W8GaIE4XnY1sXZpiX0JxgT4LtMBwpJQlmMPUw4x38mY9jhtl3P2gQY
         UNEf+oaIO8+in7vXzMAL79RAoQ5knMfjEwZUCBfwRbeLj6HX4YOWUkxEL78GCbDwZ+kU
         Jr8sSxRnHiQBgSY0XkeVMqyBUaqTv69atOTDBHk1JSOnJrOw7hgKsWRmAhr9ghmfQ3h7
         GzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u4mT1w8IjJ/aU+qFaSkCiTjcZvoTAWMzGcwVXfgZrOA=;
        b=EmIRp+kvagsnB/YIV8iB0Gu/SBp/pOiJ5IRq58zZvbqnzJVMpwISGlJXbeZFfZg7XF
         KcSUJBIpwScoYYGxjFMZP+eUF6YOULyyNeF9ML52KujRzdtgbMqkV4dpRgBx2jODCBg2
         KJhfRcVqDEKNFj1yta263ri8Csf9uLlq5S9dIU4auhvZ2D8x4UKkQdc/PyNoelSOrGfl
         IxTItu78om51CeG8+6Ij9U0u1ML7VBno78ISie8ktz4/xBQkyO7qetbFD+WFC77j4nQZ
         IOnmG34xR4juQ7QHScRLp8qJPB5DY1MTnrrAAFY5wmV0ys3HDGeAPsJccqXFnQvWazVP
         dMEQ==
X-Gm-Message-State: AOAM532y+GWbq2oaeyKvxT6vB1stEkEwuSD4SAsj08M/JPqCWcnBLeke
        5nkBEWIUFlwB8jl5SjmYzrbAyh3PNECMG0D+
X-Google-Smtp-Source: ABdhPJwBpg8uSPid7EpMtSh5NsqTrTxbmBvnB8BkGN6SRo7HVrdhQIBgYZx4JOhR9yV1ocHPGMveog==
X-Received: by 2002:a17:90a:ccb:b0:1bc:e520:2284 with SMTP id 11-20020a17090a0ccb00b001bce5202284mr10119804pjt.66.1646390587891;
        Fri, 04 Mar 2022 02:43:07 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.53])
        by smtp.gmail.com with ESMTPSA id k7-20020a6555c7000000b0034e101ca75csm4236253pgs.6.2022.03.04.02.43.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Mar 2022 02:43:07 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v12 03/12] ls-tree: use "enum object_type", not {blob,tree,commit}_type
Date:   Fri,  4 Mar 2022 18:42:29 +0800
Message-Id: <208654b5e2aebbe988b5a8f478869253a0166e9b.1646390152.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.402.gef0f5bd184
In-Reply-To: <cover.1646390152.git.dyroneteng@gmail.com>
References: <cover.1646390152.git.dyroneteng@gmail.com>
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
2.34.1.402.gef0f5bd184

