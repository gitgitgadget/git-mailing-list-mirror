Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BC7C2098B
	for <e@80x24.org>; Sun, 16 Oct 2016 23:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754888AbcJPXUp (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 19:20:45 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36218 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752517AbcJPXUo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 19:20:44 -0400
Received: by mail-pa0-f65.google.com with SMTP id os4so4454112pac.3
        for <git@vger.kernel.org>; Sun, 16 Oct 2016 16:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=GUKKtS+Z0to/BNbf+Hx44oL49eZHrVnSBCKZgUBLsTI=;
        b=V6xBLqhTOPr3PKqqw0BKmZ7+aIoISpZHngHXkoCwSL2DUXF0mMz7Z7hssnjtS0WFdp
         S/3wfAOFeWLJftxqPkML6rnlpmXNR8h0MSunXKuZlagOUDBYsQSl9pKeY7sU/7cwgqd+
         p5SLIavRAYO5g3OwAN6HZAsUrYkbH73ANZniGj/rldfyuVQ0YhLCCnsvAjhiNfVIVbCi
         ngLhyTFFp5IC+EOCNcOe50Vr5kG1dImZmfBfhC+hR8mAWdjysOWhDlnFrE92/pvlK+gu
         QIIfn/8B89A9Cb8YgciA87y1yZLkPu+mScEI39qkFXrdNLwYzcZraSoN9otlRQ71QYAT
         2w8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GUKKtS+Z0to/BNbf+Hx44oL49eZHrVnSBCKZgUBLsTI=;
        b=Ic6L79BeoRaKLefR5ZUgPyrsB0WKZblt27HPS0qfuOQHKhaNIxGzswOQ0KlBybJtDA
         rNg9ENIffKIknKd3ZlYNUOUsfRPbNJNwZ27Wf31ZsV8NtAvgU+MHnjnI03F00GPJHj9L
         3TR5T4ObAHNO1iNg/fzY1YRv2Sn0b3jZqg0yyMfYGDZlpqlCGUL0tueYv6/W1cmS012L
         279eT0Ep/tGfvQ1cKWMCPFx823FGUHD3hB9igA09ejqXk4FCX/MkV0JcneJjkg++5ATB
         2g2S6Io0os1MNDsDrtY5LTagzS0aNpZg/vMrBbUlGPUUKCeE4GmEf3r+jy0hELrfiBcT
         VRAA==
X-Gm-Message-State: AA6/9Rnr7s2u/8VoKb3GSkmE7Lqsva4iFNqZeVq19cbXus4yJZJ1CmuaRsShJW+1WyRB0A==
X-Received: by 10.66.87.131 with SMTP id ay3mr27962756pab.193.1476660042988;
        Sun, 16 Oct 2016 16:20:42 -0700 (PDT)
Received: from rem3n8pj12.ads.autodesk.com (adsk-nat-ip4.autodesk.com. [132.188.71.4])
        by smtp.gmail.com with ESMTPSA id cp2sm10325691pad.3.2016.10.16.16.20.40
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 16 Oct 2016 16:20:41 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jnareb@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, tboegi@web.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v11 00/14] Git filter protocol
Date:   Sun, 16 Oct 2016 16:20:24 -0700
Message-Id: <20161016232038.84951-1-larsxschneider@gmail.com>
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
https://github.com/larsxschneider/git/pull/15

Patches 1 and 2 are cleanups and not strictly necessary for the series.
Patches 3 to 12 are required preparation. Patch 13 is the main patch.
Patch 14 adds an example how to use the Git filter protocol in contrib.

Thanks a lot to
 Jakub, Junio, Ramsay, Dscho, Torsten and Peff
for very helpful reviews,
Lars

## Changes since v10
  * clarify documentation (Jakub)
  * change "<capability>=true" to "capability=<capability>" in protocol (Jakub)
  * make stop_multi_file_filter() static (Ramsay)
  * add flush packet after version negotiation for consistency (Jakub)
  * fix pid_t translation error on Windows (Dscho)
  * fix Unquoted references in tests (Junio)
  * remove smudge invocation count in tests (Junio)


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

 Documentation/gitattributes.txt        | 157 ++++++++++-
 builtin/archive.c                      |   4 +-
 builtin/receive-pack.c                 |   4 +-
 builtin/remote-ext.c                   |   4 +-
 builtin/upload-archive.c               |   4 +-
 connect.c                              |   2 +-
 contrib/long-running-filter/example.pl | 128 +++++++++
 convert.c                              | 375 +++++++++++++++++++++---
 daemon.c                               |   2 +-
 http-backend.c                         |   2 +-
 pkt-line.c                             | 152 +++++++++-
 pkt-line.h                             |  12 +-
 run-command.c                          |  39 ++-
 run-command.h                          |   4 +-
 shallow.c                              |   2 +-
 t/t0021-conversion.sh                  | 502 ++++++++++++++++++++++++++++++---
 t/t0021/rot13-filter.pl                | 192 +++++++++++++
 upload-pack.c                          |  30 +-
 write_or_die.c                         |  13 -
 19 files changed, 1495 insertions(+), 133 deletions(-)
 create mode 100755 contrib/long-running-filter/example.pl
 create mode 100755 t/t0021/rot13-filter.pl



## Interdiff (v10..v11)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index a182ef2..976243a 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -297,9 +297,11 @@ upon checkin. By default these commands process only a single
 blob and terminate. If a long running `process` filter is used
 in place of `clean` and/or `smudge` filters, then Git can process
 all blobs with a single filter command invocation for the entire
-life of a single Git command, for example `git add --all`.  See
-section below for the description of the protocol used to
-communicate with a `process` filter.
+life of a single Git command, for example `git add --all`. If a
+long running `process` filter is configured then it always takes
+precedence over a configured single blob filter. See section
+below for the description of the protocol used to communicate with
+a `process` filter.

 One use of the content filtering is to massage the content into a shape
 that is more convenient for the platform, filesystem, and the user to use.
@@ -393,10 +395,10 @@ text and therefore are terminated by a LF.

 Git starts the filter when it encounters the first file
 that needs to be cleaned or smudged. After the filter started
-Git sends a welcome message ("git-filter-client"), a list of
-supported protocol version numbers, and a flush packet. Git expects
-to read a welcome response message ("git-filter-server") and exactly
-one protocol version number from the previously sent list. All further
+Git sends a welcome message ("git-filter-client"), a list of supported
+protocol version numbers, and a flush packet. Git expects to read a welcome
+response message ("git-filter-server"), exactly one protocol version number
+from the previously sent list, and a flush packet. All further
 communication will be based on the selected version. The remaining
 protocol description below documents "version=2". Please note that
 "version=42" in the example below does not exist and is only there
@@ -414,12 +416,13 @@ packet:          git> version=42
 packet:          git> 0000
 packet:          git< git-filter-server
 packet:          git< version=2
-packet:          git> clean=true
-packet:          git> smudge=true
-packet:          git> not-yet-invented=true
+packet:          git< 0000
+packet:          git> capability=clean
+packet:          git> capability=smudge
+packet:          git> capability=not-yet-invented
 packet:          git> 0000
-packet:          git< clean=true
-packet:          git< smudge=true
+packet:          git< capability=clean
+packet:          git< capability=smudge
 packet:          git< 0000
 ------------------------
 Supported filter capabilities in version 2 are "clean" and
@@ -428,7 +431,7 @@ Supported filter capabilities in version 2 are "clean" and
 Afterwards Git sends a list of "key=value" pairs terminated with
 a flush packet. The list will contain at least the filter command
 (based on the supported capabilities) and the pathname of the file
-to filter relative to the repository root. Right after these packets
+to filter relative to the repository root. Right after the flush packet
 Git sends the content split in zero or more pkt-line packets and a
 flush packet to terminate content. Please note, that the filter
 must not send any response before it received the content and the
@@ -447,7 +450,10 @@ problems then the list must contain a "success" status. Right after
 these packets the filter is expected to send the content in zero
 or more pkt-line packets and a flush packet at the end. Finally, a
 second list of "key=value" pairs terminated with a flush packet
-is expected. The filter can change the status in the second list.
+is expected. The filter can change the status in the second list
+or keep the status as is with an empty list. Please note that the
+empty list must be terminated with a flush packet regardless.
+
 ------------------------
 packet:          git< status=success
 packet:          git< 0000
@@ -457,7 +463,7 @@ packet:          git< 0000  # empty list, keep "status=success" unchanged!
 ------------------------

 If the result content is empty then the filter is expected to respond
-with a "success" status and an empty list.
+with a "success" status and a flush packet to signal the empty content.
 ------------------------
 packet:          git< status=success
 packet:          git< 0000
@@ -466,9 +472,7 @@ packet:          git< 0000  # empty list, keep "status=success" unchanged!
 ------------------------

 In case the filter cannot or does not want to process the content,
-it is expected to respond with an "error" status. Depending on the
-`filter.<driver>.required` flag Git will interpret that as error
-but it will not stop or restart the filter process.
+it is expected to respond with an "error" status.
 ------------------------
 packet:          git< status=error
 packet:          git< 0000
@@ -476,9 +480,7 @@ packet:          git< 0000

 If the filter experiences an error during processing, then it can
 send the status "error" after the content was (partially or
-completely) sent. Depending on the `filter.<driver>.required` flag
-Git will interpret that as error but it will not stop or restart the
-filter process.
+completely) sent.
 ------------------------
 packet:          git< status=success
 packet:          git< 0000
@@ -488,31 +490,31 @@ packet:          git< status=error
 packet:          git< 0000
 ------------------------

-If the filter dies during the communication or does not adhere to
-the protocol then Git will stop the filter process and restart it
-with the next file that needs to be processed. Depending on the
-`filter.<driver>.required` flag Git will interpret that as error.
-
-The error handling for all cases above mimic the behavior of
-the `filter.<driver>.clean` / `filter.<driver>.smudge` error
-handling.
-
 In case the filter cannot or does not want to process the content
 as well as any future content for the lifetime of the Git process,
-it is expected to respond with an "abort" status at any point in
-the protocol. Depending on the `filter.<driver>.required` flag Git
-will interpret that as error for the content as well as any future
-content for the lifetime of the Git process but it will not stop or
-restart the filter process.
+then it is expected to respond with an "abort" status at any point
+in the protocol.
 ------------------------
 packet:          git< status=abort
 packet:          git< 0000
 ------------------------

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
 After the filter has processed a blob it is expected to wait for
 the next "key=value" list containing a command. Git will close
 the command pipe on exit. The filter is expected to detect EOF
-and exit gracefully on its own.
+and exit gracefully on its own. Git will wait until the filter
+process has stopped.

 A long running filter demo implementation can be found in
 `contrib/long-running-filter/example.pl` located in the Git
@@ -520,10 +522,6 @@ core repository. If you develop your own long running filter
 process then the `GIT_TRACE_PACKET` environment variables can be
 very helpful for debugging (see linkgit:git[1]).

-If a `filter.<driver>.process` command is configured then it
-always takes precedence over a configured `filter.<driver>.clean`
-or `filter.<driver>.smudge` command.
-
 Please note that you cannot use an existing `filter.<driver>.clean`
 or `filter.<driver>.smudge` command with `filter.<driver>.process`
 because the former two use a different inter process communication
diff --git a/contrib/long-running-filter/example.pl b/contrib/long-running-filter/example.pl
index f4102d2..3945705 100755
--- a/contrib/long-running-filter/example.pl
+++ b/contrib/long-running-filter/example.pl
@@ -70,13 +70,14 @@ sub packet_flush {

 packet_txt_write("git-filter-server");
 packet_txt_write("version=2");
+packet_flush();

-( packet_txt_read() eq ( 0, "clean=true" ) )  || die "bad capability";
-( packet_txt_read() eq ( 0, "smudge=true" ) ) || die "bad capability";
+( packet_txt_read() eq ( 0, "capability=clean" ) )  || die "bad capability";
+( packet_txt_read() eq ( 0, "capability=smudge" ) ) || die "bad capability";
 ( packet_bin_read() eq ( 1, "" ) )                  || die "bad capability end";

-packet_txt_write("clean=true");
-packet_txt_write("smudge=true");
+packet_txt_write("capability=clean");
+packet_txt_write("capability=smudge");
 packet_flush();

 while (1) {
diff --git a/convert.c b/convert.c
index 1d89632..9d2aa68 100644
--- a/convert.c
+++ b/convert.c
@@ -567,7 +567,7 @@ static void kill_multi_file_filter(struct hashmap *hashmap, struct cmd2process *
 	free(entry);
 }

-void stop_multi_file_filter(struct child_process *process)
+static void stop_multi_file_filter(struct child_process *process)
 {
 	sigchain_push(SIGPIPE, SIG_IGN);
 	/* Closing the pipe signals the filter to initiate a shutdown. */
@@ -622,8 +622,11 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 	err = strcmp(packet_read_line(process->out, NULL), "version=2");
 	if (err)
 		goto done;
+	err = packet_read_line(process->out, NULL) != NULL;
+	if (err)
+		goto done;

-	err = packet_write_list(process->in, "clean=true", "smudge=true", NULL);
+	err = packet_write_list(process->in, "capability=clean", "capability=smudge", NULL);

 	for (;;) {
 		cap_buf = packet_read_line(process->out, NULL);
@@ -631,10 +634,10 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 			break;
 		string_list_split_in_place(&cap_list, cap_buf, '=', 1);

-		if (cap_list.nr != 2 || strcmp(cap_list.items[1].string, "true"))
+		if (cap_list.nr != 2 || strcmp(cap_list.items[0].string, "capability"))
 			continue;

-		cap_name = cap_list.items[0].string;
+		cap_name = cap_list.items[1].string;
 		if (!strcmp(cap_name, "clean")) {
 			entry->supported_capabilities |= CAP_CLEAN;
 		} else if (!strcmp(cap_name, "smudge")) {
diff --git a/run-command.c b/run-command.c
index e5fd6ff..ca905a9 100644
--- a/run-command.c
+++ b/run-command.c
@@ -36,7 +36,10 @@ static void cleanup_children(int sig, int in_signal)
 		if (p->process && !in_signal) {
 			struct child_process *process = p->process;
 			if (process->clean_on_exit_handler) {
-				trace_printf("trace: run_command: running exit handler for pid %d", p->pid);
+				trace_printf(
+					"trace: run_command: running exit handler for pid %"
+					PRIuMAX, (uintmax_t)p->pid
+				);
 				process->clean_on_exit_handler(process);
 			}
 		}
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 9f892c0..a20b9f5 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -31,38 +31,35 @@ filter_git () {
 	rm -f git-stderr.log
 }

-# Count unique lines in two files and compare them.
-test_cmp_count () {
-	for FILE in $@
-	do
-		sort $FILE | uniq -c | sed "s/^[ ]*//" >$FILE.tmp
-		cat $FILE.tmp >$FILE
-	done &&
-	test_cmp $@
-}
-
-# Count unique lines except clean invocations in two files and compare
-# them. Clean invocations are not counted because their number can vary.
+# Compare two files and ensure that `clean` and `smudge` respectively are
+# called at least once if specified in the `expect` file. The actual
+# invocation count is not relevant because their number can vary.
 # c.f. http://public-inbox.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
-test_cmp_count_except_clean () {
-	for FILE in $@
+test_cmp_count () {
+	expect=$1
+	actual=$2
+	for FILE in "$expect" "$actual"
 	do
-		sort $FILE | uniq -c | sed "s/^[ ]*//" |
-			sed "s/^\([0-9]\) IN: clean/x IN: clean/" >$FILE.tmp
-		cat $FILE.tmp >$FILE
+		sort "$FILE" | uniq -c | sed "s/^[ ]*//" |
+			sed "s/^\([0-9]\) IN: clean/x IN: clean/" |
+			sed "s/^\([0-9]\) IN: smudge/x IN: smudge/" >"$FILE.tmp" &&
+		mv "$FILE.tmp" "$FILE"
 	done &&
-	test_cmp $@
+	test_cmp "$expect" "$actual"
 }

-# Compare two files but exclude clean invocations because they can vary.
+# Compare two files but exclude all `clean` invocations because Git can
+# call `clean` zero or more times.
 # c.f. http://public-inbox.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
 test_cmp_exclude_clean () {
-	for FILE in $@
+	expect=$1
+	actual=$2
+	for FILE in "$expect" "$actual"
 	do
-		grep -v "IN: clean" $FILE >$FILE.tmp
-		cat $FILE.tmp >$FILE
+		grep -v "IN: clean" "$FILE" >"$FILE.tmp" &&
+		mv "$FILE.tmp" "$FILE"
 	done &&
-	test_cmp $@
+	test_cmp "$expect" "$actual"
 }

 # Check that the contents of two files are equal and that their rot13 version
@@ -395,7 +392,7 @@ test_expect_success PERL 'required process filter should filter data' '
 			IN: clean testsubdir/test3 '\''sq'\'',\$x.r $S3 [OK] -- OUT: $S3 . [OK]
 			STOP
 		EOF
-		test_cmp_count_except_clean expected.log rot13-filter.log &&
+		test_cmp_count expected.log rot13-filter.log &&

 		rm -f test2.r "testsubdir/test3 '\''sq'\'',\$x.r" &&

diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 1a6959c..ae4c50f 100755
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -95,13 +95,14 @@ $debug->flush();

 packet_txt_write("git-filter-server");
 packet_txt_write("version=2");
+packet_flush();

-( packet_txt_read() eq ( 0, "clean=true" ) )  || die "bad capability";
-( packet_txt_read() eq ( 0, "smudge=true" ) ) || die "bad capability";
+( packet_txt_read() eq ( 0, "capability=clean" ) )  || die "bad capability";
+( packet_txt_read() eq ( 0, "capability=smudge" ) ) || die "bad capability";
 ( packet_bin_read() eq ( 1, "" ) )                  || die "bad capability end";

 foreach (@capabilities) {
-	packet_txt_write( $_ . "=true" );
+	packet_txt_write( "capability=" . $_ );
 }
 packet_flush();
 print $debug "init handshake complete\n";

--
2.10.0

