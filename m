Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C8631F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbeBEXzx (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:55:53 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36630 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbeBEXzl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:55:41 -0500
Received: by mail-pg0-f67.google.com with SMTP id x25so118633pge.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6LJ7pbUjQXxXuZnq0FeP8Zbp+8ZpKWNzqmFngN+75qg=;
        b=pt1D10oajBJPZH4glH99s3GHsqVgXJcxfxUbkOv8BppRGzbT1rkNrLT4WCRwgf9Z5N
         sf45JANRyCl3GdjpWZYMeE3m1891ij619UZL0fEZR3qJMgQ1E2cou4gLqsrMoDBIS4km
         Ba34VdjWkGP1XEnqgMPYEjMmm48R2Sm1fFT6hFj9Q2OSy7Av2gLnKUItFXPHZh/4bzt8
         ApnDZUV5RJ6Q2kW/RE0vIADA8+BOI9vcr4G+FkVC5Hh8oY+VgP5qrgibuiBgU9zmeSsV
         VKd5hjjCG9lcGmG6FLXP+y1ex9MKLnzAFbuvU6phsEJPm4thjic7LNU1OyjHw6aHnHvh
         ssBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6LJ7pbUjQXxXuZnq0FeP8Zbp+8ZpKWNzqmFngN+75qg=;
        b=rq9hi2zsTkVS4f0jlSP9SLwmnOQ7xE4oLwME5jE1WWaJa7V8Ppl/6CQVYKdM4rjc+o
         KjP5YAL+4X52VkVr2R9fn7fiQpH8c16iulRmBoT6UeBBWbQ8apBN8/JujuBJ7knKx9vS
         NIkbG8tdcJM+56WG0dr5gFv+zHP+xGEeQOXipkAC1Jk1OpfALoqKagp0P6SkeLqlQjL6
         wrPc8E7OTP211XIhw+3jQV1eEWqVA2PH3C1QhGti9ym/WE7ZhrLTwjulZzUN/UVVPOZ9
         EwmGY9Riy2BNXD1HkIYLFkH2Dr1wwfz81BwtQthM5y/EBM0HBNu23jTzhYMLvCBtg+M+
         QTsw==
X-Gm-Message-State: APf1xPDTU8hkMHG+oYCwR6FfdqNL3XlnrZDo0zrqPXBOj9FWL8dbW9um
        YZ9PllLziIR1a9E3yYyIuh04s4xRX9s=
X-Google-Smtp-Source: AH8x224+ZqSNGDkekPohFWfiW8kzGO7jg9LL0y9/3/Lrx2JxOp/xGflOH360+SrGCGzTvHUN51rjWw==
X-Received: by 10.98.248.1 with SMTP id d1mr484911pfh.222.1517874940784;
        Mon, 05 Feb 2018 15:55:40 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id k3sm15746762pff.41.2018.02.05.15.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:55:40 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 006/194] sha1_file: add repository argument to alt_odb_usable
Date:   Mon,  5 Feb 2018 15:52:00 -0800
Message-Id: <20180205235508.216277-7-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235508.216277-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the alt_odb_usable caller to be
more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

Since the implementation does not yet work with other repositories,
use a wrapper macro to enforce that the caller passes in
the_repository as the first argument. It would be more appealing to
use BUILD_ASSERT_OR_ZERO to enforce this, but that doesn't work
because it requires a compile-time constant and common compilers like
gcc 4.8.4 do not consider "r == the_repository" a compile-time
constant.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 2826d5d6ed..ca002a272d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -350,7 +350,9 @@ static const char *alt_sha1_path(struct alternate_object_database *alt,
 /*
  * Return non-zero iff the path is usable as an alternate object database.
  */
-static int alt_odb_usable(struct strbuf *path, const char *normalized_objdir)
+#define alt_odb_usable(r, p, n) alt_odb_usable_##r(p, n)
+static int alt_odb_usable_the_repository(struct strbuf *path,
+					 const char *normalized_objdir)
 {
 	struct alternate_object_database *alt;
 
@@ -418,7 +420,7 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
 		strbuf_setlen(&pathbuf, pathbuf.len - 1);
 
-	if (!alt_odb_usable(&pathbuf, normalized_objdir)) {
+	if (!alt_odb_usable(the_repository, &pathbuf, normalized_objdir)) {
 		strbuf_release(&pathbuf);
 		return -1;
 	}
-- 
2.15.1.433.g936d1b9894.dirty

