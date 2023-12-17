Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9928E446C6
	for <git@vger.kernel.org>; Sun, 17 Dec 2023 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwEv4e7Q"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-35d82fb7e86so7156725ab.2
        for <git@vger.kernel.org>; Sun, 17 Dec 2023 06:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702824101; x=1703428901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mEXw1xVmZxwcgAP/Spwp2DIwcfIyU1eJ67eSxjKcis=;
        b=jwEv4e7QPGjxL3TGDx92fnLMdM0HhA4LkDXd1Mh5eR872bFwCWVYe5zkxSBX/yciy6
         R6yr/k49+8rCPTtt2jReX5TAFktV0aedrUOJ1dbeA0s8Ck09WfdNyMLz03i4358WS4pb
         yuBNcfyetz4+BzbhpP8xVakIvxGv4O7ZCkcn4ejijf2vp/53Osmuo1/84yfPoYbh7dTp
         oUPtPfxV8ykz4gwG+GAD/8FuD6MUooLhDZH63Ja4OmYVPy9x1xuxNdBvLCvjAMOIEHxq
         7cwdLKBpUEtYeIxXAB5FWkjzTgHl6d7qdrOf9joPy1OSScRw7c8/cBGXaM3VDn3jFelu
         GVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702824101; x=1703428901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mEXw1xVmZxwcgAP/Spwp2DIwcfIyU1eJ67eSxjKcis=;
        b=GYwkqNLvExXUG981cP5VJaV/sVZIsVFNNxnFtpiGPZ7MRSrLnPrdvhzWTK013fzR09
         sqhZu97SUKK6Usxenj0WYJKsxzdVl7GnFiQyH5UhtbC3uluhUfFSfs2KMAFzwPATm2e2
         g7veR8TY643GoX+OzaSCBnfHtuSX5cFwrxi0Oo6yDJNvtNzbma9NIfXUKOY2HFyFnrFC
         YuUg7A4gh1ZOGNlRIeuvU9oDeLYdSnJpRm/Jk6UO0hNKLVhqRg23U4c1iSTEEzRz5wx9
         teWQpplWMI/h+8RRGrOj5xBW7KrK8reJxrpmCIGlHOAJv0sMbl723yP65WhERHAs0/Es
         /GSg==
X-Gm-Message-State: AOJu0YwFm42aoOhnC8FACw8URstk1T80fslYnwMfwfLrTGrSBVbrwUQ0
	VRhVOUf5jmYqss+IoQJ+/Bjh2rbkjrQ=
X-Google-Smtp-Source: AGHT+IFpKRvVqR3J4zvOO65hvOER1n/wPp86dmxXMQsQfjEz1OLqr5U4YP7b6fpJZCKigWByQmNjUQ==
X-Received: by 2002:a92:cdaa:0:b0:35f:84b8:c1a1 with SMTP id g10-20020a92cdaa000000b0035f84b8c1a1mr6813414ild.4.1702824101526;
        Sun, 17 Dec 2023 06:41:41 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id i4-20020a63cd04000000b005c1ce3c960bsm16276657pgg.50.2023.12.17.06.41.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Dec 2023 06:41:41 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v4 1/3] test-pkt-line: add option parser for unpack-sideband
Date: Sun, 17 Dec 2023 22:41:36 +0800
Message-Id: <ff4e5aff2acc5e7e1d8546798639c556e74d7076.1702823801.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1702823801.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1696425168.git.zhiyou.jx@alibaba-inc.com> <cover.1702823801.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

We can use the test helper program "test-tool pkt-line" to test pkt-line
related functions. E.g.:

 * Use "test-tool pkt-line send-split-sideband" to generate sideband
   messages.

 * Pipe these generated sideband messages to command "test-tool pkt-line
   unpack-sideband" to test packet_reader_read() function.

In order to make a complete test of the packet_reader_read() function,
add option parser for command "test-tool pkt-line unpack-sideband".

 * To remove newlines in sideband messages, we can use:

        $ test-tool pkt-line unpack-sideband --chomp-newline

 * To preserve newlines in sideband messages, we can use:

        $ test-tool pkt-line unpack-sideband --no-chomp-newline

 * To parse sideband messages using "demultiplex_sideband()" inside the
   function "packet_reader_read()", we can use:

        $ test-tool pkt-line unpack-sideband --reader-use-sideband

We also add new example sideband packets in send_split_sideband() and
add several new test cases in t0070. Among these test cases, we pipe
output of the "send-split-sideband" subcommand to the "unpack-sideband"
subcommand. We found two issues:

 1. The two splitted sideband messages "Hello," and " world!\n" should
    be concatenated together. But when we turn on use_sideband field of
    reader to parse sideband messages, the first part of the splitted
    message ("Hello,") is lost.

 2. The newline characters in sideband 2 (progress info) and sideband 3
    (error message) should be preserved, but they are both trimmed.

Will fix the above two issues in subsequent commits.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/helper/test-pkt-line.c | 59 ++++++++++++++++++++++++++++++++++++----
 t/t0070-fundamental.sh   | 58 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+), 5 deletions(-)

diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
index f4d134a145..6b306cf5ca 100644
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
@@ -79,6 +101,17 @@ static void unpack_sideband(void)
 		case PACKET_READ_EOF:
 			break;
 		case PACKET_READ_NORMAL:
+			/*
+			 * When the "use_sideband" field of the reader is turned
+			 * on, sideband packets other than the payload have been
+			 * parsed and consumed in packet_reader_read(), and only
+			 * the payload arrives here.
+			 */
+			if (reader.use_sideband) {
+				write_or_die(1, reader.line, reader.pktlen - 1);
+				break;
+			}
+
 			band = reader.line[0] & 0xff;
 			if (band < 1 || band > 2)
 				continue; /* skip non-sideband packets */
@@ -97,15 +130,31 @@ static void unpack_sideband(void)
 
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
+	 * We use unpack_sideband() to consume packets. A flush packet
+	 * is required to end parsing.
+	 */
+	packet_flush(1);
+
 	return 0;
 }
 
@@ -126,7 +175,7 @@ int cmd__pkt_line(int argc, const char **argv)
 	else if (!strcmp(argv[1], "unpack"))
 		unpack();
 	else if (!strcmp(argv[1], "unpack-sideband"))
-		unpack_sideband();
+		unpack_sideband(argc - 1, argv + 1);
 	else if (!strcmp(argv[1], "send-split-sideband"))
 		send_split_sideband();
 	else if (!strcmp(argv[1], "receive-sideband"))
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 574de34198..297a7f772e 100755
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
+test_expect_failure 'unpack-sideband: packet_reader_read() consumes sideband, no chomp payload' '
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
+test_expect_failure 'unpack-sideband: packet_reader_read() consumes sideband, chomp payload' '
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
2.41.0.232.g2f6f0bca4f.agit.8.0.4.dev

