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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F3AC433E4
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42CFB207D8
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhyzJyYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgFBERd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgFBERb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 00:17:31 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDE9C03E96E
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 21:17:31 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u13so1488445wml.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 21:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0CJKvz+UIq0ulYA4LkhhU+1iCSl0n0xCGNT6PVAPelU=;
        b=bhyzJyYenCaMx2leh76WtgQSnFRcH/x+SPv5RX0aYOwet4JsPzmHM5ynkWMC6kG5vF
         UEz/qoNMgVhWjUh+J4kJeFsCDl0dvGDMEY9C8n8mJ/ru0HLjEMT2J1cBE8/aiIL3hfsR
         NwIG0P+RFr6Stkn+tstrDI/suNUbTAYBPZalwUW684nBNddwlLZYT337//kzTEJqnHXm
         FnQiPXKXMFCkDKdA2TaCm9odjlP18/IBHkkly36aek0dGEA0mox2rmjO5Y0+CVpVu3Ni
         k2Q5BhVF6RF2ETNa40zuxJhzEYinvqN9T7YGAT8uI68nfUN3KuHN/gh6VkJXF8dWxEag
         inNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0CJKvz+UIq0ulYA4LkhhU+1iCSl0n0xCGNT6PVAPelU=;
        b=DuQRdwcT0P9aPlmn64zENcxbbin4Koor5xHO2DfSd/Db5MpfDohpnawhkbCHA2/1HA
         J4FGnP8OhHZYYu1nwwWNBuwNdKBKico15I635mLLZmb//YgI0l9WHdLrZkIx8Aksncah
         BqptFETuIizppQSmzWJaBTJnLInJ15w4gcEcfjrRBoSOueuiiV4zmnVwCMxGVPSLG6Sp
         PpNRZF4i3pzmrArFi4HDqfBam+UfCGdP56r4yo8cPEIwC3zxkWbM9AF+EobZ/AWmODqI
         AlaYHdIMUFFm+7/OJa8Uawbitbm3x3EN5yonoLhk62VhFLigdjoZTa1GxTgxD6rs3nSd
         ippg==
X-Gm-Message-State: AOAM53354sf2SiV3r8qTKmLLGy3DQ9zfnnIE4xYRiZ6sgZh/PuHUo6sS
        6lhBlb6IrdMbMQGkeYuGQjv0HgxzmSM=
X-Google-Smtp-Source: ABdhPJzEDrU9VtYTplObUc5oTK61iZD0gsdzmGKVURrYUbDuksiRywzQjqVdaKIK38rqw/m59N/q/A==
X-Received: by 2002:a1c:9d53:: with SMTP id g80mr2370462wme.13.1591071449627;
        Mon, 01 Jun 2020 21:17:29 -0700 (PDT)
Received: from localhost.localdomain ([185.228.230.249])
        by smtp.gmail.com with ESMTPSA id z2sm1717614wrs.87.2020.06.01.21.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 21:17:29 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 11/13] upload-pack: move allow_ref_in_want to upload_pack_data
Date:   Tue,  2 Jun 2020 06:16:55 +0200
Message-Id: <20200602041657.7132-12-chriscool@tuxfamily.org>
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
more thoroughly, let's move the 'allow_ref_in_want' static
variable into this struct.

It is used only by protocol v2 code.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 538160801d..3c00d79443 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -55,8 +55,6 @@ static int shallow_nr;
 static struct object_array extra_edge_obj;
 static const char *pack_objects_hook;
 
-static int allow_ref_in_want;
-
 static int allow_sideband_all;
 
 /*
@@ -104,6 +102,7 @@ struct upload_pack_data {
 	unsigned allow_filter : 1;
 
 	unsigned done : 1;					/* v2 only */
+	unsigned allow_ref_in_want : 1;				/* v2 only */
 };
 
 static void upload_pack_data_init(struct upload_pack_data *data)
@@ -1145,7 +1144,7 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 	} else if (!strcmp("uploadpack.allowfilter", var)) {
 		data->allow_filter = git_config_bool(var, value);
 	} else if (!strcmp("uploadpack.allowrefinwant", var)) {
-		allow_ref_in_want = git_config_bool(var, value);
+		data->allow_ref_in_want = git_config_bool(var, value);
 	} else if (!strcmp("uploadpack.allowsidebandall", var)) {
 		allow_sideband_all = git_config_bool(var, value);
 	} else if (!strcmp("core.precomposeunicode", var)) {
@@ -1289,7 +1288,7 @@ static void process_args(struct packet_reader *request,
 		/* process want */
 		if (parse_want(&data->writer, arg, &data->want_obj))
 			continue;
-		if (allow_ref_in_want &&
+		if (data->allow_ref_in_want &&
 		    parse_want_ref(&data->writer, arg, &data->wanted_refs,
 				   &data->want_obj))
 			continue;
-- 
2.27.0.rc0.26.g636377a2c4

