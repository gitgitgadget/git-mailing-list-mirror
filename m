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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F173C433E1
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 702F62072F
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="choRUMXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgFBERZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgFBERX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 00:17:23 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D2EC05BD43
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 21:17:22 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d128so1616046wmc.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 21:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l11+CdHhjp6N4n56z0tThcomkvVYT1MJUUbUxmfcXFE=;
        b=choRUMXinWyAKv6Kz9trgcaYU/tCX8+uce5rVDq4iL4TvuFKK0OvGdBVinTm/o2TUV
         2Up6SfYtKwsy3JzV0NqYj60rDim8Yk7bbA+GgmWVzL0ejQVG5Hk7MftkoQ/XVM16IpBl
         aaX1UwEW2iUeiywb41AOkKxIVRCMf+xTghgPvjh/+rNVwk92gk76aqp55clDdgOFKyVb
         bFrmzH7HD+y9L8omvnZgLsQQ4cMvc4ucq1HNSCE+Xm4Cyf3aT/nJHb47nc2PrrFan5Gv
         kDBxNaAt4E+ED3DDy2RivBCiLEmk/p6zBaoUJ+VgH7Ex140akzaP/f5IGGaIZWOtgpt/
         L0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l11+CdHhjp6N4n56z0tThcomkvVYT1MJUUbUxmfcXFE=;
        b=QBkB52kKjM9S4TLx/P8wpcNwRxTYTSHvUXgmh6ygc2jxVcbY8s8fveiOt9tizslpTP
         tugJTxhz+3k2MGiNCjuD9nZ7kdv2I+k+MXCpIbVc0jD1vEgz0jhIUB13y7Gmj+ZEXIrG
         I0FfDbbYTsHdPtaHMhMR1mzZVc1i6YSAN5d5sCA36JtWKqFBPZxkz9T2k4Zp+/I3jEsV
         8vLM3DyBl0F6TfuNN/u8oy7VG8Y4/6Q/UwUr13+AC1AEHQANi/Wr9khKJeauI/IHEYHQ
         nYr7C12jyv7AgyyoOegVk02a4l+WO8FSN5/hbTiCaFwvzS6it+daQhYfGVbF2UPb3i66
         17Tg==
X-Gm-Message-State: AOAM531usFjVeBgYZx4GpXUOYwhiPnYvc/HkVpE3Yqy+R1MFSAiFZw/o
        ZTwuO2E298reyoon8cH3lpHTOk439aY=
X-Google-Smtp-Source: ABdhPJzf7NpI9tG1hkYZygiEw1uoNYT30rqUr6EIkvjxoZ3Hu5l8xMIgNeCZ5ZBt3PdoZYM3qgRBgw==
X-Received: by 2002:a1c:658a:: with SMTP id z132mr2230165wmb.20.1591071441329;
        Mon, 01 Jun 2020 21:17:21 -0700 (PDT)
Received: from localhost.localdomain ([185.228.230.249])
        by smtp.gmail.com with ESMTPSA id z2sm1717614wrs.87.2020.06.01.21.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 21:17:20 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 04/13] upload-pack: move use_sideband to upload_pack_data
Date:   Tue,  2 Jun 2020 06:16:48 +0200
Message-Id: <20200602041657.7132-5-chriscool@tuxfamily.org>
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
index 21a27b2d2c..07798fdc75 100644
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
@@ -87,6 +83,9 @@ struct upload_pack_data {
 
 	unsigned int timeout;					/* v0 only */
 
+	/* 0 for no sideband, otherwise DEFAULT_PACKET_MAX or LARGE_PACKET_MAX */
+	int use_sideband;
+
 	struct list_objects_filter_options filter_options;
 
 	struct packet_writer writer;
@@ -141,7 +140,8 @@ static void reset_timeout(unsigned int timeout)
 	alarm(timeout);
 }
 
-static void send_client_data(int fd, const char *data, ssize_t sz)
+static void send_client_data(int fd, const char *data, ssize_t sz,
+			     int use_sideband)
 {
 	if (use_sideband) {
 		send_sideband(1, fd, data, sz, use_sideband);
@@ -290,7 +290,8 @@ static void create_pack_file(struct upload_pack_data *pack_data)
 			sz = xread(pack_objects.err, progress,
 				  sizeof(progress));
 			if (0 < sz)
-				send_client_data(2, progress, sz);
+				send_client_data(2, progress, sz,
+						 pack_data->use_sideband);
 			else if (sz == 0) {
 				close(pack_objects.err);
 				pack_objects.err = -1;
@@ -333,7 +334,8 @@ static void create_pack_file(struct upload_pack_data *pack_data)
 			}
 			else
 				buffered = -1;
-			send_client_data(1, data, sz);
+			send_client_data(1, data, sz,
+					 pack_data->use_sideband);
 		}
 
 		/*
@@ -346,7 +348,7 @@ static void create_pack_file(struct upload_pack_data *pack_data)
 		 * protocol to say anything, so those clients are just out of
 		 * luck.
 		 */
-		if (!ret && use_sideband) {
+		if (!ret && pack_data->use_sideband) {
 			static const char buf[] = "0005\1";
 			write_or_die(1, buf, 5);
 		}
@@ -360,15 +362,17 @@ static void create_pack_file(struct upload_pack_data *pack_data)
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
 
@@ -964,9 +968,9 @@ static void receive_needs(struct upload_pack_data *data,
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
@@ -1001,7 +1005,7 @@ static void receive_needs(struct upload_pack_data *data,
 	if (has_non_tip)
 		check_non_tip(data);
 
-	if (!use_sideband && data->daemon_mode)
+	if (!data->use_sideband && data->daemon_mode)
 		data->no_progress = 1;
 
 	if (data->depth == 0 && !data->deepen_rev_list && data->shallows.nr == 0)
@@ -1486,7 +1490,7 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 	git_config(upload_pack_config, NULL);
 
 	upload_pack_data_init(&data);
-	use_sideband = LARGE_PACKET_MAX;
+	data.use_sideband = LARGE_PACKET_MAX;
 
 	while (state != FETCH_DONE) {
 		switch (state) {
-- 
2.27.0.rc0.26.g636377a2c4

