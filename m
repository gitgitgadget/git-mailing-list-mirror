Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD6BD1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965019AbeB1XYS (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:24:18 -0500
Received: from mail-yw0-f201.google.com ([209.85.161.201]:51889 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964944AbeB1XYO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:24:14 -0500
Received: by mail-yw0-f201.google.com with SMTP id l125so2351099ywb.18
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=+k8KiRtNON3nQtEmXb4kd2epQHDgyDP76X3ZlVX6Dao=;
        b=KKRqeaR01HfQT/go2MUUCx5hl6I3u8HFV262Xm7Dy2diEnxPJPkMiG1hfo+4TtW4+P
         p1jgwK51YyVgqcL8dNcTe3DzYDgHCV2hLRYTKuLCQw/69gIy0KaQtJky/XWDtIjruLms
         Nq78OtrzHrKSW8oBzaFD77RxcY353J73i12hxfnBfriWOKkUl9gqERBHa+ZHACutllgm
         Z3C6xZS1/ebnSEvHcPqEowepOWwoQ1dLeB5cLFmEi4qGYGtJP2OEov5goZWeuPsu4wGZ
         LYQ9olHmrQ86pP8WCKEkAL4TWHbsDcH3EZBUztl82FYy4j/bI9uIAgEucXyZurrXa8Jf
         JP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=+k8KiRtNON3nQtEmXb4kd2epQHDgyDP76X3ZlVX6Dao=;
        b=QJUQqySMvb2JHPAkgXifK0qwAn50ydTxLHj8Yn2QWAFQJa2OZg+fGH5Tiv2q0i+r+v
         GCzDbWxfg9xy9GUXger/VFyMkpLZmAQrnHZkZe6NV555CKwl37OrVDQRD3mWazXs8AIO
         UfIseENA4qb+6n3YCD+CfevSsqYsxWxuzY6xg4DrOcb+X6PRGmbT/QHbmCW/rz6UXQaT
         1ZkWUExmS14DMruzWxlbiVDpgHsCoIIhWVRXB95cUTO3VU81XslR/bJxKfkmnRLYlzZY
         UVPI8fFcZymKsyKf3NPTOcaGlROsNFjBhLmiD84H+u+VkwZRX0svmG6oYYanqfNRG6u1
         bTrQ==
X-Gm-Message-State: APf1xPBJcOGtBoV84KpamETBNlEjig3tzfJ2o8/A6vC7S7+lUumu9HHC
        MQPLRi9vdoU2TubgFfr+30hOdEsj43Ezum7bxqpPJv9+FtqLlKyHv0Lok/LHtgWVezz6PaATF3g
        oDJTXKXw+IuVgC2G3XzDwEQ+htzNTbSPhJpJlK2yGekckCWv+/und9XQLvQ==
X-Google-Smtp-Source: AG47ELt88PM94GTXcIN1q6d9hhjODrxN27kCZGPD8nCySiwXS0P6BzNDA/dA+Z69vUrwBFdn5m3sf86WiaM=
MIME-Version: 1.0
X-Received: by 2002:a25:9985:: with SMTP id p5-v6mr10503825ybo.43.1519860253438;
 Wed, 28 Feb 2018 15:24:13 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:38 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-22-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 21/35] fetch-pack: perform a fetch using v2
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When communicating with a v2 server, perform a fetch by requesting the
'fetch' command.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/technical/protocol-v2.txt |  68 +++++-
 builtin/fetch-pack.c                    |   2 +-
 fetch-pack.c                            | 270 +++++++++++++++++++++++-
 fetch-pack.h                            |   4 +-
 serve.c                                 |   2 +-
 t/t5701-git-serve.sh                    |   2 +-
 t/t5702-protocol-v2.sh                  |  97 +++++++++
 transport.c                             |   7 +-
 upload-pack.c                           | 141 ++++++++++---
 upload-pack.h                           |   3 +
 10 files changed, 548 insertions(+), 48 deletions(-)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 99c70a1e4..0d63456fc 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -262,12 +262,43 @@ A `fetch` request can take the following arguments:
 	to its base by position in pack rather than by an oid.  That is,
 	they can read OBJ_OFS_DELTA (ake type 6) in a packfile.
 
+    shallow <oid>
+	A client must notify the server of all commits for which it only
+	has shallow copies (meaning that it doesn't have the parents of
+	a commit) by supplying a 'shallow <oid>' line for each such
+	object so that the server is aware of the limitations of the
+	client's history.  This is so that the server is aware that the
+	client may not have all objects reachable from such commits.
+
+    deepen <depth>
+	Requests that the fetch/clone should be shallow having a commit
+	depth of <depth> relative to the remote side.
+
+    deepen-relative
+	Requests that the semantics of the "deepen" command be changed
+	to indicate that the depth requested is relative to the client's
+	current shallow boundary, instead of relative to the requested
+	commits.
+
+    deepen-since <timestamp>
+	Requests that the shallow clone/fetch should be cut at a
+	specific time, instead of depth.  Internally it's equivalent to
+	doing "git rev-list --max-age=<timestamp>". Cannot be used with
+	"deepen".
+
+    deepen-not <rev>
+	Requests that the shallow clone/fetch should be cut at a
+	specific revision specified by '<rev>', instead of a depth.
+	Internally it's equivalent of doing "git rev-list --not <rev>".
+	Cannot be used with "deepen", but can be used with
+	"deepen-since".
+
 The response of `fetch` is broken into a number of sections separated by
 delimiter packets (0001), with each section beginning with its section
 header.
 
     output = *section
-    section = (acknowledgments | packfile)
+    section = (acknowledgments | shallow-info | packfile)
 	      (flush-pkt | delim-pkt)
 
     acknowledgments = PKT-LINE("acknowledgments" LF)
@@ -277,6 +308,11 @@ header.
     nak = PKT-LINE("NAK" LF)
     ack = PKT-LINE("ACK" SP obj-id LF)
 
+    shallow-info = PKT-LINE("shallow-info" LF)
+		   *PKT-LINE((shallow | unshallow) LF)
+    shallow = "shallow" SP obj-id
+    unshallow = "unshallow" SP obj-id
+
     packfile = PKT-LINE("packfile" LF)
 	       [PACKFILE]
 
@@ -309,6 +345,36 @@ header.
 	  determined the objects it plans to send to the client and no
 	  further negotiation is needed.
 
+----
+    shallow-info section
+	If the client has requested a shallow fetch/clone, a shallow
+	client requests a fetch or the server is shallow then the
+	server's response may include a shallow-info section.  The
+	shallow-info section will be included if (due to one of the
+	above conditions) the server needs to inform the client of any
+	shallow boundaries or adjustments to the clients already
+	existing shallow boundaries.
+
+	* Always begins with the section header "shallow-info"
+
+	* If a positive depth is requested, the server will compute the
+	  set of commits which are no deeper than the desired depth.
+
+	* The server sends a "shallow obj-id" line for each commit whose
+	  parents will not be sent in the following packfile.
+
+	* The server sends an "unshallow obj-id" line for each commit
+	  which the client has indicated is shallow, but is no longer
+	  shallow as a result of the fetch (due to its parents being
+	  sent in the following packfile).
+
+	* The server MUST NOT send any "unshallow" lines for anything
+	  which the client has not indicated was shallow as a part of
+	  its request.
+
+	* This section is only included if a packfile section is also
+	  included in the response.
+
 ----
     packfile section
 	* Always begins with the section header "packfile"
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index b2374ddbb..f9d7d0b5a 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -212,7 +212,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	}
 
 	ref = fetch_pack(&args, fd, conn, ref, dest, sought, nr_sought,
-			 &shallow, pack_lockfile_ptr);
+			 &shallow, pack_lockfile_ptr, protocol_v0);
 	if (pack_lockfile) {
 		printf("lock %s\n", pack_lockfile);
 		fflush(stdout);
diff --git a/fetch-pack.c b/fetch-pack.c
index 9f6b07ad9..dffcfd66a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -303,9 +303,9 @@ static void insert_one_alternate_object(struct object *obj)
 #define PIPESAFE_FLUSH 32
 #define LARGE_FLUSH 16384
 
-static int next_flush(struct fetch_pack_args *args, int count)
+static int next_flush(int stateless_rpc, int count)
 {
-	if (args->stateless_rpc) {
+	if (stateless_rpc) {
 		if (count < LARGE_FLUSH)
 			count <<= 1;
 		else
@@ -461,7 +461,7 @@ static int find_common(struct fetch_pack_args *args,
 			send_request(args, fd[1], &req_buf);
 			strbuf_setlen(&req_buf, state_len);
 			flushes++;
-			flush_at = next_flush(args, count);
+			flush_at = next_flush(args->stateless_rpc, count);
 
 			/*
 			 * We keep one window "ahead" of the other side, and
@@ -1008,6 +1008,259 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	return ref;
 }
 
+static void add_wants(const struct ref *wants, struct strbuf *req_buf)
+{
+	for ( ; wants ; wants = wants->next) {
+		const struct object_id *remote = &wants->old_oid;
+		const char *remote_hex;
+		struct object *o;
+
+		/*
+		 * If that object is complete (i.e. it is an ancestor of a
+		 * local ref), we tell them we have it but do not have to
+		 * tell them about its ancestors, which they already know
+		 * about.
+		 *
+		 * We use lookup_object here because we are only
+		 * interested in the case we *know* the object is
+		 * reachable and we have already scanned it.
+		 */
+		if (((o = lookup_object(remote->hash)) != NULL) &&
+		    (o->flags & COMPLETE)) {
+			continue;
+		}
+
+		remote_hex = oid_to_hex(remote);
+		packet_buf_write(req_buf, "want %s\n", remote_hex);
+	}
+}
+
+static void add_common(struct strbuf *req_buf, struct oidset *common)
+{
+	struct oidset_iter iter;
+	const struct object_id *oid;
+	oidset_iter_init(common, &iter);
+
+	while ((oid = oidset_iter_next(&iter))) {
+		packet_buf_write(req_buf, "have %s\n", oid_to_hex(oid));
+	}
+}
+
+static int add_haves(struct strbuf *req_buf, int *haves_to_send, int *in_vain)
+{
+	int ret = 0;
+	int haves_added = 0;
+	const struct object_id *oid;
+
+	while ((oid = get_rev())) {
+		packet_buf_write(req_buf, "have %s\n", oid_to_hex(oid));
+		if (++haves_added >= *haves_to_send)
+			break;
+	}
+
+	*in_vain += haves_added;
+	if (!haves_added || *in_vain >= MAX_IN_VAIN) {
+		/* Send Done */
+		packet_buf_write(req_buf, "done\n");
+		ret = 1;
+	}
+
+	/* Increase haves to send on next round */
+	*haves_to_send = next_flush(1, *haves_to_send);
+
+	return ret;
+}
+
+static int send_fetch_request(int fd_out, const struct fetch_pack_args *args,
+			      const struct ref *wants, struct oidset *common,
+			      int *haves_to_send, int *in_vain)
+{
+	int ret = 0;
+	struct strbuf req_buf = STRBUF_INIT;
+
+	if (server_supports_v2("fetch", 1))
+		packet_buf_write(&req_buf, "command=fetch");
+	if (server_supports_v2("agent", 0))
+		packet_buf_write(&req_buf, "agent=%s", git_user_agent_sanitized());
+
+	packet_buf_delim(&req_buf);
+	if (args->use_thin_pack)
+		packet_buf_write(&req_buf, "thin-pack");
+	if (args->no_progress)
+		packet_buf_write(&req_buf, "no-progress");
+	if (args->include_tag)
+		packet_buf_write(&req_buf, "include-tag");
+	if (prefer_ofs_delta)
+		packet_buf_write(&req_buf, "ofs-delta");
+
+	/* add wants */
+	add_wants(wants, &req_buf);
+
+	/* Add all of the common commits we've found in previous rounds */
+	add_common(&req_buf, common);
+
+	/* Add initial haves */
+	ret = add_haves(&req_buf, haves_to_send, in_vain);
+
+	/* Send request */
+	packet_buf_flush(&req_buf);
+	write_or_die(fd_out, req_buf.buf, req_buf.len);
+
+	strbuf_release(&req_buf);
+	return ret;
+}
+
+/*
+ * Processes a section header in a server's response and checks if it matches
+ * `section`.  If the value of `peek` is 1, the header line will be peeked (and
+ * not consumed); if 0, the line will be consumed and the function will die if
+ * the section header doesn't match what was expected.
+ */
+static int process_section_header(struct packet_reader *reader,
+				  const char *section, int peek)
+{
+	int ret;
+
+	if (packet_reader_peek(reader) != PACKET_READ_NORMAL)
+		die("error reading packet");
+
+	ret = !strcmp(reader->line, section);
+
+	if (!peek) {
+		if (!ret)
+			die("expected '%s', received '%s'",
+			    section, reader->line);
+		packet_reader_read(reader);
+	}
+
+	return ret;
+}
+
+static int process_acks(struct packet_reader *reader, struct oidset *common)
+{
+	/* received */
+	int received_ready = 0;
+	int received_ack = 0;
+
+	process_section_header(reader, "acknowledgments", 0);
+	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
+		const char *arg;
+
+		if (!strcmp(reader->line, "NAK"))
+			continue;
+
+		if (skip_prefix(reader->line, "ACK ", &arg)) {
+			struct object_id oid;
+			if (!get_oid_hex(arg, &oid)) {
+				struct commit *commit;
+				oidset_insert(common, &oid);
+				commit = lookup_commit(&oid);
+				mark_common(commit, 0, 1);
+			}
+			continue;
+		}
+
+		if (!strcmp(reader->line, "ready")) {
+			clear_prio_queue(&rev_list);
+			received_ready = 1;
+			continue;
+		}
+
+		die("unexpected acknowledgment line: '%s'", reader->line);
+	}
+
+	if (reader->status != PACKET_READ_FLUSH &&
+	    reader->status != PACKET_READ_DELIM)
+		die("error processing acks: %d", reader->status);
+
+	/* return 0 if no common, 1 if there are common, or 2 if ready */
+	return received_ready ? 2 : (received_ack ? 1 : 0);
+}
+
+enum fetch_state {
+	FETCH_CHECK_LOCAL = 0,
+	FETCH_SEND_REQUEST,
+	FETCH_PROCESS_ACKS,
+	FETCH_GET_PACK,
+	FETCH_DONE,
+};
+
+static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
+				    int fd[2],
+				    const struct ref *orig_ref,
+				    struct ref **sought, int nr_sought,
+				    char **pack_lockfile)
+{
+	struct ref *ref = copy_ref_list(orig_ref);
+	enum fetch_state state = FETCH_CHECK_LOCAL;
+	struct oidset common = OIDSET_INIT;
+	struct packet_reader reader;
+	int in_vain = 0;
+	int haves_to_send = INITIAL_FLUSH;
+	packet_reader_init(&reader, fd[0], NULL, 0,
+			   PACKET_READ_CHOMP_NEWLINE);
+
+	while (state != FETCH_DONE) {
+		switch (state) {
+		case FETCH_CHECK_LOCAL:
+			sort_ref_list(&ref, ref_compare_name);
+			QSORT(sought, nr_sought, cmp_ref_by_name);
+
+			/* v2 supports these by default */
+			allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
+			use_sideband = 2;
+
+			if (marked)
+				for_each_ref(clear_marks, NULL);
+			marked = 1;
+
+			for_each_ref(rev_list_insert_ref_oid, NULL);
+			for_each_cached_alternate(insert_one_alternate_object);
+
+			/* Filter 'ref' by 'sought' and those that aren't local */
+			if (everything_local(args, &ref, sought, nr_sought))
+				state = FETCH_DONE;
+			else
+				state = FETCH_SEND_REQUEST;
+			break;
+		case FETCH_SEND_REQUEST:
+			if (send_fetch_request(fd[1], args, ref, &common,
+					       &haves_to_send, &in_vain))
+				state = FETCH_GET_PACK;
+			else
+				state = FETCH_PROCESS_ACKS;
+			break;
+		case FETCH_PROCESS_ACKS:
+			/* Process ACKs/NAKs */
+			switch (process_acks(&reader, &common)) {
+			case 2:
+				state = FETCH_GET_PACK;
+				break;
+			case 1:
+				in_vain = 0;
+				/* fallthrough */
+			default:
+				state = FETCH_SEND_REQUEST;
+				break;
+			}
+			break;
+		case FETCH_GET_PACK:
+			/* get the pack */
+			process_section_header(&reader, "packfile", 0);
+			if (get_pack(args, fd, pack_lockfile))
+				die(_("git fetch-pack: fetch failed."));
+
+			state = FETCH_DONE;
+			break;
+		case FETCH_DONE:
+			continue;
+		}
+	}
+
+	oidset_clear(&common);
+	return ref;
+}
+
 static void fetch_pack_config(void)
 {
 	git_config_get_int("fetch.unpacklimit", &fetch_unpack_limit);
@@ -1153,7 +1406,8 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		       const char *dest,
 		       struct ref **sought, int nr_sought,
 		       struct oid_array *shallow,
-		       char **pack_lockfile)
+		       char **pack_lockfile,
+		       enum protocol_version version)
 {
 	struct ref *ref_cpy;
 	struct shallow_info si;
@@ -1167,8 +1421,12 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		die(_("no matching remote head"));
 	}
 	prepare_shallow_info(&si, shallow);
-	ref_cpy = do_fetch_pack(args, fd, ref, sought, nr_sought,
-				&si, pack_lockfile);
+	if (version == protocol_v2)
+		ref_cpy = do_fetch_pack_v2(args, fd, ref, sought, nr_sought,
+					   pack_lockfile);
+	else
+		ref_cpy = do_fetch_pack(args, fd, ref, sought, nr_sought,
+					&si, pack_lockfile);
 	reprepare_packed_git();
 	update_shallow(args, sought, nr_sought, &si);
 	clear_shallow_info(&si);
diff --git a/fetch-pack.h b/fetch-pack.h
index b6aeb43a8..7afca7305 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -3,6 +3,7 @@
 
 #include "string-list.h"
 #include "run-command.h"
+#include "protocol.h"
 
 struct oid_array;
 
@@ -43,7 +44,8 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		       struct ref **sought,
 		       int nr_sought,
 		       struct oid_array *shallow,
-		       char **pack_lockfile);
+		       char **pack_lockfile,
+		       enum protocol_version version);
 
 /*
  * Print an appropriate error message for each sought ref that wasn't
diff --git a/serve.c b/serve.c
index 05cc434cf..c3e58c1e7 100644
--- a/serve.c
+++ b/serve.c
@@ -53,7 +53,7 @@ struct protocol_capability {
 static struct protocol_capability capabilities[] = {
 	{ "agent", agent_advertise, NULL },
 	{ "ls-refs", always_advertise, ls_refs },
-	{ "fetch", always_advertise, upload_pack_v2 },
+	{ "fetch", upload_pack_advertise, upload_pack_v2 },
 };
 
 static void advertise_capabilities(void)
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index cc5918a67..569922f7a 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -9,7 +9,7 @@ test_expect_success 'test capability advertisement' '
 	version 2
 	agent=git/$(git version | cut -d" " -f3)
 	ls-refs
-	fetch
+	fetch=shallow
 	0000
 	EOF
 
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 562610fd2..4365ac273 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -45,6 +45,56 @@ test_expect_success 'ref advertisment is filtered with ls-remote using protocol
 	test_cmp actual expect
 '
 
+test_expect_success 'clone with git:// using protocol v2' '
+	test_when_finished "rm -f log" &&
+
+	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
+		clone "$GIT_DAEMON_URL/parent" daemon_child &&
+
+	git -C daemon_child log -1 --format=%s >actual &&
+	git -C "$daemon_parent" log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+
+	# Client requested to use protocol v2
+	grep "clone> .*\\\0\\\0version=2\\\0$" log &&
+	# Server responded using protocol v2
+	grep "clone< version 2" log
+'
+
+test_expect_success 'fetch with git:// using protocol v2' '
+	test_when_finished "rm -f log" &&
+
+	test_commit -C "$daemon_parent" two &&
+
+	GIT_TRACE_PACKET="$(pwd)/log" git -C daemon_child -c protocol.version=2 \
+		fetch &&
+
+	git -C daemon_child log -1 --format=%s origin/master >actual &&
+	git -C "$daemon_parent" log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+
+	# Client requested to use protocol v2
+	grep "fetch> .*\\\0\\\0version=2\\\0$" log &&
+	# Server responded using protocol v2
+	grep "fetch< version 2" log
+'
+
+test_expect_success 'pull with git:// using protocol v2' '
+	test_when_finished "rm -f log" &&
+
+	GIT_TRACE_PACKET="$(pwd)/log" git -C daemon_child -c protocol.version=2 \
+		pull &&
+
+	git -C daemon_child log -1 --format=%s >actual &&
+	git -C "$daemon_parent" log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+
+	# Client requested to use protocol v2
+	grep "fetch> .*\\\0\\\0version=2\\\0$" log &&
+	# Server responded using protocol v2
+	grep "fetch< version 2" log
+'
+
 stop_git_daemon
 
 # Test protocol v2 with 'file://' transport
@@ -80,4 +130,51 @@ test_expect_success 'ref advertisment is filtered with ls-remote using protocol
 	test_cmp actual expect
 '
 
+test_expect_success 'clone with file:// using protocol v2' '
+	test_when_finished "rm -f log" &&
+
+	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
+		clone "file://$(pwd)/file_parent" file_child &&
+
+	git -C file_child log -1 --format=%s >actual &&
+	git -C file_parent log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+
+	# Server responded using protocol v2
+	grep "clone< version 2" log
+'
+
+test_expect_success 'fetch with file:// using protocol v2' '
+	test_when_finished "rm -f log" &&
+
+	test_commit -C file_parent two &&
+
+	GIT_TRACE_PACKET="$(pwd)/log" git -C file_child -c protocol.version=2 \
+		fetch origin &&
+
+	git -C file_child log -1 --format=%s origin/master >actual &&
+	git -C file_parent log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+
+	# Server responded using protocol v2
+	grep "fetch< version 2" log
+'
+
+test_expect_success 'ref advertisment is filtered during fetch using protocol v2' '
+	test_when_finished "rm -f log" &&
+
+	test_commit -C file_parent three &&
+
+	GIT_TRACE_PACKET="$(pwd)/log" git -C file_child -c protocol.version=2 \
+		fetch origin master &&
+
+	git -C file_child log -1 --format=%s origin/master >actual &&
+	git -C file_parent log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+
+	! grep "refs/tags/one" log &&
+	! grep "refs/tags/two" log &&
+	! grep "refs/tags/three" log
+'
+
 test_done
diff --git a/transport.c b/transport.c
index bf7ba6879..8e38352c5 100644
--- a/transport.c
+++ b/transport.c
@@ -256,14 +256,17 @@ static int fetch_refs_via_pack(struct transport *transport,
 
 	switch (data->version) {
 	case protocol_v2:
-		die("support for protocol v2 not implemented yet");
+		refs = fetch_pack(&args, data->fd, data->conn,
+				  refs_tmp ? refs_tmp : transport->remote_refs,
+				  dest, to_fetch, nr_heads, &data->shallow,
+				  &transport->pack_lockfile, data->version);
 		break;
 	case protocol_v1:
 	case protocol_v0:
 		refs = fetch_pack(&args, data->fd, data->conn,
 				  refs_tmp ? refs_tmp : transport->remote_refs,
 				  dest, to_fetch, nr_heads, &data->shallow,
-				  &transport->pack_lockfile);
+				  &transport->pack_lockfile, data->version);
 		break;
 	case protocol_unknown_version:
 		BUG("unknown protocol version");
diff --git a/upload-pack.c b/upload-pack.c
index 2af6b1382..65a1beeb0 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -710,7 +710,6 @@ static void deepen(int depth, int deepen_relative,
 	}
 
 	send_unshallow(shallows);
-	packet_flush(1);
 }
 
 static void deepen_by_rev_list(int ac, const char **av,
@@ -722,7 +721,53 @@ static void deepen_by_rev_list(int ac, const char **av,
 	send_shallow(result);
 	free_commit_list(result);
 	send_unshallow(shallows);
-	packet_flush(1);
+}
+
+/* Returns 1 if a shallow list is sent or 0 otherwise */
+static int send_shallow_list(int depth, int deepen_rev_list,
+			     timestamp_t deepen_since,
+			     struct string_list *deepen_not,
+			     struct object_array *shallows)
+{
+	int ret = 0;
+
+	if (depth > 0 && deepen_rev_list)
+		die("git upload-pack: deepen and deepen-since (or deepen-not) cannot be used together");
+	if (depth > 0) {
+		deepen(depth, deepen_relative, shallows);
+		ret = 1;
+	} else if (deepen_rev_list) {
+		struct argv_array av = ARGV_ARRAY_INIT;
+		int i;
+
+		argv_array_push(&av, "rev-list");
+		if (deepen_since)
+			argv_array_pushf(&av, "--max-age=%"PRItime, deepen_since);
+		if (deepen_not->nr) {
+			argv_array_push(&av, "--not");
+			for (i = 0; i < deepen_not->nr; i++) {
+				struct string_list_item *s = deepen_not->items + i;
+				argv_array_push(&av, s->string);
+			}
+			argv_array_push(&av, "--not");
+		}
+		for (i = 0; i < want_obj.nr; i++) {
+			struct object *o = want_obj.objects[i].item;
+			argv_array_push(&av, oid_to_hex(&o->oid));
+		}
+		deepen_by_rev_list(av.argc, av.argv, shallows);
+		argv_array_clear(&av);
+		ret = 1;
+	} else {
+		if (shallows->nr > 0) {
+			int i;
+			for (i = 0; i < shallows->nr; i++)
+				register_shallow(&shallows->objects[i].item->oid);
+		}
+	}
+
+	shallow_nr += shallows->nr;
+	return ret;
 }
 
 static int process_shallow(const char *line, struct object_array *shallows)
@@ -884,40 +929,10 @@ static void receive_needs(void)
 
 	if (depth == 0 && !deepen_rev_list && shallows.nr == 0)
 		return;
-	if (depth > 0 && deepen_rev_list)
-		die("git upload-pack: deepen and deepen-since (or deepen-not) cannot be used together");
-	if (depth > 0)
-		deepen(depth, deepen_relative, &shallows);
-	else if (deepen_rev_list) {
-		struct argv_array av = ARGV_ARRAY_INIT;
-		int i;
 
-		argv_array_push(&av, "rev-list");
-		if (deepen_since)
-			argv_array_pushf(&av, "--max-age=%"PRItime, deepen_since);
-		if (deepen_not.nr) {
-			argv_array_push(&av, "--not");
-			for (i = 0; i < deepen_not.nr; i++) {
-				struct string_list_item *s = deepen_not.items + i;
-				argv_array_push(&av, s->string);
-			}
-			argv_array_push(&av, "--not");
-		}
-		for (i = 0; i < want_obj.nr; i++) {
-			struct object *o = want_obj.objects[i].item;
-			argv_array_push(&av, oid_to_hex(&o->oid));
-		}
-		deepen_by_rev_list(av.argc, av.argv, &shallows);
-		argv_array_clear(&av);
-	}
-	else
-		if (shallows.nr > 0) {
-			int i;
-			for (i = 0; i < shallows.nr; i++)
-				register_shallow(&shallows.objects[i].item->oid);
-		}
-
-	shallow_nr += shallows.nr;
+	if (send_shallow_list(depth, deepen_rev_list, deepen_since,
+			      &deepen_not, &shallows))
+		packet_flush(1);
 	object_array_clear(&shallows);
 }
 
@@ -1071,6 +1086,13 @@ struct upload_pack_data {
 	struct object_array wants;
 	struct oid_array haves;
 
+	struct object_array shallows;
+	struct string_list deepen_not;
+	int depth;
+	timestamp_t deepen_since;
+	int deepen_rev_list;
+	int deepen_relative;
+
 	unsigned stateless_rpc : 1;
 
 	unsigned use_thin_pack : 1;
@@ -1084,16 +1106,22 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 {
 	struct object_array wants = OBJECT_ARRAY_INIT;
 	struct oid_array haves = OID_ARRAY_INIT;
+	struct object_array shallows = OBJECT_ARRAY_INIT;
+	struct string_list deepen_not = STRING_LIST_INIT_DUP;
 
 	memset(data, 0, sizeof(*data));
 	data->wants = wants;
 	data->haves = haves;
+	data->shallows = shallows;
+	data->deepen_not = deepen_not;
 }
 
 static void upload_pack_data_clear(struct upload_pack_data *data)
 {
 	object_array_clear(&data->wants);
 	oid_array_clear(&data->haves);
+	object_array_clear(&data->shallows);
+	string_list_clear(&data->deepen_not, 0);
 }
 
 static int parse_want(const char *line)
@@ -1178,6 +1206,22 @@ static void process_args(struct argv_array *args, struct upload_pack_data *data)
 			continue;
 		}
 
+		/* Shallow related arguments */
+		if (process_shallow(arg, &data->shallows))
+			continue;
+		if (process_deepen(arg, &data->depth))
+			continue;
+		if (process_deepen_since(arg, &data->deepen_since,
+					 &data->deepen_rev_list))
+			continue;
+		if (process_deepen_not(arg, &data->deepen_not,
+				       &data->deepen_rev_list))
+			continue;
+		if (!strcmp(arg, "deepen-relative")) {
+			data->deepen_relative = 1;
+			continue;
+		}
+
 		/* ignore unknown lines maybe? */
 		die("unexpect line: '%s'", arg);
 	}
@@ -1273,6 +1317,23 @@ static int process_haves_and_send_acks(struct upload_pack_data *data)
 	return ret;
 }
 
+static void send_shallow_info(struct upload_pack_data *data)
+{
+	/* No shallow info needs to be sent */
+	if (!data->depth && !data->deepen_rev_list && !data->shallows.nr &&
+	    !is_repository_shallow())
+		return;
+
+	packet_write_fmt(1, "shallow-info\n");
+
+	if (!send_shallow_list(data->depth, data->deepen_rev_list,
+			       data->deepen_since, &data->deepen_not,
+			       &data->shallows) && is_repository_shallow())
+		deepen(INFINITE_DEPTH, data->deepen_relative, &data->shallows);
+
+	packet_delim(1);
+}
+
 enum fetch_state {
 	FETCH_PROCESS_ARGS = 0,
 	FETCH_SEND_ACKS,
@@ -1320,6 +1381,8 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 				state = FETCH_DONE;
 			break;
 		case FETCH_SEND_PACK:
+			send_shallow_info(&data);
+
 			packet_write_fmt(1, "packfile\n");
 			create_pack_file();
 			state = FETCH_DONE;
@@ -1332,3 +1395,11 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 	upload_pack_data_clear(&data);
 	return 0;
 }
+
+int upload_pack_advertise(struct repository *r,
+			  struct strbuf *value)
+{
+	if (value)
+		strbuf_addstr(value, "shallow");
+	return 1;
+}
diff --git a/upload-pack.h b/upload-pack.h
index 6b7890238..7720f2142 100644
--- a/upload-pack.h
+++ b/upload-pack.h
@@ -14,5 +14,8 @@ struct repository;
 struct argv_array;
 extern int upload_pack_v2(struct repository *r, struct argv_array *keys,
 			  struct argv_array *args);
+struct strbuf;
+extern int upload_pack_advertise(struct repository *r,
+				 struct strbuf *value);
 
 #endif /* UPLOAD_PACK_H */
-- 
2.16.2.395.g2e18187dfd-goog

