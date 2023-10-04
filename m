Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F2CE7B611
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 13:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242630AbjJDNSb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 09:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbjJDNSX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 09:18:23 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A005A6
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 06:18:19 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2774874c3daso1578174a91.1
        for <git@vger.kernel.org>; Wed, 04 Oct 2023 06:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696425498; x=1697030298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8eU6KlYNOUbo4tew0LaMGYacf7pAFMZMHgVRtMA2Uc=;
        b=DIOTth3OX3SYO5sPTlqKhUg9qemDme5SfgFrJIvBDcbW51FXo8sIYiAkNwkjVsX1D1
         mC/Iz0vZylFTHnlQoZ+KjcRUyoF5EhHLS7G5CaC1TFNyJkZfAjcxkHVZMWQoPxcODzu4
         5VxWgLgvgtSqUbwkJAHlH50yP80Qg6QGuvtgVHv2qi+ElqzBM/aynvvuPWNEm21r+MWG
         kqp7xm0/QJ7tJQWr+GAQ0n2HMIMd2DOIeqQAnMJhPqzTGRo/8TmVW/enxsvuzrE8xW47
         yPdPpItebPh0PnS2MqvCqeMCWCv0vvB9y63Et75r+s/EC6MnFyAYcporjmsreCxH6Ypc
         Cwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696425498; x=1697030298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8eU6KlYNOUbo4tew0LaMGYacf7pAFMZMHgVRtMA2Uc=;
        b=wYJ8xcDkCj1t8To1EJztCpSEt4su2eMIEjEI2C48kUXdkCcTHdQumVP5L1TiOD2oyW
         Zjoqq3Xl/1cAO5yC9DhMVpZV8QS4TuUwSNIdnDLsLRprkNnpZr3YMEdFmaY7F4OhY3Jb
         FkDPXvn3zYcPfvZ+KyGG8Vj6FB9I1Z0Ad9vjmZRe8fvPi0R/veRXpIoJJBll9LOBcT6k
         +69BTrasSEYPY0IrvgvmAIWETiMiL5kbtsU2Km7wL5nvRONevwfc7mhsl+EXiuZfoBZX
         Vk0vvC2RqvcoJ9gOb+M/zKGiXraFJk8eAUCYAGNQlW5DSiaLPC6SnuThDRaI0p2e9hhK
         rnQw==
X-Gm-Message-State: AOJu0YyOE8VE8a9ezHFbn9fBiGkJT3GhAKot/ltc9TqNxpw714/mRV3+
        kmZ4UfdAwCkdaM5UL+LhEGtIQAp7g+s=
X-Google-Smtp-Source: AGHT+IHfUIejH6WSuymMJFncHwXPwyhDeeG9ELG9qhRs0CobuoTo2bk9Xh2kXsCPpHrmNxebMDvbCA==
X-Received: by 2002:a17:90b:11cc:b0:277:6d6a:33ba with SMTP id gv12-20020a17090b11cc00b002776d6a33bamr2267035pjb.28.1696425498339;
        Wed, 04 Oct 2023 06:18:18 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y14-20020a17090a134e00b00260a5ecd273sm1465496pjf.1.2023.10.04.06.18.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2023 06:18:17 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 1/3] test-pkt-line: add option parser for unpack-sideband
Date:   Wed,  4 Oct 2023 21:18:12 +0800
Message-Id: <17d88ecab6228fbf56f934bc09c921268d202874.1696425168.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1696425168.git.zhiyou.jx@alibaba-inc.com>
References: <ZRKax7Me5uIHKHoC@ugly> <cover.1696425168.git.zhiyou.jx@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

We can use the test helper program "test-tool pkt-line" to test pkt-line
related functions. E.g.:

 * Use "test-tool pkt-line send-split-sideband" to generate sideband
   messages.

 * We can pipe these generated sideband messages to command "test-tool
   pkt-line unpack-sideband" to test packet_reader_read() function.

In order to make a complete test of the packet_reader_read() function,
add option parser for command "test-tool pkt-line unpack-sideband".

To remove newlines in sideband messages, we can use:

    $ test-tool pkt-line unpack-sideband --chomp-newline

To preserve newlines in sideband messages, we can use:

    $ test-tool pkt-line unpack-sideband --no-chomp-newline

To parse sideband messages using "demultiplex_sideband()" inside the
function "packet_reader_read()", we can use:

    $ test-tool pkt-line unpack-sideband --reader-use-sideband

Add several new test cases in t0070. Among these test cases, we pipe
output of the "send-split-sideband" subcommand to the "unpack-sideband"
subcommand. We found two issues:

 1. The two splitted sideband messages "Hello," and " world!\n" should
    be concatenated together. But when we enabled the function
    "demultiplex_sideband()" to parse sideband messages, the first part
    of the splitted message ("Hello,") is lost.

 2. The newline characters in sideband 2 (progress info) and sideband 3
    (error message) should be preserved, but they are also trimmed.

Will fix the above two issues in subsequent commits.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/helper/test-pkt-line.c | 58 ++++++++++++++++++++++++++++++++++++----
 t/t0070-fundamental.sh   | 58 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+), 5 deletions(-)

diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
index f4d134a145..9aa35f7861 100644
--- a/t/helper/test-pkt-line.c
+++ b/t/helper/test-pkt-line.c
@@ -2,6 +2,7 @@
 #include "test-tool.h"
 #include "pkt-line.h"
 #include "write-or-die.h"
+#include "parse-options.h"
 
 static void pack_line(const char *line)
 {
@@ -64,12 +65,33 @@ static void unpack(void)
 	}
 }
 
-static void unpack_sideband(void)
+static void unpack_sideband(int argc, const char **argv)
 {
 	struct packet_reader reader;
-	packet_reader_init(&reader, 0, NULL, 0,
-			   PACKET_READ_GENTLE_ON_EOF |
-			   PACKET_READ_CHOMP_NEWLINE);
+	int options = PACKET_READ_GENTLE_ON_EOF;
+	int chomp_newline = 1;
+	int reader_use_sideband = 0;
+	const char *const unpack_sideband_usage[] = {
+		"test_tool unpack_sideband [options...]", NULL
+	};
+	struct option cmd_options[] = {
+		OPT_BOOL(0, "reader-use-sideband", &reader_use_sideband,
+			 "set use_sideband bit for packet reader (Default: off)"),
+		OPT_BOOL(0, "chomp-newline", &chomp_newline,
+			 "chomp newline in packet (Default: on)"),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, "", cmd_options, unpack_sideband_usage,
+			     0);
+	if (argc > 0)
+		usage_msg_opt(_("too many arguments"), unpack_sideband_usage,
+			      cmd_options);
+
+	if (chomp_newline)
+		options |= PACKET_READ_CHOMP_NEWLINE;
+	packet_reader_init(&reader, 0, NULL, 0, options);
+	reader.use_sideband = reader_use_sideband;
 
 	while (packet_reader_read(&reader) != PACKET_READ_EOF) {
 		int band;
@@ -79,6 +101,16 @@ static void unpack_sideband(void)
 		case PACKET_READ_EOF:
 			break;
 		case PACKET_READ_NORMAL:
+			/*
+			 * When the "use_sideband" field of the reader is turned
+			 * on, sideband packets other than the payload have been
+			 * parsed and consumed.
+			 */
+			if (reader.use_sideband) {
+				write_or_die(1, reader.line, reader.pktlen - 1);
+				break;
+			}
+
 			band = reader.line[0] & 0xff;
 			if (band < 1 || band > 2)
 				continue; /* skip non-sideband packets */
@@ -97,15 +129,31 @@ static void unpack_sideband(void)
 
 static int send_split_sideband(void)
 {
+	const char *foo = "Foo.\n";
+	const char *bar = "Bar.\n";
 	const char *part1 = "Hello,";
 	const char *primary = "\001primary: regular output\n";
 	const char *part2 = " world!\n";
 
+	/* Each sideband message has a trailing newline character. */
+	send_sideband(1, 2, foo, strlen(foo), LARGE_PACKET_MAX);
+	send_sideband(1, 2, bar, strlen(bar), LARGE_PACKET_MAX);
+
+	/*
+	 * One sideband message is divided into part1 and part2
+	 * by the primary message.
+	 */
 	send_sideband(1, 2, part1, strlen(part1), LARGE_PACKET_MAX);
 	packet_write(1, primary, strlen(primary));
 	send_sideband(1, 2, part2, strlen(part2), LARGE_PACKET_MAX);
 	packet_response_end(1);
 
+	/*
+	 * The unpack_sideband() function above requires a flush
+	 * packet to end parsing.
+	 */
+	packet_flush(1);
+
 	return 0;
 }
 
@@ -126,7 +174,7 @@ int cmd__pkt_line(int argc, const char **argv)
 	else if (!strcmp(argv[1], "unpack"))
 		unpack();
 	else if (!strcmp(argv[1], "unpack-sideband"))
-		unpack_sideband();
+		unpack_sideband(argc - 1, argv + 1);
 	else if (!strcmp(argv[1], "send-split-sideband"))
 		send_split_sideband();
 	else if (!strcmp(argv[1], "receive-sideband"))
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 574de34198..1053913d2d 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -53,4 +53,62 @@ test_expect_success 'missing sideband designator is reported' '
 	test_i18ngrep "missing sideband" err
 '
 
+test_expect_success 'unpack-sideband: --no-chomp-newline' '
+	test_when_finished "rm -f expect-out expect-err" &&
+	test-tool pkt-line send-split-sideband >split-sideband &&
+	test-tool pkt-line unpack-sideband \
+		--no-chomp-newline <split-sideband >out 2>err &&
+	cat >expect-out <<-EOF &&
+		primary: regular output
+	EOF
+	cat >expect-err <<-EOF &&
+		Foo.
+		Bar.
+		Hello, world!
+	EOF
+	test_cmp expect-out out &&
+	test_cmp expect-err err
+'
+
+test_expect_success 'unpack-sideband: --chomp-newline (default)' '
+	test_when_finished "rm -f expect-out expect-err" &&
+	test-tool pkt-line send-split-sideband >split-sideband &&
+	test-tool pkt-line unpack-sideband \
+		--chomp-newline <split-sideband >out 2>err &&
+	printf "primary: regular output" >expect-out &&
+	printf "Foo.Bar.Hello, world!" >expect-err &&
+	test_cmp expect-out out &&
+	test_cmp expect-err err
+'
+
+test_expect_failure 'unpack-sideband with demultiplex_sideband(), no chomp newline' '
+	test_when_finished "rm -f expect-out expect-err" &&
+	test-tool pkt-line send-split-sideband >split-sideband &&
+	test-tool pkt-line unpack-sideband \
+		--reader-use-sideband \
+		--no-chomp-newline <split-sideband >out 2>err &&
+	cat >expect-out <<-EOF &&
+		primary: regular output
+	EOF
+	printf "remote: Foo.        \n"           >expect-err &&
+	printf "remote: Bar.        \n"          >>expect-err &&
+	printf "remote: Hello, world!        \n" >>expect-err &&
+	test_cmp expect-out out &&
+	test_cmp expect-err err
+'
+
+test_expect_failure 'unpack-sideband with demultiplex_sideband(), chomp newline' '
+	test_when_finished "rm -f expect-out expect-err" &&
+	test-tool pkt-line send-split-sideband >split-sideband &&
+	test-tool pkt-line unpack-sideband \
+		--reader-use-sideband \
+		--chomp-newline <split-sideband >out 2>err &&
+	printf "primary: regular output" >expect-out &&
+	printf "remote: Foo.        \n"           >expect-err &&
+	printf "remote: Bar.        \n"          >>expect-err &&
+	printf "remote: Hello, world!        \n" >>expect-err &&
+	test_cmp expect-out out &&
+	test_cmp expect-err err
+'
+
 test_done
-- 
2.40.1.50.gf560bcc116.dirty

