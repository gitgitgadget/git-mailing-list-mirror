Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEFA41F516
	for <e@80x24.org>; Mon, 25 Jun 2018 14:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934434AbeFYOe6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 10:34:58 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45447 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934426AbeFYOe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 10:34:56 -0400
Received: by mail-qt0-f194.google.com with SMTP id i18-v6so12083581qtp.12
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 07:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NStlFOJS8nL1zXynDZeiYU5EqLvivNEOpVXeL1TDLQc=;
        b=aHOGzeYl33+neLMdZL4bIh/BtxXsp6OMbOIYwCxjL6pmbUTWjbcZwrqZbVLuPCrtCO
         FkcQOOw5RF53PlaspO2+6/YnsHhvB9O0nRHMW5QzfPf8RtIj63sZx6f1plyDn39PwvOv
         AWhptWGXTrWcbAvnhDASTDmXvxr3PV9SCxOZu+ok61fnCLiBNh4jTL47rYUi5IF7Hmr7
         eXeN1Tww9uIIR8fKkmulTs0G8Mca867F6swdzYjdgMCynTHupG+lSUaiQZgI24/DiBYn
         a4rKAkyF4V+ggW/U9s6vZu6ZL+gDUBiO8UZNjsmDpLDTW6vNVT/PcaoPmjdEx7v2UhJA
         gmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NStlFOJS8nL1zXynDZeiYU5EqLvivNEOpVXeL1TDLQc=;
        b=IrW7YKQYbqu5uTbnSROA+I0zpE5V4DT8WAI9XP+ikMe5Jy9RCFX7ZAU3QMpdhxvkyX
         ttGHhGq2ooaxXw9MJLSDshoM1udSFW6hUaAIt1LfVNqdUdZUrvH3huIOaDdN7DYihcKI
         peD5ILk1I80blsZtOJ2b1Z82cbKFjp9Ao1XDcALLs5vsCuGM8468MOH7zpWBW4FpZDYJ
         fGfZjUF5Txut9m09QaKgL9PF81NZ4P+ywyCQAOvTgrgXkHnKjXbu7AoFT9s/C0Gahr7x
         hxbvWC7b6TsrSoQRYNlMvjwcE3vWdYXmKYEiTrNd72EZfcfdpyoD4sQiEqrpZYtEElYa
         NvEQ==
X-Gm-Message-State: APt69E39wpay6u+f8KyW/sAWfuIk3me+fb7k8I3pJ0uO4Qac986xlKtq
        PDeNmcqLDCvqRmcUulO10qug8Wn9
X-Google-Smtp-Source: AAOMgpfKdSweARV1+sr6PmXxVogNq51R9b3tw8zqKFobtPESzQWg1wxL3Z4IhdZ8MZ8/YWIx5pr8zQ==
X-Received: by 2002:ac8:107:: with SMTP id e7-v6mr2747041qtg.119.1529937295332;
        Mon, 25 Jun 2018 07:34:55 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id w46-v6sm12821713qtw.55.2018.06.25.07.34.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 07:34:54 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 04/24] multi-pack-index: add 'write' verb
Date:   Mon, 25 Jun 2018 10:34:14 -0400
Message-Id: <20180625143434.89044-5-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180625143434.89044-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180625143434.89044-1-dstolee@microsoft.com>
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
index 9877f9c441..c4dc92ddd9 100644
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
 	<dir>/packs/multi-pack-index for the current MIDX file, and
 	<dir>/packs for the pack-files to index.
 
+write::
+	When given as the verb, write a new MIDX file to
+	<dir>/packs/multi-pack-index.
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
index f101873525..c8f1f19d1f 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -2,9 +2,10 @@
 #include "cache.h"
 #include "config.h"
 #include "parse-options.h"
+#include "midx.h"
 
 static char const * const builtin_multi_pack_index_usage[] ={
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
2.18.0.24.g1b579a2ee9

