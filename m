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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A1AC433E3
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 643E92072F
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vX6SVsbZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgFBERX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgFBERV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 00:17:21 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98082C061A0E
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 21:17:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c3so1850608wru.12
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 21:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rIAqGSr0E2QrY1BV92Agexl6dH59N7rlDPfpK3T3/fg=;
        b=vX6SVsbZdJGMNx5LPbdAUnbbSzjlUTRIvipbgjsbnzwlyeMm4qGrALkh/TWZrjzL04
         pP7nELJKTsIQN5ftXXfrb/i4MwBk52RCILbwqflpi5OS6ym+NpD9x26++XW7HM8OqPcC
         g97zEfuUtj9eY2KEKO2CD6Vx2JCEDX5tebBVKB+FuUzIkr2usxLnjuS3B1dtSwT1+HiB
         syJUUA9ojqdAz6HEqFKygrdA+PAE86Q0Ap7PyVH4xWy46Lz5aGmQHnPBYf4BjazkUDAd
         izup+lcSDas4zaVi76zOP18rwqRnd8fkdtn+lAVS+mSmhQw4CRHvTGTg49Q6knf/agjG
         aI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rIAqGSr0E2QrY1BV92Agexl6dH59N7rlDPfpK3T3/fg=;
        b=WYsgkAQU4ZiTxTmcY/cyc4u2kUUoqojABETF/153OFIdunjm8njOcUWgiR/0USApne
         piIcx97CrbxUfh3Yuq/QVDIckb3OMIv+1BLM5pCSFZTh3tqj81S036+Ymc/TkHuY4CmB
         vOjzgbFKr0VpgSw6NdL7C4N6vpAwPL7chMvCfGI2Bs55sEy3OxhXRqwYYXf6irI53U6o
         cs87ZmBI03GFAb7OIEjHTM5h9/bYmjzNwLnSOl0JrTEfvQ/Bk/Rf/K9QpCNdOOIBSv6a
         yMfwTJVUdGIZUK1eUeJ81cnV1Ri63CIu/Y7N9rjHLpN1bXlO7UTcAbDCfMTvWGAgggDW
         W1Hg==
X-Gm-Message-State: AOAM531MtOaKlV+ONbdPnuAcBMwj+1zXUlbD9SwKbx61atAq+wWHbG7q
        VS/IW1f0l3FonGfToQAq+E4w5n7TqvQ=
X-Google-Smtp-Source: ABdhPJzEmSpqhspflswXLBPpdm92zqhmJNxlKcsT5UdyvHuOk2L0XsCmkuFUfInLR963g9tspkoTIA==
X-Received: by 2002:adf:fd41:: with SMTP id h1mr25614206wrs.374.1591071439073;
        Mon, 01 Jun 2020 21:17:19 -0700 (PDT)
Received: from localhost.localdomain ([185.228.230.249])
        by smtp.gmail.com with ESMTPSA id z2sm1717614wrs.87.2020.06.01.21.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 21:17:18 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 02/13] upload-pack: annotate upload_pack_data fields
Date:   Tue,  2 Jun 2020 06:16:46 +0200
Message-Id: <20200602041657.7132-3-chriscool@tuxfamily.org>
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
more thoroughly, let's annotate fields from this struct to let
people know which ones are used only for protocol v0 and which
ones only for protocol v2.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
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
2.27.0.rc0.26.g636377a2c4

