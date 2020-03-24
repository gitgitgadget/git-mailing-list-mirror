Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B5FC54EEB
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 01:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAEEC20714
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 01:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3UTaHz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgCXBIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 21:08:18 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46594 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgCXBIR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 21:08:17 -0400
Received: by mail-qk1-f193.google.com with SMTP id u4so5856360qkj.13
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 18:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LSNSJphHMSw0H2nivj8hpiCkplODWHbjqvz+ByT0aH8=;
        b=d3UTaHz6z91KBNYhcwCKJjuJQsUwS+8V29k6rNeE4JgK+ueGAuwo1lhZxpMwpgEwHe
         MOPow4ieU8suvukq7PREwRFwE1/ZE1093qACS+c99zV2YdHoTcbTXEuKW3qMjZ5iwvw+
         jWl251z4l9Ie2tltC1+vYyTtR8j8R7FNCLsztQExC44AfWLvygzcK/AMnD+3XAwGL5PN
         gFH4jau6GkwCgwONgdtoP4YUqNLpu5G51CH8Z3V/iA2WAr11K6gjVieBmuYGwZHiyMEc
         TSb3CD6CzK9dHGXxEIsHb/yESA+8sXSYU+RwGf6vkXkDqYgXyanXbp4rLwKHVRyKdFkx
         isuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LSNSJphHMSw0H2nivj8hpiCkplODWHbjqvz+ByT0aH8=;
        b=KmwpoNRnPzhaWwsp+WdTHQIGppU+KPZo+rdZyP08cc7ic1lVVPVFOZOBhfqeQ/Fyom
         mS97ugZV8kTpoiLtF5U41z2wqo3UNlps9PLIrS/8epFuGiA+uYwt9oRgS58hRMR/U5EA
         F1pyuyKDe8Q14f2BqnhDvgFUTvd+DoH33obaisYGRTQKaT4a1//jDqtkpXsqYc9S/rxN
         kfUYf+dU5n4eaZ/iI18kNn/ygVwq/wZ7hXUy1QBIV9HcC0cinlhHh6MUyTvhClUVvhBv
         nXMVj3PZDKIU5D++OzoM+1MFtdhnvdFtpfM5XwpegtggTXTwoaa8VVO0cUnOn2JCeAon
         Yo/A==
X-Gm-Message-State: ANhLgQ2bwTgJSf6wVSunlMxPAbctjJDf9oVaCBdCPfSSwIScAvWG7V7c
        sSCnOlt8hkS/PSZddEj5W3KP4ruX
X-Google-Smtp-Source: ADFU+vvMhc256996PYkQijHk70BrNqIcuKnMB9+HBmt5ubYCdWurJJenEYjkydpCgCuCef9VUuFQ6g==
X-Received: by 2002:ae9:e403:: with SMTP id q3mr17515099qkc.241.1585012096177;
        Mon, 23 Mar 2020 18:08:16 -0700 (PDT)
Received: from localhost.localdomain (ktnron0919w-grc-01-76-68-141-233.dsl.bell.ca. [76.68.141.233])
        by smtp.gmail.com with ESMTPSA id x9sm13301878qtk.7.2020.03.23.18.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 18:08:15 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] Lib-ify prune-packed
Date:   Mon, 23 Mar 2020 21:07:52 -0400
Message-Id: <c6a80ce8829c0b9bac22b4e264f238cf9b9359f7.1585011949.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
In-Reply-To: <cover.1585011949.git.liu.denton@gmail.com>
References: <cover.1584786523.git.liu.denton@gmail.com> <cover.1585011949.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In builtin.h, there exists the distinctly lib-ish function
prune_packed_objects(). This function can currently only be called by
built-in commands but, unlike all of the other functions in the header,
it does not make sense to impose this restriction as the functionality
can be logically reused in libgit.

Extract this function into prune-packed.c so that related definitions
can exist clearly in their own header file.

While we're at it, clean up #includes that are unused.

This patch is best viewed with --color-moved.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Makefile               |  1 +
 builtin.h              |  5 -----
 builtin/prune-packed.c | 44 +-----------------------------------------
 builtin/prune.c        |  1 +
 builtin/repack.c       |  1 +
 prune-packed.c         | 43 +++++++++++++++++++++++++++++++++++++++++
 prune-packed.h         |  9 +++++++++
 7 files changed, 56 insertions(+), 48 deletions(-)
 create mode 100644 prune-packed.c
 create mode 100644 prune-packed.h

diff --git a/Makefile b/Makefile
index 04e3cc179e..608afd58b1 100644
--- a/Makefile
+++ b/Makefile
@@ -952,6 +952,7 @@ LIB_OBJS += progress.o
 LIB_OBJS += promisor-remote.o
 LIB_OBJS += prompt.o
 LIB_OBJS += protocol.o
+LIB_OBJS += prune-packed.o
 LIB_OBJS += quote.o
 LIB_OBJS += range-diff.o
 LIB_OBJS += reachable.o
diff --git a/builtin.h b/builtin.h
index 6101d98661..a5ae15bfe5 100644
--- a/builtin.h
+++ b/builtin.h
@@ -97,11 +97,6 @@
 extern const char git_usage_string[];
 extern const char git_more_info_string[];
 
-#define PRUNE_PACKED_DRY_RUN 01
-#define PRUNE_PACKED_VERBOSE 02
-
-void prune_packed_objects(int);
-
 /**
  * If a built-in has DELAY_PAGER_CONFIG set, the built-in should call this early
  * when it wishes to respect the `pager.foo`-config. The `cmd` is the name of
diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index 48c5e78e33..b7b9281a8c 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -1,54 +1,12 @@
 #include "builtin.h"
-#include "cache.h"
-#include "progress.h"
 #include "parse-options.h"
-#include "packfile.h"
-#include "object-store.h"
+#include "prune-packed.h"
 
 static const char * const prune_packed_usage[] = {
 	N_("git prune-packed [-n | --dry-run] [-q | --quiet]"),
 	NULL
 };
 
-static struct progress *progress;
-
-static int prune_subdir(unsigned int nr, const char *path, void *data)
-{
-	int *opts = data;
-	display_progress(progress, nr + 1);
-	if (!(*opts & PRUNE_PACKED_DRY_RUN))
-		rmdir(path);
-	return 0;
-}
-
-static int prune_object(const struct object_id *oid, const char *path,
-			 void *data)
-{
-	int *opts = data;
-
-	if (!has_object_pack(oid))
-		return 0;
-
-	if (*opts & PRUNE_PACKED_DRY_RUN)
-		printf("rm -f %s\n", path);
-	else
-		unlink_or_warn(path);
-	return 0;
-}
-
-void prune_packed_objects(int opts)
-{
-	if (opts & PRUNE_PACKED_VERBOSE)
-		progress = start_delayed_progress(_("Removing duplicate objects"), 256);
-
-	for_each_loose_file_in_objdir(get_object_directory(),
-				      prune_object, NULL, prune_subdir, &opts);
-
-	/* Ensure we show 100% before finishing progress */
-	display_progress(progress, 256);
-	stop_progress(&progress);
-}
-
 int cmd_prune_packed(int argc, const char **argv, const char *prefix)
 {
 	int opts = isatty(2) ? PRUNE_PACKED_VERBOSE : 0;
diff --git a/builtin/prune.c b/builtin/prune.c
index 2b76872ad2..fd9acc7222 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -6,6 +6,7 @@
 #include "reachable.h"
 #include "parse-options.h"
 #include "progress.h"
+#include "prune-packed.h"
 #include "object-store.h"
 
 static const char * const prune_usage[] = {
diff --git a/builtin/repack.c b/builtin/repack.c
index 0781763b06..1b686ee9ce 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -10,6 +10,7 @@
 #include "argv-array.h"
 #include "midx.h"
 #include "packfile.h"
+#include "prune-packed.h"
 #include "object-store.h"
 #include "promisor-remote.h"
 
diff --git a/prune-packed.c b/prune-packed.c
new file mode 100644
index 0000000000..261520b472
--- /dev/null
+++ b/prune-packed.c
@@ -0,0 +1,43 @@
+#include "object-store.h"
+#include "packfile.h"
+#include "progress.h"
+#include "prune-packed.h"
+
+static struct progress *progress;
+
+static int prune_subdir(unsigned int nr, const char *path, void *data)
+{
+	int *opts = data;
+	display_progress(progress, nr + 1);
+	if (!(*opts & PRUNE_PACKED_DRY_RUN))
+		rmdir(path);
+	return 0;
+}
+
+static int prune_object(const struct object_id *oid, const char *path,
+			 void *data)
+{
+	int *opts = data;
+
+	if (!has_object_pack(oid))
+		return 0;
+
+	if (*opts & PRUNE_PACKED_DRY_RUN)
+		printf("rm -f %s\n", path);
+	else
+		unlink_or_warn(path);
+	return 0;
+}
+
+void prune_packed_objects(int opts)
+{
+	if (opts & PRUNE_PACKED_VERBOSE)
+		progress = start_delayed_progress(_("Removing duplicate objects"), 256);
+
+	for_each_loose_file_in_objdir(get_object_directory(),
+				      prune_object, NULL, prune_subdir, &opts);
+
+	/* Ensure we show 100% before finishing progress */
+	display_progress(progress, 256);
+	stop_progress(&progress);
+}
diff --git a/prune-packed.h b/prune-packed.h
new file mode 100644
index 0000000000..936fa9df23
--- /dev/null
+++ b/prune-packed.h
@@ -0,0 +1,9 @@
+#ifndef PRUNE_PACKED_H
+#define PRUNE_PACKED_H
+
+#define PRUNE_PACKED_DRY_RUN 01
+#define PRUNE_PACKED_VERBOSE 02
+
+void prune_packed_objects(int);
+
+#endif
-- 
2.25.0.114.g5b0ca878e0

