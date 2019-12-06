Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B5CC2BBE2
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 19:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD55E2467A
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 19:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJBbNk2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfLFTDn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 14:03:43 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:37242 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfLFTDm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 14:03:42 -0500
Received: by mail-wm1-f41.google.com with SMTP id f129so8401469wmf.2
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 11:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bFBObAohbnDPuC/lP+UX9a/nOUfyslN1OyKzum4UjVU=;
        b=pJBbNk2+i7BGqYCrKohmVmVLKK7zDcomGlhJvkfIVVD5fik21xL5FwDdHToRA21kyV
         etOmSpMiE/Ok+/qhwmhcdeAtXAITghzjtGb0oPagtr2j68t/ywDN60xaSs675kXc2dO/
         1M8mX/I3bFNBBj2k9OaZ6i6Twpxa8/XU6gCAUpWkSaXSbwfp/yVGWnt6cuzkxE+ViRiK
         WfLBasD1L2qrrs2RLbgWrRqicf8dk7rtxbfZLcpFG9dKnj3lTTiceNqk7l28z/3trj8u
         ArUOC+uaEU4WC6+8uGtf6QPgnNbJOPAma5/f3TT1fe9HqZUSXgTQyntVvDsEJ99YtSBH
         /3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bFBObAohbnDPuC/lP+UX9a/nOUfyslN1OyKzum4UjVU=;
        b=U2WAacG2Gf3hzGW07LMipSZPJJMT+2d6olYtdJsvPidOnJNicbINPAyuSRFgDNnqYC
         0pvhjQigJP9v/kr2I1KiNW/6O7n6qbc2F6pBlWeLK4rlgRlv9t9VL82QbEv1HlCRFDuk
         zEXrTQIArAe4s4XK3If1BvMEiGcEy1/Nz+w5M5+Y3xSGggOPZghcfhBf+jWu2JxM6GAE
         jIncbSgyqMH0mXh3y1CHm+hvVgq/ub26KgwPtcvcUvC2tSrTr3J/nzhQRRdvv0aNoeIH
         /Rp9Gd9qF7PnzpTj3+oK0J66ec9JlmUo87SaEXe2HlpXlYNCIODiFVuEMp83b+oXZbbu
         5ErQ==
X-Gm-Message-State: APjAAAUZt9G9z+cEshAZGrsmb+NSOpdnXbUKmXG1UBRpQtMmfUjWY2+G
        t8k5iEhe3zAX96bao11dZjg=
X-Google-Smtp-Source: APXvYqw0GQvK1qSnc0BFzYx2+PlAjzoqFEOg/7Tog9Ytt++ntGyeJ/4Y5dqtMuoXvYlxQ5LKqzjHeA==
X-Received: by 2002:a1c:4e03:: with SMTP id g3mr12497087wmh.22.1575659020870;
        Fri, 06 Dec 2019 11:03:40 -0800 (PST)
Received: from localhost.localdomain (x4d0c7a95.dyn.telefonica.de. [77.12.122.149])
        by smtp.gmail.com with ESMTPSA id d19sm4399100wmd.38.2019.12.06.11.03.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Dec 2019 11:03:40 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 2/2] t9300-fast-import: don't hang if background fast-import exits too early
Date:   Fri,  6 Dec 2019 20:03:31 +0100
Message-Id: <20191206190331.29443-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.801.g241c134b8d
In-Reply-To: <20191206190331.29443-1-szeder.dev@gmail.com>
References: <20191130104644.17350-1-szeder.dev@gmail.com>
 <20191206190331.29443-1-szeder.dev@gmail.com>
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
feeding instructions to its standard input through a fifo (fd 8) from
a background subshell, and reading and verifying its standard output
through another fifo (fd 9) in the test script's main shell process.
This "reading and verifying" is basically a 'while read ...' shell
loop iterating until 'git fast-import' outputs the expected line,
ignoring any other output.  This doesn't work very well when 'git
fast-import' dies before printing that particular line, because the
'read' builtin doesn't get EOF after the death of 'git fast-import',
as their input and output are not connected directly but through a
fifo.  Consequently, that 'read' hangs waiting for the next line from
the already dead 'git fast-import', leaving the test script and in
turn the whole test suite hanging.

Avoid this hang by checking whether the background 'git fast-import'
process exited unexpectedly early, and interrupt the 'while read' loop
if it did.  We have to jump through some hoops to achive that, though:

  - Start the background 'git fast-import' in another background
    subshell, which then:

      - prints the PID of that 'git fast-import' process to the fifo,
	to be read by the main shell process, so it will know which
	process to kill when the test is finished.

      - waits until that 'git fast-import' process exits.  If it does
	exit, then report its exit code, and write a message to the
	fifo used for 'git fast-import's standard output, thus
	un-block the 'read' builtin in the main shell process.

  - Modify that 'while read' loop to break the loop upon seeing that
    message, and fail the test in the usual way.

  - Once the test is finished kill that background subshell as well,
    and do so before killing the background 'git fast-import'.
    Otherwise the background 'git fast-import' and subshell processes
    would die racily, and if 'git fast-import' were to die sooner,
    then we might get some undesired and potentially confusing
    messages in the test's output.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t9300-fast-import.sh | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 6820ebbb63..8f6f80f021 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3164,12 +3164,21 @@ background_import_then_checkpoint () {
 	exec 9<>V.output
 	rm V.output
 
-	git fast-import $options <&8 >&9 &
-	fi_pid=$!
+	(
+		git fast-import $options <&8 >&9 &
+		echo $! >&9
+		wait $!
+		echo >&2 "background fast-import terminated too early with exit code $?"
+		# Un-block the read loop in the main shell process.
+		echo >&9 UNEXPECTED
+	) &
+	sh_pid=$!
+	read fi_pid <&9
 	# We don't mind if fast-import has already died by the time the test
 	# ends.
 	test_when_finished "
 		exec 8>&-; exec 9>&-;
+		kill $sh_pid && wait $sh_pid
 		kill $fi_pid && wait $fi_pid
 		true"
 
@@ -3190,6 +3199,9 @@ background_import_then_checkpoint () {
 		then
 			error=0
 			break
+		elif test "$output" = "UNEXPECTED"
+		then
+			break
 		fi
 		# otherwise ignore cruft
 		echo >&2 "cruft: $output"
-- 
2.24.0.801.g241c134b8d

