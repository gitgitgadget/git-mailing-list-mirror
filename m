Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BDB91F404
	for <e@80x24.org>; Wed, 21 Feb 2018 01:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbeBUBzQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 20:55:16 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38597 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeBUBzL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 20:55:11 -0500
Received: by mail-pf0-f195.google.com with SMTP id d26so60290pfn.5
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 17:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6xZYjlp630TEJPCFug4S0b2L5B9DRHsl2Ztv8Azj9Os=;
        b=iTkJbnn48gYyj8+BOwunfq9Mi6Rt+Wt+V+gqL6NklmQayanwqef7pwpt8rJ0nwb3rq
         AQYkDyJBgy8ulziKkPiv2s3L4BUcNIqHjO/7wcBWyxW9sI+Tlg8PhGlkmaczyES166t9
         /gcF2Y6TsxKarKID4MlFUCpvjKg2XNWhyLXOgblKho4+508Im/j16t3pkHict5a5UYP6
         UcSLs78+KpXiMXiXkYWkbzqp+Q6GkgFD2DyxSmWMC2MDs4ha5Qk9ZhGhT2BiEenrlNJT
         bTLOf+jsVWNrZwR9m8lYM7xiffJ8k5Hstv5Uxhd663sUHP31AGnh3yISqdaPHIsB5m8y
         jYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6xZYjlp630TEJPCFug4S0b2L5B9DRHsl2Ztv8Azj9Os=;
        b=drXI4Z28MTh2k4ruz9vMfCgCnZmNo7SZ2p3M7i1UY0v/EKZy2+J74uatb4yhQpDXG2
         f34z3lVcXYm+ubeh8xLKYozXzmWO/hdg89CMu/z02I5Watw/BWxdNIOvQl0Wqtv6tHF5
         sR8ZdvLHFh3/UofcRew1Zjle49ytCVwH7dM2tfg6XOtr72JGykbQEIahpX6e1Ow4t9MF
         5GXuzjJfajy020b+75O+Z/F8V8t9oZSldjM6Fc4H9zl/oJJoaRKlE+mmUz+zzoKzCGUp
         jGLE2uE08GWF4FzJckTZF2KuHYphHqElZbwjvXp/+p9Ni6sITGrY4crU4jwtCmHILCDy
         YmTQ==
X-Gm-Message-State: APf1xPD/JPpZRRu+IMQHfSeICRsnGkMb61nUrqIaT0ybRxrb6Rzys7fw
        ZeUh2YYitz1qLNCT4Ju2rmzizw==
X-Google-Smtp-Source: AH8x225J1IWZuKCSKnJ+Ji1U7N56xspxIUvBz98ADVsE+p6VXL573FNpt/8jeN8dsToW9ZMmsFe/SQ==
X-Received: by 10.99.49.198 with SMTP id x189mr1316840pgx.135.1519178110892;
        Tue, 20 Feb 2018 17:55:10 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id t25sm57687152pge.41.2018.02.20.17.55.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 17:55:10 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 19/27] sha1_file: add repository argument to map_sha1_file_1
Date:   Tue, 20 Feb 2018 17:54:22 -0800
Message-Id: <20180221015430.96054-20-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180221015430.96054-1-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the map_sha1_file_1 caller to be
more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 68aff90792..7fa9ed2f25 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -938,9 +938,10 @@ static int open_sha1_file_the_repository(const unsigned char *sha1,
  * Map the loose object at "path" if it is not NULL, or the path found by
  * searching for a loose object named "sha1".
  */
-static void *map_sha1_file_1(const char *path,
-			     const unsigned char *sha1,
-			     unsigned long *size)
+#define map_sha1_file_1(r, p, s, si) map_sha1_file_1_##r(p, s, si)
+static void *map_sha1_file_1_the_repository(const char *path,
+					    const unsigned char *sha1,
+					    unsigned long *size)
 {
 	void *map;
 	int fd;
@@ -969,7 +970,7 @@ static void *map_sha1_file_1(const char *path,
 
 void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
 {
-	return map_sha1_file_1(NULL, sha1, size);
+	return map_sha1_file_1(the_repository, NULL, sha1, size);
 }
 
 static int unpack_sha1_short_header(git_zstream *stream,
@@ -2199,7 +2200,7 @@ int read_loose_object(const char *path,
 
 	*contents = NULL;
 
-	map = map_sha1_file_1(path, NULL, &mapsize);
+	map = map_sha1_file_1(the_repository, path, NULL, &mapsize);
 	if (!map) {
 		error_errno("unable to mmap %s", path);
 		goto out;
-- 
2.16.1.291.g4437f3f132-goog

