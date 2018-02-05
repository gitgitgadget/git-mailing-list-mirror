Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C62741F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeBFAB2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:01:28 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39971 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBFAB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:01:26 -0500
Received: by mail-pg0-f66.google.com with SMTP id g2so121739pgn.7
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jXIalC6Qw/O/PUvTjDRWPGZKv+PhZdqYt81bf05pk0Q=;
        b=COK4wLc7FN0HgVMQOVVPlP0CkY421BNhN+MkTmhwtiB/R4X4igonPoCEFNHdhSU0P6
         X/Lbs84sIxClLtqYBjmXmUDIQXi/N9DFZnICYB8nJ6j1BrsM4PIObiu7Tbd2pC3+OQn1
         VCsE8ihJntIg+/KfemSjhw75YJfqd0QpJPj2DFQrZlHeM4tTXxNUOeum0xChi3YzA2OL
         +UlHV0228zRstfVOdC15UZtavukEzFfa4gD9SVmnnwN+5t6UiSBWBsSBQdYIX8SQzyPy
         2MyC+aShVMdqVYT6NozZK8mlz/F8oa8Pe1T+5QPIE0LdXfvhdIkaiyEgtwjDtOJmdlPq
         /oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jXIalC6Qw/O/PUvTjDRWPGZKv+PhZdqYt81bf05pk0Q=;
        b=aEBzwmEYIh9brosIH6l3ddHFQnnrhPe5QaCMtzsSqRqDDxPle9Ff4rqSsSRP5Ayv09
         p4+oChXptHEWV9KFI88qxXPOfnjsejow5IhGH86OGdhlb9xEIGIF6Pm3J6a17EpZ9MUN
         yXgslWdNTEdE9q8qd9yDQsnIYKeKwnRtq92S8klNp8gWlADPXKg9XbCOMao69UY+3aDq
         bprRhQacML27Ku6QqiyP1mRaLNVvYURbPxbQaWhmSJHGjHKEVgOgoGKqSjnmMNPuvAvI
         KgrE++vv+rAOSBZ2nHk3XYvWbnk4H7hWH4CAXsHIQL33CNIWRghtG9cnQNs2T1g0djBr
         grqg==
X-Gm-Message-State: APf1xPC7J4cODvagBDc+CZHjiuCofMaOz1CnJVsZIuD8v9nXWN13KdCD
        cHx88I0mcowzsuaWlGs+OZLT+KUMzrQ=
X-Google-Smtp-Source: AH8x227Veoz6fYpG0Z7kMESutUHkV6M0Cogx8QElYes3RLoBYxk3WqPYBslUOZNXAc+JWdtkRQrG6Q==
X-Received: by 10.101.64.74 with SMTP id h10mr394959pgp.200.1517875285993;
        Mon, 05 Feb 2018 16:01:25 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id d4sm14379382pgc.58.2018.02.05.16.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:01:25 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 037/194] pack: allow map_sha1_file to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 15:54:58 -0800
Message-Id: <20180205235735.216710-17-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 object-store.h | 3 +--
 sha1_file.c    | 5 +++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/object-store.h b/object-store.h
index fe2187fd65..57b8d89738 100644
--- a/object-store.h
+++ b/object-store.h
@@ -61,8 +61,7 @@ struct packed_git {
  * is overwritten each time the function is called.
  */
 extern const char *sha1_file_name(struct repository *r, const unsigned char *sha1);
-#define map_sha1_file(r, s, sz) map_sha1_file_##r(s, sz)
-extern void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size);
+extern void *map_sha1_file(struct repository *r, const unsigned char *sha1, unsigned long *size);
 
 extern void prepare_alt_odb(struct repository *r);
 
diff --git a/sha1_file.c b/sha1_file.c
index 590b857391..786e904eab 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -964,9 +964,10 @@ static void *map_sha1_file_1(struct repository *r, const char *path,
 	return map;
 }
 
-void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size)
+void *map_sha1_file(struct repository *r,
+		    const unsigned char *sha1, unsigned long *size)
 {
-	return map_sha1_file_1(the_repository, NULL, sha1, size);
+	return map_sha1_file_1(r, NULL, sha1, size);
 }
 
 static int unpack_sha1_short_header(git_zstream *stream,
-- 
2.15.1.433.g936d1b9894.dirty

