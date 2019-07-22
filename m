Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 235E11F461
	for <e@80x24.org>; Mon, 22 Jul 2019 21:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbfGVVXK (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jul 2019 17:23:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33265 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731284AbfGVVXK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jul 2019 17:23:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so29659862wme.0
        for <git@vger.kernel.org>; Mon, 22 Jul 2019 14:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NKgZaQCkSOhCQlyPZEna7A8tmkDyOdvT1n4qxOuQj1E=;
        b=EBh7y3c2kNvPd/8deYWY5oE7CV1kcUzPlSotmKxbBx5uyXKs+tokfQQWdk8ABs5QXk
         9gw+u8nKQRUEkm6smYlKC6hU/xVQWP+aZId6duCsB21fs289TU1MVsrYqlKORRBQB7y4
         AzSfoXL+zWqUwPMb2ZiXzjpJ3Pmrw7jOh8bO+KUHK/dd4Tx6UUjeaDkHFeG7bq5Sx0fB
         dzxTWTBDDxTIPp+0+oDNLCsSham2lFKxd8pyFLBfxRIM3W3oldU+zG33CPtYc0NGRHMI
         cVJ/9xH836rlpKKHHa4XXy8CL7pPT3ScYmES4g8DSIOsjl/PGJBQYzCy+kDyl3xlPe8k
         Av/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NKgZaQCkSOhCQlyPZEna7A8tmkDyOdvT1n4qxOuQj1E=;
        b=omMbBa36yIsGIl+pVeEEQADNf3JqDwiHX8ClSghPVudQBSTRQ+vDs7ZHqIdadJm2dZ
         8gRzMyqV/Blq1Zq7BX9rc3NSKQr6rvC5pPEDwzqr1e2SVqGg0hSvdx6MA0VNiuJ7Ii2u
         shWh7r9rxB8GQJaeb/tRbBUV7gOtov1KcJe1ibLPTyAa82+CFFfP8VAm2iAyVa3BJYg3
         FlEYwSrhdcs34T3E01sXRFm68p9m0itMsGhs5TSFsDljZGDkiAtvGEFohG6vXsl9900X
         XVpLmXCYbx9qC4BsZKLVSw4897VbX/cWSzDYLCipeSf92aEScaWmuzbsCa1TPI78w9Dg
         wPfA==
X-Gm-Message-State: APjAAAXHzfstT9SydGElxxDFUF1FRQOxlqw3mh/xSbXcbG8fG0a4b0O4
        Ri5gM38jJiZg9jQIukYC6bzTEx6I
X-Google-Smtp-Source: APXvYqxlNc6dCcrKPnsvhyOysDVSP3VWwJKsnlULMeKVQt2zih/DScJJKHYOc6t5fL9nsa1YmbqZTA==
X-Received: by 2002:a7b:c195:: with SMTP id y21mr63445212wmi.16.1563830588070;
        Mon, 22 Jul 2019 14:23:08 -0700 (PDT)
Received: from Thibaults-MBP.home ([92.177.233.89])
        by smtp.gmail.com with ESMTPSA id b15sm55553865wrt.77.2019.07.22.14.23.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 14:23:07 -0700 (PDT)
From:   thibault.jamet@gmail.com
To:     git@vger.kernel.org
Cc:     thibault.jamet@adevinta.com,
        Thibault Jamet <thibault.jamet@gmail.com>
Subject: [PATCH] Close transport helper on protocol error
Date:   Mon, 22 Jul 2019 23:22:50 +0200
Message-Id: <20190722212250.44011-1-thibault.jamet@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Thibault Jamet <thibault.jamet@gmail.com>

We have noticed that in some cases, when the transport is not fully
compliant with the protocol, git exits with a status of 128 without
closing the transport.

This usually does not have consequences in a standard unix
environment as the process gets then attached to the init one which will
then take care of closing properly the remaining transport.

We remarkably noticed this behaviour on GitHub Enterprise v2.14.24 when
a repository has been migrated to another GitHub Enterprise instance.
The output of the transport is then:

remote: Repository `org/repo' is disabled. Please ask the owner to check their account.
fatal: unable to access 'https://github.example.com/org/repo/': The requested URL returned error: 403

and the code exits inside function get_refs_list

In container contexts, there might not be such an init process
to take care of terminating the transport process and hence they remain
as zombies, as mentioned in
https://github.com/rancher/rancher/issues/13858 or
https://github.com/coreos/clair/issues/441.

Although there is a work-around running an init inside the container,
clean-up the processes created at the time git exits.

Signed-off-by: Thibault Jamet <thibault.jamet@gmail.com>
---
 transport-helper.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index cec83bd663..34caa75a72 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -101,6 +101,12 @@ static void do_take_over(struct transport *transport)
 
 static void standard_options(struct transport *t);
 
+static int disconnect_helper(struct transport *transport);
+
+static int disconnect_helper_data(struct helper_data *data);
+
+static int release_helper(struct transport *transport);
+
 static struct child_process *get_helper(struct transport *transport)
 {
 	struct helper_data *data = transport->data;
@@ -155,8 +161,10 @@ static struct child_process *get_helper(struct transport *transport)
 	while (1) {
 		const char *capname, *arg;
 		int mandatory = 0;
-		if (recvline(data, &buf))
+		if (recvline(data, &buf)){
+			release_helper(transport);
 			exit(128);
+		}
 
 		if (!*buf.buf)
 			break;
@@ -215,10 +223,14 @@ static struct child_process *get_helper(struct transport *transport)
 
 static int disconnect_helper(struct transport *transport)
 {
-	struct helper_data *data = transport->data;
+	return disconnect_helper_data(transport->data);
+}
+
+static int disconnect_helper_data(struct helper_data *data)
+{
 	int res = 0;
 
-	if (data->helper) {
+	if (data && data->helper) {
 		if (debug)
 			fprintf(stderr, "Debug: Disconnecting.\n");
 		if (!data->no_disconnect_req) {
@@ -261,8 +273,10 @@ static int strbuf_set_helper_option(struct helper_data *data,
 	int ret;
 
 	sendline(data, buf);
-	if (recvline(data, buf))
+	if (recvline(data, buf)) {
+		disconnect_helper_data(data);
 		exit(128);
+	}
 
 	if (!strcmp(buf->buf, "ok"))
 		ret = 0;
@@ -366,10 +380,12 @@ static void standard_options(struct transport *t)
 static int release_helper(struct transport *transport)
 {
 	int res = 0;
-	struct helper_data *data = transport->data;
-	refspec_clear(&data->rs);
-	res = disconnect_helper(transport);
-	free(transport->data);
+	if (transport){
+		struct helper_data *data = transport->data;
+		refspec_clear(&data->rs);
+		res = disconnect_helper(transport);
+		free(transport->data);
+	}
 	return res;
 }
 
@@ -394,8 +410,10 @@ static int fetch_with_fetch(struct transport *transport,
 	sendline(data, &buf);
 
 	while (1) {
-		if (recvline(data, &buf))
+		if (recvline(data, &buf)){
+			release_helper(transport);
 			exit(128);
+		}
 
 		if (starts_with(buf.buf, "lock ")) {
 			const char *name = buf.buf + 5;
@@ -561,8 +579,10 @@ static int run_connect(struct transport *transport, struct strbuf *cmdbuf)
 	setvbuf(input, NULL, _IONBF, 0);
 
 	sendline(data, cmdbuf);
-	if (recvline_fh(input, cmdbuf))
+	if (recvline_fh(input, cmdbuf)){
+		release_helper(transport);
 		exit(128);
+	}
 
 	if (!strcmp(cmdbuf->buf, "")) {
 		data->no_disconnect_req = 1;
@@ -1074,8 +1094,10 @@ static struct ref *get_refs_list(struct transport *transport, int for_push,
 
 	while (1) {
 		char *eov, *eon;
-		if (recvline(data, &buf))
+		if (recvline(data, &buf)){
+			release_helper(transport);
 			exit(128);
+		}
 
 		if (!*buf.buf)
 			break;
-- 
2.21.0

