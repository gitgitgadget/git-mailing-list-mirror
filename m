Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11D0C76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 07:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjDKHnj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 03:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjDKHnE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 03:43:04 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CABE40D4
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:38 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 60-20020a17090a09c200b0023fcc8ce113so9983727pjo.4
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681198957; x=1683790957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcomLW3U9EfUA+BAqXJ0OixNRNWkUrbHqyRY8UwXpzk=;
        b=mXKFoEnPfiMwWu63hg5LV98l4elDf2Zkqbtsu7bR1POql+ciYd2Yc50IaZCWQhp0VY
         8KnXf6aZ4gpAoRz0s5SZFPAdNaBD8dXMhwabEChpBhK+V9b0rNFp1xTwLJQGQ62BB1dF
         1uWOo7hvzYTqE9gHhQzT3gSqtPZ+GJ3EbustH09Fr6mxIlLUPhvxRXRBDSzK7rn0QrS4
         upWfHXzkOxLu9ttDQP/3wAaGbxeLIlA+SwFJH1TfRum8qshwv7pVpsCR2zAOk8jcKrSW
         /WgDmTZTu6cLcdHltqWcvDKtgc/EO7It760G5q614paNHAwG4Fn7QgVlDjpHEx3QUw9Q
         ioOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681198957; x=1683790957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcomLW3U9EfUA+BAqXJ0OixNRNWkUrbHqyRY8UwXpzk=;
        b=Yb8WnjPleqrXYbzbJjy6BrJDl0llkwOMTViPv7GLo5MPvzQtSbpMw+3Urv5ETqI5FQ
         Xd3KqKZqikye8BBS/xzGcyEkdJSXJXVk4wE35o3FoJvnmU/B7qm5e7uSl69aHLCetpKj
         qcoFpVY4RzHcvu/TG67rcS0XbU4gqvoDk9Z6ga7d6sl2DMZlcmNvul3J+UdS4Q/8NFa/
         XQmkk5j+P53SpvYFZooeYfBeQ3D4pIqm1KM+b11FBDmtGh3/zPJbIMOiokH49bMsBmCa
         SMC2S3CqGuyssmn9VkV6SBehizZkowxtOsz1+5Bp+6Svtpqg+rsPiDEpWirXPqHf6N19
         8fzA==
X-Gm-Message-State: AAQBX9evG4J7ljiQ0NgEKIPyvczCBXve9GFMzGKLVtPvK17DV15GscOm
        CZ7ObiScNcSj1hJJp4nnlZv5U2bKkqo=
X-Google-Smtp-Source: AKy350Yv4B1/Tj/n8vvGd3yP7KKC1A0K5Pxw5I8T9kJmla55gaA1H08JKqAoEovp+EMmqLk9AOigAA==
X-Received: by 2002:a17:903:1108:b0:19a:96ea:3850 with SMTP id n8-20020a170903110800b0019a96ea3850mr14992941plh.17.1681198956883;
        Tue, 11 Apr 2023 00:42:36 -0700 (PDT)
Received: from iron-rod.hsd1.ca.comcast.net ([2601:646:9e80:a0b0::f6a9])
        by smtp.gmail.com with ESMTPSA id az4-20020a170902a58400b001a1deff606fsm8992820plb.125.2023.04.11.00.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 00:42:36 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Calvin Wan <calvinwan@google.com>
Subject: [PATCH v3 22/23] treewide: reduce includes of cache.h in other headers
Date:   Tue, 11 Apr 2023 00:42:03 -0700
Message-Id: <20230411074204.3024420-17-newren@gmail.com>
X-Mailer: git-send-email 2.40.0.172.g72fe1174621
In-Reply-To: <20230411074204.3024420-1-newren@gmail.com>
References: <pull.1509.v3.git.1681182060.gitgitgadget@gmail.com>
 <20230411074204.3024420-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We had a handful of headers including cache.h that didn't need to
anymore.  Drop those includes and replace them with includes of
smaller files, or forward declarations.  However, note that two .c
files now need to directly include cache.h, though they should have
been including it all along given they are directly using structs
defined in it.

Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Calvin Wan <calvinwan@google.com>
---
 archive.h        | 2 +-
 chdir-notify.c   | 3 ++-
 quote.c          | 3 ++-
 refs/ref-cache.h | 2 +-
 rerere.c         | 2 +-
 resolve-undo.h   | 7 ++++++-
 revision.c       | 2 +-
 split-index.h    | 2 +-
 8 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/archive.h b/archive.h
index f96839ef383..3a4bdfbd078 100644
--- a/archive.h
+++ b/archive.h
@@ -1,9 +1,9 @@
 #ifndef ARCHIVE_H
 #define ARCHIVE_H
 
-#include "cache.h"
 #include "object-name.h"
 #include "pathspec.h"
+#include "string-list.h"
 
 struct repository;
 struct pretty_print_context;
diff --git a/chdir-notify.c b/chdir-notify.c
index 8e38cd6f3ae..0d7bc046074 100644
--- a/chdir-notify.c
+++ b/chdir-notify.c
@@ -1,7 +1,8 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "chdir-notify.h"
 #include "list.h"
+#include "path.h"
 #include "strbuf.h"
 #include "trace.h"
 
diff --git a/quote.c b/quote.c
index 7ccb5a06cd1..43c739671ed 100644
--- a/quote.c
+++ b/quote.c
@@ -1,5 +1,6 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
+#include "path.h"
 #include "quote.h"
 #include "strbuf.h"
 #include "strvec.h"
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index 850d9d3744e..cf4ad9070b9 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -1,7 +1,7 @@
 #ifndef REFS_REF_CACHE_H
 #define REFS_REF_CACHE_H
 
-#include "cache.h"
+#include "hash.h"
 
 struct ref_dir;
 struct ref_store;
diff --git a/rerere.c b/rerere.c
index 093c0f6f993..7abc94bf444 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "abspath.h"
 #include "alloc.h"
 #include "config.h"
diff --git a/resolve-undo.h b/resolve-undo.h
index 2b3f0f901e6..d1ea9727712 100644
--- a/resolve-undo.h
+++ b/resolve-undo.h
@@ -1,7 +1,12 @@
 #ifndef RESOLVE_UNDO_H
 #define RESOLVE_UNDO_H
 
-#include "cache.h"
+struct cache_entry;
+struct index_state;
+struct pathspec;
+struct string_list;
+
+#include "hash.h"
 
 struct resolve_undo_info {
 	unsigned int mode[3];
diff --git a/revision.c b/revision.c
index 3d86e07abb8..43f88eaf56c 100644
--- a/revision.c
+++ b/revision.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "alloc.h"
 #include "config.h"
 #include "environment.h"
diff --git a/split-index.h b/split-index.h
index 7a435ca2c97..1a153f47ba3 100644
--- a/split-index.h
+++ b/split-index.h
@@ -1,7 +1,7 @@
 #ifndef SPLIT_INDEX_H
 #define SPLIT_INDEX_H
 
-#include "cache.h"
+#include "hash.h"
 
 struct index_state;
 struct strbuf;
-- 
2.40.0.172.g72fe1174621

