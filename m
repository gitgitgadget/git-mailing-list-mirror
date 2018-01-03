Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EDA21F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751259AbeACATU (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:19:20 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:42618 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751215AbeACATP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:19:15 -0500
Received: by mail-io0-f195.google.com with SMTP id x67so459398ioi.9
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aY3W07FXcXl2CObiwSJQNP7EQVv0wCwGXtkiYTbApeQ=;
        b=W+kKrAMXeyQxvu+dH6SauDibjjFFMSSnYODKEBLq+/AO6rdSkCpx87ZvmwLdfkhq6G
         XnCGu5ntZ7DWV0COB6T5PKnXu8NXIGrwQnF/JyWznH+Ql5R0NHc/9wkgudPGNKVKQjrl
         4jEyUFbk4zGHz1usCGmDTVQynpiJg+PD+0z1gS3srTfKw8Huiwlv8FtcRYNpmxaZSDxS
         xYnGfcDqRUKz9S6WtUIsmBcCuH3oysWBx+FN0u4wxAkYhvch+YQF37mimLAvtKjVQgb6
         dN8WcyOHwP0RqyXgajw51rbMnaGJSLKd9ryabooBgUizP5ZuzlXlOxXOYA0j4po1a36b
         uFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aY3W07FXcXl2CObiwSJQNP7EQVv0wCwGXtkiYTbApeQ=;
        b=eg8ohC47JOlL4T0x/VabFlvHVSWn/p7bXgT/rz4uUuB8Y2f7SI1+KGBSyE+Ax1fwHU
         5ucz+6bfEtewY97D5EFn5BA97DElsTTc4Vc5zwsvLhtXNwc3QZWhlAcUarrSIZFCldjP
         0hDV3k1EamVhe+QF+abR6QiBehpeleafrfKjktu08/jLcXpwop9c093LnpM4Vn6TpbJ3
         rsPbIKd3JK+TyiTVqkxZdvesAW5FZtZ6WSDEXM3bwUPktLqy7+/P0QWJX0Xq+EkEf1AT
         cQEDEPUqMQB6MIjjYOrWjwG+rTKD0aRchi/RBZBInu048sERyAZB+UmO0GQ0gqUfiEM7
         mmoA==
X-Gm-Message-State: AKGB3mJL/sn7PkbHkKjRXRdfSphv+abSBF4ZoV82H8uT3vwdT8zAEpYg
        2nrrDVj2KrjEdH2NQIR/3MiqEDqDPQc=
X-Google-Smtp-Source: ACJfBouP/7bu3IPNzDA9yWUiL/QE/trN7Bxb4ZANQ17OJlh4v3Jx6KxcKXuUIPpGd8oGa9CYp2+scQ==
X-Received: by 10.107.185.134 with SMTP id j128mr63844168iof.221.1514938753964;
        Tue, 02 Jan 2018 16:19:13 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q2sm12679ite.17.2018.01.02.16.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 16:19:13 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 22/26] transport-helper: refactor process_connect_service
Date:   Tue,  2 Jan 2018 16:18:24 -0800
Message-Id: <20180103001828.205012-23-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103001828.205012-1-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A future patch will need to take advantage of the logic which runs and
processes the response of the connect command on a remote helper so
factor out this logic from 'process_connect_service()' and place it into
a helper function 'run_connect()'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 transport-helper.c | 67 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 29 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index d72155768..c032a2a87 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -545,14 +545,13 @@ static int fetch_with_import(struct transport *transport,
 	return 0;
 }
 
-static int process_connect_service(struct transport *transport,
-				   const char *name, const char *exec)
+static int run_connect(struct transport *transport, struct strbuf *cmdbuf)
 {
 	struct helper_data *data = transport->data;
-	struct strbuf cmdbuf = STRBUF_INIT;
-	struct child_process *helper;
-	int r, duped, ret = 0;
+	int ret = 0;
+	int duped;
 	FILE *input;
+	struct child_process *helper;
 
 	helper = get_helper(transport);
 
@@ -568,44 +567,54 @@ static int process_connect_service(struct transport *transport,
 	input = xfdopen(duped, "r");
 	setvbuf(input, NULL, _IONBF, 0);
 
+	sendline(data, cmdbuf);
+	if (recvline_fh(input, cmdbuf))
+		exit(128);
+
+	if (!strcmp(cmdbuf->buf, "")) {
+		data->no_disconnect_req = 1;
+		if (debug)
+			fprintf(stderr, "Debug: Smart transport connection "
+				"ready.\n");
+		ret = 1;
+	} else if (!strcmp(cmdbuf->buf, "fallback")) {
+		if (debug)
+			fprintf(stderr, "Debug: Falling back to dumb "
+				"transport.\n");
+	} else {
+		die("Unknown response to connect: %s",
+			cmdbuf->buf);
+	}
+
+	fclose(input);
+	return ret;
+}
+
+static int process_connect_service(struct transport *transport,
+				   const char *name, const char *exec)
+{
+	struct helper_data *data = transport->data;
+	struct strbuf cmdbuf = STRBUF_INIT;
+	int ret = 0;
+
 	/*
 	 * Handle --upload-pack and friends. This is fire and forget...
 	 * just warn if it fails.
 	 */
 	if (strcmp(name, exec)) {
-		r = set_helper_option(transport, "servpath", exec);
+		int r = set_helper_option(transport, "servpath", exec);
 		if (r > 0)
 			warning("Setting remote service path not supported by protocol.");
 		else if (r < 0)
 			warning("Invalid remote service path.");
 	}
 
-	if (data->connect)
+	if (data->connect) {
 		strbuf_addf(&cmdbuf, "connect %s\n", name);
-	else
-		goto exit;
-
-	sendline(data, &cmdbuf);
-	if (recvline_fh(input, &cmdbuf))
-		exit(128);
-
-	if (!strcmp(cmdbuf.buf, "")) {
-		data->no_disconnect_req = 1;
-		if (debug)
-			fprintf(stderr, "Debug: Smart transport connection "
-				"ready.\n");
-		ret = 1;
-	} else if (!strcmp(cmdbuf.buf, "fallback")) {
-		if (debug)
-			fprintf(stderr, "Debug: Falling back to dumb "
-				"transport.\n");
-	} else
-		die("Unknown response to connect: %s",
-			cmdbuf.buf);
+		ret = run_connect(transport, &cmdbuf);
+	}
 
-exit:
 	strbuf_release(&cmdbuf);
-	fclose(input);
 	return ret;
 }
 
-- 
2.15.1.620.gb9897f4670-goog

