Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0417BC433E1
	for <git@archiver.kernel.org>; Mon, 18 May 2020 15:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E9020657
	for <git@archiver.kernel.org>; Mon, 18 May 2020 15:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrJPER+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgERPrp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 11:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgERPro (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 11:47:44 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1980BC061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 08:47:44 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id dh1so1046515qvb.13
        for <git@vger.kernel.org>; Mon, 18 May 2020 08:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EsqxVE19hlxPM+IuRUzPbFuzwchKeAyRF0C1KT7Dj+w=;
        b=nrJPER+QfOt4kOSRglYWnwcqom1RwoMjdtJRkDDFj80BHtN9SuaVH915tRdquw+UjY
         bSCs+pQN/mR6Gspun0rMKc4w9j2KazemOQ41kSx8JqqVPqG7YTlYqdJlxmo8jnaSLFz6
         DxhRUtJr1bGr4y5HXvZYh6MMFeMS/CieoxqluYxmAXOO367D9n+FPoEWh5f/TzIwSalM
         0CYZHxtFI/Z5N4SG5TMg/+Gok9D1Acf6rOG48mg7c7Sng86f5etKfMscpHy+P2LKWr4K
         SIoOY8Kf7O7Rs1oFLHbCCfAeRz3YQqomhMosHy/HrUkPpJDezxPlTw6whNIe8Y+ZGxNL
         1pbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EsqxVE19hlxPM+IuRUzPbFuzwchKeAyRF0C1KT7Dj+w=;
        b=OGabcWaJFA0qnvwipeItAutCn4xI4R9J/iP72mh09CNo7zLHc1A9oCionPtfb6R/Kk
         A4Fv/tLjmb/ixDq7ND7uhwmFZcFZGVbELiebig7rlcUcUjLjnzSJdk5nIUisNBXMvLPV
         eWaapX26BZEn0fiUDBsMGh6b52BuMenVXPHYjKMTzZUcVE+uidzrI63V30/3PMLqDZWx
         7qH4eAMTKOVoV/r1bPCfD0pcEe+beKC+cer67olutU6hNTgGeqYLABN1tIuM+vFv8okn
         0yBFjSn1KuVmwc0lpj4AjeTbmLDD5tZ75v8i0WcZNEWETCs6ksxmvODCNnLwvdnOGgRP
         epsA==
X-Gm-Message-State: AOAM532pilHvZ8mQ4YbOyFkn88VPAUDAHRHruliC7wv4ZDlcjHLFTBW6
        b2dV8tbSk5wXq3NZqNT6YpfrVYJy
X-Google-Smtp-Source: ABdhPJz1kUNCggNE8dHZkH9qAAhkCLIpxV+C2qhWqOCd5G98hkM+1TTlyfJzc9J6E4pY3YoUsH7Hog==
X-Received: by 2002:a05:6214:1543:: with SMTP id t3mr17158571qvw.122.1589816862816;
        Mon, 18 May 2020 08:47:42 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id z201sm5146913qkb.2.2020.05.18.08.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 08:47:42 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Force Charlie <charlieio@outlook.com>
Subject: [PATCH v2 7/7] stateless-connect: send response end packet
Date:   Mon, 18 May 2020 11:47:24 -0400
Message-Id: <4b079bcd83ea80b8a0e81b0c1e3d5e083efeb9c6.1589816719.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.706.g87896c9627
In-Reply-To: <cover.1589816718.git.liu.denton@gmail.com>
References: <cover.1589393036.git.liu.denton@gmail.com> <cover.1589816718.git.liu.denton@gmail.com>
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

Instead of blindly forwarding packets, make remote-curl insert response
end and flush packets after proxying the responses from the remote
server when using stateless_connect(). On the RPC client side, ensure
that each response ends as described.

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
 connect.c                               | 10 +++++++++-
 fetch-pack.c                            | 12 ++++++++++++
 remote-curl.c                           |  7 +++++++
 remote.h                                |  3 ++-
 t/t5702-protocol-v2.sh                  | 13 +++++++++++++
 transport.c                             |  3 ++-
 9 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index f48a031dc3..84f8e92b23 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -405,7 +405,9 @@ Supported if the helper has the "connect" capability.
 	trying to fall back).  After line feed terminating the positive
 	(empty) response, the output of the service starts.  Messages
 	(both request and response) must consist of zero or more
-	PKT-LINEs, terminating in a flush packet. The client must not
+	PKT-LINEs, terminating in a flush packet. Response messages will
+	have a response end packet before the flush packet to indicate
+	the end of a response.  The client must not
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
index 11c6ec70a0..12b57f5c0a 100644
--- a/connect.c
+++ b/connect.c
@@ -409,7 +409,8 @@ static int process_ref_v2(const char *line, struct ref ***list)
 struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     struct ref **list, int for_push,
 			     const struct argv_array *ref_prefixes,
-			     const struct string_list *server_options)
+			     const struct string_list *server_options,
+			     int stateless_rpc)
 {
 	int i;
 	*list = NULL;
@@ -446,6 +447,13 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 	if (reader->status != PACKET_READ_FLUSH)
 		die(_("expected flush after ref listing"));
 
+	if (stateless_rpc) {
+		if (packet_reader_read(reader) != PACKET_READ_RESPONSE_END)
+			die(_("expected response end packet after ref listing"));
+		if (packet_reader_read(reader) != PACKET_READ_FLUSH)
+			die(_("expected flush packet after response end"));
+	}
+
 	return list;
 }
 
diff --git a/fetch-pack.c b/fetch-pack.c
index f73a2ce6cb..bcbbb7e2fb 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1468,6 +1468,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct fetch_negotiator negotiator_alloc;
 	struct fetch_negotiator *negotiator;
 	int seen_ack = 0;
+	int check_http_delimiter;
 
 	if (args->no_dependents) {
 		negotiator = NULL;
@@ -1486,6 +1487,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	}
 
 	while (state != FETCH_DONE) {
+		check_http_delimiter = 0;
+
 		switch (state) {
 		case FETCH_CHECK_LOCAL:
 			sort_ref_list(&ref, ref_compare_name);
@@ -1542,6 +1545,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				/* fallthrough */
 			case NO_COMMON_FOUND:
 				state = FETCH_SEND_REQUEST;
+				check_http_delimiter = 1;
 				break;
 			}
 			break;
@@ -1562,10 +1566,18 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				die(_("git fetch-pack: fetch failed."));
 
 			state = FETCH_DONE;
+			check_http_delimiter = 1;
 			break;
 		case FETCH_DONE:
 			continue;
 		}
+
+		if (args->stateless_rpc && check_http_delimiter) {
+			if (packet_reader_read(&reader) != PACKET_READ_RESPONSE_END)
+				die(_("git fetch-pack: expected response end packet"));
+			if (packet_reader_read(&reader) != PACKET_READ_FLUSH)
+				die(_("git fetch-pack: expected flush packet"));
+		}
 	}
 
 	if (negotiator)
diff --git a/remote-curl.c b/remote-curl.c
index d02cb547e9..8a72b5ee7a 100644
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
@@ -991,6 +993,11 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 	if (rpc_in_data.pktline_state.remaining)
 		err = error(_("%d bytes of body are still expected"), rpc_in_data.pktline_state.remaining);
 
+	if (stateless_connect) {
+		packet_response_end(rpc->in);
+		packet_flush(rpc->in);
+	}
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
index a6002e502f..182978f4be 100644
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

