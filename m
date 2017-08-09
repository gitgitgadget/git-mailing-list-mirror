Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F364E20899
	for <e@80x24.org>; Wed,  9 Aug 2017 01:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbdHIBYD (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 21:24:03 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36151 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752432AbdHIBXP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 21:23:15 -0400
Received: by mail-pg0-f48.google.com with SMTP id v77so21518664pgb.3
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 18:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=hKzyYAnxrs3k18UV3jqnCiSja1LZvXOM6yKqGoSHhZA=;
        b=S4PJS+wePpK+F4yP4PmDy18fVipXPzUQcxeX1U04bTO7+Gg0kI566muiGDCr9IOjpb
         eZ1ts4No9HPmsgIFh2LlFNN3X+p3r2Yn5112IDWFMGRwV0P5EUvHsRI0wu3MjNmMau3E
         02Y71JPBEuSv8pIULP6UbSjtCIgMbYTNBrBc6m6LHKl+TN151CgtjPc9ToPaRc6u4ywt
         t3zrjPko89UDJ21fV4mqHxqoELsJd8aPYZOfBTQadflZWWFnmi6O+NO8R2PPlpWl4SxM
         sYIWJaQXIK4dw70rXy9x6KQlPsKTnr38gPfe35Lp+gLjKu6jE/dkMw6wA7kk/u2YwKZx
         DUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=hKzyYAnxrs3k18UV3jqnCiSja1LZvXOM6yKqGoSHhZA=;
        b=s4+hq7oWEK102GtSOU52UnT9P4Yp1e/UEZLF9R8Amyixe0aEuvbs8mqb6TnikCgUJp
         o6B9FakW8HGR9OLu8J5xPaHAlisVvnDsNrAHpwY0DzthQO610xxLDXmTEekQO34xNKr0
         ndzK5anyhgW7M8CFL0jpniDD2hAIj4BwBQaAQ7ZqutAUquIV1Hw2ZmewWdDrmWu87iux
         coKfpt4xKBMA3E3uhBLygkcgbl51tN12Vo5UKqabDJFu9nGNK/NktcdBIxmLXn8ebW8I
         ZVftYcYTUL4INTUPT0Fn1zHrhGX0Enm5gaN15flEDD9E9SlKd+WBexAaAvYePGfJ9LJb
         GbcA==
X-Gm-Message-State: AHYfb5iZcRhwI1pKoz7jMwqLq9aQ4fMWjJKf9WYy/QByLP4lTtUBp5BY
        LJbV8+Z2pnZIR9aSKtkzKw==
X-Received: by 10.98.224.150 with SMTP id d22mr6380487pfm.268.1502241794047;
        Tue, 08 Aug 2017 18:23:14 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id r5sm4479602pgn.45.2017.08.08.18.23.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 18:23:13 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 10/25] pack: move install_packed_git()
Date:   Tue,  8 Aug 2017 18:22:42 -0700
Message-Id: <8404ee74341b02e4e800c09badb410c24e088b79.1502241234.git.jonathantanmy@google.com>
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
 cache.h     |  1 -
 pack.h      |  4 ++--
 packfile.c  | 11 ++++++++++-
 sha1_file.c |  9 ---------
 4 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/cache.h b/cache.h
index bf93477e8..41562dc0b 100644
--- a/cache.h
+++ b/cache.h
@@ -1611,7 +1611,6 @@ extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
 extern void prepare_packed_git(void);
 extern void reprepare_packed_git(void);
-extern void install_packed_git(struct packed_git *pack);
 
 /*
  * Give a rough count of objects in the repository. This sacrifices accuracy
diff --git a/pack.h b/pack.h
index c1f3ff32d..576c4fc7c 100644
--- a/pack.h
+++ b/pack.h
@@ -124,8 +124,6 @@ extern char *sha1_pack_name(const unsigned char *sha1);
  */
 extern char *sha1_pack_index_name(const unsigned char *sha1);
 
-extern unsigned int pack_open_fds;
-
 extern void pack_report(void);
 
 /*
@@ -152,4 +150,6 @@ extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t
 extern void unuse_pack(struct pack_window **);
 extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
 
+extern void install_packed_git(struct packed_git *pack);
+
 #endif
diff --git a/packfile.c b/packfile.c
index efe0ed3e8..4eb65e460 100644
--- a/packfile.c
+++ b/packfile.c
@@ -28,7 +28,7 @@ static unsigned int pack_used_ctr;
 static unsigned int pack_mmap_calls;
 static unsigned int peak_pack_open_windows;
 static unsigned int pack_open_windows;
-unsigned int pack_open_fds;
+static unsigned int pack_open_fds;
 static unsigned int pack_max_fds;
 static size_t peak_pack_mapped;
 static size_t pack_mapped;
@@ -658,3 +658,12 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 		hashclr(p->sha1);
 	return p;
 }
+
+void install_packed_git(struct packed_git *pack)
+{
+	if (pack->pack_fd != -1)
+		pack_open_fds++;
+
+	pack->next = packed_git;
+	packed_git = pack;
+}
diff --git a/sha1_file.c b/sha1_file.c
index 7f12b1ee0..b956ca0c9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -717,15 +717,6 @@ void *xmmap(void *start, size_t length,
 	return ret;
 }
 
-void install_packed_git(struct packed_git *pack)
-{
-	if (pack->pack_fd != -1)
-		pack_open_fds++;
-
-	pack->next = packed_git;
-	packed_git = pack;
-}
-
 void (*report_garbage)(unsigned seen_bits, const char *path);
 
 static void report_helper(const struct string_list *list,
-- 
2.14.0.434.g98096fd7a8-goog

