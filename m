Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B4C61F404
	for <e@80x24.org>; Sun,  7 Jan 2018 18:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754437AbeAGSPU (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 13:15:20 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:37859 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754393AbeAGSPS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 13:15:18 -0500
Received: by mail-qk0-f194.google.com with SMTP id p13so11730496qke.4
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 10:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kAXxwRopM+b0TMZQwojlzPzRO7isk4McScG4PPB9lGA=;
        b=RmVk13leAK7Xz37zLHMhXLtuzv4xDJQc5YtAYiCLGu7wd1AfIYGqPFoh/8psCzWa7S
         XqM5zOMpPG5VJFeXj6wIHtGdkbdFIDJ8h3xw0aHpMKb/ApXJAkcG3jSv1tVwjmrWFBU+
         hwegSxCW6jmIBMgO7x1jQGfywfMI9l+t8FP11GECKQOUTudJenm8SJiOiqLIk+sCuOHF
         6rZUb56HjQpPVxN4zm+TQVrxhRQlNTB7IQ17twCSl4d73dSRO2TPBP5zKoV4cO1B3Ukv
         xL6Sa6B4N38QMoxADqwHb+H2zNB00axVnsO1SMZ4WvkcFhPfF8OpgqgHmOQTpH+wgYSv
         dB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kAXxwRopM+b0TMZQwojlzPzRO7isk4McScG4PPB9lGA=;
        b=AbjX+oPvZQeGKTgfnx/toQJn9BWWNrUOK+XagOO8/d8Jx6uaN3ftNFC/HjDHbPTh3t
         jBNz/EPb346bDD2D9ZiRx5XT5l8MNJvS0jEEGlBTPGXdeBkPB2edFuD/SgVkVr8nTLO9
         1oD+SyGSHmeFfUK7YD6l/sk8J9GvCfEV3rWgVqL3y0R2HLA8x6GwbnKX7nRgFhIN0yjT
         g3QNoSPuXydXjUJfuQmKZnZjanizHwIO7B6IvAbkz9BYjU/q/vPHSAZvsBVcB7CjSNbo
         8F4GY434b4W2sq40Kpb3mjyM+ITU6/+wX5ydPpxagHR5HXyTM0DqHyFqhU6kerOi4Y68
         KMCQ==
X-Gm-Message-State: AKwxytcFcZRptOy3GwN9eIthnQmcSTvRMQUfnnnShFsB6s/wd8E6Z1/0
        t+gXirGKTHjYfOVFAnQa0DPvzkW73IQ=
X-Google-Smtp-Source: ACJfBotWj4ylhe2VwUcW4PM5+QTJ4FRr8pdamjqtQwDQSXV247327g6JFCMKhHqiRGHAl3gj0wBtBA==
X-Received: by 10.55.50.83 with SMTP id y80mr12392735qky.347.1515348917634;
        Sun, 07 Jan 2018 10:15:17 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id f38sm6599763qtc.73.2018.01.07.10.15.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jan 2018 10:15:16 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, stolee@gmail.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, Johannes.Shindelin@gmx.de,
        jrnieder@gmail.com
Subject: [RFC PATCH 09/18] midx: find details of nth object in midx
Date:   Sun,  7 Jan 2018 13:14:50 -0500
Message-Id: <20180107181459.222909-10-dstolee@microsoft.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180107181459.222909-1-dstolee@microsoft.com>
References: <20180107181459.222909-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The MIDX file stores pack offset information for a list of objects. The
nth_midxed_object_* methods provide ways to extract this information.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 midx.h | 15 +++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/midx.c b/midx.c
index c631be451f..4e0df0285a 100644
--- a/midx.c
+++ b/midx.c
@@ -202,6 +202,61 @@ struct pack_midx_details_internal {
 	uint32_t internal_offset;
 };
 
+struct pack_midx_details *nth_midxed_object_details(struct midxed_git *m,
+						    uint32_t n,
+						    struct pack_midx_details *d)
+{
+	struct pack_midx_details_internal *d_internal;
+	const unsigned char *details = m->chunk_object_offsets;
+
+	if (n >= m->num_objects)
+		return NULL;
+
+	d_internal = (struct pack_midx_details_internal*)(details + 8 * n);
+	d->pack_int_id = ntohl(d_internal->pack_int_id);
+	d->offset = ntohl(d_internal->internal_offset);
+
+	if (m->chunk_large_offsets && d->offset & MIDX_LARGE_OFFSET_NEEDED) {
+		uint32_t large_offset = d->offset ^ MIDX_LARGE_OFFSET_NEEDED;
+		const unsigned char *large_offsets = m->chunk_large_offsets + 8 * large_offset;
+
+		d->offset =  (((uint64_t)ntohl(*((uint32_t *)(large_offsets + 0)))) << 32) |
+					 ntohl(*((uint32_t *)(large_offsets + 4)));
+	}
+
+	return d;
+}
+
+struct pack_midx_entry *nth_midxed_object_entry(struct midxed_git *m,
+						uint32_t n,
+						struct pack_midx_entry *e)
+{
+	struct pack_midx_details details;
+	const unsigned char *index = m->chunk_oid_lookup;
+
+	if (!nth_midxed_object_details(m, n, &details))
+		return NULL;
+
+	memcpy(e->oid.hash, index + m->hdr->hash_len * n, m->hdr->hash_len);
+	e->pack_int_id = details.pack_int_id;
+	e->offset = details.offset;
+
+	return e;
+}
+
+const struct object_id *nth_midxed_object_oid(struct object_id *oid,
+					      struct midxed_git *m,
+					      uint32_t n)
+{
+	struct pack_midx_entry e;
+
+	if (!nth_midxed_object_entry(m, n, &e))
+		return 0;
+
+	hashcpy(oid->hash, e.oid.hash);
+	return oid;
+}
+
 static int midx_sha1_compare(const void *_a, const void *_b)
 {
 	struct pack_midx_entry *a = *(struct pack_midx_entry **)_a;
diff --git a/midx.h b/midx.h
index 92b74e49db..9255909ae8 100644
--- a/midx.h
+++ b/midx.h
@@ -85,6 +85,21 @@ struct midxed_git {
 
 extern struct midxed_git *get_midxed_git(const char *pack_dir, struct object_id *oid);
 
+struct pack_midx_details {
+	uint32_t pack_int_id;
+	off_t offset;
+};
+
+extern struct pack_midx_details *nth_midxed_object_details(struct midxed_git *m,
+							   uint32_t n,
+							   struct pack_midx_details *d);
+extern struct pack_midx_entry *nth_midxed_object_entry(struct midxed_git *m,
+						       uint32_t n,
+						       struct pack_midx_entry *e);
+extern const struct object_id *nth_midxed_object_oid(struct object_id *oid,
+						     struct midxed_git *m,
+						     uint32_t n);
+
 /*
  * Write a single MIDX file storing the given entries for the
  * given list of packfiles. If midx_name is null, then a temp
-- 
2.15.0

