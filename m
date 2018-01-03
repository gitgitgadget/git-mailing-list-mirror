Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0165C1F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751202AbeACAS5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:18:57 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:36218 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbeACASz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:18:55 -0500
Received: by mail-io0-f194.google.com with SMTP id i143so472424ioa.3
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/m+o88bgCimyPZ0TI/aCK2UF4ynMlifUUiyFfvTcRYI=;
        b=YjmkWs8eCWcH+c/TdDSU9lEIpeZlnmEfTrYLsdp+2taud56NheuVVXA1LKy+TI2TOU
         RrnMofr6WhBOdm6q/Q0iLOUt4kG/777juhuCiLIjy0If2Jw6VsjU2O0bUZwUJWvX49ky
         sMKecyjxwqijZ4W9doO/uLpFmTAUGcnKY7nio3urAqdwR4Amll39HkzOTJL7ZDiqQjox
         /fe9p4duERzWLDZC8HysHwX/W0xeTdMYFNu4ObLj3HmxMDr+leEjefr9rxSkE/vDrqUT
         ac2NPDWcpXOD7xSppuvHh9NMWm7uCjrco5ebKWOip27Sb0XKxnxRVjjQ13I8cpS2+oTV
         x46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/m+o88bgCimyPZ0TI/aCK2UF4ynMlifUUiyFfvTcRYI=;
        b=R9zQMQE7RxIJbyCNvutGkXMTgCPWc8px5SODZ71/5V8wvGuJ8EIKs/8hpBdLGCtp8t
         WZHsUM+jRNWSA3nF1urMwv5tXYFVCCAKxalTvXc9wJcOgQm3zBBy18jl9wJi5THg39NN
         dpQbhNS3C8FVAks1MEsZy6nquX8Whe3daKoJH8xeZv63hpTCwNFeOGjSYYTMlwnjh691
         Aa9jjfKrGk1kPl8H7E34Tnub+WpB51rg45b+vEgox5atbo8RvaOzjyxxkP6WVZA9nxgC
         HHo04xSSHUOGhSF///J1BmgFDJ+ld5dgCgNTas4uLDw0mE2nVBFLchCLGLcFbKrkJprk
         pWIA==
X-Gm-Message-State: AKGB3mIQNMep8AMnJThbxffp0cN535ITzL9VoX57XGiZtlATZpG/5s/k
        Wj2TL7d5mv+r8ZaADwFyEpsCq98+sn0=
X-Google-Smtp-Source: ACJfBothJaZUcOhkMiIvo8tFdrTAOUC7roHmabaiuK5BbHMOf2byagr/vJyzO5Z0rxacX10ERzweag==
X-Received: by 10.107.12.156 with SMTP id 28mr49477428iom.94.1514938733906;
        Tue, 02 Jan 2018 16:18:53 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q2sm12679ite.17.2018.01.02.16.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 16:18:53 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 09/26] transport: store protocol version
Date:   Tue,  2 Jan 2018 16:18:11 -0800
Message-Id: <20180103001828.205012-10-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103001828.205012-1-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once protocol_v2 is introduced requesting a fetch or a push will need to
be handled differently depending on the protocol version.  Store the
protocol version the server is speaking in 'struct git_transport_data'
and use it to determine what to do in the case of a fetch or a push.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 transport.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/transport.c b/transport.c
index 63c3dbab9..2378dcb38 100644
--- a/transport.c
+++ b/transport.c
@@ -118,6 +118,7 @@ struct git_transport_data {
 	struct child_process *conn;
 	int fd[2];
 	unsigned got_remote_heads : 1;
+	enum protocol_version version;
 	struct oid_array extra_have;
 	struct oid_array shallow;
 };
@@ -200,7 +201,8 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_GENTLE_ON_EOF);
 
-	switch (discover_version(&reader)) {
+	data->version = discover_version(&reader);
+	switch (data->version) {
 	case protocol_v1:
 	case protocol_v0:
 		get_remote_heads(&reader, &refs,
@@ -221,7 +223,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 {
 	int ret = 0;
 	struct git_transport_data *data = transport->data;
-	struct ref *refs;
+	struct ref *refs = NULL;
 	char *dest = xstrdup(transport->url);
 	struct fetch_pack_args args;
 	struct ref *refs_tmp = NULL;
@@ -247,10 +249,18 @@ static int fetch_refs_via_pack(struct transport *transport,
 	if (!data->got_remote_heads)
 		refs_tmp = get_refs_via_connect(transport, 0);
 
-	refs = fetch_pack(&args, data->fd, data->conn,
-			  refs_tmp ? refs_tmp : transport->remote_refs,
-			  dest, to_fetch, nr_heads, &data->shallow,
-			  &transport->pack_lockfile);
+	switch (data->version) {
+	case protocol_v1:
+	case protocol_v0:
+		refs = fetch_pack(&args, data->fd, data->conn,
+				  refs_tmp ? refs_tmp : transport->remote_refs,
+				  dest, to_fetch, nr_heads, &data->shallow,
+				  &transport->pack_lockfile);
+		break;
+	case protocol_unknown_version:
+		BUG("unknown protocol version");
+	}
+
 	close(data->fd[0]);
 	close(data->fd[1]);
 	if (finish_connect(data->conn))
@@ -549,7 +559,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 {
 	struct git_transport_data *data = transport->data;
 	struct send_pack_args args;
-	int ret;
+	int ret = 0;
 
 	if (!data->got_remote_heads)
 		get_refs_via_connect(transport, 1);
@@ -574,8 +584,15 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	else
 		args.push_cert = SEND_PACK_PUSH_CERT_NEVER;
 
-	ret = send_pack(&args, data->fd, data->conn, remote_refs,
-			&data->extra_have);
+	switch (data->version) {
+	case protocol_v1:
+	case protocol_v0:
+		ret = send_pack(&args, data->fd, data->conn, remote_refs,
+				&data->extra_have);
+		break;
+	case protocol_unknown_version:
+		BUG("unknown protocol version");
+	}
 
 	close(data->fd[1]);
 	close(data->fd[0]);
-- 
2.15.1.620.gb9897f4670-goog

