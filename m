Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CAA01F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752333AbeCORcL (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:32:11 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:32882 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752491AbeCORcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:32:09 -0400
Received: by mail-qt0-f202.google.com with SMTP id k22so4911447qtj.0
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=rYnaCDLMhOCjwbSZViYfblhc+Yoj+bmjBFBMj3B45n8=;
        b=FmzXuSQkp4UQoTC63di1tBQ6tzSykv4gV3sN1WbypwQ7CJ2LBmYPFxKO7RuC+X4Br6
         DtGINI3eoHnoCjSZ8q1hp314cWWne+Dd4qecSVwnyIMyMUROYODXeayaymeijs8acuN4
         grf7vpDPZU2vzok+y5Ci89gJTlrCxXTM17weLnqng6fLOAIdP8Bi/nnMdxYsLfH5J2nU
         yeQkkLR1TJ8dfy1Y8X73EAc/7h1DtbL2H0U+hdui9X05M4RxYeamWbWhrdn70n9zXVyg
         bK1afwKZEGgTmh4LmUZw5GTp8wuS0tUGAkHh5Vj7EVJctl2kuW4Z6anGl4Xdjn9IUyWh
         Z5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=rYnaCDLMhOCjwbSZViYfblhc+Yoj+bmjBFBMj3B45n8=;
        b=n03VDrxwY4moxe1iE2v6A9eCUo/+F1Ktg3WZwwcAsmQHK9fTsO5W75477DMq0+rFdS
         74Za8NBOSl8Z+sABBW8yegZxQfsubLIPkXEiFTajpRnZs9IOb1TZbPehKZ2fW4J+6alG
         GhOaZhDJ+AuT2R2DCI0CzmioXxcMrZNWRJGmIXGKpN8T4XNE3AIq8uANxbge7+mJYqlU
         B7qIv2sA0qUkOYIeeaEHBZs1iE9w17mzlrblusEkAh5Tv/lHgNsf68gEddWv4eq5i92O
         AncZ7ZNlTeJ1GfReVjTdK3sLsbuLgd/AMXDzjZIuExDjdsx1WYmPZDCERTzKXcLf2lwt
         EPGQ==
X-Gm-Message-State: AElRT7Fc8xZE05+gwkFw0qPb2bNUlbwsz4ARm+6v2ED7VMu/K0HU6ap9
        sE1Cm4P50kNiRr2tDRhKW9IYX8jQLfXHMs92eQVk2rTAE4+9uhtK0DH9NHfWCpesY1o4KEi5wbG
        Earp0CVHTVtBBHl7NXAmiTVU5P/g2g5ZNFsAqlwG4RAB1TFyTryvDUC+NoA==
X-Google-Smtp-Source: AG47ELsZ68rkH69ejZs0O5Li5iNhirLklqpWizxnjlWq3SCivSGvrf2Jawn4dccGh4+I8BY4d30hcTFRgb0=
MIME-Version: 1.0
X-Received: by 10.200.39.230 with SMTP id x35mr6422683qtx.49.1521135128622;
 Thu, 15 Mar 2018 10:32:08 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:31:16 -0700
In-Reply-To: <20180315173142.176023-1-bmwill@google.com>
Message-Id: <20180315173142.176023-10-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com> <20180315173142.176023-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v6 09/35] transport: store protocol version
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

