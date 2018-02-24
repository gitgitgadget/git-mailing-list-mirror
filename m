Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A08FC1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeBXAs1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:48:27 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46706 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752606AbeBXAsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:48:25 -0500
Received: by mail-pg0-f66.google.com with SMTP id m1so3975211pgp.13
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kKHqldAtIsUAkvbn+CJAHsKWpsXY28SfMQfJIrRHPms=;
        b=eT/sgyeWwFXlgcSCoArEgwd6ytOpl2UpbubNUz8hj1NAI5wbJcaqsKe9/QNTTGgboh
         Dp+rwo3euyLjom36VR+OWvY0HxJwca+Ya1NNal3XCDLMEZ8h/cKW10QIHMWOQQJlLajE
         5/Ix7tryZK/n0E64g/Jt3/Lg2mdKuRPqC3LAh3EuUqKu9mG7nyyRHg4ZccuwhjRSy/uV
         g061sE5gRuLfnJfLqx50wIwMdkmPGoifIg8NFpDezfc3ws61OvnG5KtyZjhQabj3oAi/
         6I45EAZaNVwizjuGnfqVGLwdsTEl0jP7LBg0HOZ5YqLsEGnPzBFFe86RV7UUbL9hVvIF
         nYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kKHqldAtIsUAkvbn+CJAHsKWpsXY28SfMQfJIrRHPms=;
        b=M8oTk5dEl0qIK8Yjfjd1BK+n8hgnrp0luKJahlN0wlXQNlQqDxsiLI0AVmaKzEDr1O
         G76nBAZ7zF16NYdmK53BfhkfX8qCwG9uQEycGuKElhgBif+Jn0N9nb9MkGkCM+ho6OWT
         Xyu+T6IsC3stkjUP/2TXdVXHnFLGOi0M/v8kz7fGNQGMClw/mVty9UuYoCAgcF1EW0Vr
         JiOhyv/QsrnIEnG41iHSV2JqK3UnMBmmn+3qfAuhp5asXoRN9nQlwlsCzVlXNpCRN8C9
         1DUaot/cYxb+IO/l7kCLcircChxyiksd055yP12RlaTpNqjCM7yVQv3FyVyDzIHaSt9Y
         Nt8A==
X-Gm-Message-State: APf1xPB/W2Te0utCF8+Ir9WU2jq+xcKdYHXJgXD/g73PMjQe0zJGtusC
        CDmCk6Gt+6FBv8FhyPz9zGBHqdc8Qk8=
X-Google-Smtp-Source: AH8x225ekcXSJ81R8ws8T9GMSTXkTFKXnVonwG3yYyyrTmvdeAuv0JxpQBL0fZE3iloXUQYYUdb+8A==
X-Received: by 10.98.13.24 with SMTP id v24mr3405044pfi.89.1519433304465;
        Fri, 23 Feb 2018 16:48:24 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id m127sm6881749pfc.78.2018.02.23.16.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 16:48:23 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com, bmwill@google.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv4 19/27] sha1_file: add repository argument to map_sha1_file_1
Date:   Fri, 23 Feb 2018 16:47:46 -0800
Message-Id: <20180224004754.129721-20-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180224004754.129721-1-sbeller@google.com>
References: <20180221015430.96054-1-sbeller@google.com>
 <20180224004754.129721-1-sbeller@google.com>
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
index 7e471e0cf4b..d4af8f56814 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -933,9 +933,10 @@ static int open_sha1_file_the_repository(const unsigned char *sha1,
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
@@ -964,7 +965,7 @@ static void *map_sha1_file_1(const char *path,
 
 void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
 {
-	return map_sha1_file_1(NULL, sha1, size);
+	return map_sha1_file_1(the_repository, NULL, sha1, size);
 }
 
 static int unpack_sha1_short_header(git_zstream *stream,
@@ -2200,7 +2201,7 @@ int read_loose_object(const char *path,
 
 	*contents = NULL;
 
-	map = map_sha1_file_1(path, NULL, &mapsize);
+	map = map_sha1_file_1(the_repository, path, NULL, &mapsize);
 	if (!map) {
 		error_errno("unable to mmap %s", path);
 		goto out;
-- 
2.16.1.291.g4437f3f132-goog

