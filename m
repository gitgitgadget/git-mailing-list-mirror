Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B834F1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 01:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932243AbeBGBOH (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:14:07 -0500
Received: from mail-ot0-f201.google.com ([74.125.82.201]:46822 "EHLO
        mail-ot0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932237AbeBGBOE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:14:04 -0500
Received: by mail-ot0-f201.google.com with SMTP id m10so2148922oth.13
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=CmudloQayDU0J5lmss//9E/eUuIpAFMf4x/DoB3uHbY=;
        b=lLTHBoQVpgpVwdC9bgOD3BY87gFfjU4ukON8iduGOpPOo3qsR1KImm4NjX9fEYblUx
         Bxei5kvTLlSBPnumWHlDI3GjQQkPhQCPLuKlRg4y4/vY+yv/QFa7/mEOpW2hThI7+FBp
         aQER/8xV7rfV6vCNerYqV+xqoj5OKs8sPZ9UZmo4t94WVmIxhtOnxzdXzsJNCFq4BHZ8
         3aR7zogZd+n3z0kL0i1F6k6WItD1gFmGskEeyzVZE1qQtTKUd2+zjQv5DHWeDjTiB8s9
         0/Ape3JQI6DboW8atF8ysAM1OovCeCI3vfuu6+XWqlb3WyWMFpUXr1Rqm84mU3dC8jIZ
         IIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=CmudloQayDU0J5lmss//9E/eUuIpAFMf4x/DoB3uHbY=;
        b=Dna7LloAwIqeM7F6narSz/guokD1YKMXQcYNwVjQCFLmBZZkoMj6geqdzBAbnSQI9p
         XCwkAd4GPtzac27zy85wp1fU4SODUoXvlRSejP05FF0cTy2lWHBUX4JCdoA6dHaDBBQl
         O0zzk50+WfQnWJHdcErJ399RP1T4eA4Pjg4oaqOuu0OfsAFkc5Q6nteDde2WS0U12tGi
         MtnUp145iPLH/aR2fPHM3CN8S7TWruh85KM3shroh7Fqsh7U5T2mKK2cGObsldw0oysK
         Svoi5WFqH/SzaHR8fsF5NLOpl1J5LRaJA3BrMeMS+T444UfBI8cIMMDqDZZX/VwMTxo0
         1axA==
X-Gm-Message-State: APf1xPBZyR2QpL6pegOvQrVirE3tJVJQpM/0pXMIAy+JArdtFQ7EdsIi
        7GG68JA9FpFAR3TRB98xkjZSvyn8L1JL022WyqiKENJZkA1np0ELzhfgljwLrH9CWRamC3pOgDI
        panu5WK4ysVTrjlHeZRR/QVSfq3bbRTFcGy5HtmqjVf193EVnKxCCoQY3Ug==
X-Google-Smtp-Source: AH8x227bLSWfpra5dWZn6vvJY650EGKLrOPUUUbvvwk6sc8SFQ3aCvwmQniuXrVZVe4tUmYbabYecWT1p98=
MIME-Version: 1.0
X-Received: by 10.157.112.19 with SMTP id k19mr2202538otj.117.1517966044220;
 Tue, 06 Feb 2018 17:14:04 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:12:58 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180207011312.189834-22-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 21/35] fetch-pack: perform a fetch using v2
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

When communicating with a v2 server, perform a fetch by requesting the
'fetch' command.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch-pack.c   |   2 +-
 fetch-pack.c           | 252 ++++++++++++++++++++++++++++++++++++++++++++++++-
 fetch-pack.h           |   4 +-
 t/t5702-protocol-v2.sh |  84 +++++++++++++++++
 transport.c            |   7 +-
 5 files changed, 342 insertions(+), 7 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index f492e8abd..867dd3cc7 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -213,7 +213,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	}
 
 	ref = fetch_pack(&args, fd, conn, ref, dest, sought, nr_sought,
-			 &shallow, pack_lockfile_ptr);
+			 &shallow, pack_lockfile_ptr, protocol_v0);
 	if (pack_lockfile) {
 		printf("lock %s\n", pack_lockfile);
 		fflush(stdout);
diff --git a/fetch-pack.c b/fetch-pack.c
index 9f6b07ad9..4fb5805dd 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1008,6 +1008,247 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
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
+static int add_haves(struct strbuf *req_buf, int *in_vain)
+{
+	int ret = 0;
+	int haves_added = 0;
+	const struct object_id *oid;
+
+	while ((oid = get_rev())) {
+		packet_buf_write(req_buf, "have %s\n", oid_to_hex(oid));
+		if (++haves_added >= INITIAL_FLUSH)
+			break;
+	};
+
+	*in_vain += haves_added;
+	if (!haves_added || *in_vain >= MAX_IN_VAIN) {
+		/* Send Done */
+		packet_buf_write(req_buf, "done\n");
+		ret = 1;
+	}
+
+	return ret;
+}
+
+static int send_fetch_request(int fd_out, const struct fetch_pack_args *args,
+			      const struct ref *wants, struct oidset *common,
+			      int *in_vain)
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
+	ret = add_haves(&req_buf, in_vain);
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
+		die(_("git fetch-pack: expected ACK/NAK, got '%s'"), reader->line);
+	}
+
+	if (reader->status != PACKET_READ_FLUSH &&
+	    reader->status != PACKET_READ_DELIM)
+		die("Error during processing acks: %d", reader->status);
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
+			/* Filter 'ref' by 'sought' and those that aren't local */
+			if (everything_local(args, &ref, sought, nr_sought))
+				state = FETCH_DONE;
+			else
+				state = FETCH_SEND_REQUEST;
+			break;
+		case FETCH_SEND_REQUEST:
+			if (send_fetch_request(fd[1], args, ref, &common, &in_vain))
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
@@ -1153,7 +1394,8 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		       const char *dest,
 		       struct ref **sought, int nr_sought,
 		       struct oid_array *shallow,
-		       char **pack_lockfile)
+		       char **pack_lockfile,
+		       enum protocol_version version)
 {
 	struct ref *ref_cpy;
 	struct shallow_info si;
@@ -1167,8 +1409,12 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
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
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index a33ff6597..16304d1c8 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -38,6 +38,50 @@ test_expect_success 'ref advertisment is filtered with ls-remote using protocol
 	! grep "refs/tags/" log
 '
 
+test_expect_success 'clone with git:// using protocol v2' '
+	GIT_TRACE_PACKET=1 git -c protocol.version=2 \
+		clone "$GIT_DAEMON_URL/parent" daemon_child 2>log &&
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
+	test_commit -C "$daemon_parent" two &&
+
+	GIT_TRACE_PACKET=1 git -C daemon_child -c protocol.version=2 \
+		fetch 2>log &&
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
+	GIT_TRACE_PACKET=1 git -C daemon_child -c protocol.version=2 \
+		pull 2>log &&
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
@@ -66,4 +110,44 @@ test_expect_success 'ref advertisment is filtered with ls-remote using protocol
 	! grep "refs/tags/" log
 '
 
+test_expect_success 'clone with file:// using protocol v2' '
+	GIT_TRACE_PACKET=1 git -c protocol.version=2 \
+		clone "file://$(pwd)/file_parent" file_child 2>log &&
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
+	test_commit -C file_parent two &&
+
+	GIT_TRACE_PACKET=1 git -C file_child -c protocol.version=2 \
+		fetch origin 2>log &&
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
+	test_commit -C file_parent three &&
+
+	GIT_TRACE_PACKET=1 git -C file_child -c protocol.version=2 \
+		fetch origin master 2>log &&
+
+	git -C file_child log -1 --format=%s origin/master >actual &&
+	git -C file_parent log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+
+	grep "ref-pattern master" log &&
+	! grep "refs/tags/" log
+'
+
 test_done
diff --git a/transport.c b/transport.c
index 6ea3905e3..c275f46ed 100644
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
-- 
2.16.0.rc1.238.g530d649a79-goog

