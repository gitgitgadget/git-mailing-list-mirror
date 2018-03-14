Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A22D1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 18:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752146AbeCNSel (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:34:41 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:49509 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752343AbeCNScj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:32:39 -0400
Received: by mail-ua0-f202.google.com with SMTP id d3so2585604uae.16
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=rYnaCDLMhOCjwbSZViYfblhc+Yoj+bmjBFBMj3B45n8=;
        b=OG8L541Fay6tAu0nVW2AgLyLIlJswM7ykD2Zkho53t+IuxVVmcnsj2AIvPFUCLkcpJ
         soBxMesCcdBqhnN8lZ6MQgxVl2BXqyhdUinqSXVmCTHhPsvcDFZ7k6U2b/BiZ/T83lKu
         OHD02AbxlOsw0S/27OPjrywgPhxH/7e3i+uJIsx0uVp7xpjoLXY3D+TPYD5C9Kt59EyR
         YEIXK2XjSi29cMiT8zwx+eza0lsRFX2752W1a5HehYYZ0jyONBMTtpKRsUkd7SiajYs8
         2blR+o0nres/oUi1LCvBDrCFK6ZSW5J5FdPPnsYTWOLMRWpUc+PxD0ft7sGhRoWW80Hy
         BstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=rYnaCDLMhOCjwbSZViYfblhc+Yoj+bmjBFBMj3B45n8=;
        b=aQ3ZiSCoNypIM59Z6SZUhrEl0McxHu0wXOHRgvzonYWw4pQKTTKKkpr/wNi9LjsKfW
         0X9wcPoO7LXyl0iKWC/3D0n1krypLEVAyry8IbeadFiPgTvEJkiXZ0YQDoBfLWeXIebn
         tu8xogsPRbW/pFeC9k6A7JpyKF4vfEQInx6BXrKZdnk7Np5n2QL1ADi5ZjOlL1TinGxv
         gtmsOam88EOOelgB8x2ZrvB4pvBreUzprwFE6f4E02owSLR47zv/f4K4pMvu5ezUF0Ig
         7viO88SQhb+zq2ADYfIZjbGcFkEd9Xv40VmQIZ5chgcQMc28LoEyz9D98EWQ0c1fV1F9
         nrwQ==
X-Gm-Message-State: AElRT7Gbrq7JNhd2dIxLr5TkkSyr8wQMgsrKieh/Rllyj/Djz6z5UQAs
        hY3ZWLuFn3BDdBFHhQ39404uUNXCjc/leGngX/jsE8NwyufjLoMGyC2mEbp9WcKSbxQUdKWiXRP
        XPSkiVSYEUj71lyHSnlDr4uoS8AVDYZDpDJpG7VzJOku1PKfC+CtN3MkPJg==
X-Google-Smtp-Source: AG47ELtyHaUXJ+fbfWa7LEoF74VCTOKiXO2hSYfISmeNYVfZfUlUk4H10vksqxgg0hSf3tO4vlOt6KOYT6E=
MIME-Version: 1.0
X-Received: by 10.176.89.174 with SMTP id g43mr2407372uad.4.1521052358337;
 Wed, 14 Mar 2018 11:32:38 -0700 (PDT)
Date:   Wed, 14 Mar 2018 11:31:46 -0700
In-Reply-To: <20180314183213.223440-1-bmwill@google.com>
Message-Id: <20180314183213.223440-10-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v5 09/35] transport: store protocol version
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

Once protocol_v2 is introduced requesting a fetch or a push will need to
be handled differently depending on the protocol version.  Store the
protocol version the server is speaking in 'struct git_transport_data'
and use it to determine what to do in the case of a fetch or a push.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 transport.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/transport.c b/transport.c
index 63c3dbab94..2378dcb38c 100644
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
2.16.2.804.g6dcf76e118-goog

