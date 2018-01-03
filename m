Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6B201F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751206AbeACAS6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:18:58 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:41983 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751190AbeACASx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:18:53 -0500
Received: by mail-it0-f66.google.com with SMTP id x28so53071ita.0
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SQFX6HYhneC0hyaAQhjGMAKd0vkgyVBVyUKA5/AiRp4=;
        b=jDinYzW/Utxu5zuQCzP0pY+Ce+SOBBIcvVj+WmQM4gjLQbiSeIpY3q8V+BnNdF51YK
         GKex/WgTDQ+Dl54SR8Tr2iGBFSvCxKBu3FncY0tNmVcrgZaT7JeFwom23IbXFV/TYjEk
         tELfoxhVlQzwOLEl9bXLNdO2Fi9MPEH16tyyNoLSKU7sdAgm80F/012NyHeOsaQ5tK0i
         o7vtf2bxf9QWdJXf2TC5tQ3og+dzsGIwOBBusxYeE3nUjBM7RWEOPoIzf0WaIntmutds
         5PdjEes3FVMP2nR3tq1wsvakEsHw7TPpvp8pJOz7US5X2zHOet0nfE61gtN4K3awzLP3
         tm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SQFX6HYhneC0hyaAQhjGMAKd0vkgyVBVyUKA5/AiRp4=;
        b=dNpY1B4tzZGdkN7PptKYaRYUbPFXM4l42tTRN6ZpeJ1seWan1vZ8ufzRRAkWVoEa9o
         NiEUjXB/SOe9qkt+ssgdMcLQ3iENxusdF5IdZVVpSO/DkG9YaBGJXS4F4S96Gyd+Zdyg
         Hj7xgjt19ab5I2ThkQRMhq8wHia3+yUEBBrin+41Zg15C5uOqa4nQgykCflnvW7RkPef
         7WZMZa1NVx8arNDek0SyQm/FKPcdNHgDO8Fbs91tuLbwxELZz0QapJ3stwH/XkHxal0G
         4qRx2G7Umgew4Q8lWocaHm+MqQMsdG74dmxnV+xrr8I+NPkejA/voYPk6BOJbMDGDk2Z
         0KIQ==
X-Gm-Message-State: AKGB3mLvBrlTEUCWqXQ/kVbwkv89+uM4dZdqABRkFvlmZNr47MiwgNHI
        64Ur1YfOJmB06Wu0THjRPL9DJDZV/rk=
X-Google-Smtp-Source: ACJfBouhvIh9aouemIAirw+gCdgHeEpcrMaxGF7vgmkhEWQHAKjl2bjnvMIMzoZkXhCw39fBmIG1KA==
X-Received: by 10.36.147.3 with SMTP id y3mr19295itd.82.1514938732337;
        Tue, 02 Jan 2018 16:18:52 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q2sm12679ite.17.2018.01.02.16.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 16:18:51 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 08/26] connect: discover protocol version outside of get_remote_heads
Date:   Tue,  2 Jan 2018 16:18:10 -0800
Message-Id: <20180103001828.205012-9-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103001828.205012-1-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to prepare for the addition of protocol_v2 push the protocol
version discovery outside of 'get_remote_heads()'.  This will allow for
keeping the logic for processing the reference advertisement for
protocol_v1 and protocol_v0 separate from the logic for protocol_v2.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch-pack.c | 16 +++++++++++++++-
 builtin/send-pack.c  | 17 +++++++++++++++--
 connect.c            | 15 ++++-----------
 connect.h            |  3 +++
 remote-curl.c        | 20 ++++++++++++++++++--
 remote.h             |  5 +++--
 transport.c          | 24 +++++++++++++++++++-----
 7 files changed, 77 insertions(+), 23 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 366b9d13f..85d4faf76 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -4,6 +4,7 @@
 #include "remote.h"
 #include "connect.h"
 #include "sha1-array.h"
+#include "protocol.h"
 
 static const char fetch_pack_usage[] =
 "git fetch-pack [--all] [--stdin] [--quiet | -q] [--keep | -k] [--thin] "
@@ -52,6 +53,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	struct fetch_pack_args args;
 	struct oid_array shallow = OID_ARRAY_INIT;
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
+	struct packet_reader reader;
 
 	packet_trace_identity("fetch-pack");
 
@@ -193,7 +195,19 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		if (!conn)
 			return args.diag_url ? 0 : 1;
 	}
-	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, &shallow);
+
+	packet_reader_init(&reader, fd[0], NULL, 0,
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_GENTLE_ON_EOF);
+
+	switch (discover_version(&reader)) {
+	case protocol_v1:
+	case protocol_v0:
+		get_remote_heads(&reader, &ref, 0, NULL, &shallow);
+		break;
+	case protocol_unknown_version:
+		BUG("unknown protocol version");
+	}
 
 	ref = fetch_pack(&args, fd, conn, ref, dest, sought, nr_sought,
 			 &shallow, pack_lockfile_ptr);
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index fc4f0bb5f..83cb125a6 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -14,6 +14,7 @@
 #include "sha1-array.h"
 #include "gpg-interface.h"
 #include "gettext.h"
+#include "protocol.h"
 
 static const char * const send_pack_usage[] = {
 	N_("git send-pack [--all | --mirror] [--dry-run] [--force] "
@@ -154,6 +155,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	int progress = -1;
 	int from_stdin = 0;
 	struct push_cas_option cas = {0};
+	struct packet_reader reader;
 
 	struct option options[] = {
 		OPT__VERBOSITY(&verbose),
@@ -256,8 +258,19 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 			args.verbose ? CONNECT_VERBOSE : 0);
 	}
 
-	get_remote_heads(fd[0], NULL, 0, &remote_refs, REF_NORMAL,
-			 &extra_have, &shallow);
+	packet_reader_init(&reader, fd[0], NULL, 0,
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_GENTLE_ON_EOF);
+
+	switch (discover_version(&reader)) {
+	case protocol_v1:
+	case protocol_v0:
+		get_remote_heads(&reader, &remote_refs, REF_NORMAL,
+				 &extra_have, &shallow);
+		break;
+	case protocol_unknown_version:
+		BUG("unknown protocol version");
+	}
 
 	transport_verify_remote_names(nr_refspecs, refspecs);
 
diff --git a/connect.c b/connect.c
index 03bbb74e4..1787b0212 100644
--- a/connect.c
+++ b/connect.c
@@ -62,7 +62,7 @@ static void die_initial_contact(int unexpected)
 		      "and the repository exists."));
 }
 
-static enum protocol_version discover_version(struct packet_reader *reader)
+enum protocol_version discover_version(struct packet_reader *reader)
 {
 	enum protocol_version version = protocol_unknown_version;
 
@@ -231,7 +231,7 @@ static int process_shallow(int len, struct oid_array *shallow_points)
 /*
  * Read all the refs from the other end
  */
-struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
+struct ref **get_remote_heads(struct packet_reader *reader,
 			      struct ref **list, unsigned int flags,
 			      struct oid_array *extra_have,
 			      struct oid_array *shallow_points)
@@ -239,23 +239,16 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 	struct ref **orig_list = list;
 	int len = 0;
 	int state = EXPECTING_FIRST_REF;
-	struct packet_reader reader;
 	const char *arg;
 
-	packet_reader_init(&reader, in, src_buf, src_len,
-			   PACKET_READ_CHOMP_NEWLINE |
-			   PACKET_READ_GENTLE_ON_EOF);
-
-	discover_version(&reader);
-
 	*list = NULL;
 
 	while (state != EXPECTING_DONE) {
-		switch (packet_reader_read(&reader)) {
+		switch (packet_reader_read(reader)) {
 		case PACKET_READ_EOF:
 			die_initial_contact(1);
 		case PACKET_READ_NORMAL:
-			len = reader.pktlen;
+			len = reader->pktlen;
 			if (len > 4 && skip_prefix(packet_buffer, "ERR ", &arg))
 				die("remote error: %s", arg);
 			break;
diff --git a/connect.h b/connect.h
index 01f14cdf3..cdb8979dc 100644
--- a/connect.h
+++ b/connect.h
@@ -13,4 +13,7 @@ extern int parse_feature_request(const char *features, const char *feature);
 extern const char *server_feature_value(const char *feature, int *len_ret);
 extern int url_is_local_not_ssh(const char *url);
 
+struct packet_reader;
+extern enum protocol_version discover_version(struct packet_reader *reader);
+
 #endif
diff --git a/remote-curl.c b/remote-curl.c
index 0053b0954..9f6d07683 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "remote.h"
+#include "connect.h"
 #include "strbuf.h"
 #include "walker.h"
 #include "http.h"
@@ -13,6 +14,7 @@
 #include "credential.h"
 #include "sha1-array.h"
 #include "send-pack.h"
+#include "protocol.h"
 
 static struct remote *remote;
 /* always ends with a trailing slash */
@@ -176,8 +178,22 @@ static struct discovery *last_discovery;
 static struct ref *parse_git_refs(struct discovery *heads, int for_push)
 {
 	struct ref *list = NULL;
-	get_remote_heads(-1, heads->buf, heads->len, &list,
-			 for_push ? REF_NORMAL : 0, NULL, &heads->shallow);
+	struct packet_reader reader;
+
+	packet_reader_init(&reader, -1, heads->buf, heads->len,
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_GENTLE_ON_EOF);
+
+	switch (discover_version(&reader)) {
+	case protocol_v1:
+	case protocol_v0:
+		get_remote_heads(&reader, &list, for_push ? REF_NORMAL : 0,
+				 NULL, &heads->shallow);
+		break;
+	case protocol_unknown_version:
+		BUG("unknown protocol version");
+	}
+
 	return list;
 }
 
diff --git a/remote.h b/remote.h
index 1f6611be2..2016461df 100644
--- a/remote.h
+++ b/remote.h
@@ -150,10 +150,11 @@ int check_ref_type(const struct ref *ref, int flags);
 void free_refs(struct ref *ref);
 
 struct oid_array;
-extern struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
+struct packet_reader;
+extern struct ref **get_remote_heads(struct packet_reader *reader,
 				     struct ref **list, unsigned int flags,
 				     struct oid_array *extra_have,
-				     struct oid_array *shallow);
+				     struct oid_array *shallow_points);
 
 int resolve_remote_symref(struct ref *ref, struct ref *list);
 int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid);
diff --git a/transport.c b/transport.c
index 8e8779096..63c3dbab9 100644
--- a/transport.c
+++ b/transport.c
@@ -18,6 +18,7 @@
 #include "sha1-array.h"
 #include "sigchain.h"
 #include "transport-internal.h"
+#include "protocol.h"
 
 static void set_upstreams(struct transport *transport, struct ref *refs,
 	int pretend)
@@ -190,13 +191,26 @@ static int connect_setup(struct transport *transport, int for_push)
 static struct ref *get_refs_via_connect(struct transport *transport, int for_push)
 {
 	struct git_transport_data *data = transport->data;
-	struct ref *refs;
+	struct ref *refs = NULL;
+	struct packet_reader reader;
 
 	connect_setup(transport, for_push);
-	get_remote_heads(data->fd[0], NULL, 0, &refs,
-			 for_push ? REF_NORMAL : 0,
-			 &data->extra_have,
-			 &data->shallow);
+
+	packet_reader_init(&reader, data->fd[0], NULL, 0,
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_GENTLE_ON_EOF);
+
+	switch (discover_version(&reader)) {
+	case protocol_v1:
+	case protocol_v0:
+		get_remote_heads(&reader, &refs,
+				 for_push ? REF_NORMAL : 0,
+				 &data->extra_have,
+				 &data->shallow);
+		break;
+	case protocol_unknown_version:
+		BUG("unknown protocol version");
+	}
 	data->got_remote_heads = 1;
 
 	return refs;
-- 
2.15.1.620.gb9897f4670-goog

