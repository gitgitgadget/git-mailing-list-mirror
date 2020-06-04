Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80829C433E1
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65391206DC
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRgusKMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbgFDRzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730313AbgFDRzR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 13:55:17 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94CDC08C5C2
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 10:55:17 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h5so7098622wrc.7
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 10:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MxsWEJoxBfnhgL9c26xEUqJhJiGybJlPZyEbbubJj10=;
        b=JRgusKMUWqpaCia0nwLvHILRsJFl+aHMcaj4bh5WZ/h0tKfPC3AAJMMsC47wHN7JHN
         eZY7WImuLSIbSnIqWDQq/C+A7pFEym7kkbLj5SM8zrBVEMWPIU+W2d8qzyp3sx5nd8IG
         StHfhr3gDCUyMSmoDTW5k+I/KOYBoEsjU+aXyMglm/PVorVOxrOAU8hbcEiWxF/pY01N
         itrJKo6Edisz9V4EOKaXegDsiVj/8+YqVKhX/HJvqoaFwsYWpx0J0jur4PAivTT1oC3Y
         CeP2uT9pHm/0QCRqbj1tUzmV9VfJV8gXpZuEYYNzIRNIwEMdn64gOqezob2AzGPTOKkX
         nlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MxsWEJoxBfnhgL9c26xEUqJhJiGybJlPZyEbbubJj10=;
        b=FvZYAlXZDxQnVGgC05ajlGVBTRpHqwuYOAneE/cZlvT2U1zd+Y2C51p3fG9ofoWRyL
         xp1TFfbA3kRVrCZFEVaMKNFPLyoVvO+m0uTb2xLeaVcq/rr0GGQHDNRACz31a/nWqp38
         NOhBrDXRDgH/XxfGEIlj8JGsUkI8jMURPjS/3aKCHlotrHkMe54Ud/abWJhqdd0iimSf
         +bul/8xpCmqmqNy9N90EVqEyPg7nPBm9T3NPignKWs2FG6r0PeW+pVdBkiqLP8s+fMXc
         9nWVFNKh+lEWYVWOPSKc9h2bAbRnbtEIgHgtFo34i+JMyRYe2VK0XT0HqRKjx7P+l4FQ
         Z5xA==
X-Gm-Message-State: AOAM530SAJ6xfrs4Vk2nS0XqqB3YFABqQjpOSgYTmV9kUM+tqpPglJAo
        X/4dNAGvMVVWtZxpKu5gUKT5O5NMivU=
X-Google-Smtp-Source: ABdhPJzuwsrqnGe98oS/6Tg2g7JD5c0OsVgeXMSsIlEMLPQIWU4DCaXDx9jsbBOVNd8dRzdX5YPRMw==
X-Received: by 2002:adf:ecc2:: with SMTP id s2mr6149656wro.60.1591293316085;
        Thu, 04 Jun 2020 10:55:16 -0700 (PDT)
Received: from localhost.localdomain ([185.228.231.251])
        by smtp.gmail.com with ESMTPSA id s7sm9173540wrr.60.2020.06.04.10.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 10:55:15 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 07/13] upload-pack: change multi_ack to an enum
Date:   Thu,  4 Jun 2020 19:54:44 +0200
Message-Id: <20200604175450.17385-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.rc0.26.gf2851482f5
In-Reply-To: <20200604175450.17385-1-chriscool@tuxfamily.org>
References: <20200602041657.7132-1-chriscool@tuxfamily.org>
 <20200604175450.17385-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
more thoroughly, let's take this opportunity to change the
'multi_ack' variable, which is now part of 'upload_pack_data',
to an enum.

This will make it clear which values this variable can take.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Acked-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 upload-pack.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index f8611a5d53..e7b8140e55 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -80,7 +80,11 @@ struct upload_pack_data {
 	int deepen_relative;
 
 	unsigned int timeout;					/* v0 only */
-	int multi_ack;						/* v0 only */
+	enum {
+		NO_MULTI_ACK = 0,
+		MULTI_ACK = 1,
+		MULTI_ACK_DETAILED = 2
+	} multi_ack;						/* v0 only */
 
 	/* 0 for no sideband, otherwise DEFAULT_PACKET_MAX or LARGE_PACKET_MAX */
 	int use_sideband;
@@ -441,7 +445,7 @@ static int get_common_commits(struct upload_pack_data *data,
 		reset_timeout(data->timeout);
 
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
-			if (data->multi_ack == 2
+			if (data->multi_ack == MULTI_ACK_DETAILED
 			    && got_common
 			    && !got_other
 			    && ok_to_give_up(&data->have_obj, &data->want_obj)) {
@@ -468,7 +472,7 @@ static int get_common_commits(struct upload_pack_data *data,
 				if (data->multi_ack
 				    && ok_to_give_up(&data->have_obj, &data->want_obj)) {
 					const char *hex = oid_to_hex(&oid);
-					if (data->multi_ack == 2) {
+					if (data->multi_ack == MULTI_ACK_DETAILED) {
 						sent_ready = 1;
 						packet_write_fmt(1, "ACK %s ready\n", hex);
 					} else
@@ -478,7 +482,7 @@ static int get_common_commits(struct upload_pack_data *data,
 			default:
 				got_common = 1;
 				oid_to_hex_r(last_hex, &oid);
-				if (data->multi_ack == 2)
+				if (data->multi_ack == MULTI_ACK_DETAILED)
 					packet_write_fmt(1, "ACK %s common\n", last_hex);
 				else if (data->multi_ack)
 					packet_write_fmt(1, "ACK %s continue\n", last_hex);
@@ -958,9 +962,9 @@ static void receive_needs(struct upload_pack_data *data,
 		if (parse_feature_request(features, "deepen-relative"))
 			data->deepen_relative = 1;
 		if (parse_feature_request(features, "multi_ack_detailed"))
-			data->multi_ack = 2;
+			data->multi_ack = MULTI_ACK_DETAILED;
 		else if (parse_feature_request(features, "multi_ack"))
-			data->multi_ack = 1;
+			data->multi_ack = MULTI_ACK;
 		if (parse_feature_request(features, "no-done"))
 			data->no_done = 1;
 		if (parse_feature_request(features, "thin-pack"))
-- 
2.27.0.rc0.26.gf2851482f5

