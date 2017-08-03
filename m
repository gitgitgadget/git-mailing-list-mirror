Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26D242047F
	for <e@80x24.org>; Thu,  3 Aug 2017 09:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbdHCJVl (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:21:41 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33282 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752049AbdHCJUM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:20:12 -0400
Received: by mail-wr0-f193.google.com with SMTP id y43so577750wrd.0
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=doHjunnwie/DTB6CxgX3CM0f90dVZwB1eXEe4ElrYTI=;
        b=h8I8FeNML8DaTOpxte+UvzVtrDqeBMxJbcDxh+hLtHgQOPy+zlughZIrLLApt/PgIE
         1CGEa6Ckzp6A7k7QIqWfIbntBJv29v3YLQK1TAjxqi8y12B555Yn087UCkNOSiWHXbd4
         Aubufc7q9LWSDFZJhoM4WD8krMXEe8aYWPSxWM+y1Eh7vgpPHBhTDNgdOmIap/2lgI1i
         6cGMgazlYqj8Xg7FEf6QjRh/dQ50/K5JfScfQTGSNwgHIlvvJAmxl3oJgvOzY+WbPeTC
         ur4e4W2WKRoJ1LfZHOwBpSbaPlAIdiw98lb3UpX+TZWjVveu03WSwJpTaKqzy8PGmJoP
         19qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=doHjunnwie/DTB6CxgX3CM0f90dVZwB1eXEe4ElrYTI=;
        b=B22mDMHdQJnZ8nNavBt/779OFbqMqDQTxEVJptXddGQ2Qi27nSO8ZbRbp/7I38NF+c
         Og7XUivxn4WX1u6dZfzLJtyhnnmIqeSdz77u9OMe9Bl6LLHevLYx56q7bpP4JJgQefOD
         G4zsY38q7Lh0z9XMI3U4NTiDtBeZIZdqFQYm/u+vwtk5zU8aCsEctcgOdYC3AdRYbBD5
         n+6XRTAcyCs2xC3yrdKSBMfRubJsHXLZvqyhhN2xt+KLEzR6q+kCwYTVigONNqPlpcrS
         Jdxn6qzCAzkH5bhrRNV73/oR0Hfq4hlXC2BjLNwy8EqgTmqD9RWTZW+6YY+OtByrpWGD
         wi+g==
X-Gm-Message-State: AIVw110C+BOiKj+UhZMcXuKwI+WNvxIZufxSvLURUT01z+Uluhn7RJAq
        xDUPthMbpI4XWfTA
X-Received: by 10.223.179.27 with SMTP id j27mr750918wrd.190.1501752010927;
        Thu, 03 Aug 2017 02:20:10 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:20:10 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ben Peart <benpeart@microsoft.com>
Subject: [PATCH v5 27/40] odb-helper: add init_object_process()
Date:   Thu,  3 Aug 2017 11:19:13 +0200
Message-Id: <20170803091926.1755-28-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

This adds the infrastructure to launch and use long running
sub-processes as external odb helpers.

For now only the 'init' and 'get_direct' capabilities are
supported with sub-processes.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c |  52 ++++---
 odb-helper.c   | 481 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 sha1_file.c    |  56 +++++--
 3 files changed, 535 insertions(+), 54 deletions(-)

diff --git a/external-odb.c b/external-odb.c
index ccca67eff5..084cd32e0b 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -67,32 +67,11 @@ const char *external_odb_root(void)
 	return root;
 }
 
-int external_odb_has_object(const unsigned char *sha1)
-{
-	struct odb_helper *o;
-
-	if (!use_external_odb)
-		return 0;
-
-	external_odb_init();
-
-	for (o = helpers; o; o = o->next) {
-		if (!(o->supported_capabilities & ODB_HELPER_CAP_HAVE))
-			return 1;
-		if (odb_helper_has_object(o, sha1))
-			return 1;
-	}
-	return 0;
-}
-
-int external_odb_get_object(const unsigned char *sha1)
+static int external_odb_do_get_object(const unsigned char *sha1)
 {
 	struct odb_helper *o;
 	const char *path;
 
-	if (!external_odb_has_object(sha1))
-		return -1;
-
 	path = sha1_file_name_alt(external_odb_root(), sha1);
 	safe_create_leading_directories_const(path);
 	prepare_external_alt_odb();
@@ -147,6 +126,35 @@ int external_odb_get_direct(const unsigned char *sha1)
 	return -1;
 }
 
+int external_odb_has_object(const unsigned char *sha1)
+{
+	struct odb_helper *o;
+
+	if (!use_external_odb)
+		return 0;
+
+	external_odb_init();
+
+	for (o = helpers; o; o = o->next) {
+		if (!(o->supported_capabilities & ODB_HELPER_CAP_HAVE)) {
+			if (o->supported_capabilities & ODB_HELPER_CAP_GET_DIRECT)
+				return 1;
+			return !external_odb_do_get_object(sha1);
+		}
+		if (odb_helper_has_object(o, sha1))
+			return 1;
+	}
+	return 0;
+}
+
+int external_odb_get_object(const unsigned char *sha1)
+{
+	if (!external_odb_has_object(sha1))
+		return -1;
+
+	return external_odb_do_get_object(sha1);
+}
+
 int external_odb_put_object(const void *buf, size_t len,
 			    const char *type, unsigned char *sha1)
 {
diff --git a/odb-helper.c b/odb-helper.c
index 4c16dd297a..fce1dff501 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -4,6 +4,22 @@
 #include "odb-helper.h"
 #include "run-command.h"
 #include "sha1-lookup.h"
+#include "sub-process.h"
+#include "pkt-line.h"
+#include "sigchain.h"
+
+struct object_process {
+	struct subprocess_entry subprocess;
+	unsigned int supported_capabilities;
+};
+
+static struct hashmap subprocess_map;
+
+static int check_object_process_status(int fd, struct strbuf *status)
+{
+	subprocess_read_status(fd, status);
+	return strcmp(status->buf, "success");
+}
 
 static void parse_capabilities(char *cap_buf,
 			       unsigned int *supported_capabilities,
@@ -39,6 +55,396 @@ static void parse_capabilities(char *cap_buf,
 	string_list_clear(&cap_list, 0);
 }
 
+static int send_start_packets(struct child_process *process, const char *cmd)
+{
+	int err = packet_writel(process->in, "git-read-object-client", "version=1", NULL);
+	if (err)
+		return err;
+
+	err = strcmp(packet_read_line(process->out, NULL), "git-read-object-server");
+	if (err) {
+		error("external process '%s' does not support read-object protocol version 1", cmd);
+		return err;
+	}
+	err = strcmp(packet_read_line(process->out, NULL), "version=1");
+	if (err)
+		return err;
+	err = packet_read_line(process->out, NULL) != NULL;
+	if (err)
+		return err;
+
+	return packet_writel(process->in,
+			     "capability=get_git_obj",
+			     "capability=get_raw_obj",
+			     "capability=get_direct",
+			     "capability=put_raw_obj",
+			     "capability=have",
+			     NULL);
+}
+
+static int start_object_process_fn(struct subprocess_entry *subprocess)
+{
+	int err;
+	struct object_process *entry = (struct object_process *)subprocess;
+	struct child_process *process = &subprocess->process;
+	char *cap_buf;
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	err = send_start_packets(process, subprocess->cmd);
+
+	if (!err)
+		while ((cap_buf = packet_read_line(process->out, NULL)))
+			parse_capabilities(cap_buf, &entry->supported_capabilities, subprocess->cmd);
+
+	sigchain_pop(SIGPIPE);
+
+	return err;
+}
+
+static struct object_process *launch_object_process(struct odb_helper *o,
+						    unsigned int capability)
+{
+	struct object_process *entry = NULL;
+
+	if (!subprocess_map.tablesize)
+		hashmap_init(&subprocess_map, (hashmap_cmp_fn) cmd2process_cmp, NULL, 0);
+	else
+		entry = (struct object_process *)subprocess_find_entry(&subprocess_map, o->cmd);
+
+	fflush(NULL);
+
+	if (!entry) {
+		entry = xmalloc(sizeof(*entry));
+		entry->supported_capabilities = 0;
+
+		if (subprocess_start(&subprocess_map, &entry->subprocess, o->cmd, start_object_process_fn)) {
+			error("Could not launch process for cmd '%s'", o->cmd);
+			free(entry);
+			return NULL;
+		}
+	}
+
+	o->supported_capabilities = entry->supported_capabilities;
+
+	if (capability && !(capability & entry->supported_capabilities)) {
+		error("The cmd '%s' does not support capability '%d'", o->cmd, capability);
+		return NULL;
+	}
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	return entry;
+}
+
+static int check_object_process_error(int err,
+				      const char *status,
+				      struct object_process *entry,
+				      const char *cmd,
+				      unsigned int capability)
+{
+	sigchain_pop(SIGPIPE);
+
+	if (!err)
+		return 0;
+
+	if (!strcmp(status, "error")) {
+		/* The process signaled a problem with the file. */
+	} else if (!strcmp(status, "notfound")) {
+		/* Object was not found */
+		err = -1;
+	} else if (!strcmp(status, "abort")) {
+		/*
+		 * The process signaled a permanent problem. Don't try to read
+		 * objects with the same command for the lifetime of the current
+		 * Git process.
+		 */
+		if (capability)
+			entry->supported_capabilities &= ~capability;
+	} else {
+		/*
+		 * Something went wrong with the read-object process.
+		 * Force shutdown and restart if needed.
+		 */
+		error("external object process '%s' failed", cmd);
+		subprocess_stop(&subprocess_map, &entry->subprocess);
+		free(entry);
+	}
+
+	return err;
+}
+
+static int send_init_packets(struct object_process *entry,
+			     struct strbuf *status)
+{
+	struct child_process *process = &entry->subprocess.process;
+
+	return packet_write_fmt_gently(process->in, "command=init\n") ||
+		packet_flush_gently(process->in) ||
+		check_object_process_status(process->out, status);
+}
+
+static int init_object_process(struct odb_helper *o)
+{
+	int err;
+	struct strbuf status = STRBUF_INIT;
+	struct object_process *entry = launch_object_process(o, 0);
+	if (!entry)
+		return -1;
+
+	err = send_init_packets(entry, &status);
+
+	return check_object_process_error(err, status.buf, entry,
+					  o->cmd, 0);
+}
+
+static ssize_t read_packetized_raw_object_to_fd(struct odb_helper *o,
+						const unsigned char *sha1,
+						int fd_in, int fd_out)
+{
+	ssize_t total_read = 0;
+	unsigned long total_got = 0;
+	int packet_len;
+
+	char hdr[32];
+	int hdrlen;
+
+	int ret = Z_STREAM_END;
+	unsigned char compressed[4096];
+	git_zstream stream;
+	git_SHA_CTX hash;
+	unsigned char real_sha1[20];
+
+	off_t size;
+	enum object_type type;
+	const char *s;
+	int pkt_size;
+	char *size_buf;
+
+	size_buf = packet_read_line(fd_in, &pkt_size);
+	if (!skip_prefix(size_buf, "size=", &s))
+		return error("odb helper '%s' did not send size of plain object", o->name);
+	size = strtoumax(s, NULL, 10);
+	if (!skip_prefix(packet_read_line(fd_in, NULL), "kind=", &s))
+		return error("odb helper '%s' did not send kind of plain object", o->name);
+	/* Check if the object is not available */
+	if (!strcmp(s, "none"))
+		return -1;
+	type = type_from_string_gently(s, strlen(s), 1);
+	if (type < 0)
+		return error("odb helper '%s' sent bad type '%s'", o->name, s);
+
+	/* Set it up */
+	git_deflate_init(&stream, zlib_compression_level);
+	stream.next_out = compressed;
+	stream.avail_out = sizeof(compressed);
+	git_SHA1_Init(&hash);
+
+	/* First header.. */
+	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), size) + 1;
+	stream.next_in = (unsigned char *)hdr;
+	stream.avail_in = hdrlen;
+	while (git_deflate(&stream, 0) == Z_OK)
+		; /* nothing */
+	git_SHA1_Update(&hash, hdr, hdrlen);
+
+	for (;;) {
+		/* packet_read() writes a '\0' extra byte at the end */
+		char buf[LARGE_PACKET_DATA_MAX + 1];
+
+		packet_len = packet_read(fd_in, NULL, NULL,
+			buf, LARGE_PACKET_DATA_MAX + 1,
+			PACKET_READ_GENTLE_ON_EOF);
+
+		if (packet_len <= 0)
+			break;
+
+		total_got += packet_len;
+
+		/* Then the data itself.. */
+		stream.next_in = (void *)buf;
+		stream.avail_in = packet_len;
+		do {
+			unsigned char *in0 = stream.next_in;
+			ret = git_deflate(&stream, Z_FINISH);
+			git_SHA1_Update(&hash, in0, stream.next_in - in0);
+			write_or_die(fd_out, compressed, stream.next_out - compressed);
+			stream.next_out = compressed;
+			stream.avail_out = sizeof(compressed);
+		} while (ret == Z_OK);
+
+		total_read += packet_len;
+	}
+
+	if (packet_len < 0) {
+		error("unable to read from odb helper '%s': %s",
+		      o->name, strerror(errno));
+		git_deflate_end(&stream);
+		return packet_len;
+	}
+
+	if (ret != Z_STREAM_END) {
+		warning("bad zlib data from odb helper '%s' for %s",
+			o->name, sha1_to_hex(sha1));
+		return -1;
+	}
+
+	ret = git_deflate_end_gently(&stream);
+	if (ret != Z_OK) {
+		warning("deflateEnd on object %s from odb helper '%s' failed (%d)",
+			sha1_to_hex(sha1), o->name, ret);
+		return -1;
+	}
+	git_SHA1_Final(real_sha1, &hash);
+	if (hashcmp(sha1, real_sha1)) {
+		warning("sha1 mismatch from odb helper '%s' for %s (got %s)",
+			o->name, sha1_to_hex(sha1), sha1_to_hex(real_sha1));
+		return -1;
+	}
+	if (total_got != size) {
+		warning("size mismatch from odb helper '%s' for %s (%lu != %lu)",
+			o->name, sha1_to_hex(sha1), total_got, size);
+		return -1;
+	}
+
+	return total_read;
+}
+
+static ssize_t read_packetized_git_object_to_fd(struct odb_helper *o,
+						const unsigned char *sha1,
+						int fd_in, int fd_out)
+{
+	ssize_t total_read = 0;
+	unsigned long total_got = 0;
+	int packet_len;
+	git_zstream stream;
+	int zret = Z_STREAM_END;
+	git_SHA_CTX hash;
+	unsigned char real_sha1[20];
+
+	memset(&stream, 0, sizeof(stream));
+	git_inflate_init(&stream);
+	git_SHA1_Init(&hash);
+
+	for (;;) {
+		/* packet_read() writes a '\0' extra byte at the end */
+		char buf[LARGE_PACKET_DATA_MAX + 1];
+
+		packet_len = packet_read(fd_in, NULL, NULL,
+			buf, LARGE_PACKET_DATA_MAX + 1,
+			PACKET_READ_GENTLE_ON_EOF);
+
+		if (packet_len <= 0)
+			break;
+
+		write_or_die(fd_out, buf, packet_len);
+
+		stream.next_in = (unsigned char *)buf;
+		stream.avail_in = packet_len;
+		do {
+			unsigned char inflated[4096];
+			unsigned long got;
+
+			stream.next_out = inflated;
+			stream.avail_out = sizeof(inflated);
+			zret = git_inflate(&stream, Z_SYNC_FLUSH);
+			got = sizeof(inflated) - stream.avail_out;
+
+			git_SHA1_Update(&hash, inflated, got);
+			/* skip header when counting size */
+			if (!total_got) {
+				const unsigned char *p = memchr(inflated, '\0', got);
+				if (p)
+					got -= p - inflated + 1;
+				else
+					got = 0;
+			}
+			total_got += got;
+		} while (stream.avail_in && zret == Z_OK);
+
+		total_read += packet_len;
+	}
+
+	git_inflate_end(&stream);
+
+	if (packet_len < 0)
+		return packet_len;
+
+	git_SHA1_Final(real_sha1, &hash);
+
+	if (zret != Z_STREAM_END) {
+		warning("bad zlib data from odb helper '%s' for %s",
+			o->name, sha1_to_hex(sha1));
+		return -1;
+	}
+	if (hashcmp(real_sha1, sha1)) {
+		warning("sha1 mismatch from odb helper '%s' for %s (got %s)",
+			o->name, sha1_to_hex(sha1), sha1_to_hex(real_sha1));
+		return -1;
+	}
+
+	return total_read;
+}
+
+static int send_get_packets(struct odb_helper *o,
+			    struct object_process *entry,
+			    const unsigned char *sha1,
+			    int fd,
+			    unsigned int *cur_cap,
+			    struct strbuf *status)
+{
+	const char *instruction;
+	int err;
+	struct child_process *process = &entry->subprocess.process;
+
+	if (entry->supported_capabilities & ODB_HELPER_CAP_GET_GIT_OBJ) {
+		*cur_cap = ODB_HELPER_CAP_GET_GIT_OBJ;
+		instruction = "get_git_obj";
+	} else if (entry->supported_capabilities & ODB_HELPER_CAP_GET_RAW_OBJ) {
+		*cur_cap = ODB_HELPER_CAP_GET_RAW_OBJ;
+		instruction = "get_raw_obj";
+	} else if (entry->supported_capabilities & ODB_HELPER_CAP_GET_DIRECT) {
+		*cur_cap = ODB_HELPER_CAP_GET_DIRECT;
+		instruction = "get_direct";
+	} else {
+		BUG("No known ODB_HELPER_CAP_GET_XXX capability!");
+	}
+
+	err = packet_write_fmt_gently(process->in, "command=%s\n", instruction);
+	if (err)
+		return err;
+
+	err = packet_write_fmt_gently(process->in, "sha1=%s\n", sha1_to_hex(sha1));
+	if (err)
+		return err;
+
+	err = packet_flush_gently(process->in);
+	if (err)
+		return err;
+
+	if (entry->supported_capabilities & ODB_HELPER_CAP_GET_RAW_OBJ)
+		err = read_packetized_raw_object_to_fd(o, sha1, process->out, fd) < 0;
+	else if (entry->supported_capabilities & ODB_HELPER_CAP_GET_GIT_OBJ)
+		err = read_packetized_git_object_to_fd(o, sha1, process->out, fd) < 0;
+
+	return check_object_process_status(process->out, status);
+}
+
+static int get_object_process(struct odb_helper *o, const unsigned char *sha1, int fd)
+{
+	int err;
+	struct strbuf status = STRBUF_INIT;
+	unsigned int cur_cap = 0;
+	struct object_process *entry = launch_object_process(o, 0);
+	if (!entry)
+		return -1;
+
+	err = send_get_packets(o, entry, sha1, fd, &cur_cap, &status);
+
+	return check_object_process_error(err, status.buf, entry,
+					  o->cmd, cur_cap);
+}
+
 struct odb_helper *odb_helper_new(const char *name, int namelen)
 {
 	struct odb_helper *o;
@@ -117,15 +523,12 @@ static int odb_helper_finish(struct odb_helper *o,
 	return 0;
 }
 
-int odb_helper_init(struct odb_helper *o)
+static int init_object_script(struct odb_helper *o)
 {
 	struct odb_helper_cmd cmd;
 	FILE *fh;
 	struct strbuf line = STRBUF_INIT;
 
-	if (!o->script_mode)
-		return 0;
-
 	if (odb_helper_start(o, &cmd, 0, "init") < 0)
 		return -1;
 
@@ -140,6 +543,21 @@ int odb_helper_init(struct odb_helper *o)
 	return 0;
 }
 
+int odb_helper_init(struct odb_helper *o)
+{
+	int res;
+	uint64_t start = getnanotime();
+
+	if (o->script_mode)
+		res = init_object_script(o);
+	else
+		res = init_object_process(o);
+
+	trace_performance_since(start, "odb_helper_init");
+
+	return 0;
+}
+
 static int parse_object_line(struct odb_helper_object *o, const char *line)
 {
 	char *end;
@@ -414,28 +832,42 @@ static int odb_helper_get_git_object(struct odb_helper *o,
 	return 0;
 }
 
-int odb_helper_get_direct(struct odb_helper *o,
-			  const unsigned char *sha1)
+static int get_direct_script(struct odb_helper *o, const unsigned char *sha1)
 {
-	struct odb_helper_object *obj;
 	struct odb_helper_cmd cmd;
 
-	obj = odb_helper_lookup(o, sha1);
-	if (!obj)
-		return -1;
-
 	if (odb_helper_start(o, &cmd, 0, "get_direct %s", sha1_to_hex(sha1)) < 0)
 		return -1;
-
 	if (odb_helper_finish(o, &cmd))
 		return -1;
-
 	return 0;
 }
 
-int odb_helper_get_object(struct odb_helper *o,
-			  const unsigned char *sha1,
-			  int fd)
+int odb_helper_get_direct(struct odb_helper *o,
+			  const unsigned char *sha1)
+{
+	int res;
+	uint64_t start;
+
+	if (o->supported_capabilities & ODB_HELPER_CAP_HAVE) {
+		struct odb_helper_object *obj = odb_helper_lookup(o, sha1);
+		if (!obj)
+			return -1;
+	}
+
+	start = getnanotime();
+
+	if (o->script_mode)
+		res = get_direct_script(o, sha1);
+	else
+		res = get_object_process(o, sha1, -1);
+
+	trace_performance_since(start, "odb_helper_get_direct");
+
+	return res;
+}
+
+static int get_object_script(struct odb_helper *o, const unsigned char *sha1, int fd)
 {
 	if (o->supported_capabilities & ODB_HELPER_CAP_GET_GIT_OBJ)
 		return odb_helper_get_git_object(o, sha1, fd);
@@ -447,6 +879,23 @@ int odb_helper_get_object(struct odb_helper *o,
 	BUG("invalid get capability (capabilities: '%d')", o->supported_capabilities);
 }
 
+int odb_helper_get_object(struct odb_helper *o,
+			  const unsigned char *sha1,
+			  int fd)
+{
+	int res;
+	uint64_t start = getnanotime();
+
+	if (o->script_mode)
+		res = get_object_script(o, sha1, fd);
+	else
+		res = get_object_process(o, sha1, fd);
+
+	trace_performance_since(start, "odb_helper_get_object");
+
+	return res;
+}
+
 int odb_helper_put_object(struct odb_helper *o,
 			  const void *buf, size_t len,
 			  const char *type, unsigned char *sha1)
diff --git a/sha1_file.c b/sha1_file.c
index 3735720bfc..fb34f0b18d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -698,7 +698,17 @@ int check_and_freshen_file(const char *fn, int freshen)
 
 static int check_and_freshen_local(const unsigned char *sha1, int freshen)
 {
-	return check_and_freshen_file(sha1_file_name(sha1), freshen);
+	int ret;
+	int tried_hook = 0;
+
+retry:
+	ret = check_and_freshen_file(sha1_file_name(sha1), freshen);
+	if (!ret && !tried_hook) {
+		tried_hook = 1;
+		if (!external_odb_get_direct(sha1))
+			goto retry;
+	}
+	return ret;
 }
 
 static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
@@ -3017,20 +3027,11 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	return (status < 0) ? status : 0;
 }
 
-int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi, unsigned flags)
+static int find_cached_or_packed(const unsigned char *sha1, struct object_info *oi,
+				 unsigned flags, struct pack_entry *e, int retry)
 {
-	static struct object_info blank_oi = OBJECT_INFO_INIT;
-	struct pack_entry e;
-	int rtype;
-	const unsigned char *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
-				    lookup_replace_object(sha1) :
-				    sha1;
-
-	if (!oi)
-		oi = &blank_oi;
-
 	if (!(flags & OBJECT_INFO_SKIP_CACHED)) {
-		struct cached_object *co = find_cached_object(real);
+		struct cached_object *co = find_cached_object(sha1);
 		if (co) {
 			if (oi->typep)
 				*(oi->typep) = co->type;
@@ -3049,9 +3050,9 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		}
 	}
 
-	if (!find_pack_entry(real, &e)) {
+	if (!find_pack_entry(sha1, e)) {
 		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(real, oi, flags)) {
+		if (!sha1_loose_object_info(sha1, oi, flags)) {
 			oi->whence = OI_LOOSE;
 			return 0;
 		}
@@ -3061,10 +3062,33 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 			return -1;
 		} else {
 			reprepare_packed_git();
-			if (!find_pack_entry(real, &e))
+			if (!find_pack_entry(sha1, e)) {
+				if (retry && !external_odb_get_direct(sha1))
+					return find_cached_or_packed(sha1, oi, flags, e, 0);
 				return -1;
+			}
 		}
 	}
+	return 1;
+}
+
+int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi, unsigned flags)
+{
+	static struct object_info blank_oi = OBJECT_INFO_INIT;
+	struct pack_entry e;
+	int rtype;
+	enum object_type real_type;
+	int res;
+	const unsigned char *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
+				    lookup_replace_object(sha1) :
+				    sha1;
+
+	if (!oi)
+		oi = &blank_oi;
+
+	res = find_cached_or_packed(real, oi, flags, &e, 1);
+	if (res < 1)
+		return res;
 
 	if (oi == &blank_oi)
 		/*
-- 
2.14.0.rc1.52.gf02fb0ddac.dirty

