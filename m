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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649C4C433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D94C20873
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STGX5SsV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbgE0QsI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 12:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbgE0QsE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 12:48:04 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24549C03E97D
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:48:04 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s8so24656036wrt.9
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZTBtRVojsFooRQ8A/hfME/j5z9yFbNPFFADrvRLzKdc=;
        b=STGX5SsVkKbg7UbOGp7WW+m9yfnumY1dhMg+GZfXIyrm/O7kjJcI4Qe2PF4vizRaPh
         2fypruU6YcMEZJ9zijyPbU5A4+zdYQ0W9+0/r6qQ/LH48Soy1s7Tn35Ug7KuBICWuPAs
         hYP+Ux9ZzJsEeEMCTHt7EhviEDTx7KUFn+8dC/474zO4hYSDoQ1zeY2QoDw8FeSJbzkz
         zHIbBTCHudldSUbQDl2oEQu7dAbGBRIO/zOnwFrXp0RQmKjIEmWUehorSuwx6ApOoszy
         1778iAnl0LKgwupERnl3Yb1fQLozrWdD0jZ6IbVE6hGWgB+3xC+g4sy3k3xvbtOgdRoa
         sjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZTBtRVojsFooRQ8A/hfME/j5z9yFbNPFFADrvRLzKdc=;
        b=bdoK90lxwQHCRBiAfAH8eND/JDTep6S/Xny/vEisAg/VYuabSfWD/LfleqiwTSlwDS
         d7IVbtEF4NTt/5rE51x4PWMfJCrt8pqoILZjXsL1W1J2osgPj4S9zzks/q3W5siy1i5O
         hwtd4EJjOExaT59XdzydMhG1gfBJyu/WNj0vjdnpJ8XbJAh3x3hSJ9BDyHzN1S+O97qS
         0T+Awhua1w3YYDCl0N0IFg3PhkK3VaoieOux1g7NDqj0epP1HZZHF7KAP6ehtJR8AQKL
         H4nU4mujOz77xrCeeKOwnxX31yffNRUffRhhh/iSYLcQNDFhDEAxo9A9G8wOfdI6OuNN
         HD9w==
X-Gm-Message-State: AOAM531qQdOLZqG+sl/OkMC1aiIyJc1urqpZY8offcf9/CEdqoUJeSyH
        FPCZ3lhhuNopZWQc8UIxmknnRdLptpM=
X-Google-Smtp-Source: ABdhPJzi8dBey89Dfs6Ifha3Zj1mpK2DPf4r6Rfu08AhYk9h9HW4DWmkr0ylrDnb6KGPn6i6bmbtHg==
X-Received: by 2002:adf:a15c:: with SMTP id r28mr24306279wrr.337.1590598082488;
        Wed, 27 May 2020 09:48:02 -0700 (PDT)
Received: from localhost.localdomain ([193.57.121.40])
        by smtp.gmail.com with ESMTPSA id d17sm2432852wrg.75.2020.05.27.09.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 09:48:01 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 04/12] upload-pack: move filter_capability_requested to upload_pack_data
Date:   Wed, 27 May 2020 18:47:34 +0200
Message-Id: <20200527164742.23067-5-chriscool@tuxfamily.org>
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
index a5a9750890..e81b326690 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -57,7 +57,6 @@ static struct object_array extra_edge_obj;
 static int keepalive = 5;
 static const char *pack_objects_hook;
 
-static int filter_capability_requested;
 static int allow_filter;
 static int allow_ref_in_want;
 
@@ -94,6 +93,7 @@ struct upload_pack_data {
 	unsigned use_include_tag : 1;
 	unsigned done : 1;
 	unsigned no_done : 1;
+	unsigned filter_capability_requested : 1;
 };
 
 static void upload_pack_data_init(struct upload_pack_data *data)
@@ -937,7 +937,7 @@ static void receive_needs(struct upload_pack_data *data,
 			continue;
 
 		if (skip_prefix(reader->line, "filter ", &arg)) {
-			if (!filter_capability_requested)
+			if (!data->filter_capability_requested)
 				die("git upload-pack: filtering capability not negotiated");
 			list_objects_filter_die_if_populated(&data->filter_options);
 			parse_list_objects_filter(&data->filter_options, arg);
@@ -970,7 +970,7 @@ static void receive_needs(struct upload_pack_data *data,
 		if (parse_feature_request(features, "include-tag"))
 			data->use_include_tag = 1;
 		if (allow_filter && parse_feature_request(features, "filter"))
-			filter_capability_requested = 1;
+			data->filter_capability_requested = 1;
 
 		o = parse_object(the_repository, &oid_buf);
 		if (!o) {
-- 
2.27.0.rc2.38.gc6b4ed14d2.dirty

