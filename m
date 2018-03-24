Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 826CB1FAE4
	for <e@80x24.org>; Sat, 24 Mar 2018 06:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbeCXGeO (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 02:34:14 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46078 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbeCXGeL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 02:34:11 -0400
Received: by mail-lf0-f66.google.com with SMTP id l4-v6so16932279lfg.12
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 23:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KaD0VgjDU7BQyAaqVf6MqUX/kNaGoDDcVGuM0oT9Kqg=;
        b=vJkWULYIxWb9/UmCqQQuxxSVDS7LDtyWyiik3joEpXqnV/3ykZdjo9ZFplmkKu1ooG
         eCdQ/f6Ki/y+mv7vUXa4C9qhJ5mmyQWh8Cup0Vx/+FqvdG85X86jpfdqUrtRGFnsjMUA
         qP6ZHJ4drk0go6adHMJxLiQfmMhmo2pgDdIodK40lrq9b92itehZFneUDO0c44JL0g+6
         siRK421KRkeeVoJyqW8Xf4RMhyQnvDhG6Ib7SnK+XqjlkuDBl9PuGJU0I1ALDga/XP5L
         LstR8wGxUFX28HiEPu8h7jxDvnpnkzDsWY+bN8dF3r2Nrg/I0/zQYd819vokzRaeJlUR
         TgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KaD0VgjDU7BQyAaqVf6MqUX/kNaGoDDcVGuM0oT9Kqg=;
        b=qkY0G8v0Kmg5dDEunyPuMQ8zo0/TrQe/XJ+tWHVtAMrhzzfevQh5X1yYnTTmLZqgSr
         G4MWXEF/ey8H3ZrCfrg+E3iICqaWko5yC9i1X+KXvIpG/lj6WWO/tfrmP0V9szL5v6vJ
         PXSiTRc/LJbf3cyyPgMgaxavsCXxxIohpv9elg11BXP3OoOy2vveURyoR+t+fSzEMVIb
         ZbkKCuuva1pFcelb94boYES9aJM/ml5NsE62L4Lqw9K2xBS4kOZc9LYq/HTvI1mgsCcO
         y9UoV4ZsbvSLObLZfffzsfFYRxERsvim2mMc8skIP/wQljnJu5BAnxp3xdLD4B2aRPc9
         Rq8A==
X-Gm-Message-State: AElRT7G2aSWp/Gh/T81LXx7fozCwycpj6I/ZsY3z0NeYeOOepY+UwfIA
        VJqPou6S71DecDEbfOLMb+I=
X-Google-Smtp-Source: AIpwx49oaXK3ExJOQp+m4wMiCBSUDLcWlFDh+ZkTqnkTCMdbn4uIranwGBKxpPRtZ4QXHRdGBIXuPQ==
X-Received: by 2002:a19:1619:: with SMTP id m25-v6mr4194713lfi.17.1521873250048;
        Fri, 23 Mar 2018 23:34:10 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h8sm2251703lja.41.2018.03.23.23.34.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 23:34:09 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v7 03/13] pack-objects: use bitfield for object_entry::dfs_state
Date:   Sat, 24 Mar 2018 07:33:43 +0100
Message-Id: <20180324063353.24722-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324063353.24722-1-pclouds@gmail.com>
References: <20180318142526.9378-1-pclouds@gmail.com>
 <20180324063353.24722-1-pclouds@gmail.com>
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
 pack-objects.h         | 28 +++++++++++++++++-----------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 647c01ea34..83f8154865 100644
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
index b883d7aa10..8507e1b869 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -1,6 +1,21 @@
 #ifndef PACK_OBJECTS_H
 #define PACK_OBJECTS_H
 
+#define OE_DFS_STATE_BITS	2
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
 /*
  * basic object info
  * -----------------
@@ -73,19 +88,10 @@ struct object_entry {
 	unsigned no_try_delta:1;
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
+	unsigned dfs_state:OE_DFS_STATE_BITS;
 
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
+
 };
 
 struct packing_data {
-- 
2.17.0.rc0.348.gd5a49e0b6f

