Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1A2F1FAE3
	for <e@80x24.org>; Thu,  8 Mar 2018 11:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935817AbeCHLnC (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 06:43:02 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42452 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935780AbeCHLnC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 06:43:02 -0500
Received: by mail-pl0-f68.google.com with SMTP id 93-v6so3163372plc.9
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 03:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mvXifmdo45PkZJVEZOXudZ5TdqBm+K4ntSGVLuVLNdc=;
        b=AXtii7LFbxJDc1gqNt5iZej9xhRxElFF+ZoNFauZF3rpcCIF5K1DHmhL9Z8L1ZahOS
         CtNI1PB0LPi/90jbWwE2rBfWuvQtiT5XIb4UYVzvje2OPlrOzcuy7q4XuPDprM/MS2EX
         V7+DE+G35RAwY6yGlccf7HUkwQKvMCW3NGTa1SYTNcNDzbk5ryOrGYLFMZCmTjnpRpvm
         Bhn+ReLIW9otf3Ig8X0C9i9b8MBxR+OdmE/0fbuNhEuDjLsgyFDzTqypmbd+IVe0d3+K
         Bf25s+twdRffAsEe/PiADDPhlv9ZMM7P1q8j5DM/n18kcCqQmjPIfzmMSOEpfgLHx28g
         fTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mvXifmdo45PkZJVEZOXudZ5TdqBm+K4ntSGVLuVLNdc=;
        b=b7+CMzFkxWl9m0EN0RPVZp2wJty+hEA/UK3xmVRYWCq2u0+uGklZXo2a9Aoi9g4ho5
         +zzwEaqFEnnCGY9AFQNkxu10skCPkdCDT0Gfa+z2YTfsiL2mPblNgQLLKy8AXpiOJWYJ
         vJs2ko8DNpkotAtjzsDcMPgYcBSJXGKgDKiFh96/1OHmZaCszIo75np19Ii7qMY6jPQd
         VtjrR9fGGEwEDiF7mRNLIZH3kesJitYUmVR5zATDti0aohFsBD+/4H3i3ULgDny8pMfk
         Ucnw3V5y42UYs5U+fbYh9uv7EyIFjKTeBlw0CDHf1KrOVW5wqLKTyurUgXNugGiW4izf
         nyqA==
X-Gm-Message-State: APf1xPBEIoM9A308b9shymkNupVQBdD4mkd+RBqnL2ytgZhYajPEh4lB
        KPj2Mm3T7U5HnruQkrP5kA4=
X-Google-Smtp-Source: AG47ELs5E5d5TA3sLTQaXGSxmCoJC3ke0F+YamtdG6mQVkww+g3ZZEac2ceDlJnaRXfXFiPpL9lU6g==
X-Received: by 2002:a17:902:600e:: with SMTP id r14-v6mr24162123plj.200.1520509381588;
        Thu, 08 Mar 2018 03:43:01 -0800 (PST)
Received: from ash ([27.78.177.129])
        by smtp.gmail.com with ESMTPSA id m65sm12081860pfc.30.2018.03.08.03.42.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Mar 2018 03:43:01 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 08 Mar 2018 18:42:56 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH/RFC v3 03/12] pack-objects: use bitfield for object_entry::dfs_state
Date:   Thu,  8 Mar 2018 18:42:23 +0700
Message-Id: <20180308114232.10508-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.873.g32ff258c87
In-Reply-To: <20180308114232.10508-1-pclouds@gmail.com>
References: <20180303024706.31465-1-pclouds@gmail.com>
 <20180308114232.10508-1-pclouds@gmail.com>
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
index 85b01b66da..628c45871c 100644
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
@@ -73,21 +88,13 @@ struct object_entry {
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
+	/* size: 120 */
 };
 
 struct packing_data {
-- 
2.16.2.873.g32ff258c87

