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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F1AC433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC172071A
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldQOWXQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbgE0QsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 12:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbgE0QsD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 12:48:03 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97B1C05BD1E
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:48:02 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j16so12266269wrb.7
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xx1Ri6O5ddwhCRuvySzBCDf1FEii2p3uCrzIYDEhXmk=;
        b=ldQOWXQFpNABRGX+WDrdgF80hyyXetrRgL++a27EqJWXC98QzRV97mtJARZF8jzhGM
         jzltmNvGNyCoOPriGC93STS0VB4YXEPnWSlm7u3uG1M+wBuwZ9pLndPE5IKzyR0YmeZa
         fLv0ZzG4V3/GF2Z5BBQvjqzxXCKxSy4NdHcMxxiBYk9urVk46UoLOPT8xYMLa44Go7Qp
         EcpPp2kF56DK34UTHF1KOsKUcCV0fpMgk2oY+pPLnX76Qa7p08Qq2WSCPhgxuWdlAXrl
         Dsf+SvHn+vZfQO5ckkzcSeQ/tHbwTO+4DVlUzqEUbGvFNxxeajhCoPGAYqorPxF853qN
         +u3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xx1Ri6O5ddwhCRuvySzBCDf1FEii2p3uCrzIYDEhXmk=;
        b=joxYN2MsTXUu24F6BySqHnGbZpvjsNQWMk4KOA/gC12O0A8S7wzW3IUOKr0mT1Wegu
         e0gPG+8MHOi6EmCGOUfdlYIldn+0dF5CjbBs/7fDKKi99HYbB3adcJ+TIQLmxzMT4fVD
         zImdpMyvjtJG0QZpAqYHrfIALkwhidX9TfeGSqrHVioeJUmYclKOT46ckm5jCcRMidR+
         TqV08VimTwCukD59lSbZJzRTt7GqzV81T7T/5AJSOHqaLUoZ/ukETEfESfI1FTAkErMB
         GrXZN19I55NgCcyi22/MIev82J3da1OPFDiDzeQLE+ntTL8w1aDFBb//4LVjAmjdCTIp
         2exQ==
X-Gm-Message-State: AOAM531toRFBQrPsQxsh8Pj04C7UwMSA01lOpEFKyzlJsyYnJ83T8XlH
        Nyv657M8a/+0z5f7QR3bruZK3f811W0=
X-Google-Smtp-Source: ABdhPJyUeQuxUC/l1lfjSVGTjapWPFAf9tQe7MxfMVbvrRPvjIVJT/2ImXhVAJZ5VxCDm6giwV7Q1A==
X-Received: by 2002:a5d:4f81:: with SMTP id d1mr14572414wru.95.1590598081258;
        Wed, 27 May 2020 09:48:01 -0700 (PDT)
Received: from localhost.localdomain ([193.57.121.40])
        by smtp.gmail.com with ESMTPSA id d17sm2432852wrg.75.2020.05.27.09.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 09:48:00 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 03/12] upload-pack: move use_sideband to upload_pack_data
Date:   Wed, 27 May 2020 18:47:33 +0200
Message-Id: <20200527164742.23067-4-chriscool@tuxfamily.org>
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
more thoroughly, let's move the 'use_sideband' static variable
into this struct.

This variable is used by both v0 and v2 protocols.

While at it, let's update the comment near the variable
definition.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index c83c5a619b..a5a9750890 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -55,10 +55,6 @@ static unsigned int allow_unadvertised_object_request;
 static int shallow_nr;
 static struct object_array extra_edge_obj;
 static int keepalive = 5;
-/* 0 for no sideband,
- * otherwise maximum packet size (up to 65520 bytes).
- */
-static int use_sideband;
 static const char *pack_objects_hook;
 
 static int filter_capability_requested;
@@ -82,6 +78,9 @@ struct upload_pack_data {
 	int deepen_relative;
 	int timeout;
 
+	/* 0 for no sideband, otherwise DEFAULT_PACKET_MAX or LARGE_PACKET_MAX */
+	int use_sideband;
+
 	struct list_objects_filter_options filter_options;
 
 	struct packet_writer writer;
@@ -135,7 +134,8 @@ static void reset_timeout(int timeout)
 	alarm(timeout);
 }
 
-static void send_client_data(int fd, const char *data, ssize_t sz)
+static void send_client_data(int fd, const char *data, ssize_t sz,
+			     int use_sideband)
 {
 	if (use_sideband) {
 		send_sideband(1, fd, data, sz, use_sideband);
@@ -284,7 +284,8 @@ static void create_pack_file(struct upload_pack_data *pack_data)
 			sz = xread(pack_objects.err, progress,
 				  sizeof(progress));
 			if (0 < sz)
-				send_client_data(2, progress, sz);
+				send_client_data(2, progress, sz,
+						 pack_data->use_sideband);
 			else if (sz == 0) {
 				close(pack_objects.err);
 				pack_objects.err = -1;
@@ -327,7 +328,8 @@ static void create_pack_file(struct upload_pack_data *pack_data)
 			}
 			else
 				buffered = -1;
-			send_client_data(1, data, sz);
+			send_client_data(1, data, sz,
+					 pack_data->use_sideband);
 		}
 
 		/*
@@ -340,7 +342,7 @@ static void create_pack_file(struct upload_pack_data *pack_data)
 		 * protocol to say anything, so those clients are just out of
 		 * luck.
 		 */
-		if (!ret && use_sideband) {
+		if (!ret && pack_data->use_sideband) {
 			static const char buf[] = "0005\1";
 			write_or_die(1, buf, 5);
 		}
@@ -354,15 +356,17 @@ static void create_pack_file(struct upload_pack_data *pack_data)
 	/* flush the data */
 	if (0 <= buffered) {
 		data[0] = buffered;
-		send_client_data(1, data, 1);
+		send_client_data(1, data, 1,
+				 pack_data->use_sideband);
 		fprintf(stderr, "flushed.\n");
 	}
-	if (use_sideband)
+	if (pack_data->use_sideband)
 		packet_flush(1);
 	return;
 
  fail:
-	send_client_data(3, abort_msg, sizeof(abort_msg));
+	send_client_data(3, abort_msg, sizeof(abort_msg),
+			 pack_data->use_sideband);
 	die("git upload-pack: %s", abort_msg);
 }
 
@@ -958,9 +962,9 @@ static void receive_needs(struct upload_pack_data *data,
 		if (parse_feature_request(features, "ofs-delta"))
 			data->use_ofs_delta = 1;
 		if (parse_feature_request(features, "side-band-64k"))
-			use_sideband = LARGE_PACKET_MAX;
+			data->use_sideband = LARGE_PACKET_MAX;
 		else if (parse_feature_request(features, "side-band"))
-			use_sideband = DEFAULT_PACKET_MAX;
+			data->use_sideband = DEFAULT_PACKET_MAX;
 		if (parse_feature_request(features, "no-progress"))
 			data->no_progress = 1;
 		if (parse_feature_request(features, "include-tag"))
@@ -995,7 +999,7 @@ static void receive_needs(struct upload_pack_data *data,
 	if (has_non_tip)
 		check_non_tip(data);
 
-	if (!use_sideband && data->daemon_mode)
+	if (!data->use_sideband && data->daemon_mode)
 		data->no_progress = 1;
 
 	if (data->depth == 0 && !data->deepen_rev_list && data->shallows.nr == 0)
@@ -1480,7 +1484,7 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 	git_config(upload_pack_config, NULL);
 
 	upload_pack_data_init(&data);
-	use_sideband = LARGE_PACKET_MAX;
+	data.use_sideband = LARGE_PACKET_MAX;
 
 	while (state != FETCH_DONE) {
 		switch (state) {
-- 
2.27.0.rc2.38.gc6b4ed14d2.dirty

