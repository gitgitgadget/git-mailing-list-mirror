Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373F6C11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2361161414
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbhGAOun (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbhGAOub (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:31 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E53C0613DC
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:48:00 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id w13so4690591wmc.3
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PCs4gtWKEQfwwXjZSPa+bpZ08P6Kqw0LvliYJMx3Soo=;
        b=VrIRgwzP6GHjCN0YWGDHmo2If392Y+X183vixaZ3f+imkCbPjq5tckdyp+6I3UZK68
         D93O8S8llFXK+1GX/xgFf+M/zGAVxwq9oafYi6GsZXGPEFxwzDEgeZvqMuSJrmnhDZeV
         4I+NVA/ppNVOkTunpFmA1b1fOjK+TNnR2OAXvwVj75yjpQfurq4jiRj0lSTbdz7MdSWn
         QUh0pt78hZd748d1Dd2+rEGl205hDiJDBipiUyw5urAcqM53WIQR6jNCxz8/GFR5seKs
         vAL//tuuqlaS4Io9VfbMyfa0AfIHsKImYqtWo/LY6ZCeCaN9Fb5xkHoP/VJj9gK8h+ap
         Ldmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PCs4gtWKEQfwwXjZSPa+bpZ08P6Kqw0LvliYJMx3Soo=;
        b=tws5mkiwuK2NRUscyLz46wCYEZtCblXkDRm0kFlm8CICxEvGOLS2bLO19EMGD6nPuo
         5rzFUXPu2cKZc1w7eX55GoK8LfVO8eroaPhMbZMK42QgES1xEizX1NGhukaz/BFC/mt6
         8RIqwI5WuKMx5ELG3XlsYOflYn3ozLACaRV4lIOmNjSgQnASQA1f9cwfr1eAXoTTLqSC
         cQFRII3yCLdBBXlWW9OPOcCFoz1jC2p4Yy5EhxKOI68nUHA0SY3wrBCftmm5SahYGc6D
         d6XyvpLyJ1YuwxlgA/6FM1sW79YTFH+EXpsONL7qWKFYd7BQKLuzGBCYNN4lgnTjaTdn
         mzfQ==
X-Gm-Message-State: AOAM530zgZAd9DxcQVSvRbK2Q1WjNZ2AUZ0LjJcqvEjUjtJ6SHMzqNMv
        zx7v1YE8AbeshrQxta0b64OUQ2z4fr0=
X-Google-Smtp-Source: ABdhPJzfkrm692t5yKea187buOsgZ19VPFRlsFtfcE46shFUdPUTX66/42fad38kjJNRBAb1GOMepg==
X-Received: by 2002:a1c:771a:: with SMTP id t26mr11345577wmi.36.1625150879003;
        Thu, 01 Jul 2021 07:47:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g10sm230548wmh.33.2021.07.01.07.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:47:58 -0700 (PDT)
Message-Id: <3cf8f3cd7717dad69262ae884a89c1a6ca0ce5fc.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:33 +0000
Subject: [PATCH v3 23/34] t/helper/test-touch: add helper to touch a series of
 files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create `test-tool touch` that can update a series of files
using either a pattern given on the command line or a list
of files read from stdin.

This will be used in a later commit to speed up p7519
which needs to generate/update many thousands of files.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile              |   1 +
 t/helper/test-tool.c  |   1 +
 t/helper/test-tool.h  |   1 +
 t/helper/test-touch.c | 126 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 129 insertions(+)
 create mode 100644 t/helper/test-touch.c

diff --git a/Makefile b/Makefile
index a2a6e1f20f6..c07cfb75532 100644
--- a/Makefile
+++ b/Makefile
@@ -757,6 +757,7 @@ TEST_BUILTINS_OBJS += test-string-list.o
 TEST_BUILTINS_OBJS += test-submodule-config.o
 TEST_BUILTINS_OBJS += test-submodule-nested-repo-config.o
 TEST_BUILTINS_OBJS += test-subprocess.o
+TEST_BUILTINS_OBJS += test-touch.o
 TEST_BUILTINS_OBJS += test-trace2.o
 TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
 TEST_BUILTINS_OBJS += test-userdiff.o
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index af879e4a5d7..1ad8d5fbd82 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -73,6 +73,7 @@ static struct test_cmd cmds[] = {
 	{ "submodule-config", cmd__submodule_config },
 	{ "submodule-nested-repo-config", cmd__submodule_nested_repo_config },
 	{ "subprocess", cmd__subprocess },
+	{ "touch", cmd__touch },
 	{ "trace2", cmd__trace2 },
 	{ "userdiff", cmd__userdiff },
 	{ "urlmatch-normalization", cmd__urlmatch_normalization },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 6c5134b46d9..58fde0a62e5 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -63,6 +63,7 @@ int cmd__string_list(int argc, const char **argv);
 int cmd__submodule_config(int argc, const char **argv);
 int cmd__submodule_nested_repo_config(int argc, const char **argv);
 int cmd__subprocess(int argc, const char **argv);
+int cmd__touch(int argc, const char **argv);
 int cmd__trace2(int argc, const char **argv);
 int cmd__userdiff(int argc, const char **argv);
 int cmd__urlmatch_normalization(int argc, const char **argv);
diff --git a/t/helper/test-touch.c b/t/helper/test-touch.c
new file mode 100644
index 00000000000..e9b3b754f1f
--- /dev/null
+++ b/t/helper/test-touch.c
@@ -0,0 +1,126 @@
+/*
+ * test-touch.c: variation on /usr/bin/touch to speed up tests
+ * with a large number of files (primarily on Windows where child
+ * process are very, very expensive).
+ */
+
+#include "test-tool.h"
+#include "cache.h"
+#include "parse-options.h"
+
+char *seq_pattern;
+int seq_start = 1;
+int seq_count = 1;
+
+static int do_touch_one(const char *path)
+{
+	int fd;
+
+	if (!utime(path, NULL))
+		return 0;
+
+	if (errno != ENOENT) {
+		warning_errno("could not touch '%s'", path);
+		return 0;
+	}
+
+	fd = open(path, O_RDWR | O_CREAT, 0644);
+	if (fd == -1) {
+		warning_errno("could not create '%s'", path);
+		return 0;
+	}
+	close(fd);
+
+	return 0;
+}
+
+/*
+ * Touch a series of files.  We assume that any required subdirs
+ * already exist.  This function allows us to replace the following
+ * test script fragment:
+ *
+ *    for i in $(test_seq 1 10000); do touch 10000_files/$i; done &&
+ *
+ * with a single process:
+ *
+ *    test-tool touch sequence --pattern="10000_files/%d" --start=1 --count=10000
+ *
+ * which is much faster on Windows.
+ */
+static int do_sequence(void)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int k;
+
+	for (k = seq_start; k < seq_start + seq_count; k++) {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, seq_pattern, k);
+
+		if (do_touch_one(buf.buf))
+			return 1;
+	}
+
+	return 0;
+}
+
+/*
+ * Read a list of pathnames from stdin and touch them.  We assume that
+ * any required subdirs already exist.
+ */
+static int do_stdin(void)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	while (strbuf_getline(&buf, stdin) != EOF && buf.len)
+		if (do_touch_one(buf.buf))
+			return 1;
+
+	return 0;
+}
+
+int cmd__touch(int argc, const char **argv)
+{
+	const char *touch_usage[] = {
+		N_("test-tool touch sequence <pattern> <start> <count>"),
+		N_("test-tool touch stdin"),
+		NULL,
+	};
+
+	struct option touch_options[] = {
+		OPT_GROUP(N_("sequence")),
+		OPT_STRING(0, "pattern", &seq_pattern, N_("format"),
+			   N_("sequence pathname pattern")),
+		OPT_INTEGER(0, "start", &seq_start,
+			    N_("sequence starting value")),
+		OPT_INTEGER(0, "count", &seq_count,
+			    N_("sequence count")),
+		OPT_END()
+	};
+
+	const char *subcmd;
+
+	if (argc < 2)
+		usage_with_options(touch_usage, touch_options);
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(touch_usage, touch_options);
+
+	subcmd = argv[1];
+	argv--;
+	argc++;
+
+	argc = parse_options(argc, argv, NULL, touch_options, touch_usage, 0);
+
+	if (!strcmp(subcmd, "sequence")) {
+		if (!seq_pattern || !strstr(seq_pattern, "%d"))
+			die("invalid sequence pattern");
+		if (seq_count < 1)
+			die("invalid sequence count: %d", seq_count);
+		return !!do_sequence();
+	}
+
+	if (!strcmp(subcmd, "stdin")) {
+		return !!do_stdin();
+	}
+
+	die("Unhandled subcommand: '%s'", subcmd);
+}
-- 
gitgitgadget

