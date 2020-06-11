Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC17C433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 894DC20760
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fm145hiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgFKMF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgFKMFv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 08:05:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8ADC08C5C3
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:50 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t18so5884921wru.6
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xKHKMd5iywnEpPHMQd4uKXcR1FpO0yE40dWh82MUXIs=;
        b=fm145hiXzqFTSSz5yxxHKoQZ4dIgX5OszV8RZIhkUOGvQq12tHu3kn1Ea2f6kzT/9g
         Qjk1ZoNeTKtVdHvqVllYp4VgJ648VQtja3oBRaabosAGvkjQOMdCDFzHdmGjNkQCnDLx
         CQlD8NWbKhoCpUvi///UN1tE4RRqXh7B1V3uj1KM11pZ5C3ePkZNRv40Uq4p4OBxhQIf
         rNJY3pJig0sG+s9z8W7bcr7+AdhRiyPPpGZnbh3kkpJtywrg4PgKW9ShXHZXvq4aTEBh
         PnCIwneACIFi3rcw9lDajqlk3GjWy/jfIh8ubU28ZskAMAU4rwg0ZqlaPGlO9SgW+k3p
         ntyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xKHKMd5iywnEpPHMQd4uKXcR1FpO0yE40dWh82MUXIs=;
        b=O7IsRbY1wJpx0zubOm21LSFiUU1SwGXQ4r07YBl8D4RiDu+Gq48YUBlext7L+GMO4v
         OhhozKWso7tpurOfmCe3/dH1CEmXNXw8HttTjJDn3hOX0pzcNaPx35giev60rFKfXUIs
         bWO2v5WwKsiNqhZEPHGDRXWD2nmB40RHp0iLE1AU+Dma7RYsfLcyuGtaseWZFxWdEgGS
         haTUvWvehgobiPlTzFVlZhR5oEMjy8du6/YItWaG/+Mzsg/o1FpPqH6VbED1Ewe5Lto9
         vJtNvK08UlERnjK0BiXCNJdfWh9FZdfIsH7ph8Bf5fVkVpXSF9H7/KlstUkKGcNHoqj/
         fvGA==
X-Gm-Message-State: AOAM532CpnCzbSpqax0ntAhx6FhTq2u1DRv6JgMetaCAFIUgjWXpFfnJ
        Y58Dxh+S/QaA0Zu7OSmUi2IjMQUaCzs=
X-Google-Smtp-Source: ABdhPJwLc9prk52uggrnG4fU20bklHX6sy/+NrD2S+nomB6mAe8Uh6F7wCbe6NTxZkghiaWxK1AW6g==
X-Received: by 2002:adf:b60b:: with SMTP id f11mr9130810wre.7.1591877149286;
        Thu, 11 Jun 2020 05:05:49 -0700 (PDT)
Received: from localhost.localdomain ([185.228.229.208])
        by smtp.gmail.com with ESMTPSA id o8sm4047174wmb.20.2020.06.11.05.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 05:05:48 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 11/14] upload-pack: pass upload_pack_data to ok_to_give_up()
Date:   Thu, 11 Jun 2020 14:05:15 +0200
Message-Id: <20200611120518.10771-12-chriscool@tuxfamily.org>
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
more thoroughly, let's pass that struct to ok_to_give_up(), so
that this function can use all the fields of the struct.

This will be used in followup commits to move a static variable
into 'upload_pack_data'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 0523feaac2..245eda8ba1 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -428,15 +428,14 @@ static int got_oid(const char *hex, struct object_id *oid,
 	return 0;
 }
 
-static int ok_to_give_up(const struct object_array *have_obj,
-			 struct object_array *want_obj)
+static int ok_to_give_up(struct upload_pack_data *data)
 {
 	uint32_t min_generation = GENERATION_NUMBER_ZERO;
 
-	if (!have_obj->nr)
+	if (!data->have_obj.nr)
 		return 0;
 
-	return can_all_from_reach_with_flag(want_obj, THEY_HAVE,
+	return can_all_from_reach_with_flag(&data->want_obj, THEY_HAVE,
 					    COMMON_KNOWN, oldest_have,
 					    min_generation);
 }
@@ -461,7 +460,7 @@ static int get_common_commits(struct upload_pack_data *data,
 			if (data->multi_ack == MULTI_ACK_DETAILED
 			    && got_common
 			    && !got_other
-			    && ok_to_give_up(&data->have_obj, &data->want_obj)) {
+			    && ok_to_give_up(data)) {
 				sent_ready = 1;
 				packet_write_fmt(1, "ACK %s ready\n", last_hex);
 			}
@@ -483,7 +482,7 @@ static int get_common_commits(struct upload_pack_data *data,
 			case -1: /* they have what we do not */
 				got_other = 1;
 				if (data->multi_ack
-				    && ok_to_give_up(&data->have_obj, &data->want_obj)) {
+				    && ok_to_give_up(data)) {
 					const char *hex = oid_to_hex(&oid);
 					if (data->multi_ack == MULTI_ACK_DETAILED) {
 						sent_ready = 1;
@@ -1402,7 +1401,7 @@ static int send_acks(struct upload_pack_data *data, struct oid_array *acks)
 				    oid_to_hex(&acks->oid[i]));
 	}
 
-	if (ok_to_give_up(&data->have_obj, &data->want_obj)) {
+	if (ok_to_give_up(data)) {
 		/* Send Ready */
 		packet_writer_write(&data->writer, "ready\n");
 		return 1;
-- 
2.27.0.90.gabb59f83a2

