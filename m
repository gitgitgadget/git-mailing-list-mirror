Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A74A020285
	for <e@80x24.org>; Thu, 24 Aug 2017 22:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754054AbdHXWyJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 18:54:09 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:32982 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754032AbdHXWyE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 18:54:04 -0400
Received: by mail-pg0-f42.google.com with SMTP id t3so4841648pgt.0
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 15:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M3QonLlhd4G3yAHgIuwSIXGjqOOzs60jWEignCaVPHE=;
        b=DeYdPXJL9jjriiYG0/1VHxuO2OMD1hIe/RXG8PPbzxJFHuyzI6Ine6DXmq+Vw14gQL
         wTtH+gHEQ2NCn6qhVTUVv5lq7knhMFdVaoEwk8nW7IhgKYIrCyhsqLpb7J0+outihkGz
         6vfgxSoOZClCJ3jZwDssQERKYe45Wc9R66Jjd6IKKFw+bLrAKLNkmq+XGFBCLNfuiAeF
         91qt2eWQea+Tez9L+oN/Qsn8u/Bme66tfYPwynK3GKupgPTxOcwASZ8keSb/tDFGiH/f
         2ruB587SGYLhWphWN4SPjrHVtsjzifuWmfIVeKZas3GdwZlS4Ll9yWs8KAGiZ0wfU9cp
         56Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M3QonLlhd4G3yAHgIuwSIXGjqOOzs60jWEignCaVPHE=;
        b=D+PR2WPzaC9nDAHNAESna6vQod1ENwY9do3/zB83HSkbHqdS93i1GpkIgfR/MOT2j+
         JPdNUj4u5xjQ4SmCulnqh+urBZioZ+NCaEVDGsqdJt0vO4zBVqDuxHxy5z688yQIdMp+
         DkyMMOBXfx5wOcEwYcnZN/pwK6KPHMIUluoAZ2/Y0UhtlwNvgIRXxkuCT58Zm3NSPfRx
         Q3iMNhMQupCwnSmZ5Ac/T7WN8xhsEBNGrrd41SauNr89falOXH8L1xSzt4/htx2r/+fM
         HF/6XGEDC98LLI28hwKM3u85TBevtUmrnvbg5ek0shntNQAegN+PZL0va+FzQqsW6l0o
         gqKw==
X-Gm-Message-State: AHYfb5gfTLADJ6cf42StH8ZJf+IJnN7CLv4HN/8uAjosJYY2RygLe1wd
        ZovlYBa5HK5Q7MZeN/lelA==
X-Google-Smtp-Source: ADKCNb73qrVf84UOTfT+Dls6tZH+cnJYRqHN21NQ/r5wbepKUCbDgbAwJfv31CTVwYhK/Zq5pqNTog==
X-Received: by 10.84.132.106 with SMTP id 97mr8382067ple.105.1503615243428;
        Thu, 24 Aug 2017 15:54:03 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id x8sm9402667pfi.174.2017.08.24.15.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Aug 2017 15:54:02 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, sbeller@google.com,
        gitster@pobox.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [RFC 6/7] transport: teach client to recognize v2 server response
Date:   Thu, 24 Aug 2017 15:53:27 -0700
Message-Id: <20170824225328.8174-7-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.342.g6490525c54-goog
In-Reply-To: <20170824225328.8174-1-bmwill@google.com>
References: <20170824225328.8174-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach a client to recognize that a server understand protocol v2 by
looking at the first pkt-line the server sends in response.  This is
done by looking for the response "version 2" sent by upload-pack.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch-pack.c |   4 +-
 builtin/send-pack.c  |   5 +-
 connect.c            | 165 ++++++++++++++++++++++++++++++---------------------
 remote-curl.c        |   7 ++-
 remote.h             |  22 ++++++-
 transport.c          |  60 ++++++++++++++++---
 6 files changed, 178 insertions(+), 85 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 366b9d13f..a2a5e1c73 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -52,6 +52,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	struct fetch_pack_args args;
 	struct oid_array shallow = OID_ARRAY_INIT;
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
+	struct remote_refs_scanner scanner;
 
 	packet_trace_identity("fetch-pack");
 
@@ -193,7 +194,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		if (!conn)
 			return args.diag_url ? 0 : 1;
 	}
-	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, &shallow);
+	remote_refs_scanner_init(&scanner, &ref, 0, NULL, &shallow);
+	get_remote_heads(fd[0], NULL, 0, &scanner);
 
 	ref = fetch_pack(&args, fd, conn, ref, dest, sought, nr_sought,
 			 &shallow, pack_lockfile_ptr);
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index fc4f0bb5f..92ec1f871 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -154,6 +154,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	int progress = -1;
 	int from_stdin = 0;
 	struct push_cas_option cas = {0};
+	struct remote_refs_scanner scanner;
 
 	struct option options[] = {
 		OPT__VERBOSITY(&verbose),
@@ -256,8 +257,8 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 			args.verbose ? CONNECT_VERBOSE : 0);
 	}
 
-	get_remote_heads(fd[0], NULL, 0, &remote_refs, REF_NORMAL,
-			 &extra_have, &shallow);
+	remote_refs_scanner_init(&scanner, &remote_refs, REF_NORMAL, &extra_have, &shallow);
+	get_remote_heads(fd[0], NULL, 0, &scanner);
 
 	transport_verify_remote_names(nr_refspecs, refspecs);
 
diff --git a/connect.c b/connect.c
index d609267be..732b651d9 100644
--- a/connect.c
+++ b/connect.c
@@ -107,97 +107,124 @@ static void annotate_refs_with_symref_info(struct ref *ref)
 	string_list_clear(&symref, 0);
 }
 
-/*
- * Read all the refs from the other end
- */
-struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
+void remote_refs_scanner_init(struct remote_refs_scanner *scanner,
 			      struct ref **list, unsigned int flags,
 			      struct oid_array *extra_have,
 			      struct oid_array *shallow_points)
 {
-	struct ref **orig_list = list;
+	memset(scanner, 0, sizeof(*scanner));
+
+	scanner->orig_list = list;
+	*list = NULL;
+	scanner->list = list;
+	scanner->flags = flags;
+	scanner->extra_have = extra_have;
+	scanner->shallow_points = shallow_points;
+}
+
+int process_ref(struct remote_refs_scanner *scanner,
+		const char *buffer, int len)
+{
+	struct ref *ref;
+	struct object_id old_oid;
+	const char *name;
+	int name_len;
+	const char *arg;
+	int ret = 1;
+
+	if (len < 0)
+		die_initial_contact(scanner->seen_response);
+
+	if (!len) {
+		ret = 0;
+		goto out;
+	}
+
+	if (len > 4 && skip_prefix(buffer, "ERR ", &arg))
+		die("remote error: %s", arg);
+
+	if (len == GIT_SHA1_HEXSZ + strlen("shallow ") &&
+	    skip_prefix(buffer, "shallow ", &arg)) {
+		if (get_oid_hex(arg, &old_oid))
+			die("protocol error: expected shallow sha-1, got '%s'", arg);
+		if (!scanner->shallow_points)
+			die("repository on the other end cannot be shallow");
+		oid_array_append(scanner->shallow_points, &old_oid);
+		goto out;
+	}
+
+	if (len < GIT_SHA1_HEXSZ + 2 || get_oid_hex(buffer, &old_oid) ||
+	    buffer[GIT_SHA1_HEXSZ] != ' ')
+		die("protocol error: expected sha/ref, got '%s'", buffer);
+	name = buffer + GIT_SHA1_HEXSZ + 1;
+
+	name_len = strlen(name);
+	if (len != name_len + GIT_SHA1_HEXSZ + 1) {
+		free(server_capabilities);
+		server_capabilities = xstrdup(name + name_len + 1);
+	}
+
+	if (scanner->extra_have && !strcmp(name, ".have")) {
+		oid_array_append(scanner->extra_have, &old_oid);
+		goto out;
+	}
+
+	if (!strcmp(name, "capabilities^{}")) {
+		if (scanner->seen_response)
+			die("protocol error: unexpected capabilities^{}");
+		if (scanner->recieved_dummy_capabilities_ref)
+			die("protocol error: multiple capabilities^{}");
+		scanner->recieved_dummy_capabilities_ref = 1;
+		ret = 1;
+		goto out;
+	}
+
+	if (!check_ref(name, scanner->flags))
+		goto out;
+
+	if (scanner->recieved_dummy_capabilities_ref)
+		die("protocol error: unexpected ref after capabilities^{}");
+
+	ref = alloc_ref(buffer + GIT_SHA1_HEXSZ + 1);
+	oidcpy(&ref->old_oid, &old_oid);
+
+	*scanner->list = ref;
+	scanner->list = &ref->next;
+
+out:
+	scanner->seen_response = 1;
+	scanner->done = !ret;
+	return ret;
+}
 
+/*
+ * Read all the refs from the other end
+ */
+struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
+			      struct remote_refs_scanner *scanner)
+{
 	/*
 	 * A hang-up after seeing some response from the other end
 	 * means that it is unexpected, as we know the other end is
 	 * willing to talk to us.  A hang-up before seeing any
 	 * response does not necessarily mean an ACL problem, though.
 	 */
-	int saw_response;
-	int got_dummy_ref_with_capabilities_declaration = 0;
-
-	*list = NULL;
-	for (saw_response = 0; ; saw_response = 1) {
-		struct ref *ref;
-		struct object_id old_oid;
-		char *name;
-		int len, name_len;
+	while (!scanner->done) {
 		char *buffer = packet_buffer;
-		const char *arg;
+		int len;
 
 		len = packet_read(in, &src_buf, &src_len,
 				  packet_buffer, sizeof(packet_buffer),
 				  PACKET_READ_GENTLE_ON_EOF |
 				  PACKET_READ_CHOMP_NEWLINE);
-		if (len < 0)
-			die_initial_contact(saw_response);
 
-		if (!len)
+		if (!process_ref(scanner, buffer, len))
 			break;
-
-		if (len > 4 && skip_prefix(buffer, "ERR ", &arg))
-			die("remote error: %s", arg);
-
-		if (len == GIT_SHA1_HEXSZ + strlen("shallow ") &&
-			skip_prefix(buffer, "shallow ", &arg)) {
-			if (get_oid_hex(arg, &old_oid))
-				die("protocol error: expected shallow sha-1, got '%s'", arg);
-			if (!shallow_points)
-				die("repository on the other end cannot be shallow");
-			oid_array_append(shallow_points, &old_oid);
-			continue;
-		}
-
-		if (len < GIT_SHA1_HEXSZ + 2 || get_oid_hex(buffer, &old_oid) ||
-			buffer[GIT_SHA1_HEXSZ] != ' ')
-			die("protocol error: expected sha/ref, got '%s'", buffer);
-		name = buffer + GIT_SHA1_HEXSZ + 1;
-
-		name_len = strlen(name);
-		if (len != name_len + GIT_SHA1_HEXSZ + 1) {
-			free(server_capabilities);
-			server_capabilities = xstrdup(name + name_len + 1);
-		}
-
-		if (extra_have && !strcmp(name, ".have")) {
-			oid_array_append(extra_have, &old_oid);
-			continue;
-		}
-
-		if (!strcmp(name, "capabilities^{}")) {
-			if (saw_response)
-				die("protocol error: unexpected capabilities^{}");
-			if (got_dummy_ref_with_capabilities_declaration)
-				die("protocol error: multiple capabilities^{}");
-			got_dummy_ref_with_capabilities_declaration = 1;
-			continue;
-		}
-
-		if (!check_ref(name, flags))
-			continue;
-
-		if (got_dummy_ref_with_capabilities_declaration)
-			die("protocol error: unexpected ref after capabilities^{}");
-
-		ref = alloc_ref(buffer + GIT_SHA1_HEXSZ + 1);
-		oidcpy(&ref->old_oid, &old_oid);
-		*list = ref;
-		list = &ref->next;
 	}
 
-	annotate_refs_with_symref_info(*orig_list);
+	annotate_refs_with_symref_info(*scanner->orig_list);
 
-	return list;
+	return scanner->list;
 }
 
 static const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp)
diff --git a/remote-curl.c b/remote-curl.c
index 0053b0954..04c191493 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -175,9 +175,12 @@ static struct discovery *last_discovery;
 
 static struct ref *parse_git_refs(struct discovery *heads, int for_push)
 {
+	struct remote_refs_scanner scanner;
 	struct ref *list = NULL;
-	get_remote_heads(-1, heads->buf, heads->len, &list,
-			 for_push ? REF_NORMAL : 0, NULL, &heads->shallow);
+	remote_refs_scanner_init(&scanner, &list, for_push ? REF_NORMAL : 0,
+				 NULL, &heads->shallow);
+	get_remote_heads(-1, heads->buf, heads->len, &scanner);
+
 	return list;
 }
 
diff --git a/remote.h b/remote.h
index 2ecf4c8c7..3a60b8fc4 100644
--- a/remote.h
+++ b/remote.h
@@ -150,10 +150,26 @@ int check_ref_type(const struct ref *ref, int flags);
 void free_refs(struct ref *ref);
 
 struct oid_array;
+
+struct remote_refs_scanner {
+	struct ref **orig_list;
+	struct ref **list;
+	unsigned int flags;
+	struct oid_array *extra_have;
+	struct oid_array *shallow_points;
+	unsigned seen_response : 1;
+	unsigned recieved_dummy_capabilities_ref : 1;
+	unsigned done : 1;
+};
+void remote_refs_scanner_init(struct remote_refs_scanner *scanner,
+			      struct ref **list, unsigned int flags,
+			      struct oid_array *extra_have,
+			      struct oid_array *shallow_points);
+int process_ref(struct remote_refs_scanner *scanner,
+		const char *buffer, int len);
+
 extern struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
-				     struct ref **list, unsigned int flags,
-				     struct oid_array *extra_have,
-				     struct oid_array *shallow);
+				     struct remote_refs_scanner *scanner);
 
 int resolve_remote_symref(struct ref *ref, struct ref *list);
 int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid);
diff --git a/transport.c b/transport.c
index d75ff0514..c05e167d6 100644
--- a/transport.c
+++ b/transport.c
@@ -187,18 +187,59 @@ static int connect_setup(struct transport *transport, int for_push)
 	return 0;
 }
 
+static int determine_version(int fd, struct strbuf *packet)
+{
+	const char *v;
+	int len;
+
+	len = strbuf_packet_read(fd, packet,
+				 PACKET_READ_GENTLE_ON_EOF |
+				 PACKET_READ_CHOMP_NEWLINE);
+	if (len < 0)
+		return -1;
+
+	if (skip_prefix(packet->buf, "version ", &v)) {
+		return 2;
+	}
+
+	return 1;
+}
+
 static struct ref *get_refs_via_connect(struct transport *transport, int for_push)
 {
 	struct git_transport_data *data = transport->data;
+	struct strbuf buf = STRBUF_INIT;
+	struct remote_refs_scanner scanner;
 	struct ref *refs;
 
+	remote_refs_scanner_init(&scanner, &refs, for_push ? REF_NORMAL : 0,
+				 &data->extra_have, &data->shallow);
+
 	connect_setup(transport, for_push);
-	get_remote_heads(data->fd[0], NULL, 0, &refs,
-			 for_push ? REF_NORMAL : 0,
-			 &data->extra_have,
-			 &data->shallow);
+
+	if (0)
+		determine_version(-1, NULL);
+	switch(determine_version(data->fd[0], &buf)) {
+	case 2:
+		/* The server understands Protocol v2 */
+		fprintf(stderr, "Server understands Protocol v2!\n");
+		break;
+	case 1:
+		/* Server is speaking Protocol v1 and sent a ref so process it */
+		process_ref(&scanner, buf.buf, buf.len);
+		break;
+	default:
+		process_ref(&scanner, NULL, -1);
+		break;
+
+	}
+
+	get_remote_heads(data->fd[0], NULL, 0, &scanner);
+
 	data->got_remote_heads = 1;
 
+	strbuf_release(&buf);
+
 	return refs;
 }
 
@@ -231,9 +272,11 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.update_shallow = data->options.update_shallow;
 
 	if (!data->got_remote_heads) {
+		struct remote_refs_scanner scanner;
 		connect_setup(transport, 0);
-		get_remote_heads(data->fd[0], NULL, 0, &refs_tmp, 0,
-				 NULL, &data->shallow);
+
+		remote_refs_scanner_init(&scanner, &refs_tmp, 0, NULL, &data->shallow);
+		get_remote_heads(data->fd[0], NULL, 0, &scanner);
 		data->got_remote_heads = 1;
 	}
 
@@ -544,10 +587,11 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 
 	if (!data->got_remote_heads) {
 		struct ref *tmp_refs;
+		struct remote_refs_scanner scanner;
 		connect_setup(transport, 1);
 
-		get_remote_heads(data->fd[0], NULL, 0, &tmp_refs, REF_NORMAL,
-				 NULL, &data->shallow);
+		remote_refs_scanner_init(&scanner, &tmp_refs, REF_NORMAL, NULL, &data->shallow);
+		get_remote_heads(data->fd[0], NULL, 0, &scanner);
 		data->got_remote_heads = 1;
 	}
 
-- 
2.14.1.342.g6490525c54-goog

