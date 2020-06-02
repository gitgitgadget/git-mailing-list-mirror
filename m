Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2729CC433DF
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 067DF2072F
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nyeb6lMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgFBER3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgFBERZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 00:17:25 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D4CC05BD43
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 21:17:25 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c3so1850707wru.12
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 21:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IEtxnMne86XyHEyMG+LQ5k8mVYgV5uborwqzMNallhU=;
        b=Nyeb6lMig5P360J3FdJackyvvYKppM+qyfg8p48OF/7sjRsucBRCsIYKeckbaMlhCn
         UbyciV0S5ou0OjbCe3MGpe0phhSnpgbvg/EiOwZFNbR0wWdtszVXVVBZ+szBbGF/sDGe
         9DyY/8jdmSPQ2Knt5FoGYToci44IL9z04bdejiP/Nnd8W1bfVY2Yz8nRUdY7XXndZC6m
         1iN6oNMobkeOQo0nu8gg4Qo25NmQmDvH/V5hKqBPROza865TspZ5bAjWol7NxkG0RNpW
         A/5dPvqm9bUXnDtmBqwzdefvLcYs/mSr+piu515hmiYhIxQyiETfgsUHHZIT8yVoPzZ6
         Az+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IEtxnMne86XyHEyMG+LQ5k8mVYgV5uborwqzMNallhU=;
        b=cvp+C1tNKAguC/po/zHKxDZMeL5UtAwHM3moTPoLFwPJcQkMvwJw4592jGPclp4tYc
         WQVMTpWY3ojBZjJu8QrAc2mw33ByzXgnOR5DXIVBpXUtEOmCvZL/q/EIWD7vdVdnIuv/
         G+is6a4gFnN5j9Td2M/VVDjIZ3tpTfPf6/cVu9/spmA/LD6C3dsQR6AWkTYJ+DFDwl1d
         O0S3VDDBlVoI4BSAnpUuM9Zn0idTrQbkvs7ywOT1/8USB/iWsG68y6BDv2kfnG7bX78Q
         wPLhdJJrXgctGBmxICqWVXW0FLsNmz4eOUWqSpl3bfGy2qdMEUkbbaFeGd7lMCO8969e
         plGw==
X-Gm-Message-State: AOAM5324nX/G3RJXmqTN2TYWO7xAMGDz/hT/w/1lJy0CXATHxnn4gRD0
        NLF/i9bdK/6Riz0v8GAmU0QyH1LNaGg=
X-Google-Smtp-Source: ABdhPJx/uaWgji/A9Pk2KYwj61nTyGzt/cK1r7ZyJfvF/ft2cQFh6d+V+ccZMVBa1geqySv+fCXscg==
X-Received: by 2002:a5d:6586:: with SMTP id q6mr22800517wru.319.1591071443553;
        Mon, 01 Jun 2020 21:17:23 -0700 (PDT)
Received: from localhost.localdomain ([185.228.230.249])
        by smtp.gmail.com with ESMTPSA id z2sm1717614wrs.87.2020.06.01.21.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 21:17:23 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 06/13] upload-pack: move multi_ack to upload_pack_data
Date:   Tue,  2 Jun 2020 06:16:50 +0200
Message-Id: <20200602041657.7132-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.rc0.26.gf2851482f5
In-Reply-To: <20200602041657.7132-1-chriscool@tuxfamily.org>
References: <20200527164742.23067-1-chriscool@tuxfamily.org>
 <20200602041657.7132-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
more thoroughly, let's move the multi_ack static variable into
this struct.

It is only used by protocol v0 code since protocol v2 assumes
certain baseline capabilities, but rolling it into
upload_pack_data and just letting v2 code ignore it as it does
now is more coherent and cleaner.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 6226387a84..f8611a5d53 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -44,7 +44,6 @@
 
 static timestamp_t oldest_have;
 
-static int multi_ack;
 /* Allow specifying sha1 if it is a ref tip. */
 #define ALLOW_TIP_SHA1	01
 /* Allow request of a sha1 if it is reachable from a ref (possibly hidden ref). */
@@ -81,6 +80,7 @@ struct upload_pack_data {
 	int deepen_relative;
 
 	unsigned int timeout;					/* v0 only */
+	int multi_ack;						/* v0 only */
 
 	/* 0 for no sideband, otherwise DEFAULT_PACKET_MAX or LARGE_PACKET_MAX */
 	int use_sideband;
@@ -441,14 +441,14 @@ static int get_common_commits(struct upload_pack_data *data,
 		reset_timeout(data->timeout);
 
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
-			if (multi_ack == 2
+			if (data->multi_ack == 2
 			    && got_common
 			    && !got_other
 			    && ok_to_give_up(&data->have_obj, &data->want_obj)) {
 				sent_ready = 1;
 				packet_write_fmt(1, "ACK %s ready\n", last_hex);
 			}
-			if (data->have_obj.nr == 0 || multi_ack)
+			if (data->have_obj.nr == 0 || data->multi_ack)
 				packet_write_fmt(1, "NAK\n");
 
 			if (data->no_done && sent_ready) {
@@ -465,10 +465,10 @@ static int get_common_commits(struct upload_pack_data *data,
 			switch (got_oid(arg, &oid, &data->have_obj)) {
 			case -1: /* they have what we do not */
 				got_other = 1;
-				if (multi_ack
+				if (data->multi_ack
 				    && ok_to_give_up(&data->have_obj, &data->want_obj)) {
 					const char *hex = oid_to_hex(&oid);
-					if (multi_ack == 2) {
+					if (data->multi_ack == 2) {
 						sent_ready = 1;
 						packet_write_fmt(1, "ACK %s ready\n", hex);
 					} else
@@ -478,9 +478,9 @@ static int get_common_commits(struct upload_pack_data *data,
 			default:
 				got_common = 1;
 				oid_to_hex_r(last_hex, &oid);
-				if (multi_ack == 2)
+				if (data->multi_ack == 2)
 					packet_write_fmt(1, "ACK %s common\n", last_hex);
-				else if (multi_ack)
+				else if (data->multi_ack)
 					packet_write_fmt(1, "ACK %s continue\n", last_hex);
 				else if (data->have_obj.nr == 1)
 					packet_write_fmt(1, "ACK %s\n", last_hex);
@@ -490,7 +490,7 @@ static int get_common_commits(struct upload_pack_data *data,
 		}
 		if (!strcmp(reader->line, "done")) {
 			if (data->have_obj.nr > 0) {
-				if (multi_ack)
+				if (data->multi_ack)
 					packet_write_fmt(1, "ACK %s\n", last_hex);
 				return 0;
 			}
@@ -958,9 +958,9 @@ static void receive_needs(struct upload_pack_data *data,
 		if (parse_feature_request(features, "deepen-relative"))
 			data->deepen_relative = 1;
 		if (parse_feature_request(features, "multi_ack_detailed"))
-			multi_ack = 2;
+			data->multi_ack = 2;
 		else if (parse_feature_request(features, "multi_ack"))
-			multi_ack = 1;
+			data->multi_ack = 1;
 		if (parse_feature_request(features, "no-done"))
 			data->no_done = 1;
 		if (parse_feature_request(features, "thin-pack"))
-- 
2.27.0.rc0.26.g636377a2c4

