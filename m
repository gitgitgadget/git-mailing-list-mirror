Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DA2E20899
	for <e@80x24.org>; Wed,  9 Aug 2017 01:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752507AbdHIBXM (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 21:23:12 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34828 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752356AbdHIBXI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 21:23:08 -0400
Received: by mail-pf0-f173.google.com with SMTP id t86so21278574pfe.2
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 18:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=14E5iDzPGLacWidthCKppqM2rqoEimLBYC1PteZhA2k=;
        b=EP4TfZZHqeOsE7JMMxtvpYNyxrNEzOWpaz6grMCPAOvVG/SiPcmNhy4U/HxcCxvL7D
         8N+aPHFvCZSJirXHIKGTpK429PHorRrqJO8iapBTMNL31RdYmnBdSfn8Q4iX159ObIPN
         BxvXhp7sqp+KdBal7gwRVdMYykLhJ6EVBCZNhcL5nyv8UcaLAK702+pbpZgHWjFHjgyV
         wxgsM1vxSJWZ/0hcVMxkRvKzRdnXRJgJG0WtX+zA4dkJ9ntcy3TBE1z/DHdkFmHwVotZ
         zdJ+bqbZbvRZYcwF+980RdRkGSkvpjcqtjk19IQCvlzij9Y6g9miA+wNPX+ZKkARk4Ux
         RoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=14E5iDzPGLacWidthCKppqM2rqoEimLBYC1PteZhA2k=;
        b=J/4a8K2nUstILFN0VZ1I/jMY8A6LysZplNfL09a5tF7xQL4xQCY2i+kBPskS7/xIHJ
         84UJgk0Eoon7DgJTshuBBm4381GR/NAxgBCfS5OA7daWcLWqYcN7Vv4iir7jktF0LiDM
         TC4myC2mfbeCK2w3u0L1WAkVhex2nnH/tfwWhE85WUaNmAx48ffDsOH3jvzCmJcllJyr
         RksgI1DZrRkuJlAG5NYMiMkxVvkV8zgbwbWMeMg4XAerGJ8ozvfuZUJUUgdCvfr65NMw
         mhis6bscc/MgaGkPDkP95MmsajVeLxfPmiX07jALKaQsRABDYmv/kCqOKKxMXOXNG6GJ
         2qFg==
X-Gm-Message-State: AHYfb5hw0mtjN3rggY1LK//TGFm50+1hjW1xFHpYhBrSSQBekCZA2WE9
        b0rooeHo4zfqgP+3sa9+ow==
X-Received: by 10.99.127.90 with SMTP id p26mr5879518pgn.377.1502241787819;
        Tue, 08 Aug 2017 18:23:07 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id r5sm4479602pgn.45.2017.08.08.18.23.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 18:23:06 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 05/25] pack: move release_pack_memory()
Date:   Tue,  8 Aug 2017 18:22:37 -0700
Message-Id: <cfd2577759c2397aa7bfab2315a651f142b83639.1502241234.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502241234.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1502241234.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function unuse_one_window() needs to be temporarily made global. Its
scope will be restored to static in a subsequent commit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 git-compat-util.h |  2 --
 pack.h            |  4 ++++
 packfile.c        | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
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

