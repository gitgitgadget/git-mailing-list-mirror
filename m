Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 825D5208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbdHRWVu (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:21:50 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35676 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbdHRWUv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:20:51 -0400
Received: by mail-pg0-f45.google.com with SMTP id q6so1091951pgs.2
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 15:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=31eXhdfPM/jTqqfbIWLi5XV16+03xMSh5mkyJvuZsc8=;
        b=SW8rTWoKAWEVyyul0can25zUEhcLckmZ9oBmSf44ArFRjmbXmJ5wY/CKM/8Wg9jI+c
         PWvhucZ4VNT1n3EXL7cat0lLmeQEaPbCCv0jmC5phmNxug9lft7pEEJnV8+zBTI8b6ef
         a64aMt/MEefXaZUdK+y473NN4/HFZmozdc1Ou0X6yEezC0x+P/Ip/3JHa58vYi6585Ws
         RNNiKkT4L8AaB/Ba55sWyU2XsHHRERB7eXF6NZG59slyhTutpPpZWs56pC5KgTP+hwTU
         8l7WGNAkRIfXiUQN6dIIIWsJelC4DmPGLHn+P54V7LJAmRW2gOp1XScg49GMl4J3qa/i
         6ZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=31eXhdfPM/jTqqfbIWLi5XV16+03xMSh5mkyJvuZsc8=;
        b=q2shsTXnRaDySkjFwnF739nzJcDfkaRRhRaRopHN1xrwtVBL31LDI5woistKWpb8xp
         yEMYHOFiH0f6LbM9twPCFc0+qeRCmwzbBhnUQqXl/SON4VPaDdL51WnixsjJCMB0ucTe
         VUByAfZlN2Wp0qBJUM4DP4pVcnPfV1ISZydDc+cu6fOeOwIt5HRUzBota+zIZlDquwCU
         0f4N5NiG0yMU6zpcmEJmHPSXCvUvTwESs27dRIeTulo3z1H2nfNz0/2rTwc0XJGqnbxq
         jVzlgh4C/4d8fxQuoFxkDdYJhsoATZoj35Nsdw51ZiUB4z/fbmto79yh/RNSMBHtDbqM
         VInQ==
X-Gm-Message-State: AHYfb5i19Sp67E8146ffNzD278KGpVFmyIMVsK9USwlxZ9FjIhdTOC+a
        WvIxS1VJe5qTnqwJ2P8W/A==
X-Received: by 10.84.143.36 with SMTP id 33mr11335160ply.79.1503094850905;
        Fri, 18 Aug 2017 15:20:50 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id w123sm12544006pfb.60.2017.08.18.15.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 15:20:50 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 05/23] pack: move release_pack_memory()
Date:   Fri, 18 Aug 2017 15:20:20 -0700
Message-Id: <bdaafb2acd92218a4d406033148a8133408e16bc.1503094448.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1503094448.git.jonathantanmy@google.com>
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1503094448.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function unuse_one_window() needs to be temporarily made global. Its
scope will be restored to static in a subsequent commit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 git-compat-util.h |  2 --
 packfile.c        | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 packfile.h        |  4 ++++
 sha1_file.c       | 49 -------------------------------------------------
 4 files changed, 53 insertions(+), 51 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index db9c22de7..201056e2d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -749,8 +749,6 @@ const char *inet_ntop(int af, const void *src, char *dst, size_t size);
 extern int git_atexit(void (*handler)(void));
 #endif
 
-extern void release_pack_memory(size_t);
-
 typedef void (*try_to_free_t)(size_t);
 extern try_to_free_t set_try_to_free_routine(try_to_free_t);
 
diff --git a/packfile.c b/packfile.c
index 6edc43228..8daa74ad1 100644
--- a/packfile.c
+++ b/packfile.c
@@ -208,3 +208,52 @@ struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path)
 
 	return p;
 }
+
+static void scan_windows(struct packed_git *p,
+	struct packed_git **lru_p,
+	struct pack_window **lru_w,
+	struct pack_window **lru_l)
+{
+	struct pack_window *w, *w_l;
+
+	for (w_l = NULL, w = p->windows; w; w = w->next) {
+		if (!w->inuse_cnt) {
+			if (!*lru_w || w->last_used < (*lru_w)->last_used) {
+				*lru_p = p;
+				*lru_w = w;
+				*lru_l = w_l;
+			}
+		}
+		w_l = w;
+	}
+}
+
+int unuse_one_window(struct packed_git *current)
+{
+	struct packed_git *p, *lru_p = NULL;
+	struct pack_window *lru_w = NULL, *lru_l = NULL;
+
+	if (current)
+		scan_windows(current, &lru_p, &lru_w, &lru_l);
+	for (p = packed_git; p; p = p->next)
+		scan_windows(p, &lru_p, &lru_w, &lru_l);
+	if (lru_p) {
+		munmap(lru_w->base, lru_w->len);
+		pack_mapped -= lru_w->len;
+		if (lru_l)
+			lru_l->next = lru_w->next;
+		else
+			lru_p->windows = lru_w->next;
+		free(lru_w);
+		pack_open_windows--;
+		return 1;
+	}
+	return 0;
+}
+
+void release_pack_memory(size_t need)
+{
+	size_t cur = pack_mapped;
+	while (need >= (cur - pack_mapped) && unuse_one_window(NULL))
+		; /* nothing */
+}
diff --git a/packfile.h b/packfile.h
index 703887d41..f6fe1c741 100644
--- a/packfile.h
+++ b/packfile.h
@@ -43,4 +43,8 @@ extern void pack_report(void);
  */
 extern int open_pack_index(struct packed_git *);
 
+extern int unuse_one_window(struct packed_git *current);
+
+extern void release_pack_memory(size_t);
+
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index 475d2032d..d51efd78d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -680,55 +680,6 @@ static int has_loose_object(const unsigned char *sha1)
 	return check_and_freshen(sha1, 0);
 }
 
-static void scan_windows(struct packed_git *p,
-	struct packed_git **lru_p,
-	struct pack_window **lru_w,
-	struct pack_window **lru_l)
-{
-	struct pack_window *w, *w_l;
-
-	for (w_l = NULL, w = p->windows; w; w = w->next) {
-		if (!w->inuse_cnt) {
-			if (!*lru_w || w->last_used < (*lru_w)->last_used) {
-				*lru_p = p;
-				*lru_w = w;
-				*lru_l = w_l;
-			}
-		}
-		w_l = w;
-	}
-}
-
-static int unuse_one_window(struct packed_git *current)
-{
-	struct packed_git *p, *lru_p = NULL;
-	struct pack_window *lru_w = NULL, *lru_l = NULL;
-
-	if (current)
-		scan_windows(current, &lru_p, &lru_w, &lru_l);
-	for (p = packed_git; p; p = p->next)
-		scan_windows(p, &lru_p, &lru_w, &lru_l);
-	if (lru_p) {
-		munmap(lru_w->base, lru_w->len);
-		pack_mapped -= lru_w->len;
-		if (lru_l)
-			lru_l->next = lru_w->next;
-		else
-			lru_p->windows = lru_w->next;
-		free(lru_w);
-		pack_open_windows--;
-		return 1;
-	}
-	return 0;
-}
-
-void release_pack_memory(size_t need)
-{
-	size_t cur = pack_mapped;
-	while (need >= (cur - pack_mapped) && unuse_one_window(NULL))
-		; /* nothing */
-}
-
 static void mmap_limit_check(size_t length)
 {
 	static size_t limit = 0;
-- 
2.14.1.480.gb18f417b89-goog

