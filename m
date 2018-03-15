Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 685F71F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752557AbeCORcj (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:32:39 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:32887 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752168AbeCORcf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:32:35 -0400
Received: by mail-qt0-f202.google.com with SMTP id k22so4912221qtj.0
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=AIUVG6ZeXCuCo3OujpxExtpR094XvJW0QyO7wxcx3Ls=;
        b=K/+dOtHZWw4WDO0EMOTNUDW2Oo/cVD8nSV2AIs5Vd03z6bDUWZhcwzK7gLLdwq3JRz
         7DEPkDfSrjQaqyE6Ufu2LTVGfU6Wx+kkPEMZTSwh0WhdViebpRrZTyk9ZVMHhvr+LO92
         ff6SiFjD3DXWrTSkAz7+1lruLDSCMU6wJD7nowISdB3r16xCy6n7xEKRwcJv0CpLsBeR
         abyNszWJoHVRK3QCQhffi65ybt45VlWyHbqLMUQBdtj8nMLecos1a8SQEhipkQZaexgk
         MXxa5gWPyahiHJEgxHnAswo4WeJvRemollAQIlGmashRqpHAE0iD14cemmIoOmhbJARR
         YbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=AIUVG6ZeXCuCo3OujpxExtpR094XvJW0QyO7wxcx3Ls=;
        b=a5wRFTXnrooZ2jQfEdjWBg+/Qj75Jce0DXuNFlvU6BVCvt+kPBXA826/i5/2xKqwyu
         wJOhzK5yGzIzhyKBThLhpwNntwe4AcjKJta0dVeiIAxX+aAOlMWO9q5cJRbyPj1BUeTT
         NhRQy4bUn/cp5zf8v1u2uD3uqI5Y9OfPf6gAhdGvwh/Jyn/mWy7KxRHFWf65q4IsKD8J
         O4E0oiuTnDJaoWUeyBBZVDc47uyOWwF3l32uHpB/WZEYwqZVF7LH5pgaUyuOmNamfIEP
         EuL/wcCoq+yKFx9vhpCjl7asRWhCifFP6+j/kIbyMww9O+yxmAipNsetOoEVjUPYTUw8
         m1+w==
X-Gm-Message-State: AElRT7FBVgxuryGFkIIyNgXbcP4bhx42GsCc/w2rRdd/HTTWp37l6YlG
        sbwKdLZs7AZwfxMaP1uRQuZeqfwNYpCKHQYuBN7gMOnLEgqtY2MAGgaPPg2M4D7BfjMHQrGczjA
        qKxzx9RKWpzX1uygx5f00OznlJv8OOpIZAg3AgkPzG/u69uLLhhvRru6PgQ==
X-Google-Smtp-Source: AG47ELtBIjnmJlNSJOJ/CHLFQmS22PF91AdQZ3H7PSylmwVDx/x0m77tF7egUkKrdf65tDxmFjJVE1BOuLY=
MIME-Version: 1.0
X-Received: by 10.200.11.73 with SMTP id m9mr6406772qti.0.1521135154929; Thu,
 15 Mar 2018 10:32:34 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:31:27 -0700
In-Reply-To: <20180315173142.176023-1-bmwill@google.com>
Message-Id: <20180315173142.176023-21-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com> <20180315173142.176023-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v6 20/35] upload-pack: introduce fetch server command
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

Introduce the 'fetch' server command.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/technical/protocol-v2.txt | 125 +++++++++++
 serve.c                                 |   2 +
 t/t5701-git-serve.sh                    |   1 +
 upload-pack.c                           | 266 ++++++++++++++++++++++++
 upload-pack.h                           |   6 +
 5 files changed, 400 insertions(+)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index bbb8b14d27..307dc1489b 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -199,3 +199,128 @@ The output of ls-refs is as follows:
     ref-attribute = (symref | peeled)
     symref = "symref-target:" symref-target
     peeled = "peeled:" obj-id
+
+ fetch
+~~~~~~~
+
+`fetch` is the command used to fetch a packfile in v2.  It can be looked
+at as a modified version of the v1 fetch where the ref-advertisement is
+stripped out (since the `ls-refs` command fills that role) and the
+message format is tweaked to eliminate redundancies and permit easy
+addition of future extensions.
+
+Additional features not supported in the base command will be advertised
+as the value of the command in the capability advertisement in the form
+of a space separated list of features: "<command>=<feature 1> <feature 2>"
+
+A `fetch` request can take the following arguments:
+
+    want <oid>
+	Indicates to the server an object which the client wants to
+	retrieve.  Wants can be anything and are not limited to
+	advertised objects.
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
+		      (nak | *ack)
+		      (ready)
+    ready = PKT-LINE("ready" LF)
+    nak = PKT-LINE("NAK" LF)
+    ack = PKT-LINE("ACK" SP obj-id LF)
+
+    packfile = PKT-LINE("packfile" LF)
+	       *PKT-LINE(%x01-03 *%x00-ff)
+
+    acknowledgments section
+	* If the client determines that it is finished with negotiations
+	  by sending a "done" line, the acknowledgments sections MUST be
+	  omitted from the server's response.
+
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
+	* If the server has found a suitable cut point and has decided
+	  to send a "ready" line, then the server can decide to (as an
+	  optimization) omit any "ACK" lines it would have sent during
+	  its response.  This is because the server will have already
+	  determined the objects it plans to send to the client and no
+	  further negotiation is needed.
+
+    packfile section
+	* This section is only included if the client has sent 'want'
+	  lines in its request and either requested that no more
+	  negotiation be done by sending 'done' or if the server has
+	  decided it has found a sufficient cut point to produce a
+	  packfile.
+
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
index 1cb5fb9b5b..3692dda801 100644
--- a/serve.c
+++ b/serve.c
@@ -6,6 +6,7 @@
 #include "argv-array.h"
 #include "ls-refs.h"
 #include "serve.h"
+#include "upload-pack.h"
 
 static int always_advertise(struct repository *r,
 			    struct strbuf *value)
@@ -54,6 +55,7 @@ struct protocol_capability {
 static struct protocol_capability capabilities[] = {
 	{ "agent", agent_advertise, NULL },
 	{ "ls-refs", always_advertise, ls_refs },
+	{ "fetch", always_advertise, upload_pack_v2 },
 };
 
 static void advertise_capabilities(void)
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index d03e08eebd..888a700443 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -9,6 +9,7 @@ test_expect_success 'test capability advertisement' '
 	version 2
 	agent=git/$(git version | cut -d" " -f3)
 	ls-refs
+	fetch
 	0000
 	EOF
 
diff --git a/upload-pack.c b/upload-pack.c
index 1e8a9e1caf..198e9f046b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -18,6 +18,7 @@
 #include "prio-queue.h"
 #include "protocol.h"
 #include "upload-pack.h"
+#include "serve.h"
 
 /* Remember to update object flag allocation in object.h */
 #define THEY_HAVE	(1u << 11)
@@ -1065,3 +1066,268 @@ void upload_pack(struct upload_pack_options *options)
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
+static void upload_pack_data_init(struct upload_pack_data *data)
+{
+	struct object_array wants = OBJECT_ARRAY_INIT;
+	struct oid_array haves = OID_ARRAY_INIT;
+
+	memset(data, 0, sizeof(*data));
+	data->wants = wants;
+	data->haves = haves;
+}
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
+static void process_args(struct packet_reader *request,
+			 struct upload_pack_data *data)
+{
+	while (packet_reader_read(request) != PACKET_READ_FLUSH) {
+		const char *arg = request->line;
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
+	FETCH_SEND_ACKS,
+	FETCH_SEND_PACK,
+	FETCH_DONE,
+};
+
+int upload_pack_v2(struct repository *r, struct argv_array *keys,
+		   struct packet_reader *request)
+{
+	enum fetch_state state = FETCH_PROCESS_ARGS;
+	struct upload_pack_data data;
+
+	upload_pack_data_init(&data);
+	use_sideband = LARGE_PACKET_MAX;
+
+	while (state != FETCH_DONE) {
+		switch (state) {
+		case FETCH_PROCESS_ARGS:
+			process_args(request, &data);
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
+		case FETCH_SEND_ACKS:
+			if (process_haves_and_send_acks(&data))
+				state = FETCH_SEND_PACK;
+			else
+				state = FETCH_DONE;
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
index a71e4dc7e2..5bbdb7e445 100644
--- a/upload-pack.h
+++ b/upload-pack.h
@@ -10,4 +10,10 @@ struct upload_pack_options {
 
 void upload_pack(struct upload_pack_options *options);
 
+struct repository;
+struct argv_array;
+struct packet_reader;
+extern int upload_pack_v2(struct repository *r, struct argv_array *keys,
+			  struct packet_reader *request);
+
 #endif /* UPLOAD_PACK_H */
-- 
2.16.2.804.g6dcf76e118-goog

