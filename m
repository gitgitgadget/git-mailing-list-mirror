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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE64C433E0
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AFB62072F
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IySfWUDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgFBERZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgFBERW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 00:17:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58FDC061A0E
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 21:17:21 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f185so1598369wmf.3
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 21:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4b7UB4ai38OmhZCpU3s14TgnOog/Csl1XFTgmqa4ys0=;
        b=IySfWUDM4eBH3Ed0rEQPuDy8gMC/eQluxE8+WEgveWXwzLvV2vuzdHQnZhbEi1im2C
         folD4iCMUcc+bUtTXQF6ZBro/Jyh/ezzLepluqrgtZgZSK+I8fTq2PG/e1czFPTlwKk2
         drzbpf7UAJ/qiDHjGCwsKy8d9SoQG6uajkUeQ+hfyfPbtmLYMeQtWg89aVkMrljHSvKS
         mVxR7pdOFQZeJvmdnXvo+WO2AqEStSaC8tKTvS3csSPmlSvjlzex0JT1UHX/XBckwnEE
         glN8NivIn2SjHdd0CK13dnIhXDKxAcDc3tWfCVyfMkODpAlQyT5oDeKAWsEv4NAGJ122
         krdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4b7UB4ai38OmhZCpU3s14TgnOog/Csl1XFTgmqa4ys0=;
        b=NjgObn+zPG/IHkv6D/hcKp9IEr16gDEeSuqAwa6F1Or0lzlEId9XtC2M4OFV0oicx9
         kJ/40P82KeZmqGbKyPAxnfFnnh8um8wT7GAQXJgEi167Wb2RGdE/np1LQKmuM7ZedOzG
         jyrpyk/r+2rmc5EDowxsH7ajm4GC+8sm2nCulZ8XTNcctcsGsRrUIsF5bZ0aZDhwpmS0
         vHBgPBH20RyqRANV7dy2PH/zIEetB/Iyt03AKhxsLSqFOJHl3JUd0uVaUhmBJuLdWDIN
         nPcn2o5DsM3adsORlK+JQwB5yPeE2ZjwEfXTHcO6D0613dhWyDE62cGkQDfGNZr/IXU5
         Fe4w==
X-Gm-Message-State: AOAM530W5FRuUQ6FdYTWDP4uS4ym+tXe8rOTGeYcdSxcqRHX/rAzl5Q9
        CfU1lCQ0kiXcnQoKbONjCKhigCVQXMM=
X-Google-Smtp-Source: ABdhPJzdaqhOumAULuzfquohwRTbcc9JIEFd0gIkdTSajOf6kO4PBu+L4yP6dqkbx5s6TNL6W9k6DA==
X-Received: by 2002:a1c:38c2:: with SMTP id f185mr2342318wma.79.1591071440285;
        Mon, 01 Jun 2020 21:17:20 -0700 (PDT)
Received: from localhost.localdomain ([185.228.230.249])
        by smtp.gmail.com with ESMTPSA id z2sm1717614wrs.87.2020.06.01.21.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 21:17:19 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 03/13] upload-pack: move static vars to upload_pack_data
Date:   Tue,  2 Jun 2020 06:16:47 +0200
Message-Id: <20200602041657.7132-4-chriscool@tuxfamily.org>
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
more thoroughly, let's move the 'no_done', 'daemon_mode' and
'timeout' variables into this struct.

They are only used by protocol v0 code since protocol v2 assumes
certain baseline capabilities, but rolling them into
upload_pack_data and just letting v2 code ignore them as it does
now is more coherent and cleaner.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 3963a3805e..21a27b2d2c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -45,8 +45,6 @@
 static timestamp_t oldest_have;
 
 static int multi_ack;
-static int no_done;
-static int daemon_mode;
 /* Allow specifying sha1 if it is a ref tip. */
 #define ALLOW_TIP_SHA1	01
 /* Allow request of a sha1 if it is reachable from a ref (possibly hidden ref). */
@@ -56,7 +54,6 @@ static int daemon_mode;
 static unsigned int allow_unadvertised_object_request;
 static int shallow_nr;
 static struct object_array extra_edge_obj;
-static unsigned int timeout;
 static int keepalive = 5;
 /* 0 for no sideband,
  * otherwise maximum packet size (up to 65520 bytes).
@@ -88,11 +85,15 @@ struct upload_pack_data {
 	int deepen_rev_list;
 	int deepen_relative;
 
+	unsigned int timeout;					/* v0 only */
+
 	struct list_objects_filter_options filter_options;
 
 	struct packet_writer writer;
 
 	unsigned stateless_rpc : 1;				/* v0 only */
+	unsigned no_done : 1;					/* v0 only */
+	unsigned daemon_mode : 1;				/* v0 only */
 
 	unsigned use_thin_pack : 1;
 	unsigned use_ofs_delta : 1;
@@ -135,7 +136,7 @@ static void upload_pack_data_clear(struct upload_pack_data *data)
 	list_objects_filter_release(&data->filter_options);
 }
 
-static void reset_timeout(void)
+static void reset_timeout(unsigned int timeout)
 {
 	alarm(timeout);
 }
@@ -251,7 +252,7 @@ static void create_pack_file(struct upload_pack_data *pack_data)
 		int pe, pu, pollsize;
 		int ret;
 
-		reset_timeout();
+		reset_timeout(pack_data->timeout);
 
 		pollsize = 0;
 		pe = pu = -1;
@@ -433,7 +434,7 @@ static int get_common_commits(struct upload_pack_data *data,
 	for (;;) {
 		const char *arg;
 
-		reset_timeout();
+		reset_timeout(data->timeout);
 
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
 			if (multi_ack == 2
@@ -446,7 +447,7 @@ static int get_common_commits(struct upload_pack_data *data,
 			if (data->have_obj.nr == 0 || multi_ack)
 				packet_write_fmt(1, "NAK\n");
 
-			if (no_done && sent_ready) {
+			if (data->no_done && sent_ready) {
 				packet_write_fmt(1, "ACK %s\n", last_hex);
 				return 0;
 			}
@@ -924,7 +925,7 @@ static void receive_needs(struct upload_pack_data *data,
 		struct object_id oid_buf;
 		const char *arg;
 
-		reset_timeout();
+		reset_timeout(data->timeout);
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
 			break;
 
@@ -957,7 +958,7 @@ static void receive_needs(struct upload_pack_data *data,
 		else if (parse_feature_request(features, "multi_ack"))
 			multi_ack = 1;
 		if (parse_feature_request(features, "no-done"))
-			no_done = 1;
+			data->no_done = 1;
 		if (parse_feature_request(features, "thin-pack"))
 			data->use_thin_pack = 1;
 		if (parse_feature_request(features, "ofs-delta"))
@@ -1000,7 +1001,7 @@ static void receive_needs(struct upload_pack_data *data,
 	if (has_non_tip)
 		check_non_tip(data);
 
-	if (!use_sideband && daemon_mode)
+	if (!use_sideband && data->daemon_mode)
 		data->no_progress = 1;
 
 	if (data->depth == 0 && !data->deepen_rev_list && data->shallows.nr == 0)
@@ -1149,19 +1150,18 @@ void upload_pack(struct upload_pack_options *options)
 	struct packet_reader reader;
 	struct upload_pack_data data;
 
-	timeout = options->timeout;
-	daemon_mode = options->daemon_mode;
-
 	git_config(upload_pack_config, NULL);
 
 	upload_pack_data_init(&data);
 
 	data.stateless_rpc = options->stateless_rpc;
+	data.daemon_mode = options->daemon_mode;
+	data.timeout = options->timeout;
 
 	head_ref_namespaced(find_symref, &data.symref);
 
 	if (options->advertise_refs || !data.stateless_rpc) {
-		reset_timeout();
+		reset_timeout(data.timeout);
 		head_ref_namespaced(send_ref, &data);
 		for_each_namespaced_ref(send_ref, &data);
 		advertise_shallow_grafts(1);
-- 
2.27.0.rc0.26.g636377a2c4

