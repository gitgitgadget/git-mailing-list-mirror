Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C67C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 07:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344940AbiCUHfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 03:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344935AbiCUHfU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 03:35:20 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6E224BFE
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:33:55 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id e3so12312202pjm.5
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9yBIuaZPOU3IJb7rGPaPtwN3Y6mEsmIG8ce5QSypmj8=;
        b=U/IVf1BZfPaSW0QEaWswkhQRLunMpATYl9dGD4CtlHA2F89MNju5j6dYHg65CftotP
         TlIkJivFZithqpu90AL5Ilw/E47SrV8KJwL9aiSsQgTl/zeMlCH2YacErBPggHSXaYZJ
         RcycVdbCYeuq9J5GINPploUYi6fsucRyjbdMfrx8S3AroOzP4G1rTOXYVzL1J4HPjipy
         zxvu0BsqEg81QxBmmLOX/FHp2vh1D8od0HekA5vO2rHKWcbu3Cy02a4OsgNYYXYof/+h
         it7R+Ay6JgoO+Qjwovzt7LoRJAUj7ZFO6M2zSGz4fUWejX7nkfSG5TWkFE2kwRunikVO
         x4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9yBIuaZPOU3IJb7rGPaPtwN3Y6mEsmIG8ce5QSypmj8=;
        b=exHpXxVfkrrOUFrzazG6Czl09pJICw4DlMqkiE0sULuof56cWTZPxOo/TKIMUpvQ0W
         qJqSoNFE4CbDn0rP7sCTco4DtRS60dw3NgMhmGZcgK5CXYKtogvFlDtJKUoU7CAPEGiQ
         h6oo1jD8Il1TjOjUdiy3tGMf+y7qE/EU5Ae2DyIps1NjBLdPnT3AE3yuTzSXmalbvw9r
         4xRZRRwEsFutZ8vMDkgvjEARWLjtVXtx2/Tvlql9XqOfsiFG1Z0ehGAH+8Nm781Pl6aS
         rs+wDReOQZCgFTpr3wST1aiRYLSJuFY2nrQywvEMtxeFPiiTc+00XSzheTlFNDP0OL3M
         n0Yw==
X-Gm-Message-State: AOAM532vEVYh2MmYj7AOshmcGV+g4KXvdZrEktb6YELlrQLA2XGDhXXw
        vBpfdVzcVO9bC0BJggWq1LE=
X-Google-Smtp-Source: ABdhPJxK59cvErLs0a1o4CJdtJTtSQhLClnOpUVilzHZ/EWy6g92dvEKI/DDf8DJGi9Yx6je7mArvw==
X-Received: by 2002:a17:90b:1803:b0:1c7:24c4:ab52 with SMTP id lw3-20020a17090b180300b001c724c4ab52mr2551205pjb.240.1647848035123;
        Mon, 21 Mar 2022 00:33:55 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.46])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090ad20600b001b8d01566ccsm18914422pju.8.2022.03.21.00.33.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2022 00:33:54 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com,
        Teng Long <dyronetengb@gmail.com>
Subject: [PATCH v13 06/16] ls-tree: simplify nesting if/else logic in "show_tree()"
Date:   Mon, 21 Mar 2022 15:33:20 +0800
Message-Id: <a8d9b78dea10af317b59ed2749b0732926bf1192.1647846935.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.406.g2e0e55130e
In-Reply-To: <cover.1647846935.git.dyroneteng@gmail.com>
References: <cover.1647846935.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the object_type() function to determine the object type from the
"mode" passed to us by read_tree(), instead of doing so with the S_*()
macros.

Signed-off-by: Teng Long <dyronetengb@gmail.com>
---
 builtin/ls-tree.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index ef8c414f61..d4be71bad2 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -66,20 +66,17 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 {
 	int recurse = 0;
 	size_t baselen;
-	enum object_type type = OBJ_BLOB;
+	enum object_type type = object_type(mode);
 
-	if (S_ISGITLINK(mode)) {
-		type = OBJ_COMMIT;
-	} else if (S_ISDIR(mode)) {
-		if (show_recursive(base->buf, base->len, pathname)) {
-			recurse = READ_TREE_RECURSIVE;
-			if (!(ls_options & LS_SHOW_TREES))
-				return recurse;
-		}
-		type = OBJ_TREE;
+	if (type == OBJ_BLOB) {
+		if (ls_options & LS_TREE_ONLY)
+			return 0;
+	} else if (type == OBJ_TREE &&
+		   show_recursive(base->buf, base->len, pathname)) {
+		recurse = READ_TREE_RECURSIVE;
+		if (!(ls_options & LS_SHOW_TREES))
+			return recurse;
 	}
-	else if (ls_options & LS_TREE_ONLY)
-		return 0;
 
 	if (!(ls_options & LS_NAME_ONLY)) {
 		if (ls_options & LS_SHOW_SIZE) {
-- 
2.34.1.406.g2e0e55130e

