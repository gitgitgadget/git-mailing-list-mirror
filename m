Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3EB01FAE2
	for <e@80x24.org>; Sun, 18 Mar 2018 14:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754338AbeCROZt (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 10:25:49 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45873 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754305AbeCROZo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 10:25:44 -0400
Received: by mail-lf0-f66.google.com with SMTP id h127-v6so21680621lfg.12
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 07:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OmfKEAbIi6WIU7d2CttL3tooXGn5B0Auo+RM3DLcJ3E=;
        b=lCVQROeDz9eZRl7pt3IF+dO9XNGNmoWfuTVaBQvKjmmZOwWTE3iufr/48ydaWQO/oX
         vVhJxIcxb2ubGqlySdxfzydd75ilD+quJSt9vhESo/B7O7CP0n0S7ZMlPlf70WQovjEO
         miLnHqrk0Zl9t1RVP2Fh+o46BYiN7yQT+0AK3Bf0RZzeScE9p6e4IfVIDzxr+YSV1yX+
         q0ZkdGcMjXgTSy+0bX4xKabX44u6VeOUKcOqZTL3yVR3//N3/hm2gIXUvMqHpA4/ClfJ
         gjAUCKmkvUrrrQQLTbKjToaaC1slg0D3w9F3E/1PJeOHNHYLy0lTXdpVHqpIXWL2XdUC
         Qzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OmfKEAbIi6WIU7d2CttL3tooXGn5B0Auo+RM3DLcJ3E=;
        b=VdOlt6cThTqEAZL96KTrWjR92nA1O6zCerv1tgc2VE6IioHfrBJ6b7B2NI3Murkoi5
         eqBmjT5+afiNhEwd/htP8CNVN7vqdPNEQax4Zys+zVvui0wI0v40mlKCA6jkbSswxtVU
         67K4+hADvUz31xi0uq85FJh4EWDAttF480Q9K01rlSec3f1aKdSlMBN4MP59QEcCFU0j
         c6uH/UL/jRrKD7l/GSCVgt0d9vaBiRKJkBCTf/y4yPdEj5SDvI1X3yyE97wH4g7E+UVw
         AjNXrzFaor4y5KZJppoNn1nhmWSGEu4VnyuWggSYZu9Lfs9XIX5d2yxpssWDO9BaY5hT
         owPw==
X-Gm-Message-State: AElRT7FWtIfHQu+c/8qg7xph6Y6a93SNDuFga/JFgAkqyYBliIBv/2RI
        Wdp0aQWuxZT0z6CNEi8KhLY=
X-Google-Smtp-Source: AG47ELtmflU6mtTwdiw0XjXN0mTn50zNiqJLyCrlkSim2icfPX3BpW+kj/UdHvafcayK33KsGAs5gw==
X-Received: by 2002:a19:280e:: with SMTP id o14-v6mr5951831lfo.121.1521383142636;
        Sun, 18 Mar 2018 07:25:42 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n24sm2551554ljg.22.2018.03.18.07.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Mar 2018 07:25:41 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v6 03/11] pack-objects: use bitfield for object_entry::dfs_state
Date:   Sun, 18 Mar 2018 15:25:18 +0100
Message-Id: <20180318142526.9378-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.347.gf9cf61673a
In-Reply-To: <20180318142526.9378-1-pclouds@gmail.com>
References: <20180317141033.21545-1-pclouds@gmail.com>
 <20180318142526.9378-1-pclouds@gmail.com>
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
2.17.0.rc0.347.gf9cf61673a

