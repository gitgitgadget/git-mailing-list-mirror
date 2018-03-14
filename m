Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A37F11F404
	for <e@80x24.org>; Wed, 14 Mar 2018 18:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752600AbeCNSdV (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:33:21 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:41932 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751957AbeCNSdS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:33:18 -0400
Received: by mail-qt0-f201.google.com with SMTP id 41so2720318qtp.8
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=CE+IVmWSlHtw8Cv8fPt1g83Xs1Hr1WxGRZhRApvhSOU=;
        b=M2cVqVfW8MQLN1uwOCxX8Roz1vxDHRVnmi55qsxmYZ3Yud7YdCYBgJrNZRFoNYCJ4B
         R4DotGyAMlXMP/Mh3ztcjI+QPQ/D4zdoi6kiyebd+N0m3zUjtrzmjez7J6EjpGIcOR0Y
         U+rPQulVOe7jli5V0GOwfVNDkP9/rprmmterLKsFkq93GCL0NDeOpEWzfgp8xbblhcF0
         BR/Dl1kywPu5Aa1PMXrbBLfIpB1SgVf5UamgEfwgWBbKNnvAQP34D7fB1XvFavDS+kDC
         7ALElRBGC/KwreUjB/F2qG3jcObJs90RKBzjSkDxMRRirZj5BvMmgc86zizdGs1hCuaJ
         0X0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=CE+IVmWSlHtw8Cv8fPt1g83Xs1Hr1WxGRZhRApvhSOU=;
        b=Vw1kI+EIO0kXxKjDOkoLCyAlMPDiI7NrdM1NbfiCNiqG42/AoboMgELSnV1XE0M5V+
         DxrJGK++6mGDyjwod8+h5z4n4z43kHhezQIBcokAwi7sn2XMBxu7aHDPWwHEmHLbcN9z
         /9DdhH1MpqT/WVyzqnlgsNYAOFWKnFEnStGbK/6nz5KEpfDFFoPnJO7g42G4viK7jI9d
         fC1ls1HO4FZfaUqCnzAjJBWMHjG9AFYtGxfjPwDz9X2GXM13jBEsNOaTrSgQAW3HnlXw
         BuqnRNPSdX19chpHuNXDoVW1AhvzsmYlQOrywWMdiZESMapY6J1+OhI56yURSMpNfiWy
         9VMA==
X-Gm-Message-State: AElRT7G1a+bXUGlxj497XHa2vqhk4CdV6+sG1+y0XGutu9eBFnq+lX40
        Y5nOgz5h9+JZ7be9vafYnAVJ46nu2yvzmcc/y2Q+/eLeIWRemCbaHZ/5ul6tyJONTSek60vs3DE
        RgGjnpZ59hUQLjuTvrLrBUcK7XU2BP69gKaf/jasis9bzxXfCeoU7usUzIQ==
X-Google-Smtp-Source: AG47ELuG0oWWmOPemD0pYl9x1fMWhqnH0XkE76L8kjZBej2Va9NkFLmMFryj43CK5g+hebBiN+cHaQpZdJs=
MIME-Version: 1.0
X-Received: by 10.200.44.187 with SMTP id 56mr3823728qtw.10.1521052397787;
 Wed, 14 Mar 2018 11:33:17 -0700 (PDT)
Date:   Wed, 14 Mar 2018 11:32:03 -0700
In-Reply-To: <20180314183213.223440-1-bmwill@google.com>
Message-Id: <20180314183213.223440-27-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v5 26/35] transport-helper: refactor process_connect_service
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
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
index 9677ead426..830f21f0a9 100644
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
2.16.2.804.g6dcf76e118-goog

