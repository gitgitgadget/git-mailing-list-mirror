Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 093D91F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbeCORc5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:32:57 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:41053 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbeCORcu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:32:50 -0400
Received: by mail-ua0-f201.google.com with SMTP id w9so4589636uae.8
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=CE+IVmWSlHtw8Cv8fPt1g83Xs1Hr1WxGRZhRApvhSOU=;
        b=q3XwffNQo2stME5ZlQed3mrSx0Rm0Uy73BN8Yo0jlWW5EPbWgAoj5kDoA9nzrcAhWC
         uHAN11qFoo+mzpF30wFCdeyb+/Z5Vyu8IWLml+ziP/BNFKarheF0ZPM0eJbFgmZfjo76
         8ghrBMju1MZjGiR7m+S0uh4h38fsrXKrEhNn3i8U9eeg1wlr3b6T4nZTBld0dMC6n4Em
         F5dcwvywIu5AgpcykAjS/5uxQPw8Y4KJDHk2XvlE99IHksrz8tXCiEwtdMsJinpSaAF5
         zIJzeZp5k762XfRVanKkAxgWTbTfXwJ5OtAxoS0euzdDC9LqksiHGRipNjKrVQcQAtrb
         amkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=CE+IVmWSlHtw8Cv8fPt1g83Xs1Hr1WxGRZhRApvhSOU=;
        b=jDg7SwQiGO7vDHuXh4kQ1MTxJFJ91ggGoOsuADk9nZjnnA+soUKm/6UZxm2ta9oa1G
         5sbrtEaoFtfVsyIMDwW6ZT5MjhXmpdIFZfXLCQ9bc96x52s+VVDUi0EhQNXpvxo4Ushv
         vNrBvWiG/u6MfftQZAIB1KPpoMnV3t9V2cMgvJkLciKcv1Cm8eWw2GhTsolP36BPLlFP
         MzKhvivwGoIGX+CiBsEBJPTzoG1VfkYrYFMnFTITFMn4BjTP/eQN8MRboJbmuC0/gLuF
         74rMHAvhMNJWy0cMIDlWfYtVSl0zB11qmAS/yjpcE9LYFlH/Spqn6IPG3mL0oLpoaGjI
         HB6g==
X-Gm-Message-State: AElRT7Gmj2hFt8mxyvyr/lYau1MpFVo4pCrRenfX86lv1IKg7i0XmuFY
        n1Aq2I1QtcDQkCOnSs0wnPqVnuH0YDisLhTPLbX9oWu2gun5bgzmddFDLj3SRqJH1fXhVdCCWpt
        AZMVV42/XZMXIha7+IkRu1sua6DrwRKPthqYIxNr/gPa6U+45NvlYU9oIJA==
X-Google-Smtp-Source: AG47ELsxYWZzJ9SCqGfN/vTBNEoXRuSwp3oCFKBLxXNHUaTNiLzb1DjZRfaEhcQ1PExXSUINxlfxT0cnjA0=
MIME-Version: 1.0
X-Received: by 10.176.76.137 with SMTP id y9mr3153950uaf.118.1521135169532;
 Thu, 15 Mar 2018 10:32:49 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:31:33 -0700
In-Reply-To: <20180315173142.176023-1-bmwill@google.com>
Message-Id: <20180315173142.176023-27-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com> <20180315173142.176023-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v6 26/35] transport-helper: refactor process_connect_service
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

