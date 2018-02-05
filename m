Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AD6D1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeBFAMJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:12:09 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46501 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752126AbeBFAMH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:12:07 -0500
Received: by mail-pl0-f66.google.com with SMTP id 36so98610ple.13
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2xV2QtJxT/fp+L3Eu9ekk66NGk6KcZfm4UUFqV0kOIU=;
        b=CCcuwoS3tOu/0i+E1LOb7Vxqm55dpQb4yg07d1mlK58NFELMbcs5ne94gXhxwaCHLn
         UmJc+gV30xwe4y6Fl1UX5hl2g4J/Ui++JmN/cpqm0rRhCJyKLvLQnmGPkGnzMKklcVqN
         J2124YQJcZVLTDt4Q9MX5TvjgiMeQYA4NPOpe+Hb1ObRv968llL/ved6JVg3ObIUJIl7
         sLHSvFd5VpQk3YE3Samt2Gyizj4q4yuWK86Ui7I+pBJ/ihe+TTjPJz/Fa0I7W/3evotB
         7KYeC5WrvkhsbEPg5R7aNBCXNFOs3X3mNEJUC3WJOKNnWE4C+la50duYnEF+ycEzBhPU
         7Hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2xV2QtJxT/fp+L3Eu9ekk66NGk6KcZfm4UUFqV0kOIU=;
        b=rxcEiAr52KMNNeDABAaaXVWrKYvwBGujm41rJjrwlnVP29zzQeMkf5qnehX+HSzssv
         r/JdXRJeem5ZQHcVKm/ckFiFh7f4lsLezVl+cSIFVCRc/lZDtKXvfIHcoK/fnF2qDy80
         Apd/ajTkRqYwOOLmLMaZjZ7T/RXfj1ReFPls4lLU8d+Xgkb4sKwfxXBdZYASMcK/eycj
         HyP4oM0/guwxbgQDkvxXhXIk3ka5pd7UDh7i4p1+UF85u2tsRaGjUtR1wsydnszDXPSD
         3soLijD2CUsRddkTHZO7xl1Rw7JBVpCCobDVMzD8hcOYaPY3NewtfeWbbQBln1oHzSMk
         wFBQ==
X-Gm-Message-State: APf1xPCbNxFjE+B5xOuNI7kHT1FD5p2x0tsrHII9JZFIhSxB6lSwTEo/
        1t18cjmPrW6r+LRXWQb87VRA0y7zSYw=
X-Google-Smtp-Source: AH8x226fuVdIPjpWoU6vqFTkFclTmYEzCRp2CtGD1Gm91zecC6G3aDu8ZMKGzJT+972vCEqY0JP+ew==
X-Received: by 2002:a17:902:9683:: with SMTP id n3-v6mr504542plp.177.1517875926670;
        Mon, 05 Feb 2018 16:12:06 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id y16sm6699196pfl.155.2018.02.05.16.12.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:12:06 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 083/194] object: add repository argument to grow_object_hash
Date:   Mon,  5 Feb 2018 15:55:44 -0800
Message-Id: <20180205235735.216710-63-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow the caller of grow_object_hash to
be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/object.c b/object.c
index 681fa40eb1..225679188b 100644
--- a/object.c
+++ b/object.c
@@ -115,7 +115,8 @@ struct object *lookup_object_the_repository(const unsigned char *sha1)
  * power of 2 (but at least 32).  Copy the existing values to the new
  * hash map.
  */
-static void grow_object_hash(void)
+#define grow_object_hash(r) grow_object_hash_##r()
+static void grow_object_hash_the_repository(void)
 {
 	int i;
 	/*
@@ -146,7 +147,7 @@ void *create_object_the_repository(const unsigned char *sha1, void *o)
 	hashcpy(obj->oid.hash, sha1);
 
 	if (the_repository->parsed_objects.obj_hash_size - 1 <= the_repository->parsed_objects.nr_objs * 2)
-		grow_object_hash();
+		grow_object_hash(the_repository);
 
 	insert_obj_hash(obj, the_repository->parsed_objects.obj_hash,
 			the_repository->parsed_objects.obj_hash_size);
-- 
2.15.1.433.g936d1b9894.dirty

