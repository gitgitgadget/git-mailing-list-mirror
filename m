Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E71B81F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964959AbeB1XZH (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:25:07 -0500
Received: from mail-yb0-f202.google.com ([209.85.213.202]:45513 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964896AbeB1XY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:24:28 -0500
Received: by mail-yb0-f202.google.com with SMTP id w1-v6so2361353ybm.12
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Yu0As66/+AOIWcjzBB391a+yPS4nMVYKyS4fPhy3it8=;
        b=R6y+ANHr7fgdABg3LatjjBXwu1NFI0PRK6fYrjIqjjoxR3br9NMcT1XfjQujV76EPw
         OT9yaGRfDSqv4Qe1z9oYf4YoEviTtm7zfthKh/xkvHAyhUpDLirncEZfmr7fEprbKUq+
         SRvvBxiYCVjePl/DjLBEkOT+Y1TDITxHliehjkYja5laGPlEllxPJhhNd7xKmPJjtDKr
         ghyU3HL2kDqHyhS8DsrHRhAd68cmWJxmu0M9+V41w8ZJJAVvFF4Yoo8Tpy+0r9PbrVtH
         Mpkh90uX7zwQNVWXRp8hK+uM8n4Qp3K+XjSZQ/fOnB0SFZqaHbnEsNXjxz/9XiKdXtMi
         qwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Yu0As66/+AOIWcjzBB391a+yPS4nMVYKyS4fPhy3it8=;
        b=fK8aFGqDCPB5WSlTQbpGhNjwk2lnWMx4bSbAJ8P0izKa3gdSQ5r6PiuNJ/SlC153sQ
         3s4YS2Kw4k4Gn9tNaPFnB/AnPPDX5cHg2YS6i404/QjPBj14VqDjEo8ltDs6ZukCS9be
         kvgixUXKlcAr/ym6/paUELRrAyarAqNMef7PJRTh4CO5ycQXofr3fB1LqQXJfesh9GNq
         l34LVSYCWeNE326C1OwunXesqQUA5B4eGFOnw3jGBgWC5B4b4GmUf/bDUgi0+s2ixQ2x
         W4iax03l2vsFQptwRgZUidrBMr2Ez7LtCS8A6OXmY5X0X9BExBbbibgJk3VLghnPuFfF
         Oi6g==
X-Gm-Message-State: APf1xPAPfgqCbv9oauybPnToWLcGQDW0zXCcb+CW9EEhI3jKSygCEmwg
        9hLRrdvKR9ORhqjLU5VXIAGzeZcLIDNJKQuuoqEHRo4Y/VYINQ0z9M7ZY2f7zBxaD0jcUrqbtqM
        ysVl4oJSakXtqVl1lL53F09xRk6IgULNp2P2Lkz45a7b7SXTu6tPp+jvbfg==
X-Google-Smtp-Source: AG47ELvRovLEVxDHVGYrbkfJjjDm5eT7PdUC9i9dHHkE/8x8hpXpK6/1JlePQ/o10tdkz0uyv4PF5O3rjqg=
MIME-Version: 1.0
X-Received: by 10.129.62.36 with SMTP id l36mr3513539ywa.80.1519860267231;
 Wed, 28 Feb 2018 15:24:27 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:43 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-27-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 26/35] transport-helper: refactor process_connect_service
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, Brandon Williams <bmwill@google.com>
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
 transport-helper.c | 67 ++++++++++++++++++++++++++--------------------
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
2.16.2.395.g2e18187dfd-goog

