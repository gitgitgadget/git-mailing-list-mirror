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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66851C433E0
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A762067B
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VG1j5ayn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbgFDRzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbgFDRzL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 13:55:11 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32717C08C5C0
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 10:55:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r7so7126906wro.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 10:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kycjsm7wcEbpE1FvhW/RgUzGigDdtwWb6EJqkf+GbGg=;
        b=VG1j5aynsn9/Tms1zget6cXlAParc1HdBRs22iriywa75v615hILWTWnp5p5FgkN1R
         zaIYhIQAbtxiZlA9+mQHCr89wSWG9R3tCeSdVQ2Mk/ws1Vyu2VqH5Xcb3gBuBw/udYrv
         BbASB27A2aXS3t+t0Ge9bhMmbSmjnkoHJJo4WYLFKEVWgegBYKdEdUU/ckoqW2v8nqfu
         WaE7c8VsPC2I95Gku5kTkzobT75DBEwBZz2cuwPbnMOV/isJVKK2QzjRAAITUH+AhzKE
         q/XV0ApF+vk/NGmIPH/BFX/wfgU4mmhEhts1DLGzr2yCPrZFUlVkEc3eAGDatWI47YOn
         2qXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kycjsm7wcEbpE1FvhW/RgUzGigDdtwWb6EJqkf+GbGg=;
        b=Nx3f5d+w2IAaJr9dryyxiugjojjzTr4QA303hnGTLyuMaLVT2KJslsGwUTK/y2N/hD
         byowdDEjlAAxRBIXF9fTMYvgSEu9SvMOk27hsrUhSzy0ey9M774879gYLD0T/sUciwhq
         KiwcEB4xs3JeFNglPF9zLA1S556XpqhzNMwdnw33L4Xj/cwTUqCzXDN/rc4UDt9nbDWN
         lijAeElZadQ9ETpSVR0SBREYk3hc+NXuEG5J+KTMF4ApyZ7zba83r9s1pcQN4/5IZTtu
         rAoVpzNw71XaouB0rVYusDrrdskhPZp7hyRqs7fYU0kYR+jpnOxSrKmoZ4PrmhK7G8qh
         J5Xg==
X-Gm-Message-State: AOAM53333+Ft3uatb+0p3eQM62jkN7q3DfOparK+evBuuZ5n9c3IF8sl
        OdsKEoLWipQ+Gbdf9x90QFLEEVdGZvU=
X-Google-Smtp-Source: ABdhPJyxE8WZEtwxFdC44JbWw40rRGvFa7RFCl+6UAH8YCszQeWlcTXXdcqIM/N/tvHr7VAkvluntA==
X-Received: by 2002:adf:f6ce:: with SMTP id y14mr5821885wrp.90.1591293309633;
        Thu, 04 Jun 2020 10:55:09 -0700 (PDT)
Received: from localhost.localdomain ([185.228.231.251])
        by smtp.gmail.com with ESMTPSA id s7sm9173540wrr.60.2020.06.04.10.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 10:55:08 -0700 (PDT)
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
Subject: [PATCH v3 02/13] upload-pack: annotate upload_pack_data fields
Date:   Thu,  4 Jun 2020 19:54:39 +0200
Message-Id: <20200604175450.17385-3-chriscool@tuxfamily.org>
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
more thoroughly, let's annotate fields from this struct to let
people know which ones are used only for protocol v0 and which
ones only for protocol v2.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Acked-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 upload-pack.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 2fa645834a..3963a3805e 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -70,12 +70,16 @@ static int allow_ref_in_want;
 
 static int allow_sideband_all;
 
+/*
+ * Please annotate, and if possible group together, fields used only
+ * for protocol v0 or only for protocol v2.
+ */
 struct upload_pack_data {
-	struct string_list symref;
-	struct string_list wanted_refs;
+	struct string_list symref;				/* v0 only */
 	struct object_array want_obj;
 	struct object_array have_obj;
-	struct oid_array haves;
+	struct oid_array haves;					/* v2 only */
+	struct string_list wanted_refs;				/* v2 only */
 
 	struct object_array shallows;
 	struct string_list deepen_not;
@@ -88,13 +92,14 @@ struct upload_pack_data {
 
 	struct packet_writer writer;
 
-	unsigned stateless_rpc : 1;
+	unsigned stateless_rpc : 1;				/* v0 only */
 
 	unsigned use_thin_pack : 1;
 	unsigned use_ofs_delta : 1;
 	unsigned no_progress : 1;
 	unsigned use_include_tag : 1;
-	unsigned done : 1;
+
+	unsigned done : 1;					/* v2 only */
 };
 
 static void upload_pack_data_init(struct upload_pack_data *data)
-- 
2.27.0.rc0.26.gf2851482f5

