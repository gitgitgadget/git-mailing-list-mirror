Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37CFC433E0
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7ED92067B
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmUNM+14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbgFDRzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730306AbgFDRzP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 13:55:15 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB303C08C5C0
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 10:55:13 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l26so6082697wme.3
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 10:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jX0AK5luiXylzslMicIct5yR3Rg8SQteEy29aY+m6IQ=;
        b=HmUNM+14V9T2JyHyiCPffmbNsEDbDDVkhuv9PRZfQFrea4F8uHaMhNlbS4B8iArN8r
         7wDqBJz5QCmYP7wTLzTNEreulkbXyO+PnboZqI47UqQBgV+cFPgOsW7nIuEihAcj7ZOu
         tWJw/vuXP1DX7IynJenAz91u1BITcEN7qeUoFALzROQz891AkJQLetFs8aQxXgvxBIzK
         wKPLm1mwmGuDplOcj6CljLQICWHK039bd+X5Dnoos11ZXCBt3w0HpsImaOWgWbRY4AVG
         CWeLovX+RjpzKzhYK4InoVTDFXb1iEhSRNZHFElUlJ5RxErZe7QXVCKHS9O9urVIhYnG
         NG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jX0AK5luiXylzslMicIct5yR3Rg8SQteEy29aY+m6IQ=;
        b=G7KrzRx2afDhvNm6WuWWk9OQqhXpesU2uuE0MgBKIik8QnVTlGCQFhgUiVyGMMs+Uw
         EsI9rHQYM4nerObiW0mGHd0q+RlXXOtJp9cVk6CicjWssQLbJdOUvukbwhYxLstuC0gw
         qdGuqPyjOJjjBhe6KISElWiEotNy6Mx7Ge6f8x5aAXTvc6eI1yjusshlKo7kgE4Jd1ey
         9dqlTZljw/QmvB1raEuFUDuJQ9yij4IO3R5vuxX6YiJLanc6TK6SzKvQClyx2qePiUe2
         ZzuufZrU9fJR/93yO3Vu+NQRdrsA1cy/e/rg4LYjR/0Jvk6PX5JjtLwhmvNXTk7vjVXg
         dPLg==
X-Gm-Message-State: AOAM531rWE9pyiP49js9QAqAKRkoKAyWJVmL6v41zNyrliatOr6R6mHp
        Qe2iSTNDCyCa7+1slwtVNUxGs6/yu0w=
X-Google-Smtp-Source: ABdhPJxYHaJxPm/5cGEfDjpigCJSDgJ4gU6jhARAxhAjbTgOYjrOke7T14mt8KmpYISsbn26k6vxlQ==
X-Received: by 2002:a1c:d7:: with SMTP id 206mr5068347wma.15.1591293312180;
        Thu, 04 Jun 2020 10:55:12 -0700 (PDT)
Received: from localhost.localdomain ([185.228.231.251])
        by smtp.gmail.com with ESMTPSA id s7sm9173540wrr.60.2020.06.04.10.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 10:55:11 -0700 (PDT)
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
Subject: [PATCH v3 04/13] upload-pack: move use_sideband to upload_pack_data
Date:   Thu,  4 Jun 2020 19:54:41 +0200
Message-Id: <20200604175450.17385-5-chriscool@tuxfamily.org>
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
more thoroughly, let's move the 'use_sideband' static variable
into this struct.

This variable is used by both v0 and v2 protocols.

While at it, let's update the comment near the variable
definition.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Acked-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.27.0.rc0.26.gf2851482f5

