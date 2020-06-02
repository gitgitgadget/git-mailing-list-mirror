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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D667C433DF
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D79320734
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYqOvd6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgFBERe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgFBERa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 00:17:30 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC7FC05BD43
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 21:17:29 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q25so1624346wmj.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 21:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2CppxbExBykFK5mnLcgyF9QicP4tdGzI/8+stg+2sRw=;
        b=jYqOvd6JG7SaEYk5aOI6xfOHRFdKy2+n/M2P5iNzLj+SPZfExGPImhHOHWGK1A1ayU
         irx82MldUZ4ymIdNGUR2D4eShwAavIGUOL8fwNSM+mgsUd4Xa3P3F5xl9PW4WnR9yBnD
         8v+N0xbL9vCDtHCQeo/Jgn6nwmspzgAbcLjH7n7eCUvQ5frBKg3Hsqwq3POUJ1ojJ7Zt
         yRivPR6JBVZv66iUHDrFCibKfIPnEGukUYdDLK3VEdBluajfQXQdCE7h0Sj8Lcy3uBcL
         E4yhUk9SSZPMHISVFGa1XktiPbZK1j27VnwHICN057FLV9PRYYKdmGBYuXQ+Gngc2r2X
         cfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2CppxbExBykFK5mnLcgyF9QicP4tdGzI/8+stg+2sRw=;
        b=ijom9eZqUAzV1C2DNgXfWURr68dgl4kU4QLGjMJ3v9bZEx91G/30ICAnXkseabBEwJ
         78GbsUXjbd/iwM5ZiqKbquyhAVfLSMDnSTx5atQ02kjGYGdzTOIPdGlYem/JxbVOHilv
         9yg+Fm55fNKDYyUHdPlEAOCOMmGpr83cXwaDN5qo+b7TMWe7hZ12qVghrR4s9qZyIZco
         280Ev7vQZArw31pajqnyxZou6u9rWWvm9rPYRcrwSO6CIYN9MCPRYSPcoABoiOrK7ZO8
         /tSKRRngboue8gzMwZsadTnNGeWteMK8M8w9nR1JDXqpJsK1ysZ5JdDJQlsrti0i2OUd
         F9YQ==
X-Gm-Message-State: AOAM531mLnx1CQNb2i/i06OFeX7HS1caxQef1xykI+8oglsSGHiNo6ZL
        TEQPIQPnpqraho8rl0QXR1A5VF+qYTg=
X-Google-Smtp-Source: ABdhPJzEE8hE888F12hienItnS9pg+fmysFOancIEJvZQffhO7Tzqi7mJ/GgbyPAdc4IEDciRPvd1w==
X-Received: by 2002:a1c:7f44:: with SMTP id a65mr2352988wmd.53.1591071448280;
        Mon, 01 Jun 2020 21:17:28 -0700 (PDT)
Received: from localhost.localdomain ([185.228.230.249])
        by smtp.gmail.com with ESMTPSA id z2sm1717614wrs.87.2020.06.01.21.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 21:17:27 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 10/13] upload-pack: move allow_filter to upload_pack_data
Date:   Tue,  2 Jun 2020 06:16:54 +0200
Message-Id: <20200602041657.7132-11-chriscool@tuxfamily.org>
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
more thoroughly, let's move the 'allow_filter' static variable
into this struct.

It is used by both protocol v0 and protocol v2 code.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 2695b52147..538160801d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -55,7 +55,6 @@ static int shallow_nr;
 static struct object_array extra_edge_obj;
 static const char *pack_objects_hook;
 
-static int allow_filter;
 static int allow_ref_in_want;
 
 static int allow_sideband_all;
@@ -102,6 +101,7 @@ struct upload_pack_data {
 	unsigned use_ofs_delta : 1;
 	unsigned no_progress : 1;
 	unsigned use_include_tag : 1;
+	unsigned allow_filter : 1;
 
 	unsigned done : 1;					/* v2 only */
 };
@@ -984,7 +984,8 @@ static void receive_needs(struct upload_pack_data *data,
 			data->no_progress = 1;
 		if (parse_feature_request(features, "include-tag"))
 			data->use_include_tag = 1;
-		if (allow_filter && parse_feature_request(features, "filter"))
+		if (data->allow_filter &&
+		    parse_feature_request(features, "filter"))
 			data->filter_capability_requested = 1;
 
 		o = parse_object(the_repository, &oid_buf);
@@ -1090,7 +1091,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 				     " allow-reachable-sha1-in-want" : "",
 			     data->stateless_rpc ? " no-done" : "",
 			     symref_info.buf,
-			     allow_filter ? " filter" : "",
+			     data->allow_filter ? " filter" : "",
 			     git_user_agent_sanitized());
 		strbuf_release(&symref_info);
 	} else {
@@ -1142,7 +1143,7 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 		if (!data->keepalive)
 			data->keepalive = -1;
 	} else if (!strcmp("uploadpack.allowfilter", var)) {
-		allow_filter = git_config_bool(var, value);
+		data->allow_filter = git_config_bool(var, value);
 	} else if (!strcmp("uploadpack.allowrefinwant", var)) {
 		allow_ref_in_want = git_config_bool(var, value);
 	} else if (!strcmp("uploadpack.allowsidebandall", var)) {
@@ -1334,7 +1335,7 @@ static void process_args(struct packet_reader *request,
 			continue;
 		}
 
-		if (allow_filter && skip_prefix(arg, "filter ", &p)) {
+		if (data->allow_filter && skip_prefix(arg, "filter ", &p)) {
 			list_objects_filter_die_if_populated(&data->filter_options);
 			parse_list_objects_filter(&data->filter_options, p);
 			continue;
-- 
2.27.0.rc0.26.g636377a2c4

