Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66CE81F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752503AbeCORcJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:32:09 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:45061 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752410AbeCORcH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:32:07 -0400
Received: by mail-qk0-f201.google.com with SMTP id x188so4873027qkc.12
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=FSKfRYvQOSEzaWKUIofIzblzBskaEOkzRI8ufYWQ9Ck=;
        b=rzoYestV33vIsxl6NbLzxwJUCxv8LDsrwa2zLia3q0Ze0c/CQUWLFeQnZ/dotrV+el
         k7zfJuqJpJTF2nL/qwYc22LQG5aSS7E3HqHuHqctFKZpFW80+BtBzfk/KtyannV+h1Hn
         LdGwYEMmV3nCrawN9NI6q8COfaX/jxCzGdai7yedvGjz0b2FLvd57lc5QHk4ISjflT27
         92XFhApQZa0SPt7EuzAgql73+hgUOLZRvea6sWyEwONZRKPgs/2X8n7kUUl9ZydKl1sj
         +SIvNqLi5PhvigyAqUkMTPmz4O+eKu+ikKY5aaBcWwqLa9BmaouvLPZ2SluBqfDlbaVv
         6x1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=FSKfRYvQOSEzaWKUIofIzblzBskaEOkzRI8ufYWQ9Ck=;
        b=ozUJ/5MVpSCAaEsAJfFTgHsMlfFfTwnY3xYvpVnc1yg0fW03sRYTuDUm/BgvdYVaoR
         gq00I+WAtR7vVeoW/IbEZGVa9NB9sjvlmdNC/FGI8mV5iyk+47aUoapPul3rjCVPnb43
         1AqxsszvgClQTIVMy8H/bLnZvm23HcLXNw1eid/dEcjHvA9H4OOdw3juVjytlIbT+2dr
         RhElToB3P9Sfy6kKnFGod1vZU7JumTn3QDV0LOyjjyoZNthXDv3ilgZTpNqnHg05eyTI
         GFc3o7UPJZPix6qEFz3hZtgMUOnF8G4ilEIvEH80GOmKPt2sDE2BOlcOAS86RSwsEgH1
         3kaA==
X-Gm-Message-State: AElRT7HCGOGenAoDb6f6PoNHI1Dp7n6ul83vMQwjdJn84hvJrjDi1I5U
        VOTFBHZxm0McM0pM7jzTBWZBs9NmYbnZrktn/cwlxl0iWsaswW7HxPGbETVqDSzjolk/aJxkwjv
        X+E2CqMLeU0pDmgjf1J3YVwj5IeE73bS9Q9Vcjfko/ejjsrOlZq4DYBqZNQ==
X-Google-Smtp-Source: AG47ELv6Ih5nC0iYcFU3c70+JxoeTVJzCmSRJMchbPY2O9f6qj3rdHmbHnNaD9J6+ecRCVNeX+CNMDVnRC0=
MIME-Version: 1.0
X-Received: by 10.200.12.10 with SMTP id k10mr6073156qti.46.1521135126271;
 Thu, 15 Mar 2018 10:32:06 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:31:15 -0700
In-Reply-To: <20180315173142.176023-1-bmwill@google.com>
Message-Id: <20180315173142.176023-9-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com> <20180315173142.176023-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v6 08/35] connect: discover protocol version outside of get_remote_heads
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

In order to prepare for the addition of protocol_v2 push the protocol
version discovery outside of 'get_remote_heads()'.  This will allow for
keeping the logic for processing the reference advertisement for
protocol_v1 and protocol_v0 separate from the logic for protocol_v2.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch-pack.c | 16 +++++++++++++++-
 builtin/send-pack.c  | 17 +++++++++++++++--
 connect.c            | 27 ++++++++++-----------------
 connect.h            |  3 +++
 remote-curl.c        | 20 ++++++++++++++++++--
 remote.h             |  5 +++--
 transport.c          | 24 +++++++++++++++++++-----
 7 files changed, 83 insertions(+), 29 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 366b9d13f9..85d4faf76c 100644
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
index fc4f0bb5fb..83cb125a68 100644
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
index c82c90b7c3..0b111e62d7 100644
--- a/connect.c
+++ b/connect.c
@@ -62,7 +62,7 @@ static void die_initial_contact(int unexpected)
 		      "and the repository exists."));
 }
 
-static enum protocol_version discover_version(struct packet_reader *reader)
+enum protocol_version discover_version(struct packet_reader *reader)
 {
 	enum protocol_version version = protocol_unknown_version;
 
@@ -233,7 +233,7 @@ enum get_remote_heads_state {
 /*
  * Read all the refs from the other end
  */
-struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
+struct ref **get_remote_heads(struct packet_reader *reader,
 			      struct ref **list, unsigned int flags,
 			      struct oid_array *extra_have,
 			      struct oid_array *shallow_points)
@@ -241,24 +241,17 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 	struct ref **orig_list = list;
 	int len = 0;
 	enum get_remote_heads_state state = EXPECTING_FIRST_REF;
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
-			if (len > 4 && skip_prefix(reader.line, "ERR ", &arg))
+			len = reader->pktlen;
+			if (len > 4 && skip_prefix(reader->line, "ERR ", &arg))
 				die("remote error: %s", arg);
 			break;
 		case PACKET_READ_FLUSH:
@@ -270,22 +263,22 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 
 		switch (state) {
 		case EXPECTING_FIRST_REF:
-			process_capabilities(reader.line, &len);
-			if (process_dummy_ref(reader.line)) {
+			process_capabilities(reader->line, &len);
+			if (process_dummy_ref(reader->line)) {
 				state = EXPECTING_SHALLOW;
 				break;
 			}
 			state = EXPECTING_REF;
 			/* fallthrough */
 		case EXPECTING_REF:
-			if (process_ref(reader.line, len, &list, flags, extra_have))
+			if (process_ref(reader->line, len, &list, flags, extra_have))
 				break;
 			state = EXPECTING_SHALLOW;
 			/* fallthrough */
 		case EXPECTING_SHALLOW:
-			if (process_shallow(reader.line, len, shallow_points))
+			if (process_shallow(reader->line, len, shallow_points))
 				break;
-			die("protocol error: unexpected '%s'", reader.line);
+			die("protocol error: unexpected '%s'", reader->line);
 		case EXPECTING_DONE:
 			break;
 		}
diff --git a/connect.h b/connect.h
index 01f14cdf3f..cdb8979dce 100644
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
index 0053b09549..9f6d07683d 100644
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
index 1f6611be21..2016461df9 100644
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
index 8e87790962..63c3dbab94 100644
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
2.16.2.804.g6dcf76e118-goog

