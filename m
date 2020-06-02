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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B585AC433E2
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96EB22072F
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOD9KbNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgFBER1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgFBERY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 00:17:24 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B3BC061A0E
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 21:17:23 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d128so1616063wmc.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 21:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3SwVy4XIer9kaNRm/s8eWt6zXC5dVG0jMC0DHt9xyqs=;
        b=HOD9KbNWoocxFTZCa6hwR+OPiH96Q62SIjPsyWkMc+WkPMakUJCXRbHFvUbKF18/g+
         ODrQqB7I1PNBmwQh0oAVlUfLkDAHU5BLnQ0ZNtwX6NJNdW2eIQA/u1vY2AAEHS6777g3
         GqZngE0M/OQ7ZsfXC7JFw8ESaAJ0LiBzqs2Ivg1za8gXW39p+NIlxrqmsfT7QgdqwBlE
         ejVg+CBTdTMpeCG2k+5cRDXu9ofngGBEgZA2EYhazjbKVRR6c1f4IT4JoBtZm0mlfX20
         8qsAQ2UzubFVjL5ba8bI8WAadrPKsF5uMfeMkUCVArHA52yMEZ4JMke6yYLiy2XD0MjC
         nJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3SwVy4XIer9kaNRm/s8eWt6zXC5dVG0jMC0DHt9xyqs=;
        b=mHPICewAzZaahmCKdcfCxCFk+mk9zuduL0+E64Iy76Xm7/xLD9Xz6akiwMkrno5mB2
         PwuD2F6jbQEZMchcDPc7/TEisHb+pNWhO3dyBB4bjj/tima3CwAqDkm1xS0i5itQevgM
         n+fbwUeCJP10Z0gr3Lw5oFU2UfuuhOOMOQm9uWIqxTXD/ldJLjKNwIU0npLL1N6+DQXk
         E8TsAmzDMz0VusjLa3IeoReXeU2WqNKkUBMMO5pp/5yCuBNkRqUky80pm5wl5PqgWsdL
         zm0+1KhOUNwV4KIP/n/MEaZ/lPwnLU6EGv8MFZks0NhKZ1w2bnfrgGcyDZwpNkoOazyv
         tTJw==
X-Gm-Message-State: AOAM531ANJK/7hNqeXAL3xicDWK/ivAPFzoln87pX9T1WRfbYfZZaXvg
        Eh9eBqylCs08M5h0qptTnnr5hnCjz8g=
X-Google-Smtp-Source: ABdhPJw+RSw+15LpsWSx4dcINdZwK0mu4NhI8wyItXL5B7a9XGPljhsE50s08W8uH4XgkQShCr0odA==
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr2176404wmk.171.1591071442380;
        Mon, 01 Jun 2020 21:17:22 -0700 (PDT)
Received: from localhost.localdomain ([185.228.230.249])
        by smtp.gmail.com with ESMTPSA id z2sm1717614wrs.87.2020.06.01.21.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 21:17:21 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 05/13] upload-pack: move filter_capability_requested to upload_pack_data
Date:   Tue,  2 Jun 2020 06:16:49 +0200
Message-Id: <20200602041657.7132-6-chriscool@tuxfamily.org>
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
more thoroughly, let's move the filter_capability_requested
static variable into this struct.

It is only used by protocol v0 code since protocol v2 assumes
certain baseline capabilities, but rolling it into
upload_pack_data and just letting v2 code ignore it as it does
now is more coherent and cleaner.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 07798fdc75..6226387a84 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -57,7 +57,6 @@ static struct object_array extra_edge_obj;
 static int keepalive = 5;
 static const char *pack_objects_hook;
 
-static int filter_capability_requested;
 static int allow_filter;
 static int allow_ref_in_want;
 
@@ -93,6 +92,7 @@ struct upload_pack_data {
 	unsigned stateless_rpc : 1;				/* v0 only */
 	unsigned no_done : 1;					/* v0 only */
 	unsigned daemon_mode : 1;				/* v0 only */
+	unsigned filter_capability_requested : 1;		/* v0 only */
 
 	unsigned use_thin_pack : 1;
 	unsigned use_ofs_delta : 1;
@@ -943,7 +943,7 @@ static void receive_needs(struct upload_pack_data *data,
 			continue;
 
 		if (skip_prefix(reader->line, "filter ", &arg)) {
-			if (!filter_capability_requested)
+			if (!data->filter_capability_requested)
 				die("git upload-pack: filtering capability not negotiated");
 			list_objects_filter_die_if_populated(&data->filter_options);
 			parse_list_objects_filter(&data->filter_options, arg);
@@ -976,7 +976,7 @@ static void receive_needs(struct upload_pack_data *data,
 		if (parse_feature_request(features, "include-tag"))
 			data->use_include_tag = 1;
 		if (allow_filter && parse_feature_request(features, "filter"))
-			filter_capability_requested = 1;
+			data->filter_capability_requested = 1;
 
 		o = parse_object(the_repository, &oid_buf);
 		if (!o) {
-- 
2.27.0.rc0.26.g636377a2c4

