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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16869C433DF
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECD38206DC
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csxsXnV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgFDRzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730322AbgFDRzU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 13:55:20 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E35EC08C5C0
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 10:55:20 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h5so7098733wrc.7
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 10:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NsnmZbntEmSHnE0k9YV//POIaRzxQCkfQqAxlzppKoo=;
        b=csxsXnV1jN1uGMmJf+RMzJ0AQJzQS5NswdpzCL6iOfCkpIoQdkYs1S3GYmF9zD7fQJ
         l2KUTeivVItGSdYLhwPz4pPc8g4r57HsxSO2DjfVbeOr9U3pW0SPP10TcS+01OPL5yqf
         VtC67Wqt7AsfX0KY7A02JpyBBpUc2J4ciwiCOWZx6t1jme6W/aw318oCAf5UUXROFLkG
         ffAGQnQrxAn0JK/xd9ucyiFC9NuEJ+Q6dV/dSP5wlesehl4CP/QDN3gwVL7SouV+piG0
         HLvmb5/drO3Y00noTDSOPJoocS66AtPVITuvTPua3lK9p4C7YKifMB2y5f3XObtJa2mx
         i6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NsnmZbntEmSHnE0k9YV//POIaRzxQCkfQqAxlzppKoo=;
        b=kpoDVN14DYA3Z1bp3OZYGzu2mfcK3BEhiVaclIHilLPU6j0KbyU9xm5mSjhlvTHlXF
         VlM0BWQvdWBDLChNZWbh5z86q2PGgj6Sch2FJERLzvzIuilPL8PLSbRzZXTzyoVKTojz
         kHQ7+mTGxuUCWgo2RKu7s8dNhSAl2U4l7TCzbbnVRVnNLFOO3SlTbnC1/iVBoJq/TtWt
         OQM2LdeDaBfFSxbE3FeDmbGIl6DX1MKuXpRz1Zm/GRR3511Zp/+jRFNsB6OL/H+MGOSc
         SfYRhT0iE9LJXJjOY+tSHAgFr40JeowQr7pesO7xNWKKLpH5APvhG+QRr4wblYe4wVZr
         4gNQ==
X-Gm-Message-State: AOAM531K5ycJ0o6MZRMiJaJcBI3TQoIUg/C2sxEgsqwYbeR5fRXJPgdj
        /JE9U7TD35vIqcrBSNepj6/wdLUP1tA=
X-Google-Smtp-Source: ABdhPJyqJqjMjGSn2v1GB46ee6emc91wmAItn9GVsHppm7j7HHb/8A1d9mGfPCpwlnsFb0+jLtGVfw==
X-Received: by 2002:a05:6000:12c4:: with SMTP id l4mr5938910wrx.128.1591293318595;
        Thu, 04 Jun 2020 10:55:18 -0700 (PDT)
Received: from localhost.localdomain ([185.228.231.251])
        by smtp.gmail.com with ESMTPSA id s7sm9173540wrr.60.2020.06.04.10.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 10:55:18 -0700 (PDT)
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
Subject: [PATCH v3 09/13] upload-pack: move keepalive to upload_pack_data
Date:   Thu,  4 Jun 2020 19:54:46 +0200
Message-Id: <20200604175450.17385-10-chriscool@tuxfamily.org>
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
more thoroughly, let's move the 'keepalive' static variable
into this struct.

It is used by code common to protocol v0 and protocol v2.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Acked-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 upload-pack.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index b846aa4728..0eb4c32552 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -53,7 +53,6 @@ static timestamp_t oldest_have;
 static unsigned int allow_unadvertised_object_request;
 static int shallow_nr;
 static struct object_array extra_edge_obj;
-static int keepalive = 5;
 static const char *pack_objects_hook;
 
 static int allow_filter;
@@ -78,6 +77,7 @@ struct upload_pack_data {
 	timestamp_t deepen_since;
 	int deepen_rev_list;
 	int deepen_relative;
+	int keepalive;
 
 	unsigned int timeout;					/* v0 only */
 	enum {
@@ -125,6 +125,8 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	data->shallows = shallows;
 	data->deepen_not = deepen_not;
 	packet_writer_init(&data->writer, 1);
+
+	data->keepalive = 5;
 }
 
 static void upload_pack_data_clear(struct upload_pack_data *data)
@@ -253,7 +255,7 @@ static void create_pack_file(struct upload_pack_data *pack_data)
 
 	while (1) {
 		struct pollfd pfd[2];
-		int pe, pu, pollsize;
+		int pe, pu, pollsize, polltimeout;
 		int ret;
 
 		reset_timeout(pack_data->timeout);
@@ -277,8 +279,11 @@ static void create_pack_file(struct upload_pack_data *pack_data)
 		if (!pollsize)
 			break;
 
-		ret = poll(pfd, pollsize,
-			keepalive < 0 ? -1 : 1000 * keepalive);
+		polltimeout = pack_data->keepalive < 0
+			? -1
+			: 1000 * pack_data->keepalive;
+
+		ret = poll(pfd, pollsize, polltimeout);
 
 		if (ret < 0) {
 			if (errno != EINTR) {
@@ -1115,6 +1120,8 @@ static int find_symref(const char *refname, const struct object_id *oid,
 
 static int upload_pack_config(const char *var, const char *value, void *cb_data)
 {
+	struct upload_pack_data *data = cb_data;
+
 	if (!strcmp("uploadpack.allowtipsha1inwant", var)) {
 		if (git_config_bool(var, value))
 			allow_unadvertised_object_request |= ALLOW_TIP_SHA1;
@@ -1131,9 +1138,9 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 		else
 			allow_unadvertised_object_request &= ~ALLOW_ANY_SHA1;
 	} else if (!strcmp("uploadpack.keepalive", var)) {
-		keepalive = git_config_int(var, value);
-		if (!keepalive)
-			keepalive = -1;
+		data->keepalive = git_config_int(var, value);
+		if (!data->keepalive)
+			data->keepalive = -1;
 	} else if (!strcmp("uploadpack.allowfilter", var)) {
 		allow_filter = git_config_bool(var, value);
 	} else if (!strcmp("uploadpack.allowrefinwant", var)) {
-- 
2.27.0.rc0.26.gf2851482f5

