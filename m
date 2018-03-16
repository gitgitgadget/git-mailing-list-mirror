Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44F801F404
	for <e@80x24.org>; Fri, 16 Mar 2018 18:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752990AbeCPSdA (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 14:33:00 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40566 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbeCPScq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 14:32:46 -0400
Received: by mail-lf0-f65.google.com with SMTP id e5-v6so12713077lfb.7
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 11:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pIePgjOyhLFXNv4ZIoHcwH5q3f0eCy6431L1h409ULI=;
        b=En8d44VPf1LuBQoETmGHSPRd6YuRvfpgjsIVlTRdW/CPe/s68Fch8TaNCMeWm6S4eG
         b1zC1/nWUOVfw4NdA8FhLhe7afKN/rlTnwqqOx3kKjkT2tFeBL5cSnsSqqnYLfEls19n
         JJ7/B7AJdgNrBv20iV6IbTICFw5sBvV/6XLfk1ru/7QezeFupcbtlvLTZbdmE/nUeDmo
         9J2ShL4aH65TEjeOTb2ufwVVRttVuxQrK4z/yHIbiMJVs5pte8YYWXsoPDd2iuYJl0wq
         hh4f9nAL+3fYrHdA1sjIyKhCWqU0Foc0Nt7Kde0QUNNMYHgPjCFA7z3pXyHby0OjRaa+
         1BHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pIePgjOyhLFXNv4ZIoHcwH5q3f0eCy6431L1h409ULI=;
        b=o/iOD7YBTyOBIHZwQ+G90t8pVqoyMQ95LpQnTKtjUa0BdCcUoBypXId5AG8R+6jAFc
         fS/ax/6kgq5TcxBF3R7oEsGF9kZf+UMU3M4Oyqb16I/5jnZ2/9cE7/B9Q+CuwKgj7e/C
         eXcr26DSioWLlFZ/313D28Mkz9wSKM36kuf7Z44xDz0sZ0tnCYj4g8assRYcX30zoyB0
         MQQZvqrrsSPIStTPUdw7y+xjUmjTrweoVcQvCQRGyVpGwtcb1NqynqDubRih1s+OABLZ
         VaHhyhFYwkc91kTPknDGca8bRiJonfrWWQjcnJItEIZ3kVi70beP5vmnCn6sfLZFDre3
         P4Bg==
X-Gm-Message-State: AElRT7GE6i+KdhxKViZvWGWgPVmRD0lVtBVpHTYjoxMcfNxgx5HUw9zL
        kyJR7DIo/nbPCvqmDi12GtWAzQ==
X-Google-Smtp-Source: AG47ELsQmmFggpasmC9KNinBlHigYai7wSEOnvBOFITbGGa2JhdZy35q9SkY3XCjsEKtiQRJR2nzXQ==
X-Received: by 10.46.118.5 with SMTP id r5mr1976172ljc.11.1521225165636;
        Fri, 16 Mar 2018 11:32:45 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j199-v6sm1033275lfe.53.2018.03.16.11.32.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Mar 2018 11:32:44 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v4 03/11] pack-objects: use bitfield for object_entry::dfs_state
Date:   Fri, 16 Mar 2018 19:31:52 +0100
Message-Id: <20180316183200.31014-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.903.gd04caf5039
In-Reply-To: <20180316183200.31014-1-pclouds@gmail.com>
References: <20180308114232.10508-1-pclouds@gmail.com>
 <20180316183200.31014-1-pclouds@gmail.com>
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
index 13f6a44fb2..09f8b4ef3e 100644
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
index 38d3ff167f..2bb1732098 100644
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
@@ -72,19 +87,10 @@ struct object_entry {
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
2.16.2.903.gd04caf5039

