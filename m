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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7885C433E1
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8603D20760
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZR8orlGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgFKMFq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgFKMFl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 08:05:41 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A56C08C5C4
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r15so4790174wmh.5
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x7+bNtX6SO0pt0Erto7KC294bramb5v5kH/PlTrfA4Y=;
        b=ZR8orlGa9+g8jj2OfxUvEtbXTgH3ashfSBrb7AjnZ+j1sUHy+MdSXU4VmHCYX1TEy0
         DHmYHsPB7RtF2x/EGLkR4yJWbQDjomk6LZMeINcjb1nae6fqvtGyEWWxDh/ZBIjZKJeI
         x5fBjhzxx/ahBg49srkqcvZrzkbD1o8U5Sx6KYixGNa3ogtHDZ84yMnmtdU8zhhV8HEk
         IXraPXHqM+0nM5pKdaXRBQ/v2gC0s4CuXvxv7KRy9GxmDoVFEJQh4Hshih7PX96Kl4Ky
         BQo6HqQcQ/OeupUVgi17rIlMas/GV0zoP9PGrmZmRE5N0Huh9TgrPnN+iak8J+wTEUG8
         j8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x7+bNtX6SO0pt0Erto7KC294bramb5v5kH/PlTrfA4Y=;
        b=LCaMRwJEvqtVbCPRV+W8d0u3fvoD+EZoZJo2M8HgLQdmO9pVIi6T4IomTHGQ5K4ogK
         u4N/DwAIYdupYtvFU0NDWY4/EXZobnX+jBsO5o33FbPV0puYikF32N1A8B7At4h26CAV
         GveqmuoEwHQpJoS+EdGCA0k/n4XPJ93v9gV/HicVwsyBaCMrEMtKDVqtNf+btWJ3E+R2
         D4OBrnstNaV3m9qi7iz52NM0XeN1PmuI+Yslfrav0+wuPxg8FUvN9K1VuCeGelUQ5QsA
         LEEOL0y2BITP4vwppMc7QvMeikXS8LxE4n6pYFGaQzYJA4UsMbD9XU/AU8vNqz2hdRAU
         ueAA==
X-Gm-Message-State: AOAM531s0qnD+ZEpaUACC/7uqmX29iHeaNIu393FaO/ArtwzgViaGpvu
        PSb9IVVwODV+V9fhLi9tV99KpJQzysY=
X-Google-Smtp-Source: ABdhPJzc+Ns3xP2uOdF+SvUMoJ5foTHU6p2LtgOBgh8NP9iEdVbjAPzT3KPWNfBFsPEVDbdYg86Qrw==
X-Received: by 2002:a7b:c2a9:: with SMTP id c9mr7394016wmk.11.1591877139692;
        Thu, 11 Jun 2020 05:05:39 -0700 (PDT)
Received: from localhost.localdomain ([185.228.229.208])
        by smtp.gmail.com with ESMTPSA id o8sm4047174wmb.20.2020.06.11.05.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 05:05:39 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 05/14] upload-pack: move shallow_nr to upload_pack_data
Date:   Thu, 11 Jun 2020 14:05:09 +0200
Message-Id: <20200611120518.10771-6-chriscool@tuxfamily.org>
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
more thoroughly, let's move the 'shallow_nr' static variable
into this struct.

It is used by code common to protocol v0 and protocol v2.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 3b4749d120..d00a8d6b77 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -51,7 +51,6 @@ static timestamp_t oldest_have;
 /* Allow request of any sha1. Implies ALLOW_TIP_SHA1 and ALLOW_REACHABLE_SHA1. */
 #define ALLOW_ANY_SHA1	07
 static unsigned int allow_unadvertised_object_request;
-static int shallow_nr;
 static struct object_array extra_edge_obj;
 
 /*
@@ -72,6 +71,7 @@ struct upload_pack_data {
 	int deepen_rev_list;
 	int deepen_relative;
 	int keepalive;
+	int shallow_nr;
 
 	unsigned int timeout;					/* v0 only */
 	enum {
@@ -192,7 +192,7 @@ static void create_pack_file(struct upload_pack_data *pack_data)
 		pack_objects.use_shell = 1;
 	}
 
-	if (shallow_nr) {
+	if (pack_data->shallow_nr) {
 		argv_array_push(&pack_objects.args, "--shallow-file");
 		argv_array_push(&pack_objects.args, "");
 	}
@@ -202,7 +202,7 @@ static void create_pack_file(struct upload_pack_data *pack_data)
 		argv_array_push(&pack_objects.args, "--thin");
 
 	argv_array_push(&pack_objects.args, "--stdout");
-	if (shallow_nr)
+	if (pack_data->shallow_nr)
 		argv_array_push(&pack_objects.args, "--shallow");
 	if (!pack_data->no_progress)
 		argv_array_push(&pack_objects.args, "--progress");
@@ -233,7 +233,7 @@ static void create_pack_file(struct upload_pack_data *pack_data)
 
 	pipe_fd = xfdopen(pack_objects.in, "w");
 
-	if (shallow_nr)
+	if (pack_data->shallow_nr)
 		for_each_commit_graft(write_one_shallow, pipe_fd);
 
 	for (i = 0; i < pack_data->want_obj.nr; i++)
@@ -700,16 +700,16 @@ static void check_non_tip(struct upload_pack_data *data)
 	}
 }
 
-static void send_shallow(struct packet_writer *writer,
+static void send_shallow(struct upload_pack_data *data,
 			 struct commit_list *result)
 {
 	while (result) {
 		struct object *object = &result->item->object;
 		if (!(object->flags & (CLIENT_SHALLOW|NOT_SHALLOW))) {
-			packet_writer_write(writer, "shallow %s",
+			packet_writer_write(&data->writer, "shallow %s",
 					    oid_to_hex(&object->oid));
 			register_shallow(the_repository, &object->oid);
-			shallow_nr++;
+			data->shallow_nr++;
 		}
 		result = result->next;
 	}
@@ -775,7 +775,7 @@ static void deepen(struct upload_pack_data *data, int depth)
 		result = get_shallow_commits(&reachable_shallows,
 					     depth + 1,
 					     SHALLOW, NOT_SHALLOW);
-		send_shallow(&data->writer, result);
+		send_shallow(data, result);
 		free_commit_list(result);
 		object_array_clear(&reachable_shallows);
 	} else {
@@ -783,7 +783,7 @@ static void deepen(struct upload_pack_data *data, int depth)
 
 		result = get_shallow_commits(&data->want_obj, depth,
 					     SHALLOW, NOT_SHALLOW);
-		send_shallow(&data->writer, result);
+		send_shallow(data, result);
 		free_commit_list(result);
 	}
 
@@ -798,7 +798,7 @@ static void deepen_by_rev_list(struct upload_pack_data *data,
 
 	disable_commit_graph(the_repository);
 	result = get_shallow_commits_by_rev_list(ac, av, SHALLOW, NOT_SHALLOW);
-	send_shallow(&data->writer, result);
+	send_shallow(data, result);
 	free_commit_list(result);
 	send_unshallow(data);
 }
@@ -844,7 +844,7 @@ static int send_shallow_list(struct upload_pack_data *data)
 		}
 	}
 
-	shallow_nr += data->shallows.nr;
+	data->shallow_nr += data->shallows.nr;
 	return ret;
 }
 
@@ -922,7 +922,7 @@ static void receive_needs(struct upload_pack_data *data,
 {
 	int has_non_tip = 0;
 
-	shallow_nr = 0;
+	data->shallow_nr = 0;
 	for (;;) {
 		struct object *o;
 		const char *features;
-- 
2.27.0.90.gabb59f83a2

