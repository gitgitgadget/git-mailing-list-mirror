Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE8EEB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 18:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbjGESBK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 14:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbjGESBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 14:01:09 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AF21998
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 11:01:06 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b852785a65so7578315ad.0
        for <git@vger.kernel.org>; Wed, 05 Jul 2023 11:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688580066; x=1691172066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DiJShljwFHtCfkWyVJlHh1MxIIdNxvRBjZaaZzUmtY=;
        b=ACvie7NU8QP5JlSWwkWAiCePErvcCM+DvHH004R4CIuj4rl7SfXXyOYjvsrnsjJGtD
         0AYD5dHqgRAeNOZR9O4Xh6XKRdyPj7u4vFjxS+ek8iKru8Jx+5ktiu1PNS+48KsT/xps
         9/4MMdoxOhVNcHuyc+ppHePtr5+LMshSOJmoUCZ2g/frWgNZ8uDbmam53jamCZUI+oOw
         zbMlGMAfdWTF+2SdITwLW9prdi81W8sw3aqcSiiImdADJlolBrQT6jzNizhE5xYtY5n1
         bacny51vvuK+P375o4gkIf37BX/k5k2AT0F+U90d2yooBv+kGyRNuxHNKzitrT8pJPM4
         jC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688580066; x=1691172066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DiJShljwFHtCfkWyVJlHh1MxIIdNxvRBjZaaZzUmtY=;
        b=IGYOZc5ZGTCgvJfxbwvEuYkCtMORi/PsYeGOyTLNzGDsGH+W7mp8U4MXmEioNYWZyG
         QHEnvqf8v9vdwNF35bOAyHSfXrjM/GoMSPXO9bNKQYZcUK/4INcI9MjVNSwtwm8nIWnE
         c3CTWlKxsNSFWLbOL/bphL9pxF7X3/xh4hdSy/yqbeMGDWBnU+yddZi0Ukb3o1qYe1ys
         QkYEP2kYbmIEk8kruIJoBiGkvF6t6td4WHfUNNkvNowv1MakEEExSx1LfNQWfQfrZ/SG
         OfajtXMuXJSQfkn1yvUHH8f2+D5J07XDWz+O7nfcC/kJm/Ay432j0IajOKZc/Sv8Ffk4
         ef+Q==
X-Gm-Message-State: ABy/qLZp0mGkUbF4mFnZSOnq0sNkHvGIbRBXQF8xuwRhFmwApvGXwEvy
        EZqAswmtoeSMBEBgRHGxgBd1cY3+4Elqqw==
X-Google-Smtp-Source: APBJJlEjMU6+M+/i1ZHJMAx6gs9REmx9Jm9PAAAGpDUNBDtUanBw1nMApqiYvYDK6VT8eLfQLrZtgQ==
X-Received: by 2002:a17:902:c950:b0:1b5:522a:1578 with SMTP id i16-20020a170902c95000b001b5522a1578mr4320346pla.29.1688580065800;
        Wed, 05 Jul 2023 11:01:05 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.158.68])
        by smtp.gmail.com with ESMTPSA id 18-20020a631452000000b005539d676060sm18194010pgu.29.2023.07.05.11.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 11:01:05 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Rene Scharfe <l.s.r@web.de>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: [PATCH 2/2] t6300: run describe atom tests on a different repo
Date:   Wed,  5 Jul 2023 23:27:12 +0530
Message-ID: <20230705175942.21090-3-five231003@gmail.com>
X-Mailer: git-send-email 2.41.0.29.g8148156d44.dirty
In-Reply-To: <20230705175942.21090-1-five231003@gmail.com>
References: <20230705175942.21090-1-five231003@gmail.com>
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
2.41.0.237.g2d10a112d6.dirty

