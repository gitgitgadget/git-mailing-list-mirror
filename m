Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07C771F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbeBEX4I (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:56:08 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33830 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752074AbeBEXzu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:55:50 -0500
Received: by mail-pg0-f65.google.com with SMTP id s73so125265pgc.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4YtiSSFCyxfS6DaOO6ZONwWpA8ZoBEHLXhx1/EpdHDA=;
        b=B7d9d1DIyclBWlvkFx61PPK7UvXWWcW10R0LV3gxx9OYavhx5iaZvu6AQqO6a4uIsX
         9gZpLec7UPBBy2r24qi0tB4zQcTqRMdSYssxVRyzOTbWM73nOTbkSQVSUJT7D9Bv2Jjk
         Xwhpnz5ycxDZpIDd3G5nXBIHq110pxuUv+V9v7oasKynZLYaj8vEkqH9Em+L9rbgeV6N
         T9VCHzDUuxpxCYmhyZVPE5QmMl7MEcUc1U3d5YOB1fui/Vpdruz0J8IcKnjle+jk16dv
         rixsY5CsYZekWV4q/jnODPI1ou/ZX5RI7mvcmQ6ZtyHQ+bkERuu6d9aaGuFle7t7mzRt
         kKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4YtiSSFCyxfS6DaOO6ZONwWpA8ZoBEHLXhx1/EpdHDA=;
        b=pcKcebppwCjA0H+CqJ/Me8W/QuhBj7D41QbMD+DZDbfhw7rBbQ6RmAQQZZzlivUO7h
         JHuA24dZD6SwascSiOD0UTU7FLdYZnfo97BXo98tVNd3rIWxpVEtYHAc5JCYz96Q1YA1
         7yYdWgnCu5/HaiOEJ9XTo8ewHCPJpoAfEnDirxLhhgeytgYbamTN6uoegsJTGlgZ31J2
         UGo7mPxYdEwoLtLtqH9y1i4FYXhJBIBhPVIHR7bEYeOBJx6rRAMrMaRtFqwf3FcF5SUE
         ZkmXbwRrHp3jl5VDB+muhYzfCjgF+Z55LqfFgIiMLcQuJUH0krs12uc7aT9I6rIfOxAE
         I84w==
X-Gm-Message-State: APf1xPAbtnlOT9ftDr6WDFsZI5EWP7zc55kYIZ8GukMTkcVfMfsENiyz
        hJrhErigMnDr1jutT3qyfG8Jn5GKj0M=
X-Google-Smtp-Source: AH8x224SBy5xnpCguBVlT0S+EP1Efl43VzywE3X8UI6jJiY5ybceCC9/GsZ1R+BkoJhbX+VNhPiX9A==
X-Received: by 10.99.113.7 with SMTP id m7mr369018pgc.403.1517874949114;
        Mon, 05 Feb 2018 15:55:49 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id z10sm14544659pgs.17.2018.02.05.15.55.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:55:48 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 012/194] sha1_file: add repository argument to map_sha1_file_1
Date:   Mon,  5 Feb 2018 15:52:06 -0800
Message-Id: <20180205235508.216277-13-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235508.216277-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
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
index 9fa7243907..24832c4b32 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -931,9 +931,10 @@ static int open_sha1_file_the_repository(const unsigned char *sha1,
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
@@ -962,7 +963,7 @@ static void *map_sha1_file_1(const char *path,
 
 void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
 {
-	return map_sha1_file_1(NULL, sha1, size);
+	return map_sha1_file_1(the_repository, NULL, sha1, size);
 }
 
 static int unpack_sha1_short_header(git_zstream *stream,
@@ -2174,7 +2175,7 @@ int read_loose_object(const char *path,
 
 	*contents = NULL;
 
-	map = map_sha1_file_1(path, NULL, &mapsize);
+	map = map_sha1_file_1(the_repository, path, NULL, &mapsize);
 	if (!map) {
 		error_errno("unable to mmap %s", path);
 		goto out;
-- 
2.15.1.433.g936d1b9894.dirty

