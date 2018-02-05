Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B55C1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeBEX4M (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:56:12 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42963 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752071AbeBEXzs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:55:48 -0500
Received: by mail-pg0-f68.google.com with SMTP id m28so105069pgc.9
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=doFvFj1oTq6hWI6vYNVk0g+5+he2D0gYp5MuwT4J4cE=;
        b=BAMLJYL24mfKE5qWbEb66CnoHjuNvPTmWi+Zb1y/Fnl3Yqw6NJBdm72HUNdxFg3/RF
         p1C74eCrYawOIvqSZw5L9o4OL2FMxUVukrS5J5BBeSRnKPFKwHL/a7E127mf3URJPSQh
         M4yu0PdZtkRuqJRQkIjs3UlAQGiL7dcQv+1/K+RHM+UT2GNByWZpw7IR54zUyWx48qoO
         hCjOH69h5XXdXc7xwSJXeAOqf0lorpquuX9iq3JxPi4e/RJj9scmB3lSJCiJxvGIU+kY
         qRws17/Zz24KGgpJO4dk8ytzOGy07+uIetjjxrnytX2Kca4RMi4xp3dq2fzy8JYgpqdS
         UhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=doFvFj1oTq6hWI6vYNVk0g+5+he2D0gYp5MuwT4J4cE=;
        b=RRVpM7Iu1Xk0Py13umOoVE05vQ+djEFoi+e/M+cMedEC9SWz/z33HbkVBupIQVDPHA
         qXrLRmNbvxJk6rzqXsGXH1CgBzuutrHM1IssZR2fSvOQ7hqAidJ5FG+bvmZWHGkRwfth
         7ZyOrpqXgNBzGTGuyJxwKLMhavxbO0HYhyn2qIilGzC+nJVTLhpXs1lX83XtTGiDs06n
         pjDg8nW+bgLHA81PfrTB3jmbs7WzVSujNdnDQdos9zvROQzseUSWTu/qIkdxcCgsy8Vr
         hCGrZOknd6MTm72Zza54teDC4Vk9VD67N+TjRbFvKRNdL5/QyAVXHSl4WBxEjCDyrLe5
         YZhA==
X-Gm-Message-State: APf1xPBCBhgB5RVB1Hba82pxHxWMRTq7r/xW/t/oF0dQ4DGWnipmG1x1
        uYTEcMPNOvo/ZWJKLP5yZ4NtYbqo51s=
X-Google-Smtp-Source: AH8x224iWgCTZiii7CKAItyHfTpLOGqtHxcYjLjeiqkYGif1EsBeyz5pi5tWO8OwiMMi5t+YrHKlPg==
X-Received: by 10.98.133.93 with SMTP id u90mr502286pfd.134.1517874947736;
        Mon, 05 Feb 2018 15:55:47 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id p1sm15782241pgr.44.2018.02.05.15.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:55:47 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 011/194] sha1_file: add repository argument to open_sha1_file
Date:   Mon,  5 Feb 2018 15:52:05 -0800
Message-Id: <20180205235508.216277-12-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235508.216277-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
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
index 6abdb8c488..9fa7243907 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -900,7 +900,9 @@ static int stat_sha1_file_the_repository(const unsigned char *sha1,
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
@@ -939,7 +941,7 @@ static void *map_sha1_file_1(const char *path,
 	if (path)
 		fd = git_open(path);
 	else
-		fd = open_sha1_file(sha1, &path);
+		fd = open_sha1_file(the_repository, sha1, &path);
 	map = NULL;
 	if (fd >= 0) {
 		struct stat st;
-- 
2.15.1.433.g936d1b9894.dirty

