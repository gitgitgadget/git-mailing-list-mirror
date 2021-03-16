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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D03C4332B
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0273C65103
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238361AbhCPP75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238268AbhCPP67 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:58:59 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC293C061763
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:58 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id y124-20020a1c32820000b029010c93864955so1743126wmy.5
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6mfVU/pD6oqADQCq558uDybfj/kXtDOp8lLFUDNHcmw=;
        b=HNgTTIcxBZKoVN/oDpwQ0x5Um2wv8piTdK2ZEQFxlD5LkXbgGklLY6r80qNA9RitOf
         QSnz16PoMmdYIY6/vJQKykPaxSdQmEinpAd/Wb2NBSt8bzR5RaqOKnhd+SKSEZUPntku
         ixA0DoPApnf9edT9tGwHyBsugEk5U1yYlZ9gGe8AZ4cKonxHwQvvXyPCwXeJD87nK5q6
         +H8lEH84PHrLnCqF0xQPmJLu8Mv6T1QStrYQg4n9rdi+DMo/kl2nK6x6GfG2g6uGNg7Z
         1J77i+OBkZW4TziC4TZzWFY+nK2kM89LXgdN+Whn4BRupGmfCCg01Vyf6O0nb3N3VGL5
         Ks0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6mfVU/pD6oqADQCq558uDybfj/kXtDOp8lLFUDNHcmw=;
        b=pdjATfE/J/QusJMBQhXlCwJXFVaFsjic75ixlsgIGQa3ergU/z9Hd3/nWRGU0IcOFz
         IRld4msHz0TkwZtSXCacuVHadVMYq2jFeWJuSiq6Mdy+7PBtjph/RPaOLJBUFVCuN0ry
         X3u0G1ZUIrUCTvG/+oJGFUIe709G4LHMtMsytz1SVk8VYqVhA0uJKo2D+ai+wCGJS/Yw
         JxDmkgOBsFd8KBToth/rtT5genIjUYtZckwIo/KLkJyTEAzB/fL5bknmPv0Ktn4x0eZY
         nBfxHLR4uiP/Vv4RjNxsW4GJMQPtVuucX6PZFdkxYbk1X8a47wKwCAWbpObRAbgQezlr
         drBQ==
X-Gm-Message-State: AOAM533royVmH0u/uK7hFq0STF/q0JYr97MILzplivJ8UlSUXWIsMsnc
        XGhX1lloxlLcDw9G4jq2A90TsrlpHW73SA==
X-Google-Smtp-Source: ABdhPJwJuRvBU9xbKD6n5uqUO4Cy6iFvBN0mB6ng9qZD6NorATBV31sY9HLutLMH0aiv4f9lZugnKA==
X-Received: by 2002:a1c:7406:: with SMTP id p6mr283146wmc.103.1615910337291;
        Tue, 16 Mar 2021 08:58:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m132sm3439060wmf.45.2021.03.16.08.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:58:56 -0700 (PDT)
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
Subject: [PATCH v3 22/32] tree-walk.h API: formatting changes for subsequent commit
Date:   Tue, 16 Mar 2021 16:58:19 +0100
Message-Id: <20210316155829.31242-23-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210316021312.13927-1-avarab@gmail.com>
References: <20210316021312.13927-1-avarab@gmail.com>
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
index a5044fcfaa..83babc41d0 100644
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
index 6e9161901d..e88187e371 100644
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
index 9f3825d277..478a659ee2 100644
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
2.31.0.256.gf0ddda3145

