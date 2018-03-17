Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DE651FAE4
	for <e@80x24.org>; Sat, 17 Mar 2018 14:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752897AbeCQOK5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 10:10:57 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46872 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752662AbeCQOKu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 10:10:50 -0400
Received: by mail-lf0-f65.google.com with SMTP id w16-v6so19276158lfc.13
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 07:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2vanK63ovmMAobalZClia16hiU+4b0oRtrjBzP7/fWc=;
        b=j3euxO2o1Pp2kUtbdLTGqPR0rQZI85IcDtkI0FG7NslnvW27BnAtqfUU14imqLK597
         q9O8It4hNC+Yi2QG1NkCrA7t7woJkUpSdlifVR6lhddfchHxZyndkrqjvkGAlAK0OcfE
         PvYvqOFo4278EEO9iUZ3aZM7+CZslDN4o2oGvzQbvw1rUhT3HkToW1HegAzjM7//Gedu
         UihdUeaXqZuf6WaPUvJpWLPidhfl9NzeCPcSiJYXMkiqhBi8Nxyddcg8y/cEWGgFm+sB
         chq2j0/XGtve93m+iDDOZvcK8qQIOgYUkthQKnotYyK5PH3TvMjyopYpKWxV2ay2youe
         V6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2vanK63ovmMAobalZClia16hiU+4b0oRtrjBzP7/fWc=;
        b=Wlne/Gv6G0pkje81CvjR93RMmtOnkGFP9JAndazYvy71G+kdDmjuR+bYXnx7ADAvkL
         yRwCTCKxwIra7gMt9yznENaYmLHaiEMMkVRl9bMM3jaw8bj3xw4frAwZjSEpJmljFevM
         MYztyOaHz8X5LZcMYSTzZtJP9v4+clwH/HrA3G6ZzzGep99JPDM875dXCw3tG1P3vytb
         rCOmI7kvZvnrm31kJPc/VamqHi6WbgOWfCsHz2QAhcqyBdyQ7ocS1FyHctY8BY0uImGv
         +AEMbCK4xk1G6rsuarg/G00AmJFa5lmqoTIzJPc1J6VvT0QTrA8OoIOQlYcKJGMI+DVg
         HB/Q==
X-Gm-Message-State: AElRT7H6os/yutfEMy6k3/FjELCLaRIgQVXy+N3MvCBDZBM7wJINNyQ8
        GfBv0DCj/PMGCFhLatFvLeE=
X-Google-Smtp-Source: AG47ELud1if+P6CYRTIzKVmPqkav5HWslEOGbBnYrYF7g2prvrcbU6xlvi1pQbgo6exBJVsfX0Sqxg==
X-Received: by 10.46.71.85 with SMTP id u82mr1297572lja.79.1521295849574;
        Sat, 17 Mar 2018 07:10:49 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f7-v6sm625648lfb.2.2018.03.17.07.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 07:10:48 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v5 03/11] pack-objects: use bitfield for object_entry::dfs_state
Date:   Sat, 17 Mar 2018 15:10:25 +0100
Message-Id: <20180317141033.21545-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.347.gf9cf61673a
In-Reply-To: <20180317141033.21545-1-pclouds@gmail.com>
References: <20180316183200.31014-1-pclouds@gmail.com>
 <20180317141033.21545-1-pclouds@gmail.com>
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
index 5f568b609c..4c6b73a4d6 100644
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
2.17.0.rc0.347.gf9cf61673a

