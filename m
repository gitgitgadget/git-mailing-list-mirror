Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60D051F404
	for <e@80x24.org>; Thu, 25 Jan 2018 23:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751794AbeAYX7L (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 18:59:11 -0500
Received: from mail-oi0-f74.google.com ([209.85.218.74]:51540 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751588AbeAYX7F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 18:59:05 -0500
Received: by mail-oi0-f74.google.com with SMTP id u194so5270653oia.18
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 15:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=CJjtU+n/WEXP3gYGzvksXWZevcTJVN7NgZG2rJXvgrE=;
        b=NY994TWwIlK7TWBWlKdXmV2cr0E6gr68SDTaD+T+QDKepuafJf5uART9qXOKqSYU5P
         PLOZKmP0dhLya12Loc8d8i2p+RVG9diO5rSyLfic4QIKE3K+xWGG2Ak2iiFpv6BTmcnn
         nAldYv4Q6SJlJM3faIhFavEbUlKA0McMFzZPuaqd4MYBil/ru5JCaE/H5yrpadZGYWFn
         7A8IRIdo2OHMX7E5/sv0vOP/mTrvDbZs3B46zbWsVYM3LATlJFX4VfSZVk1sP7+pSzvE
         rGapvejjIplVXkUbVQWa2NVUxmJfiAX3JNOwXVk8hRETFk/D+Bpsf4VBSAYyFooWw+lK
         CHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=CJjtU+n/WEXP3gYGzvksXWZevcTJVN7NgZG2rJXvgrE=;
        b=cIGqWrKqNDWYhZ5R7C6YjigW52HHw5ZDWXPcRn+0PSbM3Qmy7K3/lXTTiZnlMtjtKT
         Vu7vkJVOThnF5vhEcGlNmkpqB43Nkr2C5xnq0kWDwGvq1duoq+jsmGmegv5t7ZO/2T1z
         VAmDx62NpitJGaHQUzSAGhrjBXWi8kd4Gu0/+hCkVScT/82ibHm1SVefmgngEQbBmByC
         UDUWDnwyEKl959U0Q0OKhCRHWZDkelJXG91zFOyQXHacDgBfCYLFUjfx6xBhNpzxw3T7
         wtGYPo0SPmTBG1rN+SxfNbIPAEijfRoRYTHKzWO/jSI99BT0HhdenmH8HAvjiRPv7Jm/
         KX+A==
X-Gm-Message-State: AKwxytf3UPtGK7x1XbgCF0bEykZqSmFtJTUmsXvoT+G+yuSh8FzHwLcQ
        +S8O7dCsGj/Qq6Ce21pFSrk9TS9rT3fJx5tmk+OBejmHjAX462Ycaia0oPZxPZ3fvmTo0gfRN0s
        OyfmpWImQ62p7LfOwaBhvJByRE1vJEgE/WxFJdp7EF11k6jmlayA2leNUaw==
X-Google-Smtp-Source: AH8x225rYGubrNTAA/eCsRAgUPRWO7C4teKjJyb3pDKEDPvMBB072199azihg/iN16gW0KcDWCbPjNh63rs=
MIME-Version: 1.0
X-Received: by 10.202.219.198 with SMTP id s189mr8041482oig.83.1516924744167;
 Thu, 25 Jan 2018 15:59:04 -0800 (PST)
Date:   Thu, 25 Jan 2018 15:58:20 -0800
In-Reply-To: <20180125235838.138135-1-bmwill@google.com>
Message-Id: <20180125235838.138135-10-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180125235838.138135-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v2 09/27] transport: store protocol version
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
2.16.0.rc1.238.g530d649a79-goog

