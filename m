Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B82C433FE
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353667AbiBKU5R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:57:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353588AbiBKU4v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:56:51 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA16D71
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:39 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m126-20020a1ca384000000b0037bb8e379feso7954906wme.5
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fr0bI3s3hiyD0qm7Dx2hFQBDf0DSgtyvyddALrQO994=;
        b=R5jfIJzzjGCmj51G9b41FKGm4KnCu3J5+L+0T9gCEhBpWO/ouYO0gjhiFGVQEmsBqD
         mZzbHwruSbRnzyA1lr+zql7VTadFpN8EkecsVsrgMoaOpxrTjd8o6jIhquCkIR69Z0y1
         qnHiSBAM8hmcDvvGaqk3hVgb0+Mp8ocj6u+sAylgty91Cz7tWxbAMLeQl14MsNRD/Bla
         MP9Qm9KEE/9baE/I7k8FdfWWw4qZFmLWt1m4AKhSaiFLnAAnJ5xyM/psTSsyjimmj2JN
         twERij3iB9ZMnOWxCji9jGgVAllQL3MzC//5HPVsFY3FIH5av1fYusyqsW6wPj0+ER/M
         zDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fr0bI3s3hiyD0qm7Dx2hFQBDf0DSgtyvyddALrQO994=;
        b=2pA4sKLm3be/xJexigFB0cvd63H5GoCZAD0ZM8rqFlADCpBK5PRoYPCUYLoTGLa/Gm
         mjO+9Un0G819jWinz2QZqmcDceQ3eeIugXyt/y3ZtSsjZPNQHmzYoL7RPnA2b86iSIWU
         oTJ55ktBjjFFpYu38jJdbVryqKnseZMOzOwgcHOtROlu5R/LJ1zxTt3IXxUqFnVmvrqM
         rdny2R0qScPBYWafGjZWLJ6CHBgQR8ScrdS8s1tqQxgm1iHYUqQqStrCNvU0u1jw3Pfo
         zrD35dhwvKGa6sxmWB3Nt0bTAtnXZt6yhYpEmC46o0ubdvo2t4ugsZ4ZyMlETIv/g25+
         ON6A==
X-Gm-Message-State: AOAM533Vq88sJHvoLvCoenPs6omVmg6wDX+909LmCks5iA42T2iIRZOf
        GbFptHTwamipi7INGMC3CEhWlUEBpvo=
X-Google-Smtp-Source: ABdhPJw3JLA+BTAmFU3pzXNJXM0bnV5uncf7eSJ/ttg6oVKfc/XnqVRFM7nlM2XTEZ0MARRnXvvbxA==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr1774716wmj.2.1644612997550;
        Fri, 11 Feb 2022 12:56:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j15sm221531wmq.6.2022.02.11.12.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:56:37 -0800 (PST)
Message-Id: <4ffc2ddf516f248c35a0ca155f758a455722d7a9.1644612979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 20:56:09 +0000
Subject: [PATCH v5 20/30] t/helper/fsmonitor-client: create IPC client to talk
 to FSMonitor Daemon
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create an IPC client to send query and flush commands to the daemon.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                         |   1 +
 t/helper/test-fsmonitor-client.c | 121 +++++++++++++++++++++++++++++++
 t/helper/test-tool.c             |   1 +
 t/helper/test-tool.h             |   1 +
 4 files changed, 124 insertions(+)
 create mode 100644 t/helper/test-fsmonitor-client.c

diff --git a/Makefile b/Makefile
index b98f4899ac0..6846d91c37b 100644
--- a/Makefile
+++ b/Makefile
@@ -709,6 +709,7 @@ TEST_BUILTINS_OBJS += test-dump-split-index.o
 TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
 TEST_BUILTINS_OBJS += test-example-decorate.o
 TEST_BUILTINS_OBJS += test-fast-rebase.o
+TEST_BUILTINS_OBJS += test-fsmonitor-client.o
 TEST_BUILTINS_OBJS += test-genrandom.o
 TEST_BUILTINS_OBJS += test-genzeros.o
 TEST_BUILTINS_OBJS += test-getcwd.o
diff --git a/t/helper/test-fsmonitor-client.c b/t/helper/test-fsmonitor-client.c
new file mode 100644
index 00000000000..f7a5b3a32fa
--- /dev/null
+++ b/t/helper/test-fsmonitor-client.c
@@ -0,0 +1,121 @@
+/*
+ * test-fsmonitor-client.c: client code to send commands/requests to
+ * a `git fsmonitor--daemon` daemon.
+ */
+
+#include "test-tool.h"
+#include "cache.h"
+#include "parse-options.h"
+#include "fsmonitor-ipc.h"
+
+#ifndef HAVE_FSMONITOR_DAEMON_BACKEND
+int cmd__fsmonitor_client(int argc, const char **argv)
+{
+	die("fsmonitor--daemon not available on this platform");
+}
+#else
+
+/*
+ * Read the `.git/index` to get the last token written to the
+ * FSMonitor Index Extension.
+ */
+static const char *get_token_from_index(void)
+{
+	struct index_state *istate = the_repository->index;
+
+	if (do_read_index(istate, the_repository->index_file, 0) < 0)
+		die("unable to read index file");
+	if (!istate->fsmonitor_last_update)
+		die("index file does not have fsmonitor extension");
+
+	return istate->fsmonitor_last_update;
+}
+
+/*
+ * Send an IPC query to a `git-fsmonitor--daemon` daemon and
+ * ask for the changes since the given token or from the last
+ * token in the index extension.
+ *
+ * This will implicitly start a daemon process if necessary.  The
+ * daemon process will persist after we exit.
+ */
+static int do_send_query(const char *token)
+{
+	struct strbuf answer = STRBUF_INIT;
+	int ret;
+
+	if (!token || !*token)
+		token = get_token_from_index();
+
+	ret = fsmonitor_ipc__send_query(token, &answer);
+	if (ret < 0)
+		die(_("could not query fsmonitor--daemon"));
+
+	write_in_full(1, answer.buf, answer.len);
+	strbuf_release(&answer);
+
+	return 0;
+}
+
+/*
+ * Send a "flush" command to the `git-fsmonitor--daemon` (if running)
+ * and tell it to flush its cache.
+ *
+ * This feature is primarily used by the test suite to simulate a loss of
+ * sync with the filesystem where we miss kernel events.
+ */
+static int do_send_flush(void)
+{
+	struct strbuf answer = STRBUF_INIT;
+	int ret;
+
+	ret = fsmonitor_ipc__send_command("flush", &answer);
+	if (ret)
+		return ret;
+
+	write_in_full(1, answer.buf, answer.len);
+	strbuf_release(&answer);
+
+	return 0;
+}
+
+int cmd__fsmonitor_client(int argc, const char **argv)
+{
+	const char *subcmd;
+	const char *token = NULL;
+
+	const char * const fsmonitor_client_usage[] = {
+		N_("test-helper fsmonitor-client query [<token>]"),
+		N_("test-helper fsmonitor-client flush"),
+		NULL,
+	};
+
+	struct option options[] = {
+		OPT_STRING(0, "token", &token, N_("token"),
+			   N_("command token to send to the server")),
+		OPT_END()
+	};
+
+	if (argc < 2)
+		usage_with_options(fsmonitor_client_usage, options);
+
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(fsmonitor_client_usage, options);
+
+	subcmd = argv[1];
+	argv--;
+	argc++;
+
+	argc = parse_options(argc, argv, NULL, options, fsmonitor_client_usage, 0);
+
+	setup_git_directory();
+
+	if (!strcmp(subcmd, "query"))
+		return !!do_send_query(token);
+
+	if (!strcmp(subcmd, "flush"))
+		return !!do_send_flush();
+
+	die("Unhandled subcommand: '%s'", subcmd);
+}
+#endif
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 338a57b104d..a4c5647b2f1 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -31,6 +31,7 @@ static struct test_cmd cmds[] = {
 	{ "dump-untracked-cache", cmd__dump_untracked_cache },
 	{ "example-decorate", cmd__example_decorate },
 	{ "fast-rebase", cmd__fast_rebase },
+	{ "fsmonitor-client", cmd__fsmonitor_client },
 	{ "genrandom", cmd__genrandom },
 	{ "genzeros", cmd__genzeros },
 	{ "getcwd", cmd__getcwd },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 48cee1f4a2d..fa4c936310c 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -22,6 +22,7 @@ int cmd__dump_untracked_cache(int argc, const char **argv);
 int cmd__dump_reftable(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
 int cmd__fast_rebase(int argc, const char **argv);
+int cmd__fsmonitor_client(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
 int cmd__genzeros(int argc, const char **argv);
 int cmd__getcwd(int argc, const char **argv);
-- 
gitgitgadget

