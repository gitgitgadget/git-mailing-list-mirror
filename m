Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0633F1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750999AbeBEX5p (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:57:45 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42201 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeBEX5o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:57:44 -0500
Received: by mail-pg0-f68.google.com with SMTP id m28so108785pgc.9
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I6/n3A8XP5EXngTvt73R7IdNLfQdzxpKffgz/ynEQPo=;
        b=bNU/A82I75vlVkRVFWZDcz+ZKdWOB6cYSAf25Uh+4y/zgv+JCndtGFerLmTCRnqnH8
         dcIrDQE4lvbAenbT1P6ZE5BctjEuAcWinQDmHxBcyYf0IkJCjLZBXeoc3ca9QzpivLP6
         RHeekTk7XD2OrwEzsDXbrIaDCV6OWdTwGyT8h2o5s/PMUUiC15w3YvwG4FXhydpi7vrR
         pWQs3scDkUf2xJSfnpCUkTQxsRryZk9qo2Wag50iHvS/DRI4xIXhTpXvjkHJa19cdhOP
         laNn9ihJTAHOBi3NA9r2TcVAEW9KKvqRi8h9yf1KJrkgb3/omY4ckE3s0azvtDrdu1wp
         /KcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I6/n3A8XP5EXngTvt73R7IdNLfQdzxpKffgz/ynEQPo=;
        b=qHM2HHr96kIBGVGttplhI4gZUPmbGQcGB+4qjDnxsiE3iveedAzAYNdZDI4IbRB3n6
         Os5YADfeGXFvesgF5lAaeBYGeFHXDXSmbXP4GmVNkwzFU0JXRpCPVqQn1Pwu3j1p1CzI
         witw8xr4PhePjvMciDWrs421UGj+UEtj4fWyk3Sk5VHB674l4/qPYXr2uNa/z+Uv8C+e
         4Y4FJYtRa6F/9hvuaetZaAFcGuo95rEK2+dP8BIGT3LCBnkYLEnmESPB6+t5BulzcmAL
         krknkEULn2uwgtRTZ5kcc8lbrnoBdobcPxYoz3XxpDKcdJxTe1z6Re/Gt68q7HXidoSU
         KJpA==
X-Gm-Message-State: APf1xPCDsOx7vIFhNrz4D+vvezf2MP+ed3/QPUJ0NzIa6YCrtUBDGo4+
        F5iLn4Csk61JKE2QTKMywbdGpamNMXw=
X-Google-Smtp-Source: AH8x226d3pPINbY46jp58N2nZ/I47nbgZdUAHeUCSKiQR1Dtt8nwJFGX239IlHxUB1PkLxunB30BIA==
X-Received: by 10.99.97.193 with SMTP id v184mr365313pgb.387.1517875063125;
        Mon, 05 Feb 2018 15:57:43 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id s5sm19809772pfg.29.2018.02.05.15.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:57:42 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 021/194] pack: add repository argument to reprepare_packed_git
Date:   Mon,  5 Feb 2018 15:54:42 -0800
Message-Id: <20180205235735.216710-1-sbeller@google.com>
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

