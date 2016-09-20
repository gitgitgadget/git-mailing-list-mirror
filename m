Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A663209A9
	for <e@80x24.org>; Tue, 20 Sep 2016 19:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932830AbcITTCy (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 15:02:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36402 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932536AbcITTCw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 15:02:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id b184so4912704wma.3
        for <git@vger.kernel.org>; Tue, 20 Sep 2016 12:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=DiWNeAOJrY3f3rHCSXj5EAfRiVsbb23aTFf45fdrXs0=;
        b=ECBC1KVgLtH+FFqrRd05ZXh1o01o06bOmVEb7Z9tf2eH+WSqnVp60Hl2g4Py+erG9j
         wcX5IPlgsl/tSpnGy0/2x8t30sZwMrVLIGxbwyl4LBkmmi832RG+QsNwuelKjsIJQYG8
         1paIzmZAMeIBI/Y7wx8gtEyGT+d2kfZ7t0bSaHEUEXaS/bwIqLapvQ59Q+baUb92HyIO
         mW79eBrVlFiXAzbAwGTYg2IoFKFkUu1CnZyPFp8uNmmJMm/dXtIGrwCOAcGT+5PzMYbC
         37TasGhQTyc25IjYul0fpNkYVHt5xKYoNWEIu5c3/bouJvUZbzJzoWIG17D6s9SRnHE3
         cE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DiWNeAOJrY3f3rHCSXj5EAfRiVsbb23aTFf45fdrXs0=;
        b=PchVQ2oqHzQOZX3RYnKQdBUmSBqf+lCIKNCaXqN5QVSGoQUDTBLFFfaDvUU5u4BU4i
         DQeg5RLIlElwaF9+ChYA0v0y91aoBgdFEFIfQf2FgT/wp7U7yTas78sgHbU7gfl3zCYa
         LsR2jHEklJYizrnSpVddqweP4MKnG1qVNWbH1VN1pseMT/Fk2Qakw8UHiXHnxfA6s3qf
         3YenySas9vNarsSafnMsTRxX8zKQ+EEVsBS8FdbLSCgTrB0HRGKcHzBDrKMchugXiJWz
         uClvffg40wH4vxtTHBq64aAsN/xUNGw6LLc47Q9+Z12cvtuVD944wzNLHBGfNGr7s/a6
         d8Tw==
X-Gm-Message-State: AE9vXwN0nHrpgNvRuv/q7PE2pSEyQ0sr1Zp9DrVe/yAga1jw97aSDiZKYFizGTz5uLCJeg==
X-Received: by 10.194.21.200 with SMTP id x8mr29978716wje.129.1474398170375;
        Tue, 20 Sep 2016 12:02:50 -0700 (PDT)
Received: from slxBook4.fritz.box (p508BA5EF.dip0.t-ipconnect.de. [80.139.165.239])
        by smtp.gmail.com with ESMTPSA id gg10sm29820728wjd.4.2016.09.20.12.02.48
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 20 Sep 2016 12:02:49 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        jnareb@gmail.com, mlbright@gmail.com, tboegi@web.de,
        ramsay@ramsayjones.plus.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v8 00/11] Git filter protocol
Date:   Tue, 20 Sep 2016 21:02:36 +0200
Message-Id: <20160920190247.82189-1-larsxschneider@gmail.com>
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
https://github.com/larsxschneider/git/pull/12

Thanks a lot to
  Stefan, Torsten, Junio, Jeff, and Ramsay
for very helpful reviews,
Lars



## Major changes since v7

* explicitly define all packets as text packets terminated by an LF (except CONTENT and flush)
* move check_pipe() from write_or_die to run_command and reuse it



## All changes since v7

### Stefan

* http://public-inbox.org/git/CAGZ79kY0GaWuuh_MzKL6FZ7KWF2Kwhfh9qnEYd-qX8VDQWNmCQ@mail.gmail.com/
    * move check_pipe() from write_or_die to run_command and reuse it
    * use error() (== -1) as return value

* http://public-inbox.org/git/CAGZ79kZdroDdD5SHP+-9svSTYbJfn2vsFXAwC4aen3hMVEOOPA@mail.gmail.com/
    * remove verbose return value explanation in commit messages
    * on "packet_flush_gently" introduction, mention that the function is used later


### Torsten

* http://public-inbox.org/git/20160910164056.GA14646@tb-raspi/
    * remove unnecessary parenthesis


* http://public-inbox.org/git/20160910062919.GB11001@tb-raspi/
    * explicitly define all packets as text packets terminated by an LF (except CONTENT and flush)



### Junio

* http://public-inbox.org/git/xmqq8tuvx1sz.fsf@gitster.mtv.corp.google.com/
    * fix SP in Perl script
    * use `unsigned int` for CAP_CLEAN and CAP_SMUDGE
    * fix pointer notation
    * remove invalid "convert.h" include


### Ramsay

* http://public-inbox.org/git/6373d68b-574d-59f3-7b8d-60dd3a673806@ramsayjones.plus.com
    * declare packet_write_gently() static


### Lars
* add SP in paths for test case
* fix "{" code formatting



## Interdiff (v7..v8)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index ac000ea..946dcad 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -385,9 +385,11 @@ Long Running Filter Process
 If the filter command (a string value) is defined via
 `filter.<driver>.process` then Git can process all blobs with a
 single filter invocation for the entire life of a single Git
-command. This is achieved by using the following packet format
-(pkt-line, see technical/protocol-common.txt) based protocol over
-standard input and standard output.
+command. This is achieved by using a packet format (pkt-line,
+see technical/protocol-common.txt) based protocol over standard
+input and standard output as follows. All packets are considered
+text and therefore are terminated by an LF. Exceptions are the
+"*CONTENT" packets and the flush packet.

 Git starts the filter when it encounters the first file
 that needs to be cleaned or smudged. After the filter started
@@ -430,8 +432,8 @@ to filter relative to the repository root. Right after these packets
 Git sends the content split in zero or more pkt-line packets and a
 flush packet to terminate content.
 ------------------------
-packet:          git> command=smudge\n
-packet:          git> pathname=path/testfile.dat\n
+packet:          git> command=smudge
+packet:          git> pathname=path/testfile.dat
 packet:          git> 0000
 packet:          git> CONTENT
 packet:          git> 0000
@@ -445,7 +447,7 @@ or more pkt-line packets and a flush packet at the end. Finally, a
 second list of "key=value" pairs terminated with a flush packet
 is expected. The filter can change the status in the second list.
 ------------------------
-packet:          git< status=success\n
+packet:          git< status=success
 packet:          git< 0000
 packet:          git< SMUDGED_CONTENT
 packet:          git< 0000
@@ -455,7 +457,7 @@ packet:          git< 0000  # empty list!
 If the result content is empty then the filter is expected to respond
 with a success status and an empty list.
 ------------------------
-packet:          git< status=success\n
+packet:          git< status=success
 packet:          git< 0000
 packet:          git< 0000  # empty content!
 packet:          git< 0000  # empty list!
@@ -466,7 +468,7 @@ it is expected to respond with an "error" status. Depending on the
 `filter.<driver>.required` flag Git will interpret that as error
 but it will not stop or restart the filter process.
 ------------------------
-packet:          git< status=error\n
+packet:          git< status=error
 packet:          git< 0000
 ------------------------

@@ -476,11 +478,11 @@ completely) sent. Depending on the `filter.<driver>.required` flag
 Git will interpret that as error but it will not stop or restart the
 filter process.
 ------------------------
-packet:          git< status=success\n
+packet:          git< status=success
 packet:          git< 0000
 packet:          git< HALF_WRITTEN_ERRONEOUS_CONTENT
 packet:          git< 0000
-packet:          git< status=error\n
+packet:          git< status=error
 packet:          git< 0000
 ------------------------

@@ -500,7 +502,7 @@ the `filter.<driver>.required` flag Git will interpret that as error
 for the content as well as any future content for the lifetime of the
 Git process but it will not stop or restart the filter process.
 ------------------------
-packet:          git< status=abort\n
+packet:          git< status=abort
 packet:          git< 0000
 ------------------------

@@ -510,8 +512,8 @@ the command pipe on exit. The filter is expected to detect EOF
 and exit gracefully on its own.

 A long running filter demo implementation can be found in
-`contrib/long-running-filter/example.pl` located in the Git
-core repository. If you develop your own long running filter
+`contrib/long-running-filter/example.pl` located in the Git
+core repository. If you develop your own long running filter
 process then the `GIT_TRACE_PACKET` environment variables can be
 very helpful for debugging (see linkgit:git[1]).

diff --git a/contrib/long-running-filter/example.pl b/contrib/long-running-filter/example.pl
index 279fbfb..c13a631 100755
--- a/contrib/long-running-filter/example.pl
+++ b/contrib/long-running-filter/example.pl
@@ -9,7 +9,7 @@ use warnings;

 my $MAX_PACKET_CONTENT_SIZE = 65516;

-sub packet_read {
+sub packet_bin_read {
     my $buffer;
     my $bytes_read = read STDIN, $buffer, 4;
     if ( $bytes_read == 0 ) {
@@ -37,38 +37,50 @@ sub packet_read {
     }
 }

-sub packet_write {
+sub packet_txt_read {
+    my ( $res, $buf ) = packet_bin_read();
+    unless ( $buf =~ /\n$/ ) {
+        die "A non-binary line SHOULD BE terminated by an LF.";
+    }
+    return ( $res, substr( $buf, 0, -1 ) );
+}
+
+sub packet_bin_write {
     my ($packet) = @_;
     print STDOUT sprintf( "%04x", length($packet) + 4 );
     print STDOUT $packet;
     STDOUT->flush();
 }

+sub packet_txt_write {
+    packet_bin_write( $_[0] . "\n" );
+}
+
 sub packet_flush {
     print STDOUT sprintf( "%04x", 0 );
     STDOUT->flush();
 }

-( packet_read() eq ( 0, "git-filter-client" ) ) || die "bad initialization";
-( packet_read() eq ( 0, "version=2" ) )         || die "bad version";
-( packet_read() eq ( 1, "" ) )                  || die "bad version end";
+( packet_txt_read() eq ( 0, "git-filter-client" ) ) || die "bad initialize";
+( packet_txt_read() eq ( 0, "version=2" ) )         || die "bad version";
+( packet_bin_read() eq ( 1, "" ) )                  || die "bad version end";

-packet_write("git-filter-server\n");
-packet_write("version=2\n");
+packet_txt_write("git-filter-server");
+packet_txt_write("version=2");

-( packet_read() eq ( 0, "clean=true" ) )  || die "bad capability";
-( packet_read() eq ( 0, "smudge=true" ) ) || die "bad capability";
-( packet_read() eq ( 1, "" ) )            || die "bad capability end";
+( packet_txt_read() eq ( 0, "clean=true" ) )  || die "bad capability";
+( packet_txt_read() eq ( 0, "smudge=true" ) ) || die "bad capability";
+( packet_bin_read() eq ( 1, "" ) )            || die "bad capability end";

-packet_write( "clean=true\n" );
-packet_write( "smudge=true\n" );
+packet_txt_write("clean=true");
+packet_txt_write("smudge=true");
 packet_flush();

 while (1) {
-    my ($command) = packet_read() =~ /^command=([^=]+)\n$/;
-    my ($pathname) = packet_read() =~ /^pathname=([^=]+)\n$/;
+    my ($command)  = packet_txt_read() =~ /^command=([^=]+)$/;
+    my ($pathname) = packet_txt_read() =~ /^pathname=([^=]+)$/;

-    packet_read();
+    packet_bin_read();

     my $input = "";
     {
@@ -76,7 +88,7 @@ while (1) {
         my $buffer;
         my $done = 0;
         while ( !$done ) {
-            ( $done, $buffer ) = packet_read();
+            ( $done, $buffer ) = packet_bin_read();
             $input .= $buffer;
         }
     }
@@ -94,11 +106,11 @@ while (1) {
         die "bad command '$command'";
     }

-    packet_write("status=success\n");
+    packet_txt_write("status=success");
     packet_flush();
     while ( length($output) > 0 ) {
         my $packet = substr( $output, 0, $MAX_PACKET_CONTENT_SIZE );
-        packet_write($packet);
+        packet_bin_write($packet);
         if ( length($output) > $MAX_PACKET_CONTENT_SIZE ) {
             $output = substr( $output, $MAX_PACKET_CONTENT_SIZE );
         }
@@ -106,6 +118,6 @@ while (1) {
             $output = "";
         }
     }
-    packet_flush(); # flush content!
-    packet_flush(); # empty list!
+    packet_flush();    # flush content!
+    packet_flush();    # empty list!
 }
diff --git a/convert.c b/convert.c
index 0ed48ed..bd66257 100644
--- a/convert.c
+++ b/convert.c
@@ -472,16 +472,13 @@ static int apply_single_file_filter(const char *path, const char *src, size_t le
    return 0; /* error was already reported */

  if (strbuf_read(&nbuf, async.out, len) < 0) {
-   error("read from external filter '%s' failed", cmd);
-   err = -1;
+   err = error("read from external filter '%s' failed", cmd);
  }
  if (close(async.out)) {
-   error("read from external filter '%s' failed", cmd);
-   err = -1;
+   err = error("read from external filter '%s' failed", cmd);
  }
  if (finish_async(&async)) {
-   error("external filter '%s' failed", cmd);
-   err = -1;
+   err = error("external filter '%s' failed", cmd);
  }

  if (!err) {
@@ -496,7 +493,7 @@ static int apply_single_file_filter(const char *path, const char *src, size_t le

 struct cmd2process {
  struct hashmap_entry ent; /* must be the first member! */
- int supported_capabilities;
+ unsigned int supported_capabilities;
  const char *cmd;
  struct child_process process;
 };
@@ -541,13 +538,12 @@ static int packet_write_list(int fd, const char *line, ...)
  va_list args;
  int err;
  va_start(args, line);
- for (;;)
- {
+ for (;;) {
    if (!line)
      break;
    if (strlen(line) > PKTLINE_DATA_MAXLEN)
      return -1;
-   err = packet_write_fmt_gently(fd, "%s", line);
+   err = packet_write_fmt_gently(fd, "%s\n", line);
    if (err)
      return err;
    line = va_arg(args, const char*);
@@ -601,8 +597,7 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons

  err = packet_write_list(process->in, "clean=true", "smudge=true", NULL);

- for (;;)
- {
+ for (;;) {
    cap_buf = packet_read_line(process->out, NULL);
    if (!cap_buf)
      break;
@@ -658,7 +653,7 @@ static void read_multi_file_filter_values(int fd, struct strbuf *status) {

 static int apply_multi_file_filter(const char *path, const char *src, size_t len,
                                    int fd, struct strbuf *dst, const char *cmd,
-                                   const int wanted_capability)
+                                   const unsigned int wanted_capability)
 {
  int err;
  struct cmd2process *entry;
@@ -703,17 +698,18 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len

  sigchain_push(SIGPIPE, SIG_IGN);

-
- err = (strlen(filter_type) > PKTLINE_DATA_MAXLEN);
+ err = strlen(filter_type) > PKTLINE_DATA_MAXLEN;
  if (err)
    goto done;
+
  err = packet_write_fmt_gently(process->in, "command=%s\n", filter_type);
  if (err)
    goto done;

- err = (strlen(path) > PKTLINE_DATA_MAXLEN);
+ err = strlen(path) > PKTLINE_DATA_MAXLEN;
  if (err)
    goto done;
+
  err = packet_write_fmt_gently(process->in, "pathname=%s\n", path);
  if (err)
    goto done;
@@ -780,9 +776,9 @@ static struct convert_driver {

 static int apply_filter(const char *path, const char *src, size_t len,
                         int fd, struct strbuf *dst, struct convert_driver *drv,
-                        const int wanted_capability)
+                        const unsigned int wanted_capability)
 {
- const char* cmd = NULL;
+ const char *cmd = NULL;

  if (!drv)
    return 0;
diff --git a/pkt-line.c b/pkt-line.c
index 5001a07..a0a8543 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -96,8 +96,7 @@ int packet_flush_gently(int fd)
  packet_trace("0000", 4, 1);
  if (write_in_full(fd, "0000", 4) == 4)
    return 0;
- error("flush packet write failed");
- return -1;
+ return error("flush packet write failed");
 }

 void packet_buf_flush(struct strbuf *buf)
@@ -146,19 +145,10 @@ static int packet_write_fmt_1(int fd, int gently,
    return 0;

  if (!gently) {
-   if (errno == EPIPE) {
-     if (in_async())
-       async_exit(141);
-
-     signal(SIGPIPE, SIG_DFL);
-     raise(SIGPIPE);
-     /* Should never happen, but just in case... */
-     exit(141);
-   }
-   die_errno("packet write error");
+   check_pipe(errno);
+   die_errno("packet write with format failed");
  }
- error("packet write failed");
- return -1;
+ return error("packet write with format failed");
 }

 void packet_write_fmt(int fd, const char *fmt, ...)
@@ -181,13 +171,12 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
  return status;
 }

-int packet_write_gently(const int fd_out, const char *buf, size_t size)
+static int packet_write_gently(const int fd_out, const char *buf, size_t size)
 {
  static char packet_write_buffer[LARGE_PACKET_MAX];

  if (size > sizeof(packet_write_buffer) - 4) {
-   error("packet write failed");
-   return -1;
+   return error("packet write failed - data exceeds max packet size");
  }
  packet_trace(buf, size, 1);
  size += 4;
@@ -195,9 +184,7 @@ int packet_write_gently(const int fd_out, const char *buf, size_t size)
  memcpy(packet_write_buffer + 4, buf, size - 4);
  if (write_in_full(fd_out, packet_write_buffer, size) == size)
    return 0;
-
- error("packet write failed");
- return -1;
+ return error("packet write failed");
 }

 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
diff --git a/run-command.c b/run-command.c
index 5a4dbb6..b72f6d1 100644
--- a/run-command.c
+++ b/run-command.c
@@ -6,6 +6,19 @@
 #include "thread-utils.h"
 #include "strbuf.h"

+void check_pipe(int err)
+{
+ if (err == EPIPE) {
+   if (in_async())
+     async_exit(141);
+
+   signal(SIGPIPE, SIG_DFL);
+   raise(SIGPIPE);
+   /* Should never happen, but just in case... */
+   exit(141);
+ }
+}
+
 void child_process_init(struct child_process *child)
 {
  memset(child, 0, sizeof(*child));
diff --git a/run-command.h b/run-command.h
index 5066649..e7c5f71 100644
--- a/run-command.h
+++ b/run-command.h
@@ -54,6 +54,8 @@ int finish_command(struct child_process *);
 int finish_command_in_signal(struct child_process *);
 int run_command(struct child_process *);

+void check_pipe(int err);
+
 /*
  * Returns the path to the hook file, or NULL if the hook is missing
  * or disabled. Note that this points to static storage that will be
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 1c98ac3..210c4f6 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -34,7 +34,7 @@ test_expect_success setup '
  git checkout -- test test.t test.i &&

  echo "content-test2" >test2.o &&
- echo "content-test3-subdir" >test3-subdir.o
+ echo "content-test3 - subdir" >"test3 - subdir.o"
 '

 script='s/^\$Id: \([0-9a-f]*\) \$/\1/p'
@@ -317,9 +317,9 @@ check_filter_no_call () {
 }

 check_rot13 () {
- test_cmp $1 $2 &&
- ./../rot13.sh <$1 >expected &&
- git cat-file blob :$2 >actual &&
+ test_cmp "$1" "$2" &&
+ ./../rot13.sh <"$1" >expected &&
+ git cat-file blob :"$2" >actual &&
  test_cmp expected actual
 }

@@ -340,7 +340,7 @@ test_expect_success PERL 'required process filter should filter data' '
    cp ../test.o test.r &&
    cp ../test2.o test2.r &&
    mkdir testsubdir &&
-   cp ../test3-subdir.o testsubdir/test3-subdir.r &&
+   cp "../test3 - subdir.o" "testsubdir/test3 - subdir.r" &&
    >test4-empty.r &&

    check_filter \
@@ -349,7 +349,7 @@ test_expect_success PERL 'required process filter should filter data' '
          1 IN: clean test.r 57 [OK] -- OUT: 57 . [OK]
          1 IN: clean test2.r 14 [OK] -- OUT: 14 . [OK]
          1 IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
-         1 IN: clean testsubdir/test3-subdir.r 21 [OK] -- OUT: 21 . [OK]
+         1 IN: clean testsubdir/test3 - subdir.r 23 [OK] -- OUT: 23 . [OK]
          1 START
          1 STOP
          1 wrote filter header
@@ -361,13 +361,13 @@ test_expect_success PERL 'required process filter should filter data' '
          x IN: clean test.r 57 [OK] -- OUT: 57 . [OK]
          x IN: clean test2.r 14 [OK] -- OUT: 14 . [OK]
          x IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
-         x IN: clean testsubdir/test3-subdir.r 21 [OK] -- OUT: 21 . [OK]
+         x IN: clean testsubdir/test3 - subdir.r 23 [OK] -- OUT: 23 . [OK]
          1 START
          1 STOP
          1 wrote filter header
        EOF

-   rm -f test?.r testsubdir/test3-subdir.r &&
+   rm -f test?.r "testsubdir/test3 - subdir.r" &&

    check_filter_ignore_clean \
      git checkout . \
@@ -375,7 +375,7 @@ test_expect_success PERL 'required process filter should filter data' '
          START
          wrote filter header
          IN: smudge test2.r 14 [OK] -- OUT: 14 . [OK]
-         IN: smudge testsubdir/test3-subdir.r 21 [OK] -- OUT: 21 . [OK]
+         IN: smudge testsubdir/test3 - subdir.r 23 [OK] -- OUT: 23 . [OK]
          STOP
        EOF

@@ -395,13 +395,13 @@ test_expect_success PERL 'required process filter should filter data' '
          IN: smudge test.r 57 [OK] -- OUT: 57 . [OK]
          IN: smudge test2.r 14 [OK] -- OUT: 14 . [OK]
          IN: smudge test4-empty.r 0 [OK] -- OUT: 0  [OK]
-         IN: smudge testsubdir/test3-subdir.r 21 [OK] -- OUT: 21 . [OK]
+         IN: smudge testsubdir/test3 - subdir.r 23 [OK] -- OUT: 23 . [OK]
          STOP
        EOF

    check_rot13 ../test.o test.r &&
    check_rot13 ../test2.o test2.r &&
-   check_rot13 ../test3-subdir.o testsubdir/test3-subdir.r
+   check_rot13 "../test3 - subdir.o" "testsubdir/test3 - subdir.r"
  )
 '

diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 8e27877..8958f71 100755
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -34,7 +34,7 @@ sub rot13 {
     return $str;
 }

-sub packet_read {
+sub packet_bin_read {
     my $buffer;
     my $bytes_read = read STDIN, $buffer, 4;
     if ( $bytes_read == 0 ) {
@@ -63,13 +63,25 @@ sub packet_read {
     }
 }

-sub packet_write {
+sub packet_txt_read {
+    my ( $res, $buf ) = packet_bin_read();
+    unless ( $buf =~ /\n$/ ) {
+        die "A non-binary line SHOULD BE terminated by an LF.";
+    }
+    return ( $res, substr( $buf, 0, -1 ) );
+}
+
+sub packet_bin_write {
     my ($packet) = @_;
     print STDOUT sprintf( "%04x", length($packet) + 4 );
     print STDOUT $packet;
     STDOUT->flush();
 }

+sub packet_txt_write {
+    packet_bin_write( $_[0] . "\n" );
+}
+
 sub packet_flush {
     print STDOUT sprintf( "%04x", 0 );
     STDOUT->flush();
@@ -78,35 +90,35 @@ sub packet_flush {
 print $debug "START\n";
 $debug->flush();

-( packet_read() eq ( 0, "git-filter-client" ) ) || die "bad initialization";
-( packet_read() eq ( 0, "version=2" ) )         || die "bad version";
-( packet_read() eq ( 1, "" ) )                  || die "bad version end";
+( packet_txt_read() eq ( 0, "git-filter-client" ) ) || die "bad initialize";
+( packet_txt_read() eq ( 0, "version=2" ) )         || die "bad version";
+( packet_bin_read() eq ( 1, "" ) )                  || die "bad version end";

-packet_write("git-filter-server\n");
-packet_write("version=2\n");
+packet_txt_write("git-filter-server");
+packet_txt_write("version=2");

-( packet_read() eq ( 0, "clean=true" ) )  || die "bad capability";
-( packet_read() eq ( 0, "smudge=true" ) ) || die "bad capability";
-( packet_read() eq ( 1, "" ) )            || die "bad capability end";
+( packet_txt_read() eq ( 0, "clean=true" ) )  || die "bad capability";
+( packet_txt_read() eq ( 0, "smudge=true" ) ) || die "bad capability";
+( packet_bin_read() eq ( 1, "" ) )            || die "bad capability end";

 foreach (@capabilities) {
-    packet_write( $_ . "=true\n" );
+    packet_txt_write( $_ . "=true" );
 }
 packet_flush();
 print $debug "wrote filter header\n";
 $debug->flush();

 while (1) {
-    my ($command) = packet_read() =~ /^command=([^=]+)\n$/;
+    my ($command) = packet_txt_read() =~ /^command=([^=]+)$/;
     print $debug "IN: $command";
     $debug->flush();

-    my ($pathname) = packet_read() =~ /^pathname=([^=]+)\n$/;
+    my ($pathname) = packet_txt_read() =~ /^pathname=([^=]+)$/;
     print $debug " $pathname";
     $debug->flush();

     # Flush
-    packet_read();
+    packet_bin_read();

     my $input = "";
     {
@@ -114,7 +126,7 @@ while (1) {
         my $buffer;
         my $done = 0;
         while ( !$done ) {
-            ( $done, $buffer ) = packet_read();
+            ( $done, $buffer ) = packet_bin_read();
             $input .= $buffer;
         }
         print $debug " " . length($input) . " [OK] -- ";
@@ -141,17 +153,17 @@ while (1) {
     if ( $pathname eq "error.r" ) {
         print $debug "[ERROR]\n";
         $debug->flush();
-        packet_write("status=error\n");
+        packet_txt_write("status=error");
         packet_flush();
     }
     elsif ( $pathname eq "abort.r" ) {
         print $debug "[ABORT]\n";
         $debug->flush();
-        packet_write("status=abort\n");
+        packet_txt_write("status=abort");
         packet_flush();
     }
     else {
-        packet_write("status=success\n");
+        packet_txt_write("status=success");
         packet_flush();

         if ( $pathname eq "${command}-write-fail.r" ) {
@@ -162,7 +174,7 @@ while (1) {

         while ( length($output) > 0 ) {
             my $packet = substr( $output, 0, $MAX_PACKET_CONTENT_SIZE );
-            packet_write($packet);
+            packet_bin_write($packet);
             print $debug ".";
             if ( length($output) > $MAX_PACKET_CONTENT_SIZE ) {
                 $output = substr( $output, $MAX_PACKET_CONTENT_SIZE );
diff --git a/unpack-trees.c b/unpack-trees.c
index f6798f8..11c37fb 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -10,7 +10,6 @@
 #include "attr.h"
 #include "split-index.h"
 #include "dir.h"
-#include "convert.h"

 /*
  * Error messages expected by scripts out of plumbing commands such as
diff --git a/write_or_die.c b/write_or_die.c
index 0734432..eab8c8d 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -1,19 +1,6 @@
 #include "cache.h"
 #include "run-command.h"

-static void check_pipe(int err)
-{
- if (err == EPIPE) {
-   if (in_async())
-     async_exit(141);
-
-   signal(SIGPIPE, SIG_DFL);
-   raise(SIGPIPE);
-   /* Should never happen, but just in case... */
-   exit(141);
- }
-}
-
 /*
  * Some cases use stdio, but want to flush after the write
  * to get error handling (and to get better interactive



Lars Schneider (11):
  pkt-line: rename packet_write() to packet_write_fmt()
  pkt-line: extract set_packet_header()
  run-command: move check_pipe() from write_or_die to run_command
  pkt-line: add packet_write_fmt_gently()
  pkt-line: add packet_flush_gently()
  pkt-line: add packet_write_gently()
  pkt-line: add functions to read/write flush terminated packet streams
  convert: quote filter names in error messages
  convert: modernize tests
  convert: make apply_filter() adhere to standard Git error handling
  convert: add filter.<driver>.process option

 Documentation/gitattributes.txt        | 156 +++++++++++-
 builtin/archive.c                      |   4 +-
 builtin/receive-pack.c                 |   4 +-
 builtin/remote-ext.c                   |   4 +-
 builtin/upload-archive.c               |   4 +-
 connect.c                              |   2 +-
 contrib/long-running-filter/example.pl | 123 ++++++++++
 convert.c                              | 369 ++++++++++++++++++++++++----
 daemon.c                               |   2 +-
 http-backend.c                         |   2 +-
 pkt-line.c                             | 147 +++++++++++-
 pkt-line.h                             |  12 +-
 run-command.c                          |  13 +
 run-command.h                          |   2 +
 shallow.c                              |   2 +-
 t/t0021-conversion.sh                  | 423 ++++++++++++++++++++++++++++++---
 t/t0021/rot13-filter.pl                | 191 +++++++++++++++
 upload-pack.c                          |  30 +--
 write_or_die.c                         |  13 -
 19 files changed, 1379 insertions(+), 124 deletions(-)
 create mode 100755 contrib/long-running-filter/example.pl
 create mode 100755 t/t0021/rot13-filter.pl

--
2.10.0

