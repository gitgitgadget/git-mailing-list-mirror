Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E84671F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751089AbeBEX4h (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:56:37 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46689 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbeBEX4C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:56:02 -0500
Received: by mail-pg0-f68.google.com with SMTP id s9so96115pgq.13
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I6/n3A8XP5EXngTvt73R7IdNLfQdzxpKffgz/ynEQPo=;
        b=uPWkLTz3+4bgcvI9xwujSaXfQAgNakh23OLkZ9V7bbWT0lSxxzlQ/5GzdeZXZ2B5d6
         28haOHg7TlZSxaQ4jQd7B9U4oD1XWU1jflIlRjJvv+ou9AFK0k5YBK0STbtJmT+6MDI0
         mFamrukECoaaS+fVd/z5yHCJqQBAE32k7r+kJMqP0leUPjxZE6105obphbI8NzC6Nldl
         3+luwQQ1TD6yoyTIx17d9QJY2CYp+hSxkUagaAXDp1VXGjrcfAOpyfsO3sw6lwQA3b9Q
         XIB67XC0XMszekU60aNMuk0neO4/s4LZqch1w6Js2C0ygXUc2UfNXxWJm3I5er91UH6p
         GNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I6/n3A8XP5EXngTvt73R7IdNLfQdzxpKffgz/ynEQPo=;
        b=CdrjpCZ+KsNoEc8a7pUNv09vGLS01fufARa/1xUSXYw8v/9ucxBdV6edXcCnbM+/XZ
         /zkoQJ7oY+4PrjryqVPlQ4sIgckV5WbbQ8SZYlT0JZ2XY782HIk97D3QGt8mzLQQ/CwL
         fWL6kdlSefUAjKLJdy5IfyJihmo0sKjS/Lx6KI2BmK4lEDS5Bq8paIMk2Zt5f2q3BPkx
         cFd53xDtwgcPxpXJvAF7r81P+wOba9ItkIrjdMhZF31nESeY2uNr9iM9JCSc91oKLyOx
         e0ClPUXL7h3Y4GNuB2hjToA5xucrvAobYbygpF/YAC9/YlbbMSjowRnl9Ip59Dc48ctE
         vJeg==
X-Gm-Message-State: APf1xPD8gx7/XaQrQvg4K6eR5fc+xoRqnWoUAKSCg7TczX1zUh2nzqFl
        XChgSChU9GNRojk9ejlr5dgmFIwV9t0=
X-Google-Smtp-Source: AH8x224OTsfnC3V6FM1KINr0iwW98HJ8uFFP5OIp3fVpUB5vCqah6K6gDQN7y4lfh0xMq6L53K2D0w==
X-Received: by 10.99.116.9 with SMTP id p9mr378142pgc.437.1517874961866;
        Mon, 05 Feb 2018 15:56:01 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id w12sm17862776pfd.86.2018.02.05.15.56.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:56:01 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 021/194] pack: add repository argument to reprepare_packed_git
Date:   Mon,  5 Feb 2018 15:52:15 -0800
Message-Id: <20180205235508.216277-22-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235508.216277-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow reprepare_packed_git_mru callers to
be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

Callers adapted using contrib/coccinelle/packed_git.cocci.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/gc.c                        | 2 +-
 builtin/receive-pack.c              | 3 ++-
 bulk-checkin.c                      | 3 ++-
 contrib/coccinelle/packed_git.cocci | 4 ++++
 fetch-pack.c                        | 3 ++-
 packfile.c                          | 2 +-
 packfile.h                          | 3 ++-
 sha1_file.c                         | 2 +-
 8 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 00a3b402a8..a3a4d4d4f3 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -475,7 +475,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		return error(FAILED_RUN, rerere.argv[0]);
 
 	report_garbage = report_pack_garbage;
-	reprepare_packed_git();
+	reprepare_packed_git(the_repository);
 	if (pack_garbage.nr > 0)
 		clean_pack_garbage();
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index b2eac79a6e..744fe29366 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "repository.h"
 #include "config.h"
 #include "lockfile.h"
 #include "pack.h"
@@ -1778,7 +1779,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		status = finish_command(&child);
 		if (status)
 			return "index-pack abnormal exit";
-		reprepare_packed_git();
+		reprepare_packed_git(the_repository);
 	}
 	return NULL;
 }
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 3310fd210a..eadc2d5172 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -3,6 +3,7 @@
  */
 #include "cache.h"
 #include "bulk-checkin.h"
+#include "repository.h"
 #include "csum-file.h"
 #include "pack.h"
 #include "strbuf.h"
@@ -57,7 +58,7 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 
 	strbuf_release(&packname);
 	/* Make objects we just wrote available to ourselves */
-	reprepare_packed_git();
+	reprepare_packed_git(the_repository);
 }
 
 static int already_written(struct bulk_checkin_state *state, unsigned char sha1[])
diff --git a/contrib/coccinelle/packed_git.cocci b/contrib/coccinelle/packed_git.cocci
index 7554f4773c..0cb0e95f82 100644
--- a/contrib/coccinelle/packed_git.cocci
+++ b/contrib/coccinelle/packed_git.cocci
@@ -9,3 +9,7 @@
 @@ @@
 - prepare_packed_git()
 + prepare_packed_git(the_repository)
+
+@@ @@
+- reprepare_packed_git()
++ reprepare_packed_git(the_repository)
diff --git a/fetch-pack.c b/fetch-pack.c
index 9f6b07ad91..9c189ff3ec 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "repository.h"
 #include "config.h"
 #include "lockfile.h"
 #include "refs.h"
@@ -1169,7 +1170,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 	prepare_shallow_info(&si, shallow);
 	ref_cpy = do_fetch_pack(args, fd, ref, sought, nr_sought,
 				&si, pack_lockfile);
-	reprepare_packed_git();
+	reprepare_packed_git(the_repository);
 	update_shallow(args, sought, nr_sought, &si);
 	clear_shallow_info(&si);
 	return ref_cpy;
diff --git a/packfile.c b/packfile.c
index bf7e6d22ce..6a1c8107ed 100644
--- a/packfile.c
+++ b/packfile.c
@@ -890,7 +890,7 @@ void prepare_packed_git_the_repository(void)
 	the_repository->objects.packed_git_initialized = 1;
 }
 
-void reprepare_packed_git(void)
+void reprepare_packed_git_the_repository(void)
 {
 	the_repository->objects.approximate_object_count_valid = 0;
 	the_repository->objects.packed_git_initialized = 0;
diff --git a/packfile.h b/packfile.h
index e543a98b23..74f293c439 100644
--- a/packfile.h
+++ b/packfile.h
@@ -34,7 +34,8 @@ extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
 #define prepare_packed_git(r) prepare_packed_git_##r()
 extern void prepare_packed_git_the_repository(void);
-extern void reprepare_packed_git(void);
+#define reprepare_packed_git(r) reprepare_packed_git_##r()
+extern void reprepare_packed_git_the_repository(void);
 #define install_packed_git(r, p) install_packed_git_##r(p)
 extern void install_packed_git_the_repository(struct packed_git *pack);
 
diff --git a/sha1_file.c b/sha1_file.c
index 7662692ee5..f6e982880e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1276,7 +1276,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		if (flags & OBJECT_INFO_QUICK) {
 			return -1;
 		} else {
-			reprepare_packed_git();
+			reprepare_packed_git(the_repository);
 			if (!find_pack_entry(real, &e))
 				return -1;
 		}
-- 
2.15.1.433.g936d1b9894.dirty

