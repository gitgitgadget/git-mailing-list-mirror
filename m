Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA97D1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 15:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732501AbeHISVf (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 14:21:35 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36831 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732433AbeHISVe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 14:21:34 -0400
Received: by mail-wm0-f67.google.com with SMTP id w24-v6so798401wmc.1
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 08:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3lfAtywDprLwkA5KSR/4YJxV5b+lUQQ7aOixWJ/WfvA=;
        b=VYMtp0vYN2ig9a8yPQVla/AGlz0olCU2dYxxnsX1h6YZM72SjmIf43opkYBy5LoVdI
         DCKmzhFt6rIb5DwBlnGJIlyz1QgWJsWbJoH4yIuh28IrhwL+pqSOtPIIyxs+pAea2QVP
         a18DVJNq9eaqCUIW4K8YyEnDwivjuUy7ggHLqwh3hmxLgQlkAhuKimn0Y5AkXNAN7s1a
         DVekkkasoXPnY0NFSB33VgZQqIwWSLFvQ96wMlUj6zwq1IpQteIc/naUqQOEeB4956h5
         3FM8DvIVHLZRSEL53euH87WLKQqpB//C5UTNingUkgwp08q62QrHaTfBdBCAtWYb0srT
         tC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3lfAtywDprLwkA5KSR/4YJxV5b+lUQQ7aOixWJ/WfvA=;
        b=BfczcMT+LUFz1WyKx63nA1bw6A/7hHlUv9O6B9ii7w65f+Q35g0lWM/lCqA0k2MhQa
         akSEDnRdC7h3QjczHbPxmuiGxhrAzqTpm/CxRRgMEj6pd8ui+cl63IUmflwpJGO1Em9U
         3Nfl2J4LGDAPFzXXvFgquJ28+KeNiX4wdvyJ/VSnK3bhLN3F0X3Zuc8tFTBTnNCbTQJv
         zRRVr8fK+pnCbQaeiZUd362fevPtXRM9XkrGbFy23Nr+9icunGalPNV0kijt7l6Nx9QC
         yBI0G1GpLd94pnAxH/yxkFex/q8/qn/YSLLuwKFxWcaWX8d2K3aeZN1MnUlCMnaXsi4i
         TtwA==
X-Gm-Message-State: AOUpUlGC9hpRbseMhHMACVpTlUcZTGl6xCpc9xBjj3cJphSEzAJQSLHO
        TC7jGjKw1A/2vN8xr9Ei0JjU+W0v
X-Google-Smtp-Source: AA+uWPyJH85xsBBgVc/2G7go6LtUYZ3kuCowMAzLKcmeI2DtqgHbNhApQebxTdWUv7MgvsrQZzbmnw==
X-Received: by 2002:a1c:f703:: with SMTP id v3-v6mr1927597wmh.48.1533830161114;
        Thu, 09 Aug 2018 08:56:01 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id t69-v6sm10913762wmt.40.2018.08.09.08.55.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 08:56:00 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 3/8] pack-objects: refactor code into compute_layer_order()
Date:   Thu,  9 Aug 2018 17:55:27 +0200
Message-Id: <20180809155532.26151-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.555.g17f9c4abba
In-Reply-To: <20180809155532.26151-1-chriscool@tuxfamily.org>
References: <20180809155532.26151-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a following commit, as we will use delta islands, we will
have to compute the write order for different layers, not just
for one.

Let's prepare for that by refactoring the code that will be
used to compute the write order for a given layer into a new
compute_layer_order() function.

This will make it easier to see and understand what the
following changes are doing.

Helped-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/pack-objects.c | 90 +++++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 40 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4391504a91..99b6329399 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -667,48 +667,15 @@ static void add_family_to_write_order(struct object_entry **wo,
 	add_descendants_to_write_order(wo, endp, root);
 }
 
-static struct object_entry **compute_write_order(void)
+static void compute_layer_order(struct object_entry **wo, unsigned int *wo_end)
 {
-	unsigned int i, wo_end, last_untagged;
-
-	struct object_entry **wo;
+	unsigned int i, last_untagged;
 	struct object_entry *objects = to_pack.objects;
 
 	for (i = 0; i < to_pack.nr_objects; i++) {
-		objects[i].tagged = 0;
-		objects[i].filled = 0;
-		SET_DELTA_CHILD(&objects[i], NULL);
-		SET_DELTA_SIBLING(&objects[i], NULL);
-	}
-
-	/*
-	 * Fully connect delta_child/delta_sibling network.
-	 * Make sure delta_sibling is sorted in the original
-	 * recency order.
-	 */
-	for (i = to_pack.nr_objects; i > 0;) {
-		struct object_entry *e = &objects[--i];
-		if (!DELTA(e))
-			continue;
-		/* Mark me as the first child */
-		e->delta_sibling_idx = DELTA(e)->delta_child_idx;
-		SET_DELTA_CHILD(DELTA(e), e);
-	}
-
-	/*
-	 * Mark objects that are at the tip of tags.
-	 */
-	for_each_tag_ref(mark_tagged, NULL);
-
-	/*
-	 * Give the objects in the original recency order until
-	 * we see a tagged tip.
-	 */
-	ALLOC_ARRAY(wo, to_pack.nr_objects);
-	for (i = wo_end = 0; i < to_pack.nr_objects; i++) {
 		if (objects[i].tagged)
 			break;
-		add_to_write_order(wo, &wo_end, &objects[i]);
+		add_to_write_order(wo, wo_end, &objects[i]);
 	}
 	last_untagged = i;
 
@@ -717,7 +684,7 @@ static struct object_entry **compute_write_order(void)
 	 */
 	for (; i < to_pack.nr_objects; i++) {
 		if (objects[i].tagged)
-			add_to_write_order(wo, &wo_end, &objects[i]);
+			add_to_write_order(wo, wo_end, &objects[i]);
 	}
 
 	/*
@@ -727,7 +694,7 @@ static struct object_entry **compute_write_order(void)
 		if (oe_type(&objects[i]) != OBJ_COMMIT &&
 		    oe_type(&objects[i]) != OBJ_TAG)
 			continue;
-		add_to_write_order(wo, &wo_end, &objects[i]);
+		add_to_write_order(wo, wo_end, &objects[i]);
 	}
 
 	/*
@@ -736,7 +703,7 @@ static struct object_entry **compute_write_order(void)
 	for (i = last_untagged; i < to_pack.nr_objects; i++) {
 		if (oe_type(&objects[i]) != OBJ_TREE)
 			continue;
-		add_to_write_order(wo, &wo_end, &objects[i]);
+		add_to_write_order(wo, wo_end, &objects[i]);
 	}
 
 	/*
@@ -744,8 +711,51 @@ static struct object_entry **compute_write_order(void)
 	 */
 	for (i = last_untagged; i < to_pack.nr_objects; i++) {
 		if (!objects[i].filled)
-			add_family_to_write_order(wo, &wo_end, &objects[i]);
+			add_family_to_write_order(wo, wo_end, &objects[i]);
 	}
+}
+
+static struct object_entry **compute_write_order(void)
+{
+	unsigned int i, wo_end;
+
+	struct object_entry **wo;
+	struct object_entry *objects = to_pack.objects;
+
+	for (i = 0; i < to_pack.nr_objects; i++) {
+		objects[i].tagged = 0;
+		objects[i].filled = 0;
+		SET_DELTA_CHILD(&objects[i], NULL);
+		SET_DELTA_SIBLING(&objects[i], NULL);
+	}
+
+	/*
+	 * Fully connect delta_child/delta_sibling network.
+	 * Make sure delta_sibling is sorted in the original
+	 * recency order.
+	 */
+	for (i = to_pack.nr_objects; i > 0;) {
+		struct object_entry *e = &objects[--i];
+		if (!DELTA(e))
+			continue;
+		/* Mark me as the first child */
+		e->delta_sibling_idx = DELTA(e)->delta_child_idx;
+		SET_DELTA_CHILD(DELTA(e), e);
+	}
+
+	/*
+	 * Mark objects that are at the tip of tags.
+	 */
+	for_each_tag_ref(mark_tagged, NULL);
+
+	/*
+	 * Give the objects in the original recency order until
+	 * we see a tagged tip.
+	 */
+	ALLOC_ARRAY(wo, to_pack.nr_objects);
+	wo_end = 0;
+
+	compute_layer_order(wo, &wo_end);
 
 	if (wo_end != to_pack.nr_objects)
 		die("ordered %u objects, expected %"PRIu32, wo_end, to_pack.nr_objects);
-- 
2.18.0.555.g17f9c4abba

