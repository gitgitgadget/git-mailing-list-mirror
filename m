Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0170EC001DC
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 19:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbjGNTn3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 15:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbjGNTn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 15:43:27 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD322D57
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 12:43:19 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-262cc036fa4so1205099a91.3
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689363798; x=1691955798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PulRkw7tNkYBiDShmlY+qsgl0+6GG/LqbAZrLM0NDzI=;
        b=Zz5bgaftjX+1FIeO/eRxKxI1pmrSIcsPWNmm4km+gSSUgjdRQMTV3jFbutLXat8H0t
         eOCRtMMfqP899E1WvEHqsYFAjG8kUEThYmi4pb/wl24C9XliMpqZG1MpQkpi6+oi8OCA
         jO4lnVw3OgXY69lyqiLB9gk2WDp9hl0h1aLHAaxWoyjQqbPI18x3IYUFcMpqsNF6AX3N
         AAPp6eO907AyyDK3zx9bsMLT2neJNfCjR6vVh5A8BSnq8hzduOVZPTnqPuL3VPgjMsXb
         EFUJOpooGFW3EK0gO2x3uB1E0gS8xLNvOIQsGqXFlQYy/90mtHxN9s1us06DfPhS4dP0
         4sxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689363798; x=1691955798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PulRkw7tNkYBiDShmlY+qsgl0+6GG/LqbAZrLM0NDzI=;
        b=bSuUlRX2mfIVufwFVmZPWFUY3KioJx3iUmFy9XbV6OW0jTGmcdUe2d6OgNfeShMx4j
         V+H9GoSDqMJqkfM5issDncW5TjcrC61gdFeUKEWGNc7fTkkE4zatCqacRGJKzOdfKrtv
         DPfwumWc9278frUEtH7cz99r0lKgstcpR3lziWB2ak9zTw0h5b4Km3leKEkowPhPeBgK
         yHfT7hlbF8MH5xdDDbmGXNgWB30EMvHaa+0Y7fY18pjegvQCnY0nWiPWjeMLnQrFNfzZ
         L11lge1+stijufrHQrLsw+UstFrYQHz7EfALNkWQ5n5sj5Jwulvzjc6hksx6EdObKB43
         Zmzw==
X-Gm-Message-State: ABy/qLYGD7zIMwBvS9Rm7tDCIYQDH/16CaU2qLD9LsUTThp95IV+gjBD
        tek+nTJRYndt4tod6juP7sWgohmBybg=
X-Google-Smtp-Source: APBJJlF/3KAoRW/r9u7v2RU2tV3nHl8SGExBkj77iO0DrsY92Dm3LJj9w3PJ+EeqA0uQ0qp+ITrLgA==
X-Received: by 2002:a17:90a:db87:b0:263:6ccd:38b5 with SMTP id h7-20020a17090adb8700b002636ccd38b5mr3920810pjv.1.1689363798517;
        Fri, 14 Jul 2023 12:43:18 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.159.128])
        by smtp.gmail.com with ESMTPSA id u63-20020a17090a51c500b00260a5ecd273sm1514820pjh.1.2023.07.14.12.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 12:43:18 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: [PATCH v2 3/3] t6300: run describe atom tests on a different repo
Date:   Sat, 15 Jul 2023 00:50:28 +0530
Message-ID: <20230714194249.66862-4-five231003@gmail.com>
X-Mailer: git-send-email 2.41.0.29.g8148156d44.dirty
In-Reply-To: <20230714194249.66862-1-five231003@gmail.com>
References: <20230705175942.21090-1-five231003@gmail.com>
 <20230714194249.66862-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tests for "describe" atom and its friends currently run on the main
repo of t6300, expect for the test for "bare describe", which is run on
"describe-repo".

Things can get messy with the other tests when such changes to a repo
are done (for example, a new commit or a tag is introduced), especially
in t6300 where the tests depend on commits and tags.

An example for this can be seen in [1], where writing the tests the
current way fails the test "Verify sorts with raw:size" on linux-sha256.
This, at first glance, seems totally unrelated.

Digging in a bit deeper, it is apparent that this behavior is because of
the changes in the repo introduced when writing the "describe" tests,
which changes the raw:size of an object. Such a change in raw-size would
have been, however, small if we were dealing with SHA1, but since we are
dealing with SHA256, the change in raw:size is so significant that it
fails the above mentioned test.

So, run all the "describe" atom tests on "describe-repo", which doesn't
interfere with the main repo on which the tests in t6300 are run.

[1]: https://github.com/five-sh/git/actions/runs/5446892074/jobs/9908256427

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 t/t6300-for-each-ref.sh | 101 +++++++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 44 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 98ea37d336..181b04e699 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -561,9 +561,7 @@ test_expect_success 'color.ui=always does not override tty check' '
 	test_cmp expected.bare actual
 '
 
-test_expect_success 'describe atom vs git describe' '
-	test_when_finished "rm -rf describe-repo" &&
-
+test_expect_success 'setup for describe atom tests' '
 	git init describe-repo &&
 	(
 		cd describe-repo &&
@@ -572,9 +570,16 @@ test_expect_success 'describe atom vs git describe' '
 		git tag tagone &&
 
 		test_commit --no-tag two &&
-		git tag -a -m "tag two" tagtwo &&
+		git tag -a -m "tag two" tagtwo
+	)
+'
+
+test_expect_success 'describe atom vs git describe' '
+	(
+		cd describe-repo &&
 
-		git for-each-ref refs/tags/ --format="%(objectname)" >obj &&
+		git for-each-ref --format="%(objectname)" \
+			refs/tags/ >obj &&
 		while read hash
 		do
 			if desc=$(git describe $hash)
@@ -596,54 +601,62 @@ test_expect_success 'describe atom vs git describe' '
 '
 
 test_expect_success 'describe:tags vs describe --tags' '
-	test_when_finished "git tag -d tagname" &&
-	git tag tagname &&
-	git describe --tags >expect &&
-	git for-each-ref --format="%(describe:tags)" refs/heads/ >actual &&
-	test_cmp expect actual
+	(
+		cd describe-repo &&
+		git describe --tags >expect &&
+		git for-each-ref --format="%(describe:tags)" \
+				refs/heads/ >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'describe:abbrev=... vs describe --abbrev=...' '
-	test_when_finished "git tag -d tagname" &&
-
-	# Case 1: We have commits between HEAD and the most
-	#         recent tag reachable from it
-	test_commit --no-tag file &&
-	git describe --abbrev=14 >expect &&
-	git for-each-ref --format="%(describe:abbrev=14)" \
-		refs/heads/ >actual &&
-	test_cmp expect actual &&
-
-	# Make sure the hash used is atleast 14 digits long
-	sed -e "s/^.*-g\([0-9a-f]*\)$/\1/" <actual >hexpart &&
-	test 15 -le $(wc -c <hexpart) &&
-
-	# Case 2: We have a tag at HEAD, describe directly gives
-	#         the name of the tag
-	git tag -a -m tagged tagname &&
-	git describe --abbrev=14 >expect &&
-	git for-each-ref --format="%(describe:abbrev=14)" \
-		refs/heads/ >actual &&
-	test_cmp expect actual &&
-	test tagname = $(cat actual)
+	(
+		cd describe-repo &&
+
+		# Case 1: We have commits between HEAD and the most
+		#	  recent tag reachable from it
+		test_commit --no-tag file &&
+		git describe --abbrev=14 >expect &&
+		git for-each-ref --format="%(describe:abbrev=14)" \
+			refs/heads/ >actual &&
+		test_cmp expect actual &&
+
+		# Make sure the hash used is atleast 14 digits long
+		sed -e "s/^.*-g\([0-9a-f]*\)$/\1/" <actual >hexpart &&
+		test 15 -le $(wc -c <hexpart) &&
+
+		# Case 2: We have a tag at HEAD, describe directly gives
+		#	  the name of the tag
+		git tag -a -m tagged tagname &&
+		git describe --abbrev=14 >expect &&
+		git for-each-ref --format="%(describe:abbrev=14)" \
+			refs/heads/ >actual &&
+		test_cmp expect actual &&
+		test tagname = $(cat actual)
+	)
 '
 
 test_expect_success 'describe:match=... vs describe --match ...' '
-	test_when_finished "git tag -d tag-match" &&
-	git tag -a -m "tag match" tag-match &&
-	git describe --match "*-match" >expect &&
-	git for-each-ref --format="%(describe:match="*-match")" \
-		refs/heads/ >actual &&
-	test_cmp expect actual
+	(
+		cd describe-repo &&
+		git tag -a -m "tag match" tag-match &&
+		git describe --match "*-match" >expect &&
+		git for-each-ref --format="%(describe:match="*-match")" \
+			refs/heads/ >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'describe:exclude:... vs describe --exclude ...' '
-	test_when_finished "git tag -d tag-exclude" &&
-	git tag -a -m "tag exclude" tag-exclude &&
-	git describe --exclude "*-exclude" >expect &&
-	git for-each-ref --format="%(describe:exclude="*-exclude")" \
-		refs/heads/ >actual &&
-	test_cmp expect actual
+	(
+		cd describe-repo &&
+		git tag -a -m "tag exclude" tag-exclude &&
+		git describe --exclude "*-exclude" >expect &&
+		git for-each-ref --format="%(describe:exclude="*-exclude")" \
+			refs/heads/ >actual &&
+		test_cmp expect actual
+	)
 '
 
 cat >expected <<\EOF
-- 
2.41.0.321.g26b82700c0.dirty

