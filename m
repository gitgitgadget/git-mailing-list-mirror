Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AE8C2D0CD
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36A7206E0
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azgu1Vnd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfLPPsO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:48:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44599 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbfLPPsM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 10:48:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id q10so7833539wrm.11
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 07:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KA5j4LtwpCjFs4/8owngf7Wk8TZUNENof/E9MKDmQ7M=;
        b=azgu1VndGR2vslbCV32OdR4Ybj3deU9cXmaBtt5ry+SBM8fWfl18qk/FVk4Ku4/hoH
         yK4UFeFZ+uk0nEANzkAvIPlYmmAddER13TNX+TSQnknBCVIaMqTSJQdY24hlDcdiy0Cn
         EtvcPnxe4VO1HHlHIu3Vja/YIj4rvYzMJf5Q6hmwqYVJiNukhKCKV8GjUFHUk2DDSFgM
         6FKbBAPujwOCSwacR2926l4Kejva19VQAveGJUf407dbGw5w7MiqnoJz9lt2nqNc34++
         Wfc6ThIdeU6H0jFY/vkm/TY3lUexEiizZIwYATQBYk9LQaiDd0SZkXBgyGXmPXB33vS5
         qeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KA5j4LtwpCjFs4/8owngf7Wk8TZUNENof/E9MKDmQ7M=;
        b=ciMEIzrR+zq9Py3pVBcwPou7d27XpjRaXG4yF48G3lCuI3yDEmiM7yVfF6jfzQdi/D
         TAUv6n4roTp5MJOdD1O2egSi4a0DD+XtTGARdf49I87b67NUrYFXoRDTNGgm2bcVnjDU
         xdxp/Q8XojIZ2nIoMagddZNXg+RAbPouu89N/W2fZYactzkYBLonx2QEimZ6tGblI9Or
         9MhYOMNOa0OWy9JkvPZYjJ95dSHfDapJ/OU5/TQM2z5yesHAUZZ7G3AREvlkKc0NgZR9
         x9UytwaFrH6qe2ZHq9hB2OHbsLrCaI4+yu1ghQqE8R32SXGnoCsJWJKSzJSZ0pH9GGI0
         V1mw==
X-Gm-Message-State: APjAAAXDGv2CkvIzgwv0Auoh0auedttKxELlA1zKMg+ECVQfEEQNLwQD
        IvJhtnY0xAnGNAerkeKetTzf82YY
X-Google-Smtp-Source: APXvYqziKk56p+tTfKHcLM7B41HSrYSk7h/mYoYJpyxumCOtcrbQuP6qysAxAQayR1vGcnfSsmfBMw==
X-Received: by 2002:adf:e6cb:: with SMTP id y11mr31750592wrm.345.1576511288704;
        Mon, 16 Dec 2019 07:48:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t8sm21980286wrp.69.2019.12.16.07.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 07:48:08 -0800 (PST)
Message-Id: <8d5fb9f40b8fc766ef022f910529e6308d9c2d80.1576511287.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
        <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Dec 2019 15:47:49 +0000
Subject: [PATCH v2 01/18] t7107, t7526: directly test parse_pathspec_file()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

In my previous patches, `parse_pathspec_file()` was tested indirectly by
invoking `git reset` and `git commit` with properly crafted inputs. This
has some disadvantages:
1) A number of tests are copy&pasted for every command where
   `--pathspec-from-file` is supported. With just two commands, it
   wasn't too bad, but I'm going to extend support to many more
   commands, which would make a handful of low-value tests.
2) Tests are located in suboptimal test packages
3) Tests are indirect

Fix this by testing `parse_pathspec_file()` directly via a new test
helper.

While working on it, I also noticed that quotes testing via
`"\"file\\101.t\""` was somewhat incorrect: I escaped `\` one time while
I had to escape it two times! Tests still worked due to `"` which
prevented pathspec from matching files.

Fix this by properly escaping one more time.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Makefile                            |  1 +
 t/helper/test-parse-pathspec-file.c | 34 +++++++++++
 t/helper/test-tool.c                |  1 +
 t/helper/test-tool.h                |  1 +
 t/t0067-parse_pathspec_file.sh      | 89 +++++++++++++++++++++++++++
 t/t7107-reset-pathspec-file.sh      | 94 +++--------------------------
 t/t7526-commit-pathspec-file.sh     | 70 +--------------------
 7 files changed, 136 insertions(+), 154 deletions(-)
 create mode 100644 t/helper/test-parse-pathspec-file.c
 create mode 100755 t/t0067-parse_pathspec_file.sh

diff --git a/Makefile b/Makefile
index b7d7374dac..fd7bcaac9c 100644
--- a/Makefile
+++ b/Makefile
@@ -721,6 +721,7 @@ TEST_BUILTINS_OBJS += test-mktemp.o
 TEST_BUILTINS_OBJS += test-oidmap.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-parse-options.o
+TEST_BUILTINS_OBJS += test-parse-pathspec-file.o
 TEST_BUILTINS_OBJS += test-path-utils.o
 TEST_BUILTINS_OBJS += test-pkt-line.o
 TEST_BUILTINS_OBJS += test-prio-queue.o
diff --git a/t/helper/test-parse-pathspec-file.c b/t/helper/test-parse-pathspec-file.c
new file mode 100644
index 0000000000..e7f525feb9
--- /dev/null
+++ b/t/helper/test-parse-pathspec-file.c
@@ -0,0 +1,34 @@
+#include "test-tool.h"
+#include "parse-options.h"
+#include "pathspec.h"
+#include "gettext.h"
+
+int cmd__parse_pathspec_file(int argc, const char **argv)
+{
+	struct pathspec pathspec;
+	const char *pathspec_from_file = 0;
+	int pathspec_file_nul = 0, i;
+
+	static const char *const usage[] = {
+		"test-tool parse-pathspec-file --pathspec-from-file [--pathspec-file-nul]",
+		NULL
+	};
+
+	struct option options[] = {
+		OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
+		OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
+		OPT_END()
+	};
+
+	parse_options(argc, argv, 0, options, usage, 0);
+
+	parse_pathspec_file(&pathspec, 0, 0, 0, pathspec_from_file,
+			    pathspec_file_nul);
+
+	for (i = 0; i < pathspec.nr; i++) {
+		printf("%s\n", pathspec.items[i].original);
+	}
+
+	clear_pathspec(&pathspec);
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index f20989d449..c9a232d238 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -39,6 +39,7 @@ static struct test_cmd cmds[] = {
 	{ "oidmap", cmd__oidmap },
 	{ "online-cpus", cmd__online_cpus },
 	{ "parse-options", cmd__parse_options },
+	{ "parse-pathspec-file", cmd__parse_pathspec_file },
 	{ "path-utils", cmd__path_utils },
 	{ "pkt-line", cmd__pkt_line },
 	{ "prio-queue", cmd__prio_queue },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 8ed2af71d1..c8549fd87f 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -29,6 +29,7 @@ int cmd__mktemp(int argc, const char **argv);
 int cmd__oidmap(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
 int cmd__parse_options(int argc, const char **argv);
+int cmd__parse_pathspec_file(int argc, const char** argv);
 int cmd__path_utils(int argc, const char **argv);
 int cmd__pkt_line(int argc, const char **argv);
 int cmd__prio_queue(int argc, const char **argv);
diff --git a/t/t0067-parse_pathspec_file.sh b/t/t0067-parse_pathspec_file.sh
new file mode 100755
index 0000000000..df7b319713
--- /dev/null
+++ b/t/t0067-parse_pathspec_file.sh
@@ -0,0 +1,89 @@
+#!/bin/sh
+
+test_description='Test parse_pathspec_file()'
+
+. ./test-lib.sh
+
+test_expect_success 'one item from stdin' '
+	echo fileA.t | test-tool parse-pathspec-file --pathspec-from-file=- >actual &&
+
+	cat >expect <<-\EOF &&
+	fileA.t
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'one item from file' '
+	echo fileA.t >list &&
+	test-tool parse-pathspec-file --pathspec-from-file=list >actual &&
+
+	cat >expect <<-\EOF &&
+	fileA.t
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'NUL delimiters' '
+	printf "fileA.t\0fileB.t\0" | test-tool parse-pathspec-file --pathspec-from-file=- --pathspec-file-nul >actual &&
+
+	cat >expect <<-\EOF &&
+	fileA.t
+	fileB.t
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'LF delimiters' '
+	printf "fileA.t\nfileB.t\n" | test-tool parse-pathspec-file --pathspec-from-file=- >actual &&
+
+	cat >expect <<-\EOF &&
+	fileA.t
+	fileB.t
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'no trailing delimiter' '
+	printf "fileA.t\nfileB.t" | test-tool parse-pathspec-file --pathspec-from-file=- >actual &&
+
+	cat >expect <<-\EOF &&
+	fileA.t
+	fileB.t
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'CRLF delimiters' '
+	printf "fileA.t\r\nfileB.t\r\n" | test-tool parse-pathspec-file --pathspec-from-file=- >actual &&
+
+	cat >expect <<-\EOF &&
+	fileA.t
+	fileB.t
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'quotes' '
+	# shell  takes \\\\101 and spits \\101
+	# printf takes   \\101 and spits  \101
+	# git    takes    \101 and spits     A
+	printf "\"file\\\\101.t\"" | test-tool parse-pathspec-file --pathspec-from-file=- >actual &&
+
+	cat >expect <<-\EOF &&
+	fileA.t
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--pathspec-file-nul takes quotes literally' '
+	# shell  takes \\\\101 and spits \\101
+	# printf takes   \\101 and spits  \101
+	printf "\"file\\\\101.t\"" | test-tool parse-pathspec-file --pathspec-from-file=- --pathspec-file-nul >actual &&
+
+	cat >expect <<-\EOF &&
+	"file\101.t"
+	EOF
+	test_cmp expect actual
+'
+
+test_done
diff --git a/t/t7107-reset-pathspec-file.sh b/t/t7107-reset-pathspec-file.sh
index 6b1a731fff..f36fce27b9 100755
--- a/t/t7107-reset-pathspec-file.sh
+++ b/t/t7107-reset-pathspec-file.sh
@@ -25,7 +25,7 @@ verify_expect () {
 	test_cmp expect actual
 }
 
-test_expect_success '--pathspec-from-file from stdin' '
+test_expect_success 'simplest' '
 	restore_checkpoint &&
 
 	git rm fileA.t &&
@@ -37,20 +37,7 @@ test_expect_success '--pathspec-from-file from stdin' '
 	verify_expect
 '
 
-test_expect_success '--pathspec-from-file from file' '
-	restore_checkpoint &&
-
-	git rm fileA.t &&
-	echo fileA.t >list &&
-	git reset --pathspec-from-file=list &&
-
-	cat >expect <<-\EOF &&
-	 D fileA.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'NUL delimiters' '
+test_expect_success '--pathspec-file-nul' '
 	restore_checkpoint &&
 
 	git rm fileA.t fileB.t &&
@@ -63,71 +50,21 @@ test_expect_success 'NUL delimiters' '
 	verify_expect
 '
 
-test_expect_success 'LF delimiters' '
-	restore_checkpoint &&
-
-	git rm fileA.t fileB.t &&
-	printf "fileA.t\nfileB.t\n" | git reset --pathspec-from-file=- &&
-
-	cat >expect <<-\EOF &&
-	 D fileA.t
-	 D fileB.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'no trailing delimiter' '
-	restore_checkpoint &&
-
-	git rm fileA.t fileB.t &&
-	printf "fileA.t\nfileB.t" | git reset --pathspec-from-file=- &&
-
-	cat >expect <<-\EOF &&
-	 D fileA.t
-	 D fileB.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'CRLF delimiters' '
+test_expect_success 'only touches what was listed' '
 	restore_checkpoint &&
 
-	git rm fileA.t fileB.t &&
-	printf "fileA.t\r\nfileB.t\r\n" | git reset --pathspec-from-file=- &&
+	git rm fileA.t fileB.t fileC.t fileD.t &&
+	printf "fileB.t\nfileC.t\n" | git reset --pathspec-from-file=- &&
 
 	cat >expect <<-\EOF &&
-	 D fileA.t
+	D  fileA.t
 	 D fileB.t
+	 D fileC.t
+	D  fileD.t
 	EOF
 	verify_expect
 '
 
-test_expect_success 'quotes' '
-	restore_checkpoint &&
-
-	git rm fileA.t &&
-	printf "\"file\\101.t\"" | git reset --pathspec-from-file=- &&
-
-	cat >expect <<-\EOF &&
-	 D fileA.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'quotes not compatible with --pathspec-file-nul' '
-	restore_checkpoint &&
-
-	git rm fileA.t &&
-	printf "\"file\\101.t\"" >list &&
-	# Note: "git reset" has not yet learned to fail on wrong pathspecs
-	git reset --pathspec-from-file=list --pathspec-file-nul &&
-
-	cat >expect <<-\EOF &&
-	 D fileA.t
-	EOF
-	test_must_fail verify_expect
-'
-
 test_expect_success '--pathspec-from-file is not compatible with --soft or --hard' '
 	restore_checkpoint &&
 
@@ -137,19 +74,4 @@ test_expect_success '--pathspec-from-file is not compatible with --soft or --har
 	test_must_fail git reset --hard --pathspec-from-file=list
 '
 
-test_expect_success 'only touches what was listed' '
-	restore_checkpoint &&
-
-	git rm fileA.t fileB.t fileC.t fileD.t &&
-	printf "fileB.t\nfileC.t\n" | git reset --pathspec-from-file=- &&
-
-	cat >expect <<-\EOF &&
-	D  fileA.t
-	 D fileB.t
-	 D fileC.t
-	D  fileD.t
-	EOF
-	verify_expect
-'
-
 test_done
diff --git a/t/t7526-commit-pathspec-file.sh b/t/t7526-commit-pathspec-file.sh
index a06b683534..4e592f7472 100755
--- a/t/t7526-commit-pathspec-file.sh
+++ b/t/t7526-commit-pathspec-file.sh
@@ -26,7 +26,7 @@ verify_expect () {
 	test_cmp expect actual
 }
 
-test_expect_success '--pathspec-from-file from stdin' '
+test_expect_success 'simplest' '
 	restore_checkpoint &&
 
 	echo fileA.t | git commit --pathspec-from-file=- -m "Commit" &&
@@ -37,19 +37,7 @@ test_expect_success '--pathspec-from-file from stdin' '
 	verify_expect
 '
 
-test_expect_success '--pathspec-from-file from file' '
-	restore_checkpoint &&
-
-	echo fileA.t >list &&
-	git commit --pathspec-from-file=list -m "Commit" &&
-
-	cat >expect <<-\EOF &&
-	A	fileA.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'NUL delimiters' '
+test_expect_success '--pathspec-file-nul' '
 	restore_checkpoint &&
 
 	printf "fileA.t\0fileB.t\0" | git commit --pathspec-from-file=- --pathspec-file-nul -m "Commit" &&
@@ -61,60 +49,6 @@ test_expect_success 'NUL delimiters' '
 	verify_expect
 '
 
-test_expect_success 'LF delimiters' '
-	restore_checkpoint &&
-
-	printf "fileA.t\nfileB.t\n" | git commit --pathspec-from-file=- -m "Commit" &&
-
-	cat >expect <<-\EOF &&
-	A	fileA.t
-	A	fileB.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'no trailing delimiter' '
-	restore_checkpoint &&
-
-	printf "fileA.t\nfileB.t" | git commit --pathspec-from-file=- -m "Commit" &&
-
-	cat >expect <<-\EOF &&
-	A	fileA.t
-	A	fileB.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'CRLF delimiters' '
-	restore_checkpoint &&
-
-	printf "fileA.t\r\nfileB.t\r\n" | git commit --pathspec-from-file=- -m "Commit" &&
-
-	cat >expect <<-\EOF &&
-	A	fileA.t
-	A	fileB.t
-	EOF
-	verify_expect
-'
-
-test_expect_success 'quotes' '
-	restore_checkpoint &&
-
-	printf "\"file\\101.t\"" | git commit --pathspec-from-file=- -m "Commit" &&
-
-	cat >expect <<-\EOF &&
-	A	fileA.t
-	EOF
-	verify_expect expect
-'
-
-test_expect_success 'quotes not compatible with --pathspec-file-nul' '
-	restore_checkpoint &&
-
-	printf "\"file\\101.t\"" >list &&
-	test_must_fail git commit --pathspec-from-file=list --pathspec-file-nul -m "Commit"
-'
-
 test_expect_success 'only touches what was listed' '
 	restore_checkpoint &&
 
-- 
gitgitgadget

