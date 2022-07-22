Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62D3C433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 19:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbiGVTnP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 15:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236544AbiGVTnN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 15:43:13 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940A88213E
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 12:43:11 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-10d6e8990b9so7497602fac.7
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3P7bKPM8JYtG1JM3i8hUdQbPzKAIuzG2Xy2Ehm03naU=;
        b=h/wu8plB1bS+EjThyETAjuuyIlpivDktrT+L0tNd1cy84WLB+Kd4nhBeZKsnab3rez
         uNMd5+UXJDVPfvCKoUrr03ESOKrdRhJNcIKngNcxhIoZ8mZH28ozi9z5cxuaJcLp/yHb
         TMxoKJC+knynFw9Jy2a9ySJbW/lcdBhywx6s1prBijVfznWDQm/dj3rLfUe6Q1HhvGJV
         gDsomU4guurNILSjogwdDTM/OdsFahx63gkqt28N5aaORpBzcG9oF/csHyFf0b6yXymn
         296UTxZSUxuq6sJTwW76H4JloEe/860FyOG9QvkGeHPBxLujsCzeTheIvwAq0/zVtSph
         Rsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3P7bKPM8JYtG1JM3i8hUdQbPzKAIuzG2Xy2Ehm03naU=;
        b=KfLCkqvGd1rHlVYVWocHGxUP06RRa2pKVPC+K3thlUFu7c5YHHxPMzVGWXh2LU0LhS
         1nh9NR/PRfKnzrFtxgOnNSz2ScZdU62u8aUPZrEDs0099U4hubpI91vZL5q6CxpfGjyi
         6Xxt355B6fvdgWeh/L9NLvJ2E5Wd2C4EXI4NdWAH8fs69ZGmwkCF0nqUlEWdDFY40fXX
         6husJKKfby935Ml7TdaP1RBYfoA2/0GwavVPG/gjaT4Joy5jDrwajrlKM7ylR0YLe7Pn
         GwkP7+MZiLBLc60SfQXb5W8yomEov98w8xQKaGg8kUZXCIZ+IO8RETNqUqjY617LFSfU
         zVuA==
X-Gm-Message-State: AJIora90eAIV7IAdkXJjS2wDmNffxOhiyyokDKtnl6Y02VcF8fzIQmZh
        vtQTauZkUqvbwLD/Sko7B16mM+geC3O3SQ==
X-Google-Smtp-Source: AGRyM1uzifASsNtxqbsvBQSojoL4/OkkwGplZNVvQtsQO/9RWpWOKmYMmcnLts0Rz3wBh4jcsszflQ==
X-Received: by 2002:a05:6870:231b:b0:10b:7a08:bfbf with SMTP id w27-20020a056870231b00b0010b7a08bfbfmr8310166oao.11.1658518990604;
        Fri, 22 Jul 2022 12:43:10 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id w4-20020a4aa444000000b0041ba884d42csm2162093ool.42.2022.07.22.12.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 12:43:10 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com,
        christian.couder@gmail.com
Subject: [PATCH 2/2] t/t0021: replace old rot13-filter.pl uses with new test-tool cmd
Date:   Fri, 22 Jul 2022 16:42:50 -0300
Message-Id: <3b0240c1b92dfb441e9b307a7896145a713ee168.1658518769.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1658518769.git.matheus.bernardino@usp.br>
References: <cover.1658518769.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Complete the perl-to-C conversion from the previous commit by actually
removing the old perl script and adjusting the test cases to directly
call "test-tool rot13-filter".

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/t0021-conversion.sh                   | 69 ++++++++++++-------------
 t/t0021/rot13-filter.pl                 |  5 --
 t/t2080-parallel-checkout-basics.sh     |  7 +--
 t/t2082-parallel-checkout-attributes.sh |  7 +--
 4 files changed, 37 insertions(+), 51 deletions(-)
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
index 1447bc0a24..0000000000
--- a/t/t0021/rot13-filter.pl
+++ /dev/null
@@ -1,5 +0,0 @@
-use 5.008;
-
-my @quoted_args = map "'$_'", @ARGV;
-exec "test-tool rot13-filter @quoted_args";
-die "failed to exec test-tool";
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

