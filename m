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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8434CC433E1
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 641AB206DC
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U86LV9mU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbgFDRzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbgFDRzP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 13:55:15 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399AAC08C5C1
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 10:55:15 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c3so7073451wru.12
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 10:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q8+pO6b+C6ueibgsRq/EOVwpJwefWlMdNVGnh7lNH9U=;
        b=U86LV9mUqYrrZzYP1IxlolgqTb8eibJnHf6gwxG6DscarmPJUgIcQhiZ1i86frYhLR
         oR1jVk1FWwlIa0kagD+e2+gcF9ylNgJE0in8WxVAnxjZNQglvomDePFDcgL4Rug31Y3c
         Y6v9MO/8WfBMxJVzbnQYEwCGrO9BZIxsFJnvyrRHUt1UVEhh3GYSJbpeJSkw+nZEHZTQ
         s+MWN6L+9k7Gk71vir+r5P53snQzn3W9L25WdPKF9zovAf7KB61E4ksjmejNimF9eBMe
         PJk3RdixJsX9a2KNFx9M9edtlIwtBD6WJIoaIebSvBDALNDLYz7/kRKvUQbBiz8jnUlL
         9IzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q8+pO6b+C6ueibgsRq/EOVwpJwefWlMdNVGnh7lNH9U=;
        b=BKC6Nx7+ekQn+I9nI59vb7Z0cfPTtOhKf/evoy3JDyKcxcvowGYJoXmNRpYhyypR3d
         Y26BUyEVSLJekAboA2Gu2Og6F/rZMEeTFHwOhbCVMBu8N7APOHairdXiWdYN449GkHcm
         I4gjUfAoCJZbj1UZQIfF5S8v9c5DnmDwMxu59KjsVAroqxRJqoxiZ0ofZ4eLPn5WYBfZ
         x+FXTa2nU4GhQcS3G5VJwIsSKfxc+/Tof2mbJjfHQlHp3Gv42HICkTs6KvanD0JPEoH9
         X+PCkglfgweeBTO44UYaOx6Vy0HKKohjFf58TlBOUatUirZWSfRrXD+xvseBzbFoLWnj
         2PMw==
X-Gm-Message-State: AOAM53272MIe/ISuMJsdiHtLbkJYsZaMMIHMTC+wpWwuypI06kUYiTFQ
        B7PChmIbSSPibWE1qNey7Exsu3z4Mr4=
X-Google-Smtp-Source: ABdhPJzppMAzsNmy5W8QC5z6b1YSo/xmVcswOZBUU0VlF/KRemS6TMQuX4p+D4GlQ26Vap2VRBeWzg==
X-Received: by 2002:adf:9c12:: with SMTP id f18mr5977741wrc.105.1591293313632;
        Thu, 04 Jun 2020 10:55:13 -0700 (PDT)
Received: from localhost.localdomain ([185.228.231.251])
        by smtp.gmail.com with ESMTPSA id s7sm9173540wrr.60.2020.06.04.10.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 10:55:13 -0700 (PDT)
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
Subject: [PATCH v3 05/13] upload-pack: move filter_capability_requested to upload_pack_data
Date:   Thu,  4 Jun 2020 19:54:42 +0200
Message-Id: <20200604175450.17385-6-chriscool@tuxfamily.org>
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
more thoroughly, let's move the filter_capability_requested
static variable into this struct.

It is only used by protocol v0 code since protocol v2 assumes
certain baseline capabilities, but rolling it into
upload_pack_data and just letting v2 code ignore it as it does
now is more coherent and cleaner.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Acked-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.27.0.rc0.26.gf2851482f5

