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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C83C43446
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3609601FE
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCUAC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 20:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhCUABm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 20:01:42 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BBBC061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:42 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x16so12845031wrn.4
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0SGsfSLgm+6VjfV1q/Uy3tUGdl14k4fQ03TAS4b7q7M=;
        b=pEfcxOgvfo5g6QSUbHW7MuQyblNAJI+832owZX/EHxilJ11mnZpepaC3inbXIt9/DQ
         CXEI/rPo/Xk4Py8rYIWhNhmoGKinB0jTtTC/L+U+f/U+glEV2L69KkayCzxXCdtPR8gl
         Rad+JCLKtztFkuevtxP1BgYBI//zEJQz2BqkuLUu2+F70CaswQqiFUpqJRq18ISOu1ni
         cIw4rX5FfCv1fwcB7A6bgvy3NXueq63kX3Oq2yTc8wiP489sQEJ0GTy1TL4XJrYq4LsG
         C1HJWkg04+QYOg+pjxAGXBXP59+DeBi8ijuWos16HhWhvaZCI67QDEO75fyg/HMisgsp
         Yf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0SGsfSLgm+6VjfV1q/Uy3tUGdl14k4fQ03TAS4b7q7M=;
        b=fA+ODABr2ByP60qtpb7Y3fDci/adOxeZhSX+KcW4ztMqWNah9VIO2JFvELqcjloO6v
         yIQ7vkTaom6eETu6GdIzBo5ztxA4Y6Ifyd8FrL+eyy2FQVUGAQkUjustF53lL+AvbA/C
         edLMXTfdfwrLFERwbyagn05Gy61EAeztMHo/vcVQkD4hXSh7a7JZtzZ5Jqz7hQZKRywh
         UQZ88Gtd7LJVADGW+VFgW7KWKOA8wCUl2GBbfs2vC/YJWeJzSsWSlUCF3oykRB5xvWqm
         /3PvhwkrTW/eqQcz2MC5MrxF99Ph6M/1sB8Ex9Lz20bR0DpZIjiVeB7ZIkcJXqt9HAF8
         eWDQ==
X-Gm-Message-State: AOAM532eLm+k4tXnDe0ChUdqxVg2j3PQ3ugF3TwgxO+vA2JZkqeA6P5f
        3EVxSRIH7EveF2ky8tpnsWuvzexGl71j9A==
X-Google-Smtp-Source: ABdhPJzTm/AlcaoVe3gqRuAVCPByxQ/kaSp8flQLnBuadoX7DiVtDbvhnfSkrwxpVuY0eg1te/ikUQ==
X-Received: by 2002:a05:6000:2c4:: with SMTP id o4mr11206328wry.190.1616284900946;
        Sat, 20 Mar 2021 17:01:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g5sm15304834wrq.30.2021.03.20.17.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 17:01:40 -0700 (PDT)
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
Subject: [PATCH v4 19/29] tree-walk.h API: formatting changes for subsequent commit
Date:   Sun, 21 Mar 2021 01:00:52 +0100
Message-Id: <7251654dd52ec131328ca4e2daef966dbb14f899.1616282534.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <cover.1616282533.git.avarab@gmail.com>
References: <20210316155829.31242-1-avarab@gmail.com> <cover.1616282533.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do formatting (mainly whitespace) changes of code around the
get_tree_entry() function to make a subsequent change where we'll add
a sister function easier to read.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 blame.c     |  5 +++--
 tree-walk.c |  9 ++++++---
 tree-walk.h | 12 ++++++++----
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/blame.c b/blame.c
index 5018bb8fb2c..6ed1520e619 100644
--- a/blame.c
+++ b/blame.c
@@ -102,9 +102,10 @@ static void verify_working_tree_path(struct repository *r,
 		const struct object_id *commit_oid = &parents->item->object.oid;
 		struct object_id blob_oid;
 		unsigned short mode;
+		int ret = get_tree_entry(r, commit_oid, path, &blob_oid,
+					 &mode);
 
-		if (!get_tree_entry(r, commit_oid, path, &blob_oid, &mode) &&
-		    oid_object_info(r, &blob_oid, NULL) == OBJ_BLOB)
+		if (!ret && oid_object_info(r, &blob_oid, NULL) == OBJ_BLOB)
 			return;
 	}
 
diff --git a/tree-walk.c b/tree-walk.c
index 6e9161901d8..e88187e3714 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -591,7 +591,8 @@ static int find_tree_entry(struct repository *r, struct tree_desc *t,
 			oidcpy(result, &oid);
 			return 0;
 		}
-		return get_tree_entry(r, &oid, name + entrylen, result, mode);
+		return get_tree_entry(r, &oid, name + entrylen, result,
+				      mode);
 	}
 	return -1;
 }
@@ -622,7 +623,8 @@ int get_tree_entry(struct repository *r,
 	} else {
 		struct tree_desc t;
 		init_tree_desc(&t, tree, size);
-		retval = find_tree_entry(r, &t, name, oid, mode);
+		retval = find_tree_entry(r, &t, name, oid,
+					 mode);
 	}
 	free(tree);
 	return retval;
@@ -748,7 +750,8 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct repository *r,
 
 		/* Look up the first (or only) path component in the tree. */
 		find_result = find_tree_entry(r, &t, namebuf.buf,
-					      &current_tree_oid, mode);
+					      &current_tree_oid,
+					      mode);
 		if (find_result) {
 			goto done;
 		}
diff --git a/tree-walk.h b/tree-walk.h
index 9f3825d2773..478a659ee2b 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -169,10 +169,14 @@ struct traverse_info {
 
 /**
  * Find an entry in a tree given a pathname and the sha1 of a tree to
- * search. Returns 0 if the entry is found and -1 otherwise. The third
- * and fourth parameters are set to the entry's sha1 and mode respectively.
- */
-int get_tree_entry(struct repository *, const struct object_id *, const char *, struct object_id *, unsigned short *);
+ * search. Returns 0 if the entry is found and -1 otherwise.
+ *
+ * The third and fourth parameters are set to the entry's sha1 and
+ * mode respectively.
+ */
+int get_tree_entry(struct repository *, const struct object_id *, const char *,
+		   struct object_id *,
+		   unsigned short *);
 
 /**
  * Generate the full pathname of a tree entry based from the root of the
-- 
2.31.0.286.gc175f2cb894

