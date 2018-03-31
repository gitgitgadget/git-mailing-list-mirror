Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 165241FAE5
	for <e@80x24.org>; Sat, 31 Mar 2018 10:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753073AbeCaKD2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 06:03:28 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43036 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752442AbeCaKD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 06:03:26 -0400
Received: by mail-lf0-f65.google.com with SMTP id v207-v6so15124204lfa.10
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 03:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k64+ES+7yOwZnueDav4NKNR5wZ8RCSdVzJ6Qw/I7+Gk=;
        b=Sv4zTqvwSyBQUNXs9P5x5+xGNij48YHh+bNFaDGSQrv4qfR2tVZo/X6dlSvAN8sSAc
         7SpCvNSAKOHH2mM5HDaImP+DRQ63f2M8wuV5+4PDorhTC4hpTP8zRqRMIMkyL7iUGijC
         ekvVtnPBsddp7h0DJyFQ0v8ZBZMso9xwrBAiuaa+C8E2F9sbVH5P7wju4XvwnR7MhAzG
         kCk8nCfVmIwak/P0ed/hLUJoOf1/YZoG5TLRWJ5N0Sw3xtlUKIy4ZK9MJxs/eh+5ax+y
         HL1dyrPal5cjP0zLt0fIAyW6PY0+nO8fNoB7t6RX21Ye5OwkZpoUf4A8Xd1iJQB8RNZL
         hpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k64+ES+7yOwZnueDav4NKNR5wZ8RCSdVzJ6Qw/I7+Gk=;
        b=SW/dcUiYCUeZkvZRhc4/u5AJgBeO4mjcObH0+7EAVzkvhvEcQRHp5BC7xeXhbslb98
         AqEAHkt4/+bHmyPpsptwhfqiWNhTh9sEFf0jAS3vb4NUqLs5PdRya4hkvrg+byEKzv5f
         tHQ4NDJ6oaqygNb7481ae23MndsXHvDTI6avYhCm0YjGcCVo/NNqHI/SPOGH79cqhB9a
         iMwjs/w2cbUEPFM0Sl+aiZFQ2X3DAZvQLWENEemlZCWuvScAyvGifDoLpeodjfy0i8TX
         Pb31f/vziOkEO5NV1fAlGrGsqyLYt5RkEIq3PiGeN1OtFcvQv5R2VLm9YrJpk5CLajqa
         O2MA==
X-Gm-Message-State: ALQs6tBkRLZZu/VeMCkSRVmfE1sXRXJXgSHei8vwWMCKZB1S9myO7owy
        320mfWF5O21yr9UiFDxn6mk=
X-Google-Smtp-Source: AIpwx48VC/YiZAk7qTKLQu9lRs97U57wiYkknKpdN9Uh9Jm+JkOLsdaf9MboqikZco2c5e0thLjfbg==
X-Received: by 10.46.46.10 with SMTP id u10mr1372488lju.77.1522490605581;
        Sat, 31 Mar 2018 03:03:25 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id a1sm1799175ljj.90.2018.03.31.03.03.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Mar 2018 03:03:24 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v8 04/15] pack-objects: use bitfield for object_entry::dfs_state
Date:   Sat, 31 Mar 2018 12:03:00 +0200
Message-Id: <20180331100311.32373-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc2.515.g4feb9b7923
In-Reply-To: <20180331100311.32373-1-pclouds@gmail.com>
References: <20180324063353.24722-1-pclouds@gmail.com>
 <20180331100311.32373-1-pclouds@gmail.com>
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
index 7133baa63f..ebb6e034cb 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3049,6 +3049,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	if (DFS_NUM_STATES > (1 << OE_DFS_STATE_BITS))
+		BUG("too many dfs states, increase OE_DFS_STATE_BITS");
+
 	check_replace_refs = 0;
 
 	reset_pack_idx_option(&pack_idx_opts);
diff --git a/pack-objects.h b/pack-objects.h
index b4a83a6123..080ef62d31 100644
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
2.17.0.rc2.515.g4feb9b7923

