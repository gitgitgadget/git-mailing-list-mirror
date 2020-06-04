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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981B4C433E0
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7946620772
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StL6nQR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbgFDRz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730336AbgFDRzX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 13:55:23 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C4CC08C5C0
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 10:55:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c3so7073804wru.12
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 10:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3UbWBbqthOteAeFgEeN1OMziwAp2xGWU0IRuQXIy9Io=;
        b=StL6nQR1pd/tkHq/IM6sFg5WbC44j/uTrnmRRGDR5HOjyDTPllbmtTHTXHUeafK/8a
         Fat9hoFxTnm1UYrfeFC+ZhSAdzlDqKScxPcO8pMsthABd+xfvoKGYRNwYhV+uZK1VVfK
         Wd4HsqNQ9ATO9G9X//4a4lW4bkCLbdEIgY/fhIupSlVbyw7lAWo/bzyVJcsrWy0yYflU
         mHOShxJIMe/IiclIEjGBt6IO1Lr1J40hYhLVhNT2duyYilYaG2IB5pre/RltLsQ0dHEQ
         uBhAkVwi6YahbuH6/AZFb5pqcocO7Kq46KSuBxCY7vYPlGcXA+G+LUHPaEd2bRsnP5Yk
         Vawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3UbWBbqthOteAeFgEeN1OMziwAp2xGWU0IRuQXIy9Io=;
        b=R/FZpsySpxTvn2cdYNOrdPvFUoUwmJcbs3itzeBbgJeIH5KNOt/RBwgn2mrvxWG6mn
         kLJ1pUTpYNtlfwbHObwh5wfdaBwyStnYt7s1u1b+Fy4GGQZp1pdCDIVBDXMbRAYvFmjP
         rQXoWnoVejUnzfVMbNAgopqdnMRl9bGrjnZlJPw1oweNS3SDPFhcQRMbyoTVj58ztHBQ
         3WP9vr8goRTcLkF8bGN63xkgtyI+Tywwrp9dQcgCMjEXvLvFxKbU3NG6LqHSoX0BmRCD
         /cgxIQes21vb4Ec018sk7M6D2PiLnFQNKS0/DiZicddEfNRZQqhFtkArb71y7xWogN37
         waIg==
X-Gm-Message-State: AOAM531FtTp2IgM8kmiAKDJzPYHd7JypjWwiIHFCV4fjf7iDKrQfBzWR
        KQOIhvr2v5lIDuVh1rLN1NHPs2bu1Qw=
X-Google-Smtp-Source: ABdhPJxZp4fOIdPaGiahKPZZ34LQqDNXzf+Sn74VRq3UfXvlyvwkAJhyv+A/qmgrh+N7slSpv7yjBQ==
X-Received: by 2002:a5d:60c3:: with SMTP id x3mr5336289wrt.48.1591293321307;
        Thu, 04 Jun 2020 10:55:21 -0700 (PDT)
Received: from localhost.localdomain ([185.228.231.251])
        by smtp.gmail.com with ESMTPSA id s7sm9173540wrr.60.2020.06.04.10.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 10:55:20 -0700 (PDT)
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
Subject: [PATCH v3 11/13] upload-pack: move allow_ref_in_want to upload_pack_data
Date:   Thu,  4 Jun 2020 19:54:48 +0200
Message-Id: <20200604175450.17385-12-chriscool@tuxfamily.org>
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
more thoroughly, let's move the 'allow_ref_in_want' static
variable into this struct.

It is used only by protocol v2 code.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Acked-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 upload-pack.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 19b342d4b0..0d75745d8d 100644
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
2.27.0.rc0.26.gf2851482f5

