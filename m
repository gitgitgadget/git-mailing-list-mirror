Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5338C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 10:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbiCDKoN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 05:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237851AbiCDKoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 05:44:09 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAC01AC28E
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 02:43:21 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id gb21so7010997pjb.5
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 02:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5pWjgLNiHsMJ9655JgBu+NQx7QZXdZDxYUYMYDeDCkk=;
        b=U67USCirV3wnvfFnAKI8xo1EFVnXrXkYo6Chhp+qxlXbyWaIR0DYlcAFJSRG2aLkxJ
         CFmQrxY14gOLI+aVYk8wqAWfsmZkjwgC6CepIrBzu/ygzK1C8y93a1rXjw4xCvpdiDY4
         ELcUzM9Y2/r6dDohZp/LSd5PISDwgHitKQZJxZ1oSZITzA1JYfyWdkDVjwfsxqH5p6Yu
         knr6+jxDNQpSlwW6lLN330ruyhO+IOzkc3YTABjtaTKE9WXlQjY8WpTZFvZYmUq8QgsL
         mVPw3byATFaGlPNWXTAueEEW8NCPfFuI0RPPPwKaiCgYtHnVygfqBX7scrOUT3JPcH75
         h/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5pWjgLNiHsMJ9655JgBu+NQx7QZXdZDxYUYMYDeDCkk=;
        b=zIrEmcCLygNIfQSz/f2lvHbahYS9w7RD950lwzHd2HX8NUP2FkT8UDi4eEN4DLYcAd
         fsiZwT8BBD2YqrQ15w6/1661ClsxRHlSVwvYo+7jxo5Yy9aDKV78IOaTDkd39EukrPuD
         74wlWyzcC6amKPW/eKdVwZ0XgthUMb7+182LUaKnhuddaIHenT29K8Ae6dhYR8LLlhbx
         oTa1oBmOjsqkEInMtJCh+vhphNgq2Ers0mkZ/aRb+HdRM/jGsSzzcblK9z8L+Jhtg/sM
         vBTnqnN7q+g+8PQEyuA+5kJgAbFeXiRt3Tl5QMHPiGZ5SNXfzUu+t9zfyG4qjaPMi4ih
         4yRg==
X-Gm-Message-State: AOAM5301bK9fPyihP1XEuzEhFcTGXuKFi1eMPhqI85au/CWN6vI1e0FB
        msJzAkydriRDgpWV3WyHllG2vX6mHqDO0At1
X-Google-Smtp-Source: ABdhPJwdLbHVHjG6m0tv2m+TkwsHvYn5RSsTYNnA3hxXli7w0vR5H3FSf92f0VOjtNOTaGCi+3vaCg==
X-Received: by 2002:a17:902:f602:b0:14f:53a8:64f7 with SMTP id n2-20020a170902f60200b0014f53a864f7mr40520671plg.151.1646390600901;
        Fri, 04 Mar 2022 02:43:20 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.53])
        by smtp.gmail.com with ESMTPSA id k7-20020a6555c7000000b0034e101ca75csm4236253pgs.6.2022.03.04.02.43.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Mar 2022 02:43:20 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com,
        Teng Long <dyronetengb@gmail.com>
Subject: [PATCH v12 06/12] ls-tree: simplify nesting if/else logic in "show_tree()"
Date:   Fri,  4 Mar 2022 18:42:32 +0800
Message-Id: <a8d9b78dea10af317b59ed2749b0732926bf1192.1646390152.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.402.gef0f5bd184
In-Reply-To: <cover.1646390152.git.dyroneteng@gmail.com>
References: <cover.1646390152.git.dyroneteng@gmail.com>
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
2.34.1.402.gef0f5bd184

