Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB14CC433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 04:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiAFEcD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 23:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbiAFEcC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 23:32:02 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA99AC061201
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 20:32:01 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gp5so1465194pjb.0
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 20:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=quPlpqJZbkVLddFnUJGmACJ58TFoAyL7YzXhu9KzNic=;
        b=Yhams3REDSx4U1dwQYd6lgFe1y6eTAePl14pwhNcvINAYMzaj4dgkvt03G2BfKAOEA
         J4VlJtE50srht3j9yGE1lGkrgrgI0s5nfjPT11sJPIa6zUoUrrmYuGatfNCyCS6/7XFC
         hDDVNLWL+z7H4RbYmjVWqQEMJT10dmwULlTr+Q6+wshdPRjwdLqY7/OojOMYFnNUALb2
         8/1d9kHJkWh90qXzev29njd6Bd61GVtN+rGfUE0wM0jkqgqQ61w1zJJnUoXSk5x280XC
         fizjxDACsUwgU7nVLkdLvrH3gCe+ZKx4F0Zf/O9S31xz6ul6Qfid2naTaQO5O6Iy8XpC
         LSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=quPlpqJZbkVLddFnUJGmACJ58TFoAyL7YzXhu9KzNic=;
        b=J6moWwLSx12dU8G6MRR9VZoWOhWmDa7kkeNfgG8r/a3pjhJmapcQNmkzV2nbNLAJu0
         mYThypbEIo2J3z2LKzfLeIcWTcDoQl2wqY5mBdGls8bFH7E/bKfg7mfjgYgY67iAYI62
         fqIbDs5/4d6EmGnWF+e+T3PLkRtDr39SUYfA0BNC/fOfzgBSxT+4P26zKkp+ayBxAyMO
         QogT3RCDmgW1C9Nc9dO9b7N7ScZrHJC+V4KMEo6GiP2rKIqIE9IegvRxJ960SwDpxavs
         asqPViv8V214vQGebEXB9qH87o14Eoo+8Mj+U52f95QZuZH253HdQtfk/YOTxZ7Wz6i+
         92XQ==
X-Gm-Message-State: AOAM533tu/ksVKbxUjmLU3d5jLw0pq3WB72ihHWWnjAUWmCLtNCdOtXY
        iN0/7UUVUO26Xk9kTGLIXME=
X-Google-Smtp-Source: ABdhPJyd1T9piKw+QbnRKq1uLWt7Llfa+CkttP+dUD1Ct9vZ+8fcmn3EQArvITpVAyNqUSeY2GhVsg==
X-Received: by 2002:a17:903:1246:b0:149:a6fc:cf80 with SMTP id u6-20020a170903124600b00149a6fccf80mr28528026plh.156.1641443521406;
        Wed, 05 Jan 2022 20:32:01 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.34])
        by smtp.gmail.com with ESMTPSA id 13sm636491pfm.161.2022.01.05.20.31.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jan 2022 20:32:01 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, tenglong.tl@alibaba-inc.com,
        Johannes.Schindelin@gmx.de
Subject: [PATCH v9 4/9] ls-tree: use "size_t", not "int" for "struct strbuf"'s "len"
Date:   Thu,  6 Jan 2022 12:31:27 +0800
Message-Id: <2637464fd8f6b8bae6c681f20c10c9fc76dc6d6c.1641440700.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.1794.g2ae0a9cb82
In-Reply-To: <cover.1641440700.git.dyroneteng@gmail.com>
References: <cover.1641440700.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

The "struct strbuf"'s "len" member is a "size_t", not an "int", so
let's change our corresponding types accordingly. This also changes
the "len" and "speclen" variables, which are likewise used to store
the return value of strlen(), which returns "size_t", not "int".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 3f0225b097..eecc7482d5 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -31,7 +31,7 @@ static const  char * const ls_tree_usage[] = {
 	NULL
 };
 
-static int show_recursive(const char *base, int baselen, const char *pathname)
+static int show_recursive(const char *base, size_t baselen, const char *pathname)
 {
 	int i;
 
@@ -43,7 +43,7 @@ static int show_recursive(const char *base, int baselen, const char *pathname)
 
 	for (i = 0; i < pathspec.nr; i++) {
 		const char *spec = pathspec.items[i].match;
-		int len, speclen;
+		size_t len, speclen;
 
 		if (strncmp(base, spec, baselen))
 			continue;
@@ -65,7 +65,7 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 		const char *pathname, unsigned mode, void *context)
 {
 	int retval = 0;
-	int baselen;
+	size_t baselen;
 	enum object_type type = OBJ_BLOB;
 
 	if (S_ISGITLINK(mode)) {
-- 
2.33.0.rc1.1794.g2ae0a9cb82

