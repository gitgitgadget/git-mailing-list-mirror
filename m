Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 393861F404
	for <e@80x24.org>; Wed, 21 Feb 2018 01:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751506AbeBUBzR (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 20:55:17 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37334 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751484AbeBUBzK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 20:55:10 -0500
Received: by mail-pg0-f67.google.com with SMTP id y26so62532pgv.4
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 17:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LdZL0aZZrUkkwsLcA1uy0JpqYyGhin9QhvewaroT3Es=;
        b=MnnDTApFfBqPuYw7ctYYO0LQmGDQwS0R3nqWaqs+Ij+XQ9c+EHJCVXDXnwjbuHRIWX
         wYYuZe6SIphPUOuncHyMzM9ktpmEYEBiM5Y9OcmCQ318vPxBQxObAN8izN2gPkzs5sdO
         +dQfErZYphOF87kyQ6EaBoYfqltVEMTRNZFvv8If0rOjHettDQ/CK1dDaqPbFBTnCnBa
         d4BzlXlT+eto9DypNwocynyhP5QQ+cTdbZOMlRq3lpWjVVEgs8QLwb+xahJeA6ZwOiJW
         tIhmAg40SkWCEpRFQjgax9t4DAyI8KOJs+ZR7S8OjvmkvH7/lc6o+MS0RdI3iMJ5zd5W
         Y0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LdZL0aZZrUkkwsLcA1uy0JpqYyGhin9QhvewaroT3Es=;
        b=JAmOQKNXbUnvgOBdsp9y8d1K5827uzOImv6rCzP9Gbj6JyLqOsdrQT5vryDf0AuMQ+
         pkVrzY2DGrIeFt7ta1Chzlwpe4Kg363L4cmFOdUUWZ5dzE/FD10QJxTKFayMjWPaqaRu
         kSDfkD16K2uJSK8S3PQQI8rrwbjMLJlaVA38uWhWh8a+94ZJxpbksbHauMLlAZ1Nklh1
         WuWthZeZYsD7YQ7lcZqcz2ZZbdEN6Gdb/0/pJnULaqH95++A9sZmnM0VomIUgylg+L+I
         xykh9ppx9ifPY+q4JIcu80vo6R836jluSEy5NP7uwNuM1+ar+xn1aZ9c/uWXCPEgkV6A
         LnQg==
X-Gm-Message-State: APf1xPANTrEZakk583DN2y97m9w/wsGBSmBj1qWs5vlsybZFACuycu4f
        3Z4xdeS3NZ6EfnPtkv4iNFYU3bGC1nE=
X-Google-Smtp-Source: AH8x225fs5IVVXwUM0T7L3qqWdbAw38/3u2CODhbXeDj94FIUgJ1iC6nt/vvnWVoLM35V1W9zsvqAA==
X-Received: by 10.99.180.79 with SMTP id n15mr1366111pgu.314.1519178109259;
        Tue, 20 Feb 2018 17:55:09 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id t3sm13939020pgt.75.2018.02.20.17.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 17:55:08 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 18/27] sha1_file: add repository argument to open_sha1_file
Date:   Tue, 20 Feb 2018 17:54:21 -0800
Message-Id: <20180221015430.96054-19-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180221015430.96054-1-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the open_sha1_file caller to be
more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index ed297773e5..68aff90792 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -903,7 +903,9 @@ static int stat_sha1_file_the_repository(const unsigned char *sha1,
  * Like stat_sha1_file(), but actually open the object and return the
  * descriptor. See the caveats on the "path" parameter above.
  */
-static int open_sha1_file(const unsigned char *sha1, const char **path)
+#define open_sha1_file(r, s, p) open_sha1_file_##r(s, p)
+static int open_sha1_file_the_repository(const unsigned char *sha1,
+					 const char **path)
 {
 	int fd;
 	struct alternate_object_database *alt;
@@ -946,7 +948,7 @@ static void *map_sha1_file_1(const char *path,
 	if (path)
 		fd = git_open(path);
 	else
-		fd = open_sha1_file(sha1, &path);
+		fd = open_sha1_file(the_repository, sha1, &path);
 	map = NULL;
 	if (fd >= 0) {
 		struct stat st;
-- 
2.16.1.291.g4437f3f132-goog

