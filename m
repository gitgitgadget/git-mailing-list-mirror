Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E696C1F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751257AbeACATT (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:19:19 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:42612 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751240AbeACATM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:19:12 -0500
Received: by mail-io0-f193.google.com with SMTP id x67so459289ioi.9
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WkYnUZLwyQ9J/nr0tbTERaJyLCbQIb4f/PhjlHsetvA=;
        b=vGc3xuBaHw8Kxy03euQnGN3rjjr3o5E3Y9myc9XZiJZnVNxZGyQpP2Hc/UvqGWhPYW
         XHNqtdkDhHeuCGGO8hgT9/hdEURrn4MS3cSl0/tXuXe1FbU4W3y/BOCf4ZrCiJLermAg
         p1EeqYv3s+iY4aVOz0en1+Qp33GtDpyBO2nGkCzzmcPi2jFP3M0qxuAtzLpqt3if86YN
         k2Hfvw/gdZeEuilUER/R8pGL0IO1Bvx6LMZZEPkqQcazS/xZLbhv561PZcTMVEOAWaUf
         UT6kwJKzJud3VEM1zmy4y5mJDOcH/4AOQRalwf8G2ZDzh5CdmwPVCnahtZY9AxHVa7Rm
         fH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WkYnUZLwyQ9J/nr0tbTERaJyLCbQIb4f/PhjlHsetvA=;
        b=U5Zh8L1Cdby/ENhZaVguJ1XzCAoGcObBE3uAWD6D5dQWCpBZJo4Yj/t0AQdHWEO4w0
         ZKrYu3yrZCUKYGz0CIaU8sLzVIQxpBbNgDsZB8/7HyIPnNLZbaqpLqsK6BhXkasVVQCL
         ukNDS9JmiVXAwsTtIos/4h4M0e9yHvgpbZlDJgnJQyiIEhbJN/wIwnrfpshI9zNH5pWS
         iQIo3aiAoZR9/jE07TM4FybVhsxERj1o2UHQo6D4tzbsRGoGST6pJiL+mL1kUNQR3Am4
         /R4dXKRwerhPky2G2SUhOm4mTXyKPbJWXilDmhKNFd3yk7jJb+NNL2xNRmqsbT46zj84
         lzYg==
X-Gm-Message-State: AKGB3mJK35UqvGY0ymc2u6sQjsh/AhFlb04NKNTmGmm3X2pbD6lWivJ1
        my9Xy/DhlHeoHt7y0A7UiLHF3eTSDSY=
X-Google-Smtp-Source: ACJfBoudJtc2VvK4mAxHr5YrIQW9+kjFuvi7ljE47z8S2aRxRopAqdC2kKuVkOkUmTtwDyGS7HPTFA==
X-Received: by 10.107.136.42 with SMTP id k42mr61525528iod.124.1514938750931;
        Tue, 02 Jan 2018 16:19:10 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q2sm12679ite.17.2018.01.02.16.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 16:19:10 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 20/26] fetch-pack: perform a fetch using v2
Date:   Tue,  2 Jan 2018 16:18:22 -0800
Message-Id: <20180103001828.205012-21-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103001828.205012-1-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When communicating with a v2 server, perform a fetch by requesting the
'fetch' command.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch-pack.c   |   2 +-
 fetch-pack.c           | 267 ++++++++++++++++++++++++++++++++++++++++++++++++-
 fetch-pack.h           |   4 +-
 t/t5701-protocol-v2.sh |  40 ++++++++
 transport.c            |   8 +-
 5 files changed, 314 insertions(+), 7 deletions(-)

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
index 9f6b07ad9..c26fdc539 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1008,6 +1008,262 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
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
+static int send_haves(int fd_out, int *in_vain)
+{
+	int ret = 0;
+	struct strbuf req_buf = STRBUF_INIT;
+
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
+static int send_fetch_request(int fd_out, const struct fetch_pack_args *args,
+			      const struct ref *wants, struct oidset *common,
+			      int *in_vain)
+{
+	int ret = 0;
+	struct strbuf req_buf = STRBUF_INIT;
+
+	packet_buf_write(&req_buf, "command=fetch");
+	packet_buf_write(&req_buf, "agent=%s", git_user_agent_sanitized());
+	if (args->stateless_rpc)
+		packet_buf_write(&req_buf, "stateless-rpc=true");
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
+	/*
+	 * If we are running stateless-rpc we need to add all the common
+	 * commits we've found in previous rounds
+	 */
+	if (args->stateless_rpc) {
+		struct oidset_iter iter;
+		const struct object_id *oid;
+		oidset_iter_init(common, &iter);
+
+		while ((oid = oidset_iter_next(&iter))) {
+			packet_buf_write(&req_buf, "have %s\n", oid_to_hex(oid));
+		}
+	}
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
+static enum ack_type process_ack(const char *line, struct object_id *oid)
+{
+	const char *arg;
+
+	if (!strcmp(line, "NAK"))
+		return NAK;
+	if (skip_prefix(line, "ACK ", &arg)) {
+		if (!parse_oid_hex(arg, oid, &arg)) {
+			if (strstr(arg, "continue"))
+				return ACK_continue;
+			if (strstr(arg, "common"))
+				return ACK_common;
+			if (strstr(arg, "ready"))
+				return ACK_ready;
+			return ACK;
+		}
+	}
+	if (skip_prefix(line, "ERR ", &arg))
+		die(_("remote error: %s"), arg);
+	die(_("git fetch-pack: expected ACK/NAK, got '%s'"), line);
+}
+
+static int process_acks(struct packet_reader *reader, struct oidset *common)
+{
+	int got_ready = 0;
+	int got_common = 0;
+	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
+		struct object_id oid;
+		struct commit *commit;
+		enum ack_type ack = process_ack(reader->line, &oid);
+
+		switch (ack) {
+		case ACK_ready:
+			clear_prio_queue(&rev_list);
+			got_ready = 1;
+			/* fallthrough */
+		case ACK_common:
+			oidset_insert(common, &oid);
+			commit = lookup_commit(&oid);
+			mark_common(commit, 0, 1);
+			got_common = 1;
+			break;
+		case NAK:
+			break;
+		case ACK:
+		case ACK_continue:
+			die("ACK/ACK_continue not supported");
+		}
+	}
+
+	if (reader->status != PACKET_READ_FLUSH &&
+	    reader->status != PACKET_READ_DELIM)
+		die("Error during processing acks: %d", reader->status);
+
+	/* return 0 if no common, 1 if there are common, or 2 if ready */
+	return got_ready + got_common;
+}
+
+#define FETCH_CHECK_LOCAL 0
+#define FETCH_SEND_REQUEST 1
+#define FETCH_PROCESS_ACKS 2
+#define FETCH_SEND_HAVES 3
+#define FETCH_GET_PACK 4
+#define FETCH_DONE 5
+
+static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
+				    int fd[2],
+				    const struct ref *orig_ref,
+				    struct ref **sought, int nr_sought,
+				    char **pack_lockfile)
+{
+	struct ref *ref = copy_ref_list(orig_ref);
+	int state = FETCH_CHECK_LOCAL;
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
+				if (args->stateless_rpc)
+					state = FETCH_SEND_REQUEST;
+				else
+					state = FETCH_SEND_HAVES;
+				break;
+			}
+			break;
+		case FETCH_SEND_HAVES:
+			if (send_haves(fd[1], &in_vain))
+				state = FETCH_GET_PACK;
+			else
+				state = FETCH_PROCESS_ACKS;
+			break;
+		case FETCH_GET_PACK:
+			/* get the pack */
+			if (get_pack(args, fd, pack_lockfile))
+				die(_("git fetch-pack: fetch failed."));
+
+			state = FETCH_DONE;
+			break;
+		case FETCH_DONE:
+			break;
+		default:
+			die("invalid state");
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
@@ -1153,7 +1409,8 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		       const char *dest,
 		       struct ref **sought, int nr_sought,
 		       struct oid_array *shallow,
-		       char **pack_lockfile)
+		       char **pack_lockfile,
+		       enum protocol_version version)
 {
 	struct ref *ref_cpy;
 	struct shallow_info si;
@@ -1167,8 +1424,12 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
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
diff --git a/t/t5701-protocol-v2.sh b/t/t5701-protocol-v2.sh
index 7d8aeb766..3e411e178 100755
--- a/t/t5701-protocol-v2.sh
+++ b/t/t5701-protocol-v2.sh
@@ -33,4 +33,44 @@ test_expect_success 'ref advertisment is filtered with ls-remote using protocol
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
+	# Server responded using protocol v1
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
+	# Server responded using protocol v1
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
index 6ea3905e3..4fdbd9adc 100644
--- a/transport.c
+++ b/transport.c
@@ -256,14 +256,18 @@ static int fetch_refs_via_pack(struct transport *transport,
 
 	switch (data->version) {
 	case protocol_v2:
-		die("support for protocol v2 not implemented yet");
+		refs = fetch_pack(&args, data->fd, data->conn,
+				  refs_tmp ? refs_tmp : transport->remote_refs,
+				  dest, to_fetch, nr_heads, &data->shallow,
+				  &transport->pack_lockfile, data->version);
+		packet_flush(data->fd[1]);
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
2.15.1.620.gb9897f4670-goog

