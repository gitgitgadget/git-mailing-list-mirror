Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64D691F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 00:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753801AbeGFAxh (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 20:53:37 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39713 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753537AbeGFAxe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 20:53:34 -0400
Received: by mail-qt0-f193.google.com with SMTP id q12-v6so8711389qtp.6
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 17:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E8XFtFxSvgrw+gV/TUxAoIhR5X7uhYMpRYikcFzrp+g=;
        b=aPpn8FOQb8zDGbtmZ+ovZ80HSLdzUvRaLQIZqyCOnEK9MPRQ3UwCzauz8a0U3XZLHM
         MJ6ALMpuHvAY879GoukDUl26DHe1UWeaZQXhuWD1SjwhhPquDwfo5CSsBhXV66RHy/ZI
         SCAwybG6wSDe7VGX4Qimgwp0d2CmB8Mv/ugUDaHGXL/GHACVy2obzJF7FWir1rei7rjG
         35E0gYa9IX9HkZw0ClCLYlfr/DopuzCMCfSl9mBeyXhiX8Dk1hWYNOWMQe5f/HoTlADr
         Sp0qAY2PM5hYd3z/fgRl1RpDblzD97XI0xYxKGLPXx/AdDBFN0oJl0J8Wo5pAFXcQ42X
         Detg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E8XFtFxSvgrw+gV/TUxAoIhR5X7uhYMpRYikcFzrp+g=;
        b=cAFfdyH+uauXJ0oR3yUdulUYrnKVBu6lwd2ChZG2nUGSvnKTMcuE0G9XpErNFsNM0d
         vq6z6eIHfG8dxoD0quCt1y5Lr6fDfBJ9jcWXdu/zr0kzkc2N3z2qHrZCYBvQQyF8d1N0
         K/gRyaVsL/hg6pK1DttgWxs+nkLBLW+sJZLfRH6WtZMHZGiQ3KlNTWzyDh66BEXMWvnx
         0HhBizey+Aa8owYG8z/XzXC4AmarJOp319GxclA+4UjdA0O/dJj1u40eBid4LmbCrAZc
         SltbQlhvD0AIcfxpD3AnG0fLIAdxTCu9D1y2sP4aPuD3frBVd+08DTIyCMhkmtErdDOv
         1x2A==
X-Gm-Message-State: APt69E0PXnktKmk8XjCaFVgliDGa50VsF1cpHLEoqOS/nzaHr2BX4NnW
        7iWs488HqJ57kTTUJBVutW/sWPm7
X-Google-Smtp-Source: AAOMgpd4HltbMaM9jmZUzzDZb6TXuh56n31ni/v+kDNKIz3U9nAbInyR97BRlLTzkodc+uTgSSX2Lg==
X-Received: by 2002:ac8:16ee:: with SMTP id y43-v6mr7605744qtk.148.1530838413448;
        Thu, 05 Jul 2018 17:53:33 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u25-v6sm4882791qku.3.2018.07.05.17.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 17:53:32 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: [PATCH v3 04/24] multi-pack-index: add 'write' verb
Date:   Thu,  5 Jul 2018 20:53:01 -0400
Message-Id: <20180706005321.124643-5-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180706005321.124643-1-dstolee@microsoft.com>
References: <20180625143434.89044-1-dstolee@microsoft.com>
 <20180706005321.124643-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In anticipation of writing multi-pack-indexes, add a
'git multi-pack-index write' subcommand and send the options to a
write_midx_file() method. Also create a basic test file that tests
the 'write' subcommand.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-multi-pack-index.txt | 22 +++++++++++++++++++++-
 Makefile                               |  1 +
 builtin/multi-pack-index.c             | 10 +++++++++-
 midx.c                                 |  7 +++++++
 midx.h                                 |  6 ++++++
 t/t5319-multi-pack-index.sh            | 10 ++++++++++
 6 files changed, 54 insertions(+), 2 deletions(-)
 create mode 100644 midx.c
 create mode 100644 midx.h
 create mode 100755 t/t5319-multi-pack-index.sh

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index a83c0496a6..be97c9372e 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -9,7 +9,7 @@ git-multi-pack-index - Write and verify multi-pack-indexes
 SYNOPSIS
 --------
 [verse]
-'git multi-pack-index' [--object-dir <dir>]
+'git multi-pack-index' [--object-dir <dir>] <verb>
 
 DESCRIPTION
 -----------
@@ -23,6 +23,26 @@ OPTIONS
 	`<dir>/packs/multi-pack-index` for the current MIDX file, and
 	`<dir>/packs` for the pack-files to index.
 
+write::
+	When given as the verb, write a new MIDX file to
+	`<dir>/packs/multi-pack-index`.
+
+
+EXAMPLES
+--------
+
+* Write a MIDX file for the packfiles in the current .git folder.
++
+-----------------------------------------------
+$ git multi-pack-index write
+-----------------------------------------------
+
+* Write a MIDX file for the packfiles in an alternate.
++
+-----------------------------------------------
+$ git multi-pack-index --object-dir <alt> write
+-----------------------------------------------
+
 
 SEE ALSO
 --------
diff --git a/Makefile b/Makefile
index 54610875ec..f5636c711d 100644
--- a/Makefile
+++ b/Makefile
@@ -890,6 +890,7 @@ LIB_OBJS += merge.o
 LIB_OBJS += merge-blobs.o
 LIB_OBJS += merge-recursive.o
 LIB_OBJS += mergesort.o
+LIB_OBJS += midx.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += notes.o
 LIB_OBJS += notes-cache.o
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 4853291477..14b32e1373 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -2,9 +2,10 @@
 #include "cache.h"
 #include "config.h"
 #include "parse-options.h"
+#include "midx.h"
 
 static char const * const builtin_multi_pack_index_usage[] = {
-	N_("git multi-pack-index [--object-dir <dir>]"),
+	N_("git multi-pack-index [--object-dir <dir>] [write]"),
 	NULL
 };
 
@@ -34,5 +35,12 @@ int cmd_multi_pack_index(int argc, const char **argv,
 	if (!opts.object_dir)
 		opts.object_dir = get_object_directory();
 
+	if (argc == 0)
+		usage_with_options(builtin_multi_pack_index_usage,
+				   builtin_multi_pack_index_options);
+
+	if (!strcmp(argv[0], "write"))
+		return write_midx_file(opts.object_dir);
+
 	return 0;
 }
diff --git a/midx.c b/midx.c
new file mode 100644
index 0000000000..32468db1a2
--- /dev/null
+++ b/midx.c
@@ -0,0 +1,7 @@
+#include "cache.h"
+#include "midx.h"
+
+int write_midx_file(const char *object_dir)
+{
+	return 0;
+}
diff --git a/midx.h b/midx.h
new file mode 100644
index 0000000000..dbdbe9f873
--- /dev/null
+++ b/midx.h
@@ -0,0 +1,6 @@
+#ifndef __MIDX_H__
+#define __MIDX_H__
+
+int write_midx_file(const char *object_dir);
+
+#endif
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
new file mode 100755
index 0000000000..ec3ddbe79c
--- /dev/null
+++ b/t/t5319-multi-pack-index.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+
+test_description='multi-pack-indexes'
+. ./test-lib.sh
+
+test_expect_success 'write midx with no packs' '
+	git multi-pack-index --object-dir=. write
+'
+
+test_done
-- 
2.18.0.118.gd4f65b8d14

