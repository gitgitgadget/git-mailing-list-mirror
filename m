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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D4CC433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B22642071A
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiguL2pw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgE0QsV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 12:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgE0QsL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 12:48:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F365C05BD1E
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:48:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k26so60906wmi.4
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Np3x3lXNMsgPvQ0nMmzplFldIsfuVyoocsuMGjjF55I=;
        b=UiguL2pwLlxGwxskf1UnFIy/q8L07kfJKYSKWixs2wO/xP8dWDcuZP76VGfdK3KreY
         mb44wIFnzrX11aRiUaLRPSR8ohaD67JvOC2DGKuitSf6vgwsU/OiskO1/QouCUZv1lPy
         zDrRRarx9GWQEsPQIXFBnXfBojLpFjGJrGMp+4NR6TZIoOhI4knf5QA8Y+E+6Vxd69wy
         Mx1t3mbjC/FlqLagQ5+7lassm9w35znQ3OAaXiEr/Bc9uWoWG/erUfV57m62vst/cb20
         RECBjrotwUBKK6BkhKprzECNL6N0Z750Eknt7Z+Pdu/PZXtaIHvRsj1/Vmx5dVOUwMMK
         B/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Np3x3lXNMsgPvQ0nMmzplFldIsfuVyoocsuMGjjF55I=;
        b=Pvm9Rg/nhcid0hBlCr3Jd19K/SH5cO8B7FMXhYmEPp6C3p+50uwxsDcn8jUwyBKqFx
         GnFb7q1Lw02RwHuCfxpztCqxQyLhQe1R7TFVMmBCXPldtbtX7pRVZjW1Heb9zhYhk+U5
         eFqEpAlYPQyvREH4MpQuieQHTNodP0pYXSFvO+m9zF4EoMqMpKEerHW1TZXk3PNQy8aE
         z7Wsel1On21ZzK+256OvspVUqHeLFiAmZNRMwMrRJnfRvpfUTj77ManO+e3xdKli0CdI
         5VabvUxMw7r3Rxs4NGDv9jcLb5DVViRZs6koW3iqE/P5MeowzX9TDU2TcNzefkJ423ct
         2Z/g==
X-Gm-Message-State: AOAM530hPAocbaNUIponot+SR5k8KmfhrnZWNNNv+5O0sdislvYASzQ7
        6HgBpZ+SXyyh8ng1xUNY5zzM6oma/mo=
X-Google-Smtp-Source: ABdhPJyoSaE6rputAc7wETKHaScrXJLUopDhmLlz3r9irqxYDd0wrYjxMY8aCZPCtBBtx+sQlYMBng==
X-Received: by 2002:a7b:c399:: with SMTP id s25mr5420619wmj.185.1590598089571;
        Wed, 27 May 2020 09:48:09 -0700 (PDT)
Received: from localhost.localdomain ([193.57.121.40])
        by smtp.gmail.com with ESMTPSA id d17sm2432852wrg.75.2020.05.27.09.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 09:48:08 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 10/12] upload-pack: move allow_ref_in_want to upload_pack_data
Date:   Wed, 27 May 2020 18:47:40 +0200
Message-Id: <20200527164742.23067-11-chriscool@tuxfamily.org>
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
more thoroughly, let's move the 'allow_ref_in_want' static
variable into this struct.

It is only used by protocol v0 code since protocol v2 assumes
certain baseline capabilities, but rolling it into
upload_pack_data and just letting v2 code ignore it as it does
now is more coherent and cleaner.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 10bafeb8b6..b5647eb47c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -55,8 +55,6 @@ static int shallow_nr;
 static struct object_array extra_edge_obj;
 static const char *pack_objects_hook;
 
-static int allow_ref_in_want;
-
 static int allow_sideband_all;
 
 struct upload_pack_data {
@@ -100,6 +98,7 @@ struct upload_pack_data {
 	unsigned filter_capability_requested : 1;
 
 	unsigned allow_filter : 1;
+	unsigned allow_ref_in_want : 1;
 };
 
 static void upload_pack_data_init(struct upload_pack_data *data)
@@ -1141,7 +1140,7 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 	} else if (!strcmp("uploadpack.allowfilter", var)) {
 		data->allow_filter = git_config_bool(var, value);
 	} else if (!strcmp("uploadpack.allowrefinwant", var)) {
-		allow_ref_in_want = git_config_bool(var, value);
+		data->allow_ref_in_want = git_config_bool(var, value);
 	} else if (!strcmp("uploadpack.allowsidebandall", var)) {
 		allow_sideband_all = git_config_bool(var, value);
 	} else if (!strcmp("core.precomposeunicode", var)) {
@@ -1285,7 +1284,7 @@ static void process_args(struct packet_reader *request,
 		/* process want */
 		if (parse_want(&data->writer, arg, &data->want_obj))
 			continue;
-		if (allow_ref_in_want &&
+		if (data->allow_ref_in_want &&
 		    parse_want_ref(&data->writer, arg, &data->wanted_refs,
 				   &data->want_obj))
 			continue;
-- 
2.27.0.rc2.38.gc6b4ed14d2.dirty

