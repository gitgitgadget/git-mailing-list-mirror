Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF8D61F404
	for <e@80x24.org>; Wed, 28 Feb 2018 01:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeB1BGc (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 20:06:32 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43928 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751856AbeB1BGX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 20:06:23 -0500
Received: by mail-pg0-f65.google.com with SMTP id e9so310945pgs.10
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 17:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FUS/mxoMx5xvmHPjCUQzFV2CbbdtDykwzPD2fUJkus4=;
        b=J8Zx1qUjLCVkPwqipwnKEhNr9JXRGqa85NVvTHJS9u+ZwlLxQn34vZ0Gm+shOJWCs/
         WCfzs/CrsZsZBjhkeqmWu+jOKGUhPyodWwWd/nk7UQsktLvWYTQem9Gn+oP+lu3pglHN
         K1lpdPT1L86kN89O75u4qTCyMtgAabPv6wCbquAbWzDIvsNdJW3xAmrI+FvtEo5MAQzV
         huShXfRP//3B7uCeZ6kQcKQfY+sJf3IHZqrPCOhHCcapxW+FiZ9p6o721RXtE1kMp7il
         89QIQK4WjLfOV0efRE2J2rckgCnZQDBBEs0BVAVG+uRvMrDF4TuOmOknFbhRBt2fTWHA
         RJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FUS/mxoMx5xvmHPjCUQzFV2CbbdtDykwzPD2fUJkus4=;
        b=T0B7weF8+w5uEWu8VBledh4tvHIZEUD9MpHTzyXasWO0Lq3rXKOjLNH9U8SmVs+tbZ
         jZs2WAqNFcmkRpS5NFCNLyLbGrKeEyeKBAoPtg0OVny9Bumj4CfxF7JQc3+fUHH3hCQB
         cfju6QKgugrNsyY3vkgwb4wBXiEDOmSnl0/aNIqjGqNXNzz5ak+woBAT0lK212aAklcZ
         5UNdmLG8uFvmxMJrAGAoT+W5/O6ZyEz6FPi2juKOBA9X/JJdOzHBbhc91G7OfEv3swfM
         5EPFXfBk5kt+eFPcdix1t77oJD8y5YWKN+sKPYnAvJv7DCxYOAlQOVHyY+DPLx/oD1L1
         13gw==
X-Gm-Message-State: APf1xPCV1rCpDZ2xkK0awPS9la5trWl7m3GrbCTqn0vgFAChlo9fmKRX
        lRU/h+U0DsnnFxmZyhOWe/PO590ogcY=
X-Google-Smtp-Source: AH8x224CyAFxx+jzJdDWCPr+RJZChq6s+0UHrKrqqMel/GA6U+Z1iGVIg4uN1OhgohMhwxO82EEkeA==
X-Received: by 10.101.81.12 with SMTP id f12mr12570942pgq.81.1519779982450;
        Tue, 27 Feb 2018 17:06:22 -0800 (PST)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id f7sm358286pgq.66.2018.02.27.17.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 17:06:21 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 06/11] packfile: add repository argument to reprepare_packed_git
Date:   Tue, 27 Feb 2018 17:06:03 -0800
Message-Id: <20180228010608.215505-7-sbeller@google.com>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
In-Reply-To: <20180228010608.215505-1-sbeller@google.com>
References: <20180228010608.215505-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See previous patch for explanation.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/gc.c           | 2 +-
 builtin/receive-pack.c | 3 ++-
 bulk-checkin.c         | 3 ++-
 fetch-pack.c           | 3 ++-
 packfile.c             | 2 +-
 packfile.h             | 3 ++-
 sha1_file.c            | 2 +-
 7 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 97f34ae9fe0..c16020ef42a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -478,7 +478,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		return error(FAILED_RUN, rerere.argv[0]);
 
 	report_garbage = report_pack_garbage;
-	reprepare_packed_git();
+	reprepare_packed_git(the_repository);
 	if (pack_garbage.nr > 0)
 		clean_pack_garbage();
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 954fc72c7cb..8b03a6e03dc 100644
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
index 3310fd210a1..eadc2d51720 100644
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
diff --git a/fetch-pack.c b/fetch-pack.c
index 8253d746e0c..eac5928a27b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "repository.h"
 #include "config.h"
 #include "lockfile.h"
 #include "refs.h"
@@ -1192,7 +1193,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 	prepare_shallow_info(&si, shallow);
 	ref_cpy = do_fetch_pack(args, fd, ref, sought, nr_sought,
 				&si, pack_lockfile);
-	reprepare_packed_git();
+	reprepare_packed_git(the_repository);
 	update_shallow(args, sought, nr_sought, &si);
 	clear_shallow_info(&si);
 	return ref_cpy;
diff --git a/packfile.c b/packfile.c
index 6e8b98ab405..6ea50230aab 100644
--- a/packfile.c
+++ b/packfile.c
@@ -899,7 +899,7 @@ void prepare_packed_git_the_repository(void)
 	the_repository->objects.packed_git_initialized = 1;
 }
 
-void reprepare_packed_git(void)
+void reprepare_packed_git_the_repository(void)
 {
 	the_repository->objects.approximate_object_count_valid = 0;
 	the_repository->objects.packed_git_initialized = 0;
diff --git a/packfile.h b/packfile.h
index 39eb590b2ae..9afbf73657e 100644
--- a/packfile.h
+++ b/packfile.h
@@ -36,7 +36,8 @@ extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
 #define prepare_packed_git(r) prepare_packed_git_##r()
 extern void prepare_packed_git_the_repository(void);
-extern void reprepare_packed_git(void);
+#define reprepare_packed_git(r) reprepare_packed_git_##r()
+extern void reprepare_packed_git_the_repository(void);
 extern void install_packed_git(struct repository *r, struct packed_git *pack);
 
 /*
diff --git a/sha1_file.c b/sha1_file.c
index 36282acb1a8..0b9fefaaf02 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1281,7 +1281,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 			return 0;
 
 		/* Not a loose object; someone else may have just packed it. */
-		reprepare_packed_git();
+		reprepare_packed_git(the_repository);
 		if (find_pack_entry(real, &e))
 			break;
 
-- 
2.16.2.395.g2e18187dfd-goog

