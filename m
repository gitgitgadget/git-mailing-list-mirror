Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA23C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 17:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5A820722
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 17:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyEKEye+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfL3Rmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 12:42:33 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32989 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfL3Rmc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 12:42:32 -0500
Received: by mail-ed1-f67.google.com with SMTP id r21so33288218edq.0
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 09:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MVifjPyNtyIEO1E8Kyg6CewUd/DrW7g7hQw/HN3IuNI=;
        b=LyEKEye+k1WLcx5mDlVjCezxE0PCe2UGW95LE+6de4j23xMlntavRCl2an5C4WfIas
         f8rWFOWFThSwshueIXKozbw8zqwLZ9Vhw/ruLSMIjmOKaKqB/jixzwO0jyU695kzaapT
         6Ick/Qb3oiqgD4TZpjuW8Msa4IINMmSL82RQr5nlp4BBAYj9ynU7LwfhnVPoDTOZ20O7
         MthwbcPorwaeyi26SwgAJ+YsRHOoOOoWnlTLIiID0kw+YT9NxqQFnPbxmb7MRqDMljtL
         fSZjlOfNN/hx4Kjfwn0J+0j9FVxjch5ufyN47NXV7JpDIqrg/7YqjqexH/0bMlU4wYXZ
         yvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MVifjPyNtyIEO1E8Kyg6CewUd/DrW7g7hQw/HN3IuNI=;
        b=pQ9toLHKu0Kuz+sKrpeww3X0Fh6w9R37U1U4Rj1P4g/v00Ch1dSVZoFsu+x6Cl3JV6
         xQzQQZrQprzU6mynlaqdO7Y1+lkDBA2zDvDZjFZprSvk6yF+FRuCrFu2q3XWjeZtu7dL
         doU9H+wUG8FZanLhmMt+JKptiiQyyl+fwR152liOT+XGKLB+M7N8YtQlyFVfzcjHMRtJ
         O/ZsvevlYSJd+tlIY/PzGkPBbJa0Lh9fVZGypQjxbHLiHxl4BnzfCgEDvPpyDFiDhZHh
         EfmMwVO+ofK2xsdHSH8yI9lQuCxvwgI3iAHLkNQhgV9zBBvmw4w67gfHcQq5PczUObHh
         xthQ==
X-Gm-Message-State: APjAAAXkKPYrTJ0TQogAlroAxVYH+S4XPm7quQfm8CD533a7eAAL+/0m
        pS0QlZHLGzNnc1coudkbrv95sITh
X-Google-Smtp-Source: APXvYqwSPgajQBXD/n4FfgKeQMjNNsb92duD4WL4kFKRxk54UhvHxc4hVHs0Vf3Q4kgr/GFejpE+kA==
X-Received: by 2002:a17:906:4f93:: with SMTP id o19mr71279721eju.52.1577727749713;
        Mon, 30 Dec 2019 09:42:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g9sm5683584ejd.66.2019.12.30.09.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 09:42:29 -0800 (PST)
Message-Id: <27383a5b084b5e68152b08eb96fb4ddaf6d87f82.1577727747.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.503.git.1577727747.gitgitgadget@gmail.com>
References: <pull.503.git.1577727747.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Dec 2019 17:42:26 +0000
Subject: [PATCH 2/3] t: directly test parse_pathspec_file()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Previously, `parse_pathspec_file()` was tested indirectly by invoking
git commands with properly crafted inputs. As demonstrated by the
previous bugfix, testing complicated black boxes indirectly can lead to
tests that silently test the wrong thing.

Introduce direct tests for `parse_pathspec_file()`.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Makefile                            |  1 +
 t/helper/test-parse-pathspec-file.c | 34 +++++++++++
 t/helper/test-tool.c                |  1 +
 t/helper/test-tool.h                |  1 +
 t/t0067-parse_pathspec_file.sh      | 89 +++++++++++++++++++++++++++++
 5 files changed, 126 insertions(+)
 create mode 100644 t/helper/test-parse-pathspec-file.c
 create mode 100755 t/t0067-parse_pathspec_file.sh

diff --git a/Makefile b/Makefile
index 09f98b777c..0061f96e8a 100644
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
-- 
gitgitgadget

