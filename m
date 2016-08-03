Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 200A71F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 16:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758113AbcHCQnd (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 12:43:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34669 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757777AbcHCQnE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 12:43:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so37223819wma.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 09:42:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xF/NlO4ALaUrek541A8mWDmLDihO2jVskCXagZbgTsc=;
        b=Sf1ARqySJFUpdC759gGASJUUB28fHWFwZHlqtmEFoNipc7PUMgwavAvcYjldmXSDcQ
         XhJmpqCOdoBzxUzLFKlFU8OQD4WmuNNpfKZ3E3DQCyoKYJarRcvf8GM7Xe4S1lCgnWGm
         rgWg2+sVZCUHdg1XpK+iuEz1e9I4mBIRpJ5rfSACIxCxNr9cKUxHgoZyBpyWSXBou+Tx
         G/iC1uKp6DiVJcD95tH5eWACl0BhwJ0W3Q9PfRRSFnC7HWZq+/Q916/sGKuA0cLUoYLG
         tqYSHLt3QWQZt+U45D9ccvDcI5s25NJ9ULO7YH7DtMwAu2LUz0vk4dBcwrw/XSr6y4MC
         zYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xF/NlO4ALaUrek541A8mWDmLDihO2jVskCXagZbgTsc=;
        b=J7dVDuzKdsPXhTvLPbdPHVAaxHzqlbHgwCfYrYAPs9ebpmNiZnXjf2GPi+UQ5QouqG
         bivJXy08yTy+dSCW4blRd0iBpUfa5xiCjprQ9xHmCxeu+eDEMyWGHUEGDeNUIjriXB1x
         l9ozPGIQxrd/NG4r8uskW0PzdSymSuOGLGJbDwrpz+wNlz4sY3tcumMprJEMU//s4j/q
         +zIhzgYRwE0P+UZ/25RwmUCbdB+krAKsQM1g9GgvcMomOT2x6DGGdSV19yxQz8+aprSs
         QwkQChdU++wawAhOTLrVxpltxQqGfi7X9eTR3DO5caPswy72qi8e91AZdO8LCUpD0YXx
         tqeA==
X-Gm-Message-State: AEkoouuRCFzIukZaV8wMFTFxl+k1C9T4p6WVJ1akSmpXwGVAm4Y+Xs3OapIiNoqRgZ37Bw==
X-Received: by 10.28.4.194 with SMTP id 185mr25704631wme.91.1470242559207;
        Wed, 03 Aug 2016 09:42:39 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 3sm8959736wms.1.2016.08.03.09.42.37
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 09:42:38 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v4 11/12] convert: add filter.<driver>.process option
Date:	Wed,  3 Aug 2016 18:42:24 +0200
Message-Id: <20160803164225.46355-12-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160803164225.46355-1-larsxschneider@gmail.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160803164225.46355-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Git's clean/smudge mechanism invokes an external filter process for every
single blob that is affected by a filter. If Git filters a lot of blobs
then the startup time of the external filter processes can become a
significant part of the overall Git execution time.

In a preliminary performance test this developer used a clean/smudge filter
written in golang to filter 12,000 files. This process took 364s with the
existing filter mechanism and 5s with the new mechanism. See details here:
https://github.com/github/git-lfs/pull/1382

This patch adds the `filter.<driver>.process` string option which, if used,
keeps the external filter process running and processes all blobs with
the packet format (pkt-line) based protocol over standard input and standard
output described below.

Git starts the filter when it encounters the first file
that needs to be cleaned or smudged. After the filter started
Git expects a welcome message, protocol version number, and
filter capabilities separated by spaces:
------------------------
packet:          git< git-filter-protocol\n
packet:          git< version=2\n
packet:          git< capabilities=clean smudge\n
------------------------
Supported filter capabilities are "clean" and "smudge".

Afterwards Git sends a command (based on the supported
capabilities), the pathname of a file relative to the
repository root, the content split in zero or more pkt-line
packets, and a flush packet at the end:
------------------------
packet:          git> command=smudge\n
packet:          git> pathname=path/testfile.dat\n
packet:          git> CONTENT
packet:          git> 0000
------------------------

The filter is expected to respond with the result content in zero
or more pkt-line packets and a flush packet at the end. Finally, a
"result=success" packet is expected if everything went well.
------------------------
packet:          git< SMUDGED_CONTENT
packet:          git< 0000
packet:          git< result=success\n
------------------------

If the result content is empty then the filter is expected to respond
only with a flush packet and a "result=success" packet.
------------------------
packet:          git< 0000
packet:          git< result=success\n
------------------------

In case the filter cannot or does not want to process the content,
it is expected to respond with a flush packet and a "result=reject"
packet. Depending on the `filter.<driver>.required` flag Git will
interpret that as error but it will not stop or restart the filter
process.
------------------------
packet:          git< 0000
packet:          git< result=reject\n
------------------------

If the filter experiences an error during processing, then it can
either die or send a flush packet and a "result=error" packet. If
Git receives such an error then it will stop and restart the filter
with the next file that needs to be processed.
------------------------
packet:          git< HALF_WRITTEN_ERRONEOUS_CONTENT
packet:          git< 0000
packet:          git< result=error\n
------------------------

After the filter has processed a blob it is expected to wait for
the next command. When the Git process terminates, it will send
a kill signal to the filter in that stage.

If a `filter.<driver>.clean` or `filter.<driver>.smudge` command
is configured then these commands always take precedence over
a configured `filter.<driver>.process` command.

Helped-by: Martin-Louis Bright <mlbright@gmail.com>
Reviewed-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/gitattributes.txt |  98 +++++++++++-
 convert.c                       | 277 ++++++++++++++++++++++++++++++----
 t/t0021-conversion.sh           | 322 ++++++++++++++++++++++++++++++++++++++++
 t/t0021/rot13-filter.pl         | 148 ++++++++++++++++++
 4 files changed, 815 insertions(+), 30 deletions(-)
 create mode 100755 t/t0021/rot13-filter.pl

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 8882a3e..49514ab 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -300,7 +300,13 @@ checkout, when the `smudge` command is specified, the command is
 fed the blob object from its standard input, and its standard
 output is used to update the worktree file.  Similarly, the
 `clean` command is used to convert the contents of worktree file
-upon checkin.
+upon checkin. By default these commands process only a single
+blob and terminate.  If a long running `process` filter is used
+in place of `clean` and/or `smudge` filters, then Git can process
+all blobs with a single filter command invocation for the entire
+life of a single Git command, for example `git add --all`.  See
+section below for the description of the protocol used to
+communicate with a `process` filter.
 
 One use of the content filtering is to massage the content into a shape
 that is more convenient for the platform, filesystem, and the user to use.
@@ -375,6 +381,96 @@ substitution.  For example:
 ------------------------
 
 
+Long Running Filter Process
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+If the filter command (a string value) is defined via
+`filter.<driver>.process` then Git can process all blobs with a
+single filter invocation for the entire life of a single Git
+command. This is achieved by using the following packet format
+(pkt-line, see technical/protocol-common.txt) based protocol over
+standard input and standard output.
+
+Git starts the filter when it encounters the first file
+that needs to be cleaned or smudged. After the filter started
+Git expects a welcome message, protocol version number, and
+filter capabilities separated by spaces:
+------------------------
+packet:          git< git-filter-protocol\n
+packet:          git< version=2\n
+packet:          git< capabilities=clean smudge\n
+------------------------
+Supported filter capabilities are "clean" and "smudge".
+
+Afterwards Git sends a command (based on the supported
+capabilities), the pathname of a file relative to the
+repository root, the content split in zero or more pkt-line
+packets, and a flush packet at the end:
+------------------------
+packet:          git> command=smudge\n
+packet:          git> pathname=path/testfile.dat\n
+packet:          git> CONTENT
+packet:          git> 0000
+------------------------
+
+The filter is expected to respond with the result content in zero
+or more pkt-line packets and a flush packet at the end. Finally, a
+"result=success" packet is expected if everything went well.
+------------------------
+packet:          git< SMUDGED_CONTENT
+packet:          git< 0000
+packet:          git< result=success\n
+------------------------
+
+If the result content is empty then the filter is expected to respond
+only with a flush packet and a "result=success" packet.
+------------------------
+packet:          git< 0000
+packet:          git< result=success\n
+------------------------
+
+In case the filter cannot or does not want to process the content,
+it is expected to respond with a flush packet and a "result=reject"
+packet. Depending on the `filter.<driver>.required` flag Git will
+interpret that as error but it will not stop or restart the filter
+process.
+------------------------
+packet:          git< 0000
+packet:          git< result=reject\n
+------------------------
+
+If the filter experiences an error during processing, then it can
+either die or send a flush packet and a "result=error" packet. If
+Git receives such an error then it will stop and restart the filter
+with the next file that needs to be processed.
+------------------------
+packet:          git< HALF_WRITTEN_ERRONEOUS_CONTENT
+packet:          git< 0000
+packet:          git< result=error\n
+------------------------
+
+After the filter has processed a blob it is expected to wait for
+the next command. When the Git process terminates, it will send
+a kill signal to the filter in that stage.
+
+A long running filter demo implementation can be found in
+`t/t0021/rot13-filter.pl` located in the Git core repository.
+If you develop your own long running filter process then the
+`GIT_TRACE_PACKET` environment variables can be very helpful
+for debugging (see linkgit:git[1]).
+
+If a `filter.<driver>.clean` or `filter.<driver>.smudge` command
+is configured then these commands always take precedence over
+a configured `filter.<driver>.process` command.
+
+Please note that you cannot use an existing `filter.<driver>.clean`
+or `filter.<driver>.smudge` command with `filter.<driver>.process`
+because the former two use a different inter process communication
+protocol than the latter one. As soon as Git would detect a file
+that needs to be processed by such an invalid "process" filter,
+it would wait for a proper protocol handshake and appear "hanging".
+
+
 Interaction between checkin/checkout attributes
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/convert.c b/convert.c
index 522e2c5..130430a 100644
--- a/convert.c
+++ b/convert.c
@@ -3,6 +3,7 @@
 #include "run-command.h"
 #include "quote.h"
 #include "sigchain.h"
+#include "pkt-line.h"
 
 /*
  * convert.c - convert a file when checking it out and checking it in.
@@ -427,7 +428,7 @@ static int filter_buffer_or_fd(int in, int out, void *data)
 	return (write_err || status);
 }
 
-static int apply_filter(const char *path, const char *src, size_t len, int fd,
+static int apply_single_file_filter(const char *path, const char *src, size_t len, int fd,
                         struct strbuf *dst, const char *cmd)
 {
 	/*
@@ -441,12 +442,6 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
 	struct async async;
 	struct filter_params params;
 
-	if (!cmd || !*cmd)
-		return 0;
-
-	if (!dst)
-		return 1;
-
 	memset(&async, 0, sizeof(async));
 	async.proc = filter_buffer_or_fd;
 	async.data = &params;
@@ -481,14 +476,245 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
 	return ret;
 }
 
+#define FILTER_CAPABILITIES_CLEAN    (1u<<0)
+#define FILTER_CAPABILITIES_SMUDGE   (1u<<1)
+#define FILTER_SUPPORTS_CLEAN(type)  ((type) & FILTER_CAPABILITIES_CLEAN)
+#define FILTER_SUPPORTS_SMUDGE(type) ((type) & FILTER_CAPABILITIES_SMUDGE)
+
+struct cmd2process {
+	struct hashmap_entry ent; /* must be the first member! */
+	int supported_capabilities;
+	const char *cmd;
+	struct child_process process;
+};
+
+static int cmd_process_map_initialized = 0;
+static struct hashmap cmd_process_map;
+
+static int cmd2process_cmp(const struct cmd2process *e1,
+                           const struct cmd2process *e2,
+                           const void *unused)
+{
+	return strcmp(e1->cmd, e2->cmd);
+}
+
+static struct cmd2process *find_multi_file_filter_entry(struct hashmap *hashmap, const char *cmd)
+{
+	struct cmd2process key;
+	hashmap_entry_init(&key, strhash(cmd));
+	key.cmd = cmd;
+	return hashmap_get(hashmap, &key, NULL);
+}
+
+static void kill_multi_file_filter(struct hashmap *hashmap, struct cmd2process *entry)
+{
+	if (!entry)
+		return;
+	sigchain_push(SIGPIPE, SIG_IGN);
+	close(entry->process.in);
+	close(entry->process.out);
+	sigchain_pop(SIGPIPE);
+	finish_command(&entry->process);
+	child_process_clear(&entry->process);
+	hashmap_remove(hashmap, entry, NULL);
+	free(entry);
+}
+
+static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, const char *cmd)
+{
+	int did_fail;
+	struct cmd2process *entry;
+	struct child_process *process;
+	const char *argv[] = { cmd, NULL };
+	static const char cap_key[] = "capabilities=";
+	int cap_key_len = strlen(cap_key);
+	struct string_list cap_list = STRING_LIST_INIT_NODUP;
+	char *cap_buf;
+	int i;
+
+	entry = xmalloc(sizeof(*entry));
+	hashmap_entry_init(entry, strhash(cmd));
+	entry->cmd = cmd;
+	entry->supported_capabilities = 0;
+	process = &entry->process;
+
+	child_process_init(process);
+	process->argv = argv;
+	process->use_shell = 1;
+	process->in = -1;
+	process->out = -1;
+
+	if (start_command(process)) {
+		error("cannot fork to run external filter '%s'", cmd);
+		kill_multi_file_filter(hashmap, entry);
+		return NULL;
+	}
+
+	did_fail = strcmp(packet_read_line(process->out, NULL), "git-filter-protocol");
+	if (did_fail)
+		goto done;
+
+	did_fail = strcmp(packet_read_line(process->out, NULL), "version=2");
+	if (did_fail)
+		goto done;
+
+	cap_buf = packet_read_line(process->out, NULL);
+	if (!cap_buf ||
+		strlen(cap_buf) <= cap_key_len ||
+		strncmp(cap_buf, cap_key, cap_key_len)) {
+		error("filter capabilities not found");
+		did_fail = 1;
+		goto done;
+	}
+
+	string_list_split_in_place(&cap_list, &cap_buf[cap_key_len], ' ', -1);
+	if (cap_list.nr > 0) {
+		for (i = 0; i < cap_list.nr; i++) {
+			const char *requested = cap_list.items[i].string;
+			if (!strcmp(requested, "clean")) {
+				entry->supported_capabilities |= FILTER_CAPABILITIES_CLEAN;
+			} else if (!strcmp(requested, "smudge")) {
+				entry->supported_capabilities |= FILTER_CAPABILITIES_SMUDGE;
+			} else {
+				warning(
+					"external filter '%s' requested unsupported filter capability '%s'",
+					cmd, requested
+				);
+			}
+		}
+	}
+	string_list_clear(&cap_list, 0);
+
+done:
+	if (did_fail) {
+		error("initialization for external filter '%s' failed", cmd);
+		kill_multi_file_filter(hashmap, entry);
+		return NULL;
+	}
+
+	hashmap_add(hashmap, entry);
+	return entry;
+}
+
+static int apply_multi_file_filter(const char *path, const char *src, size_t len,
+                                   int fd, struct strbuf *dst, const char *cmd,
+                                   const int wanted_capability)
+{
+	int ret = 1;
+	struct cmd2process *entry;
+	struct child_process *process;
+	struct stat file_stat;
+	struct strbuf nbuf = STRBUF_INIT;
+	char *filter_type;
+	char *filter_result = NULL;
+
+	if (!cmd_process_map_initialized) {
+		cmd_process_map_initialized = 1;
+		hashmap_init(&cmd_process_map, (hashmap_cmp_fn) cmd2process_cmp, 0);
+		entry = NULL;
+	} else {
+		entry = find_multi_file_filter_entry(&cmd_process_map, cmd);
+	}
+
+	fflush(NULL);
+
+	if (!entry) {
+		entry = start_multi_file_filter(&cmd_process_map, cmd);
+		if (!entry)
+			return 0;
+	}
+	process = &entry->process;
+
+	if (!(wanted_capability & entry->supported_capabilities))
+		return 1;  // it is OK if the wanted capability is not supported
+
+	if (FILTER_SUPPORTS_CLEAN(wanted_capability))
+		filter_type = "clean";
+	else if (FILTER_SUPPORTS_SMUDGE(wanted_capability))
+		filter_type = "smudge";
+	else
+		die("unexpected filter type");
+
+	if (fd >= 0 && !src) {
+		if (fstat(fd, &file_stat) == -1)
+			return 0;
+		len = file_stat.st_size;
+	}
+
+	packet_buf_write(&nbuf, "command=%s\n", filter_type);
+	ret = !direct_packet_write(process->in, nbuf.buf, nbuf.len, 1);
+	if (!ret)
+		goto done;
+
+	strbuf_reset(&nbuf);
+	packet_buf_write(&nbuf, "pathname=%s\n", path);
+	ret = !direct_packet_write(process->in, nbuf.buf, nbuf.len, 1);
+	if (!ret)
+		goto done;
+
+	if (fd >= 0)
+		ret = !packet_write_stream_with_flush_from_fd(fd, process->in);
+	else
+		ret = !packet_write_stream_with_flush_from_buf(src, len, process->in);
+	if (!ret)
+		goto done;
+
+	strbuf_reset(&nbuf);
+	ret = packet_read_till_flush(process->out, &nbuf) >= 0;
+	if (!ret)
+		goto done;
+
+	filter_result = packet_read_line(process->out, NULL);
+	ret = !strcmp(filter_result, "result=success");
+
+done:
+	if (ret) {
+		strbuf_swap(dst, &nbuf);
+	} else {
+		if (!filter_result || strcmp(filter_result, "result=reject")) {
+			// Something went wrong with the protocol filter. Force shutdown!
+			error("external filter '%s' failed", cmd);
+			kill_multi_file_filter(&cmd_process_map, entry);
+		}
+	}
+	strbuf_release(&nbuf);
+	return ret;
+}
+
 static struct convert_driver {
 	const char *name;
 	struct convert_driver *next;
 	const char *smudge;
 	const char *clean;
+	const char *process;
 	int required;
 } *user_convert, **user_convert_tail;
 
+static int apply_filter(const char *path, const char *src, size_t len,
+                        int fd, struct strbuf *dst, struct convert_driver *drv,
+                        const int wanted_capability)
+{
+	const char* cmd = NULL;
+
+	if (!drv)
+		return 0;
+
+	if (!dst)
+		return 1;
+
+	if (FILTER_SUPPORTS_CLEAN(wanted_capability) && drv->clean)
+		cmd = drv->clean;
+	else if (FILTER_SUPPORTS_SMUDGE(wanted_capability) && drv->smudge)
+		cmd = drv->smudge;
+
+	if (cmd && *cmd)
+		return apply_single_file_filter(path, src, len, fd, dst, cmd);
+	else if (drv->process && *drv->process)
+		return apply_multi_file_filter(path, src, len, fd, dst, drv->process, wanted_capability);
+
+	return 0;
+}
+
 static int read_convert_config(const char *var, const char *value, void *cb)
 {
 	const char *key, *name;
@@ -526,6 +752,10 @@ static int read_convert_config(const char *var, const char *value, void *cb)
 	if (!strcmp("clean", key))
 		return git_config_string(&drv->clean, var, value);
 
+	if (!strcmp("process", key)) {
+		return git_config_string(&drv->process, var, value);
+	}
+
 	if (!strcmp("required", key)) {
 		drv->required = git_config_bool(var, value);
 		return 0;
@@ -823,7 +1053,7 @@ int would_convert_to_git_filter_fd(const char *path)
 	if (!ca.drv->required)
 		return 0;
 
-	return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);
+	return apply_filter(path, NULL, 0, -1, NULL, ca.drv, FILTER_CAPABILITIES_CLEAN);
 }
 
 const char *get_convert_attr_ascii(const char *path)
@@ -856,18 +1086,12 @@ int convert_to_git(const char *path, const char *src, size_t len,
                    struct strbuf *dst, enum safe_crlf checksafe)
 {
 	int ret = 0;
-	const char *filter = NULL;
-	int required = 0;
 	struct conv_attrs ca;
 
 	convert_attrs(&ca, path);
-	if (ca.drv) {
-		filter = ca.drv->clean;
-		required = ca.drv->required;
-	}
 
-	ret |= apply_filter(path, src, len, -1, dst, filter);
-	if (!ret && required)
+	ret |= apply_filter(path, src, len, -1, dst, ca.drv, FILTER_CAPABILITIES_CLEAN);
+	if (!ret && ca.drv && ca.drv->required)
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
 	if (ret && dst) {
@@ -889,9 +1113,9 @@ void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
 	convert_attrs(&ca, path);
 
 	assert(ca.drv);
-	assert(ca.drv->clean);
+	assert(ca.drv->clean || ca.drv->process);
 
-	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv->clean))
+	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, FILTER_CAPABILITIES_CLEAN))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
 	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
@@ -903,15 +1127,9 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 					    int normalizing)
 {
 	int ret = 0, ret_filter = 0;
-	const char *filter = NULL;
-	int required = 0;
 	struct conv_attrs ca;
 
 	convert_attrs(&ca, path);
-	if (ca.drv) {
-		filter = ca.drv->smudge;
-		required = ca.drv->required;
-	}
 
 	ret |= ident_to_worktree(path, src, len, dst, ca.ident);
 	if (ret) {
@@ -920,9 +1138,10 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 	}
 	/*
 	 * CRLF conversion can be skipped if normalizing, unless there
-	 * is a smudge filter.  The filter might expect CRLFs.
+	 * is a smudge or process filter (even if the process filter doesn't
+	 * support smudge).  The filters might expect CRLFs.
 	 */
-	if (filter || !normalizing) {
+	if ((ca.drv && (ca.drv->smudge || ca.drv->process)) || !normalizing) {
 		ret |= crlf_to_worktree(path, src, len, dst, ca.crlf_action);
 		if (ret) {
 			src = dst->buf;
@@ -930,8 +1149,8 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 		}
 	}
 
-	ret_filter = apply_filter(path, src, len, -1, dst, filter);
-	if (!ret_filter && required)
+	ret_filter = apply_filter(path, src, len, -1, dst, ca.drv, FILTER_CAPABILITIES_SMUDGE);
+	if (!ret_filter && ca.drv && ca.drv->required)
 		die("%s: smudge filter %s failed", path, ca.drv->name);
 
 	return ret | ret_filter;
@@ -1383,7 +1602,7 @@ struct stream_filter *get_stream_filter(const char *path, const unsigned char *s
 	struct stream_filter *filter = NULL;
 
 	convert_attrs(&ca, path);
-	if (ca.drv && (ca.drv->smudge || ca.drv->clean))
+	if (ca.drv && (ca.drv->process || ca.drv->smudge || ca.drv->clean))
 		return NULL;
 
 	if (ca.crlf_action == CRLF_AUTO || ca.crlf_action == CRLF_AUTO_CRLF)
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 34c8eb9..c1a22f4 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -42,6 +42,9 @@ test_expect_success setup '
 	rm -f test test.t test.i &&
 	git checkout -- test test.t test.i &&
 
+	echo "content-test2" >test2.o &&
+	echo "content-test3-subdir" >test3-subdir.o &&
+
 	mkdir generated-test-data &&
 	for i in $(test_seq 1 $T0021_LARGE_FILE_SIZE)
 	do
@@ -296,4 +299,323 @@ test_expect_success 'disable filter with empty override' '
 	test_must_be_empty err
 '
 
+check_filter () {
+	rm -f rot13-filter.log actual.log &&
+	"$@" 2> git_stderr.log &&
+	test_must_be_empty git_stderr.log &&
+	cat >expected.log &&
+	sort rot13-filter.log | uniq -c | sed "s/^[ ]*//" >actual.log &&
+	test_cmp expected.log actual.log
+}
+
+check_filter_count_clean () {
+	rm -f rot13-filter.log actual.log &&
+	"$@" 2> git_stderr.log &&
+	test_must_be_empty git_stderr.log &&
+	cat >expected.log &&
+	sort rot13-filter.log | uniq -c | sed "s/^[ ]*//" |
+		sed "s/^\([0-9]\) IN: clean/x IN: clean/" >actual.log &&
+	test_cmp expected.log actual.log
+}
+
+check_filter_ignore_clean () {
+	rm -f rot13-filter.log actual.log &&
+	"$@" &&
+	cat >expected.log &&
+	grep -v "IN: clean" rot13-filter.log >actual.log &&
+	test_cmp expected.log actual.log
+}
+
+check_filter_no_call () {
+	rm -f rot13-filter.log &&
+	"$@" 2> git_stderr.log &&
+	test_must_be_empty git_stderr.log &&
+	test_must_be_empty rot13-filter.log
+}
+
+check_rot13 () {
+	test_cmp $1 $2 &&
+	./../rot13.sh <$1 >expected &&
+	git cat-file blob :$2 >actual &&
+	test_cmp expected actual
+}
+
+test_expect_success PERL 'required process filter should filter data' '
+	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
+	test_config_global filter.protocol.required true &&
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+
+		echo "*.r filter=protocol" >.gitattributes &&
+		git add . &&
+		git commit . -m "test commit" &&
+		git branch empty &&
+
+		cat ../test.o >test.r &&
+		cat ../test2.o >test2.r &&
+		mkdir testsubdir &&
+		cat ../test3-subdir.o >testsubdir/test3-subdir.r &&
+		>test4-empty.r &&
+
+		check_filter \
+			git add . \
+				<<-\EOF &&
+					1 IN: clean test.r 57 [OK] -- OUT: 57 [OK]
+					1 IN: clean test2.r 14 [OK] -- OUT: 14 [OK]
+					1 IN: clean test4-empty.r 0 [OK] -- OUT: 0 [OK]
+					1 IN: clean testsubdir/test3-subdir.r 21 [OK] -- OUT: 21 [OK]
+					1 start
+					1 wrote filter header
+				EOF
+
+		check_filter_count_clean \
+			git commit . -m "test commit" \
+				<<-\EOF &&
+					x IN: clean test.r 57 [OK] -- OUT: 57 [OK]
+					x IN: clean test2.r 14 [OK] -- OUT: 14 [OK]
+					x IN: clean test4-empty.r 0 [OK] -- OUT: 0 [OK]
+					x IN: clean testsubdir/test3-subdir.r 21 [OK] -- OUT: 21 [OK]
+					1 start
+					1 wrote filter header
+				EOF
+
+		rm -f test?.r testsubdir/test3-subdir.r &&
+
+		check_filter_ignore_clean \
+			git checkout . \
+				<<-\EOF &&
+					start
+					wrote filter header
+					IN: smudge test2.r 14 [OK] -- OUT: 14 [OK]
+					IN: smudge testsubdir/test3-subdir.r 21 [OK] -- OUT: 21 [OK]
+				EOF
+
+		check_filter_ignore_clean \
+			git checkout empty \
+				<<-\EOF &&
+					start
+					wrote filter header
+				EOF
+
+		check_filter_ignore_clean \
+			git checkout master \
+				<<-\EOF &&
+					start
+					wrote filter header
+					IN: smudge test.r 57 [OK] -- OUT: 57 [OK]
+					IN: smudge test2.r 14 [OK] -- OUT: 14 [OK]
+					IN: smudge test4-empty.r 0 [OK] -- OUT: 0 [OK]
+					IN: smudge testsubdir/test3-subdir.r 21 [OK] -- OUT: 21 [OK]
+				EOF
+
+		check_rot13 ../test.o test.r &&
+		check_rot13 ../test2.o test2.r &&
+		check_rot13 ../test3-subdir.o testsubdir/test3-subdir.r
+	)
+'
+
+test_expect_success PERL 'required process filter should filter smudge data and one-shot filter should clean' '
+	test_config_global filter.protocol.clean ./../rot13.sh &&
+	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl smudge" &&
+	test_config_global filter.protocol.required true &&
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+
+		echo "*.r filter=protocol" >.gitattributes &&
+		git add . &&
+		git commit . -m "test commit" &&
+		git branch empty &&
+
+		cat ../test.o >test.r &&
+		cat ../test2.o >test2.r &&
+
+		check_filter_no_call \
+			git add . &&
+
+		check_filter_no_call \
+			git commit . -m "test commit" &&
+
+		rm -f test?.r testsubdir/test3-subdir.r &&
+
+		check_filter_ignore_clean \
+			git checkout . \
+				<<-\EOF &&
+					start
+					wrote filter header
+					IN: smudge test2.r 14 [OK] -- OUT: 14 [OK]
+				EOF
+
+		git checkout empty &&
+
+		check_filter_ignore_clean \
+			git checkout master\
+				<<-\EOF &&
+					start
+					wrote filter header
+					IN: smudge test.r 57 [OK] -- OUT: 57 [OK]
+					IN: smudge test2.r 14 [OK] -- OUT: 14 [OK]
+				EOF
+
+		check_rot13 ../test.o test.r &&
+		check_rot13 ../test2.o test2.r
+	)
+'
+
+test_expect_success PERL 'required process filter should clean only' '
+	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean" &&
+	test_config_global filter.protocol.required true &&
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+
+		echo "*.r filter=protocol" >.gitattributes &&
+		git add . &&
+		git commit . -m "test commit" &&
+		git branch empty &&
+
+		cat ../test.o >test.r &&
+
+		check_filter \
+			git add . \
+				<<-\EOF &&
+					1 IN: clean test.r 57 [OK] -- OUT: 57 [OK]
+					1 start
+					1 wrote filter header
+				EOF
+
+		check_filter_count_clean \
+			git commit . -m "test commit" \
+				<<-\EOF
+					x IN: clean test.r 57 [OK] -- OUT: 57 [OK]
+					1 start
+					1 wrote filter header
+				EOF
+	)
+'
+
+test_expect_success PERL 'required process filter should process files larger LARGE_PACKET_MAX' '
+	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
+	test_config_global filter.protocol.required true &&
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+
+		echo "*.file filter=protocol" >.gitattributes &&
+		cat ../generated-test-data/largish.file.rot13 >large.rot13 &&
+		cat ../generated-test-data/largish.file >large.file &&
+		cat large.file >large.original &&
+
+		git add large.file .gitattributes &&
+		git commit . -m "test commit" &&
+
+		rm -f large.file &&
+		git checkout -- large.file &&
+		git cat-file blob :large.file >actual &&
+		test_cmp large.rot13 actual
+	)
+'
+
+test_expect_success PERL 'required process filter should with clean error should fail' '
+	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
+	test_config_global filter.protocol.required true &&
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+
+		echo "*.r filter=protocol" >.gitattributes &&
+
+		cat ../test.o >test.r &&
+		echo "this is going to fail" >clean-write-fail.r &&
+		echo "content-test3-subdir" >test3.r &&
+
+		# Note: There are three clean paths in convert.c we just test one here.
+		test_must_fail git add .
+	)
+'
+
+test_expect_success PERL 'process filter should restart after unexpected write failure' '
+	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+
+		echo "*.r filter=protocol" >.gitattributes &&
+
+		cat ../test.o >test.r &&
+		cat ../test2.o >test2.r &&
+		echo "this is going to fail" >smudge-write-fail.o &&
+		cat smudge-write-fail.o >smudge-write-fail.r &&
+		git add . &&
+		git commit . -m "test commit" &&
+		rm -f *.r &&
+
+		check_filter_ignore_clean \
+			git checkout . \
+				<<-\EOF &&
+					start
+					wrote filter header
+					IN: smudge smudge-write-fail.r 22 [OK] -- OUT: 22 [WRITE FAIL]
+					start
+					wrote filter header
+					IN: smudge test.r 57 [OK] -- OUT: 57 [OK]
+					IN: smudge test2.r 14 [OK] -- OUT: 14 [OK]
+				EOF
+
+		check_rot13 ../test.o test.r &&
+		check_rot13 ../test2.o test2.r &&
+
+		! test_cmp smudge-write-fail.o smudge-write-fail.r && # Smudge failed!
+		./../rot13.sh <smudge-write-fail.o >expected &&
+		git cat-file blob :smudge-write-fail.r >actual &&
+		test_cmp expected actual							  # Clean worked!
+	)
+'
+
+test_expect_success PERL 'process filter should not restart after intentionally rejected file' '
+	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+
+		echo "*.r filter=protocol" >.gitattributes &&
+
+		cat ../test.o >test.r &&
+		cat ../test2.o >test2.r &&
+		echo "this is going to be rejected" >reject.o &&
+		cat reject.o >reject.r &&
+		git add . &&
+		git commit . -m "test commit" &&
+		rm -f *.r &&
+
+		check_filter_ignore_clean \
+			git checkout . \
+				<<-\EOF &&
+					start
+					wrote filter header
+					IN: smudge reject.r 29 [OK] -- OUT: 0 [REJECT]
+					IN: smudge test.r 57 [OK] -- OUT: 57 [OK]
+					IN: smudge test2.r 14 [OK] -- OUT: 14 [OK]
+				EOF
+
+		check_rot13 ../test.o test.r &&
+		check_rot13 ../test2.o test2.r
+	)
+'
+
 test_done
diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
new file mode 100755
index 0000000..ca6d5e4
--- /dev/null
+++ b/t/t0021/rot13-filter.pl
@@ -0,0 +1,148 @@
+#!/usr/bin/perl
+#
+# Example implementation for the Git filter protocol version 2
+# See Documentation/gitattributes.txt, section "Filter Protocol"
+#
+# The script takes the list of supported protocol capabilities as
+# arguments ("clean", "smudge", etc).
+#
+# This implementation supports three special test cases:
+# (1) If data with the pathname "clean-write-fail.r" is processed with
+#     a "clean" operation then the write operation will die.
+# (2) If data with the pathname "smudge-write-fail.r" is processed with
+#     a "smudge" operation then the write operation will die.
+# (3) If data with the pathname "reject.r" is processed with any
+#     operation then the filter signals that it does not want to process
+#     the file.
+#
+
+use strict;
+use warnings;
+
+my $MAX_PACKET_CONTENT_SIZE = 65516;
+my @capabilities            = @ARGV;
+
+sub rot13 {
+    my ($str) = @_;
+    $str =~ y/A-Za-z/N-ZA-Mn-za-m/;
+    return $str;
+}
+
+sub packet_read {
+    my $buffer;
+    my $bytes_read = read STDIN, $buffer, 4;
+    if ( $bytes_read == 0 ) {
+        return;
+    }
+    elsif ( $bytes_read != 4 ) {
+        die "invalid packet size '$bytes_read' field";
+    }
+    my $pkt_size = hex($buffer);
+    if ( $pkt_size == 0 ) {
+        return ( 1, "" );
+    }
+    elsif ( $pkt_size > 4 ) {
+        my $content_size = $pkt_size - 4;
+        $bytes_read = read STDIN, $buffer, $content_size;
+        if ( $bytes_read != $content_size ) {
+            die "invalid packet ($content_size expected; $bytes_read read)";
+        }
+        return ( 0, $buffer );
+    }
+    else {
+        die "invalid packet size";
+    }
+}
+
+sub packet_write {
+    my ($packet) = @_;
+    print STDOUT sprintf( "%04x", length($packet) + 4 );
+    print STDOUT $packet;
+    STDOUT->flush();
+}
+
+sub packet_flush {
+    print STDOUT sprintf( "%04x", 0 );
+    STDOUT->flush();
+}
+
+open my $debug, ">>", "rot13-filter.log";
+print $debug "start\n";
+$debug->flush();
+
+packet_write("git-filter-protocol\n");
+packet_write("version=2\n");
+packet_write( "capabilities=" . join( ' ', @capabilities ) . "\n" );
+print $debug "wrote filter header\n";
+$debug->flush();
+
+while (1) {
+    my ($command) = packet_read() =~ /^command=([^=]+)\n$/;
+    unless ( defined($command) ) {
+        exit();
+    }
+    print $debug "IN: $command";
+    $debug->flush();
+
+    my ($pathname) = packet_read() =~ /^pathname=([^=]+)\n$/;
+    print $debug " $pathname";
+    $debug->flush();
+
+    my $input = "";
+    {
+        binmode(STDIN);
+        my $buffer;
+        my $done = 0;
+        while ( !$done ) {
+            ( $done, $buffer ) = packet_read();
+            $input .= $buffer;
+        }
+        print $debug " " . length($input) . " [OK] -- ";
+        $debug->flush();
+    }
+
+    my $output;
+    if ( $pathname eq "reject.r" ) {
+        $output = "";
+    }
+    elsif ( $command eq "clean" and grep( /^clean$/, @capabilities ) ) {
+        $output = rot13($input);
+    }
+    elsif ( $command eq "smudge" and grep( /^smudge$/, @capabilities ) ) {
+        $output = rot13($input);
+    }
+    else {
+        die "bad command $command";
+    }
+
+    print $debug "OUT: " . length($output) . " ";
+    $debug->flush();
+
+    if ( $pathname eq "${command}-write-fail.r" ) {
+        print $debug "[WRITE FAIL]\n";
+        $debug->flush();
+        die "write error";
+    }
+    elsif ( $pathname eq "reject.r" ) {
+        packet_flush();
+        print $debug "[REJECT]\n";
+        $debug->flush();
+        packet_write("result=reject\n");
+    }
+    else {
+        while ( length($output) > 0 ) {
+            my $packet = substr( $output, 0, $MAX_PACKET_CONTENT_SIZE );
+            packet_write($packet);
+            if ( length($output) > $MAX_PACKET_CONTENT_SIZE ) {
+                $output = substr( $output, $MAX_PACKET_CONTENT_SIZE );
+            }
+            else {
+                $output = "";
+            }
+        }
+        packet_flush();
+        print $debug "[OK]\n";
+        $debug->flush();
+        packet_write("result=success\n");
+    }
+}
-- 
2.9.0

