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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BD7C1550B
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BAB86523C
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhCHPHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbhCHPHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 10:07:25 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEE1C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 07:07:25 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d15so11824544wrv.5
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 07:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w+QpdmLliqbSLlapaOlfBFBxLUjIso5zyUbCIrHEZxE=;
        b=eNXlkHAQOkgzZHSmnsuWKG7kYPa7Ox/DDl8wlZra7UiicqyhabQBWNMpDkRe2co9qV
         fOb/XFTCw+EZMS7JYxhJPrD49c3eXtb5AFo2qPwD/Y7bRWmKva0db7so5VUuSu8E3dKl
         H/E8EEubM/+xsZMNdYbtSYwjGT+Yq/4//KQxfcSr5U1xjz4ba9Gj6REB/uH4/35IfHz8
         m4IY6nOLHpK+ZS9Vgnyei+vTTgd/lUR57rtni9/WPggx99nzLeh5GzCNZzpEP/+jOvDj
         s31Dsk0K8bMDeXQ3uOpm2OEeBmedsg/E3v3w/r2zHLM5F5T6ljXRY4PF64vMCjNKnQDF
         1XmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w+QpdmLliqbSLlapaOlfBFBxLUjIso5zyUbCIrHEZxE=;
        b=amQdJ8KM6zwnMv1sFS6I8Fc3Izcq4YDtKFCd10NS8xaZ1spHQZdv88MLthClIqmEhz
         6zgCKUVhz4CSutL4eEEhnXGwqcV0Dc0MUmNq63fntTvDnG0rOMOP1QpkENWlbuwdHi4z
         1/wAR2l/l2SvXiFV6z06USkIxpuSz/M0mwolcfzxvhj8FWiZwMHjFYvcXYL0sa63W5t/
         /PQcQHRE+blB62pvs/AYe1iLcsuV4thNH7xZmFMch9Ts63cHxhLhqpEkZ3sPiyD4U2bb
         iGF6gT47V3Xkk1JZh1/EJcWJtBWMrh4D9cEgWfRA8NwBVU0upx9ilmurpEuF4ciIHel2
         k+mg==
X-Gm-Message-State: AOAM532vtSO1wRBARwP+KnUp6irD0s4czxTwrHVhBCA/yeSGo3IpNYfr
        eVgh3lpoi8FGaGj8CLywewIZHpmD1TeWeQ==
X-Google-Smtp-Source: ABdhPJzKYrSzfwlqqV9EBLASW6e1irJ3fEDzfl9Mcfig4VS/6xkcNuURLXRd2vfnT8hx4L55ckdVvg==
X-Received: by 2002:a5d:6989:: with SMTP id g9mr6627209wru.198.1615216043857;
        Mon, 08 Mar 2021 07:07:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm3820488wrt.29.2021.03.08.07.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:07:23 -0800 (PST)
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
Subject: [PATCH 19/30] tree-walk.h API: formatting changes for subsequent commit
Date:   Mon,  8 Mar 2021 16:06:39 +0100
Message-Id: <20210308150650.18626-20-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
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
index a5044fcfaa6..83babc41d08 100644
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
2.31.0.rc0.126.g04f22c5b82

