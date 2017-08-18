Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56F48208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbdHRWUy (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:20:54 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:38261 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdHRWUx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:20:53 -0400
Received: by mail-pg0-f44.google.com with SMTP id t80so44558170pgb.5
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 15:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=HSNFWzo4OJpRBGcGyPSSWRno9Hy8P2VUSdCtFbfTJWQ=;
        b=fS/GerEGE/9NBDNujI2O15zmWP7eOQI9YdjGMAAmNX+Aw0ecFgJgFWcvugbg91N3dd
         BXNFnZrODccvaRBFOhwOn9i4zAiDKgOpMV/zUKUQqIZxPaiG48gcXSL1AXA64umtQcWY
         f9lVAGrpqBQpHRHqtmagrzrp3garPFIyckMuBQcALjINucEipKfodyHi1pEvRu2gb9EQ
         taWmSKuyBGOQagzQ13Egnm1i6345nM8H/Lil53vgbTRe6MK6o8X1ObvkXNZ8WVqoJZ6V
         4Ga5S+nXQm28pyvOnJhqWuNmZMOdP8zywEKlfti6LgwulUtareroKlZdXzS4gNs30M6T
         gxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=HSNFWzo4OJpRBGcGyPSSWRno9Hy8P2VUSdCtFbfTJWQ=;
        b=JInv+l/+upNteorak1BYPqgxDr/eFDkBYt1cEbpdDrrJxQDpUbjyC25yFLTANrEIlm
         xRfGHpGdAkLGCszYh9aGvJLb0lGuC/N2z2l2ZviCyn2oFLiI26giMSnQNV+3Q5mH2bwU
         IG/tmY22I0Nyx5Jdk4eQNAnbqBl3dpMpeXpAXtC/fZu2pxwHxC/8nhFul4fcWRLCpa0Z
         hnZrhkfSXxb8NC5xdomJdR2ZVXcYSXzmmIW3HLmrWxEGz2ydThU5TwE6B0ZtGO5eVHKi
         xRwTFVBhaq4Xj1Ls+LHA4/Cg5EhyytyIPAITWpCZwgKaJeEi7xIIS27SEyc5LtOgd45F
         wHSw==
X-Gm-Message-State: AHYfb5ihD/TteWYikfQJkhTtLpdp3Tjw2hyzzZO/L4enMDfyfYmaD1AN
        F46MiTQaY6NGL0yklMMnxg==
X-Received: by 10.84.229.12 with SMTP id b12mr11050802plk.325.1503094852062;
        Fri, 18 Aug 2017 15:20:52 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id w123sm12544006pfb.60.2017.08.18.15.20.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 15:20:51 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 06/23] pack: move pack-closing functions
Date:   Fri, 18 Aug 2017 15:20:21 -0700
Message-Id: <d22c3a8a6ae947175bcef1a3ae3ec9c2986d3d17.1503094448.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1503094448.git.jonathantanmy@google.com>
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1503094448.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function close_pack_fd() needs to be temporarily made global. Its
scope will be restored to static in a subsequent commit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/am.c           |  1 +
 builtin/clone.c        |  1 +
 builtin/fetch.c        |  1 +
 builtin/merge.c        |  1 +
 builtin/receive-pack.c |  1 +
 cache.h                |  8 --------
 packfile.c             | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
 packfile.h             | 11 ++++++++++
 sha1_file.c            | 55 --------------------------------------------------
 9 files changed, 70 insertions(+), 63 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index c973bd96d..b9d9ff203 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -31,6 +31,7 @@
 #include "mailinfo.h"
 #include "apply.h"
 #include "string-list.h"
+#include "packfile.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
diff --git a/builtin/clone.c b/builtin/clone.c
index 08b5cc433..13abb075a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -25,6 +25,7 @@
 #include "remote.h"
 #include "run-command.h"
 #include "connected.h"
+#include "packfile.h"
 
 /*
  * Overall FIXMEs:
diff --git a/builtin/fetch.c b/builtin/fetch.c
index c87e59f3b..c86c36f37 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -17,6 +17,7 @@
 #include "connected.h"
 #include "argv-array.h"
 #include "utf8.h"
+#include "packfile.h"
 
 static const char * const builtin_fetch_usage[] = {
 	N_("git fetch [<options>] [<repository> [<refspec>...]]"),
diff --git a/builtin/merge.c b/builtin/merge.c
index 900bafdb4..45e673dcc 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -32,6 +32,7 @@
 #include "gpg-interface.h"
 #include "sequencer.h"
 #include "string-list.h"
+#include "packfile.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index cabdc55e0..0019a484f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -23,6 +23,7 @@
 #include "fsck.h"
 #include "tmp-objdir.h"
 #include "oidset.h"
+#include "packfile.h"
 
 static const char * const receive_pack_usage[] = {
 	N_("git receive-pack <git-dir>"),
diff --git a/cache.h b/cache.h
index f271033db..bbc56566e 100644
--- a/cache.h
+++ b/cache.h
@@ -1645,15 +1645,7 @@ extern int odb_mkstemp(struct strbuf *template, const char *pattern);
  */
 extern int odb_pack_keep(const char *name);
 
-/*
- * munmap the index file for the specified packfile (if it is
- * currently mmapped).
- */
-extern void close_pack_index(struct packed_git *);
-
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, size_t *);
-extern void close_pack_windows(struct packed_git *);
-extern void close_all_packs(void);
 extern void unuse_pack(struct pack_window **);
 extern void clear_delta_base_cache(void);
 extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
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
diff --git a/packfile.h b/packfile.h
index f6fe1c741..c6a07de62 100644
--- a/packfile.h
+++ b/packfile.h
@@ -43,6 +43,17 @@ extern void pack_report(void);
  */
 extern int open_pack_index(struct packed_git *);
 
+/*
+ * munmap the index file for the specified packfile (if it is
+ * currently mmapped).
+ */
+extern void close_pack_index(struct packed_git *);
+
+extern void close_pack_windows(struct packed_git *);
+extern void close_all_packs(void);
+
+extern int close_pack_fd(struct packed_git *);
+
 extern int unuse_one_window(struct packed_git *current);
 
 extern void release_pack_memory(size_t);
diff --git a/sha1_file.c b/sha1_file.c
index d51efd78d..7913a69f1 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -718,53 +718,6 @@ void *xmmap(void *start, size_t length,
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
@@ -847,14 +800,6 @@ void unuse_pack(struct pack_window **w_cursor)
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
2.14.1.480.gb18f417b89-goog

