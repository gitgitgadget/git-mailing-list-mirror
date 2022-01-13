Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE97C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 03:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbiAMDm3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 22:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbiAMDm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 22:42:27 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1480AC06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 19:42:27 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id u15so7667118ple.2
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 19:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pmZI9YoLhRPKFtW+CoSYeM/MQUzBxsyZVt0ENVu7K1U=;
        b=NwjQBkKtazJeAuCU8wWuWQeV47n/ytOWNezKNQJLVi0NNDvypVQYIC6TATqwVpZSHU
         WmPxtSv2Tz1JM7nMT9Vphb1Drd+qRTBzDL/VTlbVKtED+9rFwTH/STTDfipf92lZgWq4
         VrkJe72TAtNUQzv99+Hfa3HL6Ax/0Stc4u0Gz90reFOJMjRFMkn7CSQNYEV3REwh3/b4
         IkWpTbi6SQckllNE7HfLn84a7nIyAtwEigd3QZ4ve8rXa+7bgTgvYJNL41/G4/yqwVBO
         XJgYL5r67nw2fAwf1g8fOJV/qZiKoGKJeWMEuvi9OXh5huOIUaH+AfV0G+SWLN95fiYz
         MsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pmZI9YoLhRPKFtW+CoSYeM/MQUzBxsyZVt0ENVu7K1U=;
        b=JchtXe75yH6fPjfX+POws2u1rjQLepHsDh2Uf+Jg41FUNr6mgjEuymkKnvRHUzUTuZ
         Ed1+4Z/FzK/jYtSs4F9jSMfiHpfhCyt4MQaijREzLHkF2lQXIG2ohj780rlZPR/VRYuO
         Co7100fHDsk+SOZxNEDjDEh9T3Mat6f2d9zuKjMyslbO/AYRnU3VsrRM/R5ZNM2nEjNC
         QzIMmoacbvT7sFCG34ethdFTH8weZOFvNH2PsAmSR0IxeBF75ThfXR7oLdY/99LIY6TM
         /a05TTDQZoHZw7fHUbbP+mBtTkZPCY3g4hl7mCR47Snt2Bkrya7wPtn8u7FlG1wjItBF
         tc+g==
X-Gm-Message-State: AOAM530m+9aW7YbGFgqQ0MtYGpdeRm3oI31vh9UNkq+6+XvMWQYhn4Cx
        3m09dZpQLL7uozAWBl5LqKo=
X-Google-Smtp-Source: ABdhPJyKEYPCBTEJov/WJoQf7WPh/CEXTly3FlK/6ImXSmE+mzlh8RpUY22sguA0X+kM273fDVlmoA==
X-Received: by 2002:a17:90a:de0b:: with SMTP id m11mr12475592pjv.76.1642045346609;
        Wed, 12 Jan 2022 19:42:26 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.48])
        by smtp.gmail.com with ESMTPSA id c20sm879436pgk.75.2022.01.12.19.42.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jan 2022 19:42:26 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com, martin.agren@gmail.com
Subject: [PATCH v10 3/9] ls-tree: use "enum object_type", not {blob,tree,commit}_type
Date:   Thu, 13 Jan 2022 11:42:06 +0800
Message-Id: <208654b5e2aebbe988b5a8f478869253a0166e9b.1641978175.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.390.g2ae0a9cb82.dirty
In-Reply-To: <cover.1641978175.git.dyroneteng@gmail.com>
References: <cover.1641978175.git.dyroneteng@gmail.com>
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
2.34.1.390.g2ae0a9cb82.dirty

