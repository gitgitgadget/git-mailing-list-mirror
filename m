Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 708A0208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbdHRWUw (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:20:52 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35661 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdHRWUs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:20:48 -0400
Received: by mail-pg0-f54.google.com with SMTP id q6so1091312pgs.2
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 15:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=QcjTYtNu7ww4t0vB+w1K/Twq3oXY5Lc70fpCa/ZyeQI=;
        b=U/3kD17BoW/YHhfQH2iqwDinFB4YOAsmnaoXaaojngSUnOEANJI0V3gO0+QhlkqViq
         Ctr+16O2DcxI/JCRGtZV/QSjv0yICJR60nfS/CmM+G6ehpToYLUkRzdyvzPZxs2Mreje
         gqM6o0SFPTcZiWq3kI8+yISAih8uHGl3i4MDLnH51z/jr/8LhrhDcKUfvkMt+1klLLAM
         xGzlKahDVxkBl3cPTlTKzAHmjSGZ3WPb1Kr6f6gsw+k7xlSy4VBWgS9cPsxHAK/Io5lZ
         q9TZEdWeyzs67KvyJeP0R9ssC/sBso5QSLWLyY/f2f1MAU37MtyAXsQ6C8I8HMR13Gcw
         MqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=QcjTYtNu7ww4t0vB+w1K/Twq3oXY5Lc70fpCa/ZyeQI=;
        b=HKk8PBzdRZRuG5JYpKZ62zb6Tvex6osLvCpeHp2JMGYRfTgNM3SmmDZDPl3XoZihm0
         gg7GOygKrJKGoTDFydETQi4kO9fbBP2WfJGKxvvI13ttgleoBntC5R0E7RzpoX999EAL
         4ai8KEa1weuM/XkM+dbgbaYsEs8NEezG7yjaGL275wyGubt0aRpd7TIgF9gsyI6EoBuL
         UJfLL5SQlxTpgaTUMvPkbS2FmpzbYrUZEsPEqRzZIypAMqNlGk/oFDraP55ajIrjZDpl
         F0NXa0Hec33PZWFObPuq2mYB4wDBFCJqKD5FnkS3KmhAdX7hw5kPA9VMMyM7bXlysout
         srxg==
X-Gm-Message-State: AHYfb5i2cbPoQNivRbODtSFUXiTqyEr8YibdX+2o+Cd/nRD1Xxm01Fi6
        UbQiCKjbbn6FMf7H1Y0r8A==
X-Received: by 10.84.208.236 with SMTP id c41mr11190709plj.244.1503094847409;
        Fri, 18 Aug 2017 15:20:47 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id w123sm12544006pfb.60.2017.08.18.15.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 15:20:46 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 02/23] pack: move static state variables
Date:   Fri, 18 Aug 2017 15:20:17 -0700
Message-Id: <46e6295fd5c651834a1ef8abc2c716e6c9ce8c3f.1503094448.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1503094448.git.jonathantanmy@google.com>
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1503094448.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

sha1_file.c declares some static variables that store packfile-related
state. Move them to packfile.c.

They are temporarily made global, but subsequent commits will restore
their scope back to static.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 packfile.c  | 14 ++++++++++++++
 packfile.h  |  9 +++++++++
 sha1_file.c | 13 -------------
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/packfile.c b/packfile.c
index 0d191dfd6..0f46e0617 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "mru.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *sha1,
@@ -21,3 +22,16 @@ char *sha1_pack_index_name(const unsigned char *sha1)
 	static struct strbuf buf = STRBUF_INIT;
 	return odb_pack_name(&buf, sha1, "idx");
 }
+
+unsigned int pack_used_ctr;
+unsigned int pack_mmap_calls;
+unsigned int peak_pack_open_windows;
+unsigned int pack_open_windows;
+unsigned int pack_open_fds;
+unsigned int pack_max_fds;
+size_t peak_pack_mapped;
+size_t pack_mapped;
+struct packed_git *packed_git;
+
+static struct mru packed_git_mru_storage;
+struct mru *packed_git_mru = &packed_git_mru_storage;
diff --git a/packfile.h b/packfile.h
index 3c4a0dbd7..a76bb7cec 100644
--- a/packfile.h
+++ b/packfile.h
@@ -24,4 +24,13 @@ extern char *sha1_pack_name(const unsigned char *sha1);
  */
 extern char *sha1_pack_index_name(const unsigned char *sha1);
 
+extern unsigned int pack_used_ctr;
+extern unsigned int pack_mmap_calls;
+extern unsigned int peak_pack_open_windows;
+extern unsigned int pack_open_windows;
+extern unsigned int pack_open_fds;
+extern unsigned int pack_max_fds;
+extern size_t peak_pack_mapped;
+extern size_t pack_mapped;
+
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index 6e7a20b52..2b5ce9959 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -683,19 +683,6 @@ static int has_loose_object(const unsigned char *sha1)
 	return check_and_freshen(sha1, 0);
 }
 
-static unsigned int pack_used_ctr;
-static unsigned int pack_mmap_calls;
-static unsigned int peak_pack_open_windows;
-static unsigned int pack_open_windows;
-static unsigned int pack_open_fds;
-static unsigned int pack_max_fds;
-static size_t peak_pack_mapped;
-static size_t pack_mapped;
-struct packed_git *packed_git;
-
-static struct mru packed_git_mru_storage;
-struct mru *packed_git_mru = &packed_git_mru_storage;
-
 void pack_report(void)
 {
 	fprintf(stderr,
-- 
2.14.1.480.gb18f417b89-goog

