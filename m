Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 053181F404
	for <e@80x24.org>; Fri, 26 Jan 2018 00:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751849AbeAYX7d (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 18:59:33 -0500
Received: from mail-yw0-f201.google.com ([209.85.161.201]:37910 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbeAYX7b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 18:59:31 -0500
Received: by mail-yw0-f201.google.com with SMTP id l33so5969639ywh.5
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 15:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=gRpk8kx1urg8qHzPvz60duGfxJosY3B98dZ3TfAPCq8=;
        b=D5uz2rMqg8ba/i4IKUqeZaB4bGJ4wzDTnykjiSVhTjKQDoXkryz5Lxekag7I2CcBWr
         G2aIe/6ZEI/44Qhmr5cuufIeIcR2igST0WuI1M82iFD4D9Qp6rfALzuE+VkEvv9E7QV/
         1Y04PnGYOVmtbODsI0axDSev0L/qWXUlV4OTjYGtXrQh5Z9VGtDnTGu+eEBKKvnemmSw
         GPdbOkGTsABjTlsUSq6XEcsSFbHzdXMrfCFD0+VYCJhUqiNTJ4lZQp9qkFYmdlEZjbdE
         zlhLymhyJvBCICUOZK6fw/MoyhSk5qtw1Oehw1V0/75hZkevQFbd1MGmpe3d4SVwiTKq
         lz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=gRpk8kx1urg8qHzPvz60duGfxJosY3B98dZ3TfAPCq8=;
        b=ZyQ4PQeFDUnOAPGFfjXMljXUK49jYyXyVf6TPMnlrkPFWUwMOSgQeUnxjIIocIC2e3
         /lLET792qG8k+Z4qxBIX7/uJaJB0zwkDm8ltaXHp1tOB7NBh207TVONbXkCxL02LvTkP
         tfvtFfC+zSuHmZ6v0A0spERES1UJ0DmVKtR4GXmx0yB4tslog/laRVR5jsbh1mHE5s6l
         ZCHVvLi6ovUl6mJm7fkD2tgSs53asrOD47yeuXCt9ci9TghlsUg58NA0nRb4QDc4UjF8
         Qhgtt7lE7Zxb6OWAQoRHk+YWw9cm6nnhCtnL42I5jDbwqIWW+EP12MLhm+9q+7QbJ+fi
         Hg/w==
X-Gm-Message-State: AKwxyteKAMViZ4eHbAJs525t1YL/8ger1Fy637aZD39UGgB/O2TWG98K
        S1PbBrcdPBGQ/+llIpbgTX037rH14hEjHiLvl3BH1TsM0lSfcjcmAens1lzWWrb/m0ANN165pHD
        vcvSoj4pmHLjaVn11FzjlMmZKIqTRFD+dmEBcuQFM95EoG2KRvLzakatpjQ==
X-Google-Smtp-Source: AH8x226Ey9xkoJHnS/ZV3YdzBZFGsrDzCCQiGsI3bqL7EUGNVxLZ6sz2MmLtVUwT+klVcHjS7CSgmyVVlXo=
MIME-Version: 1.0
X-Received: by 10.37.178.136 with SMTP id k8mr5834130ybj.64.1516924770483;
 Thu, 25 Jan 2018 15:59:30 -0800 (PST)
Date:   Thu, 25 Jan 2018 15:58:31 -0800
In-Reply-To: <20180125235838.138135-1-bmwill@google.com>
Message-Id: <20180125235838.138135-21-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180125235838.138135-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v2 20/27] upload-pack: introduce fetch server command
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

Introduce the 'fetch' server command.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/technical/protocol-v2.txt | 121 +++++++++++++
 serve.c                                 |   2 +
 t/t5701-git-serve.sh                    |   1 +
 upload-pack.c                           | 293 ++++++++++++++++++++++++++++++++
 upload-pack.h                           |   5 +
 5 files changed, 422 insertions(+)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 4683d41ac..ca09a2cfe 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -147,3 +147,124 @@ The output of ls-refs is as follows:
     ref-attribute = (symref | peeled)
     symref = "symref-target:" symref-target
     peeled = "peeled:" obj-id
+
+ fetch
+-------
+
+`fetch` is the command used to fetch a packfile in v2.  It can be looked
+at as a modified version of the v1 fetch where the ref-advertisement is
+stripped out (since the `ls-refs` command fills that role) and the
+message format is tweaked to eliminate redundancies and permit easy
+addition of future extensions.
+
+Additional features not supported in the base command will be advertised
+as the value of the command in the capability advertisement in the form
+of a space separated list of features, e.g.  "<command>=<feature 1>
+<feature 2>".
+
+A `fetch` request can take the following parameters wrapped in
+packet-lines:
+
+    want <oid>
+	Indicates to the server an object which the client wants to
+	retrieve.
+
+    have <oid>
+	Indicates to the server an object which the client has locally.
+	This allows the server to make a packfile which only contains
+	the objects that the client needs. Multiple 'have' lines can be
+	supplied.
+
+    done
+	Indicates to the server that negotiation should terminate (or
+	not even begin if performing a clone) and that the server should
+	use the information supplied in the request to construct the
+	packfile.
+
+    thin-pack
+	Request that a thin pack be sent, which is a pack with deltas
+	which reference base objects not contained within the pack (but
+	are known to exist at the receiving end). This can reduce the
+	network traffic significantly, but it requires the receiving end
+	to know how to "thicken" these packs by adding the missing bases
+	to the pack.
+
+    no-progress
+	Request that progress information that would normally be sent on
+	side-band channel 2, during the packfile transfer, should not be
+	sent.  However, the side-band channel 3 is still used for error
+	responses.
+
+    include-tag
+	Request that annotated tags should be sent if the objects they
+	point to are being sent.
+
+    ofs-delta
+	Indicate that the client understands PACKv2 with delta referring
+	to its base by position in pack rather than by an oid.  That is,
+	they can read OBJ_OFS_DELTA (ake type 6) in a packfile.
+
+The response of `fetch` is broken into a number of sections separated by
+delimiter packets (0001), with each section beginning with its section
+header.
+
+    output = *section
+    section = (acknowledgments | packfile)
+	      (flush-pkt | delim-pkt)
+
+    acknowledgments = PKT-LINE("acknowledgments" LF)
+		      *(ready | nak | ack)
+    ready = PKT-LINE("ready" LF)
+    nak = PKT-LINE("NAK" LF)
+    ack = PKT-LINE("ACK" SP obj-id LF)
+
+    packfile = PKT-LINE("packfile" LF)
+	       [PACKFILE]
+
+----
+    acknowledgments section
+	* Always begins with the section header "acknowledgments"
+
+	* The server will respond with "NAK" if none of the object ids sent
+	  as have lines were common.
+
+	* The server will respond with "ACK obj-id" for all of the
+	  object ids sent as have lines which are common.
+
+	* A response cannot have both "ACK" lines as well as a "NAK"
+	  line.
+
+	* The server will respond with a "ready" line indicating that
+	  the server has found an acceptable common base and is ready to
+	  make and send a packfile (which will be found in the packfile
+	  section of the same response)
+
+	* If the client determines that it is finished with negotiations
+	  by sending a "done" line, the acknowledgments sections can be
+	  omitted from the server's response as an optimization.
+
+	* If the server has found a suitable cut point and has decided
+	  to send a "ready" line, then the server can decide to (as an
+	  optimization) omit any "ACK" lines it would have sent during
+	  its response.  This is because the server will have already
+	  determined the objects it plans to send to the client and no
+	  further negotiation is needed.
+
+----
+    packfile section
+	* Always begins with the section header "packfile"
+
+	* The transmission of the packfile begins immediately after the
+	  section header
+
+	* The data transfer of the packfile is always multiplexed, using
+	  the same semantics of the 'side-band-64k' capability from
+	  protocol version 1.  This means that each packet, during the
+	  packfile data stream, is made up of a leading 4-byte pkt-line
+	  length (typical of the pkt-line format), followed by a 1-byte
+	  stream code, followed by the actual data.
+
+	  The stream code can be one of:
+		1 - pack data
+		2 - progress messages
+		3 - fatal error message just before stream aborts
diff --git a/serve.c b/serve.c
index 2f404154a..e0235e2bc 100644
--- a/serve.c
+++ b/serve.c
@@ -6,6 +6,7 @@
 #include "argv-array.h"
 #include "ls-refs.h"
 #include "serve.h"
+#include "upload-pack.h"
 
 static int always_advertise(struct repository *r,
 			    struct strbuf *value)
@@ -53,6 +54,7 @@ static struct protocol_capability capabilities[] = {
 	{ "agent", agent_advertise, NULL },
 	{ "stateless-rpc", always_advertise, NULL },
 	{ "ls-refs", always_advertise, ls_refs },
+	{ "fetch", always_advertise, upload_pack_v2 },
 };
 
 static void advertise_capabilities(void)
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index debdc1b8d..e3bc08667 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -10,6 +10,7 @@ test_expect_success 'test capability advertisement' '
 	agent=git/$(git version | cut -d" " -f3)
 	stateless-rpc
 	ls-refs
+	fetch
 	0000
 	EOF
 
diff --git a/upload-pack.c b/upload-pack.c
index 42d83d5b1..f7944ffdc 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -18,6 +18,7 @@
 #include "prio-queue.h"
 #include "protocol.h"
 #include "upload-pack.h"
+#include "serve.h"
 
 /* Remember to update object flag allocation in object.h */
 #define THEY_HAVE	(1u << 11)
@@ -1065,3 +1066,295 @@ void upload_pack(struct upload_pack_options *options)
 		create_pack_file();
 	}
 }
+
+struct upload_pack_data {
+	struct object_array wants;
+	struct oid_array haves;
+
+	unsigned stateless_rpc : 1;
+
+	unsigned use_thin_pack : 1;
+	unsigned use_ofs_delta : 1;
+	unsigned no_progress : 1;
+	unsigned use_include_tag : 1;
+	unsigned done : 1;
+};
+
+#define UPLOAD_PACK_DATA_INIT { OBJECT_ARRAY_INIT, OID_ARRAY_INIT, 0, 0, 0, 0, 0, 0 }
+
+static void upload_pack_data_clear(struct upload_pack_data *data)
+{
+	object_array_clear(&data->wants);
+	oid_array_clear(&data->haves);
+}
+
+static int parse_want(const char *line)
+{
+	const char *arg;
+	if (skip_prefix(line, "want ", &arg)) {
+		struct object_id oid;
+		struct object *o;
+
+		if (get_oid_hex(arg, &oid))
+			die("git upload-pack: protocol error, "
+			    "expected to get oid, not '%s'", line);
+
+		o = parse_object(&oid);
+		if (!o) {
+			packet_write_fmt(1,
+					 "ERR upload-pack: not our ref %s",
+					 oid_to_hex(&oid));
+			die("git upload-pack: not our ref %s",
+			    oid_to_hex(&oid));
+		}
+
+		if (!(o->flags & WANTED)) {
+			o->flags |= WANTED;
+			add_object_array(o, NULL, &want_obj);
+		}
+
+		return 1;
+	}
+
+	return 0;
+}
+
+static int parse_have(const char *line, struct oid_array *haves)
+{
+	const char *arg;
+	if (skip_prefix(line, "have ", &arg)) {
+		struct object_id oid;
+
+		if (get_oid_hex(arg, &oid))
+			die("git upload-pack: expected SHA1 object, got '%s'", arg);
+		oid_array_append(haves, &oid);
+		return 1;
+	}
+
+	return 0;
+}
+
+static void process_args(struct argv_array *args, struct upload_pack_data *data)
+{
+	int i;
+
+	for (i = 0; i < args->argc; i++) {
+		const char *arg = args->argv[i];
+
+		/* process want */
+		if (parse_want(arg))
+			continue;
+		/* process have line */
+		if (parse_have(arg, &data->haves))
+			continue;
+
+		/* process args like thin-pack */
+		if (!strcmp(arg, "thin-pack")) {
+			use_thin_pack = 1;
+			continue;
+		}
+		if (!strcmp(arg, "ofs-delta")) {
+			use_ofs_delta = 1;
+			continue;
+		}
+		if (!strcmp(arg, "no-progress")) {
+			no_progress = 1;
+			continue;
+		}
+		if (!strcmp(arg, "include-tag")) {
+			use_include_tag = 1;
+			continue;
+		}
+		if (!strcmp(arg, "done")) {
+			data->done = 1;
+			continue;
+		}
+
+		/* ignore unknown lines maybe? */
+		die("unexpect line: '%s'", arg);
+	}
+}
+
+static void read_haves(struct upload_pack_data *data)
+{
+	struct packet_reader reader;
+	packet_reader_init(&reader, 0, NULL, 0,
+			   PACKET_READ_CHOMP_NEWLINE);
+
+	while (packet_reader_read(&reader) == PACKET_READ_NORMAL) {
+
+		if (parse_have(reader.line, &data->haves))
+			continue;
+		if (!strcmp(reader.line, "done")) {
+			data->done = 1;
+			continue;
+		}
+	}
+	if (reader.status != PACKET_READ_FLUSH)
+		die("ERROR");
+}
+
+static int process_haves(struct oid_array *haves, struct oid_array *common)
+{
+	int i;
+
+	/* Process haves */
+	for (i = 0; i < haves->nr; i++) {
+		const struct object_id *oid = &haves->oid[i];
+		struct object *o;
+		int we_knew_they_have = 0;
+
+		if (!has_object_file(oid))
+			continue;
+
+		oid_array_append(common, oid);
+
+		o = parse_object(oid);
+		if (!o)
+			die("oops (%s)", oid_to_hex(oid));
+		if (o->type == OBJ_COMMIT) {
+			struct commit_list *parents;
+			struct commit *commit = (struct commit *)o;
+			if (o->flags & THEY_HAVE)
+				we_knew_they_have = 1;
+			else
+				o->flags |= THEY_HAVE;
+			if (!oldest_have || (commit->date < oldest_have))
+				oldest_have = commit->date;
+			for (parents = commit->parents;
+			     parents;
+			     parents = parents->next)
+				parents->item->object.flags |= THEY_HAVE;
+		}
+		if (!we_knew_they_have)
+			add_object_array(o, NULL, &have_obj);
+	}
+
+	return 0;
+}
+
+static int send_acks(struct oid_array *acks, struct strbuf *response)
+{
+	int i;
+
+	packet_buf_write(response, "acknowledgments\n");
+
+	/* Send Acks */
+	if (!acks->nr)
+		packet_buf_write(response, "NAK\n");
+
+	for (i = 0; i < acks->nr; i++) {
+		packet_buf_write(response, "ACK %s\n",
+				 oid_to_hex(&acks->oid[i]));
+	}
+
+	if (ok_to_give_up()) {
+		/* Send Ready */
+		packet_buf_write(response, "ready\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+static int process_haves_and_send_acks(struct upload_pack_data *data)
+{
+	struct oid_array common = OID_ARRAY_INIT;
+	struct strbuf response = STRBUF_INIT;
+	int ret = 0;
+
+	process_haves(&data->haves, &common);
+	if (data->done) {
+		ret = 1;
+	} else if (send_acks(&common, &response)) {
+		packet_buf_delim(&response);
+		ret = 1;
+	} else {
+		/* Add Flush */
+		packet_buf_flush(&response);
+		ret = 0;
+	}
+
+	/* Send response */
+	write_or_die(1, response.buf, response.len);
+	strbuf_release(&response);
+
+	oid_array_clear(&data->haves);
+	oid_array_clear(&common);
+	return ret;
+}
+
+enum fetch_state {
+	FETCH_PROCESS_ARGS = 0,
+	FETCH_READ_HAVES,
+	FETCH_SEND_ACKS,
+	FETCH_SEND_PACK,
+	FETCH_DONE,
+};
+
+int upload_pack_v2(struct repository *r, struct argv_array *keys,
+		   struct argv_array *args)
+{
+	enum fetch_state state = FETCH_PROCESS_ARGS;
+	struct upload_pack_data data = UPLOAD_PACK_DATA_INIT;
+	const char *out;
+	use_sideband = LARGE_PACKET_MAX;
+
+	/* Check if cmd is being run as a stateless-rpc */
+	if (has_capability(keys, "stateless-rpc", &out))
+		if (!strcmp(out, "true"))
+			data.stateless_rpc = 1;
+
+	while (state != FETCH_DONE) {
+		switch (state) {
+		case FETCH_PROCESS_ARGS:
+			process_args(args, &data);
+
+			if (!want_obj.nr) {
+				/*
+				 * Request didn't contain any 'want' lines,
+				 * guess they didn't want anything.
+				 */
+				state = FETCH_DONE;
+			} else if (data.haves.nr) {
+				/*
+				 * Request had 'have' lines, so lets ACK them.
+				 */
+				state = FETCH_SEND_ACKS;
+			} else {
+				/*
+				 * Request had 'want's but no 'have's so we can
+				 * immedietly go to construct and send a pack.
+				 */
+				state = FETCH_SEND_PACK;
+			}
+			break;
+		case FETCH_READ_HAVES:
+			read_haves(&data);
+			state = FETCH_SEND_ACKS;
+			break;
+		case FETCH_SEND_ACKS:
+			if (process_haves_and_send_acks(&data))
+				state = FETCH_SEND_PACK;
+			else if (data.stateless_rpc)
+				/*
+				 * Request was made via stateless-rpc and a
+				 * packfile isn't ready to be created and sent.
+				 */
+				state = FETCH_DONE;
+			else
+				state = FETCH_READ_HAVES;
+			break;
+		case FETCH_SEND_PACK:
+			packet_write_fmt(1, "packfile\n");
+			create_pack_file();
+			state = FETCH_DONE;
+			break;
+		case FETCH_DONE:
+			continue;
+		}
+	}
+
+	upload_pack_data_clear(&data);
+	return 0;
+}
diff --git a/upload-pack.h b/upload-pack.h
index a71e4dc7e..6b7890238 100644
--- a/upload-pack.h
+++ b/upload-pack.h
@@ -10,4 +10,9 @@ struct upload_pack_options {
 
 void upload_pack(struct upload_pack_options *options);
 
+struct repository;
+struct argv_array;
+extern int upload_pack_v2(struct repository *r, struct argv_array *keys,
+			  struct argv_array *args);
+
 #endif /* UPLOAD_PACK_H */
-- 
2.16.0.rc1.238.g530d649a79-goog

