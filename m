Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAE591F404
	for <e@80x24.org>; Mon,  9 Apr 2018 22:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbeDIWqV (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 18:46:21 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36283 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751902AbeDIWpy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 18:45:54 -0400
Received: by mail-pl0-f65.google.com with SMTP id 91-v6so6108816pld.3
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 15:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ygDIhx/jc6TeABGPnbccuN0d1C3BPsRInrjjaXK4a1Y=;
        b=drA9aL4lTvmsE4eJKz2gEIM/OR0sg+/xjqmDbsrTUOahwSISkirkGcJXY6CTixacV5
         OFjYRnVLqunH1DT0KWJZ6k417bywAD58pUxMLm4f0/PtLhXYm/zSdx0dqi/8ZSxqC7+2
         8UuD7+2tu7R3tj07DyKnpLUrzF8Ax9tkO+/DwCYwuHM4bdrNucNJ3rOfhs+jvNsL7O/X
         FhrlSOD2an9ay4KTXfpv0f6bofVSF3NwHAI3jxBToNm3V37D6HxfLwxyJ56hOWDq5qmm
         wWuvm5tpuNzpxfRbLUgo1gkUtbzSSu2GAxV9Vbwm0h6PuHKngbEXdLNc44PevCQu4XOQ
         TjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ygDIhx/jc6TeABGPnbccuN0d1C3BPsRInrjjaXK4a1Y=;
        b=N/ALtG9pQ3gsr/4rxUsrnBcP/f1DVFT01rU4aOuom4xeTkD5psZ/LEH2EQ4GAuhRAa
         w+PC9KbLw5yRVQ8cIdlfWI7xB9FdLEODEpEwK4A4LCqRmUeNEreEE6VDz60/yS6Nykt6
         IAEv9aexThn2XsNx5/1fCR76h81QOtTeWQfrs5fcn23VNDTJTV3wBthcnT+Z8oWNsGzV
         7UbOd3TgDhmL3igs9JvWdjfFTBqqG6q6gt5rEe4pXQhmufS0fbgQ9FmwEk9Fv4m7G4Xj
         F9LVMPjqLbECUcdJ8Juji1bR+YgrQK7C1VsPIMr/hyZFr2TBhMJBu6CkD8cXfOuTkDvm
         QCzg==
X-Gm-Message-State: AElRT7GXJOaBobxLNTzJIigfXFSqksOQ+0Dry5Xl968yY/qV+GSagwxH
        dcwTpJ4fkEYNuemYVSHCTJ4v4g==
X-Google-Smtp-Source: AIpwx49h/L1ZHy58wopfqWXzrR3CX8vo0mRKzHQqeJj1LJcS/tLaVqBGAbMg1A6OGOa798jHMLfnlQ==
X-Received: by 2002:a17:902:6b8b:: with SMTP id p11-v6mr40911397plk.213.1523313953618;
        Mon, 09 Apr 2018 15:45:53 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id a65sm2557371pfg.170.2018.04.09.15.45.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 15:45:53 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        sunshine@sunshineco.com, pclouds@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net, Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/16] replace-object: add repository argument to lookup_replace_object
Date:   Mon,  9 Apr 2018 15:45:28 -0700
Message-Id: <20180409224533.17764-12-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180409224533.17764-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
 <20180409224533.17764-1-sbeller@google.com>
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
index e3d20a7722..82a6e86077 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -25,7 +25,7 @@ static int verify_object(const struct object_id *oid, const char *expected_type)
 	enum object_type type;
 	unsigned long size;
 	void *buffer = read_object_file(oid, &type, &size);
-	const struct object_id *repl = lookup_replace_object(oid);
+	const struct object_id *repl = lookup_replace_object(the_repository, oid);
 
 	if (buffer) {
 		if (type == type_from_string(expected_type))
diff --git a/object.c b/object.c
index 998ec2a25f..66cffaf6e5 100644
--- a/object.c
+++ b/object.c
@@ -247,7 +247,7 @@ struct object *parse_object(const struct object_id *oid)
 	unsigned long size;
 	enum object_type type;
 	int eaten;
-	const struct object_id *repl = lookup_replace_object(oid);
+	const struct object_id *repl = lookup_replace_object(the_repository, oid);
 	void *buffer;
 	struct object *obj;
 
diff --git a/replace-object.h b/replace-object.h
index ddeb0470bd..dff57bfa1e 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -23,7 +23,8 @@ extern const struct object_id *do_lookup_replace_object_the_repository(const str
  * either sha1 or a pointer to a permanently-allocated value.  When
  * object replacement is suppressed, always return sha1.
  */
-static inline const struct object_id *lookup_replace_object(const struct object_id *oid)
+#define lookup_replace_object(r, s) lookup_replace_object_##r(s)
+static inline const struct object_id *lookup_replace_object_the_repository(const struct object_id *oid)
 {
 	if (!check_replace_refs ||
 	    (the_repository->objects->replace_map &&
diff --git a/sha1_file.c b/sha1_file.c
index c38e41e49e..028a4357c5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1240,7 +1240,7 @@ int oid_object_info_extended(const struct object_id *oid, struct object_info *oi
 	int already_retried = 0;
 
 	if (flags & OBJECT_INFO_LOOKUP_REPLACE)
-		real = lookup_replace_object(oid);
+		real = lookup_replace_object(the_repository, oid);
 
 	if (is_null_oid(real))
 		return -1;
@@ -1379,8 +1379,8 @@ void *read_object_file_extended(const struct object_id *oid,
 	const struct packed_git *p;
 	const char *path;
 	struct stat st;
-	const struct object_id *repl = lookup_replace ? lookup_replace_object(oid)
-						      : oid;
+	const struct object_id *repl = lookup_replace ?
+		lookup_replace_object(the_repository, oid) : oid;
 
 	errno = 0;
 	data = read_object(repl->hash, type, size);
diff --git a/streaming.c b/streaming.c
index a6e1162946..cce7b17ea7 100644
--- a/streaming.c
+++ b/streaming.c
@@ -140,7 +140,7 @@ struct git_istream *open_istream(const struct object_id *oid,
 {
 	struct git_istream *st;
 	struct object_info oi = OBJECT_INFO_INIT;
-	const struct object_id *real = lookup_replace_object(oid);
+	const struct object_id *real = lookup_replace_object(the_repository, oid);
 	enum input_source src = istream_source(real, type, &oi);
 
 	if (src < 0)
-- 
2.17.0.484.g0c8726318c-goog

