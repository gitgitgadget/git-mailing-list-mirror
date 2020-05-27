Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB86CC433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95CE32071A
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mD+tBMj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgE0QsC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 12:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgE0QsB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 12:48:01 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948D4C05BD1E
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:48:01 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u13so86197wml.1
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7UiFHnoDVmGy51pePUyz/BxKai79L3vtN4/6ZnTcCzc=;
        b=mD+tBMj3WwP16LOdU0djjNZm7+b8n2ZfJI5lwtRX4dvT3qeux+FnjH2bE6XfS3jWHc
         bNW3j14Fr1UfJO5DdXbjHUG2FNtTI+zcOBS1AqiYeLmAObWD9xytdEHzQwMrdOWnjY/z
         J+D2PavwXImaG6IXu4dqj9c3gVixmlrT603nPtfqIUoJAyoja83f+oSbkCY33sHykDVz
         JvVJWRFcoHzoZPvwvmUjW/P+oQ9UxYww6fIQxvt0umgD4+XYGcqbPSLtPfFd4TC+NDKf
         n4H9cfScKxPR0vwWP09VSc6MerdvIK1ZOrOnuiU65E20lqA1Q7gRsJ1HXbU0ga7yBl+L
         ZrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7UiFHnoDVmGy51pePUyz/BxKai79L3vtN4/6ZnTcCzc=;
        b=Y9S28UxLRc851Px5cr38OJxewtRuPetm9sPrvhDUt8wBUQBqzPEVa9joOM9trah7zU
         rwoEMqK1N/OCJ9OeDcdP3vGvmO7R0Z4HU6BqJQzIqqcA1L0vnS6BKTcs6e/xUznA407m
         1Wvd4u78uB9lfNunTS0QcbaaLJ0LaYNUVnM1A8QGcuVdB5hsZJAW9ki5hAVMEP06l9dJ
         eZYx6bmajvjXR2XJ5OO0L/XVPgT+IyqtHEWzhxzEaJLQtxEg6lHs2oEAn/h4bVRqjIRB
         sH/vcvq1a4x/UVhWEfkEQNnUOa5o+0XMwX6vGpqfFr1/b4/Hdp98qhpmU+EdM+dInkV/
         7P6g==
X-Gm-Message-State: AOAM530WjbBfBS5d+Ai8SFP+9Y40ADt+01gGh1yYBU2sAQ91LCLbHj34
        +AVeJjrXC99gSGl7G3F2lm5R/KQJnog=
X-Google-Smtp-Source: ABdhPJxlzMm5k1Ku0yCapsJ1WGDPa+EXkUyxXnHPTY/vd9cvc3uXCOOZKqmdxMTS3fQbEJLSLo6Krw==
X-Received: by 2002:a7b:c149:: with SMTP id z9mr4933459wmi.57.1590598080012;
        Wed, 27 May 2020 09:48:00 -0700 (PDT)
Received: from localhost.localdomain ([193.57.121.40])
        by smtp.gmail.com with ESMTPSA id d17sm2432852wrg.75.2020.05.27.09.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 09:47:59 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 02/12] upload-pack: move static vars to upload_pack_data
Date:   Wed, 27 May 2020 18:47:32 +0200
Message-Id: <20200527164742.23067-3-chriscool@tuxfamily.org>
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
more thoroughly, let's move the 'no_done', 'daemon_mode' and
'timeout' variables into this struct.

They are only used by protocol v0 code since protocol v2 assumes
certain baseline capabilities, but rolling them into
upload_pack_data and just letting v2 code ignore them as it does
now is more coherent and cleaner.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 2fa645834a..c83c5a619b 100644
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
@@ -83,18 +80,21 @@ struct upload_pack_data {
 	timestamp_t deepen_since;
 	int deepen_rev_list;
 	int deepen_relative;
+	int timeout;
 
 	struct list_objects_filter_options filter_options;
 
 	struct packet_writer writer;
 
 	unsigned stateless_rpc : 1;
+	unsigned daemon_mode : 1;
 
 	unsigned use_thin_pack : 1;
 	unsigned use_ofs_delta : 1;
 	unsigned no_progress : 1;
 	unsigned use_include_tag : 1;
 	unsigned done : 1;
+	unsigned no_done : 1;
 };
 
 static void upload_pack_data_init(struct upload_pack_data *data)
@@ -130,7 +130,7 @@ static void upload_pack_data_clear(struct upload_pack_data *data)
 	list_objects_filter_release(&data->filter_options);
 }
 
-static void reset_timeout(void)
+static void reset_timeout(int timeout)
 {
 	alarm(timeout);
 }
@@ -246,7 +246,7 @@ static void create_pack_file(struct upload_pack_data *pack_data)
 		int pe, pu, pollsize;
 		int ret;
 
-		reset_timeout();
+		reset_timeout(pack_data->timeout);
 
 		pollsize = 0;
 		pe = pu = -1;
@@ -428,7 +428,7 @@ static int get_common_commits(struct upload_pack_data *data,
 	for (;;) {
 		const char *arg;
 
-		reset_timeout();
+		reset_timeout(data->timeout);
 
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
 			if (multi_ack == 2
@@ -441,7 +441,7 @@ static int get_common_commits(struct upload_pack_data *data,
 			if (data->have_obj.nr == 0 || multi_ack)
 				packet_write_fmt(1, "NAK\n");
 
-			if (no_done && sent_ready) {
+			if (data->no_done && sent_ready) {
 				packet_write_fmt(1, "ACK %s\n", last_hex);
 				return 0;
 			}
@@ -919,7 +919,7 @@ static void receive_needs(struct upload_pack_data *data,
 		struct object_id oid_buf;
 		const char *arg;
 
-		reset_timeout();
+		reset_timeout(data->timeout);
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
 			break;
 
@@ -952,7 +952,7 @@ static void receive_needs(struct upload_pack_data *data,
 		else if (parse_feature_request(features, "multi_ack"))
 			multi_ack = 1;
 		if (parse_feature_request(features, "no-done"))
-			no_done = 1;
+			data->no_done = 1;
 		if (parse_feature_request(features, "thin-pack"))
 			data->use_thin_pack = 1;
 		if (parse_feature_request(features, "ofs-delta"))
@@ -995,7 +995,7 @@ static void receive_needs(struct upload_pack_data *data,
 	if (has_non_tip)
 		check_non_tip(data);
 
-	if (!use_sideband && daemon_mode)
+	if (!use_sideband && data->daemon_mode)
 		data->no_progress = 1;
 
 	if (data->depth == 0 && !data->deepen_rev_list && data->shallows.nr == 0)
@@ -1144,19 +1144,18 @@ void upload_pack(struct upload_pack_options *options)
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
2.27.0.rc2.38.gc6b4ed14d2.dirty

