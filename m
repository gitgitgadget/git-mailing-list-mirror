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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780C2C43142
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D7C6502E
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbhCPCOc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 22:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbhCPCOA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 22:14:00 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F310C06175F
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:49 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j2so9643303wrx.9
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HKBmeL5mGNcpScmpi3Tdqxig2aOh0OKNdGErZBSD6RE=;
        b=MAsvXle+cc1wCL92+QEitr8ULoRQK4Jjp95HPLyBCSqWRb0N3nRS1nHxf3oA6aHDCF
         g8sD9DvNn/NJw2g11wCa8hsUT0YSeXsLXEmKvK05IEbnOTuVwbL8Gzx1Arik/1DeM0kk
         F8DnRkl0Vv776PwkKjiSjlLOsDXCYgK6bHyXJyQR4spyX6aYrbgmcFO38yFBsEk+aFO3
         vZhGsUC5D4GP4frwOFs0pW9d7WeTHS7A6IcVp89HewieIjt1nO1isBcyZqnk2FM0QDot
         wzt4ojwf3Q0fTx9Z4eII14ReZgqLadZny71zsgvGSozo8OEJ2c+O8bAUFuUIzQCb06/p
         dgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HKBmeL5mGNcpScmpi3Tdqxig2aOh0OKNdGErZBSD6RE=;
        b=qClURBaE7+md3Wu95AIGwOxjhBPovuDaXAIKPEfCa2+ryP3UZj38Oznnp8I0IhgNoy
         Ze+9PdMDAKCXah+SxYy6BadbTW9nMkgGORxa1Fg9oJXFfgToFxfZUz9cLK8JgYrx+qV7
         fYfX+mjozOoRYrrX1lA1UU5pWViX+56FHbEWmOc4I5oAfDrLneGY86AWi5oNJXOY0aJ3
         6IijzXUBnze4mkv1/wMoWBDDirNA8NQtk9/wI3jdpMETvoMyTw9ur8AmxerZ5W5BLu2y
         Al/6r/GAyzYXgvuHFggw3al57KClj4cZif8vmD261nV4AIrRSaJy/bdHTrT7PWNL58YF
         tvSw==
X-Gm-Message-State: AOAM532KPZfHo8JZ8w/2p6pHiAJJx5xeg7bVcvMutWGiwBhe8y0uNeQi
        VY3g6Cif7kXj1j1ZICbh4+ErzbrKgdgdvQ==
X-Google-Smtp-Source: ABdhPJxKcSOFMQN07DNOHPY6x+bdvkhx4fz1emEXt2/oKFgjRaOq3J47LoQY+nfCwlMqPyVPkFlGcw==
X-Received: by 2002:adf:8b5c:: with SMTP id v28mr2254407wra.272.1615860827676;
        Mon, 15 Mar 2021 19:13:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i8sm21092494wrx.43.2021.03.15.19.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 19:13:46 -0700 (PDT)
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
Subject: [PATCH v2 19/29] tree-walk.h API: formatting changes for subsequent commit
Date:   Tue, 16 Mar 2021 03:13:02 +0100
Message-Id: <20210316021312.13927-20-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308150650.18626-1-avarab@gmail.com>
References: <20210308150650.18626-1-avarab@gmail.com>
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
2.31.0.rc2.211.g1d0b8788b3

