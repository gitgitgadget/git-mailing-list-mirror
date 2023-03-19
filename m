Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CE9C76195
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 16:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjCSQ1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 12:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCSQ1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 12:27:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090EF1B573
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 09:27:23 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v1so2213840wrv.1
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 09:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679243242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFWxhwP9unSpWhnTIbTXFfQX8UvkA2GTyb9qvU+YibY=;
        b=UlF99bHVQX9XWUj1WWvYPSzrHpdFTL6sJk76ZgFLEr7qd5a85LCMOa0nT9HwlgUROV
         v+ui0tuaAIxfkvkoumCGngTSJnRopU8jqULBMLeizL1GImDRQlMYqJB/mvAmEGKCFfCj
         eDt/VN89GBOz11/qwczaoZQYR0h7eucbrMoVizewDGBgKVOkxXuXAHXxC3rF9d+KR/4S
         XWD2IyRXbnOXLF6A8DpOHIt8GP/zer9P0tBphXUjBJnXjXuKGTsQsQdCHbm7OH65Wn7k
         iw37xlY5TANel6m7qU4XehxYUBgI/f6qRINl32OI5TsAqMQZqcfY/zgLKnJKhdDs32nK
         UDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679243242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFWxhwP9unSpWhnTIbTXFfQX8UvkA2GTyb9qvU+YibY=;
        b=dLkmIv057rHeiccXx0s5cgax6LzFbMBpJDMBodX7ESm67AqTXFp2BVuxiqVmOwZJCO
         k+1wsYX4hnBtTqEAgeZo3Wnt3uLigqBHwJC4bUu+YG3rAiWwUtj84gLYuJ8oznYXeWMS
         VtbmD2JNkc59aLsMSrjuPda2QK2ml/J0Vlo8APsxK+b68mfTD1Z52WnXF83NScfJL5Gd
         hbvM3X+1+cqk7nU/Z6jCYCw4ghNhAmuQQ4luJyR9+zAL2+pbBChEeJKQnyjrklFz8iay
         oOVWHCZ6h3s+AaLKvaclO3oqDe4eDhDWaYrN2e0Oza3ku6nSVbAbVQUcy11es5OW8/c5
         FS6g==
X-Gm-Message-State: AO0yUKVwAFsqiRP0s9Fo1iVY4pnAk98n94FyOYNmy6cjm09jbfrAnRGt
        RaoCY3ArXSBavtlXB+osFKMPCZgDFsg=
X-Google-Smtp-Source: AK7set/5o+jZrzCwnoy7hgMFmZHfn9FlQy9CtQeKqD4OTcTXQhWMLlVdYFrvT9bWl90H07lmcQsoKw==
X-Received: by 2002:adf:d0cf:0:b0:2d1:86e6:bd6 with SMTP id z15-20020adfd0cf000000b002d186e60bd6mr9767972wrh.22.1679243242324;
        Sun, 19 Mar 2023 09:27:22 -0700 (PDT)
Received: from localhost (62-165-236-170.pool.digikabel.hu. [62.165.236.170])
        by smtp.gmail.com with ESMTPSA id d12-20020adffbcc000000b002c54e26bca5sm6886856wrs.49.2023.03.19.09.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 09:27:21 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/2] treewide: remove unnecessary inclusions of parse-options.h from headers
Date:   Sun, 19 Mar 2023 17:27:12 +0100
Message-Id: <20230319162712.654137-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.40.0.499.g88fa0b00d2
In-Reply-To: <20230319162712.654137-1-szeder.dev@gmail.com>
References: <20230319162712.654137-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The headers 'diagnose.h', 'list-objects-filter-options.h',
'ref-filter.h' and 'remote.h' declare option parsing callback
functions with a 'struct option*' parameter, and 'revision.h' declares
an option parsing helper function taking 'struct parse_opt_ctx_t*' and
'struct option*' parameters.  These headers all include
'parse-options.h', although they don't need any of the type
definitions from that header file.  Furthermore,
'list-objects-filter-options.h' and 'ref-filter.h' also define some
OPT_* macros to initialize a 'struct option', but these don't
necessitate the inclusion of parse-options.h in these headers either,
because these macros are only expanded in source files.

Remove these unnecessary inclusions of parse-options.h and use forward
declarations to declare the necessary types.

After this patch none of the header files include parse-options.h
anymore.

With these changes, the build time after modifying only
parse-options.h is reduced by about 30%, and the number of targets
built is almost 20% less:

  Before:

    $ touch parse-options.h && time make -j4 |wc -l
    353

    real    1m1.527s
    user    3m32.205s
    sys	    0m15.903s

  After:

    289

    real    0m39.285s
    user    2m12.540s
    sys     0m11.164s

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 diagnose.h                    | 3 ++-
 list-objects-filter-options.h | 3 ++-
 ref-filter.h                  | 2 +-
 remote.h                      | 2 +-
 revision.h                    | 3 ++-
 5 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/diagnose.h b/diagnose.h
index 7a4951a786..f525219ab0 100644
--- a/diagnose.h
+++ b/diagnose.h
@@ -2,7 +2,8 @@
 #define DIAGNOSE_H
 
 #include "strbuf.h"
-#include "parse-options.h"
+
+struct option;
 
 enum diagnose_mode {
 	DIAGNOSE_NONE,
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index ef03b45132..727c986122 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -2,10 +2,11 @@
 #define LIST_OBJECTS_FILTER_OPTIONS_H
 
 #include "object.h"
-#include "parse-options.h"
 #include "string-list.h"
 #include "strbuf.h"
 
+struct option;
+
 /*
  * The list of defined filters for list-objects.
  */
diff --git a/ref-filter.h b/ref-filter.h
index aa0eea4ecf..daa6d02017 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -4,7 +4,6 @@
 #include "oid-array.h"
 #include "refs.h"
 #include "commit.h"
-#include "parse-options.h"
 
 /* Quoting styles */
 #define QUOTE_NONE 0
@@ -24,6 +23,7 @@
 
 struct atom_value;
 struct ref_sorting;
+struct option;
 
 enum ref_sorting_order {
 	REF_SORTING_REVERSE = 1<<0,
diff --git a/remote.h b/remote.h
index 5b38ee20b8..73638cefeb 100644
--- a/remote.h
+++ b/remote.h
@@ -1,10 +1,10 @@
 #ifndef REMOTE_H
 #define REMOTE_H
 
-#include "parse-options.h"
 #include "hashmap.h"
 #include "refspec.h"
 
+struct option;
 struct transport_ls_refs_options;
 
 /**
diff --git a/revision.h b/revision.h
index ab71443696..649f817f39 100644
--- a/revision.h
+++ b/revision.h
@@ -2,7 +2,6 @@
 #define REVISION_H
 
 #include "commit.h"
-#include "parse-options.h"
 #include "grep.h"
 #include "notes.h"
 #include "pretty.h"
@@ -62,6 +61,8 @@ struct string_list;
 struct saved_parents;
 struct bloom_key;
 struct bloom_filter_settings;
+struct option;
+struct parse_opt_ctx_t;
 define_shared_commit_slab(revision_sources, char *);
 
 struct rev_cmdline_info {
-- 
2.40.0.499.g88fa0b00d2

