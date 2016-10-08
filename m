Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3155207EC
	for <e@80x24.org>; Sat,  8 Oct 2016 11:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934979AbcJHLZh (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Oct 2016 07:25:37 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34543 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932697AbcJHLZf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2016 07:25:35 -0400
Received: by mail-wm0-f65.google.com with SMTP id b201so6641759wmb.1
        for <git@vger.kernel.org>; Sat, 08 Oct 2016 04:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=YIwNohV/0VwjehWWuSVYphxE0RuB8OfINHLifwOsBpo=;
        b=N8bGPevoGzCqgQTYO3FBt7sWoZ7Jlk0yb2de5A+LrH63+iqXJmNqlmbirW6BPBtaya
         pkT2rAtkFzpgRVoR0YE2FYpqUQfcKoFtwBGyVlcJEvfRm1RhUU5ib4mFOk/6RnqQEyED
         kA4dskB/LR/4Zladan6rQ3Qr4REkoNG+MwyfJb8DZNEZ24zhYAc/s9aF93iG6htpwn8Y
         rHGUUPjk5P9jLZRPa7j7JUdVsG+mg06QDZ8ciA0+nl+12bavxQP1UMbfRBoS0l9IZQbE
         6ko9ugUzkAy89ZPa6pWLD5pbxI6ynzBgSey97YImM6k3AV8bwjHp0wOz2UClmde8nVpJ
         yhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YIwNohV/0VwjehWWuSVYphxE0RuB8OfINHLifwOsBpo=;
        b=eP76thP9hJmgoaAotGjxQQSOH/oTf5cpC5Ja3jD/GITvz+qJXBn+LBqRoKLxVD0oLl
         tUy3iXZQaWcDWSc8aJ+zmldfaj2Igy0nEI8UZKqzBjopSUJqcvIIDEhbsoSDbqu5PMzf
         g1aOXpu+fkt+4NSNXtWbUWkZOv7sQDvBG0xyE/j0/QcMBYeKw01ZunGeD2OTpp/HEUHa
         SEPWehVAwqwjf+k2qSVuDObTObfq3dS2ZYc6jk4R+SndN4vkDoRqcIeKkHy6GSRjt4fP
         RowL3qqf2Wf5DkyBy1F6Ka0penbToJsdKBZq28BW4rH3N/DbEaEbe9Jvdv0UvZtr59gF
         Mq8g==
X-Gm-Message-State: AA6/9Rmp2tWMkf0SLNva6G2sGom6Vh5YMpaH7xf/QXGuh+DZV7GnrCHwMC7CEkiLmP7LLg==
X-Received: by 10.194.106.197 with SMTP id gw5mr18437658wjb.88.1475925933715;
        Sat, 08 Oct 2016 04:25:33 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB73B1.dip0.t-ipconnect.de. [93.219.115.177])
        by smtp.gmail.com with ESMTPSA id a1sm24599623wju.41.2016.10.08.04.25.31
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 08 Oct 2016 04:25:32 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jnareb@gmail.com, peff@peff.net,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v10 00/14] Git filter protocol
Date:   Sat,  8 Oct 2016 13:25:16 +0200
Message-Id: <20161008112530.15506-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

The goal of this series is to avoid launching a new clean/smudge filter
process for each file that is filtered.

A short summary about v1 to v5 can be found here:
https://git.github.io/rev_news/2016/08/17/edition-18/

This series is also published on web:
https://github.com/larsxschneider/git/pull/14

Patches 1 and 2 are cleanups and not strictly necessary for the series.
Patches 3 to 12 are required preparation. Patch 13 is the main patch.
Patch 14 adds an example how to use the Git filter protocol in contrib.

Thanks a lot to
 Jakub, Junio, and Peff
for very helpful reviews,
Lars

## Changes since v9
  * replace the very specific "wait after close(stdin)" behavior with the
    more flexible run-command "clean_on_exit_handler" flag to fix flaky t0021,
    see discussion:
    http://public-inbox.org/git/xmqq37k9mm7k.fsf@gitster.mtv.corp.google.com/
    http://public-inbox.org/git/xmqq8tubitjs.fsf@gitster.mtv.corp.google.com/
  * run stop_multi_file_filter() for all filters on Git shutdown
  * actually kill filter in kill_multi_file_filter()
  * add new filter process to hashmap only if the process start was successful
  * remove superfluous fstat() call
  * avoid potential buffer overflow in packet_write_gently() packet size check
  * remove superfluous buffer in write_packetized_from_buf()
  * improve test name


Lars Schneider (14):
  convert: quote filter names in error messages
  convert: modernize tests
  run-command: move check_pipe() from write_or_die to run_command
  run-command: add clean_on_exit_handler
  pkt-line: rename packet_write() to packet_write_fmt()
  pkt-line: extract set_packet_header()
  pkt-line: add packet_write_fmt_gently()
  pkt-line: add packet_flush_gently()
  pkt-line: add packet_write_gently()
  pkt-line: add functions to read/write flush terminated packet streams
  convert: make apply_filter() adhere to standard Git error handling
  convert: prepare filter.<driver>.process option
  convert: add filter.<driver>.process option
  contrib/long-running-filter: add long running filter example

 Documentation/gitattributes.txt        | 159 ++++++++++-
 builtin/archive.c                      |   4 +-
 builtin/receive-pack.c                 |   4 +-
 builtin/remote-ext.c                   |   4 +-
 builtin/upload-archive.c               |   4 +-
 connect.c                              |   2 +-
 contrib/long-running-filter/example.pl | 127 +++++++++
 convert.c                              | 372 +++++++++++++++++++++---
 daemon.c                               |   2 +-
 http-backend.c                         |   2 +-
 pkt-line.c                             | 152 +++++++++-
 pkt-line.h                             |  12 +-
 run-command.c                          |  36 ++-
 run-command.h                          |   4 +-
 shallow.c                              |   2 +-
 t/t0021-conversion.sh                  | 505 ++++++++++++++++++++++++++++++---
 t/t0021/rot13-filter.pl                | 191 +++++++++++++
 upload-pack.c                          |  30 +-
 write_or_die.c                         |  13 -
 19 files changed, 1492 insertions(+), 133 deletions(-)
 create mode 100755 contrib/long-running-filter/example.pl
 create mode 100755 t/t0021/rot13-filter.pl



## Interdiff (v9..v10)

diff --git a/convert.c b/convert.c
index 88581d6..1d89632 100644
--- a/convert.c
+++ b/convert.c
@@ -516,23 +516,6 @@ static struct cmd2process *find_multi_file_filter_entry(struct hashmap *hashmap,
 	return hashmap_get(hashmap, &key, NULL);
 }

-static void kill_multi_file_filter(struct hashmap *hashmap, struct cmd2process *entry)
-{
-	if (!entry)
-		return;
-	sigchain_push(SIGPIPE, SIG_IGN);
-	/*
-	 * We kill the filter most likely because an error happened already.
-	 * That's why we are not interested in any error code here.
-	 */
-	close(entry->process.in);
-	close(entry->process.out);
-	sigchain_pop(SIGPIPE);
-	finish_command(&entry->process);
-	hashmap_remove(hashmap, entry, NULL);
-	free(entry);
-}
-
 static int packet_write_list(int fd, const char *line, ...)
 {
 	va_list args;
@@ -552,6 +535,49 @@ static int packet_write_list(int fd, const char *line, ...)
 	return packet_flush_gently(fd);
 }

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
+void stop_multi_file_filter(struct child_process *process)
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
 static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, const char *cmd)
 {
 	int err;
@@ -563,7 +589,6 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 	const char *cap_name;

 	entry = xmalloc(sizeof(*entry));
-	hashmap_entry_init(entry, strhash(cmd));
 	entry->cmd = cmd;
 	entry->supported_capabilities = 0;
 	process = &entry->process;
@@ -573,14 +598,16 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 	process->use_shell = 1;
 	process->in = -1;
 	process->out = -1;
-	process->wait_on_exit = 1;
+	process->clean_on_exit = 1;
+	process->clean_on_exit_handler = stop_multi_file_filter;

 	if (start_command(process)) {
 		error("cannot fork to run external filter '%s'", cmd);
-		kill_multi_file_filter(hashmap, entry);
 		return NULL;
 	}

+	hashmap_entry_init(entry, strhash(cmd));
+
 	sigchain_push(SIGPIPE, SIG_IGN);

 	err = packet_write_list(process->in, "git-filter-client", "version=2", NULL);
@@ -635,24 +662,6 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 	return entry;
 }

-static void read_multi_file_filter_status(int fd, struct strbuf *status) {
-	struct strbuf **pair;
-	char *line;
-	for (;;) {
-		line = packet_read_line(fd, NULL);
-		if (!line)
-			break;
-		pair = strbuf_split_str(line, '=', 2);
-		if (pair[0] && pair[0]->len && pair[1]) {
-			if (!strcmp(pair[0]->buf, "status=")) {
-				strbuf_reset(status);
-				strbuf_addbuf(status, pair[1]);
-			}
-		}
-		strbuf_list_free(pair);
-	}
-}
-
 static int apply_multi_file_filter(const char *path, const char *src, size_t len,
 				   int fd, struct strbuf *dst, const char *cmd,
 				   const unsigned int wanted_capability)
@@ -660,10 +669,9 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	int err;
 	struct cmd2process *entry;
 	struct child_process *process;
-	struct stat file_stat;
 	struct strbuf nbuf = STRBUF_INIT;
 	struct strbuf filter_status = STRBUF_INIT;
-	char *filter_type;
+	const char *filter_type;

 	if (!cmd_process_map_initialized) {
 		cmd_process_map_initialized = 1;
@@ -692,12 +700,6 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	else
 		die("unexpected filter type");

-	if (fd >= 0 && !src) {
-		if (fstat(fd, &file_stat) == -1)
-			return 0;
-		len = xsize_t(file_stat.st_size);
-	}
-
 	sigchain_push(SIGPIPE, SIG_IGN);

 	assert(strlen(filter_type) < LARGE_PACKET_DATA_MAX - strlen("command=\n"));
diff --git a/pkt-line.c b/pkt-line.c
index b82aaca..0b5125f 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -174,12 +174,13 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
 static int packet_write_gently(const int fd_out, const char *buf, size_t size)
 {
 	static char packet_write_buffer[LARGE_PACKET_MAX];
-	const size_t packet_size = size + 4;
+	size_t packet_size;

-	if (packet_size > sizeof(packet_write_buffer))
+	if (size > sizeof(packet_write_buffer) - 4)
 		return error("packet write failed - data exceeds max packet size");

 	packet_trace(buf, size, 1);
+	packet_size = size + 4;
 	set_packet_header(packet_write_buffer, packet_size);
 	memcpy(packet_write_buffer + 4, buf, size);
 	if (write_in_full(fd_out, packet_write_buffer, packet_size) == packet_size)
@@ -217,14 +218,13 @@ int write_packetized_from_fd(int fd_in, int fd_out)

 int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
 {
-	static char buf[LARGE_PACKET_DATA_MAX];
 	int err = 0;
 	size_t bytes_written = 0;
 	size_t bytes_to_write;

 	while (!err) {
-		if ((len - bytes_written) > sizeof(buf))
-			bytes_to_write = sizeof(buf);
+		if ((len - bytes_written) > LARGE_PACKET_DATA_MAX)
+			bytes_to_write = LARGE_PACKET_DATA_MAX;
 		else
 			bytes_to_write = len - bytes_written;
 		if (bytes_to_write == 0)
diff --git a/run-command.c b/run-command.c
index 96c54fe..e5fd6ff 100644
--- a/run-command.c
+++ b/run-command.c
@@ -21,9 +21,7 @@ void child_process_clear(struct child_process *child)

 struct child_to_clean {
 	pid_t pid;
-	char *name;
-	int stdin;
-	int wait;
+	struct child_process *process;
 	struct child_to_clean *next;
 };
 static struct child_to_clean *children_to_clean;
@@ -31,35 +29,23 @@ static int installed_child_cleanup_handler;

 static void cleanup_children(int sig, int in_signal)
 {
-	int status;
-	struct child_to_clean *p = children_to_clean;
-
-	/* Close the the child's stdin as indicator that Git will exit soon */
-	while (p) {
-		if (p->wait)
-			if (p->stdin > 0)
-				close(p->stdin);
-		p = p->next;
-	}
-
 	while (children_to_clean) {
-		p = children_to_clean;
+		struct child_to_clean *p = children_to_clean;
 		children_to_clean = p->next;

-		if (p->wait) {
-			fprintf(stderr, _("Waiting for '%s' to finish..."), p->name);
-			while ((waitpid(p->pid, &status, 0)) < 0 && errno == EINTR)
-				;	/* nothing */
-			fprintf(stderr, _("done!\n"));
+		if (p->process && !in_signal) {
+			struct child_process *process = p->process;
+			if (process->clean_on_exit_handler) {
+				trace_printf("trace: run_command: running exit handler for pid %d", p->pid);
+				process->clean_on_exit_handler(process);
+			}
 		}

 		kill(p->pid, sig);
-		if (!in_signal) {
-			free(p->name);
+		if (!in_signal)
 			free(p);
 	}
 }
-}

 static void cleanup_children_on_signal(int sig)
 {
@@ -73,16 +59,11 @@ static void cleanup_children_on_exit(void)
 	cleanup_children(SIGTERM, 0);
 }

-static void mark_child_for_cleanup(pid_t pid, const char *name, int stdin, int wait)
+static void mark_child_for_cleanup(pid_t pid, struct child_process *process)
 {
 	struct child_to_clean *p = xmalloc(sizeof(*p));
 	p->pid = pid;
-	p->wait = wait;
-	p->stdin = stdin;
-	if (name)
-		p->name = xstrdup(name);
-	else
-		p->name = "process";
+	p->process = process;
 	p->next = children_to_clean;
 	children_to_clean = p;

@@ -93,13 +74,6 @@ static void mark_child_for_cleanup(pid_t pid, const char *name, int stdin, int w
 	}
 }

-#ifdef NO_PTHREADS
-static void mark_child_for_cleanup_no_wait(pid_t pid, const char *name, int timeout, int stdin)
-{
-	mark_child_for_cleanup(pid, NULL, 0, 0);
-}
-#endif
-
 static void clear_child_for_cleanup(pid_t pid)
 {
 	struct child_to_clean **pp;
@@ -458,9 +432,8 @@ int start_command(struct child_process *cmd)
 	}
 	if (cmd->pid < 0)
 		error_errno("cannot fork() for %s", cmd->argv[0]);
-	else if (cmd->clean_on_exit || cmd->wait_on_exit)
-		mark_child_for_cleanup(
-			cmd->pid, cmd->argv[0], cmd->in, cmd->wait_on_exit);
+	else if (cmd->clean_on_exit)
+		mark_child_for_cleanup(cmd->pid, cmd);

 	/*
 	 * Wait for child's execvp. If the execvp succeeds (or if fork()
@@ -520,9 +493,8 @@ int start_command(struct child_process *cmd)
 	failed_errno = errno;
 	if (cmd->pid < 0 && (!cmd->silent_exec_failure || errno != ENOENT))
 		error_errno("cannot spawn %s", cmd->argv[0]);
-	if ((cmd->clean_on_exit || cmd->wait_on_exit) && cmd->pid >= 0)
-		mark_child_for_cleanup(
-			cmd->pid, cmd->argv[0], cmd->in, cmd->clean_on_exit_timeout);
+	if (cmd->clean_on_exit && cmd->pid >= 0)
+		mark_child_for_cleanup(cmd->pid, cmd);

 	argv_array_clear(&nargv);
 	cmd->argv = sargv;
@@ -804,7 +776,7 @@ int start_async(struct async *async)
 		exit(!!async->proc(proc_in, proc_out, async->data));
 	}

-	mark_child_for_cleanup_no_wait(async->pid);
+	mark_child_for_cleanup(async->pid, NULL);

 	if (need_in)
 		close(fdin[0]);
diff --git a/run-command.h b/run-command.h
index f7b9907..dd1c78c 100644
--- a/run-command.h
+++ b/run-command.h
@@ -42,10 +42,9 @@ struct child_process {
 	unsigned silent_exec_failure:1;
 	unsigned stdout_to_stderr:1;
 	unsigned use_shell:1;
-	 /* kill the child on Git exit */
 	unsigned clean_on_exit:1;
-	/* close the child's stdin on Git exit and wait until it terminates */
-	unsigned wait_on_exit:1;
+	void (*clean_on_exit_handler)(struct child_process *process);
+	void *clean_on_exit_handler_cbdata;
 };

 #define CHILD_PROCESS_INIT { NULL, ARGV_ARRAY_INIT, ARGV_ARRAY_INIT }
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 52b7fe9..9f892c0 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -28,9 +28,7 @@ file_size () {
 filter_git () {
 	rm -f rot13-filter.log &&
 	git "$@" 2>git-stderr.log &&
-	sed '/Waiting for/d' git-stderr.log >git-stderr-clean.log &&
-	test_must_be_empty git-stderr-clean.log &&
-	rm -f git-stderr.log git-stderr-clean.log
+	rm -f git-stderr.log
 }

 # Count unique lines in two files and compare them.
@@ -668,7 +666,7 @@ test_expect_success PERL 'process filter should not be restarted if it signals a
 	)
 '

-test_expect_success PERL 'process filter signals abort once to abort processing of all future files' '
+test_expect_success PERL 'process filter abort stops processing of all further files' '
 	test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
 	rm -rf repo &&
 	mkdir repo &&
@@ -688,6 +686,8 @@ test_expect_success PERL 'process filter signals abort once to abort processing
 		git add . &&
 		rm -f *.r &&

+		# Note: This test assumes that Git filters files in alphabetical
+		# order ("abort.r" before "test.r").
 		filter_git checkout --quiet --no-progress . &&
 		cat >expected.log <<-EOF &&
 			START

--
2.10.0

