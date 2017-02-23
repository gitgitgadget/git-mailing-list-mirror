Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 085BB2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbdBWXFF (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:05:05 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36214 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbdBWXFE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:05:04 -0500
Received: by mail-pg0-f41.google.com with SMTP id s67so2263665pgb.3
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 15:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YrCXjrnucRA81cVMa9rKdqg5Z0Y9BLznYauRFwaszBA=;
        b=V6C1t1OWhv2W4Qt7QRsfDBXYvTeB6hdEojXSRiraSs3+whe+8Z8avsBv9U6dofl5iu
         vkG12VYieAtO+IvzdShk4IM6o0FF+i9waCR5FUU3xAeHbRq8DdShip1GxDpiVe9AyZYZ
         g2cK3VEZsFtmEX6bCkzkK5VlRl/ATqJQhf2esYxd0Eh9BjfzUUti5xKbg4/dQr9ydtxk
         dxOI9ehMLKOkxiCFgQOv4Pa9yJ2jVtjEl+uLYEJHUaf5t6z5X+xN5qO3YmiCdB/7gu7D
         47RWkeSqNusHPcAS0DWj9AIMJSfeB6iBiWkfgfwDf2nxhFR9Nhh15vYDGFzTTg3jY9/N
         otEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YrCXjrnucRA81cVMa9rKdqg5Z0Y9BLznYauRFwaszBA=;
        b=MbBNGqB5WwQuIm5EnecgaujA3+52Emq5KMY5hehrPugoJyoUiRrUkeoW1qGgRJT51o
         QgeLn84z1PdouykOyvu3ovicWxW3rkQd8Hqnhv/KP2oKvmyw48SVomYo+ns8qSrJYajd
         iZfMRmaR89cC1uQutoCgcCY4CDzwW8BwnMzDgf7ZKvoUAdxGX0CNDbpdRnqTwzESxVUk
         xkee6DnV/4BjXwZio0oMylXowHiRhM/6iseMfT4WxPSa4grOc8FzYZc0RLSxpfrRXHn9
         sQC6OdwIUadTVsIIT2Vp0+lgPP+TdXq/egYbtEKqF+mdLfWr/tW75QpsYggZBHpIOvEd
         21Vw==
X-Gm-Message-State: AMke39kFNHug5W/7ipiJoufZY27w5P4aULTGdZg3UN/xqYNIhGpB0bPNUcpW+Fd3MlEa4tsT
X-Received: by 10.99.130.67 with SMTP id w64mr50329094pgd.194.1487890685235;
        Thu, 23 Feb 2017 14:58:05 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:ad75:dfc7:8a6:1152])
        by smtp.gmail.com with ESMTPSA id n63sm495465pfk.64.2017.02.23.14.58.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 14:58:04 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com, gitster@pobox.com,
        novalis@novalis.org
Subject: [PATCH 11/15] unpack-trees: pass old oid to verify_clean_submodule
Date:   Thu, 23 Feb 2017 14:57:31 -0800
Message-Id: <20170223225735.10994-12-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <20170223225735.10994-1-sbeller@google.com>
References: <xmqqlgt5vlse.fsf@gitster.mtv.corp.google.com>
 <20170223225735.10994-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The check (which uses the old oid) is yet to be implemented, but this part
is just a refactor, so it can go separately first.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 unpack-trees.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 3a8ee19fe8..616a0ae4b2 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1407,7 +1407,8 @@ static void invalidate_ce_path(const struct cache_entry *ce,
  * Currently, git does not checkout subprojects during a superproject
  * checkout, so it is not going to overwrite anything.
  */
-static int verify_clean_submodule(const struct cache_entry *ce,
+static int verify_clean_submodule(const char *old_sha1,
+				  const struct cache_entry *ce,
 				  enum unpack_trees_error_types error_type,
 				  struct unpack_trees_options *o)
 {
@@ -1427,16 +1428,18 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	struct dir_struct d;
 	char *pathbuf;
 	int cnt = 0;
-	unsigned char sha1[20];
 
-	if (S_ISGITLINK(ce->ce_mode) &&
-	    resolve_gitlink_ref(ce->name, "HEAD", sha1) == 0) {
-		/* If we are not going to update the submodule, then
+	if (S_ISGITLINK(ce->ce_mode)) {
+		unsigned char sha1[20];
+		int sub_head = resolve_gitlink_ref(ce->name, "HEAD", sha1);
+		/*
+		 * If we are not going to update the submodule, then
 		 * we don't care.
 		 */
-		if (!hashcmp(sha1, ce->oid.hash))
+		if (!sub_head && !hashcmp(sha1, ce->oid.hash))
 			return 0;
-		return verify_clean_submodule(ce, error_type, o);
+		return verify_clean_submodule(sub_head ? NULL : sha1_to_hex(sha1),
+					      ce, error_type, o);
 	}
 
 	/*
-- 
2.12.0.rc1.16.ge4278d41a0.dirty

