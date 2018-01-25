Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C6011F404
	for <e@80x24.org>; Thu, 25 Jan 2018 23:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeAYX7l (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 18:59:41 -0500
Received: from mail-vk0-f74.google.com ([209.85.213.74]:36233 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751852AbeAYX7i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 18:59:38 -0500
Received: by mail-vk0-f74.google.com with SMTP id n186so5044126vkc.3
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 15:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=3IzS4UfEupUub3EHuboXCbwC4mTd8S8Xal1/BtsomDM=;
        b=PMYWO71CEqx5nF+R4l6iZzJFb/eKG8MUkaV87BO/jZN/oLcwa1ky/baURXPGJ/vhmJ
         dhgJXzn9CNGV4F5nKSEOTKv+VEYSbIyQR8XI4vj/OHJt2/8DsbYzQC8hU2toa/hW+65J
         53mo6+ddES1o9fDGAPNCFx7e35Rk/FX4/j7vuud4mU/kyMDkLtjb4QNefDzXUPX2jNjq
         533Gjd0CCZUxibJGknXQUkhuBEDp1XedEnBsJcz2gI/icUV+wC2Y/G+w/OssjXHu5A/J
         J3ejf1Z+ICtCpebQpu6JofJwEKyQcaX1DYx48ahOa6gBPjLFYwPWwFwSNRApvs/UGuQ5
         /SQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=3IzS4UfEupUub3EHuboXCbwC4mTd8S8Xal1/BtsomDM=;
        b=kLncWmtaWnxlJIgVHI8ecM4PGK9UQHgCXT1hZQdEDsnNC1Z5vGy/oFslXdYc6CrRzU
         e8Rwza53jLvVyaG2Zijmq5fehPs6k4CSy1BMdViKJZxblbP2InU9jkL+QfZkWvn/P3Lh
         XoBTNl6OlMF4KBLBhVmpZ43dzMIdcUGugGhvIEHXWmDDL1ubh7QoR300zAHLDyhQutJI
         qA5sFlHOia2LFWlXJ6sLd9aAiDLOXyBp+vzJ1kppFpiuvpyvWsUHGxeyJIziYKD6+7j0
         dhz6grhqC5QX7ddy+En2SjD4Yl3bWo74lhxBFtnSAJjW+BmGp1FvrTMhNJsuNESWuqAo
         93Ug==
X-Gm-Message-State: AKwxyteyY9ib5r9ygdZ5bVDVEuT4fY/OWeoypXtQjHVpGh0gO6q0sRf0
        ceRNb3RGBTAbHGMDfTC1EWokMHq+WK7+KS5D8mY9iMAObMvUJDPMdbSt1DvZZutJKeutHCGIAaV
        M/3K93ScVIgwhl42b5+foWS9CzSsT1z9nAICe1YVAQ7zBIH/pPuD8P4QdZQ==
X-Google-Smtp-Source: AH8x227++qg3BKjbg/Yfjz8UySxwO6psmF7gaufVXaxYmGbpiaaMo+ReRGpmDs5kahlGFp9xO7d5TXXV76E=
MIME-Version: 1.0
X-Received: by 10.159.52.105 with SMTP id s41mr5794295uab.34.1516924777158;
 Thu, 25 Jan 2018 15:59:37 -0800 (PST)
Date:   Thu, 25 Jan 2018 15:58:34 -0800
In-Reply-To: <20180125235838.138135-1-bmwill@google.com>
Message-Id: <20180125235838.138135-24-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180125235838.138135-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v2 23/27] transport-helper: refactor process_connect_service
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
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

