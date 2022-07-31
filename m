Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CFFC19F2B
	for <git@archiver.kernel.org>; Sun, 31 Jul 2022 18:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbiGaSUV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jul 2022 14:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbiGaSUS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jul 2022 14:20:18 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44E3112F
        for <git@vger.kernel.org>; Sun, 31 Jul 2022 11:20:12 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id f10so3741281uap.2
        for <git@vger.kernel.org>; Sun, 31 Jul 2022 11:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=OJI1C/HB8TZW7g3TPbsslesUzAFrGbJdQyEnJONEVG4=;
        b=vuHzs+dcHVGpjMHHsoeBoDLetsHtuJl0jLOieXIM08kcxlGyuG7Vs2w+09DtMxPlAy
         6VqhD2psT/V1Psgz1ZdRBJpJL6/REsziXJg1raCKjo4QaENBGVTeUOWnHuTJGmhZU7EJ
         rhg4OoG/2kZMoDy3c/Af/1DhIOhl3IiCWBxexcDuEAZXGSjHmZfyZrNYvW7w+5EfwhIp
         /9S4LSfFrSACmjfJKvpi/SBbJU8HLpRwDwgMtkDdXEEkCkqZ/UupQrEaYTbRJKCaFZGC
         3Yyjn0n1+Ym3pn2893CkbOjeuGXdr1U1PYCYshLVh/rlXgaqOatBL241iu7f6bCOTpIu
         +LDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=OJI1C/HB8TZW7g3TPbsslesUzAFrGbJdQyEnJONEVG4=;
        b=I1Az1QFtvEyL1Q2CGuRTwPm14lxcGMInvW6Zvpvb7S9NuO6JiHHkYDOZsxxA/fmpnZ
         AxpehHZy8S0DcjAZ4awcp7nbd97D2h9AS2I+0OmvjM3dBKj3gMLnAAG+f4BMNYa/KSN+
         Y5+z4ii/Vyy/W9/DtsAKuJjZ208n6P75dQLQ5xhIo1fGpHWqVK/rAIax9m+3EWkGca2F
         V7Sa6rWPs+Uw/7v6qdUhGEVqFG1cRBcudcQyDVKPzAegm1ipp8IEDICSyIRR5u3axKut
         DNPDsnX1kyOBQmVPzoiXyAhXOkqBx0bArLV0W06Uuf999t56NYt4fv3G9wIzqKwmECFh
         ndkw==
X-Gm-Message-State: ACgBeo2AwyXjChR1Y+GsV6HMr6tGFYzViH0DESEbGl3ccxDEneozVtWm
        /BTtt/ensfD48/9T1JYMWXeJvwYGvb24lg==
X-Google-Smtp-Source: AA6agR5/wS+8xUfwW/NglLnm+zwwZdSTW33Z/8gTIlRWSbC4Eu6vCo/IEw+1iMmIiYxP/Evyca8TXw==
X-Received: by 2002:ab0:22c7:0:b0:384:e253:9caa with SMTP id z7-20020ab022c7000000b00384e2539caamr4784003uam.55.1659291611310;
        Sun, 31 Jul 2022 11:20:11 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id l2-20020a056102050200b003573f2ff61asm3738795vsa.22.2022.07.31.11.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 11:20:10 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, johannes.schindelin@gmx.de
Subject: [PATCH v3 3/3] tests: use the new C rot13-filter helper to avoid PERL prereq
Date:   Sun, 31 Jul 2022 15:19:50 -0300
Message-Id: <c66fc0a18699663b4440dbfd2887c2689dc486fe.1659291026.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1659291025.git.matheus.bernardino@usp.br>
References: <cover.1659291025.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit implemented a C version of the t0021/rot13-filter.pl
script. Let's use this new C helper to eliminate the PERL prereq from
various tests, and also remove the superseded Perl script.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/t0021-conversion.sh                   |  69 ++++---
 t/t0021/rot13-filter.pl                 | 247 ------------------------
 t/t2080-parallel-checkout-basics.sh     |   7 +-
 t/t2082-parallel-checkout-attributes.sh |   7 +-
 4 files changed, 37 insertions(+), 293 deletions(-)
 delete mode 100644 t/t0021/rot13-filter.pl

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 963b66e08c..aeaa8e02ed 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -17,9 +17,6 @@ tr \
   'nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM'
 EOF
 
-write_script rot13-filter.pl "$PERL_PATH" \
-	<"$TEST_DIRECTORY"/t0021/rot13-filter.pl
-
 generate_random_characters () {
 	LEN=$1
 	NAME=$2
@@ -365,8 +362,8 @@ test_expect_success 'diff does not reuse worktree files that need cleaning' '
 	test_line_count = 0 count
 '
 
-test_expect_success PERL 'required process filter should filter data' '
-	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
+test_expect_success 'required process filter should filter data' '
+	test_config_global filter.protocol.process "test-tool rot13-filter debug.log clean smudge" &&
 	test_config_global filter.protocol.required true &&
 	rm -rf repo &&
 	mkdir repo &&
@@ -450,8 +447,8 @@ test_expect_success PERL 'required process filter should filter data' '
 	)
 '
 
-test_expect_success PERL 'required process filter should filter data for various subcommands' '
-	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
+test_expect_success 'required process filter should filter data for various subcommands' '
+	test_config_global filter.protocol.process "test-tool rot13-filter debug.log clean smudge" &&
 	test_config_global filter.protocol.required true &&
 	(
 		cd repo &&
@@ -561,9 +558,9 @@ test_expect_success PERL 'required process filter should filter data for various
 	)
 '
 
-test_expect_success PERL 'required process filter takes precedence' '
+test_expect_success 'required process filter takes precedence' '
 	test_config_global filter.protocol.clean false &&
-	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean" &&
+	test_config_global filter.protocol.process "test-tool rot13-filter debug.log clean" &&
 	test_config_global filter.protocol.required true &&
 	rm -rf repo &&
 	mkdir repo &&
@@ -587,8 +584,8 @@ test_expect_success PERL 'required process filter takes precedence' '
 	)
 '
 
-test_expect_success PERL 'required process filter should be used only for "clean" operation only' '
-	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean" &&
+test_expect_success 'required process filter should be used only for "clean" operation only' '
+	test_config_global filter.protocol.process "test-tool rot13-filter debug.log clean" &&
 	rm -rf repo &&
 	mkdir repo &&
 	(
@@ -622,8 +619,8 @@ test_expect_success PERL 'required process filter should be used only for "clean
 	)
 '
 
-test_expect_success PERL 'required process filter should process multiple packets' '
-	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
+test_expect_success 'required process filter should process multiple packets' '
+	test_config_global filter.protocol.process "test-tool rot13-filter debug.log clean smudge" &&
 	test_config_global filter.protocol.required true &&
 
 	rm -rf repo &&
@@ -687,8 +684,8 @@ test_expect_success PERL 'required process filter should process multiple packet
 	)
 '
 
-test_expect_success PERL 'required process filter with clean error should fail' '
-	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
+test_expect_success 'required process filter with clean error should fail' '
+	test_config_global filter.protocol.process "test-tool rot13-filter debug.log clean smudge" &&
 	test_config_global filter.protocol.required true &&
 	rm -rf repo &&
 	mkdir repo &&
@@ -706,8 +703,8 @@ test_expect_success PERL 'required process filter with clean error should fail'
 	)
 '
 
-test_expect_success PERL 'process filter should restart after unexpected write failure' '
-	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
+test_expect_success 'process filter should restart after unexpected write failure' '
+	test_config_global filter.protocol.process "test-tool rot13-filter debug.log clean smudge" &&
 	rm -rf repo &&
 	mkdir repo &&
 	(
@@ -761,8 +758,8 @@ test_expect_success PERL 'process filter should restart after unexpected write f
 	)
 '
 
-test_expect_success PERL 'process filter should not be restarted if it signals an error' '
-	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
+test_expect_success 'process filter should not be restarted if it signals an error' '
+	test_config_global filter.protocol.process "test-tool rot13-filter debug.log clean smudge" &&
 	rm -rf repo &&
 	mkdir repo &&
 	(
@@ -804,8 +801,8 @@ test_expect_success PERL 'process filter should not be restarted if it signals a
 	)
 '
 
-test_expect_success PERL 'process filter abort stops processing of all further files' '
-	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
+test_expect_success 'process filter abort stops processing of all further files' '
+	test_config_global filter.protocol.process "test-tool rot13-filter debug.log clean smudge" &&
 	rm -rf repo &&
 	mkdir repo &&
 	(
@@ -861,10 +858,10 @@ test_expect_success PERL 'invalid process filter must fail (and not hang!)' '
 	)
 '
 
-test_expect_success PERL 'delayed checkout in process filter' '
-	test_config_global filter.a.process "rot13-filter.pl a.log clean smudge delay" &&
+test_expect_success 'delayed checkout in process filter' '
+	test_config_global filter.a.process "test-tool rot13-filter a.log clean smudge delay" &&
 	test_config_global filter.a.required true &&
-	test_config_global filter.b.process "rot13-filter.pl b.log clean smudge delay" &&
+	test_config_global filter.b.process "test-tool rot13-filter b.log clean smudge delay" &&
 	test_config_global filter.b.required true &&
 
 	rm -rf repo &&
@@ -940,8 +937,8 @@ test_expect_success PERL 'delayed checkout in process filter' '
 	)
 '
 
-test_expect_success PERL 'missing file in delayed checkout' '
-	test_config_global filter.bug.process "rot13-filter.pl bug.log clean smudge delay" &&
+test_expect_success 'missing file in delayed checkout' '
+	test_config_global filter.bug.process "test-tool rot13-filter bug.log clean smudge delay" &&
 	test_config_global filter.bug.required true &&
 
 	rm -rf repo &&
@@ -960,8 +957,8 @@ test_expect_success PERL 'missing file in delayed checkout' '
 	grep "error: .missing-delay\.a. was not filtered properly" git-stderr.log
 '
 
-test_expect_success PERL 'invalid file in delayed checkout' '
-	test_config_global filter.bug.process "rot13-filter.pl bug.log clean smudge delay" &&
+test_expect_success 'invalid file in delayed checkout' '
+	test_config_global filter.bug.process "test-tool rot13-filter bug.log clean smudge delay" &&
 	test_config_global filter.bug.required true &&
 
 	rm -rf repo &&
@@ -990,10 +987,10 @@ do
 		mode_prereq='UTF8_NFD_TO_NFC' ;;
 	esac
 
-	test_expect_success PERL,SYMLINKS,$mode_prereq \
+	test_expect_success SYMLINKS,$mode_prereq \
 	"delayed checkout with $mode-collision don't write to the wrong place" '
 		test_config_global filter.delay.process \
-			"\"$TEST_ROOT/rot13-filter.pl\" --always-delay delayed.log clean smudge delay" &&
+			"test-tool rot13-filter --always-delay delayed.log clean smudge delay" &&
 		test_config_global filter.delay.required true &&
 
 		git init $mode-collision &&
@@ -1026,12 +1023,12 @@ do
 	'
 done
 
-test_expect_success PERL,SYMLINKS,CASE_INSENSITIVE_FS \
+test_expect_success SYMLINKS,CASE_INSENSITIVE_FS \
 "delayed checkout with submodule collision don't write to the wrong place" '
 	git init collision-with-submodule &&
 	(
 		cd collision-with-submodule &&
-		git config filter.delay.process "\"$TEST_ROOT/rot13-filter.pl\" --always-delay delayed.log clean smudge delay" &&
+		git config filter.delay.process "test-tool rot13-filter --always-delay delayed.log clean smudge delay" &&
 		git config filter.delay.required true &&
 
 		# We need Git to treat the submodule "a" and the
@@ -1062,11 +1059,11 @@ test_expect_success PERL,SYMLINKS,CASE_INSENSITIVE_FS \
 	)
 '
 
-test_expect_success PERL 'setup for progress tests' '
+test_expect_success 'setup for progress tests' '
 	git init progress &&
 	(
 		cd progress &&
-		git config filter.delay.process "rot13-filter.pl delay-progress.log clean smudge delay" &&
+		git config filter.delay.process "test-tool rot13-filter delay-progress.log clean smudge delay" &&
 		git config filter.delay.required true &&
 
 		echo "*.a filter=delay" >.gitattributes &&
@@ -1132,12 +1129,12 @@ do
 	'
 done
 
-test_expect_success PERL 'delayed checkout correctly reports the number of updated entries' '
+test_expect_success 'delayed checkout correctly reports the number of updated entries' '
 	rm -rf repo &&
 	git init repo &&
 	(
 		cd repo &&
-		git config filter.delay.process "../rot13-filter.pl delayed.log clean smudge delay" &&
+		git config filter.delay.process "test-tool rot13-filter delayed.log clean smudge delay" &&
 		git config filter.delay.required true &&
 
 		echo "*.a filter=delay" >.gitattributes &&
diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
deleted file mode 100644
index 7bb93768f3..0000000000
--- a/t/t0021/rot13-filter.pl
+++ /dev/null
@@ -1,247 +0,0 @@
-#
-# Example implementation for the Git filter protocol version 2
-# See Documentation/gitattributes.txt, section "Filter Protocol"
-#
-# Usage: rot13-filter.pl [--always-delay] <log path> <capabilities>
-#
-# Log path defines a debug log file that the script writes to. The
-# subsequent arguments define a list of supported protocol capabilities
-# ("clean", "smudge", etc).
-#
-# When --always-delay is given all pathnames with the "can-delay" flag
-# that don't appear on the list bellow are delayed with a count of 1
-# (see more below).
-#
-# This implementation supports special test cases:
-# (1) If data with the pathname "clean-write-fail.r" is processed with
-#     a "clean" operation then the write operation will die.
-# (2) If data with the pathname "smudge-write-fail.r" is processed with
-#     a "smudge" operation then the write operation will die.
-# (3) If data with the pathname "error.r" is processed with any
-#     operation then the filter signals that it cannot or does not want
-#     to process the file.
-# (4) If data with the pathname "abort.r" is processed with any
-#     operation then the filter signals that it cannot or does not want
-#     to process the file and any file after that is processed with the
-#     same command.
-# (5) If data with a pathname that is a key in the DELAY hash is
-#     requested (e.g. "test-delay10.a") then the filter responds with
-#     a "delay" status and sets the "requested" field in the DELAY hash.
-#     The filter will signal the availability of this object after
-#     "count" (field in DELAY hash) "list_available_blobs" commands.
-# (6) If data with the pathname "missing-delay.a" is processed that the
-#     filter will drop the path from the "list_available_blobs" response.
-# (7) If data with the pathname "invalid-delay.a" is processed that the
-#     filter will add the path "unfiltered" which was not delayed before
-#     to the "list_available_blobs" response.
-#
-
-use 5.008;
-sub gitperllib {
-	# Git assumes that all path lists are Unix-y colon-separated ones. But
-	# when the Git for Windows executes the test suite, its MSYS2 Bash
-	# calls git.exe, and colon-separated path lists are converted into
-	# Windows-y semicolon-separated lists of *Windows* paths (which
-	# naturally contain a colon after the drive letter, so splitting by
-	# colons simply does not cut it).
-	#
-	# Detect semicolon-separated path list and handle them appropriately.
-
-	if ($ENV{GITPERLLIB} =~ /;/) {
-		return split(/;/, $ENV{GITPERLLIB});
-	}
-	return split(/:/, $ENV{GITPERLLIB});
-}
-use lib (gitperllib());
-use strict;
-use warnings;
-use IO::File;
-use Git::Packet;
-
-my $MAX_PACKET_CONTENT_SIZE = 65516;
-
-my $always_delay = 0;
-if ( $ARGV[0] eq '--always-delay' ) {
-	$always_delay = 1;
-	shift @ARGV;
-}
-
-my $log_file                = shift @ARGV;
-my @capabilities            = @ARGV;
-
-open my $debug, ">>", $log_file or die "cannot open log file: $!";
-
-my %DELAY = (
-	'test-delay10.a' => { "requested" => 0, "count" => 1 },
-	'test-delay11.a' => { "requested" => 0, "count" => 1 },
-	'test-delay20.a' => { "requested" => 0, "count" => 2 },
-	'test-delay10.b' => { "requested" => 0, "count" => 1 },
-	'missing-delay.a' => { "requested" => 0, "count" => 1 },
-	'invalid-delay.a' => { "requested" => 0, "count" => 1 },
-);
-
-sub rot13 {
-	my $str = shift;
-	$str =~ y/A-Za-z/N-ZA-Mn-za-m/;
-	return $str;
-}
-
-print $debug "START\n";
-$debug->flush();
-
-packet_initialize("git-filter", 2);
-
-my %remote_caps = packet_read_and_check_capabilities("clean", "smudge", "delay");
-packet_check_and_write_capabilities(\%remote_caps, @capabilities);
-
-print $debug "init handshake complete\n";
-$debug->flush();
-
-while (1) {
-	my ( $res, $command ) = packet_key_val_read("command");
-	if ( $res == -1 ) {
-		print $debug "STOP\n";
-		exit();
-	}
-	print $debug "IN: $command";
-	$debug->flush();
-
-	if ( $command eq "list_available_blobs" ) {
-		# Flush
-		packet_compare_lists([1, ""], packet_bin_read()) ||
-			die "bad list_available_blobs end";
-
-		foreach my $pathname ( sort keys %DELAY ) {
-			if ( $DELAY{$pathname}{"requested"} >= 1 ) {
-				$DELAY{$pathname}{"count"} = $DELAY{$pathname}{"count"} - 1;
-				if ( $pathname eq "invalid-delay.a" ) {
-					# Send Git a pathname that was not delayed earlier
-					packet_txt_write("pathname=unfiltered");
-				}
-				if ( $pathname eq "missing-delay.a" ) {
-					# Do not signal Git that this file is available
-				} elsif ( $DELAY{$pathname}{"count"} == 0 ) {
-					print $debug " $pathname";
-					packet_txt_write("pathname=$pathname");
-				}
-			}
-		}
-
-		packet_flush();
-
-		print $debug " [OK]\n";
-		$debug->flush();
-		packet_txt_write("status=success");
-		packet_flush();
-	} else {
-		my ( $res, $pathname ) = packet_key_val_read("pathname");
-		if ( $res == -1 ) {
-			die "unexpected EOF while expecting pathname";
-		}
-		print $debug " $pathname";
-		$debug->flush();
-
-		# Read until flush
-		my ( $done, $buffer ) = packet_txt_read();
-		while ( $buffer ne '' ) {
-			if ( $buffer eq "can-delay=1" ) {
-				if ( exists $DELAY{$pathname} and $DELAY{$pathname}{"requested"} == 0 ) {
-					$DELAY{$pathname}{"requested"} = 1;
-				} elsif ( !exists $DELAY{$pathname} and $always_delay ) {
-					$DELAY{$pathname} = { "requested" => 1, "count" => 1 };
-				}
-			} elsif ($buffer =~ /^(ref|treeish|blob)=/) {
-				print $debug " $buffer";
-			} else {
-				# In general, filters need to be graceful about
-				# new metadata, since it's documented that we
-				# can pass any key-value pairs, but for tests,
-				# let's be a little stricter.
-				die "Unknown message '$buffer'";
-			}
-
-			( $done, $buffer ) = packet_txt_read();
-		}
-		if ( $done == -1 ) {
-			die "unexpected EOF after pathname '$pathname'";
-		}
-
-		my $input = "";
-		{
-			binmode(STDIN);
-			my $buffer;
-			my $done = 0;
-			while ( !$done ) {
-				( $done, $buffer ) = packet_bin_read();
-				$input .= $buffer;
-			}
-			if ( $done == -1 ) {
-				die "unexpected EOF while reading input for '$pathname'";
-			}			
-			print $debug " " . length($input) . " [OK] -- ";
-			$debug->flush();
-		}
-
-		my $output;
-		if ( exists $DELAY{$pathname} and exists $DELAY{$pathname}{"output"} ) {
-			$output = $DELAY{$pathname}{"output"}
-		} elsif ( $pathname eq "error.r" or $pathname eq "abort.r" ) {
-			$output = "";
-		} elsif ( $command eq "clean" and grep( /^clean$/, @capabilities ) ) {
-			$output = rot13($input);
-		} elsif ( $command eq "smudge" and grep( /^smudge$/, @capabilities ) ) {
-			$output = rot13($input);
-		} else {
-			die "bad command '$command'";
-		}
-
-		if ( $pathname eq "error.r" ) {
-			print $debug "[ERROR]\n";
-			$debug->flush();
-			packet_txt_write("status=error");
-			packet_flush();
-		} elsif ( $pathname eq "abort.r" ) {
-			print $debug "[ABORT]\n";
-			$debug->flush();
-			packet_txt_write("status=abort");
-			packet_flush();
-		} elsif ( $command eq "smudge" and
-			exists $DELAY{$pathname} and
-			$DELAY{$pathname}{"requested"} == 1 ) {
-			print $debug "[DELAYED]\n";
-			$debug->flush();
-			packet_txt_write("status=delayed");
-			packet_flush();
-			$DELAY{$pathname}{"requested"} = 2;
-			$DELAY{$pathname}{"output"} = $output;
-		} else {
-			packet_txt_write("status=success");
-			packet_flush();
-
-			if ( $pathname eq "${command}-write-fail.r" ) {
-				print $debug "[WRITE FAIL]\n";
-				$debug->flush();
-				die "${command} write error";
-			}
-
-			print $debug "OUT: " . length($output) . " ";
-			$debug->flush();
-
-			while ( length($output) > 0 ) {
-				my $packet = substr( $output, 0, $MAX_PACKET_CONTENT_SIZE );
-				packet_bin_write($packet);
-				# dots represent the number of packets
-				print $debug ".";
-				if ( length($output) > $MAX_PACKET_CONTENT_SIZE ) {
-					$output = substr( $output, $MAX_PACKET_CONTENT_SIZE );
-				} else {
-					$output = "";
-				}
-			}
-			packet_flush();
-			print $debug " [OK]\n";
-			$debug->flush();
-			packet_flush();
-		}
-	}
-}
diff --git a/t/t2080-parallel-checkout-basics.sh b/t/t2080-parallel-checkout-basics.sh
index c683e60007..7d956625ca 100755
--- a/t/t2080-parallel-checkout-basics.sh
+++ b/t/t2080-parallel-checkout-basics.sh
@@ -230,12 +230,9 @@ test_expect_success SYMLINKS 'parallel checkout checks for symlinks in leading d
 # check the final report including sequential, parallel, and delayed entries
 # all at the same time. So we must have finer control of the parallel checkout
 # variables.
-test_expect_success PERL '"git checkout ." report should not include failed entries' '
-	write_script rot13-filter.pl "$PERL_PATH" \
-		<"$TEST_DIRECTORY"/t0021/rot13-filter.pl &&
-
+test_expect_success '"git checkout ." report should not include failed entries' '
 	test_config_global filter.delay.process \
-		"\"$(pwd)/rot13-filter.pl\" --always-delay delayed.log clean smudge delay" &&
+		"test-tool rot13-filter --always-delay delayed.log clean smudge delay" &&
 	test_config_global filter.delay.required true &&
 	test_config_global filter.cat.clean cat  &&
 	test_config_global filter.cat.smudge cat  &&
diff --git a/t/t2082-parallel-checkout-attributes.sh b/t/t2082-parallel-checkout-attributes.sh
index 2525457961..2df55b9405 100755
--- a/t/t2082-parallel-checkout-attributes.sh
+++ b/t/t2082-parallel-checkout-attributes.sh
@@ -138,12 +138,9 @@ test_expect_success 'parallel-checkout and external filter' '
 # The delayed queue is independent from the parallel queue, and they should be
 # able to work together in the same checkout process.
 #
-test_expect_success PERL 'parallel-checkout and delayed checkout' '
-	write_script rot13-filter.pl "$PERL_PATH" \
-		<"$TEST_DIRECTORY"/t0021/rot13-filter.pl &&
-
+test_expect_success 'parallel-checkout and delayed checkout' '
 	test_config_global filter.delay.process \
-		"\"$(pwd)/rot13-filter.pl\" --always-delay \"$(pwd)/delayed.log\" clean smudge delay" &&
+		"test-tool rot13-filter --always-delay \"$(pwd)/delayed.log\" clean smudge delay" &&
 	test_config_global filter.delay.required true &&
 
 	echo "abcd" >original &&
-- 
2.37.1

