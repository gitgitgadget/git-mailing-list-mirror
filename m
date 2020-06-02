Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D402C433E3
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E10E2072F
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFwZ9qpx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgFBERa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFBER1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 00:17:27 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C141C061A0E
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 21:17:26 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k26so1595623wmi.4
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 21:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c1LsDCav3Oo0omDkV24DpSjULKgysEltfw0vysiozXM=;
        b=YFwZ9qpx4v6hCHoEMNBo2PfpMzs+5pdb7brREUWrur+xr8Yt/CZ3IBj3mPkWjrfrJP
         uvyLvxbmpkjVRYRo+7+jeCuukZtxa4AgZFiPjk++HcE1wc6heosK1D/7MpU1O6XX9dQH
         jF7dlQJqUop4ieTvjRuHNQlXc4gLDeZ9Mqvzt2sk2biOJRRysVpfeURFPWq6xH+R1kiy
         1rdic7NUM5OB4i9ARQXFEQlXBF5W5Cmsw4J8y7YGrU3WK3iRueZYo/fEMb4wPSrkRZCN
         A5LbUbiFdf0p4lsuoBiLNs4f4iTeJmJCfZn0LLDWkQLC2OgX+iB4O5bu4PxTOwywAUiP
         sluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c1LsDCav3Oo0omDkV24DpSjULKgysEltfw0vysiozXM=;
        b=SSBySfYi+1Kzb5LTJExpURyeU36aCbDWsktiEhKZ4uBGEmpO5MtU49edxlpVg7xzPs
         +5Z9xKfamkzT8/DX2AwSbUeVZCgs7R3QVjfl9LZB2s7UXKkep4Ok+ZSoXFub9YXrjlRT
         rwgmawKF0LaQRgb4MfZGSqLDAXuQUIQMyT5NLdkkDT9zeJ0FZBCGoDqlW+gdrP6TY0+v
         8+o7PLboeYSbMDsQGyK/jrNQWwjLHl8rFEq2T/T5jKqE9o5gWp6mJmN2dxupNYtDw+lZ
         41dH0ZgHTKaQc87IBf/eiF7m4FlYVGnKboREwh7lP2Mbo2v1YTyztDZnirXEC97VkIaT
         AWFA==
X-Gm-Message-State: AOAM533yuQMGkMPhTVsBIC1eyzc88BMlxv1GfcjRqSMqCvyf7wMhY7Ko
        sX4JA4gYywiLmOsgMQaricEEtRtr6uM=
X-Google-Smtp-Source: ABdhPJyaru+HM9GFKrHkmdMpMhzUaFvs4QmPBmTNu1b6z31IT8n35/rdOCyy9ZW5jfjtMOCEXs+8jw==
X-Received: by 2002:a1c:46c3:: with SMTP id t186mr2156968wma.36.1591071444801;
        Mon, 01 Jun 2020 21:17:24 -0700 (PDT)
Received: from localhost.localdomain ([185.228.230.249])
        by smtp.gmail.com with ESMTPSA id z2sm1717614wrs.87.2020.06.01.21.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 21:17:24 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 07/13] upload-pack: change multi_ack to an enum
Date:   Tue,  2 Jun 2020 06:16:51 +0200
Message-Id: <20200602041657.7132-8-chriscool@tuxfamily.org>
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
more thoroughly, let's take this opportunity to change the
'multi_ack' variable, which is now part of 'upload_pack_data',
to an enum.

This will make it clear which values this variable can take.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index f8611a5d53..83270452d4 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -80,7 +80,11 @@ struct upload_pack_data {
 	int deepen_relative;
 
 	unsigned int timeout;					/* v0 only */
-	int multi_ack;						/* v0 only */
+	enum  {
+		no_multi_ack = 0,
+		multi_ack = 1,
+		multi_ack_detailed = 2
+	} multi_ack;						/* v0 only */
 
 	/* 0 for no sideband, otherwise DEFAULT_PACKET_MAX or LARGE_PACKET_MAX */
 	int use_sideband;
@@ -441,7 +445,7 @@ static int get_common_commits(struct upload_pack_data *data,
 		reset_timeout(data->timeout);
 
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
-			if (data->multi_ack == 2
+			if (data->multi_ack == multi_ack_detailed
 			    && got_common
 			    && !got_other
 			    && ok_to_give_up(&data->have_obj, &data->want_obj)) {
@@ -468,7 +472,7 @@ static int get_common_commits(struct upload_pack_data *data,
 				if (data->multi_ack
 				    && ok_to_give_up(&data->have_obj, &data->want_obj)) {
 					const char *hex = oid_to_hex(&oid);
-					if (data->multi_ack == 2) {
+					if (data->multi_ack == multi_ack_detailed) {
 						sent_ready = 1;
 						packet_write_fmt(1, "ACK %s ready\n", hex);
 					} else
@@ -478,7 +482,7 @@ static int get_common_commits(struct upload_pack_data *data,
 			default:
 				got_common = 1;
 				oid_to_hex_r(last_hex, &oid);
-				if (data->multi_ack == 2)
+				if (data->multi_ack == multi_ack_detailed)
 					packet_write_fmt(1, "ACK %s common\n", last_hex);
 				else if (data->multi_ack)
 					packet_write_fmt(1, "ACK %s continue\n", last_hex);
@@ -958,9 +962,9 @@ static void receive_needs(struct upload_pack_data *data,
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
2.27.0.rc0.26.g636377a2c4

