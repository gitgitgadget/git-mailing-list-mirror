Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 723DF208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751660AbdHRWVC (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:21:02 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:37604 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdHRWUz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:20:55 -0400
Received: by mail-pg0-f48.google.com with SMTP id y129so72155693pgy.4
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 15:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Ny/VslKlaCWeJNFzGY2MKZXHzVzavay9lF5jebiqhpE=;
        b=f4098uVfGgJB2ZFl+LB88thtKGRmbxxZDAWt4S8i+rkQudGmuyuXCnjuHRMSNQpcaK
         K20cpuUZQzZNvQi14LhpeWzCiZEYgIfyodczpVvf2iyDWa4hECh5uM3D7u+0ruOAfY4j
         6iVsAprBbQ/B/ZHCtnP2w5ov8/aI1Scxz2YR2lM+2KXlKrpE1Mbl+j8aIUFAPAxoFsfk
         HxyQV6T8mMhntcmt8c60j9ozccrtA3kq8XqVObRx4mLIKaoyzYO/PRrk9EpPgpchiEeq
         3Ti4SnTeshquA3ioQlV+3GiNsNHy0a4plhuuAvT2AcdANYxX2rd0/iMo3EhQbbK/SK5P
         r0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Ny/VslKlaCWeJNFzGY2MKZXHzVzavay9lF5jebiqhpE=;
        b=n1ZhBNfZJTd2OncCwMRYyBPchB4gKs1dZ6RKOYgC/n3JTH5kxL3q/tT3i55+ZLPUM6
         65flEZp5xAoDZAjhcEf/+f05vgt8ze8lXpGVRRypWyrOmaDE/3ZHH+P2SNN1+4aZix1P
         /nCHwP4nUpwDf/Qs/MZ5BRS/Y7qgQI9zLjw/QzsxvKSrqSUCms2PYf42GXVOXIHc7KaV
         H/kUHQJYIWpNcbkdRU2jOYRy6lBWHNno5yPu4+0L1PYpQs70xRz771gIH3j8+jnkQlsc
         w68xSV4887g+SDzIIFOITwMG9aJMjictRFAKx3k3E3QP3M00QLLxqxzAGYZzX1hz4O7A
         kX/w==
X-Gm-Message-State: AHYfb5hLO/yU+SJyz694V5CBtKkUdKdN7bckD6vK0OpDHisj9oAZ/b72
        0PUwxW519NaKEUHw0CvQuA==
X-Received: by 10.84.133.37 with SMTP id 34mr11445196plf.221.1503094854266;
        Fri, 18 Aug 2017 15:20:54 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id w123sm12544006pfb.60.2017.08.18.15.20.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 15:20:53 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 08/23] pack: move unuse_pack()
Date:   Fri, 18 Aug 2017 15:20:23 -0700
Message-Id: <072dadfc10df6aa3b61095cd31b814d130e148fb.1503094448.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1503094448.git.jonathantanmy@google.com>
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1503094448.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h     | 1 -
 packfile.c  | 9 +++++++++
 packfile.h  | 1 +
 sha1_file.c | 9 ---------
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index a27018210..0313b0b8d 100644
--- a/cache.h
+++ b/cache.h
@@ -1645,7 +1645,6 @@ extern int odb_mkstemp(struct strbuf *template, const char *pattern);
  */
 extern int odb_pack_keep(const char *name);
 
-extern void unuse_pack(struct pack_window **);
 extern void clear_delta_base_cache(void);
 extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
 
diff --git a/packfile.c b/packfile.c
index ea451d27e..0c97c3a1a 100644
--- a/packfile.c
+++ b/packfile.c
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
diff --git a/packfile.h b/packfile.h
index 97cfc5e70..b5db490ab 100644
--- a/packfile.h
+++ b/packfile.h
@@ -45,6 +45,7 @@ extern void close_pack_index(struct packed_git *);
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, size_t *);
 extern void close_pack_windows(struct packed_git *);
 extern void close_all_packs(void);
+extern void unuse_pack(struct pack_window **);
 
 extern void release_pack_memory(size_t);
 
diff --git a/sha1_file.c b/sha1_file.c
index 7704801d1..84d96d0ab 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -718,15 +718,6 @@ void *xmmap(void *start, size_t length,
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
2.14.1.480.gb18f417b89-goog

