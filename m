Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B771D1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752233AbeBFAV1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:21:27 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40879 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752110AbeBFAVY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:21:24 -0500
Received: by mail-pl0-f67.google.com with SMTP id g18so124704plo.7
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BNqqf4mqan3+Yfpjo1hyt9XXc+i2iYTgYKPYpaTMGgM=;
        b=T6rDhjj1hyrGaUk86hLJmBUTyPItZauUpIV/ANed8tkfaxf9XFkLLTG/hQPCTr2a0H
         OlmPM6fVSOj88fN6dy1p1WpzgqRwRdGGUtM8lVOE8gDKX1/VX5h/TRsXmKY/CrU1u5Ca
         4g1y/6pZuCm6OHSlvyq0QYe+VYXbeHmQFeucBUyI6jt6tDVeUmkkj6LmQtqFbTHMBZ1m
         KMd5envIwLcb1qJ8fte3XWN994AewI/SB8kRT/KWIAfUZ5yxx5JGCCyJCMKCKdc7f6aI
         D5bJ/etJZj7hyhm3KhuMpzvRKZdPzrUN7jJweLFdFqDHCK+yhUkzN4n4CmqE6Kq0mz+t
         VK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BNqqf4mqan3+Yfpjo1hyt9XXc+i2iYTgYKPYpaTMGgM=;
        b=TD58rTbq2j1bhmf0jB22zCCrqq8WKcs5MByxYPqHiT3lnpuAWmXayGyt1CMIUow7/3
         ve1DHFGR9euG8rIJLg87/a2CQY/3yuyPfL9p7cKK6gbkinB0tTlBiGrRmtDlTTnRU0rf
         jeb1i8R/RSPH3fQqqwRHAAIdR/4ZZGtR7WwN5THgvDI9kC+gpndLSM06BZq8YA+ccv0F
         VHatODimm/vG+0m4CDfpzYXcPOs4sekFvDrh3Fgg0HtHl96QP5dfw4N6MZV9nfzqp6VQ
         k6Py4T7G/+6YxdnYIn3+SjFhwBiIYz8oYMXD3aB7cfMQm2zEmdKuDjfUvzpFJeA24Bcu
         He0w==
X-Gm-Message-State: APf1xPBywJ1GIyu8kjauzQ5/3nf8wx/pCGEa3T6IS9NOR74oKlQ0gTfz
        m6vEQx3HpJaVZ+mpgi+BB6rhbj6p7LI=
X-Google-Smtp-Source: AH8x225YApkURy1AchRm3mR8c96hW7AUpHezA5ys9Cb7KAcRepIBDqpjmQUOJZ7LqBUdpXLYAS/LUQ==
X-Received: by 2002:a17:902:12f:: with SMTP id 44-v6mr531293plb.403.1517876482788;
        Mon, 05 Feb 2018 16:21:22 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id b9sm14081778pgq.35.2018.02.05.16.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:21:22 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 122/194] object-store.h: allow read_sha1_file{_extended} to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:16:37 -0800
Message-Id: <20180206001749.218943-24-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object-store.h | 10 +++++-----
 sha1_file.c    | 11 ++++++-----
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/object-store.h b/object-store.h
index 974f2de78d..47c38170e3 100644
--- a/object-store.h
+++ b/object-store.h
@@ -82,14 +82,14 @@ struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 };
 
-#define read_sha1_file_extended(r, s, t, sz, l) read_sha1_file_extended_##r(s, t, sz, l)
-extern void *read_sha1_file_extended_the_repository(const unsigned char *sha1,
+extern void *read_sha1_file_extended(struct repository *r,
+				     const unsigned char *sha1,
 				     enum object_type *type,
 				     unsigned long *size, int lookup_replace);
-#define read_sha1_file(r, s, t, sz) read_sha1_file_##r(s, t, sz)
-static inline void *read_sha1_file_the_repository(const unsigned char *sha1, enum object_type *type, unsigned long *size)
+
+static inline void *read_sha1_file(struct repository *r, const unsigned char *sha1, enum object_type *type, unsigned long *size)
 {
-	return read_sha1_file_extended(the_repository, sha1, type, size, 1);
+	return read_sha1_file_extended(r, sha1, type, size, 1);
 }
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
diff --git a/sha1_file.c b/sha1_file.c
index 6164ba29c5..743ada360d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1356,7 +1356,8 @@ int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
  * deal with them should arrange to call read_object() and give error
  * messages themselves.
  */
-void *read_sha1_file_extended_the_repository(const unsigned char *sha1,
+void *read_sha1_file_extended(struct repository *r,
+			      const unsigned char *sha1,
 			      enum object_type *type,
 			      unsigned long *size,
 			      int lookup_replace)
@@ -1366,10 +1367,10 @@ void *read_sha1_file_extended_the_repository(const unsigned char *sha1,
 	const char *path;
 	struct stat st;
 	const unsigned char *repl = lookup_replace ?
-		lookup_replace_object(the_repository, sha1) : sha1;
+		lookup_replace_object(r, sha1) : sha1;
 
 	errno = 0;
-	data = read_object(the_repository, repl, type, size);
+	data = read_object(r, repl, type, size);
 	if (data)
 		return data;
 
@@ -1381,11 +1382,11 @@ void *read_sha1_file_extended_the_repository(const unsigned char *sha1,
 		die("replacement %s not found for %s",
 		    sha1_to_hex(repl), sha1_to_hex(sha1));
 
-	if (!stat_sha1_file(the_repository, repl, &st, &path))
+	if (!stat_sha1_file(r, repl, &st, &path))
 		die("loose object %s (stored in %s) is corrupt",
 		    sha1_to_hex(repl), path);
 
-	if ((p = has_packed_and_bad(the_repository, repl)) != NULL)
+	if ((p = has_packed_and_bad(r, repl)) != NULL)
 		die("packed object %s (stored in %s) is corrupt",
 		    sha1_to_hex(repl), p->pack_name);
 
-- 
2.15.1.433.g936d1b9894.dirty

