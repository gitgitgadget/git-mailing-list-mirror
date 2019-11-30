Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E80C432C0
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 10:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6387C20732
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 10:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqKse+So"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfK3Kqw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 05:46:52 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:34098 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfK3Kqw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 05:46:52 -0500
Received: by mail-wr1-f50.google.com with SMTP id t2so37967607wrr.1
        for <git@vger.kernel.org>; Sat, 30 Nov 2019 02:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m/kYOfnvqTsN/KABCyvupTilnUMdseB0gsghHA8Zp1M=;
        b=MqKse+SoNW3iAqNiXA3EIPmbo+wkH7kTdxj6S0uhnu3rKvcK3t8aIkSOK8sivyTvoN
         rjn3sx1j06XH6Zboh9bupbdM2g3/1N8UAQYvUEatBtLxZB3M600e61gETe9bDpT7wTm/
         SqX+A2NJOWKOMl8nLmL35rFhTipXJsIlVtzcj22VpjdzyRY8mSiuaP8r8trQqbJcbEBD
         st/+JHX3rHdcvTvZ4hj5ha8x7NQZDA5FD4WU8OBm166hXmoIaMrmi/nH6JxKrqy1VGgO
         wJqOCAT1b9bqZ5TS+ufFtbEZQP0+UXMpX/U69OVxTPh/sHU4v0uqzSj//yRQAS1Gw5q2
         v+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m/kYOfnvqTsN/KABCyvupTilnUMdseB0gsghHA8Zp1M=;
        b=QZlBk+bXmEarAMosMrm/U4xe0u2mRoO82MROYAvfjCTGu0VulR8lvHJpsmbvcFKPfB
         aosCV6r+4PZy7jAkQ2WaSqq3GoJvhFfo57G1smGI/F1I/bILy4BEPtqN5oTo79TVN1EA
         gLhUrAJLzZbC8bYTZflU5It+i+REKv85kBtHo0+FDCcG8EiuQidQ4qBoC0Gd/+4YgGbR
         FZ4HYR7+B7xRwZnjCAPk/jORsAkrbJtFJIITGncT+2ZEtwUFCEHb0wqjn7DGpUXLERw5
         rkpNOTmLkfoWqLP672bYpDvwAN8lSkqeYZQ8Ygn4Ht+KNjOZyDkKSHiFlhtkOpQlSRqu
         lG4Q==
X-Gm-Message-State: APjAAAX+/9ULymBnFZkQ1XSQJzGofcv3XNwWR9AlozgpSFsPTISvthsw
        LDKVSaUfQDf9EHOqTgc4Buy0vW+f
X-Google-Smtp-Source: APXvYqwnJiPHZ1eQjYZkJQyaA6vpBB8PHvAW5WyykEL00slBxjStusj9MD/XOrPiozpFr7RrbACkNw==
X-Received: by 2002:adf:9185:: with SMTP id 5mr61446323wri.389.1575110808945;
        Sat, 30 Nov 2019 02:46:48 -0800 (PST)
Received: from localhost.localdomain (x4db4469b.dyn.telefonica.de. [77.180.70.155])
        by smtp.gmail.com with ESMTPSA id m3sm16272683wrs.53.2019.11.30.02.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Nov 2019 02:46:48 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t9300-fast-import: don't hang if background fast-import exits too early
Date:   Sat, 30 Nov 2019 11:46:44 +0100
Message-Id: <20191130104644.17350-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.643.gac013444ca
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The five tests checking 'git fast-import's checkpoint handling in
't9300-fast-import.sh', all with the prefix "V:" in their test
description, can hang indefinitely if 'git fast-import' unexpectedly
dies early in any of these tests.

These five tests run 'git fast-import' in the background, while
feeding instructions to its standard input through a fifo from a
background subshell, and reading and verifying its standard output
through another fifo in the test script's main shell process.  This
"reading and verifying" is basically a 'while read ...' shell loop
iterating until 'git fast-import' outputs the expected line, ignoring
any other output.  This doesn't work very well when 'git fast-import'
dies before printing that particular line, because the 'read' builtin
doesn't get EOF after the death of 'git fast-import', as their input
and output are not connected directly but through a fifo.
Consequently, that 'read' hangs waiting for the next line from the
already dead 'git fast-import', leaving the test script and in turn
the whole test suite hanging.

Avoid this hang by checking whether the background 'git fast-import'
process exited unexpectedly early, and interrupt the 'while read' loop
if it did.  We have to jump through some hoops to achive that, though:

  - Start the background 'git fast-import' in another background
    subshell, which then waits until that 'git fast-import' process
    exits.  If it does exit, then report its exit code, and write a
    message to the fifo used for 'git fast-import's standard output,
    thus un-block the 'read' builtin in the main shell process.

  - Modify that 'while read' loop to break the loop upon seeing that
    message, and fail the test in the usual way.

  - Once the test is finished kill that background subshell as well,
    and do so before killing the background 'git fast-import'.
    Otherwise the background 'git fast-import' and subshell would die
    racily, and if 'git fast-import' were to die sooner, then we might
    get some undesired and potentially confusing messages in the
    test's output.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t9300-fast-import.sh | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index e707fb861e..dcfaa9cc36 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3148,63 +3148,74 @@ test_expect_success 'U: validate root delete result' '
 # The commands in input_file should not produce any output on the file
 # descriptor set with --cat-blob-fd (or stdout if unspecified).
 #
 # To make sure you're observing the side effects of checkpoint *before*
 # fast-import terminates (and thus writes out its state), check that the
 # fast-import process is still running using background_import_still_running
 # *after* evaluating the test conditions.
 background_import_then_checkpoint () {
 	options=$1
 	input_file=$2
 
 	mkfifo V.input
 	exec 8<>V.input
 	rm V.input
 
 	mkfifo V.output
 	exec 9<>V.output
 	rm V.output
 
-	git fast-import $options <&8 >&9 &
-	echo $! >V.pid
+	(
+		git fast-import $options <&8 >&9 &
+		echo $! >V.fi.pid
+		wait $!
+		echo >&2 "background fast-import terminated too early with exit code $?"
+		# Un-block the read loop in the main shell process.
+		echo >&9 UNEXPECTED
+	) &
+	echo $! >V.sh.pid
 	# We don't mind if fast-import has already died by the time the test
 	# ends.
-	test_when_finished "
+	test_when_finished '
 		exec 8>&-; exec 9>&-;
-		kill $(cat V.pid) && wait $(cat V.pid)
-		true"
+		kill $(cat V.sh.pid) && wait $(cat V.sh.pid)
+		kill $(cat V.fi.pid) && wait $(cat V.sh.pid)
+		true'
 
 	# Start in the background to ensure we adhere strictly to (blocking)
 	# pipes writing sequence. We want to assume that the write below could
 	# block, e.g. if fast-import blocks writing its own output to &9
 	# because there is no reader on &9 yet.
 	(
 		cat "$input_file"
 		echo "checkpoint"
 		echo "progress checkpoint"
 	) >&8 &
 
 	error=1 ;# assume the worst
 	while read output <&9
 	do
 		if test "$output" = "progress checkpoint"
 		then
 			error=0
 			break
+		elif test "$output" = "UNEXPECTED"
+		then
+			break
 		fi
 		# otherwise ignore cruft
 		echo >&2 "cruft: $output"
 	done
 
 	if test $error -eq 1
 	then
 		false
 	fi
 }
 
 background_import_still_running () {
-	if ! kill -0 "$(cat V.pid)"
+	if ! kill -0 "$(cat V.fi.pid)"
 	then
 		echo >&2 "background fast-import terminated too early"
 		false
 	fi
 }
-- 
2.24.0.643.gac013444ca

