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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569CCC433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36402207C3
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jS8i3LDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgFKMFl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgFKMFh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 08:05:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC35DC08C5C1
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:36 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x6so5848821wrm.13
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cG/zu+4G8PWCH//ql+TEDKup6eQGMfvqRWo9iA6rEQA=;
        b=jS8i3LDj+lvbSuGc4XR0iRX6SM9QQzKYw2CcAmgY3WKOGomPnz/0VdABLdMuURxOst
         SEhDTiwtiwUGUX/+bqNBLFizVQT8T7Ko10YpvQ5wfvoZSL9n39EEa1ZNipAQkHIKnUar
         AnDB6N2/udOx5wrtt9K+Y/gtN2/pLUCEl6qoUq6g6fVTk/0koY+1oylMUTjgU+c5iYrB
         /095M3NcGfHlubb3LgpkRjmzIbadsduSITJ+BlKYAUB+qt15/bR5B7cFA3EWIaWvC6lb
         IsY2bgOE1R/kX3+7cmTUDqHntR9dsajPjH3vc3nvhh5uK4g0IbwkoIGl2+Mr7O8xDim1
         lGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cG/zu+4G8PWCH//ql+TEDKup6eQGMfvqRWo9iA6rEQA=;
        b=CiOc8zcNhX1UZ32TNBE9QQAfQWnF4ZwvEUSB1Ijh+eWyjSVKhwzL+IvekNUKKuX2Kb
         7Ues56M8butXs3yiln5vSQwxdQleLNKXjN11GwuUZEmTUkDJ6WsdOftKPzZPWkFRAaju
         psP2SvsC56XSL1iJCK82caHWU4tFP5FSZ91ewT/kj1LhKS+JjBRv72oE2SLfxNE2LKVO
         T7Vihmp3P84IZbIrtsjJ9htW4hwux1kFxgSmtqsQRvl6I0bgir6/SOFR/JIu6KWUDcyF
         65PA9Z+X5odJBur1jPjftgL1hxDMg/36ildLayyFfL/nwcgqgMaYcgIeMn5ObChHZIbQ
         MANQ==
X-Gm-Message-State: AOAM533SIPRT0cg8df2YCN7wFkhPhpssoNzCY8Dv0XX5zrbzICwHIRDI
        v3ytN0sB/4sWAGbLPK+QyvdUzVX/NhA=
X-Google-Smtp-Source: ABdhPJzeutUHYvr43AihNNdA/+4alrWTxyT4BdTIXONbV8Bufb9b4hiqWJMcG9Igb62AGuMJqmx+nQ==
X-Received: by 2002:adf:fec8:: with SMTP id q8mr9586497wrs.2.1591877135027;
        Thu, 11 Jun 2020 05:05:35 -0700 (PDT)
Received: from localhost.localdomain ([185.228.229.208])
        by smtp.gmail.com with ESMTPSA id o8sm4047174wmb.20.2020.06.11.05.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 05:05:34 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 02/14] upload-pack: pass upload_pack_data to deepen()
Date:   Thu, 11 Jun 2020 14:05:06 +0200
Message-Id: <20200611120518.10771-3-chriscool@tuxfamily.org>
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
more thoroughly, let's pass that struct to deepen(), so that
this function can use all the fields of the struct.

This will be used in followup commits to move static variables
into 'upload_pack_data'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index ada9082b06..3f15828fd2 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -753,17 +753,16 @@ static void send_unshallow(struct packet_writer *writer,
 
 static int check_ref(const char *refname_full, const struct object_id *oid,
 		     int flag, void *cb_data);
-static void deepen(struct packet_writer *writer, int depth, int deepen_relative,
-		   struct object_array *shallows, struct object_array *want_obj)
+static void deepen(struct upload_pack_data *data, int depth)
 {
 	if (depth == INFINITE_DEPTH && !is_repository_shallow(the_repository)) {
 		int i;
 
-		for (i = 0; i < shallows->nr; i++) {
-			struct object *object = shallows->objects[i].item;
+		for (i = 0; i < data->shallows.nr; i++) {
+			struct object *object = data->shallows.objects[i].item;
 			object->flags |= NOT_SHALLOW;
 		}
-	} else if (deepen_relative) {
+	} else if (data->deepen_relative) {
 		struct object_array reachable_shallows = OBJECT_ARRAY_INIT;
 		struct commit_list *result;
 
@@ -774,23 +773,23 @@ static void deepen(struct packet_writer *writer, int depth, int deepen_relative,
 		head_ref_namespaced(check_ref, NULL);
 		for_each_namespaced_ref(check_ref, NULL);
 
-		get_reachable_list(shallows, &reachable_shallows);
+		get_reachable_list(&data->shallows, &reachable_shallows);
 		result = get_shallow_commits(&reachable_shallows,
 					     depth + 1,
 					     SHALLOW, NOT_SHALLOW);
-		send_shallow(writer, result);
+		send_shallow(&data->writer, result);
 		free_commit_list(result);
 		object_array_clear(&reachable_shallows);
 	} else {
 		struct commit_list *result;
 
-		result = get_shallow_commits(want_obj, depth,
+		result = get_shallow_commits(&data->want_obj, depth,
 					     SHALLOW, NOT_SHALLOW);
-		send_shallow(writer, result);
+		send_shallow(&data->writer, result);
 		free_commit_list(result);
 	}
 
-	send_unshallow(writer, shallows, want_obj);
+	send_unshallow(&data->writer, &data->shallows, &data->want_obj);
 }
 
 static void deepen_by_rev_list(struct packet_writer *writer, int ac,
@@ -815,8 +814,7 @@ static int send_shallow_list(struct upload_pack_data *data)
 	if (data->depth > 0 && data->deepen_rev_list)
 		die("git upload-pack: deepen and deepen-since (or deepen-not) cannot be used together");
 	if (data->depth > 0) {
-		deepen(&data->writer, data->depth, data->deepen_relative,
-		       &data->shallows, &data->want_obj);
+		deepen(data, data->depth);
 		ret = 1;
 	} else if (data->deepen_rev_list) {
 		struct argv_array av = ARGV_ARRAY_INIT;
@@ -1464,8 +1462,7 @@ static void send_shallow_info(struct upload_pack_data *data)
 
 	if (!send_shallow_list(data) &&
 	    is_repository_shallow(the_repository))
-		deepen(&data->writer, INFINITE_DEPTH, data->deepen_relative,
-		       &data->shallows, &data->want_obj);
+		deepen(data, INFINITE_DEPTH);
 
 	packet_delim(1);
 }
-- 
2.27.0.90.gabb59f83a2

