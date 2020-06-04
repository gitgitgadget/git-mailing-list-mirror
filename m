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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FBBC433E0
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04AFC20738
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYDggUJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbgFDRza (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730339AbgFDRzY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 13:55:24 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10721C08C5C0
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 10:55:24 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r9so6094090wmh.2
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 10:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rp+KI8HHhRsLIJaPWde4PVHjOxys+D0eD5bN7m2VPPg=;
        b=pYDggUJ/CMcjkSqCFb4TbLeV4fl4ovippJMgfVE9/lCUvwkuGFXtj8BLAMdM/qKsaX
         xk3aHT90WYYraNwmTM64E/IbXMMRkj1s3bomhrMJRgS5YPsVQ1LWmbFnokQMcwelSR6i
         70sixyiLANzn+ZjD4cMP3hGjH1AdTShLwntoJUqh6zU2AnpMbfVZVE6gJ7gDS/VDQNx0
         EmJ9jxmq7VrRPX2PdcP480ojlkwE+C6z+iUVuK6kWuKPrer8YvqkWrkcsqo2WQNDdJuu
         zgzcPi5Mhh6Z+lSupZUGjpHPktMYGVBsLdgCkReJH6g9b3ycGtYa82hQq/J3tsDAol95
         z80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rp+KI8HHhRsLIJaPWde4PVHjOxys+D0eD5bN7m2VPPg=;
        b=hfd98ekdTeu56eEpaKt/OEdNOTngU9w4dRTKwKJBDLGj/RmpJuR2r+tMEYVYBqyRw6
         tx+r9SptBU+EZw4HLH5Os3kpAtr66vsTtRg3I1zxYSIbwqi2IMVAEFCvOpG1yxYogtbJ
         NU+iQfadvEEwIfV2CfwGg3/abi0g/h2L5vU8u7Ynw2gnPH9IkVxVkyq4yEzaCdeWFlkc
         pTe/eO+hrRG9z4iul4BS6XOAIbSoZDGVVOjPBSF6shwc/Geg3k3lHOwgQxI3t1jHwPHR
         dhgpqGGUpRnQAj/nBfywQLTnBRoijFjjq1CmZtJLK49+ivpa23jzUsYzX2cmctgvW/KJ
         ekqg==
X-Gm-Message-State: AOAM5328hpPGULXuJWMfEYT7xuCGgvY/wJpCUdaGc3/46Vg8Vt7tERgc
        GlikJkwc2muTbczAqM9+27cG67pcPrg=
X-Google-Smtp-Source: ABdhPJy1uyBYWXq3xCOzcJal+mo+XUebQZ59KnVJuh36umjVnTuQwnJOcu/jFtT4vudun7txNlwDMQ==
X-Received: by 2002:a1c:4b0f:: with SMTP id y15mr5431132wma.83.1591293322482;
        Thu, 04 Jun 2020 10:55:22 -0700 (PDT)
Received: from localhost.localdomain ([185.228.231.251])
        by smtp.gmail.com with ESMTPSA id s7sm9173540wrr.60.2020.06.04.10.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 10:55:21 -0700 (PDT)
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
Subject: [PATCH v3 12/13] upload-pack: move allow_sideband_all to upload_pack_data
Date:   Thu,  4 Jun 2020 19:54:49 +0200
Message-Id: <20200604175450.17385-13-chriscool@tuxfamily.org>
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
more thoroughly, let's move the 'allow_sideband_all' static
variable into this struct.

It is used only by protocol v2 code.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Acked-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 upload-pack.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 0d75745d8d..78b10a89ea 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -55,8 +55,6 @@ static int shallow_nr;
 static struct object_array extra_edge_obj;
 static const char *pack_objects_hook;
 
-static int allow_sideband_all;
-
 /*
  * Please annotate, and if possible group together, fields used only
  * for protocol v0 or only for protocol v2.
@@ -103,6 +101,7 @@ struct upload_pack_data {
 
 	unsigned done : 1;					/* v2 only */
 	unsigned allow_ref_in_want : 1;				/* v2 only */
+	unsigned allow_sideband_all : 1;			/* v2 only */
 };
 
 static void upload_pack_data_init(struct upload_pack_data *data)
@@ -1146,7 +1145,7 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 	} else if (!strcmp("uploadpack.allowrefinwant", var)) {
 		data->allow_ref_in_want = git_config_bool(var, value);
 	} else if (!strcmp("uploadpack.allowsidebandall", var)) {
-		allow_sideband_all = git_config_bool(var, value);
+		data->allow_sideband_all = git_config_bool(var, value);
 	} else if (!strcmp("core.precomposeunicode", var)) {
 		precomposed_unicode = git_config_bool(var, value);
 	}
@@ -1341,7 +1340,7 @@ static void process_args(struct packet_reader *request,
 		}
 
 		if ((git_env_bool("GIT_TEST_SIDEBAND_ALL", 0) ||
-		     allow_sideband_all) &&
+		     data->allow_sideband_all) &&
 		    !strcmp(arg, "sideband-all")) {
 			data->writer.use_sideband = 1;
 			continue;
-- 
2.27.0.rc0.26.gf2851482f5

