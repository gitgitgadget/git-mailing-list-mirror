Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1C7C433E0
	for <git@archiver.kernel.org>; Tue, 19 May 2020 10:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F349206D4
	for <git@archiver.kernel.org>; Tue, 19 May 2020 10:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1TzDpH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgESKyW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 06:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728625AbgESKyV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 06:54:21 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F797C05BD09
        for <git@vger.kernel.org>; Tue, 19 May 2020 03:54:20 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id p12so10660741qtn.13
        for <git@vger.kernel.org>; Tue, 19 May 2020 03:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=99UkvxAYs9mF93dxO73Sz5GT3PvnfX6LAik4PfDQmcc=;
        b=n1TzDpH2IcM0XmWdAvPdq+uOhXD/hJR8EEPCJ7A9PbdP1BbIhRMu88XlBMKTK1CPZl
         X4vl9mZd+lGmxDqtIdo9bBwjrIVDqvS4o/qzrOnM8DGC8QN+w8RakPdFxdzJarEFGx1R
         imluvHMxDxy0lJZUI9tOxTagwSrFcEZBgWc2k915CkZRldUC+aK3bk5fEBWJaDMNA3rP
         SPG8OvagIP8BeXyLPMZVVdta4iCLWGCrUR9Q/wprwBQG2u2tkjpESlCAwZ/aNbuJ7pLt
         ZEsgKg4UmE7IfrCdekamhS1nfmjM4rmiRc2LJ5wznN5RUkUXVzLQPSx4bjbXTMO9xNvi
         Q3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=99UkvxAYs9mF93dxO73Sz5GT3PvnfX6LAik4PfDQmcc=;
        b=stuIDaLXgsIA1bCQGuSaD73KMFqe8c2R92WNpVo1xMyNvTvq6yuvPzH9FmTMF+mqAP
         NsM6EAn+KA/Kv2mm4I2QBur05kRYFQ8hDUh7R1c4n9HQpX4F1wTyFLiMwdbjjJBhu9AT
         AX2aA8GitPivmPUuXBy6PVl/YC79KfsuhtGX+KP0xCVt1Vhz6cmImjajQGf7NZY6fwqS
         hRWZfbR4O/SpYvQQ3RYGOtuyK3U/JpX4TQtsHplRgq0BuytWzpMinh6Oub2S5pllGIOG
         tdJ6zBQyBEgOj8HA3Xpf0YAsyh0dVDSjaLXYFLpvUjcQQvpR/Zn6Q0C7a99SPJ6QKtHa
         6P7Q==
X-Gm-Message-State: AOAM5301Qcw0J3elwOis/lEXUIw4yC9z/dtMjRIqsJVv/spmAaGo/DHw
        0jdzOdlCJxItWZ1EUMzADQKSx0PC
X-Google-Smtp-Source: ABdhPJwxiD5R4PviiblHSXag0lPNHLM9+sEaIoJ7KyAWeuP7/PA1bPueDRAa4cLi5xMPrn/ubZId+w==
X-Received: by 2002:aed:2ce4:: with SMTP id g91mr21896395qtd.22.1589885658970;
        Tue, 19 May 2020 03:54:18 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id c63sm10177775qkf.131.2020.05.19.03.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 03:54:18 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Force Charlie <charlieio@outlook.com>
Subject: [PATCH v3 7/7] stateless-connect: send response end packet
Date:   Tue, 19 May 2020 06:54:00 -0400
Message-Id: <c26e160fbc211f1fbb4e231a1c4a4b84fa347cf6.1589885479.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.706.g87896c9627
In-Reply-To: <cover.1589885479.git.liu.denton@gmail.com>
References: <cover.1589816718.git.liu.denton@gmail.com> <cover.1589885479.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, remote-curl acts as a proxy and blindly forwards packets
between an HTTP server and fetch-pack. In the case of a stateless RPC
connection where the connection is terminated before the transaction is
complete, remote-curl will blindly forward the packets before waiting on
more input from fetch-pack. Meanwhile, fetch-pack will read the
transaction and continue reading, expecting more input to continue the
transaction. This results in a deadlock between the two processes.

This can be seen in the following command which does not terminate:

	$ git -c protocol.version=2 clone https://github.com/git/git.git --shallow-since=20151012
	Cloning into 'git'...

whereas the v1 version does terminate as expected:

	$ git -c protocol.version=1 clone https://github.com/git/git.git --shallow-since=20151012
	Cloning into 'git'...
	fatal: the remote end hung up unexpectedly

Instead of blindly forwarding packets, make remote-curl insert a
response end packet after proxying the responses from the remote server
when using stateless_connect(). On the RPC client side, ensure that each
response ends as described.

A separate control packet is chosen because we need to be able to
differentiate between what the remote server sends and remote-curl's
control packets. By ensuring in the remote-curl code that a server
cannot send response end packets, we prevent a malicious server from
being able to perform a denial of service attack in which they spoof a
response end packet and cause the described deadlock to happen.

Reported-by: Force Charlie <charlieio@outlook.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/gitremote-helpers.txt     |  4 +++-
 Documentation/technical/protocol-v2.txt |  2 ++
 builtin/fetch-pack.c                    |  2 +-
 connect.c                               | 16 +++++++++++++++-
 connect.h                               |  4 ++++
 fetch-pack.c                            | 13 +++++++++++++
 remote-curl.c                           |  5 +++++
 remote.h                                |  3 ++-
 t/t5702-protocol-v2.sh                  | 13 +++++++++++++
 transport.c                             |  3 ++-
 10 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index f48a031dc3..93baeeb029 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -405,7 +405,9 @@ Supported if the helper has the "connect" capability.
 	trying to fall back).  After line feed terminating the positive
 	(empty) response, the output of the service starts.  Messages
 	(both request and response) must consist of zero or more
-	PKT-LINEs, terminating in a flush packet. The client must not
+	PKT-LINEs, terminating in a flush packet. Response messages will
+	then have a response end packet after the flush packet to
+	indicate the end of a response.  The client must not
 	expect the server to store any state in between request-response
 	pairs.  After the connection ends, the remote helper exits.
 +
diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 7e3766cafb..3996d70891 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -33,6 +33,8 @@ In protocol v2 these special packets will have the following semantics:
 
   * '0000' Flush Packet (flush-pkt) - indicates the end of a message
   * '0001' Delimiter Packet (delim-pkt) - separates sections of a message
+  * '0002' Message Packet (response-end-pkt) - indicates the end of a response
+    for stateless connections
 
 Initial Client Request
 ----------------------
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 4771100072..94b0c89b82 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -224,7 +224,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	version = discover_version(&reader);
 	switch (version) {
 	case protocol_v2:
-		get_remote_refs(fd[1], &reader, &ref, 0, NULL, NULL);
+		get_remote_refs(fd[1], &reader, &ref, 0, NULL, NULL, args.stateless_rpc);
 		break;
 	case protocol_v1:
 	case protocol_v0:
diff --git a/connect.c b/connect.c
index 11c6ec70a0..0df45a1108 100644
--- a/connect.c
+++ b/connect.c
@@ -406,10 +406,21 @@ static int process_ref_v2(const char *line, struct ref ***list)
 	return ret;
 }
 
+void check_stateless_delimiter(int stateless_rpc,
+			      struct packet_reader *reader,
+			      const char *error)
+{
+	if (!stateless_rpc)
+		return; /* not in stateless mode, no delimiter expected */
+	if (packet_reader_read(reader) != PACKET_READ_RESPONSE_END)
+		die("%s", error);
+}
+
 struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     struct ref **list, int for_push,
 			     const struct argv_array *ref_prefixes,
-			     const struct string_list *server_options)
+			     const struct string_list *server_options,
+			     int stateless_rpc)
 {
 	int i;
 	*list = NULL;
@@ -446,6 +457,9 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 	if (reader->status != PACKET_READ_FLUSH)
 		die(_("expected flush after ref listing"));
 
+	check_stateless_delimiter(stateless_rpc, reader,
+				  _("expected response end packet after ref listing"));
+
 	return list;
 }
 
diff --git a/connect.h b/connect.h
index 5f2382e018..235bc66254 100644
--- a/connect.h
+++ b/connect.h
@@ -22,4 +22,8 @@ int server_supports_v2(const char *c, int die_on_error);
 int server_supports_feature(const char *c, const char *feature,
 			    int die_on_error);
 
+void check_stateless_delimiter(int stateless_rpc,
+			       struct packet_reader *reader,
+			       const char *error);
+
 #endif
diff --git a/fetch-pack.c b/fetch-pack.c
index f73a2ce6cb..f096442d4d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1450,6 +1450,13 @@ enum fetch_state {
 	FETCH_DONE,
 };
 
+static void do_check_stateless_delimiter(const struct fetch_pack_args *args,
+					 struct packet_reader *reader)
+{
+	check_stateless_delimiter(args->stateless_rpc, reader,
+				  _("git fetch-pack: expected response end packet"));
+}
+
 static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				    int fd[2],
 				    const struct ref *orig_ref,
@@ -1534,6 +1541,10 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			/* Process ACKs/NAKs */
 			switch (process_acks(negotiator, &reader, &common)) {
 			case READY:
+				/*
+				 * Don't check for response delimiter; get_pack() will
+				 * read the rest of this response.
+				 */
 				state = FETCH_GET_PACK;
 				break;
 			case COMMON_FOUND:
@@ -1541,6 +1552,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				seen_ack = 1;
 				/* fallthrough */
 			case NO_COMMON_FOUND:
+				do_check_stateless_delimiter(args, &reader);
 				state = FETCH_SEND_REQUEST;
 				break;
 			}
@@ -1560,6 +1572,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			process_section_header(&reader, "packfile", 0);
 			if (get_pack(args, fd, pack_lockfile, sought, nr_sought))
 				die(_("git fetch-pack: fetch failed."));
+			do_check_stateless_delimiter(args, &reader);
 
 			state = FETCH_DONE;
 			break;
diff --git a/remote-curl.c b/remote-curl.c
index d02cb547e9..75532a8bae 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -703,6 +703,8 @@ static void check_pktline(struct check_pktline_state *state, const char *ptr, si
 				state->remaining = packet_length(state->len_buf);
 				if (state->remaining < 0) {
 					die(_("remote-curl: bad line length character: %.4s"), state->len_buf);
+				} else if (state->remaining == 2) {
+					die(_("remote-curl: unexpected response end packet"));
 				} else if (state->remaining < 4) {
 					state->remaining = 0;
 				} else {
@@ -991,6 +993,9 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 	if (rpc_in_data.pktline_state.remaining)
 		err = error(_("%d bytes of body are still expected"), rpc_in_data.pktline_state.remaining);
 
+	if (stateless_connect)
+		packet_response_end(rpc->in);
+
 	curl_slist_free_all(headers);
 	free(gzip_body);
 	return err;
diff --git a/remote.h b/remote.h
index 11d8719b58..5cc26c1b3b 100644
--- a/remote.h
+++ b/remote.h
@@ -179,7 +179,8 @@ struct ref **get_remote_heads(struct packet_reader *reader,
 struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     struct ref **list, int for_push,
 			     const struct argv_array *ref_prefixes,
-			     const struct string_list *server_options);
+			     const struct string_list *server_options,
+			     int stateless_rpc);
 
 int resolve_remote_symref(struct ref *ref, struct ref *list);
 
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 4eb81ba2d4..8da65e60de 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -620,6 +620,19 @@ test_expect_success 'clone repository with http:// using protocol v2 with incomp
 	test_i18ngrep "bytes of body are still expected" err
 '
 
+test_expect_success 'clone with http:// using protocol v2 and invalid parameters' '
+	test_when_finished "rm -f log" &&
+
+	test_must_fail env GIT_TRACE_PACKET="$(pwd)/log" GIT_TRACE_CURL="$(pwd)/log" \
+		git -c protocol.version=2 \
+		clone --shallow-since=20151012 "$HTTPD_URL/smart/http_parent" http_child_invalid &&
+
+	# Client requested to use protocol v2
+	grep "Git-Protocol: version=2" log &&
+	# Server responded using protocol v2
+	grep "git< version 2" log
+'
+
 test_expect_success 'clone big repository with http:// using protocol v2' '
 	test_when_finished "rm -f log" &&
 
diff --git a/transport.c b/transport.c
index 431a93caef..7d50c502ad 100644
--- a/transport.c
+++ b/transport.c
@@ -297,7 +297,8 @@ static struct ref *handshake(struct transport *transport, int for_push,
 		if (must_list_refs)
 			get_remote_refs(data->fd[1], &reader, &refs, for_push,
 					ref_prefixes,
-					transport->server_options);
+					transport->server_options,
+					transport->stateless_rpc);
 		break;
 	case protocol_v1:
 	case protocol_v0:
-- 
2.26.2.706.g87896c9627

