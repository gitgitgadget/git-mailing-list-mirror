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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8814C433E1
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3B482072F
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqQvcO/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgFBERb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgFBER1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 00:17:27 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0E5C05BD43
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 21:17:27 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q11so1906177wrp.3
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 21:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Np7aeozVFJVo4XrBmyZ8nDJAXiodOCLak84um66XWpI=;
        b=JqQvcO/RwquFQyjiAq+GqOWlDWJYZ6sSMv1Kox5Ui06VDcloEmhfNb5AINgf0Ae36C
         yK4R5u6s+CQW/T+O+/lQz7M9qTxc1IVD4hD1M9/msYP++W9U/CaaZ6vqJh40vCFL5ERg
         vsVyw+z3WyaeKR9fREjynxiPGYT2F/aaeOu1GTsPtxJ0zX1Os/In9qNmPbdhxhtADKU5
         s97hzJzNOgq9PDIGDGZ9O7JBvFQy2fjxxyx34wcmJkzHgmQ/z4OpIUtmwywGULhsMU1x
         T8p8GBb66PX97WdCOAtpZl09zRBy9p3d/vPnsWL6EQJOZEqSOmmpXCvhfQ8WoGkqVAHD
         Qx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Np7aeozVFJVo4XrBmyZ8nDJAXiodOCLak84um66XWpI=;
        b=fhtdEEh2MpFmIkGlwSxrbxaB/n0z8FcyOKFzcbznrRXDcxFkZOsXeqJQLttfr7pOIP
         rfpUS6BkkypwTsP5T0lCmDSTFd1cwi7NI35Mr8XJWjuoYSyJLjF0SpahfaY9yoXTDHgf
         kDfbQrqKaPEuMMXnxNKN1NG8t2BOEpzhKyA6pImcUPzJcDLPjN4j7PhS9WrJvtvEdFCR
         +HH5J89bcX5wu5lEG74W0h1CgpPyB9LdKnMxHLE94aR0cbPdkxb/2wvKNmVDqVxR16zm
         A/LJ+IAvrnbmPncWfvm03JtH3d6x5stsnLv72O3m6WPDj0ZTL2oXg/bIpJztp26T2Dno
         haLQ==
X-Gm-Message-State: AOAM531fhs0Zc7YXAyoBqehPijI/lsVEu5CbAIhze4qSZppx76TA8/Ss
        rRvSOF08QgE9V87lQIa/OAJl6RHm8Os=
X-Google-Smtp-Source: ABdhPJzbRjpR145EFqFZOEBN5g3SHi2QwPCtyKvOVarseWUtZcJ4s3NDrWcqoJQE9qBodPCZ/6/pWg==
X-Received: by 2002:a05:6000:1192:: with SMTP id g18mr25845322wrx.326.1591071445861;
        Mon, 01 Jun 2020 21:17:25 -0700 (PDT)
Received: from localhost.localdomain ([185.228.230.249])
        by smtp.gmail.com with ESMTPSA id z2sm1717614wrs.87.2020.06.01.21.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 21:17:25 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 08/13] upload-pack: pass upload_pack_data to upload_pack_config()
Date:   Tue,  2 Jun 2020 06:16:52 +0200
Message-Id: <20200602041657.7132-9-chriscool@tuxfamily.org>
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
more thoroughly, let's pass that struct to upload_pack_config(),
so that this function can use all the fields of the struct.

This will be used in followup commits to move static variables
that are set in upload_pack_config() into 'upload_pack_data'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 83270452d4..7b0954794a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1113,7 +1113,7 @@ static int find_symref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-static int upload_pack_config(const char *var, const char *value, void *unused)
+static int upload_pack_config(const char *var, const char *value, void *cb_data)
 {
 	if (!strcmp("uploadpack.allowtipsha1inwant", var)) {
 		if (git_config_bool(var, value))
@@ -1158,10 +1158,10 @@ void upload_pack(struct upload_pack_options *options)
 	struct packet_reader reader;
 	struct upload_pack_data data;
 
-	git_config(upload_pack_config, NULL);
-
 	upload_pack_data_init(&data);
 
+	git_config(upload_pack_config, &data);
+
 	data.stateless_rpc = options->stateless_rpc;
 	data.daemon_mode = options->daemon_mode;
 	data.timeout = options->timeout;
@@ -1491,11 +1491,11 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 
 	clear_object_flags(ALL_FLAGS);
 
-	git_config(upload_pack_config, NULL);
-
 	upload_pack_data_init(&data);
 	data.use_sideband = LARGE_PACKET_MAX;
 
+	git_config(upload_pack_config, &data);
+
 	while (state != FETCH_DONE) {
 		switch (state) {
 		case FETCH_PROCESS_ARGS:
-- 
2.27.0.rc0.26.g636377a2c4

