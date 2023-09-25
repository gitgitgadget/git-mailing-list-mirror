Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E671FCE7A95
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 15:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjIYPm5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 11:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjIYPmq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 11:42:46 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4DA19B5
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 08:41:51 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c364fb8a4cso60552525ad.1
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 08:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695656511; x=1696261311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8eU6KlYNOUbo4tew0LaMGYacf7pAFMZMHgVRtMA2Uc=;
        b=AuEUpoC+LlghjUPKfkvqIep+9d/ONKyjKIRHBfcla/TTal8x6gvdn91oWHuumip1qp
         V8LHkCYHVbRPfhNgjt2MQU9crBhpGb7Aubxe8s4dBYwKoS6DfI6vXHsq+LY3d0Qh1OAp
         tighQXo5MpDGEzgoIAy9FA84B+pL5zPWGSHg40T+S0vcZKoFDTwY1nq8ib1KhUDK26cb
         kQHr481PDOwn0I+F1rNMB/OtBfKS3OjcCbJhd8awexjYcuggexkxSHV9Tfe+rHs3L1YC
         8gqoMtwBCakzwh1ZEGLmDmPwvH+bJH8Ys5k1bY+x1pCR4eckzW2UVjL96Id/+k4p9vpF
         NV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695656511; x=1696261311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8eU6KlYNOUbo4tew0LaMGYacf7pAFMZMHgVRtMA2Uc=;
        b=PnJkcb7T2q+mmGUFfKNMWdH+AviOzMYZeVDQyca+6ZEenLmS5yszrBx7qPe6pA+fcJ
         dcXZzMBMmXKIcXdF09/VVX49T3sM1Ee5ERVHwxO4wowImILOECLF90ftfTRtTFOKxgGr
         ONpaNuw+ZTdU2VcQbF77vtaTI27SF4qZ5p7IZ/glReNlfOIlOO8V554Y61OH71vhKNnA
         AXylq+HuVSTwMB6MGFeQQpvOJkI1qLpNgBx/JV/6jpUT1UMeUMdxbZ9IfF8lQuBHNv9l
         acoiOndZoKNMwfqsYuYaCgSB2hyHprR4E1PamNH1i79tgN+7T26Ag2z4GFrcOKg2DCOM
         ofuA==
X-Gm-Message-State: AOJu0YwUEfuae1q6Y4ry9lYYOEhvIfzewUc03e1k+i5pgHZluxkvsL4g
        Z4sfg3qc1jJA4plCVdco8seHYSmbwMA=
X-Google-Smtp-Source: AGHT+IFFm90/fsHFJt+Cm/E85LqV6ohwLat7Zn3H4WW1+qc9nARuFvfj+gnrxR0ZoHKxwfisNj05YA==
X-Received: by 2002:a17:90a:c298:b0:277:70f5:115d with SMTP id f24-20020a17090ac29800b0027770f5115dmr915632pjt.0.1695656510645;
        Mon, 25 Sep 2023 08:41:50 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a1a4500b00274e610dbdasm10960638pjl.8.2023.09.25.08.41.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Sep 2023 08:41:50 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2 1/3] test-pkt-line: add option parser for unpack-sideband
Date:   Mon, 25 Sep 2023 23:41:42 +0800
Message-Id: <20230925154144.15213-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <CANYiYbF+Xmk4rCNLMJe+i_CFafg8=QU5vbXWNUZbOVsDLTe5QQ@mail.gmail.com>
References: <CANYiYbF+Xmk4rCNLMJe+i_CFafg8=QU5vbXWNUZbOVsDLTe5QQ@mail.gmail.com>
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

