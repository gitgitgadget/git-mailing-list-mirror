Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA53DC2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D42661244
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhEVN6v (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 09:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhEVN6n (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 09:58:43 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C1BC061574
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:18 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d11so23701572wrw.8
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BA7FTa5LhN0caORx5MCdbHxg65jsbpWHZ0p9QRRXVV8=;
        b=ey0XBfEZJi0vjPH5c2/9sE6Q5zpoK6plbyjea3qrqaN/NWLErzzrB9Q+1KmkgDd3z8
         Dwd3a3Sb5+/VQYdWkIj67UUMP/mFlsuFhEU3eYPCiGisHSI7YYfb4IFJ2vDvoYKbnY9l
         L7mm98sMoxejOr03gum3PeA3yKNjpBcHYKVPzJlAifIE1h1DTHN1Irfp28bxovMZ+TFQ
         gj0uJ/llAVj1PZQWnFzqWxf7tNFrhLvrzAQhN2v0i1CYUG2zC9B32TLzRuPTRxYPOXEl
         ojHChEnj/6rNWZORhpSbTrJE150vBb6+Vyc9O6jB4fjtGFMzXuqUO8vqL1glWf5lJnCo
         /ehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BA7FTa5LhN0caORx5MCdbHxg65jsbpWHZ0p9QRRXVV8=;
        b=pg+DNKR06IoRktj7CygLyox7j6j8QAj3qGOkWQ/eZubIZ/dIMEsVzKs/yCuJJ9mAuy
         OSuNIxXiexNp3Y6Q7iSnHEBDa1LEb/qvfbUP7ArOMtT1vAh7WB1Yik9nc4Vz9mMzELWL
         RPJxPRzURysPGzKgGgevRRQEm2u9M8YSbOcY/pRVjACOLdDJccm+ZRRUIic6SDlEzQLP
         pQTL05d0uoYXVH/csXtSyighXenz28uzaFfSxkVtZydgbREGr3bnlUDv2A6WwKLHwrf4
         zWLpmSoJJ0yoCKFEuGwvG1N92elSEzdBW5QY3GwijzKaDmyq7dfBwdgbgSqfNZZRfO9W
         hjnQ==
X-Gm-Message-State: AOAM53162P2225n6GLoCeN//74QFkQznRaJ+y8rEfDwj7LjtOsTT/clm
        4l4dD60OWp+ENGHacU7OuuEPinnoH4s=
X-Google-Smtp-Source: ABdhPJyPOvT9G4IWrRz5IjwTAwlvyIlGbY87UdaXqK6cHKf6khPEByuIA+0K0aooVJWpw2xTA4yvRQ==
X-Received: by 2002:a05:6000:244:: with SMTP id m4mr14318746wrz.225.1621691836867;
        Sat, 22 May 2021 06:57:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x2sm2538508wmc.21.2021.05.22.06.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 06:57:16 -0700 (PDT)
Message-Id: <d21af7ff842c2a2642ae42df7b972a8817b8a3e8.1621691828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
        <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 May 2021 13:56:49 +0000
Subject: [PATCH v2 10/28] t/helper/fsmonitor-client: create IPC client to talk
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
 t/helper/test-fsmonitor-client.c | 125 +++++++++++++++++++++++++++++++
 t/helper/test-tool.c             |   1 +
 t/helper/test-tool.h             |   1 +
 4 files changed, 128 insertions(+)
 create mode 100644 t/helper/test-fsmonitor-client.c

diff --git a/Makefile b/Makefile
index 74673acc9833..80059032c4e3 100644
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
index 000000000000..4961f28e3e02
--- /dev/null
+++ b/t/helper/test-fsmonitor-client.c
@@ -0,0 +1,125 @@
+/*
+ * test-fsmonitor-client.c: client code to send commands/requests to
+ * a `git fsmonitor--daemon` daemon.
+ */
+
+#include "test-tool.h"
+#include "cache.h"
+#include "parse-options.h"
+//#include "fsmonitor.h"
+#include "fsmonitor-ipc.h"
+//#include "compat/fsmonitor/fsmonitor-fs-listen.h"
+//#include "fsmonitor--daemon.h"
+//#include "simple-ipc.h"
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
index 25c6a37e93e5..b15d328f9a41 100644
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
index f03c5988b20c..a8e96b97c419 100644
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

