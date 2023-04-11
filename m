Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EE6C7619A
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 07:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjDKHni (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 03:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjDKHnE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 03:43:04 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D9D3AB0
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:37 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id la3so6883353plb.11
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681198955; x=1683790955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmiJilx7uuOUgo5p1MxFX7IbhyNujOJ+j+lpp6j3vyc=;
        b=PBDSMKbhVa4RVvLj9dHSZkW1XJp0gR8e8y1bdUeli2+2D1kSgA9hQB+2UaKdH1DTP4
         ZIIajRAih1WzyU48H2PxhqmI2JsIuBkx6yzzMofstSSdIPWddr7LcmA8VpXImpaksAmt
         H4fIB4Js0umg5N4T0DcD2Al4sOR4B8k5uQUxK7dV2G1G63/40FoFyawD7xqIeU1NlFB0
         gQ96j914tsncC0jFYONVRbSqHaWhObMEjKK28nGmu5x1XeNJ326b5AKeTmrKC7BVsJ66
         +os6JaicVBdSSz2tfCoX+34XIVK5nkyHnhFbNO17emK84eP9s/RcTSNbMK9rjKdi10g/
         +F2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681198955; x=1683790955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmiJilx7uuOUgo5p1MxFX7IbhyNujOJ+j+lpp6j3vyc=;
        b=xSP8eG4qIY1uPwRlUhay6h9voWdyvFqX+I+ltjnSPzqxBSiQgTDyC8wXh8NRMyCxwD
         BjY37nwQFMndV6+L4qcI60pA7Sz7YPRp3tBomHH3hCu3zqPULWHe9sO97MIvuGPZxuws
         3HXK18m9S97Zbio/Of2cGkkv46l5ci4Yrh2dTtUzynVvWH9KFQNAWAA8pKhJC/YPJsG2
         GGjiEyua1z/nHD9/fDN+mvnvvxXd5FqYpKCY9TCfW8IM7XSvaRBhE1t6XdczB2px5KvH
         058lK3ri/iCnWduKUxGXcT74MSBBBL7CKFY8Z6tR/FC4tEwL+xz866zRzOMTwbAlvfhX
         cvVg==
X-Gm-Message-State: AAQBX9fGWc5bmAMMqp6ZiUfYHIe2TmC4T6XAbbVC/JBJzVEuTHKcb1k8
        LaCtmOAyxNSXWk/ggKwg/7NzugPMVkU=
X-Google-Smtp-Source: AKy350YoR6RsDQ+FVmhaN5++gxoG079dyMeWxA+4X+bFM+aaEzoJWMKRjydoZ5+fUwSO+n73p4J+VA==
X-Received: by 2002:a05:6a20:299f:b0:db:1d43:18fe with SMTP id f31-20020a056a20299f00b000db1d4318femr13574648pzh.8.1681198955167;
        Tue, 11 Apr 2023 00:42:35 -0700 (PDT)
Received: from iron-rod.hsd1.ca.comcast.net ([2601:646:9e80:a0b0::f6a9])
        by smtp.gmail.com with ESMTPSA id az4-20020a170902a58400b001a1deff606fsm8992820plb.125.2023.04.11.00.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 00:42:34 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Calvin Wan <calvinwan@google.com>
Subject: [PATCH v3 21/23] treewide: remove double forward declaration of read_in_full
Date:   Tue, 11 Apr 2023 00:42:02 -0700
Message-Id: <20230411074204.3024420-16-newren@gmail.com>
X-Mailer: git-send-email 2.40.0.172.g72fe1174621
In-Reply-To: <20230411074204.3024420-1-newren@gmail.com>
References: <pull.1509.v3.git.1681182060.gitgitgadget@gmail.com>
 <20230411074204.3024420-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cache.h's nature of a dumping ground of includes prevented it from
being included in some compat/ files, forcing us into a workaround
of having a double forward declaration of the read_in_full() function
(see commit 14086b0a13 ("compat/pread.c: Add a forward declaration to
fix a warning", 2007-11-17)).  Now that we have moved functions like
read_in_full() from cache.h to wrapper.h, and wrapper.h isn't littered
with unrelated and scary #defines, get rid of the extra forward
declaration and just have compat/pread.c include wrapper.h.

Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Calvin Wan <calvinwan@google.com>
---
 builtin/clone.c       | 1 +
 bulk-checkin.c        | 1 +
 combine-diff.c        | 1 +
 compat/pread.c        | 1 +
 git-compat-util.h     | 6 ------
 grep.c                | 1 +
 pack-write.c          | 1 +
 path.c                | 1 +
 refs/packed-backend.c | 1 +
 send-pack.c           | 1 +
 setup.c               | 1 +
 upload-pack.c         | 1 +
 12 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index c7fdffb484c..4ed0a1d5aad 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -42,6 +42,7 @@
 #include "hook.h"
 #include "bundle.h"
 #include "bundle-uri.h"
+#include "wrapper.h"
 
 /*
  * Overall FIXMEs:
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 9192298db6a..d843279715c 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -17,6 +17,7 @@
 #include "packfile.h"
 #include "object-file.h"
 #include "object-store.h"
+#include "wrapper.h"
 
 static int odb_transaction_nesting;
 
diff --git a/combine-diff.c b/combine-diff.c
index cd5f39f22f4..f7e9fb57473 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -16,6 +16,7 @@
 #include "userdiff.h"
 #include "oid-array.h"
 #include "revision.h"
+#include "wrapper.h"
 
 static int compare_paths(const struct combine_diff_path *one,
 			  const struct diff_filespec *two)
diff --git a/compat/pread.c b/compat/pread.c
index 978cac4ec91..484e6d4c716 100644
--- a/compat/pread.c
+++ b/compat/pread.c
@@ -1,4 +1,5 @@
 #include "../git-compat-util.h"
+#include "../wrapper.h"
 
 ssize_t git_pread(int fd, void *buf, size_t count, off_t offset)
 {
diff --git a/git-compat-util.h b/git-compat-util.h
index 1e6592624d0..4fb771f42a5 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -859,12 +859,6 @@ int git_lstat(const char *, struct stat *);
 #define pread git_pread
 ssize_t git_pread(int fd, void *buf, size_t count, off_t offset);
 #endif
-/*
- * Forward decl that will remind us if its twin in cache.h changes.
- * This function is used in compat/pread.c.  But we can't include
- * cache.h there.
- */
-ssize_t read_in_full(int fd, void *buf, size_t count);
 
 #ifdef NO_SETENV
 #define setenv gitsetenv
diff --git a/grep.c b/grep.c
index bb8796a829f..d144b374894 100644
--- a/grep.c
+++ b/grep.c
@@ -11,6 +11,7 @@
 #include "commit.h"
 #include "quote.h"
 #include "help.h"
+#include "wrapper.h"
 
 static int grep_source_load(struct grep_source *gs);
 static int grep_source_is_binary(struct grep_source *gs,
diff --git a/pack-write.c b/pack-write.c
index d9b460fab4c..9c37121be31 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -10,6 +10,7 @@
 #include "oidmap.h"
 #include "pack-objects.h"
 #include "pack-revindex.h"
+#include "wrapper.h"
 
 void reset_pack_idx_option(struct pack_idx_option *opts)
 {
diff --git a/path.c b/path.c
index dff215ac693..7c1cd8182a8 100644
--- a/path.c
+++ b/path.c
@@ -18,6 +18,7 @@
 #include "object-store.h"
 #include "lockfile.h"
 #include "exec-cmd.h"
+#include "wrapper.h"
 
 static int get_st_mode_bits(const char *path, int *mode)
 {
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 1eba1015dd5..2333ed5a1f7 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -9,6 +9,7 @@
 #include "../iterator.h"
 #include "../lockfile.h"
 #include "../chdir-notify.h"
+#include "../wrapper.h"
 #include "../write-or-die.h"
 
 enum mmap_strategy {
diff --git a/send-pack.c b/send-pack.c
index 72ebb7b61ae..351037b07bc 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -14,6 +14,7 @@
 #include "quote.h"
 #include "transport.h"
 #include "version.h"
+#include "wrapper.h"
 #include "oid-array.h"
 #include "gpg-interface.h"
 #include "shallow.h"
diff --git a/setup.c b/setup.c
index a546da755f1..59abc16ba6d 100644
--- a/setup.c
+++ b/setup.c
@@ -12,6 +12,7 @@
 #include "promisor-remote.h"
 #include "quote.h"
 #include "trace2.h"
+#include "wrapper.h"
 
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
diff --git a/upload-pack.c b/upload-pack.c
index 0305fb2fbdc..e16dee783dd 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -32,6 +32,7 @@
 #include "commit-graph.h"
 #include "commit-reach.h"
 #include "shallow.h"
+#include "wrapper.h"
 #include "write-or-die.h"
 
 /* Remember to update object flag allocation in object.h */
-- 
2.40.0.172.g72fe1174621

