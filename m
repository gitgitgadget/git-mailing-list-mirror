Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B77CC1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeBFAUx (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:20:53 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34273 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbeBFAUw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:20:52 -0500
Received: by mail-pg0-f67.google.com with SMTP id s73so176736pgc.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KHBFr/62kUR6/1/hCGi0l83zmMptMUl0BLaXfIFTRVY=;
        b=CHXioy5aH4vvU0yuQ7nhqeVe0oqJMIb+/0FRVGteGAYaaVDe9mbtO2lrQ7NxCluJgh
         OF9txMjbQ0E+H60k2rxpcx2zXcdIxRFaTiG0/ltNaqFPvFLCT3qepdLzLchSvGO1Sa4F
         Lh9sIQXFom+91njDG/4Pez1u5Mdmvxb5RBn023eoIgNMCu2EvufB279CJusLc8ib73Hu
         t2zwnIEyoCtlcIqOc4FRtapqXzq5Jaxq0iTTUCVOB9BUqvQ0s6uXPjDAJJa/5/xwbl+j
         q3uyYdmkQHri1PIiHkDjxLJh8MYwHoYVwwJRLVj1GF342R7eWGzXYwPMv7qzONUEPSDy
         RfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KHBFr/62kUR6/1/hCGi0l83zmMptMUl0BLaXfIFTRVY=;
        b=TrxUWfL2JFYs1xQw+D6PEW4EMPenpf3RwRINcRWPqv2VE+kKpkKC82fJ6BgQUptl+k
         sqVlxPrgbmC7CTjYI6IxiTt+Ph6uuZk66Oa8M62ZxcUy5DqL8lRTUttJQptGsddd+7bs
         o37Yx8li3IgXYoymA6PO+vpJYIf9ZVm4awv4fSKDaOMb9CvH2Qm0eh8Qc9xzVsSwM8Xn
         Mj9lRLjlqD1bKHoE/o62XNm/BQLyIo2pPZHDjyrRO/pqq84G2Pq18eeQk7LMOEGMJPfe
         rpBKHfrmY/wLWs+BBBaxXRLHXqgys7yfaXw1UEDQO9k182sa1VR1cjqhrs9c9AdbofhN
         WGYw==
X-Gm-Message-State: APf1xPBFe7vLp5eNkxn3TGeC7sFpE/iHCH94RTUky3Vq3DvshknhC/Gs
        nna1KCOfP4q45WvvfUizA07YvkFs+68=
X-Google-Smtp-Source: AH8x225Ne0mNjyYc2FvV5Hhux+OjsbmekLSrwZ3aFEFtTrAeAtcfgzaJfvwtcb8rsvfHcmD3FgG5mw==
X-Received: by 10.98.107.71 with SMTP id g68mr551435pfc.96.1517876451228;
        Mon, 05 Feb 2018 16:20:51 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id m83sm19448371pfk.107.2018.02.05.16.20.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:20:50 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 117/194] streaming: add repository argument to open_istream_fn
Date:   Mon,  5 Feb 2018 16:16:32 -0800
Message-Id: <20180206001749.218943-19-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of open_istream_fn
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

Unlike the previous commits, this uses a run time check to make sure
the passed repository is the_repository instead of a compile time check.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 streaming.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/streaming.c b/streaming.c
index f0ff5e7245..8c1e1a1601 100644
--- a/streaming.c
+++ b/streaming.c
@@ -15,7 +15,8 @@ enum input_source {
 	pack_non_delta = 2
 };
 
-typedef int (*open_istream_fn)(struct git_istream *,
+typedef int (*open_istream_fn)(struct repository *,
+			       struct git_istream *,
 			       struct object_info *,
 			       const unsigned char *,
 			       enum object_type *);
@@ -29,7 +30,9 @@ struct stream_vtbl {
 
 #define open_method_decl(name) \
 	int open_istream_ ##name \
-	(struct git_istream *st, struct object_info *oi, \
+	(struct repository *r, \
+	 struct git_istream *st, \
+	 struct object_info *oi, \
 	 const unsigned char *sha1, \
 	 enum object_type *type)
 
@@ -147,8 +150,8 @@ struct git_istream *open_istream(const unsigned char *sha1,
 		return NULL;
 
 	st = xmalloc(sizeof(*st));
-	if (open_istream_tbl[src](st, &oi, real, type)) {
-		if (open_istream_incore(st, &oi, real, type)) {
+	if (open_istream_tbl[src](the_repository, st, &oi, real, type)) {
+		if (open_istream_incore(the_repository, st, &oi, real, type)) {
 			free(st);
 			return NULL;
 		}
@@ -338,6 +341,9 @@ static struct stream_vtbl loose_vtbl = {
 
 static open_method_decl(loose)
 {
+	if (r != the_repository)
+		BUG("r != the_repository");
+
 	st->u.loose.mapped = map_sha1_file(the_repository,
 					   sha1, &st->u.loose.mapsize);
 	if (!st->u.loose.mapped)
@@ -433,6 +439,9 @@ static open_method_decl(pack_non_delta)
 	struct pack_window *window;
 	enum object_type in_pack_type;
 
+	if (r != the_repository)
+		BUG("r != the_repository");
+
 	st->u.in_pack.pack = oi->u.packed.pack;
 	st->u.in_pack.pos = oi->u.packed.offset;
 	window = NULL;
@@ -490,6 +499,9 @@ static struct stream_vtbl incore_vtbl = {
 
 static open_method_decl(incore)
 {
+	if (r != the_repository)
+		BUG("r != the_repository");
+
 	st->u.incore.buf = read_sha1_file_extended(the_repository, sha1,
 						   type, &st->size, 0);
 	st->u.incore.read_ptr = 0;
-- 
2.15.1.433.g936d1b9894.dirty

