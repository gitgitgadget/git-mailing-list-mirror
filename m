Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 623D31FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938986AbcHJS5y (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:57:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36508 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S938915AbcHJS5v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:57:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id i138so11311378wmf.3
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 11:57:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7wsF2gd0W9rqIkBWAGmx2Lyu2G8CRPW166gvfmaK9Lk=;
        b=qYr8uwUHbrRbvIRgX1Uvx+SOAmK4hkCZJvg8jsgHYpekGwB+cANhARPHN3Fn25s563
         XScwOP78W3NY+g1NXgt9XjDFjoTMNYmrgjjB/jHGJSscqkdJD0IHbSaFO9bvArobW5gU
         42Jl7z44mz1u4HItLcS9+9fGfdHxwegWXLEK+aua9sKfPYmEFliPOMk3XVyfUD4KIB3z
         C/hHAFyBBSh3idgMVHjklhGRMaSmoIkik5JFsnDNJNvCCV/XzjRarsN7u/Nrs/bhfwWB
         /TPGsQK/iHQfqmq/3/++Z6hGeWg0MTjQ0pqdFnLJtASXVoF7KPaGtzFKSvaPow0DsHT5
         kr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7wsF2gd0W9rqIkBWAGmx2Lyu2G8CRPW166gvfmaK9Lk=;
        b=SaxYGaaDzx/hLsLsvD5VGT/7l6WlLoVWRYi/CzBC8ozT4dPhyxl/Lg03sFO6VLYuuU
         etA0JQrfSfAWMtWn0S+lrP9v5wwFpnMUx3Qx5iOeWrJr5YTGCxA1nPBAe7ubHlDD0y8U
         Lj4h/7mJpOu2tGBcnyqH00keUq98+ruBNHYjDmhgVt9RMm95Nk9H0ypQlECcbrPU8Caa
         mbjt5iP5sF+yL7CcnxDmonlajHO5/kFQ6mDCVz5u1B38GCOa2o+t14JyJ+efMeh59aF7
         bp4Tnmf4MP/+Ya0h+2riGZebEcdg9vfsqfhgCDYGom/T38Ly20lvpzU7oFtZC7aNeRP4
         Q3sQ==
X-Gm-Message-State: AEkoouvDbt91msrhP57IysNLaPEWSiFLsIAe4a3L8/+t1bHgJflAkfWlEjIKVIvrVfwUAA==
X-Received: by 10.28.230.205 with SMTP id e74mr3401982wmi.42.1470834265075;
        Wed, 10 Aug 2016 06:04:25 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id p83sm8319899wma.18.2016.08.10.06.04.24
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 06:04:24 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, mlbright@gmail.com,
	e@80x24.org, peff@peff.net, Johannes.Schindelin@gmx.de,
	ben@wijen.net, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v5 12/15] convert: generate large test files only once
Date:	Wed, 10 Aug 2016 15:04:08 +0200
Message-Id: <20160810130411.12419-13-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160810130411.12419-1-larsxschneider@gmail.com>
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
 <20160810130411.12419-1-larsxschneider@gmail.com>
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
2.9.2

