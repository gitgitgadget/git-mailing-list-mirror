Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96506C4332B
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 20:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7926464F72
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 20:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238976AbhCDUSe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 15:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238924AbhCDUSO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 15:18:14 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6242AC061764
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 12:17:34 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u16so11058207wrt.1
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 12:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZbbyA1WwTIDHqSji1Vd0aAj2DE4clnaH0m7TUhn3sm0=;
        b=QxneDKcbbMVMmeT1nPtRB8ylyaBlnnId35u6f13JcQgsDcarzvF7ynN2kPCQyO7eQ7
         32jUImxU60kryibTRhIuwJ045+jdUEnnN8D+8ulr/kvlzNBCCT659a+ReX3u1gjFiZeK
         D3qHrdcp4cNlVvlEiD0QyBLtKorvnq5whOxKev8L206PvG6Mo0OSpntM5NvtjtIS13dX
         nkOIpCA4vVOIUdufuXfVGey6eukyJU432M+Q/HfSAL3ezLCd9iAzhCJsasq26Cy7rPtq
         CqFmeZQetG3+NkvEUE9xPNmA38XVIn8uXpHbSBcCEO528Y0OVts0NlH371bMEobJtH04
         hfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZbbyA1WwTIDHqSji1Vd0aAj2DE4clnaH0m7TUhn3sm0=;
        b=YnFgihsMR2RVSLgw2az/uonfpZS1xdtsGxCpwfSywSX+72kmZ3jTz3zRjPXahOAZTg
         5FYOvFLw2gcMuMgAaSyXtIC6j8v2vjZhL+/WwJTtVGKffuyTaIrmS2n9d/71bsg48dNx
         TsZuD/Mnspb4/8inngDECB1p9sqQOgA94QqahnQrdOd4llkTStPZTppmU0hPtppXEu2i
         CVVQ9WooZPHEAyAN717oS9mLBkpSSSjW0vhujnyHPn6bIChPYzwJn/RlMkM+IKQ2fGm9
         7InuBn8XjUlRMGKKKyOJ2ZQJwOGIyGyYui79uLaMOc/PSohhgOZQshGxSh4MfHgefWqY
         Ghqg==
X-Gm-Message-State: AOAM530sIqaep9roJP4XXryKsivEuMXu0syeo9Z/xYwXw9ZDLlJsH+pl
        pDd4vQ2pAShHvZNQsRubFlhd/2aMvzA=
X-Google-Smtp-Source: ABdhPJwIZz2trBPHE3NGcmxbsxfvo8mIEELmAuN2/CBw7JJLRWWWrbuqcZq93CBC2CK5mvibcrAnfA==
X-Received: by 2002:adf:a3c2:: with SMTP id m2mr5770215wrb.195.1614889053220;
        Thu, 04 Mar 2021 12:17:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15sm573443wru.38.2021.03.04.12.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 12:17:32 -0800 (PST)
Message-Id: <1902c23b87dbf6d4cf44d5a51c10eef539bb1243.1614889047.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.893.git.1614889047.gitgitgadget@gmail.com>
References: <pull.893.git.1614889047.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Mar 2021 20:17:26 +0000
Subject: [PATCH 7/8] test-simple-ipc: add --token=<token> string option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Change the `test-tool simple-ipc send` subcommand take a string
option rather than assume the last unclaimed value of argv.

This makes it a little less awkward to use after the recent changes
that added the `--name=<name>` option.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/helper/test-simple-ipc.c | 25 ++++++++++++++++---------
 t/t0052-simple-ipc.sh      | 10 +++++-----
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/t/helper/test-simple-ipc.c b/t/helper/test-simple-ipc.c
index 116c824d7555..4da63fd30c97 100644
--- a/t/helper/test-simple-ipc.c
+++ b/t/helper/test-simple-ipc.c
@@ -217,6 +217,7 @@ struct cl_args
 {
 	const char *subcommand;
 	const char *path;
+	const char *token;
 
 	int nr_threads;
 	int max_wait_sec;
@@ -229,6 +230,7 @@ struct cl_args
 struct cl_args cl_args = {
 	.subcommand = NULL,
 	.path = "ipc-test",
+	.token = NULL,
 
 	.nr_threads = 5,
 	.max_wait_sec = 60,
@@ -467,19 +469,22 @@ static int client__probe_server(void)
 }
 
 /*
- * Send an IPC command to an already-running server daemon and print the
- * response.
+ * Send an IPC command token to an already-running server daemon and
+ * print the response.
  *
- * argv[2] contains a simple (1 word) command that `test_app_cb()` (in
- * the daemon process) will understand.
+ * This is a simple 1 word command/token that `test_app_cb()` (in the
+ * daemon process) will understand.
  */
-static int client__send_ipc(const char *send_token)
+static int client__send_ipc(void)
 {
-	const char *command = send_token ? send_token : "(no-command)";
+	const char *command = "(no-command)";
 	struct strbuf buf = STRBUF_INIT;
 	struct ipc_client_connect_options options
 		= IPC_CLIENT_CONNECT_OPTIONS_INIT;
 
+	if (cl_args.token && *cl_args.token)
+		command = cl_args.token;
+
 	options.wait_if_busy = 1;
 	options.wait_if_not_found = 0;
 
@@ -511,7 +516,9 @@ static int client__stop_server(void)
 	time(&time_limit);
 	time_limit += cl_args.max_wait_sec;
 
-	ret = client__send_ipc("quit");
+	cl_args.token = "quit";
+
+	ret = client__send_ipc();
 	if (ret)
 		return ret;
 
@@ -697,6 +704,7 @@ int cmd__simple_ipc(int argc, const char **argv)
 		OPT_INTEGER(0, "batchsize", &cl_args.batchsize, N_("number of requests per thread")),
 
 		OPT_STRING(0, "byte", &bytevalue, N_("byte"), N_("ballast character")),
+		OPT_STRING(0, "token", &cl_args.token, N_("token"), N_("command token to send to the server")),
 
 		OPT_END()
 	};
@@ -757,10 +765,9 @@ int cmd__simple_ipc(int argc, const char **argv)
 	}
 
 	if (!strcmp(cl_args.subcommand, "send")) {
-		const char *send_token = argv[0];
 		if (client__probe_server())
 			return 1;
-		return !!client__send_ipc(send_token);
+		return !!client__send_ipc();
 	}
 
 	if (!strcmp(cl_args.subcommand, "sendbytes")) {
diff --git a/t/t0052-simple-ipc.sh b/t/t0052-simple-ipc.sh
index 18dcc8130728..ff98be31a51b 100755
--- a/t/t0052-simple-ipc.sh
+++ b/t/t0052-simple-ipc.sh
@@ -20,7 +20,7 @@ test_expect_success 'start simple command server' '
 '
 
 test_expect_success 'simple command server' '
-	test-tool simple-ipc send ping >actual &&
+	test-tool simple-ipc send --token=ping >actual &&
 	echo pong >expect &&
 	test_cmp expect actual
 '
@@ -31,19 +31,19 @@ test_expect_success 'servers cannot share the same path' '
 '
 
 test_expect_success 'big response' '
-	test-tool simple-ipc send big >actual &&
+	test-tool simple-ipc send --token=big >actual &&
 	test_line_count -ge 10000 actual &&
 	grep -q "big: [0]*9999\$" actual
 '
 
 test_expect_success 'chunk response' '
-	test-tool simple-ipc send chunk >actual &&
+	test-tool simple-ipc send --token=chunk >actual &&
 	test_line_count -ge 10000 actual &&
 	grep -q "big: [0]*9999\$" actual
 '
 
 test_expect_success 'slow response' '
-	test-tool simple-ipc send slow >actual &&
+	test-tool simple-ipc send --token=slow >actual &&
 	test_line_count -ge 100 actual &&
 	grep -q "big: [0]*99\$" actual
 '
@@ -116,7 +116,7 @@ test_expect_success 'stress test threads' '
 test_expect_success 'stop-daemon works' '
 	test-tool simple-ipc stop-daemon &&
 	test_must_fail test-tool simple-ipc is-active &&
-	test_must_fail test-tool simple-ipc send ping
+	test_must_fail test-tool simple-ipc send --token=ping
 '
 
 test_done
-- 
gitgitgadget

