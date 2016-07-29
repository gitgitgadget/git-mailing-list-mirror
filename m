Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EE121F855
	for <e@80x24.org>; Fri, 29 Jul 2016 23:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753531AbcG2Xid (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 19:38:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34507 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758AbcG2XiS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 19:38:18 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so17717780wma.1
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 16:38:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Twbmbqir/uGjiI674pqW5v7s40tyl8ZT4q24AhEWhaQ=;
        b=nuqJ7erOjqdv14LRgyK6YRlF64YCY3mxcPcX3tauB9iWn2tF2ojuug3MYp+CpV+1z3
         H5sLVfMTQ5+aSq8J5oa8iR1oRYrs1P3tezmHEW/w58veCLrbnk7W3U8tEu/n/HZhuPNm
         B5+ZSlP/bdfa4eQdg5WeJXwQskLiG/vCw6jJQhovGmLppqw07Cx08Gyy2q26K6sBwAU8
         GpYF2byM45RtwgcFWtK/HnLCGGuiuuaJVqx6xHTE5y+paJY9kEh+X4RcVvRjs95EfFua
         TY08X65Sqh3w1GdSCBuex9ZD4FNPS6iNWDjpeQxWmDg5zLBmgrtY2oal7PfRG+6Pqoaz
         VH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Twbmbqir/uGjiI674pqW5v7s40tyl8ZT4q24AhEWhaQ=;
        b=GlYw7FXQ9Wvj6kqnQskRmIhm+Vy/t8NRn1pyPjuezCf5wdol850Ac4uCmEfXx//ffw
         4ochMzrAh7/UmkerZnivvY6etuqPctcvMi1memVluY0qloUC/WgJnSuvxxB/5Tb8Qn1X
         b9H8wlvYsaEKs1UzvHTc2D9NmD0XBjgeNPZO1Xeb7M0cVFNJUv9haVtqKhEPceB1+DAa
         8QIcbPaCovppqqOGlR+z4C/rGjmWuehxx37YpDZXA4/TAu9Dm4UxFBeKl57XfdCVWvzq
         GcTClnw/GhKauLHN+FS9h57L+GTeHHq1X/MGmTyQ97XCKZHV5DqnbVbs8rS/O5BcMclG
         dV3Q==
X-Gm-Message-State: AEkoout3L5CbS1PcxbyYQDYkeU8uPYE8rAn/H0MovMXPsS1T74OHCTlE93Dd/IhnlD5Acw==
X-Received: by 10.28.16.3 with SMTP id 3mr3412080wmq.58.1469835496252;
        Fri, 29 Jul 2016 16:38:16 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB4145.dip0.t-ipconnect.de. [93.219.65.69])
        by smtp.gmail.com with ESMTPSA id i1sm18663212wjl.9.2016.07.29.16.38.15
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 29 Jul 2016 16:38:15 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v3 09/10] convert: generate large test files only once
Date:	Sat, 30 Jul 2016 01:38:00 +0200
Message-Id: <20160729233801.82844-10-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160729233801.82844-1-larsxschneider@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
 <20160729233801.82844-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Generate more interesting large test files with pseudo random characters
in between and reuse these test files in multiple tests. Run tests formerly
marked as EXPENSIVE every time but with a smaller data set.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/t0021-conversion.sh | 48 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 7b45136..34c8eb9 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -4,6 +4,15 @@ test_description='blob conversion via gitattributes'
 
 . ./test-lib.sh
 
+if test_have_prereq EXPENSIVE
+then
+	T0021_LARGE_FILE_SIZE=2048
+	T0021_LARGISH_FILE_SIZE=100
+else
+	T0021_LARGE_FILE_SIZE=30
+	T0021_LARGISH_FILE_SIZE=2
+fi
+
 cat <<EOF >rot13.sh
 #!$SHELL_PATH
 tr \
@@ -31,7 +40,26 @@ test_expect_success setup '
 	cat test >test.i &&
 	git add test test.t test.i &&
 	rm -f test test.t test.i &&
-	git checkout -- test test.t test.i
+	git checkout -- test test.t test.i &&
+
+	mkdir generated-test-data &&
+	for i in $(test_seq 1 $T0021_LARGE_FILE_SIZE)
+	do
+		RANDOM_STRING="$(test-genrandom end $i | tr -dc "A-Za-z0-9" )"
+		ROT_RANDOM_STRING="$(echo $RANDOM_STRING | ./rot13.sh )"
+		# Generate 1MB of empty data and 100 bytes of random characters
+		# printf "$(test-genrandom start $i)"
+		printf "%1048576d" 1 >>generated-test-data/large.file &&
+		printf "$RANDOM_STRING" >>generated-test-data/large.file &&
+		printf "%1048576d" 1 >>generated-test-data/large.file.rot13 &&
+		printf "$ROT_RANDOM_STRING" >>generated-test-data/large.file.rot13 &&
+
+		if test $i = $T0021_LARGISH_FILE_SIZE
+		then
+			cat generated-test-data/large.file >generated-test-data/largish.file &&
+			cat generated-test-data/large.file.rot13 >generated-test-data/largish.file.rot13
+		fi
+	done
 '
 
 script='s/^\$Id: \([0-9a-f]*\) \$/\1/p'
@@ -199,9 +227,9 @@ test_expect_success 'required filter clean failure' '
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
@@ -214,15 +242,15 @@ test_expect_success 'filter that does not read is fine' '
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

