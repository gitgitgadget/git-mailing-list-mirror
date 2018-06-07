Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C01811F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932857AbeFGODy (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:03:54 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42420 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932829AbeFGODt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:03:49 -0400
Received: by mail-qt0-f194.google.com with SMTP id y31-v6so9911063qty.9
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 07:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NptNEX/Gm4Umb67eOFhSZbm92io6asnJ08Bd3BzLMDA=;
        b=rNQ8k2cmDJvtijcWvk5DCCmoslae2QoGgUMRP60OYMQqP7m5tku+ICzMzVMmd1R2dR
         snvre+ehou1zgSYzPebPzFXSUmJiNlGaPwL7ZGXELcMShbnAgicQKIvr4maMiVCCIa1z
         3l1redhLdl/WCZdNsH9Gj/w3w4HWjSRM9xO6nBzjW9aWuqHDiEbVJ1JBzI0FZpk5Wy84
         vI6cZ0ALpYa9TniUBc+U5VnwZPGQWgXzHlNuWlFcK68de/uHHx18nxox6qvvEvTvrRYh
         m1wnf9W97TFakg3vYPR12LOt3d9k0/+nSOorIPlPOF7jqHno84kV4zFRM+MUHCJjxC6L
         2WcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NptNEX/Gm4Umb67eOFhSZbm92io6asnJ08Bd3BzLMDA=;
        b=rsUYaCHQcUhnK4BEsh/9rtOFTP0+SprxEQy/jG/LQi/FDWfYtuBWJIu45rJF0x8B87
         0gceDnrFq4FX6nUL0uF6P6kdNxjF88SCSeOTdhSvrAflDDDiFl/+ZsynmErUXedt9AWI
         cKOma3O0cQE07rtyVuJE8bTtv34l4q7ZdVCzlwfwu8X9/22v7osJhkIhyLCBn88kctJs
         pYUDS3anaIyJppVXbVVtr994HxSjq58CLyAOSfbl7OWlsASoyE6R9NOvGi7bpK9t2RLd
         TpW/h9lPL6SgXBfU2Qz1bDcsr67rxg31Q6KvOOX8crHNE00gGz6X965XPW0lF6hZE1kj
         BCFg==
X-Gm-Message-State: APt69E3ohxrSPklfyhJ7UuAWjVbgdADEyHoeZsdlkoQBNLhO9jVe6kNU
        lVz6SX1ErwTx7b9QA2T93rz2UjzI
X-Google-Smtp-Source: ADUXVKJU9DcwUk9BIoIUea0nzF3m+IizbB3HOA9Xd7UsH2/a1Mo4DzoummDeXOyUoA907slKW+yRhw==
X-Received: by 2002:a0c:8a5a:: with SMTP id 26-v6mr1789335qvu.192.1528380227414;
        Thu, 07 Jun 2018 07:03:47 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u74-v6sm12532763qku.55.2018.06.07.07.03.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:03:46 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, dstolee@microsoft.com, avarab@gmail.com,
        jrnieder@gmail.com, jonathantanmy@google.com, mfick@codeaurora.org
Subject: [PATCH 04/23] midx: add 'write' subcommand and basic wiring
Date:   Thu,  7 Jun 2018 10:03:19 -0400
Message-Id: <20180607140338.32440-5-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180607140338.32440-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In anticipation of writing multi-pack-indexes (MIDX files), add a
'git midx write' subcommand and send the options to a write_midx_file()
method. Also create a basic test file that tests the 'write' subcommand.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-midx.txt | 22 +++++++++++++++++++++-
 Makefile                   |  1 +
 builtin/midx.c             |  9 ++++++++-
 midx.c                     |  9 +++++++++
 midx.h                     |  4 ++++
 t/t5319-midx.sh            | 10 ++++++++++
 6 files changed, 53 insertions(+), 2 deletions(-)
 create mode 100644 midx.c
 create mode 100644 midx.h
 create mode 100755 t/t5319-midx.sh

diff --git a/Documentation/git-midx.txt b/Documentation/git-midx.txt
index 2bd886f1a2..dcaeb1a91b 100644
--- a/Documentation/git-midx.txt
+++ b/Documentation/git-midx.txt
@@ -9,7 +9,7 @@ git-midx - Write and verify multi-pack-indexes (MIDX files).
 SYNOPSIS
 --------
 [verse]
-'git midx' [--object-dir <dir>]
+'git midx' [--object-dir <dir>] <verb>
 
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
+-------------------------------------------
+$ git midx write
+-------------------------------------------
+
+* Write a MIDX file for the packfiles in an alternate.
++
+-------------------------------------------
+$ git midx --object-dir <alt> write
+-------------------------------------------
+
 
 GIT
 ---
diff --git a/Makefile b/Makefile
index 88958c7b42..aa86fcd8ec 100644
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
diff --git a/builtin/midx.c b/builtin/midx.c
index 59ea92178f..dc0a5acd3f 100644
--- a/builtin/midx.c
+++ b/builtin/midx.c
@@ -3,9 +3,10 @@
 #include "config.h"
 #include "git-compat-util.h"
 #include "parse-options.h"
+#include "midx.h"
 
 static char const * const builtin_midx_usage[] ={
-	N_("git midx [--object-dir <dir>]"),
+	N_("git midx [--object-dir <dir>] [write]"),
 	NULL
 };
 
@@ -34,5 +35,11 @@ int cmd_midx(int argc, const char **argv, const char *prefix)
 	if (!opts.object_dir)
 		opts.object_dir = get_object_directory();
 
+	if (argc == 0)
+		return 0;
+
+	if (!strcmp(argv[0], "write"))
+		return write_midx_file(opts.object_dir);
+
 	return 0;
 }
diff --git a/midx.c b/midx.c
new file mode 100644
index 0000000000..616af66b13
--- /dev/null
+++ b/midx.c
@@ -0,0 +1,9 @@
+#include "git-compat-util.h"
+#include "cache.h"
+#include "dir.h"
+#include "midx.h"
+
+int write_midx_file(const char *object_dir)
+{
+	return 0;
+}
diff --git a/midx.h b/midx.h
new file mode 100644
index 0000000000..3a63673952
--- /dev/null
+++ b/midx.h
@@ -0,0 +1,4 @@
+#include "cache.h"
+#include "packfile.h"
+
+int write_midx_file(const char *object_dir);
diff --git a/t/t5319-midx.sh b/t/t5319-midx.sh
new file mode 100755
index 0000000000..a590137af7
--- /dev/null
+++ b/t/t5319-midx.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+
+test_description='multi-pack-indexes'
+. ./test-lib.sh
+
+test_expect_success 'write midx with no pakcs' '
+	git midx --object-dir=. write
+'
+
+test_done
-- 
2.18.0.rc1

