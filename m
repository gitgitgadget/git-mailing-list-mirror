Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08AE41F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752085AbeBFAI4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:08:56 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41159 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbeBFAIx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:08:53 -0500
Received: by mail-pg0-f67.google.com with SMTP id 141so132910pgd.8
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TQMVPu8JmdxHu6mkcKQxHEqDdfbFS4Blk7/y05Q3qs8=;
        b=PqT7866LV1w6QHHrHTok2jjaq2Wxqc7qvxojhm80smcxV8KCQCtUbYT5tBuT5o8XUB
         CWutvk0Qepn89KC3PPaovrogd/TRmr9MhufWhy1FFzC9+LyRwGKUc40IKxdxEqXbHchj
         rSU9PQ39mAZroynVisMeYDb0pHQYCVrf/LekUFqfmmzp4Ka0/Yvblj13cl2CYPBgvXSr
         SiDjCrT0FORaXkwIbivZxZqSoWxjEBjBE8IkWlu3QM8Zis8kq6pDHpD9AiCEBNlwWcdj
         MEZ4KyYBfEVPSxU61QwHkoHhu1VclnbHdZv3hNUDzSIefV7g6+hpI+5XWqH+bVb2cKKa
         5fLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TQMVPu8JmdxHu6mkcKQxHEqDdfbFS4Blk7/y05Q3qs8=;
        b=kWWvM2BGUUOgOd2KWw4ZNsmuUtEy95jWWXczUqf69QdWg0LPIE2l/21cYGUKG+77xV
         BoSNQUvT2JY4PXBm8JHhZVDxASWbO5P1LFbYzALZJ2kW1Tkk5h4atRjnpiW0LIEyVaox
         GMM0Fo4Hl5qrvsd1PdBdz+v1lrWM79wtjFzHYVJu4ySRNY90bsF5ZA7ryQuLRmzeBhbu
         Y+jGaSUruSksMoDxIA6WeqxV6+QXCr78vyWBuJhNKiETl7fvmbG3wxoegwDjFH8bcfvq
         y24TZpA8KsyWPGuF4HQHSFUPsPJLQ+cFi48ps2Fq2UhRIQTHOymE6GLAOo24fE/rVmpj
         i4qA==
X-Gm-Message-State: APf1xPB+PNxwfJQ9ZbKxJ2cvBG5yM5DwEHqP305d+Q0E3zvx5943uMlf
        zgrZATN/ZItiokTA3Ksz9mOAqfLOeRI=
X-Google-Smtp-Source: AH8x224nhxyMGC0OrhvZS4sSwpT9CYzwzEH/xC5v14qxYjFtTRKf6FnlC+h10Es6wX+3UMSpnUNEsQ==
X-Received: by 10.98.237.6 with SMTP id u6mr526466pfh.190.1517875732555;
        Mon, 05 Feb 2018 16:08:52 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id q10sm9587512pfl.106.2018.02.05.16.08.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:08:51 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 070/194] packfile: add repository argument to read_object
Date:   Mon,  5 Feb 2018 15:55:31 -0800
Message-Id: <20180205235735.216710-50-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of read_object
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 packfile.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/packfile.c b/packfile.c
index f641f6329a..56b2db8b06 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1447,8 +1447,10 @@ struct unpack_entry_stack_ent {
 	unsigned long size;
 };
 
-static void *read_object(const unsigned char *sha1, enum object_type *type,
-			 unsigned long *size)
+#define read_object(r, s, t, sz) read_object_##r(s, t, sz)
+static void *read_object_the_repository(const unsigned char *sha1,
+					enum object_type *type,
+					unsigned long *size)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
 	void *content;
@@ -1592,7 +1594,7 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 				      sha1_to_hex(base_sha1), (uintmax_t)obj_offset,
 				      p->pack_name);
 				mark_bad_packed_object(p, base_sha1);
-				base = read_object(base_sha1, &type, &base_size);
+				base = read_object(the_repository, base_sha1, &type, &base_size);
 				external_base = base;
 			}
 		}
-- 
2.15.1.433.g936d1b9894.dirty

