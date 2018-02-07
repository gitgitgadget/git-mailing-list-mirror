Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D0371F404
	for <e@80x24.org>; Wed,  7 Feb 2018 01:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932209AbeBGBNj (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:13:39 -0500
Received: from mail-io0-f201.google.com ([209.85.223.201]:56533 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932199AbeBGBNh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:13:37 -0500
Received: by mail-io0-f201.google.com with SMTP id w17so3703648iow.23
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=CJjtU+n/WEXP3gYGzvksXWZevcTJVN7NgZG2rJXvgrE=;
        b=a/w6jyYZV869Mlm0UQpOGfg1+UX5lFrRrHPTSsElxqcmdqd8fKPLfaHIWaSZQ+tEDp
         cTLueYTqPheIFtIVUpM0uKQhUaBAYeOHtymGjtchWQZjtYMmll3uQ+kunasL8dxiJpQe
         6+twU/bJEcuhFepJY9Q26CJAvT5vQzwSZzY15RTCPrInhDwBwnE0cPng4rMOOvOCpUj5
         LVFwo1n/s+Qa1XGI5kJan4dG5XFi+kf7gz028pEEqFGqaxYX3thw7Z6StYjCxpGEGxNz
         mZ9fx5qc4sb3/dB7UWfK7z1I+hMgt5BRG1a8f8X77hVf57d5V2RZFMVh9td5iLujR26Z
         fuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=CJjtU+n/WEXP3gYGzvksXWZevcTJVN7NgZG2rJXvgrE=;
        b=aOdd4bwfeCNQnqbiiCmBHJzdzraSP0GHRYClc7yePsNTjbxWOkmRWQhjTlRIw+uFRT
         un+R6sBz9b3Z7fVsNuuJctkNEa23kUMpy1lMBeJxcuKFi1m1Sl8cMpV5a5aCL6RhiLEn
         SHEFLqoB3qVHaPnUwbtlDYUJKIu4Ssmn4b5iM6UCxByNCfSTZH4Vk06RPsiDjVCCqd4D
         qFxFZ0ebExlU5O2GHBsnG5RiZt8oXSkRWDTYqAivzlaHlHTFBtaByOZkKC8ip863eRiD
         wS+MYcC5i9nPFY/aBAlwUcTNHn52kGAhPTbiRD1jtDlx8ndxNvBc2TBesBqPv5E36hQe
         Y3Ww==
X-Gm-Message-State: APf1xPAYhJgKRNLC06hq/8MGSR/czcN3Nys5Zse9WsEFQehDIL2muqNf
        JpYG5p954X91995KtK8tCwJFyJEZcpDzSOQQsiCO4XjdI5Vu/yFMk9omUxcPYmdqrJLtVtcG26Y
        7izDrp7ZBQWMWkm8jdtLGLIDOTX2gpVvvxWkprVR0iucRUUrmTFs2f652oA==
X-Google-Smtp-Source: AH8x227v3BCqWftZVBlZQpMK7ZHDTEEeyct2k6t3UT77+zv6loyBlPLy6IbWP6dU02yqjtfzG16PHBLvR3Q=
MIME-Version: 1.0
X-Received: by 10.36.118.82 with SMTP id z79mr3245386itb.25.1517966016548;
 Tue, 06 Feb 2018 17:13:36 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:12:46 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180207011312.189834-10-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 09/35] transport: store protocol version
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

