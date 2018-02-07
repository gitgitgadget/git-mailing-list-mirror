Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 329651FAE2
	for <e@80x24.org>; Wed,  7 Feb 2018 01:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932263AbeBGBOU (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:14:20 -0500
Received: from mail-qk0-f201.google.com ([209.85.220.201]:42340 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932252AbeBGBOT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:14:19 -0500
Received: by mail-qk0-f201.google.com with SMTP id b191so3151049qkc.9
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=3IzS4UfEupUub3EHuboXCbwC4mTd8S8Xal1/BtsomDM=;
        b=SDVsE6wiYocjLdUOtrH0Ahj70vf1+RmrW90Uo14agwV7wcEL0XKjj2h6rQ1CcydBGK
         sIv9FvvfDxyxzr3kFAZYJfoZKh6z6mCyIw3cubdsQdjR9keOMpfzJaRF7OCU8mhdg7Pn
         JuSsnzu/CvwjcjEGVo86yJHgM8uxSYcjJjrqn4B3g05HlSQulRTV4kWDijSb8oy6nJu1
         D7wo+/KZcvWBX/tzM/TpDol9pRoUMwJq6yK7QzrAKCZAFUmfxhcan3rAWwGly2lC0v5T
         YMdjHv6y5AYK1SABf8lqe06+LXH+HJpM63PE+NjahryNETEjITiVABG9W5VxaB5uoEHo
         jmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=3IzS4UfEupUub3EHuboXCbwC4mTd8S8Xal1/BtsomDM=;
        b=kwREDSE7UKZxmg28By2hx+w9ZwH7tnl1MFxlyOVXPOg4Ft2Arfk2Xo76clL1FP8eIP
         ODsyHnUYNYf/ARELZaTKiUq3Ranm52HWvEj948M2XaVtlkMyzVZhlt51hbvU/pTiUUC6
         OLlz/L8pW+k+2WxDrLNnO5Zcq6uv5a630LC79m7rtHd1tTQZ7HijotrpyofnSylFF6oH
         FW7xOMCk941wZwBU7L9VOEHQE8JSdlubDk2+NqZXWJk1VzaC9yGLXcR+FEIdGeekkucK
         GSZrHsK3E5hhF7Abmp7fU9FyqlhAD5HcdPJNmYUJoH56sxbU4Pg9t77aAgzJMKDMmAgb
         R06w==
X-Gm-Message-State: APf1xPD8LZVgEQ0E2zgPgkU2jAruTxNMP8J6AVDPQEg8h/9NTAgjlbam
        qm5Ul7+OilOYtMdvsy1WO6hjf5KcSx12QPuwpuageqmWn05x4ibdAdxQsu4/IjtdtIM5lwhYXSX
        9u66mCfoPeyj+LjiNl171VvmyGliJLeR5maxDbSsvYeHdz/W6UuiuOmbWZg==
X-Google-Smtp-Source: AH8x226cqwoe4Efu5Tm2Hb4FgoPg9BSJJHjpRQ7BPhBHKKIM92cpB64wt3EJM9eaxiBTgGH7+VR8v/LwdPg=
MIME-Version: 1.0
X-Received: by 10.237.52.68 with SMTP id w62mr3318867qtd.15.1517966058476;
 Tue, 06 Feb 2018 17:14:18 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:13:04 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180207011312.189834-28-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 27/35] transport-helper: refactor process_connect_service
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
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
2.16.0.rc1.238.g530d649a79-goog

