Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191E6C07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 15:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED43F613F5
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 15:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240361AbhGPPoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 11:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbhGPPod (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 11:44:33 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780B9C06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 08:41:37 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i94so12590520wri.4
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 08:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kTjdLTR00MRqpxvhHR54aBL3fgay/IFGbNagLbL40fg=;
        b=f4e5V4adC6+oBg8BacHWKLyDPZJYOH/cw7+xT7fgBRLR6QHwgcpp56rFvlyQZjmMdY
         O/1Rk561PM8m5GEObBzZRr1K1PbBtsY0lgTRPUwZ8SlLsF3zEHgrhVrCCgG5iliZcIxl
         sI8e1Lykn1+sNWc8C6gJoLxMAg77IF5Qw89W9Cp7TH23S3TvxKQwAWHLKgagqvyPdZhX
         D93efWXguY/InEht20uS0B7MFUKKGvjM1j7GofmAgqZRNoKEW7nhL7HO6d+D+GH5+I72
         KPas9H+mcDupVkSAwRHWzU+RYcMSg+xpAnS/uAa3qjeFr9Xb8kMZ9i4s/P3hOGkMAsc2
         oMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kTjdLTR00MRqpxvhHR54aBL3fgay/IFGbNagLbL40fg=;
        b=etk0Q9vYFka855teyVb1X+Bno72LqL4y0p0JESeh9BvbO2tBbYcxzoXjab5mqUdbid
         K/kYpN9oKtQfz2Wfo78iGDi+h1ptSLUHWIp/922HEYZkjCUVgVF6LoT1z2qfNfhD9k9X
         VWZlmajPfppAOBRMeIoFp2KrLa4ZxcnhhW/86QpZcXfdTnyN6XhnMfVVAS92uRa+foKG
         zXncbxMKrim1bBBP7ip4w/FkUXB9GkQmL0qSPj3fgTb17PPMmRnT5pC7Bhe3hVjDDAre
         /Q0LmEwbPfYKI78XyPVunop3cdEvaQjmx8ftarPpsKhZ93nnTDwvO3r3aABcKM5Q5kdX
         2igQ==
X-Gm-Message-State: AOAM531kPuwYhcnMoIWnkDxT21RS0bindq0ro0qWahlhXA2zjXWeLnZQ
        f43bP43uXCgd+gcXaUdedSGqt2vL7D6wng==
X-Google-Smtp-Source: ABdhPJwIqEkvOxQayce2kWu/JW5KFztbDm2B+PaIuNRqefkycfLUDLOKrwsGtnrhExANHwa1sXlC+A==
X-Received: by 2002:a5d:48c6:: with SMTP id p6mr13241341wrs.45.1626450095635;
        Fri, 16 Jul 2021 08:41:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u16sm12443643wrw.36.2021.07.16.08.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 08:41:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4] test-lib-functions: use test-tool for [de]packetize()
Date:   Fri, 16 Jul 2021 17:41:33 +0200
Message-Id: <patch-1.1-546974eed59-20210716T153909Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.gfa1990a4f10
In-Reply-To: <cover-0.5-0000000000-20210714T005115Z-avarab@gmail.com>
References: <cover-0.5-0000000000-20210714T005115Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The shell+perl "[de]packetize()" helper functions were added in
4414a150025 (t/lib-git-daemon: add network-protocol helpers,
2018-01-24), and around the same time we added the "pkt-line" helper
in 74e70029615 (test-pkt-line: introduce a packet-line test helper,
2018-03-14).

For some reason it seems we've mostly used the shell+perl version
instead of the helper since then. There were discussions around
88124ab2636 (test-lib-functions: make packetize() more efficient,
2020-03-27) and cacae4329fa (test-lib-functions: simplify packetize()
stdin code, 2020-03-29) to improve them and make them more efficient.

There was one good reason to do so, we needed an equivalent of
"test-tool pkt-line pack", but that command wasn't capable of handling
input with "\n" (a feature) or "\0" (just because it happens to be
printf-based under the hood).

Let's add a "pkt-line-raw" helper for that, and expose is at a
packetize_raw() to go with the existing packetize() on the shell
level, this gives us the smallest amount of change to the tests
themselves.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

I ejected changing/adding test code for this v4. This keeps the
compatibility wrappers and just narrowly changes the things that need
a packetize_raw() to use that new helper.

I left the simpler packetize() case as a "printf", it could also use
the test tool, but in case someone cares about process overhead on say
Windows this entire change should be strictly better than the status
quo.

Range-diff against v3:
1:  67aa8141153 < -:  ----------- serve tests: add missing "extra delim" test
2:  64dfd14865c < -:  ----------- serve tests: use test_cmp in "protocol violations" test
3:  92bfd8a87b8 < -:  ----------- tests: replace [de]packetize() shell+perl test-tool pkt-line
4:  9842c85d1f3 ! 1:  546974eed59 tests: replace remaining packetize() with "test-tool pkt-line"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    tests: replace remaining packetize() with "test-tool pkt-line"
    +    test-lib-functions: use test-tool for [de]packetize()
     
    -    Move the only remaining users of "packetize()" over to "test-tool
    -    pkt-line", for this we need a new "pack-raw-stdin" subcommand in the
    -    test-tool. The "pack" command takes input on stdin, but splits it by
    -    "\n", furthermore we'll format the output using C-strings, so the
    -    embedded "\0" being tested for here would cause the string to be
    -    truncated.
    +    The shell+perl "[de]packetize()" helper functions were added in
    +    4414a150025 (t/lib-git-daemon: add network-protocol helpers,
    +    2018-01-24), and around the same time we added the "pkt-line" helper
    +    in 74e70029615 (test-pkt-line: introduce a packet-line test helper,
    +    2018-03-14).
     
    -    So we need another mode that just calls packet_write() on the raw
    -    input we got on stdin.
    +    For some reason it seems we've mostly used the shell+perl version
    +    instead of the helper since then. There were discussions around
    +    88124ab2636 (test-lib-functions: make packetize() more efficient,
    +    2020-03-27) and cacae4329fa (test-lib-functions: simplify packetize()
    +    stdin code, 2020-03-29) to improve them and make them more efficient.
    +
    +    There was one good reason to do so, we needed an equivalent of
    +    "test-tool pkt-line pack", but that command wasn't capable of handling
    +    input with "\n" (a feature) or "\0" (just because it happens to be
    +    printf-based under the hood).
    +
    +    Let's add a "pkt-line-raw" helper for that, and expose is at a
    +    packetize_raw() to go with the existing packetize() on the shell
    +    level, this gives us the smallest amount of change to the tests
    +    themselves.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ t/t5411/once-0010-report-status-v1.sh: test_expect_success "proc-receive: report
      		then
      			printf "%s %s refs/heads/main\0report-status\n" \
     -				$A $B | packetize
    -+				$A $B | test-tool pkt-line pack-raw-stdin
    ++				$A $B | packetize_raw
      		else
      			printf "%s %s refs/heads/main\0report-status object-format=$GIT_DEFAULT_HASH\n" \
     -				$A $B | packetize
    -+				$A $B | test-tool pkt-line pack-raw-stdin
    ++				$A $B | packetize_raw
      		fi &&
    - 		test-tool pkt-line pack <<-EOF &&
    - 		$ZERO_OID $A refs/for/main/topic1
    + 		printf "%s %s refs/for/main/topic1\n" \
    + 			$ZERO_OID $A | packetize &&
     
      ## t/t5562-http-backend-content-length.sh ##
     @@ t/t5562-http-backend-content-length.sh: test_expect_success 'setup' '
    @@ t/t5562-http-backend-content-length.sh: test_expect_success 'setup' '
      	{
      		printf "%s %s refs/heads/newbranch\\0report-status object-format=%s\\n" \
     -			"$ZERO_OID" "$hash_next" "$(test_oid algo)" | packetize &&
    -+			"$ZERO_OID" "$hash_next" "$(test_oid algo)" |
    -+			test-tool pkt-line pack-raw-stdin &&
    ++			"$ZERO_OID" "$hash_next" "$(test_oid algo)" | packetize_raw
      		printf 0000 &&
      		echo "$hash_next" | git pack-objects --stdout
      	} >push_body &&
    @@ t/t5570-git-daemon.sh: test_expect_success 'hostname cannot break out of directo
      test_expect_success FAKENC 'hostname interpolation works after LF-stripping' '
      	{
     -		printf "git-upload-pack /interp.git\n\0host=localhost" | packetize
    --		printf "0000"
    -+		printf "git-upload-pack /interp.git\n\0host=localhost" |
    -+		test-tool pkt-line pack-raw-stdin &&
    -+		test-tool pkt-line pack <<-\EOF
    -+		0000
    -+		EOF
    ++		printf "git-upload-pack /interp.git\n\0host=localhost" | packetize_raw
    + 		printf "0000"
      	} >input &&
    -+
      	fake_nc "$GIT_DAEMON_HOST_PORT" <input >output &&
    - 	test-tool pkt-line unpack <output >actual &&
    +
    + ## t/test-lib-functions.sh ##
    +@@ t/test-lib-functions.sh: nongit () {
    + 	)
    + } 7>&2 2>&4
    + 
    +-# convert function arguments or stdin (if not arguments given) to pktline
    +-# representation. If multiple arguments are given, they are separated by
    +-# whitespace and put in a single packet. Note that data containing NULs must be
    +-# given on stdin, and that empty input becomes an empty packet, not a flush
    +-# packet (for that you can just print 0000 yourself).
    ++# These functions are historical wrappers around "test-tool pkt-line"
    ++# for older tests. Use "test-tool pkt-line" itself in new tests.
    + packetize () {
    + 	if test $# -gt 0
    + 	then
    + 		packet="$*"
    + 		printf '%04x%s' "$((4 + ${#packet}))" "$packet"
    + 	else
    +-		perl -e '
    +-			my $packet = do { local $/; <STDIN> };
    +-			printf "%04x%s", 4 + length($packet), $packet;
    +-		'
    ++		test-tool pkt-line pack
    + 	fi
    + }
    + 
    +-# Parse the input as a series of pktlines, writing the result to stdout.
    +-# Sideband markers are removed automatically, and the output is routed to
    +-# stderr if appropriate.
    +-#
    +-# NUL bytes are converted to "\\0" for ease of parsing with text tools.
    ++packetize_raw () {
    ++	test-tool pkt-line pack-raw-stdin
    ++}
    ++
    + depacketize () {
    +-	perl -e '
    +-		while (read(STDIN, $len, 4) == 4) {
    +-			if ($len eq "0000") {
    +-				print "FLUSH\n";
    +-			} else {
    +-				read(STDIN, $buf, hex($len) - 4);
    +-				$buf =~ s/\0/\\0/g;
    +-				if ($buf =~ s/^[\x2\x3]//) {
    +-					print STDERR $buf;
    +-				} else {
    +-					$buf =~ s/^\x1//;
    +-					print $buf;
    +-				}
    +-			}
    +-		}
    +-	'
    ++	test-tool pkt-line unpack
    + }
      
    + # Converts base-16 data into base-8. The output is given as a sequence of
5:  7ca83c5a551 < -:  ----------- test-lib-functions.sh: remove unused [de]packetize() functions

 t/helper/test-pkt-line.c               | 12 ++++++++
 t/t5411/once-0010-report-status-v1.sh  |  4 +--
 t/t5562-http-backend-content-length.sh |  2 +-
 t/t5570-git-daemon.sh                  |  2 +-
 t/test-lib-functions.sh                | 38 ++++++--------------------
 5 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
index 5e638f0b970..c5e052e5378 100644
--- a/t/helper/test-pkt-line.c
+++ b/t/helper/test-pkt-line.c
@@ -26,6 +26,16 @@ static void pack(int argc, const char **argv)
 	}
 }
 
+static void pack_raw_stdin(void)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	if (strbuf_read(&sb, 0, 0) < 0)
+		die_errno("failed to read from stdin");
+	packet_write(1, sb.buf, sb.len);
+	strbuf_release(&sb);
+}
+
 static void unpack(void)
 {
 	struct packet_reader reader;
@@ -110,6 +120,8 @@ int cmd__pkt_line(int argc, const char **argv)
 
 	if (!strcmp(argv[1], "pack"))
 		pack(argc - 2, argv + 2);
+	else if (!strcmp(argv[1], "pack-raw-stdin"))
+		pack_raw_stdin();
 	else if (!strcmp(argv[1], "unpack"))
 		unpack();
 	else if (!strcmp(argv[1], "unpack-sideband"))
diff --git a/t/t5411/once-0010-report-status-v1.sh b/t/t5411/once-0010-report-status-v1.sh
index 1233a46eac5..297b10925d5 100644
--- a/t/t5411/once-0010-report-status-v1.sh
+++ b/t/t5411/once-0010-report-status-v1.sh
@@ -28,10 +28,10 @@ test_expect_success "proc-receive: report status v1" '
 		if test -z "$GIT_DEFAULT_HASH" || test "$GIT_DEFAULT_HASH" = "sha1"
 		then
 			printf "%s %s refs/heads/main\0report-status\n" \
-				$A $B | packetize
+				$A $B | packetize_raw
 		else
 			printf "%s %s refs/heads/main\0report-status object-format=$GIT_DEFAULT_HASH\n" \
-				$A $B | packetize
+				$A $B | packetize_raw
 		fi &&
 		printf "%s %s refs/for/main/topic1\n" \
 			$ZERO_OID $A | packetize &&
diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index e5d3d15ba8d..05a58069b0c 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -63,7 +63,7 @@ test_expect_success 'setup' '
 	hash_next=$(git commit-tree -p HEAD -m next HEAD^{tree}) &&
 	{
 		printf "%s %s refs/heads/newbranch\\0report-status object-format=%s\\n" \
-			"$ZERO_OID" "$hash_next" "$(test_oid algo)" | packetize &&
+			"$ZERO_OID" "$hash_next" "$(test_oid algo)" | packetize_raw
 		printf 0000 &&
 		echo "$hash_next" | git pack-objects --stdout
 	} >push_body &&
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 82c31ab6cd8..b87ca06a585 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -194,7 +194,7 @@ test_expect_success 'hostname cannot break out of directory' '
 
 test_expect_success FAKENC 'hostname interpolation works after LF-stripping' '
 	{
-		printf "git-upload-pack /interp.git\n\0host=localhost" | packetize
+		printf "git-upload-pack /interp.git\n\0host=localhost" | packetize_raw
 		printf "0000"
 	} >input &&
 	fake_nc "$GIT_DAEMON_HOST_PORT" <input >output &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index b2810478a21..e5b80e0f88e 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1453,46 +1453,24 @@ nongit () {
 	)
 } 7>&2 2>&4
 
-# convert function arguments or stdin (if not arguments given) to pktline
-# representation. If multiple arguments are given, they are separated by
-# whitespace and put in a single packet. Note that data containing NULs must be
-# given on stdin, and that empty input becomes an empty packet, not a flush
-# packet (for that you can just print 0000 yourself).
+# These functions are historical wrappers around "test-tool pkt-line"
+# for older tests. Use "test-tool pkt-line" itself in new tests.
 packetize () {
 	if test $# -gt 0
 	then
 		packet="$*"
 		printf '%04x%s' "$((4 + ${#packet}))" "$packet"
 	else
-		perl -e '
-			my $packet = do { local $/; <STDIN> };
-			printf "%04x%s", 4 + length($packet), $packet;
-		'
+		test-tool pkt-line pack
 	fi
 }
 
-# Parse the input as a series of pktlines, writing the result to stdout.
-# Sideband markers are removed automatically, and the output is routed to
-# stderr if appropriate.
-#
-# NUL bytes are converted to "\\0" for ease of parsing with text tools.
+packetize_raw () {
+	test-tool pkt-line pack-raw-stdin
+}
+
 depacketize () {
-	perl -e '
-		while (read(STDIN, $len, 4) == 4) {
-			if ($len eq "0000") {
-				print "FLUSH\n";
-			} else {
-				read(STDIN, $buf, hex($len) - 4);
-				$buf =~ s/\0/\\0/g;
-				if ($buf =~ s/^[\x2\x3]//) {
-					print STDERR $buf;
-				} else {
-					$buf =~ s/^\x1//;
-					print $buf;
-				}
-			}
-		}
-	'
+	test-tool pkt-line unpack
 }
 
 # Converts base-16 data into base-8. The output is given as a sequence of
-- 
2.32.0.874.gfa1990a4f10

