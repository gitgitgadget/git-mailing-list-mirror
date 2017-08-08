Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C936420899
	for <e@80x24.org>; Tue,  8 Aug 2017 19:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752378AbdHHTdN (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 15:33:13 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:37786 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752266AbdHHTc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 15:32:56 -0400
Received: by mail-pg0-f45.google.com with SMTP id y129so18621722pgy.4
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 12:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=86JNDIUUUTNDyqSH3kBnLLvEHo49HQ/m082NPSJGvng=;
        b=o7XdqHMPHNeM6E05fStTIT9aLRsaMOZFOPG4im0pZO7dorokMxUZcQTA8iJXiew3JC
         iyepBe1ASzkTMPGavPZukof63w0ittAGe6o/8VWNYshs77KgpjNFkBkb1uRFZtBCM5xf
         IJdZ6nZOUT2Z/mHsr9atOORoJCALuG2tnu4NbZkiPu4g/wN9aDgquwWTSXdTn0UH5i72
         L2v8mDc2XtSsDSG1oxrK3JlkgUZGHgf9DEZOF4+CL5QUdpZkn7VkR5Nz6grCJ3MWe6Yi
         8/FUDkG1lnEPAE4lTbsm4Ov8/xL2I/nkUfchOSIZSUFQDlgOlNzBlxrGasog6HBK15rr
         sfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=86JNDIUUUTNDyqSH3kBnLLvEHo49HQ/m082NPSJGvng=;
        b=hoYvKxrjbEuPYvCoKtfStXAKDY+4xakey97o/hQM4ffOYYeibPRVqr1Pn3J9vODLb5
         d7AWzBxyewiAzj9MQD/lC+7KYGWytjOGw5nZKQZ4dRevCqw02QPGsSslmAQvgb2JixDs
         oyYGAou/d3Td+Fyqx9XNVlzh97/TDVCiYb7KlnuFdLLrUc20x7X724tKfJtciBOj3gVp
         5p4cbxxUiwlL1wPfb/5JIF8Bhke/wNDORiXChDO0CySRwp+ee9ev0UTgm17rMEaAkEO6
         rG99ECl4/L/D3BkClT21INTv9mNsqg/noSsPA/X51lrAbSsafW5hz7VMBS8afIDa2ZxM
         XDHw==
X-Gm-Message-State: AHYfb5iMAj5iAuO7EG0+6N1vhyce3uS7s4N0S17++Xjm0fuM+Me49RbX
        Zbtpubai2wEbatpsYn5tJg==
X-Received: by 10.84.211.100 with SMTP id b91mr6236170pli.246.1502220774996;
        Tue, 08 Aug 2017 12:32:54 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id k186sm4332547pfc.173.2017.08.08.12.32.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 12:32:53 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC PATCH 05/10] pack: move release_pack_memory()
Date:   Tue,  8 Aug 2017 12:32:35 -0700
Message-Id: <90178a372d410c34891594e45fcd13d3939ddf0c.1502220307.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502220307.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502220307.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function unuse_one_window() needs to be temporarily made global. Its
scope will be restored to static in a subsequent commit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 git-compat-util.h |  2 --
 pack.c            | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 pack.h            |  4 ++++
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
 
diff --git a/pack.c b/pack.c
index 6edc43228..8daa74ad1 100644
--- a/pack.c
+++ b/pack.c
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
diff --git a/pack.h b/pack.h
index 5be0ed42a..c16220586 100644
--- a/pack.h
+++ b/pack.h
@@ -143,4 +143,8 @@ extern int open_pack_index(struct packed_git *);
 
 extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
 
+extern int unuse_one_window(struct packed_git *current);
+
+extern void release_pack_memory(size_t);
+
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index 2e414f5f5..644876e4e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -679,55 +679,6 @@ static int has_loose_object(const unsigned char *sha1)
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
2.14.0.434.g98096fd7a8-goog

