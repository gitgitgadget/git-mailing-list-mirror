Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E02FC433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F1A20760
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAhewm8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgFKMF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbgFKMFs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 08:05:48 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61C8C08C5C1
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:47 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x13so5894951wrv.4
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R2ynU3cvIOZRETshm7q92+Ucq6MT4ZzQrbrUH0tWK5U=;
        b=SAhewm8Nc5efO9Kt+6658NVfKQ75kbDTRFoWPWwTQBHTiFc9PPuZlQVCpeS2i27oBB
         LILHKbpoOHxVSYe/XBFgwZzDWJUKk9hdUYNkjms7ZYce9CFUC+eHdZqcPlT/zQa7y1F4
         TRqMZdDhnDSDjUWnbWLGHFVdmgrpvtiujWw0Fw+1a+B56JNtHabkn4ahpNUtlUbhMnHG
         t2knSUNj7LfGLyuL0AAhmWiiykfnxIrgWCR4FqODiUI1abwrBC+btFrfgb68boh5cu28
         Jz7xQPatXcgU7vsvTpFxSoENZyzkfrIpqUrgbEX9cf31nzsW6EHT6+5OWP/yh4QCHgUn
         y1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R2ynU3cvIOZRETshm7q92+Ucq6MT4ZzQrbrUH0tWK5U=;
        b=eHiY5CV3/aE91gTVcuad+l65sMM4DNEBeWOxO0rTqu7fswHKrB9bScpWGhNZ7bSAGw
         Xk1VWyEMC6gwbw3CrqdEM7kZJvIyhfq/BnVh/xsRnlv/erev6DL3bWsQb8LNCzzDLOME
         9mN2VIwhCfO3Fk406O0vXkD0pAV5YqV8eVWrD4VS8Bfbv0q2BrrJqZuKMszxcHruGJqQ
         p8P5Px+EE+VNVDVXdEVOCt40DZfP0Z3kFb3M4SxnsAHJHplrb9DnJMm8hBWVbHG53JEK
         uCHQU1XHPU7FwVCOQ1UWbSaVBScf+A4A0u3hScOBtg+hqfDXi1I1qccABe0NwhTCkd2P
         O5/A==
X-Gm-Message-State: AOAM530QO6fLfGkNtY4/BXj+8/QlP8rI1EvdEQIcny4uYlaFIiaPRWm6
        ehFrV21CHT281TzxQ2Wt5vXw6IzRUC0=
X-Google-Smtp-Source: ABdhPJx3K0fV8at82eDgORK9SklCUT3YL9k1km57qTk/kBojjT7vUKr859h0aynhZHTgh26o30S5LA==
X-Received: by 2002:adf:9c12:: with SMTP id f18mr9910362wrc.105.1591877146123;
        Thu, 11 Jun 2020 05:05:46 -0700 (PDT)
Received: from localhost.localdomain ([185.228.229.208])
        by smtp.gmail.com with ESMTPSA id o8sm4047174wmb.20.2020.06.11.05.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 05:05:45 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 09/14] upload-pack: pass upload_pack_data to process_haves()
Date:   Thu, 11 Jun 2020 14:05:13 +0200
Message-Id: <20200611120518.10771-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.90.gabb59f83a2
In-Reply-To: <20200611120518.10771-1-chriscool@tuxfamily.org>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
 <20200611120518.10771-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
more thoroughly, let's pass that struct to process_haves(), so
that this function can use all the fields of the struct.

This will be used in followup commits to move a static variable
into 'upload_pack_data'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 0b30794d91..b20600fceb 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1348,14 +1348,13 @@ static void process_args(struct packet_reader *request,
 		die(_("expected flush after fetch arguments"));
 }
 
-static int process_haves(struct oid_array *haves, struct oid_array *common,
-			 struct object_array *have_obj)
+static int process_haves(struct upload_pack_data *data, struct oid_array *common)
 {
 	int i;
 
 	/* Process haves */
-	for (i = 0; i < haves->nr; i++) {
-		const struct object_id *oid = &haves->oid[i];
+	for (i = 0; i < data->haves.nr; i++) {
+		const struct object_id *oid = &data->haves.oid[i];
 		struct object *o;
 		int we_knew_they_have = 0;
 
@@ -1382,7 +1381,7 @@ static int process_haves(struct oid_array *haves, struct oid_array *common,
 				parents->item->object.flags |= THEY_HAVE;
 		}
 		if (!we_knew_they_have)
-			add_object_array(o, NULL, have_obj);
+			add_object_array(o, NULL, &data->have_obj);
 	}
 
 	return 0;
@@ -1419,7 +1418,7 @@ static int process_haves_and_send_acks(struct upload_pack_data *data)
 	struct oid_array common = OID_ARRAY_INIT;
 	int ret = 0;
 
-	process_haves(&data->haves, &common, &data->have_obj);
+	process_haves(data, &common);
 	if (data->done) {
 		ret = 1;
 	} else if (send_acks(&data->writer, &common,
-- 
2.27.0.90.gabb59f83a2

