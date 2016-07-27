Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3011C203EB
	for <e@80x24.org>; Wed, 27 Jul 2016 00:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbcG0AGV (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 20:06:21 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35619 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758226AbcG0AGP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 20:06:15 -0400
Received: by mail-wm0-f67.google.com with SMTP id i5so4041086wmg.2
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 17:06:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pKd5IGbkhCUC7x0aGnLX9xF5929mITllfHt66hPWOqc=;
        b=ptLy9R46Fo7i5awAOnSNkjWm/Fo6jSOUnlgV2CLoUdA9QZEDQquPPUI+LspimKxsej
         9B+WIlMl4CYW7TUT0YO3IKnrGfPWKDhQ+Gv9jW4vpbRgaG8OA/SjJon2PKGUqQk3qylE
         A2hJ6qwWy1jDw8rdWK/4/ogTRmHXBU0m8wTkGIJ04EL9KSVWwmayCN2oRv/IF0CF9dBT
         2V1ORxC+BpB711hvkRb0H5Mbqu4J1IC8ioopNVK2Uw3vzkyQKaJd5mBapV/szEzqAxp1
         NdfDpEMYawLL2T8vGUGMT0w/PetH08aDOktfH64is7WXh8XQAccOFF1nFxQqfIg/iiEf
         x4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pKd5IGbkhCUC7x0aGnLX9xF5929mITllfHt66hPWOqc=;
        b=GmM4itFNeJsTMc/UhYvRpKu+jhUhA7m1WOjJeBz38cP8V4gaYHmqoNVY6ESJCD0ODE
         cpelhF8Crj4xG91o6GmsfEYXmPL4uGGQFjYwgwqIFaelt+ATi03RFvQUzeRvI7CDaqS+
         a+dcyTVbyBQWrLQbONcXbEux/n0tobxjj0xWU65z8oTzbwSsfp7EjNLMPTvXKwKvIJuG
         xSAf8qucfU3mNyyPmaG0inu0lSR/S5dnttk2Jd0FbTipmeAGihnVBkJHtZqReAYu1L7J
         yvuNjsk79ljt9Ni+9N9qVtLr2+jKrMB+28Zi+Yfisu7pk1+I5mjNgi9G5Z7hDgJBLISy
         ZPUA==
X-Gm-Message-State: ALyK8tIyLZyKY4AFJirQUtksIcKncuWE2YEG9TuAGFE9U6y0wRkooQGtNZscslIAcfTpeA==
X-Received: by 10.28.32.15 with SMTP id g15mr47015937wmg.25.1469577974035;
        Tue, 26 Jul 2016 17:06:14 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB772A.dip0.t-ipconnect.de. [93.219.119.42])
        by smtp.gmail.com with ESMTPSA id q137sm35330015wmd.19.2016.07.26.17.06.12
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jul 2016 17:06:13 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, remi.galan-alfonso@ensimag.grenoble-inp.fr,
	pclouds@gmail.com, e@80x24.org, ramsay@ramsayjones.plus.com,
	peff@peff.net, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v2 4/5] convert: generate large test files only once
Date:	Wed, 27 Jul 2016 02:06:04 +0200
Message-Id: <20160727000605.49982-5-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160727000605.49982-1-larsxschneider@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160727000605.49982-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Generate a more interesting large test file with random characters in
between and reuse this test file in multiple tests. Run tests formerly
marked as EXPENSIVE every time but with a smaller test file.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/t0021-conversion.sh | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 7b45136..b9911a4 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -4,6 +4,13 @@ test_description='blob conversion via gitattributes'
 
 . ./test-lib.sh
 
+if test_have_prereq EXPENSIVE
+then
+	T0021_LARGE_FILE_SIZE=2048
+else
+	T0021_LARGE_FILE_SIZE=30
+fi
+
 cat <<EOF >rot13.sh
 #!$SHELL_PATH
 tr \
@@ -31,7 +38,15 @@ test_expect_success setup '
 	cat test >test.i &&
 	git add test test.t test.i &&
 	rm -f test test.t test.i &&
-	git checkout -- test test.t test.i
+	git checkout -- test test.t test.i &&
+
+	mkdir -p generated-test-data &&
+	for i in $(test_seq 1 $T0021_LARGE_FILE_SIZE)
+	do
+		# Generate 1MB of empty data and 100 bytes of random characters
+		printf "%1048576d" 1
+		printf "$(LC_ALL=C tr -dc "A-Za-z0-9" </dev/urandom | dd bs=$((RANDOM>>8)) count=1 2>/dev/null)"
+	done >generated-test-data/large.file
 '
 
 script='s/^\$Id: \([0-9a-f]*\) \$/\1/p'
@@ -199,9 +214,9 @@ test_expect_success 'required filter clean failure' '
 test_expect_success 'filtering large input to small output should use little memory' '
 	test_config filter.devnull.clean "cat >/dev/null" &&
 	test_config filter.devnull.required true &&
-	for i in $(test_seq 1 30); do printf "%1048576d" 1; done >30MB &&
-	echo "30MB filter=devnull" >.gitattributes &&
-	GIT_MMAP_LIMIT=1m GIT_ALLOC_LIMIT=1m git add 30MB
+	cp generated-test-data/large.file large.file &&
+	echo "large.file filter=devnull" >.gitattributes &&
+	GIT_MMAP_LIMIT=1m GIT_ALLOC_LIMIT=1m git add large.file
 '
 
 test_expect_success 'filter that does not read is fine' '
@@ -214,15 +229,15 @@ test_expect_success 'filter that does not read is fine' '
 	test_cmp expect actual
 '
 
-test_expect_success EXPENSIVE 'filter large file' '
+test_expect_success 'filter large file' '
 	test_config filter.largefile.smudge cat &&
 	test_config filter.largefile.clean cat &&
-	for i in $(test_seq 1 2048); do printf "%1048576d" 1; done >2GB &&
-	echo "2GB filter=largefile" >.gitattributes &&
-	git add 2GB 2>err &&
+	echo "large.file filter=largefile" >.gitattributes &&
+	cp generated-test-data/large.file large.file &&
+	git add large.file 2>err &&
 	test_must_be_empty err &&
-	rm -f 2GB &&
-	git checkout -- 2GB 2>err &&
+	rm -f large.file &&
+	git checkout -- large.file 2>err &&
 	test_must_be_empty err
 '
 
-- 
2.9.0

