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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BE1C433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E7E12053B
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKYfAbjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgFKMFm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgFKMFk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 08:05:40 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1128C08C5C3
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:39 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r15so4790078wmh.5
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZpoYXp44avpR1ovbikkhbHProtxbWL0REBJrEQezDM0=;
        b=gKYfAbjcTfoyMTS55wjdiYigimR+mMSOB3QmiARbgO9IIlSc4c1swafC2yeLCu9Mfg
         AY0Z+769Ys0KzAWSSGz6F/qL9TLiFY8rri2kI0pra97Q+Zg5COHImSUwg12RaUyTNjuI
         HbJr9I5fCUtrUa911BJZzurjEyFF5MKFUR6RYIShA8Q3g4s2a3/lLrbmA8l1CG5RO6J5
         vxQ9gPNwbfp1Es1oy366ev+40SjhUNFjqSWJbRWw1biOjlZhBJ7KC+JfJPfQXXqw42KT
         sNlNiH9w3KQoBUe6V2S3wu/nvMKojz4L3PxyuvJjoDFNUMvtQbITAuAnHasy/hsNo72q
         GsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZpoYXp44avpR1ovbikkhbHProtxbWL0REBJrEQezDM0=;
        b=G50ostAITVQfM0JuK0URk4xfVZjzP4sINc5jHXaSnOKfdCphqWNSyVJQbBWN3AlR0z
         eRdGGKtNEcSWJbCjd2zgqjM5OYs504WsfJp8yuEtHW5knJhJI6mBfnkYhPqYYw2TMuq3
         07KreGqmOZYkXGfc/n4M5+SjNvNtTShAxp8aW/fHhvo1DI9AQHZdmuZUe5MSQxYstvkG
         3G2SKpmMg0SAF+HO0dU4lmzDebwa+flG9WpaZJxSOqnB/Uf8OpPB8SK5gGJSkJiaEX2k
         vPVLOXhcaWfwq+wksH7Zp84fN9/e6YdRl6qW8r1y7Gw9IcSo79ep6XPAnOrlArRFMvKu
         pp5w==
X-Gm-Message-State: AOAM532yFEbQM+p7ObIh2qhsSOKI982NuaKFsRSWE54mk1maQIT8e9iI
        uVDH9mCiGP/nSQCjp2ACWZdg8o54aa0=
X-Google-Smtp-Source: ABdhPJy6AU0ppVdDJNML9INF9ZZiukov3hDry2QtYqcj2scoq3blBVykwL5f/CRAHCSxT+WyCuEcrw==
X-Received: by 2002:a7b:cf31:: with SMTP id m17mr7449910wmg.47.1591877138108;
        Thu, 11 Jun 2020 05:05:38 -0700 (PDT)
Received: from localhost.localdomain ([185.228.229.208])
        by smtp.gmail.com with ESMTPSA id o8sm4047174wmb.20.2020.06.11.05.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 05:05:37 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 04/14] upload-pack: pass upload_pack_data to send_unshallow()
Date:   Thu, 11 Jun 2020 14:05:08 +0200
Message-Id: <20200611120518.10771-5-chriscool@tuxfamily.org>
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
more thoroughly, let's pass that struct to send_unshallow(), so
that this function can use all the fields of the struct.

This will be used in followup commits to move static variables
into 'upload_pack_data'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index aa8cde6dbf..3b4749d120 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -715,17 +715,15 @@ static void send_shallow(struct packet_writer *writer,
 	}
 }
 
-static void send_unshallow(struct packet_writer *writer,
-			   const struct object_array *shallows,
-			   struct object_array *want_obj)
+static void send_unshallow(struct upload_pack_data *data)
 {
 	int i;
 
-	for (i = 0; i < shallows->nr; i++) {
-		struct object *object = shallows->objects[i].item;
+	for (i = 0; i < data->shallows.nr; i++) {
+		struct object *object = data->shallows.objects[i].item;
 		if (object->flags & NOT_SHALLOW) {
 			struct commit_list *parents;
-			packet_writer_write(writer, "unshallow %s",
+			packet_writer_write(&data->writer, "unshallow %s",
 					    oid_to_hex(&object->oid));
 			object->flags &= ~CLIENT_SHALLOW;
 			/*
@@ -741,7 +739,7 @@ static void send_unshallow(struct packet_writer *writer,
 			parents = ((struct commit *)object)->parents;
 			while (parents) {
 				add_object_array(&parents->item->object,
-						 NULL, want_obj);
+						 NULL, &data->want_obj);
 				parents = parents->next;
 			}
 			add_object_array(object, NULL, &extra_edge_obj);
@@ -789,7 +787,7 @@ static void deepen(struct upload_pack_data *data, int depth)
 		free_commit_list(result);
 	}
 
-	send_unshallow(&data->writer, &data->shallows, &data->want_obj);
+	send_unshallow(data);
 }
 
 static void deepen_by_rev_list(struct upload_pack_data *data,
@@ -802,7 +800,7 @@ static void deepen_by_rev_list(struct upload_pack_data *data,
 	result = get_shallow_commits_by_rev_list(ac, av, SHALLOW, NOT_SHALLOW);
 	send_shallow(&data->writer, result);
 	free_commit_list(result);
-	send_unshallow(&data->writer, &data->shallows, &data->want_obj);
+	send_unshallow(data);
 }
 
 /* Returns 1 if a shallow list is sent or 0 otherwise */
-- 
2.27.0.90.gabb59f83a2

