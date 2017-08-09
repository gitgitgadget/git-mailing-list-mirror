Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B58C320899
	for <e@80x24.org>; Wed,  9 Aug 2017 01:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752541AbdHIBXR (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 21:23:17 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:38012 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752356AbdHIBXM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 21:23:12 -0400
Received: by mail-pg0-f52.google.com with SMTP id l64so21492610pge.5
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 18:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=FRo+cEgU6F5kKXSL6BT82lMnESWQNINEH98RD5/HREg=;
        b=EqMdeFPFifY/ipCYAg1r/slPl5U+1UOrVVKMZo1qksVJldev/haj+K6XFjrYH4l0jS
         HOl3VcPtCZVQoNFteiGXxMlztNdxfwHzXig4PSa7zYfGOVGg2w7wNzWJYxU+ebuTiDBd
         alLCU2Rz2HVgCKV7BaF3YJcDscq9kKlGKnnIR53EE3R8vkLkZLanpZFnnOSH6SpG+dIS
         N/LcvpfWrN1XSV+HKindYdmkNcs76TPpu7Dm/BxZjeMwZZfPaILqtvemCaLwnf3zX839
         nfqucjm45kBIiNslU+00at0h9rxVaSr6uvfQJk1wsVaLd94oEKPsdMSnJqZU4Cyw/vIU
         plwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=FRo+cEgU6F5kKXSL6BT82lMnESWQNINEH98RD5/HREg=;
        b=DJiZqeZgDfYdNo3AejUC0HMyf9DgiM1VG6G09U0nre5m1uRkgIZWW4BvkrVaJJ2HCe
         pyT1U4+ivZvtPS/Bj9ZAyghdKsLSZRi7RgX08Jv2F2nIr4RPAvXCi90va9FapFBr9k7W
         b8ioXnR05cQJPKrmL1q3ciI8jxIqqc/qJfM07lWU7gGuNDp1aTQHUoq2D1Tb3jgj8zIk
         AVgWsZdAZIQDHxMqPlVIhcjVFQnFHwWKtrAN+mk2GcT6P0bMdQpboUiD/gtCJ1bpbXpa
         ERMAuAVKHH8DdaP+AfRgtK3rxWBQLasMLCc/tjfchup6rAREvEbqj7SF2N7l9Oui3yP2
         +55A==
X-Gm-Message-State: AHYfb5j4hLfSKW3WW9SAqlQoaS5hYskv5j+Guug0QfElz/OVx0L60/pd
        bPxJBoEW1QcVZMXD9UU37Q==
X-Received: by 10.101.75.131 with SMTP id t3mr5851020pgq.387.1502241791572;
        Tue, 08 Aug 2017 18:23:11 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id r5sm4479602pgn.45.2017.08.08.18.23.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 18:23:11 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 08/25] pack: move unuse_pack()
Date:   Tue,  8 Aug 2017 18:22:40 -0700
Message-Id: <3b0568343887b94981649afff996d0b18694d8a2.1502241234.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502241234.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1502241234.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h     | 1 -
 pack.h      | 1 +
 packfile.c  | 9 +++++++++
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
 
diff --git a/pack.h b/pack.h
index bf2b99bf9..3876e9ae6 100644
--- a/pack.h
+++ b/pack.h
@@ -149,5 +149,6 @@ extern void close_all_packs(void);
 extern int open_packed_git(struct packed_git *p);
 
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
+extern void unuse_pack(struct pack_window **);
 
 #endif
diff --git a/packfile.c b/packfile.c
index 85cb65558..93526ea7b 100644
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

