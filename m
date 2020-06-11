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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43415C433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1437C2053B
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwymZNAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgFKMFg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgFKMFf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 08:05:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AB2C08C5C2
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:35 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c3so5855675wru.12
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=80tB2gi809Iclic/onhayifTdDZuro2omtm0DhEsF1c=;
        b=CwymZNAvPNiJXR4uRWIkv9yat5rexwoWhttIkT8ejWq9fPBqYvPGkjm8iWaMyKd33L
         xz1anRYRIaeriVmvtgRWky2XGPVWvbSq0cpwapuGgAcFnZQco++Rco1CwJ5TWUoBuI82
         Z4wcSYJ5j0xkZffT1o3RvmBE4SBvHpA+AQ7bViytUi98y/PALie7XRS89xYRq8lgUz+8
         dpvHtlyzDXH79PCaONyneHeZ+aNTJwpKY0Wn77+pFIEfXhyrOdL5d2XbP0qPS+ewV6Vr
         m3COJ9frnv8MO0nenL4L+tjIfn8U7K/WxAk8YgqpXUOkUz6FIUHjO8iMsorxhElDU1LV
         ojJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=80tB2gi809Iclic/onhayifTdDZuro2omtm0DhEsF1c=;
        b=HoFPyx3crlOBZ0anTGdYVBnHVMwQX4La+XRsVFBWCyuiX4O91+JFy0w2rsRz9ohWfH
         QmDP0jYdxtor5MlOUouRQ+PaVkMVBpiU9d0iuknxxI6Dp2OlHSjqYAYXs3v/+NS1lZY8
         oNnZITTyCjOXXNWVsLPkYDdY+d509NCoiqqEOKOfYP5gJ34M4DZ1Jif0DkLY7Ahg2U+2
         WLMgGriIfObv4RSxyKRmjFwvHrmnsfLDw3YB7kpJQtWkXbaeqSNCeMpwUS13vRnBgapT
         InBfTGkTcCfYJ+hwuRf5VkAOa/UIxgJ1749moIJCipiqEGz8AL7x7oiGii+ejgc18Zf+
         muTQ==
X-Gm-Message-State: AOAM530SHAQPMBa8U4Pm2NB1kktoFE+Ffc+WQRwDwEIevuwVAe2pxjAB
        Rt30YBo7QUGcQlVF0i4ZSpIx2q4VP7A=
X-Google-Smtp-Source: ABdhPJyzH/LWetfQJ0x5Sl/hO+Ft2jNaaX6TUh2CUONjp1zTRwH6ukl+zi4MiVlMlJANzgFOpOS2eA==
X-Received: by 2002:a5d:42cd:: with SMTP id t13mr8987476wrr.355.1591877133417;
        Thu, 11 Jun 2020 05:05:33 -0700 (PDT)
Received: from localhost.localdomain ([185.228.229.208])
        by smtp.gmail.com with ESMTPSA id o8sm4047174wmb.20.2020.06.11.05.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 05:05:32 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 01/14] upload-pack: pass upload_pack_data to send_shallow_list()
Date:   Thu, 11 Jun 2020 14:05:05 +0200
Message-Id: <20200611120518.10771-2-chriscool@tuxfamily.org>
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
more thoroughly, let's pass that struct to send_shallow_list(),
so that this function can use all the fields of the struct.

This will be used in followup commits to move static variables
into 'upload_pack_data'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 57 +++++++++++++++++++--------------------------------
 1 file changed, 21 insertions(+), 36 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index bc7e3ca19d..ada9082b06 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -808,53 +808,49 @@ static void deepen_by_rev_list(struct packet_writer *writer, int ac,
 }
 
 /* Returns 1 if a shallow list is sent or 0 otherwise */
-static int send_shallow_list(struct packet_writer *writer,
-			     int depth, int deepen_rev_list,
-			     timestamp_t deepen_since,
-			     struct string_list *deepen_not,
-			     int deepen_relative,
-			     struct object_array *shallows,
-			     struct object_array *want_obj)
+static int send_shallow_list(struct upload_pack_data *data)
 {
 	int ret = 0;
 
-	if (depth > 0 && deepen_rev_list)
+	if (data->depth > 0 && data->deepen_rev_list)
 		die("git upload-pack: deepen and deepen-since (or deepen-not) cannot be used together");
-	if (depth > 0) {
-		deepen(writer, depth, deepen_relative, shallows, want_obj);
+	if (data->depth > 0) {
+		deepen(&data->writer, data->depth, data->deepen_relative,
+		       &data->shallows, &data->want_obj);
 		ret = 1;
-	} else if (deepen_rev_list) {
+	} else if (data->deepen_rev_list) {
 		struct argv_array av = ARGV_ARRAY_INIT;
 		int i;
 
 		argv_array_push(&av, "rev-list");
-		if (deepen_since)
-			argv_array_pushf(&av, "--max-age=%"PRItime, deepen_since);
-		if (deepen_not->nr) {
+		if (data->deepen_since)
+			argv_array_pushf(&av, "--max-age=%"PRItime, data->deepen_since);
+		if (data->deepen_not.nr) {
 			argv_array_push(&av, "--not");
-			for (i = 0; i < deepen_not->nr; i++) {
-				struct string_list_item *s = deepen_not->items + i;
+			for (i = 0; i < data->deepen_not.nr; i++) {
+				struct string_list_item *s = data->deepen_not.items + i;
 				argv_array_push(&av, s->string);
 			}
 			argv_array_push(&av, "--not");
 		}
-		for (i = 0; i < want_obj->nr; i++) {
-			struct object *o = want_obj->objects[i].item;
+		for (i = 0; i < data->want_obj.nr; i++) {
+			struct object *o = data->want_obj.objects[i].item;
 			argv_array_push(&av, oid_to_hex(&o->oid));
 		}
-		deepen_by_rev_list(writer, av.argc, av.argv, shallows, want_obj);
+		deepen_by_rev_list(&data->writer, av.argc, av.argv,
+				   &data->shallows, &data->want_obj);
 		argv_array_clear(&av);
 		ret = 1;
 	} else {
-		if (shallows->nr > 0) {
+		if (data->shallows.nr > 0) {
 			int i;
-			for (i = 0; i < shallows->nr; i++)
+			for (i = 0; i < data->shallows.nr; i++)
 				register_shallow(the_repository,
-						 &shallows->objects[i].item->oid);
+						 &data->shallows.objects[i].item->oid);
 		}
 	}
 
-	shallow_nr += shallows->nr;
+	shallow_nr += data->shallows.nr;
 	return ret;
 }
 
@@ -1022,14 +1018,7 @@ static void receive_needs(struct upload_pack_data *data,
 	if (data->depth == 0 && !data->deepen_rev_list && data->shallows.nr == 0)
 		return;
 
-	if (send_shallow_list(&data->writer,
-			      data->depth,
-			      data->deepen_rev_list,
-			      data->deepen_since,
-			      &data->deepen_not,
-			      data->deepen_relative,
-			      &data->shallows,
-			      &data->want_obj))
+	if (send_shallow_list(data))
 		packet_flush(1);
 }
 
@@ -1473,11 +1462,7 @@ static void send_shallow_info(struct upload_pack_data *data)
 
 	packet_writer_write(&data->writer, "shallow-info\n");
 
-	if (!send_shallow_list(&data->writer, data->depth,
-			       data->deepen_rev_list,
-			       data->deepen_since, &data->deepen_not,
-			       data->deepen_relative,
-			       &data->shallows, &data->want_obj) &&
+	if (!send_shallow_list(data) &&
 	    is_repository_shallow(the_repository))
 		deepen(&data->writer, INFINITE_DEPTH, data->deepen_relative,
 		       &data->shallows, &data->want_obj);
-- 
2.27.0.90.gabb59f83a2

