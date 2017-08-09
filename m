Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3E6A20899
	for <e@80x24.org>; Wed,  9 Aug 2017 01:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbdHIBYF (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 21:24:05 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33254 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752483AbdHIBXK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 21:23:10 -0400
Received: by mail-pg0-f41.google.com with SMTP id u5so21620842pgn.0
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 18:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=QMfQCLpktqG8h61+g47uy5FErzXoJGWLH9VVeOySGLs=;
        b=Nym416d4MxSvLiuOQSERagWAbs2dhgUe0OwZPrPyAfdVuCYydYSwRVAjvJGNpaOq8w
         nlDNgOauY6ZDnxQnxkv+ge7uld7UGyiYoe17G7+F7GoCq3J0STMVK4wHJSu5yB6KZrIZ
         QvvdJisjyIWijkim3iAcZd+LoBX9jaVLfiSm89JUWA6d6+I3LqumuzAMr5g/MIAJ4kqY
         3p8o5ImMABrofpIBIbvL82XyDFow/S5IjG9/ZZlOgR2XXCT9TrORO2TNNrAiHa6+/703
         qyziZSoKB4p/Gnv1ClAnIfuP+V8IlZ57focB7FgfMCqnOqpvoAB2eVC5cA00sJ7saQLR
         Y12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=QMfQCLpktqG8h61+g47uy5FErzXoJGWLH9VVeOySGLs=;
        b=tA8PKAMFyCEyEuZ+GD6KMP+5RLriXku23+qAqg7YKQDBGNqStRUOINuzqPrTkzDC9L
         OQ4/yXoHfbIujm7TgQgYDz3b9Yi6YPGNaXjdBr3jlqHhJHmrlQeNoQ0J7fuTihxrBn9O
         h7tMtYuUx1Sg0zs419fQqcFAsC1ydD3gTSO7sRkAsyvKSoAhHExUNH+7zs4O2xxlubDO
         sFGsIfQO21cN/88kFNndR0/YbgS2TYif1JyESy65ouDZT7aXmPDGLselLlIK5dg86NXP
         GycCHnmdgqJ1P8+uN3lJc5Fl6eDvExOT7kElWiW0IFaUMfFiNpjnMjVhYeZ8Napzy6xR
         Yvew==
X-Gm-Message-State: AHYfb5gl9iBAo91neAU0KYtcbwnlL41Sqi3x1VhrAxdNcowo2E0CkGrR
        ibh/KjwxUrRLe0FWtqF0EA==
X-Received: by 10.101.90.195 with SMTP id d3mr5833208pgt.223.1502241789476;
        Tue, 08 Aug 2017 18:23:09 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id r5sm4479602pgn.45.2017.08.08.18.23.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 18:23:08 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 06/25] pack: move pack-closing functions
Date:   Tue,  8 Aug 2017 18:22:38 -0700
Message-Id: <8909048c39578f0fe5e52d0056f3911553dbe6f9.1502241234.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502241234.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1502241234.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function close_pack_fd() needs to be temporarily made global. Its
scope will be restored to static in a subsequent commit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/am.c    |  1 +
 builtin/clone.c |  1 +
 builtin/fetch.c |  1 +
 builtin/merge.c |  1 +
 cache.h         |  8 --------
 pack.h          |  9 +++++++++
 packfile.c      | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sha1_file.c     | 55 -------------------------------------------------------
 8 files changed, 67 insertions(+), 63 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index c973bd96d..c38dd10a3 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -31,6 +31,7 @@
 #include "mailinfo.h"
 #include "apply.h"
 #include "string-list.h"
+#include "pack.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
diff --git a/builtin/clone.c b/builtin/clone.c
index 08b5cc433..53410a45d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -25,6 +25,7 @@
 #include "remote.h"
 #include "run-command.h"
 #include "connected.h"
+#include "pack.h"
 
 /*
  * Overall FIXMEs:
diff --git a/builtin/fetch.c b/builtin/fetch.c
index c87e59f3b..196a3bfc4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -17,6 +17,7 @@
 #include "connected.h"
 #include "argv-array.h"
 #include "utf8.h"
+#include "pack.h"
 
 static const char * const builtin_fetch_usage[] = {
 	N_("git fetch [<options>] [<repository> [<refspec>...]]"),
diff --git a/builtin/merge.c b/builtin/merge.c
index 900bafdb4..9cff4b276 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -32,6 +32,7 @@
 #include "gpg-interface.h"
 #include "sequencer.h"
 #include "string-list.h"
+#include "pack.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
diff --git a/cache.h b/cache.h
index 5d6839525..25a21a61f 100644
--- a/cache.h
+++ b/cache.h
@@ -1637,15 +1637,7 @@ extern int odb_mkstemp(struct strbuf *template, const char *pattern);
  */
 extern int odb_pack_keep(const char *name);
 
-/*
- * munmap the index file for the specified packfile (if it is
- * currently mmapped).
- */
-extern void close_pack_index(struct packed_git *);
-
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
-extern void close_pack_windows(struct packed_git *);
-extern void close_all_packs(void);
 extern void unuse_pack(struct pack_window **);
 extern void clear_delta_base_cache(void);
 extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
diff --git a/pack.h b/pack.h
index c16220586..fd4668528 100644
--- a/pack.h
+++ b/pack.h
@@ -147,4 +147,13 @@ extern int unuse_one_window(struct packed_git *current);
 
 extern void release_pack_memory(size_t);
 
+extern void close_pack_windows(struct packed_git *);
+extern int close_pack_fd(struct packed_git *);
+/*
+ * munmap the index file for the specified packfile (if it is
+ * currently mmapped).
+ */
+extern void close_pack_index(struct packed_git *);
+extern void close_all_packs(void);
+
 #endif
diff --git a/packfile.c b/packfile.c
index 8daa74ad1..c8e2dbdee 100644
--- a/packfile.c
+++ b/packfile.c
@@ -257,3 +257,57 @@ void release_pack_memory(size_t need)
 	while (need >= (cur - pack_mapped) && unuse_one_window(NULL))
 		; /* nothing */
 }
+
+void close_pack_windows(struct packed_git *p)
+{
+	while (p->windows) {
+		struct pack_window *w = p->windows;
+
+		if (w->inuse_cnt)
+			die("pack '%s' still has open windows to it",
+			    p->pack_name);
+		munmap(w->base, w->len);
+		pack_mapped -= w->len;
+		pack_open_windows--;
+		p->windows = w->next;
+		free(w);
+	}
+}
+
+int close_pack_fd(struct packed_git *p)
+{
+	if (p->pack_fd < 0)
+		return 0;
+
+	close(p->pack_fd);
+	pack_open_fds--;
+	p->pack_fd = -1;
+
+	return 1;
+}
+
+void close_pack_index(struct packed_git *p)
+{
+	if (p->index_data) {
+		munmap((void *)p->index_data, p->index_size);
+		p->index_data = NULL;
+	}
+}
+
+static void close_pack(struct packed_git *p)
+{
+	close_pack_windows(p);
+	close_pack_fd(p);
+	close_pack_index(p);
+}
+
+void close_all_packs(void)
+{
+	struct packed_git *p;
+
+	for (p = packed_git; p; p = p->next)
+		if (p->do_not_close)
+			die("BUG: want to close pack marked 'do-not-close'");
+		else
+			close_pack(p);
+}
diff --git a/sha1_file.c b/sha1_file.c
index 644876e4e..e2927244f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -717,53 +717,6 @@ void *xmmap(void *start, size_t length,
 	return ret;
 }
 
-void close_pack_windows(struct packed_git *p)
-{
-	while (p->windows) {
-		struct pack_window *w = p->windows;
-
-		if (w->inuse_cnt)
-			die("pack '%s' still has open windows to it",
-			    p->pack_name);
-		munmap(w->base, w->len);
-		pack_mapped -= w->len;
-		pack_open_windows--;
-		p->windows = w->next;
-		free(w);
-	}
-}
-
-static int close_pack_fd(struct packed_git *p)
-{
-	if (p->pack_fd < 0)
-		return 0;
-
-	close(p->pack_fd);
-	pack_open_fds--;
-	p->pack_fd = -1;
-
-	return 1;
-}
-
-static void close_pack(struct packed_git *p)
-{
-	close_pack_windows(p);
-	close_pack_fd(p);
-	close_pack_index(p);
-}
-
-void close_all_packs(void)
-{
-	struct packed_git *p;
-
-	for (p = packed_git; p; p = p->next)
-		if (p->do_not_close)
-			die("BUG: want to close pack marked 'do-not-close'");
-		else
-			close_pack(p);
-}
-
-
 /*
  * The LRU pack is the one with the oldest MRU window, preferring packs
  * with no used windows, or the oldest mtime if it has no windows allocated.
@@ -846,14 +799,6 @@ void unuse_pack(struct pack_window **w_cursor)
 	}
 }
 
-void close_pack_index(struct packed_git *p)
-{
-	if (p->index_data) {
-		munmap((void *)p->index_data, p->index_size);
-		p->index_data = NULL;
-	}
-}
-
 static unsigned int get_max_fd_limit(void)
 {
 #ifdef RLIMIT_NOFILE
-- 
2.14.0.434.g98096fd7a8-goog

