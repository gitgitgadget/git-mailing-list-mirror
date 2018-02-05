Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0508F1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeBFAHd (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:07:33 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34016 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752380AbeBFAH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:07:29 -0500
Received: by mail-pl0-f66.google.com with SMTP id q17so113405pll.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uT4s7ZWWsSvEOI9KQwBnfI1/UZ9mp8xsaNz3x18gvTU=;
        b=dj/rgOkirTP17nEbNnyPW3EQMJuJ8j+Y7yxPrX0mqyyBvHUUcujw3ARA+W1m+lhBMm
         /RE0hcYrOLtD9czJT9UCl3kd2i/IBpop3u0IKxqTTZXJcQz8yrY7kB0nDH7hZGVUphwk
         jZKkH7kT1/sjTzs7PlE+j708adeZ5Fi/6U7rGtsJRTvcxjjtu5Gj/OB/f9SednzZb68k
         5oxt1xLfPIwveU+hUtcH70DYvgRiyMqlfKuu9ZSDoj6BUcU8K1riE5VwftZKMj9kAT6o
         YJ3/wNkmDJuCDNvwb35/5Jr+TeuueA3f0PpiNEeaAlWcdj+HERLL8QQ0X5XX2dTWbLgd
         VRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uT4s7ZWWsSvEOI9KQwBnfI1/UZ9mp8xsaNz3x18gvTU=;
        b=RKJzDhsZd6LdnfWwbUCoiSKJZZo+vAgMv3LWfNGcQ8NlJwats/TOH63jo1v6ZmfL9z
         PIFa/C78eALlf4rIWDAJNQutx53yuMZ7dJs1y+N/WjGn1PqMHbPNijYckecvyeBD4kOY
         +Ruo8oxg9y+XwK9iaYRvyZDMERMIFUSEh+5aN58lmDQshqU9w5Ttm7sbWuZCG+IOobsK
         EXqfnNSJJ4ImuW1il7/cVRVlAY29xkGu45bqa2XOPw8/whn/1vWnFL9oBCva9BSBJYP/
         BXx6+PyVZwqkmYlQoEr4HSKinxIfSA68QvladlPACvcTBxElyUCYhe8HgLjMyDLVqYZ4
         PMtw==
X-Gm-Message-State: APf1xPDIxqqugB+Ua/lp9ZIP4HMSS1CGLWCP954Q4g8DepRjwBbVIkxn
        X+/c3CeBWOxpVP0NyasUtfE/29Akolw=
X-Google-Smtp-Source: AH8x2274i6m6TCWQvFTXASkf3l2Brv/tJB5+SOieMNzxB+2YMKuk9Um9+H9IqskLzUlzjHg2GR3bGA==
X-Received: by 2002:a17:902:8498:: with SMTP id c24-v6mr515070plo.450.1517875647914;
        Mon, 05 Feb 2018 16:07:27 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id a3sm7133891pgw.23.2018.02.05.16.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:07:27 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 063/194] replace-object: add repository argument to lookup_replace_object
Date:   Mon,  5 Feb 2018 15:55:24 -0800
Message-Id: <20180205235735.216710-43-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow callers of lookup_replace_object
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/mktag.c  | 2 +-
 object.c         | 2 +-
 replace-object.h | 3 ++-
 sha1_file.c      | 6 +++---
 streaming.c      | 2 +-
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index 93934e8e4b..ab41735f2a 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -26,7 +26,7 @@ static int verify_object(const unsigned char *sha1, const char *expected_type)
 	enum object_type type;
 	unsigned long size;
 	void *buffer = read_sha1_file(sha1, &type, &size);
-	const unsigned char *repl = lookup_replace_object(sha1);
+	const unsigned char *repl = lookup_replace_object(the_repository, sha1);
 
 	if (buffer) {
 		if (type == type_from_string(expected_type))
diff --git a/object.c b/object.c
index fc0ccbefef..a5cafb10e7 100644
--- a/object.c
+++ b/object.c
@@ -246,7 +246,7 @@ struct object *parse_object(const struct object_id *oid)
 	unsigned long size;
 	enum object_type type;
 	int eaten;
-	const unsigned char *repl = lookup_replace_object(oid->hash);
+	const unsigned char *repl = lookup_replace_object(the_repository, oid->hash);
 	void *buffer;
 	struct object *obj;
 
diff --git a/replace-object.h b/replace-object.h
index 67a433d5a5..c61ee66e95 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -21,7 +21,8 @@ extern const unsigned char *do_lookup_replace_object(struct repository *r, const
  * either sha1 or a pointer to a permanently-allocated value.  When
  * object replacement is suppressed, always return sha1.
  */
-static inline const unsigned char *lookup_replace_object(const unsigned char *sha1)
+#define lookup_replace_object(r, s) lookup_replace_object_##r(s)
+static inline const unsigned char *lookup_replace_object_the_repository(const unsigned char *sha1)
 {
 	if (!check_replace_refs ||
 	    (the_repository->objects.replacements.prepared &&
diff --git a/sha1_file.c b/sha1_file.c
index 8ee86f8ede..a6df4b61c7 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1243,7 +1243,7 @@ int sha1_object_info_extended_the_repository(const unsigned char *sha1, struct o
 	struct pack_entry e;
 	int rtype;
 	const unsigned char *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
-				    lookup_replace_object(sha1) :
+				    lookup_replace_object(the_repository, sha1) :
 				    sha1;
 
 	if (is_null_sha1(real))
@@ -1369,8 +1369,8 @@ void *read_sha1_file_extended(const unsigned char *sha1,
 	const struct packed_git *p;
 	const char *path;
 	struct stat st;
-	const unsigned char *repl = lookup_replace ? lookup_replace_object(sha1)
-						   : sha1;
+	const unsigned char *repl = lookup_replace ?
+		lookup_replace_object(the_repository, sha1) : sha1;
 
 	errno = 0;
 	data = read_object(repl, type, size);
diff --git a/streaming.c b/streaming.c
index c47600e719..bc3c4811ca 100644
--- a/streaming.c
+++ b/streaming.c
@@ -140,7 +140,7 @@ struct git_istream *open_istream(const unsigned char *sha1,
 {
 	struct git_istream *st;
 	struct object_info oi = OBJECT_INFO_INIT;
-	const unsigned char *real = lookup_replace_object(sha1);
+	const unsigned char *real = lookup_replace_object(the_repository, sha1);
 	enum input_source src = istream_source(real, type, &oi);
 
 	if (src < 0)
-- 
2.15.1.433.g936d1b9894.dirty

