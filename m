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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2C6C433E1
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB3A42071A
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+wSOgF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbgE0QsW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 12:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbgE0QsH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 12:48:07 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735F0C03E97D
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:48:07 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e1so24723740wrt.5
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=biXD0PSbZHQ5kb+Lge2gnrWpM40mlglFMgRt9Fibc7I=;
        b=W+wSOgF2hTbJEo2wDxI0BEMVN558SyGEniUkhp29HCNBcRkest17IOYm8vKGju93PG
         /4HNk/Ts/7PZOFLsrWxzigGshY2/f1ciS7sL+ow/gPd174th1344Mxv+AgNdMQzzvXYK
         Nn2FY6mwRfacuS8m0Kd+SVP1Tp8cZ9VWoYNLpizQn7POlPvvUjXT24rEWFIk9r2eaCWz
         xO4LRaPA2GYYWLreKQ3pHLzWMKF1IBzsaKz4EWswRZbFAqV9uneDIWnXqO/atr6E0Sfm
         xN6mm71CMEa9UUwNq+IaPkP0oF4J2X4WJBYetO6oKk9/9/fAFsHf3ACaWMU1m1znK38a
         zOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=biXD0PSbZHQ5kb+Lge2gnrWpM40mlglFMgRt9Fibc7I=;
        b=T68EWy2/5vx0EHFyf0MW91MFYpkJVSyRl45Ucg7KwJ+8FLSKyojxitc6D5Ju5qJY62
         PEX3jqvahcASWzAyeN8/o+jdFUYTQ1u6WuElpXIA73OePLhN6llzBZAnV4Jm3yAZKjNn
         bYY4TiFsPiUuuSYP1iey989tn9WGop3Hi48BvyqzvhWG2oDrCjDB3BP+a2HFykEZ5u+T
         Ok6pAPXIA+HUjYub0Pb/iwK85em8KsKol3dXX1ZZReEUQBv9T/PZD9XdIb3jkAFmOFhg
         kAAoeqFtebUQ9wJRTNG8UxvUthSoQgzNwU676VBVlFsTZAlORi6BB6GSLztX4C7767vz
         cNIw==
X-Gm-Message-State: AOAM530+auXAhFy9l8+BN1NFcT47GNBXxPiT4oBg/WQomeElbziE7PS3
        RqQyxYenB5us5ksi8tyS+B0ZbIdUfD0=
X-Google-Smtp-Source: ABdhPJydnRvLouxz5/0ok/xoEnluuKDL1GEWGT3ikz0u9iZ5GMYke03vetrDn27YjKEC2s4SBRNdtg==
X-Received: by 2002:adf:b34e:: with SMTP id k14mr25913695wrd.109.1590598085956;
        Wed, 27 May 2020 09:48:05 -0700 (PDT)
Received: from localhost.localdomain ([193.57.121.40])
        by smtp.gmail.com with ESMTPSA id d17sm2432852wrg.75.2020.05.27.09.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 09:48:05 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 07/12] upload-pack: pass upload_pack_data to upload_pack_config()
Date:   Wed, 27 May 2020 18:47:37 +0200
Message-Id: <20200527164742.23067-8-chriscool@tuxfamily.org>
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
more thoroughly, let's pass that struct to upload_pack_config(),
so that this function can use all the fields of the struct.

This will be used in followup commits to move static variables
that are set in upload_pack_config() into 'upload_pack_data'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index d211bebc0e..101e28f478 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1108,7 +1108,7 @@ static int find_symref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-static int upload_pack_config(const char *var, const char *value, void *unused)
+static int upload_pack_config(const char *var, const char *value, void *cb_data)
 {
 	if (!strcmp("uploadpack.allowtipsha1inwant", var)) {
 		if (git_config_bool(var, value))
@@ -1153,10 +1153,10 @@ void upload_pack(struct upload_pack_options *options)
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
@@ -1486,11 +1486,11 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 
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
2.27.0.rc2.38.gc6b4ed14d2.dirty

