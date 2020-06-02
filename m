Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7C8C433E1
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1030E2072F
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMcRHp9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgFBERh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgFBERc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 00:17:32 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF81C061A0E
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 21:17:32 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r9so1482097wmh.2
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 21:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JdrO+vOZkCvNrejQcxamuRBCDHKbWhkYM+Rym0CJobo=;
        b=pMcRHp9ADi5SrdWDXOhqY1iWSeMbHZA0jBsMzGIWFA+nm9vxCj9cWHrLU+KaAoklT0
         aIag9jdnXK0T1cneOmtFQ5SpWGfKgIuhxxxio54KOTwsQbUv2pMyvhMPY6BX1D9DBAB3
         3cx7wwHtI0oLpM+nqSONmUq1nvYHf8jLyXOZ/DpR2SnTLlBdiikxhgmqgAqYl4W89QGZ
         tzor1lg9rsOlDmI6taNuciEZPGxc4F5zNFGrJ3N2D1Cc0UCqCEmY4BZB8yWhjp9zncV4
         xKVZucY5Dyzy9DqrRyMiL46dFzc+n39F5p6p7SdhgotVIwVyhm+XaHRnAwttdKfO5HZ8
         slQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JdrO+vOZkCvNrejQcxamuRBCDHKbWhkYM+Rym0CJobo=;
        b=H4YcaRwMb9AtkrCOSd8ATuwHgDKKEFbFbjEa/EV7sWoxXQg0UVICgSWTEMR+uIzKN+
         5Yl3/eH0VbPSnW0ZZyrN50MYOrKB3jaez33qOxONd8h2zP+wUsSGAJYjFSNeSVlNK5B8
         qEmeiDCAH3BKxB2v3ftRHVEj8Bqn9KUc4vZZl2QJKKNRx9mhgrs/yPdowzMmbgHPvXwo
         creudCQvJLVjKHQj16WOB0oDZKmQyNq5DZFzTiOD5YjlKPIoa6cNLEBwexii1mR6DNwQ
         //Idti400jtBGBwQG45MYR94jDcHTdFn4M6a58nd8IwgeVeE/6yzVB5vMC39H0V5C+nP
         D3+w==
X-Gm-Message-State: AOAM532mlceKzDkBRKxkMVg3+1JPgFxIlBCK0hqQb36DbcTiPHIt1mjD
        CLC9rzDbbt9CN/PqsfSXWfYQtiloAvU=
X-Google-Smtp-Source: ABdhPJwWaGJMi6ROIz7EZYILpvoJ44M8beMGHN164HOjzUgiRgWGm4QWgC+Ix5Y/q6Q+lLqLFIU9/w==
X-Received: by 2002:a1c:7dd5:: with SMTP id y204mr2100455wmc.182.1591071450946;
        Mon, 01 Jun 2020 21:17:30 -0700 (PDT)
Received: from localhost.localdomain ([185.228.230.249])
        by smtp.gmail.com with ESMTPSA id z2sm1717614wrs.87.2020.06.01.21.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 21:17:30 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 12/13] upload-pack: move allow_sideband_all to upload_pack_data
Date:   Tue,  2 Jun 2020 06:16:56 +0200
Message-Id: <20200602041657.7132-13-chriscool@tuxfamily.org>
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
more thoroughly, let's move the 'allow_sideband_all' static
variable into this struct.

It is used only by protocol v2 code.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 3c00d79443..0887410791 100644
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
2.27.0.rc0.26.g636377a2c4

