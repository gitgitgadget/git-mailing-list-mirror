Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C32D01F576
	for <e@80x24.org>; Thu,  1 Mar 2018 09:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966788AbeCAJLi (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 04:11:38 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41074 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966685AbeCAJLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 04:11:25 -0500
Received: by mail-pg0-f67.google.com with SMTP id q27so2061077pgn.8
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 01:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OjpbQPqDE53cq7w1mRyKRvaHRrQw+I9IyjbJ9Tj+c/I=;
        b=UWibEXVlnYTyEEVqFkSAJVu71teJSwUnkusjfN+j2mS+/J4//9jJDlmGWiezZtzcdE
         ecySp8vVIFXAVY9olyZzSY6QwOoEr4xaCmIHv3gcvxHiuitS6Qi2tv7fqxImln05Mh3T
         r3oZ1pw+ZabP0hnzs21VFk4qajRSnzMZakPlBqQbzxijcH+sgZIf34FvKqpcoCPu806R
         ZFiGVD4H4qY6KduiMB8LCH4WCfkmOvkwWNEIADqDlmgOreHvZV6ud895VWoYb39isEqs
         8mWuMdydgaiVVf5rE9xnSexujvO/GW9bcf1lJCfa4rnTabPGl4fGcYTgAg/GUmulGw4d
         oTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OjpbQPqDE53cq7w1mRyKRvaHRrQw+I9IyjbJ9Tj+c/I=;
        b=IpyRP/FCqWFhjrQt9Yfk57blBV4PPXLFcr5+oRYK4hW5QO/0WV/IApplke36CxKXXu
         jPrinaJIHW45vEBEp3vs2aT0tb0lEaoOEGjugEx77+g2r774r/VFk/RKWfOOcblLXYzq
         MZK8SJUTu7DVAKv+mlEy2XkbVrtT50DOgCY9cEL3HMZ3ahz+nrHxlbNjpAriJHKq9u6p
         kL6UTuUCsPJwhqHmyFae/1gO8LPNhL9FPD5Uc8w1wXuxCE36V2JN0hi5ByGgJbcBSeID
         yp3x7MyuhOtGJRaKdT/Rq+StvDBT/EU4D0mgaTFyCnHTTrEcG109iEmOPdLZAqzamOjC
         3fdw==
X-Gm-Message-State: APf1xPDzBTQ0kYAf138revg07V0eKFJDX4RmRHJ40m5KPnbulUEwJdxK
        o9PQ67ftsfh6aTTqYL3Mz5RWnA==
X-Google-Smtp-Source: AG47ELtclpqOejgBQ/D0xKPo/b0CkguqMtzkWZJnzvS99PuCHvPRUatvl6ukgPNjsySfQqn9r7q7pg==
X-Received: by 10.101.97.139 with SMTP id c11mr956562pgv.433.1519895485178;
        Thu, 01 Mar 2018 01:11:25 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id l19sm6357388pgn.31.2018.03.01.01.11.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Mar 2018 01:11:24 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 01 Mar 2018 16:11:19 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/11] pack-objects: use bitfield for object_entry::dfs_state
Date:   Thu,  1 Mar 2018 16:10:44 +0700
Message-Id: <20180301091052.32267-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180301091052.32267-1-pclouds@gmail.com>
References: <20180228092722.GA25627@ash>
 <20180301091052.32267-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c |  3 +++
 pack-objects.h         | 33 ++++++++++++++++++++-------------
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index fd217cb51f..a4dbb40824 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3049,6 +3049,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	if (DFS_NUM_STATES > (1 << OE_DFS_STATE_BITS))
+		die("BUG: too many dfs states, increase OE_DFS_STATE_BITS");
+
 	check_replace_refs = 0;
 
 	reset_pack_idx_option(&pack_idx_opts);
diff --git a/pack-objects.h b/pack-objects.h
index f8b06e2521..fca334ab4d 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -1,6 +1,21 @@
 #ifndef PACK_OBJECTS_H
 #define PACK_OBJECTS_H
 
+#define OE_DFS_STATE_BITS 2
+
+/*
+ * State flags for depth-first search used for analyzing delta cycles.
+ *
+ * The depth is measured in delta-links to the base (so if A is a delta
+ * against B, then A has a depth of 1, and B a depth of 0).
+ */
+enum dfs_state {
+	DFS_NONE = 0,
+	DFS_ACTIVE,
+	DFS_DONE,
+	DFS_NUM_STATES
+};
+
 struct object_entry {
 	struct pack_idx_entry idx;
 	unsigned long size;	/* uncompressed size */
@@ -27,21 +42,13 @@ struct object_entry {
 	unsigned no_try_delta:1;
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
+	unsigned dfs_state:OE_DFS_STATE_BITS;
+
+	/* XXX 20 bits hole, try to pack */
 
-	/* XXX 22 bits hole, try to pack */
-	/*
-	 * State flags for depth-first search used for analyzing delta cycles.
-	 *
-	 * The depth is measured in delta-links to the base (so if A is a delta
-	 * against B, then A has a depth of 1, and B a depth of 0).
-	 */
-	enum {
-		DFS_NONE = 0,
-		DFS_ACTIVE,
-		DFS_DONE
-	} dfs_state;
 	int depth;
-	/* size: 128, padding: 4 */
+
+	/* size: 120, padding: 4 */
 };
 
 struct packing_data {
-- 
2.16.1.435.g8f24da2e1a

