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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94388C433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D7D20760
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vu4217Ae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgFKMFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgFKMFo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 08:05:44 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C81C08C5C1
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:42 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k26so4787739wmi.4
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CBkoA5bP9U4k1FkqEJXWUd6cIv4gdRbSUWXRIUOZTLA=;
        b=Vu4217AegXEfI1oG6XhZA90mXB0sCZpPLhxsfEHtazLdLsAHLAm5NyX2J7xfEdDQIT
         TmUgENtvgvunxfxoAyBbN4ar0FEbOWCKlAFn/xOqDJB/Em72h8eLeClTUo1Izt8MGeDl
         fJTWoRzVtUifCh+wZnLeqkXjBlfBc7JuA2y2xyccG0axoEAcjYLrkbkkJ4UQRggAfG3n
         oY7tzEBRE8L7BDgxEURuyEofM3MmxXDVB9Habja7nxGYfUgf2sco24gClU1B2tPowrXZ
         JLzSkOIpw85HDT4XRYdqRzH8QshikEK1ClDMM+kJeKytw8wUx15LqdW9J1B6hgtelEZd
         BfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CBkoA5bP9U4k1FkqEJXWUd6cIv4gdRbSUWXRIUOZTLA=;
        b=WwDZoUwGKdjiiaSwjT75D0LlsPtFdi4tcCJUNskjceWW2Afp5s/ItWiNGGCVGYKrD5
         P63pwSaUpOZjElE7OyfC2f5vnAcT/oaa/N7yYYANWXcQ4+9pKG3agB4GuInCTAedXnox
         qIY89XqKXIBntos3Ix1d0V6zOhUuzIzeu2bPxbZsgjTuPh+5XF7Wfl1EsiSjTB4uGoXZ
         nwJD+82pj/XfpXcOA0VfPlp4qbzuM8CK9kQEYTdDgpmkAafwRfKXsTTVPDQZ3VUBcVsc
         dF0r5cHOx+r2PtmuJRFbQIqkYDe/+8sTRJ4m3LmFLJSNezda+Pq+/Nq2zjksBkKJBf6b
         1idA==
X-Gm-Message-State: AOAM5327QomVlXRcCjOm2azrVc+lqbbReZHm7C9FWl/f7OhBapaxO3EZ
        WDgNU8v8i70aenD5z7WjorQTGjzl10U=
X-Google-Smtp-Source: ABdhPJyp1OVA8hwIz+v9f1+xDAEQQ4cNPETD3xiLtDZ5jhOSEa+YeO85ZQ5LtBQajvrYbGPagdeM9A==
X-Received: by 2002:a7b:cf35:: with SMTP id m21mr8176390wmg.181.1591877140999;
        Thu, 11 Jun 2020 05:05:40 -0700 (PDT)
Received: from localhost.localdomain ([185.228.229.208])
        by smtp.gmail.com with ESMTPSA id o8sm4047174wmb.20.2020.06.11.05.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 05:05:40 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 06/14] upload-pack: move extra_edge_obj to upload_pack_data
Date:   Thu, 11 Jun 2020 14:05:10 +0200
Message-Id: <20200611120518.10771-7-chriscool@tuxfamily.org>
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
more thoroughly, let's move the 'extra_edge_obj' static variable
into this struct.

It is used by code common to protocol v0 and protocol v2.

While at it let's properly initialize and clear 'extra_edge_obj'
in the appropriate 'upload_pack_data' initialization and
clearing functions.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index d00a8d6b77..acddfe28d6 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -51,7 +51,6 @@ static timestamp_t oldest_have;
 /* Allow request of any sha1. Implies ALLOW_TIP_SHA1 and ALLOW_REACHABLE_SHA1. */
 #define ALLOW_ANY_SHA1	07
 static unsigned int allow_unadvertised_object_request;
-static struct object_array extra_edge_obj;
 
 /*
  * Please annotate, and if possible group together, fields used only
@@ -66,6 +65,7 @@ struct upload_pack_data {
 
 	struct object_array shallows;
 	struct string_list deepen_not;
+	struct object_array extra_edge_obj;
 	int depth;
 	timestamp_t deepen_since;
 	int deepen_rev_list;
@@ -114,6 +114,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	struct oid_array haves = OID_ARRAY_INIT;
 	struct object_array shallows = OBJECT_ARRAY_INIT;
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
+	struct object_array extra_edge_obj = OBJECT_ARRAY_INIT;
 
 	memset(data, 0, sizeof(*data));
 	data->symref = symref;
@@ -123,6 +124,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	data->haves = haves;
 	data->shallows = shallows;
 	data->deepen_not = deepen_not;
+	data->extra_edge_obj = extra_edge_obj;
 	packet_writer_init(&data->writer, 1);
 
 	data->keepalive = 5;
@@ -137,6 +139,7 @@ static void upload_pack_data_clear(struct upload_pack_data *data)
 	oid_array_clear(&data->haves);
 	object_array_clear(&data->shallows);
 	string_list_clear(&data->deepen_not, 0);
+	object_array_clear(&data->extra_edge_obj);
 	list_objects_filter_release(&data->filter_options);
 
 	free((char *)data->pack_objects_hook);
@@ -243,9 +246,9 @@ static void create_pack_file(struct upload_pack_data *pack_data)
 	for (i = 0; i < pack_data->have_obj.nr; i++)
 		fprintf(pipe_fd, "%s\n",
 			oid_to_hex(&pack_data->have_obj.objects[i].item->oid));
-	for (i = 0; i < extra_edge_obj.nr; i++)
+	for (i = 0; i < pack_data->extra_edge_obj.nr; i++)
 		fprintf(pipe_fd, "%s\n",
-			oid_to_hex(&extra_edge_obj.objects[i].item->oid));
+			oid_to_hex(&pack_data->extra_edge_obj.objects[i].item->oid));
 	fprintf(pipe_fd, "\n");
 	fflush(pipe_fd);
 	fclose(pipe_fd);
@@ -742,7 +745,7 @@ static void send_unshallow(struct upload_pack_data *data)
 						 NULL, &data->want_obj);
 				parents = parents->next;
 			}
-			add_object_array(object, NULL, &extra_edge_obj);
+			add_object_array(object, NULL, &data->extra_edge_obj);
 		}
 		/* make sure commit traversal conforms to client */
 		register_shallow(the_repository, &object->oid);
-- 
2.27.0.90.gabb59f83a2

