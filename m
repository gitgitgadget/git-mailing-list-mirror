Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FECC433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CB122074D
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWU2y31p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgEOKFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 06:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbgEOKFT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 06:05:19 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BCEC05BD0A
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:05:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id w7so2776825wre.13
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j5bWbdiPefzdp1+8Fhl/fWfUwo6VIAL6w6+ThJxHuyA=;
        b=PWU2y31p1U3sSAOHilzWBD9L1n02T2/dvHNqmDZRmooYym4la4MgzE1LJxScrcYas4
         20e5W7++w7zEqKRHpjvR4c2dRMLvcvuamB/auyWv+iFt50YcM7jfa2YM9HqN34naIi/g
         694kfcJGGbhSHN9bhq0OmIRSE2K/LHkI69oyRx5dgEmDrLQl6+tEh91iSCzUiGq9KYhc
         Dg+Gpht7trpgLwnc7Vr5t61GZC0jMtsdJPIGd0Y0HRfaZDRd1PGbqqujv5MqBz8N1Emf
         q5d5BKo6ULXtUChI+Dd3MQx6gr/rLyy5GI2v3I8smCFr6HAC2zjrOvDT/9fypDZdRTaI
         Pgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j5bWbdiPefzdp1+8Fhl/fWfUwo6VIAL6w6+ThJxHuyA=;
        b=HrQLCKkCUvzy8g0jgTCP9JW86VYaaPI/dS3Ze+afAaEFTYt+RFH+e6wemHC5w9A+rp
         3MldJHVLFSr66D5tLuaDEuPvnNIpvO1Gp58P0DTDY40cxi/IQHH02T5k8hpExVfHJYQI
         c+7wZjE+wIM1PqCXWSQK3SGepubZQMIOA9NE4dZvhnQcqCBNkkN1uksFsZiZ267AKSOq
         U85U06M01+XNob7jhsTUG1ldXg8/Sa9yppwx8T0LsiyhC/i5wUr37YMIgw71fA2Gv0B8
         6DN68eQo73f+byCGWCeDQlBATY266vG6038QNpd6GLkhlyAv+t9Pfek/eYmT6hgtIajQ
         R55Q==
X-Gm-Message-State: AOAM530fymsLFmKsRjsQmmbaP/EixB5O+TfD5Zz1s93ZaYbkZsRswwrq
        zx8NxMS9P4UHF3x+/ajV4m5vvIhsG0k=
X-Google-Smtp-Source: ABdhPJyKR/8nyeDwI5Ycczh+fubOG6W35HizJKVedtBi5LbxMD1k4qdPPYVnKn2vu7/cJldKykJ0jw==
X-Received: by 2002:adf:e783:: with SMTP id n3mr829246wrm.157.1589537116988;
        Fri, 15 May 2020 03:05:16 -0700 (PDT)
Received: from localhost.localdomain ([193.57.121.171])
        by smtp.gmail.com with ESMTPSA id m3sm2792326wrn.96.2020.05.15.03.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:05:16 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 06/13] upload-pack: pass upload_pack_data to receive_needs()
Date:   Fri, 15 May 2020 12:04:47 +0200
Message-Id: <20200515100454.14486-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.26.2.639.gb7dde20fdf
In-Reply-To: <20200515100454.14486-1-chriscool@tuxfamily.org>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
more thoroughly, let's pass 'struct upload_pack_data' to
receive_needs(), so that this function and the functions it
calls can use all the fields of that struct in followup commits.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 7953a33189..94bf9cd088 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -907,9 +907,8 @@ static int process_deepen_not(const char *line, struct string_list *deepen_not,
 	return 0;
 }
 
-static void receive_needs(struct packet_reader *reader,
-			  struct object_array *want_obj,
-			  struct list_objects_filter_options *filter_options)
+static void receive_needs(struct upload_pack_data *data,
+			  struct packet_reader *reader)
 {
 	struct object_array shallows = OBJECT_ARRAY_INIT;
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
@@ -944,8 +943,8 @@ static void receive_needs(struct packet_reader *reader,
 		if (skip_prefix(reader->line, "filter ", &arg)) {
 			if (!filter_capability_requested)
 				die("git upload-pack: filtering capability not negotiated");
-			list_objects_filter_die_if_populated(filter_options);
-			parse_list_objects_filter(filter_options, arg);
+			list_objects_filter_die_if_populated(&data->filter_options);
+			parse_list_objects_filter(&data->filter_options, arg);
 			continue;
 		}
 
@@ -990,7 +989,7 @@ static void receive_needs(struct packet_reader *reader,
 			if (!((allow_unadvertised_object_request & ALLOW_ANY_SHA1) == ALLOW_ANY_SHA1
 			      || is_our_ref(o)))
 				has_non_tip = 1;
-			add_object_array(o, NULL, want_obj);
+			add_object_array(o, NULL, &data->want_obj);
 		}
 	}
 
@@ -1002,7 +1001,7 @@ static void receive_needs(struct packet_reader *reader,
 	 * by another process that handled the initial request.
 	 */
 	if (has_non_tip)
-		check_non_tip(want_obj, &writer);
+		check_non_tip(&data->want_obj, &writer);
 
 	if (!use_sideband && daemon_mode)
 		no_progress = 1;
@@ -1012,7 +1011,7 @@ static void receive_needs(struct packet_reader *reader,
 
 	if (send_shallow_list(&writer, depth, deepen_rev_list, deepen_since,
 			      &deepen_not, deepen_relative, &shallows,
-			      want_obj))
+			      &data->want_obj))
 		packet_flush(1);
 	object_array_clear(&shallows);
 }
@@ -1176,7 +1175,7 @@ void upload_pack(struct upload_pack_options *options)
 				   PACKET_READ_CHOMP_NEWLINE |
 				   PACKET_READ_DIE_ON_ERR_PACKET);
 
-		receive_needs(&reader, &data.want_obj, &data.filter_options);
+		receive_needs(&data, &reader);
 		if (data.want_obj.nr) {
 			get_common_commits(&data, &reader);
 			create_pack_file(&data.have_obj,
-- 
2.26.2.638.gb2c16ea67b.dirty

