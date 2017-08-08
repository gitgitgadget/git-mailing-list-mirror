Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E12420899
	for <e@80x24.org>; Tue,  8 Aug 2017 19:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbdHHTdK (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 15:33:10 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:36289 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752324AbdHHTdB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 15:33:01 -0400
Received: by mail-pg0-f47.google.com with SMTP id v77so18590423pgb.3
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 12:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=lGsCfhjzq3sfHC5E5TNLGbHeYtDET1yQSzJ1A3fEyAw=;
        b=nLipOwRR0I7wxB6FxnoFEVkBQiqWdeNFrW02FzRi7QAHBtpek4U9tXJLKnfdidKN8M
         H1gCzrWoVLBaWw5+lpvyhAgoREru79C7d1Xe6RluCjiv7uHCya73IYCDSuUHG7Z2f9Ou
         t1ZYlo4t6LT90W7tMD2mLp+rxCdXWLO7UsqqL947gf5hmolofjMbWfWLxM2oXp/vxefu
         Qnd8/RJmDWk2ZZESzTSfVkzynY6fag0tZNLb+hjFOviobsY1VvgoL6gdb9zBpr7iJF2P
         OtJ1Ka1fabIVPHBwNgbLI8IEXgPI8RhEDUfN4rUrutyYsCErYezxmxxrv/3YZhwY6xzV
         A33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=lGsCfhjzq3sfHC5E5TNLGbHeYtDET1yQSzJ1A3fEyAw=;
        b=Y79+30ReBG1gDkLoxW5VZigBdWX4gEv489wf4HibmGm9R0rAfHSCMkJHcvsGnEt+fA
         b2uOifQRarYVd0S2JGClmBkmYaphePDphuGlzZza5rG4DltAXO6ruBtPC2ftavTZPAdy
         TwV++9gQo2/HX33rGEZ+RwSZoIiKWu5f9UKMZ/5QrA5SGhP+xUblx8IssKr2SKk5pnta
         ctcHoC2pRtWnNmIJyZ+Ra60R96dMuR5vXnLFsFwntKRnG3oE93/eIfAUcP9zl529JfdZ
         ZylvQNNBb1ZQaMe1CV9/h37ycU0lWCFl9Hl9mZkzZkTC9oGAYVmDONry8jcxDIQwOWer
         4gbQ==
X-Gm-Message-State: AHYfb5gVNJ+HMphuE9p5PY1vj50dZrxxn4ESPF4HP4crXQWt3tmqZ08X
        6h3aPf74DmPUq/3G1ToG1Q==
X-Received: by 10.98.18.11 with SMTP id a11mr5639572pfj.116.1502220780349;
        Tue, 08 Aug 2017 12:33:00 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id k186sm4332547pfc.173.2017.08.08.12.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 12:32:59 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC PATCH 08/10] pack: move unuse_pack()
Date:   Tue,  8 Aug 2017 12:32:38 -0700
Message-Id: <106f64e0995c85dd1dd3916cea8a8408facd335b.1502220307.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502220307.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502220307.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h     | 1 -
 pack.c      | 9 +++++++++
 pack.h      | 1 +
 sha1_file.c | 9 ---------
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index dd9f9a9ae..4812f3a63 100644
--- a/cache.h
+++ b/cache.h
@@ -1637,7 +1637,6 @@ extern int odb_mkstemp(struct strbuf *template, const char *pattern);
  */
 extern int odb_pack_keep(const char *name);
 
-extern void unuse_pack(struct pack_window **);
 extern void clear_delta_base_cache(void);
 extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
 
diff --git a/pack.c b/pack.c
index 85cb65558..93526ea7b 100644
--- a/pack.c
+++ b/pack.c
@@ -596,3 +596,12 @@ unsigned char *use_pack(struct packed_git *p,
 		*left = win->len - xsize_t(offset);
 	return win->base + offset;
 }
+
+void unuse_pack(struct pack_window **w_cursor)
+{
+	struct pack_window *w = *w_cursor;
+	if (w) {
+		w->inuse_cnt--;
+		*w_cursor = NULL;
+	}
+}
diff --git a/pack.h b/pack.h
index bf2b99bf9..3876e9ae6 100644
--- a/pack.h
+++ b/pack.h
@@ -149,5 +149,6 @@ extern void close_all_packs(void);
 extern int open_packed_git(struct packed_git *p);
 
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
+extern void unuse_pack(struct pack_window **);
 
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index 8f17a07e9..12501ef06 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -717,15 +717,6 @@ void *xmmap(void *start, size_t length,
 	return ret;
 }
 
-void unuse_pack(struct pack_window **w_cursor)
-{
-	struct pack_window *w = *w_cursor;
-	if (w) {
-		w->inuse_cnt--;
-		*w_cursor = NULL;
-	}
-}
-
 static struct packed_git *alloc_packed_git(int extra)
 {
 	struct packed_git *p = xmalloc(st_add(sizeof(*p), extra));
-- 
2.14.0.434.g98096fd7a8-goog

