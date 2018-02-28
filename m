Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15AE91F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964989AbeB1XXq (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:23:46 -0500
Received: from mail-yw0-f202.google.com ([209.85.161.202]:36848 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964980AbeB1XXl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:23:41 -0500
Received: by mail-yw0-f202.google.com with SMTP id v19so2387221ywg.3
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=mEG4/PJf89FMRzx9x7XMpHmn0lTlwGmi66Q+Z4ZBDxM=;
        b=h6C2UnI6ZzxlZDfSbKKXEUEVcKgGEy0XrLtwdFDDHQ2EAwodkgoB0qyquPtNsuxGoR
         4ie8kyX1BZAjeKZ/t/l5FF8S7FOQ7KjlVP3J460tycTFdCz6fkhfYqoa2tFJm8Xb3Dhi
         Hps0FwuljnXF6BEvW7YMuJByI55NflTYGJn3ABpSNBKsMu+fchb8DcBIFdNcPb8aAYMn
         bMvFWkrS9Bw9Es1w26i4kadRqy2IlOv08M581z482AZBaoicrNn3qYEsDwUEljRFjz8L
         +tZOmGlZS6D0GVZza8UdCjTeXkb9Lv6qJE0XL+WI6JXfVdvtCgggygFDKb2hBhmUXXgU
         ChNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=mEG4/PJf89FMRzx9x7XMpHmn0lTlwGmi66Q+Z4ZBDxM=;
        b=XDFrI8iMVDvkC9NSp4B0mcqRFmNDwePDJW3FAUvdILecfiIESGYHUHnZhcRYYgw5Gj
         ehpTVT5UqLxGHrvvMV6hD36gBfOb0+4RXmbHEPtFdd4nSwbhCIMot7zxCKOwfA3cZnhd
         MC4bj1JaXlxj/V2wMj32A9JECb9Tv7KBOR0k9A4lDD6Wpmv5st6VtcKwN8lYiu/JZxt7
         LW17Z4l386I8bb64bhRbnQta+UaYSG2UqsdlpKtKy9OT0PV+4d/DZKOC+bV1P5uvJJxn
         md0B4CZaj71cN6Ss+ByXd43Og8CS8+BZ+pF01FB8r9YF8Yb2nIWmRICsrqo37VhvoxZC
         d8DQ==
X-Gm-Message-State: APf1xPCrdq/WvlIpywnsXVhRPJzMA1jxI/DVf4O+OwAJnXmloAvFFRMD
        EiPwjNO5uSKxFarik/ov/PKvfQR8MQhl6Hlq1TEIw1aV4sIlsa9QHmyyJb+cwfJypklfHnDB10e
        GWrpCSsFuYH8CXBUCh4fM7wWONDtbkFRzzA70UNuHMr8QtR7+IUyCx5hhoA==
X-Google-Smtp-Source: AH8x225Z72YWojD+I3lOBvJkr5ICltqtbKUYO5CagRLwpw2uM4IUok6L+jVQPouXBknOyvbEhHNaP8jeSrg=
MIME-Version: 1.0
X-Received: by 10.129.181.68 with SMTP id c4mr10075683ywk.69.1519860220503;
 Wed, 28 Feb 2018 15:23:40 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:26 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-10-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 09/35] transport: store protocol version
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
2.16.2.395.g2e18187dfd-goog

