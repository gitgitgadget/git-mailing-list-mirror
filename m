Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB51DC77B6F
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 07:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjDKHmt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 03:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjDKHma (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 03:42:30 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E8D3C11
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:22 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id nh20-20020a17090b365400b0024496d637e1so12430503pjb.5
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681198941; x=1683790941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0Y4QEw41vJGTs0AOOEd+pzjL/F0oMfxDoezacg+c8s=;
        b=nJwc6mAN/yhiCLad+ni4USoLO3clp2ZUUAMckFv8VsNjQ1bXfvfOEqWfDMmmyEUo0p
         z7+shBEmP8M4xBPBL9+fWc5ZasciIHNJV96K1vHThbefTk/NxM1CvQI3X4vWFcKt8HQt
         NGMSo3zD2UC6HqOA/z+6rim6eylXgKs+m2r42QoPbVVnrxsfoUasxvNLK69alo+oQpyZ
         xqjvzKjq3lxbm/ZT2TxwAwtM561lxwusDLxTmLhPUG7b6XiPvggXNIChm2KdBrNnaaT9
         u3sDXlEDmJdQJ//dfwzH/I9oG2s0gcpQhTu5TzoWO/TF7+/1XHU1JdkvUa6IOiq0SzE3
         2iCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681198941; x=1683790941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0Y4QEw41vJGTs0AOOEd+pzjL/F0oMfxDoezacg+c8s=;
        b=wzRGTdmMUe1ZP3UjQ3jtPvFFiWMFTp4To9aIp29ITZwkY8DSQeStbQQZQGnw2rkmcY
         dPlly6Jzaay4+sl3gUaRHoJNbWRM763+fbPYhGbQ9GM90RTZeJwuxx7VV+0k2PGP06ZZ
         G3niRNbIHKtZ1EEODDTEbo3fae8oADVFvxZ8VMFBno7EiivnFLoU21huLk9YZydtkILV
         S0t7GERKdsIuiTs+sQpKZnJ6p/SHmmeBh678OgmgRkSTYYq1TqRcFlRaNAQINneA8JWX
         UQFrbsY2xD0i70Rf/ggmpuyLstKiwAkNMoRA6UgCTdT07TF1aAL86GNuS1VkWHwK9/no
         Kf7A==
X-Gm-Message-State: AAQBX9d8hOUyt7gcqJ+Hnhe+GlboJQGUnDX3+EyH5xMgT71OOzYyDfOV
        LYxHgIm5xtDlprLbcHbs8DfwaWBiOFs=
X-Google-Smtp-Source: AKy350bHFBsSIx1X1IOVPIv3/L1x7U+tL6+uj6fZYIruqEIVPJFYzvWptDEFru3kiMoh8mIepVt26Q==
X-Received: by 2002:a17:90b:4f4d:b0:246:a782:d94 with SMTP id pj13-20020a17090b4f4d00b00246a7820d94mr2627767pjb.7.1681198941413;
        Tue, 11 Apr 2023 00:42:21 -0700 (PDT)
Received: from iron-rod.hsd1.ca.comcast.net ([2601:646:9e80:a0b0::f6a9])
        by smtp.gmail.com with ESMTPSA id az4-20020a170902a58400b001a1deff606fsm8992820plb.125.2023.04.11.00.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 00:42:20 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Calvin Wan <calvinwan@google.com>
Subject: [PATCH v3 13/23] treewide: remove cache.h inclusion due to object-file.h changes
Date:   Tue, 11 Apr 2023 00:41:54 -0700
Message-Id: <20230411074204.3024420-8-newren@gmail.com>
X-Mailer: git-send-email 2.40.0.172.g72fe1174621
In-Reply-To: <20230411074204.3024420-1-newren@gmail.com>
References: <pull.1509.v3.git.1681182060.gitgitgadget@gmail.com>
 <20230411074204.3024420-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Calvin Wan <calvinwan@google.com>
---
 bulk-checkin.c  | 2 +-
 commit-graph.c  | 2 +-
 http-fetch.c    | 2 +-
 http-walker.c   | 2 +-
 http.h          | 1 -
 notes-merge.c   | 2 +-
 pack-bitmap.c   | 2 +-
 pack-check.c    | 2 +-
 pack-mtimes.c   | 2 +-
 pack-revindex.c | 2 +-
 streaming.c     | 2 +-
 tmp-objdir.c    | 2 +-
 12 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index af15f8a9af4..9192298db6a 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -1,7 +1,7 @@
 /*
  * Copyright (c) 2011, Google Inc.
  */
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "bulk-checkin.h"
 #include "environment.h"
diff --git a/commit-graph.c b/commit-graph.c
index c20e73ceebf..0c4f2266445 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/http-fetch.c b/http-fetch.c
index c874d3402dd..fffda592670 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "exec-cmd.h"
 #include "gettext.h"
diff --git a/http-walker.c b/http-walker.c
index 4588e6a340a..3b41f5654b3 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "repository.h"
 #include "commit.h"
 #include "hex.h"
diff --git a/http.h b/http.h
index 783b2b09b8b..3a409bccd4e 100644
--- a/http.h
+++ b/http.h
@@ -3,7 +3,6 @@
 
 struct packed_git;
 
-#include "cache.h"
 #include "git-zlib.h"
 
 #include <curl/curl.h>
diff --git a/notes-merge.c b/notes-merge.c
index cc9538ac5c0..233e49e3195 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "advice.h"
 #include "commit.h"
 #include "gettext.h"
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 1371f17d22f..48fc2ec76de 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "commit.h"
 #include "gettext.h"
diff --git a/pack-check.c b/pack-check.c
index 40d88bc5ebe..049f2f0bfc0 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "environment.h"
 #include "hex.h"
 #include "repository.h"
diff --git a/pack-mtimes.c b/pack-mtimes.c
index 0096ace080b..020a37f8fe3 100644
--- a/pack-mtimes.c
+++ b/pack-mtimes.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "gettext.h"
 #include "pack-mtimes.h"
 #include "object-file.h"
diff --git a/pack-revindex.c b/pack-revindex.c
index 22a1958a1fc..4d9bb41b4db 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "gettext.h"
 #include "pack-revindex.h"
 #include "object-file.h"
diff --git a/streaming.c b/streaming.c
index b3415724ee4..21e39585e89 100644
--- a/streaming.c
+++ b/streaming.c
@@ -1,7 +1,7 @@
 /*
  * Copyright (c) 2011, Google Inc.
  */
-#include "cache.h"
+#include "git-compat-util.h"
 #include "convert.h"
 #include "environment.h"
 #include "streaming.h"
diff --git a/tmp-objdir.c b/tmp-objdir.c
index fff7ff42db7..c33a554f921 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "tmp-objdir.h"
 #include "abspath.h"
 #include "chdir-notify.h"
-- 
2.40.0.172.g72fe1174621

