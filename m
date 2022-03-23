Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608ECC433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 09:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243112AbiCWJPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 05:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239897AbiCWJPW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 05:15:22 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EBB5D657
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:41 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id kx5-20020a17090b228500b001c6ed9db871so5808804pjb.1
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LSCgYerIJoEYaQDkukdioFVpfUA46EUlOFZymoT0//k=;
        b=POTwnpL1GvjMUQLasfMYimKZpHxYFSOerSx5FLHglyXOfAR0EkL9bJPUlCDx9fsr3+
         F7BtDJDdVcfhrr0cdYO6WPgSU0AOWAPLbPOZHOVF2PlvI3zeJnBFlSCLZPpJuURGexNX
         8opXdT9HWUjpIzB1f4Yl4p+79O/sKTgUUB3SFVePI/BvxUZ7KjECGWt6Hxv/4xBfd8P2
         5wGbQ2kjkxdAJhvjn1xpy4a1oddZSDjAHn3Mo5s0mTwkMq2w7hOswpWkvAWjk/VODAMr
         Wq224aWpYxjGWwM7Lp1KN3XBqXtzX2CO6r1IQ29GsycS2iyuQgg7J5QDrklixzsHXfQK
         KpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LSCgYerIJoEYaQDkukdioFVpfUA46EUlOFZymoT0//k=;
        b=IgIcUeSbaHy3LGCRU8/0jdd8aN8okl09iaZRKEaMEd3XfCG6LjSfsFlhTEZDH8OUKZ
         tA4HI4Lb7PIjclrylFAW+FM2SZbDD2hbCUGyCc0YjNeV/bg3L9xYh+51V5QjUH0f+2an
         wiKOiRkVRwiTBL3v5Gzo8W3VWl3pJpDk1p0ytKpQqkQC24N2gL/dhS53oV4tVkrRfk8+
         xBFbZdgSqVS/vTgmu6tiZgs7ukPFEcnAM5p7ebe8DGa/EGXhGhD55rxVP218UxmUB9fX
         0k2xK825WLAnxFY7w5zwzed0ZjrpKL34Lic07TKsLbaJq7AM9nOJdhnD1rBx5C3Az22K
         +vzw==
X-Gm-Message-State: AOAM531GLev7bZA0bptmMTv2Wo1QFxHLsMhNu2nYQvoLs/i0pFHf16Vs
        W4fe9B6T5T3kTyEMWXHI0Lw=
X-Google-Smtp-Source: ABdhPJyd2JNN6yk0W3Tm4BK81Yxtp/ZKjXJtkDNirbuj1a0/Q5cqmsExDq3YZaVb0GQ57YjmSRZbTw==
X-Received: by 2002:a17:90b:1d82:b0:1c7:1d3:f4 with SMTP id pf2-20020a17090b1d8200b001c701d300f4mr10364020pjb.223.1648026820829;
        Wed, 23 Mar 2022 02:13:40 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.39])
        by smtp.gmail.com with ESMTPSA id s135-20020a63778d000000b0038259e54389sm10224261pgc.19.2022.03.23.02.13.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Mar 2022 02:13:40 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com,
        Teng Long <dyronetengb@gmail.com>
Subject: [PATCH v14 07/15] ls-tree: simplify nesting if/else logic in "show_tree()"
Date:   Wed, 23 Mar 2022 17:13:07 +0800
Message-Id: <bff68d994f70021eea92df8f72fd3fa2328f48fb.1648026472.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.404.g92931a4a2c.dirty
In-Reply-To: <cover.1648026472.git.dyroneteng@gmail.com>
References: <cover.1648026472.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the object_type() function to determine the object type from the
"mode" passed to us by read_tree(), instead of doing so with the S_*()
macros.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
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
2.34.1.404.g92931a4a2c.dirty

