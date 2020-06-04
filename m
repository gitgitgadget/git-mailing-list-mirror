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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909C9C433E0
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75269207D8
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKad3Ald"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbgFDRzU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730306AbgFDRzR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 13:55:17 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79206C08C5C0
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 10:55:16 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x14so7115395wrp.2
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 10:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HdYZXtFZbQmoNqpb+TJRxmLNyZGIvx2H2KUYd4nidoY=;
        b=fKad3Ald/9wkjVD0Ee4jrKxmjmrZiAhys4615x7OhKOBXcU9sBWJsrnNtnQEUloFTU
         kaJa7pwUaR97s9YTrb1wF8ZEUNiba3Z6HCsWF7aK/kDF3RkaxFGFFFnyWk25ZiPQjDR+
         sU+Q+ZSyA9nBX6DQJLgp8ZGkmcu96/G96k3uPajqpFHAgBSfTCDGAaW83psGLj6RiptM
         +Zs7Y/Wo11XIJjfAAWrGEoyeHhOQT+pvyJWxl2Ie+ijh6d5tdJ7Hxsf2yXFl17ehJyt0
         j2USy7nvUgdCVEYKjyyV3Z/OlZEXd/9bcZLqGV86GOxpCTIF4B1uxA3bRh5HTMQfOW5d
         qNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HdYZXtFZbQmoNqpb+TJRxmLNyZGIvx2H2KUYd4nidoY=;
        b=jYBL23KxHaxmY9bpO9ieN2wsRHwQizqNS795entfBn/9XOVkcGM0Sf/1CCV8OTi3KR
         0zknEc2h9SJk/zmazqCsCNegqyyQb12uOIkymBgVoShpnSTMtEnBAJJaKw2zMS06DsFA
         t99pYlhlyRzIKksX6FuJpe7UtHSFtkHqWeF35544z0s+eKiW55bqstLtXNTVYocNr0+9
         E4BoQzXHmQQMnNfhNqSZpKWtckuGD1UmJoT0pIYrepVYXODICmGWdZbUKawfEfi8Xa79
         XV9lglUY6+CRy1sGi7mJC3aUPf2XJZxFQqTDFf06lSHWAfdlE/HbZYjFSmW+CH77OXJq
         rhWw==
X-Gm-Message-State: AOAM5316qavaeeG+dzZvsFkBRohW0r4rYtOYdpkMH0/DONcsB3nfqGaH
        Klw9wTb0vXUYxBh8HEEPZEgPzu8pavo=
X-Google-Smtp-Source: ABdhPJw2ncBWPBj+ywAZgIk4sWm25quT2Uxs3E8Z3sckAnA6lv271oNLH/yqHt2jxTyTk7eDwYcQnw==
X-Received: by 2002:adf:f8c8:: with SMTP id f8mr5537016wrq.151.1591293314888;
        Thu, 04 Jun 2020 10:55:14 -0700 (PDT)
Received: from localhost.localdomain ([185.228.231.251])
        by smtp.gmail.com with ESMTPSA id s7sm9173540wrr.60.2020.06.04.10.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 10:55:14 -0700 (PDT)
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
Subject: [PATCH v3 06/13] upload-pack: move multi_ack to upload_pack_data
Date:   Thu,  4 Jun 2020 19:54:43 +0200
Message-Id: <20200604175450.17385-7-chriscool@tuxfamily.org>
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
more thoroughly, let's move the multi_ack static variable into
this struct.

It is only used by protocol v0 code since protocol v2 assumes
certain baseline capabilities, but rolling it into
upload_pack_data and just letting v2 code ignore it as it does
now is more coherent and cleaner.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Acked-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.27.0.rc0.26.gf2851482f5

