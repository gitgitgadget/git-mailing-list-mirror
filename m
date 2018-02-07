Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 869A41FAE2
	for <e@80x24.org>; Wed,  7 Feb 2018 01:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932261AbeBGBOT (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:14:19 -0500
Received: from mail-yw0-f202.google.com ([209.85.161.202]:38660 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932237AbeBGBOK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:14:10 -0500
Received: by mail-yw0-f202.google.com with SMTP id g126so129083ywb.5
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=kDDOvcqbECz6crr0njOPUYaoDI7B+EvagSKUHTV6cXo=;
        b=ZIYMgk8MkLv1zI40zbbqS8S553pbFu1g1JR0OkEXi9/TDD/RtLt1BO+zdLaKf1gb76
         XqNJwh55DqBQEmxDzyIXj37i4G7TyHuqQ8FhDQYXYiV4IgA5z/Tq2Tsj8QWmmwNKr1Xw
         gjH184q85e3oV9gl4vPJuI2N9g+Ez7xP3sSL19uzVU9FkAOpLzudWXlSFoIHAn6rvyBw
         +OxOc5FP2vOoRTDsnj0aI5sNGBHjOZt3GfHUqM3JeXbIWjCTxXp1rAfAGDmYBUy5Nx3b
         PUivTcwvWZ6kKiYYyQIAqzvApLZW3JENAn5GoSBRrLoRKyqDwepfspYGXW+PabFRbGuO
         3PBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=kDDOvcqbECz6crr0njOPUYaoDI7B+EvagSKUHTV6cXo=;
        b=PDeEscigr4EwTHi5Y6NflnYzEs+c890R2qAgMC9oVhx8+4g7L9yvPcv2gDoV31XPEf
         84fieTJUfVJy4eBFJVxpuyijIXWUrtj9NeHnN/uYxyasQOdVahYI1f3bthABb2Xn/bK7
         y+7b6hevWmHNGlqn0MHIYsRgK8Nrx6AQM+Z2siJMQ9bafcBTUZv+Z4xk2cGjXeHdKtkH
         jHPH+ApasRKsXliTPm/Fzd4tkzcYY2+hXYQRjqXksnifmmvzmYJoFnSuMK8IbINdirgD
         KI0nwC+95dr6hmw46jyAwAXZdX9iC1Sa0mxbCpde7i1vSzaGACRFbCtVSbggUCFgfG3N
         vu+A==
X-Gm-Message-State: APf1xPC4ulCk+OfAoAZyqiOhEUaHfMd3a5i6FbzFp+4LdjdPVXLtBMuv
        5Vxz1Q7p6hVoqhk8IUn4PqE8Hegv0yqkJ3cuCuoYnaXrNlqpkwCbdNTYgWaEn+S50nOUzrcGAiP
        OX7ET0ybhajMn0aSpDf80kSnyb+iL2XpnLn8hOaAhfcv4Pb1fbwjH7QyA+A==
X-Google-Smtp-Source: AH8x226r9QpYFbjOXvtELmXEd1I4hM8EA2pFToX0efEISfTrZ0e7dCsWXxp9yyrSf01jc0hO7RW2oT58p5s=
MIME-Version: 1.0
X-Received: by 10.37.129.140 with SMTP id p12mr7582ybk.64.1517966049128; Tue,
 06 Feb 2018 17:14:09 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:13:00 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180207011312.189834-24-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 23/35] fetch-pack: support shallow requests
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

Enable shallow clones and deepen requests using protocol version 2 if
the server 'fetch' command supports the 'shallow' feature.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 connect.c    | 22 +++++++++++++++++++
 connect.h    |  2 ++
 fetch-pack.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/connect.c b/connect.c
index 7cb1f1df7..9577528f3 100644
--- a/connect.c
+++ b/connect.c
@@ -82,6 +82,28 @@ int server_supports_v2(const char *c, int die_on_error)
 	return 0;
 }
 
+int server_supports_feature(const char *c, const char *feature,
+			    int die_on_error)
+{
+	int i;
+
+	for (i = 0; i < server_capabilities_v2.argc; i++) {
+		const char *out;
+		if (skip_prefix(server_capabilities_v2.argv[i], c, &out) &&
+		    (!*out || *(out++) == '=')) {
+			if (parse_feature_request(out, feature))
+				return 1;
+			else
+				break;
+		}
+	}
+
+	if (die_on_error)
+		die("server doesn't support feature '%s'", feature);
+
+	return 0;
+}
+
 static void process_capabilities_v2(struct packet_reader *reader)
 {
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL)
diff --git a/connect.h b/connect.h
index 8898d4495..0e69c6709 100644
--- a/connect.h
+++ b/connect.h
@@ -17,5 +17,7 @@ struct packet_reader;
 extern enum protocol_version discover_version(struct packet_reader *reader);
 
 extern int server_supports_v2(const char *c, int die_on_error);
+extern int server_supports_feature(const char *c, const char *feature,
+				   int die_on_error);
 
 #endif
diff --git a/fetch-pack.c b/fetch-pack.c
index 4fb5805dd..c0807e219 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1008,6 +1008,26 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	return ref;
 }
 
+static void add_shallow_requests(struct strbuf *req_buf,
+				 const struct fetch_pack_args *args)
+{
+	if (is_repository_shallow())
+		write_shallow_commits(req_buf, 1, NULL);
+	if (args->depth > 0)
+		packet_buf_write(req_buf, "deepen %d", args->depth);
+	if (args->deepen_since) {
+		timestamp_t max_age = approxidate(args->deepen_since);
+		packet_buf_write(req_buf, "deepen-since %"PRItime, max_age);
+	}
+	if (args->deepen_not) {
+		int i;
+		for (i = 0; i < args->deepen_not->nr; i++) {
+			struct string_list_item *s = args->deepen_not->items + i;
+			packet_buf_write(req_buf, "deepen-not %s", s->string);
+		}
+	}
+}
+
 static void add_wants(const struct ref *wants, struct strbuf *req_buf)
 {
 	for ( ; wants ; wants = wants->next) {
@@ -1090,6 +1110,10 @@ static int send_fetch_request(int fd_out, const struct fetch_pack_args *args,
 	if (prefer_ofs_delta)
 		packet_buf_write(&req_buf, "ofs-delta");
 
+	/* Add shallow-info and deepen request */
+	if (server_supports_feature("fetch", "shallow", 1))
+		add_shallow_requests(&req_buf, args);
+
 	/* add wants */
 	add_wants(wants, &req_buf);
 
@@ -1119,7 +1143,7 @@ static int process_section_header(struct packet_reader *reader,
 	int ret;
 
 	if (packet_reader_peek(reader) != PACKET_READ_NORMAL)
-		die("error reading packet");
+		die("error reading section header '%s'", section);
 
 	ret = !strcmp(reader->line, section);
 
@@ -1174,6 +1198,43 @@ static int process_acks(struct packet_reader *reader, struct oidset *common)
 	return received_ready ? 2 : (received_ack ? 1 : 0);
 }
 
+static void receive_shallow_info(struct fetch_pack_args *args,
+				 struct packet_reader *reader)
+{
+	process_section_header(reader, "shallow-info", 0);
+	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
+		const char *arg;
+		struct object_id oid;
+
+		if (skip_prefix(reader->line, "shallow ", &arg)) {
+			if (get_oid_hex(arg, &oid))
+				die(_("invalid shallow line: %s"), reader->line);
+			register_shallow(&oid);
+			continue;
+		}
+		if (skip_prefix(reader->line, "unshallow ", &arg)) {
+			if (get_oid_hex(arg, &oid))
+				die(_("invalid unshallow line: %s"), reader->line);
+			if (!lookup_object(oid.hash))
+				die(_("object not found: %s"), reader->line);
+			/* make sure that it is parsed as shallow */
+			if (!parse_object(&oid))
+				die(_("error in object: %s"), reader->line);
+			if (unregister_shallow(&oid))
+				die(_("no shallow found: %s"), reader->line);
+			continue;
+		}
+		die(_("expected shallow/unshallow, got %s"), reader->line);
+	}
+
+	if (reader->status != PACKET_READ_FLUSH &&
+	    reader->status != PACKET_READ_DELIM)
+		die("error processing shallow info: %d", reader->status);
+
+	setup_alternate_shallow(&shallow_lock, &alternate_shallow_file, NULL);
+	args->deepen = 1;
+}
+
 enum fetch_state {
 	FETCH_CHECK_LOCAL = 0,
 	FETCH_SEND_REQUEST,
@@ -1205,6 +1266,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			/* v2 supports these by default */
 			allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
 			use_sideband = 2;
+			if (args->depth > 0 || args->deepen_since || args->deepen_not)
+				args->deepen = 1;
 
 			/* Filter 'ref' by 'sought' and those that aren't local */
 			if (everything_local(args, &ref, sought, nr_sought))
@@ -1233,6 +1296,10 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			}
 			break;
 		case FETCH_GET_PACK:
+			/* Check for shallow-info section */
+			if (process_section_header(&reader, "shallow-info", 1))
+				receive_shallow_info(args, &reader);
+
 			/* get the pack */
 			process_section_header(&reader, "packfile", 0);
 			if (get_pack(args, fd, pack_lockfile))
-- 
2.16.0.rc1.238.g530d649a79-goog

