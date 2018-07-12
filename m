Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D05C51F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732229AbeGLTvM (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:51:12 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44456 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbeGLTvL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:51:11 -0400
Received: by mail-qt0-f196.google.com with SMTP id b15-v6so25153689qtp.11
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=brTBFYSj4e0oUXJmZ3O9Wj5Y7iJ4+2dvwm78//q5nkE=;
        b=QVgMRGlczvub/sNZz7/8ZvE22XcDEJ/rCrIcuOXFdR2A4reaYZpIvxoM8VxSoVagsK
         swqNncHdgZQqQSmzOobZ4k6GRn9kG4IRxdS1x9JHve4KyN1Gqwg41Q9IbObwvuO01rr6
         fUgBwSxLT5bKGPSeGfloR7leu01bgJn+Jfy00E6dJulqVu+FdyY8hS39X613GmgRCTzq
         8OxYNbJR8+mn2f5l/CF+OulDXqbxK0nJVObgBPt/q7z4d+P/bEHcMP8ueQkcd1U4nBbr
         gn3dXeX7n2DvJqFiPmqMgRggrWdBOZd+HiFrCzx7bp+3nrOx3xdPxdWd8Lcv/Rt6gGug
         MAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=brTBFYSj4e0oUXJmZ3O9Wj5Y7iJ4+2dvwm78//q5nkE=;
        b=b5Oi70+Je6fJZs45oHKdOwVb1tAdnOM9VWV9RppmHVuZlYPqL2W2GsHGad2kAurGtz
         t1KY1sR7r4JdBQ8d2zokiO2nPNSqY6XN8NOAerofpEycI55V7u6VU/jZqDk/M4E1jIqa
         +Rb0vP+tvcLxKjHeUFfwSvOYBqI4zK6U0oAj0SiAl8vMmBalkMEkrhVgfQoZRHBwn4cP
         8VekAgRTcVwqZIVAQXv0badqflk9/cVzN7FHe3ZSVemLI0Vn9QtGvbzYEdfHIVUXQFT6
         ZkU9qf88pf6J/1EF69x7fCx1j4ehG+Z+/K/02sP2VTNSHdUglkyh0bMAhFesbuKYPpZa
         wAUg==
X-Gm-Message-State: AOUpUlHlijOJCWzUr0usrbXXuErARjrh29xii2+CtDEbUUrBknjUz1Nb
        NEHDaJufDaPcNUtoPLxov/kJrsNAodA=
X-Google-Smtp-Source: AAOMgpdG7SX9uMX6jteey6au7smWDvcI/74cittftAXopeRzX7kfiRgvXcXmfcL7zURL+I/1zw/qBA==
X-Received: by 2002:ac8:3f0a:: with SMTP id c10-v6mr3130514qtk.162.1531424411018;
        Thu, 12 Jul 2018 12:40:11 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id j5-v6sm14247756qte.57.2018.07.12.12.40.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 12:40:10 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, dstolee@microsoft.com
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v4 04/23] multi-pack-index: add 'write' verb
Date:   Thu, 12 Jul 2018 15:39:21 -0400
Message-Id: <20180712193940.21065-5-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180712193940.21065-1-dstolee@microsoft.com>
References: <20180706005321.124643-1-dstolee@microsoft.com>
 <20180712193940.21065-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In anticipation of writing multi-pack-indexes, add a skeleton
'git multi-pack-index write' subcommand and send the options to a
write_midx_file() method. Also create a skeleton test script that
tests the 'write' subcommand.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-multi-pack-index.txt | 22 +++++++++++++++++++++-
 Makefile                               |  1 +
 builtin/multi-pack-index.c             | 17 +++++++++++++++--
 midx.c                                 |  7 +++++++
 midx.h                                 |  6 ++++++
 t/t5319-multi-pack-index.sh            | 10 ++++++++++
 6 files changed, 60 insertions(+), 3 deletions(-)
 create mode 100644 midx.c
 create mode 100644 midx.h
 create mode 100755 t/t5319-multi-pack-index.sh

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index ec9982cbfc..a62af1caca 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -9,7 +9,7 @@ git-multi-pack-index - Write and verify multi-pack-indexes
 SYNOPSIS
 --------
 [verse]
-'git multi-pack-index' [--object-dir=<dir>]
+'git multi-pack-index' [--object-dir=<dir>] <verb>
 
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
+* Write a MIDX file for the packfiles in an alternate object store.
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
index 3161ddae86..6a7aa00cf2 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -2,9 +2,10 @@
 #include "cache.h"
 #include "config.h"
 #include "parse-options.h"
+#include "midx.h"
 
 static char const * const builtin_multi_pack_index_usage[] = {
-	N_("git multi-pack-index [--object-dir=<dir>]"),
+	N_("git multi-pack-index [--object-dir=<dir>] write"),
 	NULL
 };
 
@@ -30,5 +31,17 @@ int cmd_multi_pack_index(int argc, const char **argv,
 	if (!opts.object_dir)
 		opts.object_dir = get_object_directory();
 
-	return 0;
+	if (argc == 0)
+		goto usage;
+
+	if (!strcmp(argv[0], "write")) {
+		if (argc > 1)
+			goto usage;
+
+		return write_midx_file(opts.object_dir);
+	}
+
+usage:
+	usage_with_options(builtin_multi_pack_index_usage,
+			   builtin_multi_pack_index_options);
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

