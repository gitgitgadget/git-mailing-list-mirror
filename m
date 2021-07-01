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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FDEC11F6A
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9D946140C
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhGAOuf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbhGAOuY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E730BC061765
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:47:52 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id f14so8218901wrs.6
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FPBKBRBBPCafHEVXnDZiFc4V2cPGyq12y/pnJ2IeXvY=;
        b=dVUYpjVt7yPovvdZ50QO9vtrewWbkpn3GZTPbnoFq3xivs8e3oA20weO+ltkh02hcL
         mEo6uGO7retVFWyVjd1naYZ1irmDI5wpRjroKCabc9b92STYkLTUC2/GP4SS2qggJOI+
         qatMm9ULdoqkxdQinjH7MotnRQm5ahzSsFRyyLhPuzYRxZkKBtIeFRfee4bnMd2XHTYD
         FV68qXT1P24kJtzz1faQSZUDjN+OGtDGSoqOAkou3ZWj5k7NTi2BvMVqrvfjDKMe02ij
         daCsjREA8OkE0AzQmEUMA4ywAhk4/iWB9FpGqGp318VrT+F9snvVOdHb20QDVAWyCzMU
         o8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FPBKBRBBPCafHEVXnDZiFc4V2cPGyq12y/pnJ2IeXvY=;
        b=eaHt4Yf0hE2fgjeNTWerQvykz+qhWuvtr46E99nk07OkekMRutdG1R5IpCoXRFBZ+P
         AvQykhEQVTMxgTzRQXhN/bkQ+Z5Rl1VKoGLPBs7Tjg+XrmKmkTgPzlyMvPKlv7AAzdZo
         4++OI6qOk1kGCyz7+VphwjPwa8MANbB7luYLSnTO/oBlrFsvUtCm7SY1CbRqQzosSs2V
         hNky39tY+M3/OnpshEGjOHGEb/BPxrUYY+UAYfYkZ+HKkgpmBq4nlfRZYDuCZoLhFBUX
         EnJra86vnw2KzMeosEdmbdH3vS0ZdnjfEE017LNjpkTfaz8OM3+xTsT1XBOW0rIUsXWm
         aoiw==
X-Gm-Message-State: AOAM533KlgINCEyQURgQwTblEC683kqZ8P9g9AnK9jWc2mZyUjdk21A2
        QdLQ1TwUxtZUtmwPEsy9YQC5T4U5rII=
X-Google-Smtp-Source: ABdhPJwpM/xG1mImS8itmI5s7cOWePi4XgZPprIgF6Uz+mlBChur+F80Cmk0IsygBlEOsnepCYKvJA==
X-Received: by 2002:adf:fc47:: with SMTP id e7mr21404wrs.284.1625150871578;
        Thu, 01 Jul 2021 07:47:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z3sm10069442wmi.29.2021.07.01.07.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:47:51 -0700 (PDT)
Message-Id: <c2adac8ed4b4f324b54b147e1fcb1aa4a74e80dd.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:20 +0000
Subject: [PATCH v3 10/34] t/helper/fsmonitor-client: create IPC client to talk
 to FSMonitor Daemon
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
index 8fe1e42a435..c45caacf2c3 100644
--- a/Makefile
+++ b/Makefile
@@ -709,6 +709,7 @@ TEST_BUILTINS_OBJS += test-dump-split-index.o
 TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
 TEST_BUILTINS_OBJS += test-example-decorate.o
 TEST_BUILTINS_OBJS += test-fast-rebase.o
+TEST_BUILTINS_OBJS += test-fsmonitor-client.o
 TEST_BUILTINS_OBJS += test-genrandom.o
 TEST_BUILTINS_OBJS += test-genzeros.o
 TEST_BUILTINS_OBJS += test-hash-speed.o
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
index c5bd0c6d4c7..af879e4a5d7 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -31,6 +31,7 @@ static struct test_cmd cmds[] = {
 	{ "dump-untracked-cache", cmd__dump_untracked_cache },
 	{ "example-decorate", cmd__example_decorate },
 	{ "fast-rebase", cmd__fast_rebase },
+	{ "fsmonitor-client", cmd__fsmonitor_client },
 	{ "genrandom", cmd__genrandom },
 	{ "genzeros", cmd__genzeros },
 	{ "hashmap", cmd__hashmap },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index e8069a3b222..6c5134b46d9 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -21,6 +21,7 @@ int cmd__dump_split_index(int argc, const char **argv);
 int cmd__dump_untracked_cache(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
 int cmd__fast_rebase(int argc, const char **argv);
+int cmd__fsmonitor_client(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
 int cmd__genzeros(int argc, const char **argv);
 int cmd__hashmap(int argc, const char **argv);
-- 
gitgitgadget

