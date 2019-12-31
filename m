Return-Path: <SRS0=sBbF=2V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D786FC2D0C2
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 10:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E672206D9
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 10:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3wFgS47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfLaKPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Dec 2019 05:15:18 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40563 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfLaKPS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Dec 2019 05:15:18 -0500
Received: by mail-ed1-f65.google.com with SMTP id b8so34924341edx.7
        for <git@vger.kernel.org>; Tue, 31 Dec 2019 02:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=By11ZhLNpGOJE7ks9nGpRahw14cn6l0tXfvSE8ofCmk=;
        b=F3wFgS47kINKg8okhGCRD6ol7d6QU4wCYcA9T4sfm6F4yx5Scd2CydGyXwaWGlPydm
         vt1JCBh0TbSTYSMg8AvQKwexN0NW9VMNbFOuuRm7ivN3UkIjfrM5DvyR0M4YSse6fZrv
         fOz29P9zeHaXrr0PJWLLI5XYO1VsP62w/XAyWlx4/BTv1t3vn2go+GSsFtkcFcXUlPM2
         L1nxT03mrAP6tt8ZCd/Ug4FQ43c0nD+Nbm5zFqCvqvnUT7wXM0PS6ExSEebbIvbIqidP
         XL3t3jAJXqdih9E1LtGDQiYJm5MeEl8xVV8htgGu0AUnGCIXs0MPtDjmO/OtAoK4IFyN
         k0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=By11ZhLNpGOJE7ks9nGpRahw14cn6l0tXfvSE8ofCmk=;
        b=XBPWq0XX7+MU8zdMNpyHhzGZHQbITxNOM5QKaHAHUV8+OEydT/MMcR+MhkBff7/MTj
         PuWrN8A4TDUbkvcJms5dFRhuTJxFYiqcRrW1AM9/ua62wlo/3ofplYu8tIgvMqLVCxiN
         6nIp69BXrNhjZRZGr+nm/vypY5yx9WWvbOtbZ9i2Yp1ccImIFxMtV77HXbN3Ih9X4z/X
         59pvXLySe7t3TzIiUDlRrBLEMCeIBW1omIWQSN5sRDD3cof6U/ascBeVog4WYQ3z7iHs
         IEivLYjwvfceWo3oW/v2seVDbsD7XVepGF0BLQA/xQnMi8QyAxg3mZfijRVCrknTQwdd
         Co/g==
X-Gm-Message-State: APjAAAVDdugYYcMK2plvCrhh9JGQNTyBkWP9QUusaoBZ6zXf/6o6eyaM
        MMyfSgKJ2pyUqY/MYRbL2hSadQtC
X-Google-Smtp-Source: APXvYqxn03O1IWnxnt1Yuvx2cy9orGDkiS8/TR7TRFZ5lJwJYkjR/M36SVSXudV4EV1dDx1vreTXCg==
X-Received: by 2002:a17:906:4f93:: with SMTP id o19mr75172509eju.52.1577787315985;
        Tue, 31 Dec 2019 02:15:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l26sm6011509ejr.23.2019.12.31.02.15.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Dec 2019 02:15:15 -0800 (PST)
Message-Id: <8748f3baf1d92f2e642c529ba3856714f847a468.1577787313.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.503.v4.git.1577787313.gitgitgadget@gmail.com>
References: <pull.503.v3.git.1577786032.gitgitgadget@gmail.com>
        <pull.503.v4.git.1577787313.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Dec 2019 10:15:12 +0000
Subject: [PATCH v4 2/3] t: directly test parse_pathspec_file()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
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
 Makefile                            |   1 +
 t/helper/test-parse-pathspec-file.c |  33 +++++++++
 t/helper/test-tool.c                |   1 +
 t/helper/test-tool.h                |   1 +
 t/t0067-parse_pathspec_file.sh      | 108 ++++++++++++++++++++++++++++
 5 files changed, 144 insertions(+)
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
index 0000000000..02f4ccfd2a
--- /dev/null
+++ b/t/helper/test-parse-pathspec-file.c
@@ -0,0 +1,33 @@
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
+	for (i = 0; i < pathspec.nr; i++)
+		printf("%s\n", pathspec.items[i].original);
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
index 0000000000..7bab49f361
--- /dev/null
+++ b/t/t0067-parse_pathspec_file.sh
@@ -0,0 +1,108 @@
+#!/bin/sh
+
+test_description='Test parse_pathspec_file()'
+
+. ./test-lib.sh
+
+test_expect_success 'one item from stdin' '
+	cat >expect <<-\EOF &&
+	fileA.t
+	EOF
+
+	echo fileA.t |
+	test-tool parse-pathspec-file --pathspec-from-file=- >actual &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'one item from file' '
+	cat >expect <<-\EOF &&
+	fileA.t
+	EOF
+
+	echo fileA.t >list &&
+	test-tool parse-pathspec-file --pathspec-from-file=list >actual &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'NUL delimiters' '
+	cat >expect <<-\EOF &&
+	fileA.t
+	fileB.t
+	EOF
+
+	printf "fileA.t\0fileB.t\0" |
+	test-tool parse-pathspec-file --pathspec-from-file=- --pathspec-file-nul >actual &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'LF delimiters' '
+	cat >expect <<-\EOF &&
+	fileA.t
+	fileB.t
+	EOF
+
+	printf "fileA.t\nfileB.t\n" |
+	test-tool parse-pathspec-file --pathspec-from-file=- >actual &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'no trailing delimiter' '
+	cat >expect <<-\EOF &&
+	fileA.t
+	fileB.t
+	EOF
+
+	printf "fileA.t\nfileB.t" |
+	test-tool parse-pathspec-file --pathspec-from-file=- >actual &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'CRLF delimiters' '
+	cat >expect <<-\EOF &&
+	fileA.t
+	fileB.t
+	EOF
+
+	printf "fileA.t\r\nfileB.t\r\n" |
+	test-tool parse-pathspec-file --pathspec-from-file=- >actual &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'quotes' '
+	cat >expect <<-\EOF &&
+	fileA.t
+	EOF
+
+	cat >list <<-\EOF &&
+	"file\101.t"
+	EOF
+
+	test-tool parse-pathspec-file --pathspec-from-file=list >actual &&
+
+	test_cmp expect actual
+'
+
+test_expect_success '--pathspec-file-nul takes quotes literally' '
+	# Note: there is an extra newline because --pathspec-file-nul takes
+	# input \n literally, too
+	cat >expect <<-\EOF &&
+	"file\101.t"
+
+	EOF
+
+	cat >list <<-\EOF &&
+	"file\101.t"
+	EOF
+
+	test-tool parse-pathspec-file --pathspec-from-file=list --pathspec-file-nul >actual &&
+
+	test_cmp expect actual
+'
+
+test_done
-- 
gitgitgadget

