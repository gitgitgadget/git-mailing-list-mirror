Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA8A32098B
	for <e@80x24.org>; Sun, 16 Oct 2016 23:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757212AbcJPXVv (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 19:21:51 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33196 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756775AbcJPXVu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 19:21:50 -0400
Received: by mail-pf0-f195.google.com with SMTP id i85so8094349pfa.0
        for <git@vger.kernel.org>; Sun, 16 Oct 2016 16:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eFHBJcenlPTaqVru9ZNSXUD2PoAvMXuGCPz7EcgwApc=;
        b=cssl3Bz/1Ddn1UbrCoMzhY0VUcYNeao7X1WPuDxusn6UWHnSXlQD/l+d3Fq1x74+ti
         8urNmBGFat5RMbglmsLTy0+SQrCoTH7vSC+74lpJHAqliDxrzWzPhNd0QP5dSYBrDYdE
         pao66X3eYH2KVDU8IlupXgz+7eSpj/5ODOT37kdyO6GIwq+yA4cwU+RxbK3Tkvga1isz
         zEhe21rGzVoUuwdWdsnSBG+YZm9pyyf57Op28ihH87jeMQqMiDwWjGRmIBMpFAjsapDn
         i4GAxlTFSF1N97VaEQTGyv81bhQv+7pyzkuyAsHY9q3E7z+poiMdbMN+XmlLLYGFOWlD
         S/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eFHBJcenlPTaqVru9ZNSXUD2PoAvMXuGCPz7EcgwApc=;
        b=Py1hBS+oG5+rm7e1OGr5GPKWya7c8cbLlTHOQ6NfBjqFHz43b1h9aLo1AzQ2RXnBA7
         lgaA5VzEE5XCtliRkKIKzmeYid/9b2aHXxZJglzMUhXy2SpQmUYnzyeJytMeUNOFNep2
         4j8To38jJHoTfHl1BO/X0eK/QMOZQQ9j3iTJECoyGuLST0FPuO+u9aFWmuyEbqfPYFxO
         SZQukaH0JMfhiRmT5mOlIPjQUUcScH1ph3HmYg5pS0xC3oUZCq0lczXxB3+qqcdW+dWw
         w9PyaMsrUQtVtqvD6cCgSg1hv5pGlcIhmavpNrA7CwZl2l4RgVA3hFTgRjOv30wj+996
         2FAA==
X-Gm-Message-State: AA6/9Rl8eKkIShKCcXdO7G8zuUeqZhjQse9YEAFcyS4FT+/YI2Efgdt1NmN4vojwSiwnSQ==
X-Received: by 10.98.194.68 with SMTP id l65mr33876717pfg.159.1476660109379;
        Sun, 16 Oct 2016 16:21:49 -0700 (PDT)
Received: from rem3n8pj12.ads.autodesk.com (adsk-nat-ip4.autodesk.com. [132.188.71.4])
        by smtp.gmail.com with ESMTPSA id cp2sm10325691pad.3.2016.10.16.16.21.39
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 16 Oct 2016 16:21:43 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jnareb@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, tboegi@web.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v11 13/14] convert: add filter.<driver>.process option
Date:   Sun, 16 Oct 2016 16:20:37 -0700
Message-Id: <20161016232038.84951-14-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161016232038.84951-1-larsxschneider@gmail.com>
References: <20161016232038.84951-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Git's clean/smudge mechanism invokes an external filter process for
every single blob that is affected by a filter. If Git filters a lot of
blobs then the startup time of the external filter processes can become
a significant part of the overall Git execution time.

In a preliminary performance test this developer used a clean/smudge
filter written in golang to filter 12,000 files. This process took 364s
with the existing filter mechanism and 5s with the new mechanism. See
details here: https://github.com/github/git-lfs/pull/1382

This patch adds the `filter.<driver>.process` string option which, if
used, keeps the external filter process running and processes all blobs
with the packet format (pkt-line) based protocol over standard input and
standard output. The full protocol is explained in detail in
`Documentation/gitattributes.txt`.

A few key decisions:

* The long running filter process is referred to as filter protocol
  version 2 because the existing single shot filter invocation is
  considered version 1.
* Git sends a welcome message and expects a response right after the
  external filter process has started. This ensures that Git will not
  hang if a version 1 filter is incorrectly used with the
  filter.<driver>.process option for version 2 filters. In addition,
  Git can detect this kind of error and warn the user.
* The status of a filter operation (e.g. "success" or "error) is set
  before the actual response and (if necessary!) re-set after the
  response. The advantage of this two step status response is that if
  the filter detects an error early, then the filter can communicate
  this and Git does not even need to create structures to read the
  response.
* All status responses are pkt-line lists terminated with a flush
  packet. This allows us to send other status fields with the same
  protocol in the future.

Helped-by: Martin-Louis Bright <mlbright@gmail.com>
Reviewed-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitattributes.txt | 155 +++++++++++++-
 convert.c                       | 300 ++++++++++++++++++++++++++-
 t/t0021-conversion.sh           | 444 +++++++++++++++++++++++++++++++++++++++-
 t/t0021/rot13-filter.pl         | 192 +++++++++++++++++
 4 files changed, 1081 insertions(+), 10 deletions(-)
 create mode 100755 t/t0021/rot13-filter.pl

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 7aff940..3f4d1ed 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -293,7 +293,15 @@ checkout, when the `smudge` command is specified, the command is
 fed the blob object from its standard input, and its standard
 output is used to update the worktree file.  Similarly, the
 `clean` command is used to convert the contents of worktree file
-upon checkin.
+upon checkin. By default these commands process only a single
+blob and terminate. If a long running `process` filter is used
+in place of `clean` and/or `smudge` filters, then Git can process
+all blobs with a single filter command invocation for the entire
+life of a single Git command, for example `git add --all`. If a
+long running `process` filter is configured then it always takes
+precedence over a configured single blob filter. See section
+below for the description of the protocol used to communicate with
+a `process` filter.
 
 One use of the content filtering is to massage the content into a shape
 that is more convenient for the platform, filesystem, and the user to use.
@@ -373,6 +381,151 @@ not exist, or may have different contents. So, smudge and clean commands
 should not try to access the file on disk, but only act as filters on the
 content provided to them on standard input.
 
+Long Running Filter Process
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+If the filter command (a string value) is defined via
+`filter.<driver>.process` then Git can process all blobs with a
+single filter invocation for the entire life of a single Git
+command. This is achieved by using a packet format (pkt-line,
+see technical/protocol-common.txt) based protocol over standard
+input and standard output as follows. All packets, except for the
+"*CONTENT" packets and the "0000" flush packet, are considered
+text and therefore are terminated by a LF.
+
+Git starts the filter when it encounters the first file
+that needs to be cleaned or smudged. After the filter started
+Git sends a welcome message ("git-filter-client"), a list of supported
+protocol version numbers, and a flush packet. Git expects to read a welcome
+response message ("git-filter-server"), exactly one protocol version number
+from the previously sent list, and a flush packet. All further
+communication will be based on the selected version. The remaining
+protocol description below documents "version=2". Please note that
+"version=42" in the example below does not exist and is only there
+to illustrate how the protocol would look like with more than one
+version.
+
+After the version negotiation Git sends a list of all capabilities that
+it supports and a flush packet. Git expects to read a list of desired
+capabilities, which must be a subset of the supported capabilities list,
+and a flush packet as response:
+------------------------
+packet:          git> git-filter-client
+packet:          git> version=2
+packet:          git> version=42
+packet:          git> 0000
+packet:          git< git-filter-server
+packet:          git< version=2
+packet:          git< 0000
+packet:          git> capability=clean
+packet:          git> capability=smudge
+packet:          git> capability=not-yet-invented
+packet:          git> 0000
+packet:          git< capability=clean
+packet:          git< capability=smudge
+packet:          git< 0000
+------------------------
+Supported filter capabilities in version 2 are "clean" and
+"smudge".
+
+Afterwards Git sends a list of "key=value" pairs terminated with
+a flush packet. The list will contain at least the filter command
+(based on the supported capabilities) and the pathname of the file
+to filter relative to the repository root. Right after the flush packet
+Git sends the content split in zero or more pkt-line packets and a
+flush packet to terminate content. Please note, that the filter
+must not send any response before it received the content and the
+final flush packet.
+------------------------
+packet:          git> command=smudge
+packet:          git> pathname=path/testfile.dat
+packet:          git> 0000
+packet:          git> CONTENT
+packet:          git> 0000
+------------------------
+
+The filter is expected to respond with a list of "key=value" pairs
+terminated with a flush packet. If the filter does not experience
+problems then the list must contain a "success" status. Right after
+these packets the filter is expected to send the content in zero
+or more pkt-line packets and a flush packet at the end. Finally, a
+second list of "key=value" pairs terminated with a flush packet
+is expected. The filter can change the status in the second list
+or keep the status as is with an empty list. Please note that the
+empty list must be terminated with a flush packet regardless.
+
+------------------------
+packet:          git< status=success
+packet:          git< 0000
+packet:          git< SMUDGED_CONTENT
+packet:          git< 0000
+packet:          git< 0000  # empty list, keep "status=success" unchanged!
+------------------------
+
+If the result content is empty then the filter is expected to respond
+with a "success" status and a flush packet to signal the empty content.
+------------------------
+packet:          git< status=success
+packet:          git< 0000
+packet:          git< 0000  # empty content!
+packet:          git< 0000  # empty list, keep "status=success" unchanged!
+------------------------
+
+In case the filter cannot or does not want to process the content,
+it is expected to respond with an "error" status.
+------------------------
+packet:          git< status=error
+packet:          git< 0000
+------------------------
+
+If the filter experiences an error during processing, then it can
+send the status "error" after the content was (partially or
+completely) sent.
+------------------------
+packet:          git< status=success
+packet:          git< 0000
+packet:          git< HALF_WRITTEN_ERRONEOUS_CONTENT
+packet:          git< 0000
+packet:          git< status=error
+packet:          git< 0000
+------------------------
+
+In case the filter cannot or does not want to process the content
+as well as any future content for the lifetime of the Git process,
+then it is expected to respond with an "abort" status at any point
+in the protocol.
+------------------------
+packet:          git< status=abort
+packet:          git< 0000
+------------------------
+
+Git neither stops nor restarts the filter process in case the
+"error"/"abort" status is set. However, Git sets its exit code
+according to the `filter.<driver>.required` flag, mimicking the
+behavior of the `filter.<driver>.clean` / `filter.<driver>.smudge`
+mechanism.
+
+If the filter dies during the communication or does not adhere to
+the protocol then Git will stop the filter process and restart it
+with the next file that needs to be processed. Depending on the
+`filter.<driver>.required` flag Git will interpret that as error.
+
+After the filter has processed a blob it is expected to wait for
+the next "key=value" list containing a command. Git will close
+the command pipe on exit. The filter is expected to detect EOF
+and exit gracefully on its own. Git will wait until the filter
+process has stopped.
+
+If you develop your own long running filter
+process then the `GIT_TRACE_PACKET` environment variables can be
+very helpful for debugging (see linkgit:git[1]).
+
+Please note that you cannot use an existing `filter.<driver>.clean`
+or `filter.<driver>.smudge` command with `filter.<driver>.process`
+because the former two use a different inter process communication
+protocol than the latter one.
+
+
 Interaction between checkin/checkout attributes
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/convert.c b/convert.c
index 71e11ff..9d2aa68 100644
--- a/convert.c
+++ b/convert.c
@@ -3,6 +3,7 @@
 #include "run-command.h"
 #include "quote.h"
 #include "sigchain.h"
+#include "pkt-line.h"
 
 /*
  * convert.c - convert a file when checking it out and checking it in.
@@ -490,11 +491,292 @@ static int apply_single_file_filter(const char *path, const char *src, size_t le
 #define CAP_CLEAN    (1u<<0)
 #define CAP_SMUDGE   (1u<<1)
 
+struct cmd2process {
+	struct hashmap_entry ent; /* must be the first member! */
+	unsigned int supported_capabilities;
+	const char *cmd;
+	struct child_process process;
+};
+
+static int cmd_process_map_initialized;
+static struct hashmap cmd_process_map;
+
+static int cmd2process_cmp(const struct cmd2process *e1,
+			   const struct cmd2process *e2,
+			   const void *unused)
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
+static int packet_write_list(int fd, const char *line, ...)
+{
+	va_list args;
+	int err;
+	va_start(args, line);
+	for (;;) {
+		if (!line)
+			break;
+		if (strlen(line) > LARGE_PACKET_DATA_MAX)
+			return -1;
+		err = packet_write_fmt_gently(fd, "%s\n", line);
+		if (err)
+			return err;
+		line = va_arg(args, const char*);
+	}
+	va_end(args);
+	return packet_flush_gently(fd);
+}
+
+static void read_multi_file_filter_status(int fd, struct strbuf *status) {
+	struct strbuf **pair;
+	char *line;
+	for (;;) {
+		line = packet_read_line(fd, NULL);
+		if (!line)
+			break;
+		pair = strbuf_split_str(line, '=', 2);
+		if (pair[0] && pair[0]->len && pair[1]) {
+			/* the last "status=<foo>" line wins */
+			if (!strcmp(pair[0]->buf, "status=")) {
+				strbuf_reset(status);
+				strbuf_addbuf(status, pair[1]);
+			}
+		}
+		strbuf_list_free(pair);
+	}
+}
+
+static void kill_multi_file_filter(struct hashmap *hashmap, struct cmd2process *entry)
+{
+	if (!entry)
+		return;
+
+	entry->process.clean_on_exit = 0;
+	kill(entry->process.pid, SIGTERM);
+	finish_command(&entry->process);
+
+	hashmap_remove(hashmap, entry, NULL);
+	free(entry);
+}
+
+static void stop_multi_file_filter(struct child_process *process)
+{
+	sigchain_push(SIGPIPE, SIG_IGN);
+	/* Closing the pipe signals the filter to initiate a shutdown. */
+	close(process->in);
+	close(process->out);
+	sigchain_pop(SIGPIPE);
+	/* Finish command will wait until the shutdown is complete. */
+	finish_command(process);
+}
+
+static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, const char *cmd)
+{
+	int err;
+	struct cmd2process *entry;
+	struct child_process *process;
+	const char *argv[] = { cmd, NULL };
+	struct string_list cap_list = STRING_LIST_INIT_NODUP;
+	char *cap_buf;
+	const char *cap_name;
+
+	entry = xmalloc(sizeof(*entry));
+	entry->cmd = cmd;
+	entry->supported_capabilities = 0;
+	process = &entry->process;
+
+	child_process_init(process);
+	process->argv = argv;
+	process->use_shell = 1;
+	process->in = -1;
+	process->out = -1;
+	process->clean_on_exit = 1;
+	process->clean_on_exit_handler = stop_multi_file_filter;
+
+	if (start_command(process)) {
+		error("cannot fork to run external filter '%s'", cmd);
+		return NULL;
+	}
+
+	hashmap_entry_init(entry, strhash(cmd));
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	err = packet_write_list(process->in, "git-filter-client", "version=2", NULL);
+	if (err)
+		goto done;
+
+	err = strcmp(packet_read_line(process->out, NULL), "git-filter-server");
+	if (err) {
+		error("external filter '%s' does not support filter protocol version 2", cmd);
+		goto done;
+	}
+	err = strcmp(packet_read_line(process->out, NULL), "version=2");
+	if (err)
+		goto done;
+	err = packet_read_line(process->out, NULL) != NULL;
+	if (err)
+		goto done;
+
+	err = packet_write_list(process->in, "capability=clean", "capability=smudge", NULL);
+
+	for (;;) {
+		cap_buf = packet_read_line(process->out, NULL);
+		if (!cap_buf)
+			break;
+		string_list_split_in_place(&cap_list, cap_buf, '=', 1);
+
+		if (cap_list.nr != 2 || strcmp(cap_list.items[0].string, "capability"))
+			continue;
+
+		cap_name = cap_list.items[1].string;
+		if (!strcmp(cap_name, "clean")) {
+			entry->supported_capabilities |= CAP_CLEAN;
+		} else if (!strcmp(cap_name, "smudge")) {
+			entry->supported_capabilities |= CAP_SMUDGE;
+		} else {
+			warning(
+				"external filter '%s' requested unsupported filter capability '%s'",
+				cmd, cap_name
+			);
+		}
+
+		string_list_clear(&cap_list, 0);
+	}
+
+done:
+	sigchain_pop(SIGPIPE);
+
+	if (err || errno == EPIPE) {
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
+				   int fd, struct strbuf *dst, const char *cmd,
+				   const unsigned int wanted_capability)
+{
+	int err;
+	struct cmd2process *entry;
+	struct child_process *process;
+	struct strbuf nbuf = STRBUF_INIT;
+	struct strbuf filter_status = STRBUF_INIT;
+	const char *filter_type;
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
+		return 0;
+
+	if (CAP_CLEAN & wanted_capability)
+		filter_type = "clean";
+	else if (CAP_SMUDGE & wanted_capability)
+		filter_type = "smudge";
+	else
+		die("unexpected filter type");
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	assert(strlen(filter_type) < LARGE_PACKET_DATA_MAX - strlen("command=\n"));
+	err = packet_write_fmt_gently(process->in, "command=%s\n", filter_type);
+	if (err)
+		goto done;
+
+	err = strlen(path) > LARGE_PACKET_DATA_MAX - strlen("pathname=\n");
+	if (err) {
+		error("path name too long for external filter");
+		goto done;
+	}
+
+	err = packet_write_fmt_gently(process->in, "pathname=%s\n", path);
+	if (err)
+		goto done;
+
+	err = packet_flush_gently(process->in);
+	if (err)
+		goto done;
+
+	if (fd >= 0)
+		err = write_packetized_from_fd(fd, process->in);
+	else
+		err = write_packetized_from_buf(src, len, process->in);
+	if (err)
+		goto done;
+
+	read_multi_file_filter_status(process->out, &filter_status);
+	err = strcmp(filter_status.buf, "success");
+	if (err)
+		goto done;
+
+	err = read_packetized_to_strbuf(process->out, &nbuf) < 0;
+	if (err)
+		goto done;
+
+	read_multi_file_filter_status(process->out, &filter_status);
+	err = strcmp(filter_status.buf, "success");
+
+done:
+	sigchain_pop(SIGPIPE);
+
+	if (err || errno == EPIPE) {
+		if (!strcmp(filter_status.buf, "error")) {
+			/* The filter signaled a problem with the file. */
+		} else if (!strcmp(filter_status.buf, "abort")) {
+			/*
+			 * The filter signaled a permanent problem. Don't try to filter
+			 * files with the same command for the lifetime of the current
+			 * Git process.
+			 */
+			 entry->supported_capabilities &= ~wanted_capability;
+		} else {
+			/*
+			 * Something went wrong with the protocol filter.
+			 * Force shutdown and restart if another blob requires filtering.
+			 */
+			error("external filter '%s' failed", cmd);
+			kill_multi_file_filter(&cmd_process_map, entry);
+		}
+	} else {
+		strbuf_swap(dst, &nbuf);
+	}
+	strbuf_release(&nbuf);
+	return !err;
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
 
@@ -510,13 +792,15 @@ static int apply_filter(const char *path, const char *src, size_t len,
 	if (!dst)
 		return 1;
 
-	if ((CAP_CLEAN & wanted_capability) && drv->clean)
+	if ((CAP_CLEAN & wanted_capability) && !drv->process && drv->clean)
 		cmd = drv->clean;
-	else if ((CAP_SMUDGE & wanted_capability) && drv->smudge)
+	else if ((CAP_SMUDGE & wanted_capability) && !drv->process && drv->smudge)
 		cmd = drv->smudge;
 
 	if (cmd && *cmd)
 		return apply_single_file_filter(path, src, len, fd, dst, cmd);
+	else if (drv->process && *drv->process)
+		return apply_multi_file_filter(path, src, len, fd, dst, drv->process, wanted_capability);
 
 	return 0;
 }
@@ -558,6 +842,9 @@ static int read_convert_config(const char *var, const char *value, void *cb)
 	if (!strcmp("clean", key))
 		return git_config_string(&drv->clean, var, value);
 
+	if (!strcmp("process", key))
+		return git_config_string(&drv->process, var, value);
+
 	if (!strcmp("required", key)) {
 		drv->required = git_config_bool(var, value);
 		return 0;
@@ -919,7 +1206,7 @@ void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
 	convert_attrs(&ca, path);
 
 	assert(ca.drv);
-	assert(ca.drv->clean);
+	assert(ca.drv->clean || ca.drv->process);
 
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
@@ -944,9 +1231,10 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 	}
 	/*
 	 * CRLF conversion can be skipped if normalizing, unless there
-	 * is a smudge filter.  The filter might expect CRLFs.
+	 * is a smudge or process filter (even if the process filter doesn't
+	 * support smudge).  The filters might expect CRLFs.
 	 */
-	if ((ca.drv && ca.drv->smudge) || !normalizing) {
+	if ((ca.drv && (ca.drv->smudge || ca.drv->process)) || !normalizing) {
 		ret |= crlf_to_worktree(path, src, len, dst, ca.crlf_action);
 		if (ret) {
 			src = dst->buf;
@@ -1407,7 +1695,7 @@ struct stream_filter *get_stream_filter(const char *path, const unsigned char *s
 	struct stream_filter *filter = NULL;
 
 	convert_attrs(&ca, path);
-	if (ca.drv && (ca.drv->smudge || ca.drv->clean))
+	if (ca.drv && (ca.drv->process || ca.drv->smudge || ca.drv->clean))
 		return NULL;
 
 	if (ca.crlf_action == CRLF_AUTO || ca.crlf_action == CRLF_AUTO_CRLF)
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index dc50938..a20b9f5 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -4,13 +4,72 @@ test_description='blob conversion via gitattributes'
 
 . ./test-lib.sh
 
-cat <<EOF >rot13.sh
+TEST_ROOT="$(pwd)"
+
+cat <<EOF >"$TEST_ROOT/rot13.sh"
 #!$SHELL_PATH
 tr \
   'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' \
   'nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM'
 EOF
-chmod +x rot13.sh
+chmod +x "$TEST_ROOT/rot13.sh"
+
+generate_random_characters () {
+	LEN=$1
+	NAME=$2
+	test-genrandom some-seed $LEN |
+		perl -pe "s/./chr((ord($&) % 26) + ord('a'))/sge" >"$TEST_ROOT/$NAME"
+}
+
+file_size () {
+	cat "$1" | wc -c | sed "s/^[ ]*//"
+}
+
+filter_git () {
+	rm -f rot13-filter.log &&
+	git "$@" 2>git-stderr.log &&
+	rm -f git-stderr.log
+}
+
+# Compare two files and ensure that `clean` and `smudge` respectively are
+# called at least once if specified in the `expect` file. The actual
+# invocation count is not relevant because their number can vary.
+# c.f. http://public-inbox.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
+test_cmp_count () {
+	expect=$1
+	actual=$2
+	for FILE in "$expect" "$actual"
+	do
+		sort "$FILE" | uniq -c | sed "s/^[ ]*//" |
+			sed "s/^\([0-9]\) IN: clean/x IN: clean/" |
+			sed "s/^\([0-9]\) IN: smudge/x IN: smudge/" >"$FILE.tmp" &&
+		mv "$FILE.tmp" "$FILE"
+	done &&
+	test_cmp "$expect" "$actual"
+}
+
+# Compare two files but exclude all `clean` invocations because Git can
+# call `clean` zero or more times.
+# c.f. http://public-inbox.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
+test_cmp_exclude_clean () {
+	expect=$1
+	actual=$2
+	for FILE in "$expect" "$actual"
+	do
+		grep -v "IN: clean" "$FILE" >"$FILE.tmp" &&
+		mv "$FILE.tmp" "$FILE"
+	done &&
+	test_cmp "$expect" "$actual"
+}
+
+# Check that the contents of two files are equal and that their rot13 version
+# is equal to the committed content.
+test_cmp_committed_rot13 () {
+	test_cmp "$1" "$2" &&
+	"$TEST_ROOT/rot13.sh" <"$1" >expected &&
+	git cat-file blob :"$2" >actual &&
+	test_cmp expected actual
+}
 
 test_expect_success setup '
 	git config filter.rot13.smudge ./rot13.sh &&
@@ -31,7 +90,10 @@ test_expect_success setup '
 	cat test >test.i &&
 	git add test test.t test.i &&
 	rm -f test test.t test.i &&
-	git checkout -- test test.t test.i
+	git checkout -- test test.t test.i &&
+
+	echo "content-test2" >test2.o &&
+	echo "content-test3 - filename with special characters" >"test3 '\''sq'\'',\$x.o"
 '
 
 script='s/^\$Id: \([0-9a-f]*\) \$/\1/p'
@@ -279,4 +341,380 @@ test_expect_success 'diff does not reuse worktree files that need cleaning' '
 	test_line_count = 0 count
 '
 
+test_expect_success PERL 'required process filter should filter data' '
+	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
+	test_config_global filter.protocol.required true &&
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+
+		echo "git-stderr.log" >.gitignore &&
+		echo "*.r filter=protocol" >.gitattributes &&
+		git add . &&
+		git commit . -m "test commit 1" &&
+		git branch empty-branch &&
+
+		cp "$TEST_ROOT/test.o" test.r &&
+		cp "$TEST_ROOT/test2.o" test2.r &&
+		mkdir testsubdir &&
+		cp "$TEST_ROOT/test3 '\''sq'\'',\$x.o" "testsubdir/test3 '\''sq'\'',\$x.r" &&
+		>test4-empty.r &&
+
+		S=$(file_size test.r) &&
+		S2=$(file_size test2.r) &&
+		S3=$(file_size "testsubdir/test3 '\''sq'\'',\$x.r") &&
+
+		filter_git add . &&
+		cat >expected.log <<-EOF &&
+			START
+			init handshake complete
+			IN: clean test.r $S [OK] -- OUT: $S . [OK]
+			IN: clean test2.r $S2 [OK] -- OUT: $S2 . [OK]
+			IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
+			IN: clean testsubdir/test3 '\''sq'\'',\$x.r $S3 [OK] -- OUT: $S3 . [OK]
+			STOP
+		EOF
+		test_cmp_count expected.log rot13-filter.log &&
+
+		filter_git commit . -m "test commit 2" &&
+		cat >expected.log <<-EOF &&
+			START
+			init handshake complete
+			IN: clean test.r $S [OK] -- OUT: $S . [OK]
+			IN: clean test2.r $S2 [OK] -- OUT: $S2 . [OK]
+			IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
+			IN: clean testsubdir/test3 '\''sq'\'',\$x.r $S3 [OK] -- OUT: $S3 . [OK]
+			IN: clean test.r $S [OK] -- OUT: $S . [OK]
+			IN: clean test2.r $S2 [OK] -- OUT: $S2 . [OK]
+			IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
+			IN: clean testsubdir/test3 '\''sq'\'',\$x.r $S3 [OK] -- OUT: $S3 . [OK]
+			STOP
+		EOF
+		test_cmp_count expected.log rot13-filter.log &&
+
+		rm -f test2.r "testsubdir/test3 '\''sq'\'',\$x.r" &&
+
+		filter_git checkout --quiet --no-progress . &&
+		cat >expected.log <<-EOF &&
+			START
+			init handshake complete
+			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
+			IN: smudge testsubdir/test3 '\''sq'\'',\$x.r $S3 [OK] -- OUT: $S3 . [OK]
+			STOP
+		EOF
+		test_cmp_exclude_clean expected.log rot13-filter.log &&
+
+		filter_git checkout --quiet --no-progress empty-branch &&
+		cat >expected.log <<-EOF &&
+			START
+			init handshake complete
+			IN: clean test.r $S [OK] -- OUT: $S . [OK]
+			STOP
+		EOF
+		test_cmp_exclude_clean expected.log rot13-filter.log &&
+
+		filter_git checkout --quiet --no-progress master &&
+		cat >expected.log <<-EOF &&
+			START
+			init handshake complete
+			IN: smudge test.r $S [OK] -- OUT: $S . [OK]
+			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
+			IN: smudge test4-empty.r 0 [OK] -- OUT: 0  [OK]
+			IN: smudge testsubdir/test3 '\''sq'\'',\$x.r $S3 [OK] -- OUT: $S3 . [OK]
+			STOP
+		EOF
+		test_cmp_exclude_clean expected.log rot13-filter.log &&
+
+		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test.r &&
+		test_cmp_committed_rot13 "$TEST_ROOT/test2.o" test2.r &&
+		test_cmp_committed_rot13 "$TEST_ROOT/test3 '\''sq'\'',\$x.o" "testsubdir/test3 '\''sq'\'',\$x.r"
+	)
+'
+
+test_expect_success PERL 'required process filter takes precedence' '
+	test_config_global filter.protocol.clean false &&
+	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean" &&
+	test_config_global filter.protocol.required true &&
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+
+		echo "*.r filter=protocol" >.gitattributes &&
+		cp "$TEST_ROOT/test.o" test.r &&
+		S=$(file_size test.r) &&
+
+		# Check that the process filter is invoked here
+		filter_git add . &&
+		cat >expected.log <<-EOF &&
+			START
+			init handshake complete
+			IN: clean test.r $S [OK] -- OUT: $S . [OK]
+			STOP
+		EOF
+		test_cmp_count expected.log rot13-filter.log
+	)
+'
+
+test_expect_success PERL 'required process filter should be used only for "clean" operation only' '
+	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean" &&
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+
+		echo "*.r filter=protocol" >.gitattributes &&
+		cp "$TEST_ROOT/test.o" test.r &&
+		S=$(file_size test.r) &&
+
+		filter_git add . &&
+		cat >expected.log <<-EOF &&
+			START
+			init handshake complete
+			IN: clean test.r $S [OK] -- OUT: $S . [OK]
+			STOP
+		EOF
+		test_cmp_count expected.log rot13-filter.log &&
+
+		rm test.r &&
+
+		filter_git checkout --quiet --no-progress . &&
+		# If the filter would be used for "smudge", too, we would see
+		# "IN: smudge test.r 57 [OK] -- OUT: 57 . [OK]" here
+		cat >expected.log <<-EOF &&
+			START
+			init handshake complete
+			STOP
+		EOF
+		test_cmp_exclude_clean expected.log rot13-filter.log
+	)
+'
+
+test_expect_success PERL 'required process filter should process multiple packets' '
+	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
+	test_config_global filter.protocol.required true &&
+
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+
+		# Generate data requiring 1, 2, 3 packets
+		S=65516 && # PKTLINE_DATA_MAXLEN -> Maximal size of a packet
+		generate_random_characters $(($S    )) 1pkt_1__.file &&
+		generate_random_characters $(($S  +1)) 2pkt_1+1.file &&
+		generate_random_characters $(($S*2-1)) 2pkt_2-1.file &&
+		generate_random_characters $(($S*2  )) 2pkt_2__.file &&
+		generate_random_characters $(($S*2+1)) 3pkt_2+1.file &&
+
+		for FILE in "$TEST_ROOT"/*.file
+		do
+			cp "$FILE" . &&
+			"$TEST_ROOT/rot13.sh" <"$FILE" >"$FILE.rot13"
+		done &&
+
+		echo "*.file filter=protocol" >.gitattributes &&
+		filter_git add *.file .gitattributes &&
+		cat >expected.log <<-EOF &&
+			START
+			init handshake complete
+			IN: clean 1pkt_1__.file $(($S    )) [OK] -- OUT: $(($S    )) . [OK]
+			IN: clean 2pkt_1+1.file $(($S  +1)) [OK] -- OUT: $(($S  +1)) .. [OK]
+			IN: clean 2pkt_2-1.file $(($S*2-1)) [OK] -- OUT: $(($S*2-1)) .. [OK]
+			IN: clean 2pkt_2__.file $(($S*2  )) [OK] -- OUT: $(($S*2  )) .. [OK]
+			IN: clean 3pkt_2+1.file $(($S*2+1)) [OK] -- OUT: $(($S*2+1)) ... [OK]
+			STOP
+		EOF
+		test_cmp_count expected.log rot13-filter.log &&
+
+		rm -f *.file &&
+
+		filter_git checkout --quiet --no-progress -- *.file &&
+		cat >expected.log <<-EOF &&
+			START
+			init handshake complete
+			IN: smudge 1pkt_1__.file $(($S    )) [OK] -- OUT: $(($S    )) . [OK]
+			IN: smudge 2pkt_1+1.file $(($S  +1)) [OK] -- OUT: $(($S  +1)) .. [OK]
+			IN: smudge 2pkt_2-1.file $(($S*2-1)) [OK] -- OUT: $(($S*2-1)) .. [OK]
+			IN: smudge 2pkt_2__.file $(($S*2  )) [OK] -- OUT: $(($S*2  )) .. [OK]
+			IN: smudge 3pkt_2+1.file $(($S*2+1)) [OK] -- OUT: $(($S*2+1)) ... [OK]
+			STOP
+		EOF
+		test_cmp_exclude_clean expected.log rot13-filter.log &&
+
+		for FILE in *.file
+		do
+			test_cmp_committed_rot13 "$TEST_ROOT/$FILE" $FILE
+		done
+	)
+'
+
+test_expect_success PERL 'required process filter with clean error should fail' '
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
+		cp "$TEST_ROOT/test.o" test.r &&
+		echo "this is going to fail" >clean-write-fail.r &&
+		echo "content-test3-subdir" >test3.r &&
+
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
+		cp "$TEST_ROOT/test.o" test.r &&
+		cp "$TEST_ROOT/test2.o" test2.r &&
+		echo "this is going to fail" >smudge-write-fail.o &&
+		cp smudge-write-fail.o smudge-write-fail.r &&
+
+		S=$(file_size test.r) &&
+		S2=$(file_size test2.r) &&
+		SF=$(file_size smudge-write-fail.r) &&
+
+		git add . &&
+		rm -f *.r &&
+
+		rm -f rot13-filter.log &&
+		git checkout --quiet --no-progress . 2>git-stderr.log &&
+
+		grep "smudge write error at" git-stderr.log &&
+		grep "error: external filter" git-stderr.log &&
+
+		cat >expected.log <<-EOF &&
+			START
+			init handshake complete
+			IN: smudge smudge-write-fail.r $SF [OK] -- OUT: $SF [WRITE FAIL]
+			START
+			init handshake complete
+			IN: smudge test.r $S [OK] -- OUT: $S . [OK]
+			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
+			STOP
+		EOF
+		test_cmp_exclude_clean expected.log rot13-filter.log &&
+
+		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test.r &&
+		test_cmp_committed_rot13 "$TEST_ROOT/test2.o" test2.r &&
+
+		# Smudge failed
+		! test_cmp smudge-write-fail.o smudge-write-fail.r &&
+		"$TEST_ROOT/rot13.sh" <smudge-write-fail.o >expected &&
+		git cat-file blob :smudge-write-fail.r >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success PERL 'process filter should not be restarted if it signals an error' '
+	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+
+		echo "*.r filter=protocol" >.gitattributes &&
+
+		cp "$TEST_ROOT/test.o" test.r &&
+		cp "$TEST_ROOT/test2.o" test2.r &&
+		echo "this will cause an error" >error.o &&
+		cp error.o error.r &&
+
+		S=$(file_size test.r) &&
+		S2=$(file_size test2.r) &&
+		SE=$(file_size error.r) &&
+
+		git add . &&
+		rm -f *.r &&
+
+		filter_git checkout --quiet --no-progress . &&
+		cat >expected.log <<-EOF &&
+			START
+			init handshake complete
+			IN: smudge error.r $SE [OK] -- OUT: 0 [ERROR]
+			IN: smudge test.r $S [OK] -- OUT: $S . [OK]
+			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
+			STOP
+		EOF
+		test_cmp_exclude_clean expected.log rot13-filter.log &&
+
+		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test.r &&
+		test_cmp_committed_rot13 "$TEST_ROOT/test2.o" test2.r &&
+		test_cmp error.o error.r
+	)
+'
+
+test_expect_success PERL 'process filter abort stops processing of all further files' '
+	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+
+		echo "*.r filter=protocol" >.gitattributes &&
+
+		cp "$TEST_ROOT/test.o" test.r &&
+		cp "$TEST_ROOT/test2.o" test2.r &&
+		echo "error this blob and all future blobs" >abort.o &&
+		cp abort.o abort.r &&
+
+		SA=$(file_size abort.r) &&
+
+		git add . &&
+		rm -f *.r &&
+
+		# Note: This test assumes that Git filters files in alphabetical
+		# order ("abort.r" before "test.r").
+		filter_git checkout --quiet --no-progress . &&
+		cat >expected.log <<-EOF &&
+			START
+			init handshake complete
+			IN: smudge abort.r $SA [OK] -- OUT: 0 [ABORT]
+			STOP
+		EOF
+		test_cmp_exclude_clean expected.log rot13-filter.log &&
+
+		test_cmp "$TEST_ROOT/test.o" test.r &&
+		test_cmp "$TEST_ROOT/test2.o" test2.r &&
+		test_cmp abort.o abort.r
+	)
+'
+
+test_expect_success PERL 'invalid process filter must fail (and not hang!)' '
+	test_config_global filter.protocol.process cat &&
+	test_config_global filter.protocol.required true &&
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+
+		echo "*.r filter=protocol" >.gitattributes &&
+
+		cp "$TEST_ROOT/test.o" test.r &&
+		test_must_fail git add . 2>git-stderr.log &&
+		grep "does not support filter protocol version" git-stderr.log
+	)
+'
+
 test_done
diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
new file mode 100755
index 0000000..ae4c50f
--- /dev/null
+++ b/t/t0021/rot13-filter.pl
@@ -0,0 +1,192 @@
+#!/usr/bin/perl
+#
+# Example implementation for the Git filter protocol version 2
+# See Documentation/gitattributes.txt, section "Filter Protocol"
+#
+# The script takes the list of supported protocol capabilities as
+# arguments ("clean", "smudge", etc).
+#
+# This implementation supports special test cases:
+# (1) If data with the pathname "clean-write-fail.r" is processed with
+#     a "clean" operation then the write operation will die.
+# (2) If data with the pathname "smudge-write-fail.r" is processed with
+#     a "smudge" operation then the write operation will die.
+# (3) If data with the pathname "error.r" is processed with any
+#     operation then the filter signals that it cannot or does not want
+#     to process the file.
+# (4) If data with the pathname "abort.r" is processed with any
+#     operation then the filter signals that it cannot or does not want
+#     to process the file and any file after that is processed with the
+#     same command.
+#
+
+use strict;
+use warnings;
+
+my $MAX_PACKET_CONTENT_SIZE = 65516;
+my @capabilities            = @ARGV;
+
+open my $debug, ">>", "rot13-filter.log" or die "cannot open log file: $!";
+
+sub rot13 {
+	my $str = shift;
+	$str =~ y/A-Za-z/N-ZA-Mn-za-m/;
+	return $str;
+}
+
+sub packet_bin_read {
+	my $buffer;
+	my $bytes_read = read STDIN, $buffer, 4;
+	if ( $bytes_read == 0 ) {
+		# EOF - Git stopped talking to us!
+		print $debug "STOP\n";
+		exit();
+	}
+	elsif ( $bytes_read != 4 ) {
+		die "invalid packet: '$buffer'";
+	}
+	my $pkt_size = hex($buffer);
+	if ( $pkt_size == 0 ) {
+		return ( 1, "" );
+	}
+	elsif ( $pkt_size > 4 ) {
+		my $content_size = $pkt_size - 4;
+		$bytes_read = read STDIN, $buffer, $content_size;
+		if ( $bytes_read != $content_size ) {
+			die "invalid packet ($content_size bytes expected; $bytes_read bytes read)";
+		}
+		return ( 0, $buffer );
+	}
+	else {
+		die "invalid packet size: $pkt_size";
+	}
+}
+
+sub packet_txt_read {
+	my ( $res, $buf ) = packet_bin_read();
+	unless ( $buf =~ s/\n$// ) {
+		die "A non-binary line MUST be terminated by an LF.";
+	}
+	return ( $res, $buf );
+}
+
+sub packet_bin_write {
+	my $buf = shift;
+	print STDOUT sprintf( "%04x", length($buf) + 4 );
+	print STDOUT $buf;
+	STDOUT->flush();
+}
+
+sub packet_txt_write {
+	packet_bin_write( $_[0] . "\n" );
+}
+
+sub packet_flush {
+	print STDOUT sprintf( "%04x", 0 );
+	STDOUT->flush();
+}
+
+print $debug "START\n";
+$debug->flush();
+
+( packet_txt_read() eq ( 0, "git-filter-client" ) ) || die "bad initialize";
+( packet_txt_read() eq ( 0, "version=2" ) )         || die "bad version";
+( packet_bin_read() eq ( 1, "" ) )                  || die "bad version end";
+
+packet_txt_write("git-filter-server");
+packet_txt_write("version=2");
+packet_flush();
+
+( packet_txt_read() eq ( 0, "capability=clean" ) )  || die "bad capability";
+( packet_txt_read() eq ( 0, "capability=smudge" ) ) || die "bad capability";
+( packet_bin_read() eq ( 1, "" ) )                  || die "bad capability end";
+
+foreach (@capabilities) {
+	packet_txt_write( "capability=" . $_ );
+}
+packet_flush();
+print $debug "init handshake complete\n";
+$debug->flush();
+
+while (1) {
+	my ($command) = packet_txt_read() =~ /^command=([^=]+)$/;
+	print $debug "IN: $command";
+	$debug->flush();
+
+	my ($pathname) = packet_txt_read() =~ /^pathname=([^=]+)$/;
+	print $debug " $pathname";
+	$debug->flush();
+
+	# Flush
+	packet_bin_read();
+
+	my $input = "";
+	{
+		binmode(STDIN);
+		my $buffer;
+		my $done = 0;
+		while ( !$done ) {
+			( $done, $buffer ) = packet_bin_read();
+			$input .= $buffer;
+		}
+		print $debug " " . length($input) . " [OK] -- ";
+		$debug->flush();
+	}
+
+	my $output;
+	if ( $pathname eq "error.r" or $pathname eq "abort.r" ) {
+		$output = "";
+	}
+	elsif ( $command eq "clean" and grep( /^clean$/, @capabilities ) ) {
+		$output = rot13($input);
+	}
+	elsif ( $command eq "smudge" and grep( /^smudge$/, @capabilities ) ) {
+		$output = rot13($input);
+	}
+	else {
+		die "bad command '$command'";
+	}
+
+	print $debug "OUT: " . length($output) . " ";
+	$debug->flush();
+
+	if ( $pathname eq "error.r" ) {
+		print $debug "[ERROR]\n";
+		$debug->flush();
+		packet_txt_write("status=error");
+		packet_flush();
+	}
+	elsif ( $pathname eq "abort.r" ) {
+		print $debug "[ABORT]\n";
+		$debug->flush();
+		packet_txt_write("status=abort");
+		packet_flush();
+	}
+	else {
+		packet_txt_write("status=success");
+		packet_flush();
+
+		if ( $pathname eq "${command}-write-fail.r" ) {
+			print $debug "[WRITE FAIL]\n";
+			$debug->flush();
+			die "${command} write error";
+		}
+
+		while ( length($output) > 0 ) {
+			my $packet = substr( $output, 0, $MAX_PACKET_CONTENT_SIZE );
+			packet_bin_write($packet);
+			# dots represent the number of packets
+			print $debug ".";
+			if ( length($output) > $MAX_PACKET_CONTENT_SIZE ) {
+				$output = substr( $output, $MAX_PACKET_CONTENT_SIZE );
+			}
+			else {
+				$output = "";
+			}
+		}
+		packet_flush();
+		print $debug " [OK]\n";
+		$debug->flush();
+		packet_flush();
+	}
+}
-- 
2.10.0

