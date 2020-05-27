Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B92C433E2
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 396042071A
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkictQ/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389184AbgE0QsJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 12:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729900AbgE0QsH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 12:48:07 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062E6C05BD1E
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:48:07 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l11so24762936wru.0
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JzaK3oaiuoxJl0gGNDuBN5H1kuaIm1tDSaPtL88bkAw=;
        b=MkictQ/tSjkj6/foS/0dyvF5TkSdngDqFMxbL1PgGDnkIDJ88Tae1P/xcxBszlMmSt
         PQ4AglE6jZgeB4Wcvz2w8seesqY1qS2F4lz22BIW5nGR5OvEroBTeoBLsRxhR8x+Rc+I
         7pH1kUbrKRnz4cFjxrlhoIa/50R0+N87IjAKuFWZZ/uBuggwda4fLw35+9C273XN5L1r
         SI6xKs6h3TNLWBoMJM87y3etDA+gx6n74NcApCPvx5okb5/uIdUqdHLEIwEAH6qH64GS
         2yaM4IfqdFb6db/msLnF1H1zwf+Qgd28avD32kPbD06Bt8ctT9UcAmkEj6sjogjYIFBT
         ltAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JzaK3oaiuoxJl0gGNDuBN5H1kuaIm1tDSaPtL88bkAw=;
        b=tVjWfo8Oif1jO4+l9Y84xeaz78YhL1yKjdBNFY030Y4jCgUgjbcaIjjwDG2pHaS2uE
         NyJUYSJ9HkHpIwcQVK+oKDjZAApE/bGyw8YyG2KNiK8qaURbaGe7M5Ae3Br953QNs/jl
         5Vjj5LCbddM5fW2s1PJTat5eYpz4ISvm4eR1QAjb4TgKuScan39lQyOlTuKqDlreciLj
         H9mw6yOac9Eau8r/wox21aoR73rC1zGCKFj/aZk2E5SEZABB0y8/lF7ZJ5vchPxv2Y5p
         vGfAMHj0vs9hEPKgZiutYimn7kYBK7Vb+YNW0tVzU/pvzFHleOwE89ar3hQKlsLd5r3C
         +XFQ==
X-Gm-Message-State: AOAM531EeSfxrotYARsEmzdipEsaLvV3R7QAZXeEhp0XQ7Tf7hSKEIK9
        o3XgdybRERXPJO4BWBl90oC0LV36Blw=
X-Google-Smtp-Source: ABdhPJwSbEf1Xz64CnGW7epFlALUjSZipw8YoRzWOhyhn2l8yYkfz/dkS65TA5SD1bHyo8vH0qcN0A==
X-Received: by 2002:a5d:4a0b:: with SMTP id m11mr5988815wrq.385.1590598084966;
        Wed, 27 May 2020 09:48:04 -0700 (PDT)
Received: from localhost.localdomain ([193.57.121.40])
        by smtp.gmail.com with ESMTPSA id d17sm2432852wrg.75.2020.05.27.09.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 09:48:04 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 06/12] upload-pack: change multi_ack to an enum
Date:   Wed, 27 May 2020 18:47:36 +0200
Message-Id: <20200527164742.23067-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.rc2.38.gc6b4ed14d2.dirty
In-Reply-To: <20200527164742.23067-1-chriscool@tuxfamily.org>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
 <20200527164742.23067-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
more thoroughly, let's take this opportunity to change the
'multi_ack' variable, which is now part of 'upload_pack_data',
to an enum.

This will make it clear which values this variable can take.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 385b165bec..d211bebc0e 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -75,7 +75,12 @@ struct upload_pack_data {
 	int deepen_rev_list;
 	int deepen_relative;
 	int timeout;
-	int multi_ack;
+
+	enum  {
+		no_multi_ack = 0,
+		multi_ack = 1,
+		multi_ack_detailed = 2
+	} multi_ack;
 
 	/* 0 for no sideband, otherwise DEFAULT_PACKET_MAX or LARGE_PACKET_MAX */
 	int use_sideband;
@@ -435,7 +440,7 @@ static int get_common_commits(struct upload_pack_data *data,
 		reset_timeout(data->timeout);
 
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
-			if (data->multi_ack == 2
+			if (data->multi_ack == multi_ack_detailed
 			    && got_common
 			    && !got_other
 			    && ok_to_give_up(&data->have_obj, &data->want_obj)) {
@@ -462,7 +467,7 @@ static int get_common_commits(struct upload_pack_data *data,
 				if (data->multi_ack
 				    && ok_to_give_up(&data->have_obj, &data->want_obj)) {
 					const char *hex = oid_to_hex(&oid);
-					if (data->multi_ack == 2) {
+					if (data->multi_ack == multi_ack_detailed) {
 						sent_ready = 1;
 						packet_write_fmt(1, "ACK %s ready\n", hex);
 					} else
@@ -472,7 +477,7 @@ static int get_common_commits(struct upload_pack_data *data,
 			default:
 				got_common = 1;
 				oid_to_hex_r(last_hex, &oid);
-				if (data->multi_ack == 2)
+				if (data->multi_ack == multi_ack_detailed)
 					packet_write_fmt(1, "ACK %s common\n", last_hex);
 				else if (data->multi_ack)
 					packet_write_fmt(1, "ACK %s continue\n", last_hex);
@@ -952,9 +957,9 @@ static void receive_needs(struct upload_pack_data *data,
 		if (parse_feature_request(features, "deepen-relative"))
 			data->deepen_relative = 1;
 		if (parse_feature_request(features, "multi_ack_detailed"))
-			data->multi_ack = 2;
+			data->multi_ack = multi_ack_detailed;
 		else if (parse_feature_request(features, "multi_ack"))
-			data->multi_ack = 1;
+			data->multi_ack = multi_ack;
 		if (parse_feature_request(features, "no-done"))
 			data->no_done = 1;
 		if (parse_feature_request(features, "thin-pack"))
-- 
2.27.0.rc2.38.gc6b4ed14d2.dirty

