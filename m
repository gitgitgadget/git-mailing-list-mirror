Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0011A1FD99
	for <e@80x24.org>; Thu, 25 Aug 2016 11:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756808AbcHYLTi (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 07:19:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34063 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756376AbcHYLTh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 07:19:37 -0400
Received: by mail-wm0-f68.google.com with SMTP id q128so6940034wma.1
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 04:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kjwaajgyIS/lDG/3kS5QJR7k9w9ND1ySrpTSQP2ISc4=;
        b=jEhfgeTdDUKrU/9mfQBrk5nBuq7eGRcRp8F0FR6muzuqaIukgZErFlHSSWy9O1Qxch
         KuVmDhZ4jZKQdG5jHKlPLoCZLT/hSL23LNSyVZaPnGYjqdHvpqQq2kmojYy1aeymHzjh
         yrUYWn08tmeSCNNjukuJYEPTI2U0Nw7lEIXycZNR3ubkcogGn9rxjZxME0YSehOLTHlA
         iw+slC5VESYRuDZPJ7i0qZf/h3WSvZom7XqUkQaebupDkU32dsoqhdSt16OwTjxounsW
         tl5Bwkg2AwyFzhCQNME9q5a0PqLmRZgcq9VFd6iLI9WO3h2VuD7/E6/ej5PgOs2JhgHg
         hYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kjwaajgyIS/lDG/3kS5QJR7k9w9ND1ySrpTSQP2ISc4=;
        b=MhpwsuDhdWjSVZCI/+OJ+g8pb98vbGIhtNUDUSr1qAAHmr0ksR/x3DPspOaeQRY+cM
         bRSri+zIDWtB638gIoCr6Cn4kjrGuNt32UzWDRUDZ9NXLSQIDPTFq+amOBQtlTDkXdiG
         hyA3skRPhIiDQQ+B9z7wglD+RbaAy4ZPW1cNIYOxlw9tErI5FWpcTg+cNS9jQL2DZ4Sr
         inxUviwpLYJJTVtxv9OlmTQmpVabK6BzqTNU5st72RmNEGH/la8HTgnXqV231pZeouUD
         KeORe1wNrXuy0xL3RlOndjwm5qDu16RxUD5RoflrLzrVjeV4EUJQ9o2eT2qW6sb8f8+8
         li0A==
X-Gm-Message-State: AEkoous+T1rmLTIetvu2E1bstTa9dd428D8XrWAToDE/Q4y+g7LJm5Fal9UC47vidsOq8w==
X-Received: by 10.194.80.104 with SMTP id q8mr7770462wjx.151.1472123291010;
        Thu, 25 Aug 2016 04:08:11 -0700 (PDT)
Received: from bcnf9f9l32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id p71sm38304839wmf.9.2016.08.25.04.08.09
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 25 Aug 2016 04:08:10 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v6 10/13] convert: generate large test files only once
Date:   Thu, 25 Aug 2016 13:07:49 +0200
Message-Id: <20160825110752.31581-11-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160825110752.31581-1-larsxschneider@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Generate more interesting large test files with pseudo random characters
in between and reuse these test files in multiple tests. Run tests
formerly marked as EXPENSIVE every time but with a smaller data set.

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

