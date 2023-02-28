Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7950C7EE30
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 23:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjB1XjU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 18:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjB1XjR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 18:39:17 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC031A4BF
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 15:39:16 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id n5so6837764pfv.11
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 15:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIM66mQfoMWy246+UTzcOvzWZnl4Uatjclm6VFhIvSY=;
        b=brSgDiCvuxdkTilL3FpaWOJ6r1sdD2a5SLjVSkfir3R6VcoN/5ZhA0FV4LmlJFKn/c
         FiNSSjGYk5pYS5qUhcAsi/23OHw87rtWM0ggNeKhVCfRfjxyp6z2bsaN9tCkz+ZfHk01
         U79tDYGIxQpRmrZGR1vbH87JEKjTWFhSkUb+Gyl1ElWcVANt4gErYu6e7l9JKc+3ZQVg
         YhWTTKWjaS9qecWG+gUtP8LSyCX/f9NaoYX+Bq6xBe6BZVoTGY/n9+wVmnPhiP3XZYFN
         j1woHoV9Fng65svxmVRXu1d4jmFiy7kpDnznxYaPoeGtn12qBJp1WV3AJo0recPgB0FN
         pVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mIM66mQfoMWy246+UTzcOvzWZnl4Uatjclm6VFhIvSY=;
        b=jW9H0Fsfebxuui/gsRiF8VxushJWcTLfOCWw28Cpc7zok24eoynngrkTWftuq8BexE
         54spgxaVVGQa2SUnerKLbwwev6A/4muSyaNIbLJ5/cwBBewfmN5y764H0wUHoP7DCVkB
         7g3GZPAZvVBXssiIOcKUsP/vuGegTiuLvtbRUBnskxy4GPzRk98CVLFF1iDbCQbHwn5U
         FCaagqS4/YTCOuBfUvKZApe3jGvi90N0Q/FTzid+kdqrLdr62OdhCis4Ah6TgDE1qDsR
         7Q/pXYO64sjvG02q8VWZbJzy5cIEDqLr2iWQ/ZyXO8XxnpdLe6oEjifM3Wz3XaiYVjwk
         UysQ==
X-Gm-Message-State: AO0yUKWKkJS1LboaQBRq7yrLwO0/D/OlnYIdXqjREbb4NNTzv0zv3E4I
        L9a6ivix6jKm+vdh6tfCUMlD+BOrEm8=
X-Google-Smtp-Source: AK7set+RZQStgbKRVBgJ4fNtdSwrbOkDfno0T6GOjTQDeHveMw3hFSCfKXmV/O0mDMod0D9SZEgExg==
X-Received: by 2002:a62:79cb:0:b0:5a9:c16f:b4ea with SMTP id u194-20020a6279cb000000b005a9c16fb4eamr4874766pfc.7.1677627555996;
        Tue, 28 Feb 2023 15:39:15 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79111000000b005e00086250asm6512547pfh.125.2023.02.28.15.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 15:39:15 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 03/20] t5541: simplify and move "no empty path components" test
Date:   Tue, 28 Feb 2023 15:38:56 -0800
Message-Id: <20230228233913.684853-3-gitster@pobox.com>
X-Mailer: git-send-email 2.40.0-rc0-32-ga0f05f6840
In-Reply-To: <20230228233913.684853-1-gitster@pobox.com>
References: <20230228233913.684853-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Commit 9ee6bcd398 (t5541-http-push: add test for URLs with trailing
slash, 2010-04-08) added a test that clones a URL with a trailing slash,
and confirms that we don't send a doubled slash (like "$url//info/refs")
to the server.

But this test makes no sense in t5541, which is about pushing. It should
have been added in t5551. Let's move it there.

But putting it at the end is tricky, since it checks the entire contents
of the Apache access log. We could get around this by clearing the log
before our test. But there's an even simpler solution: just make sure no
doubled slashes appear in the log (fortunately, "http://" does not
appear in the log itself).

As a bonus, this also lets us drop the check for the v0 protocol (which
is otherwise necessary since v2 makes multiple requests, and
check_access_log insists on exactly matching the number of requests,
even though we don't care about that here).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5541-http-push-smart.sh  | 18 ------------------
 t/t5551-http-fetch-smart.sh |  9 +++++++++
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index f8bf533c33..d0211cd8be 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -36,24 +36,6 @@ test_expect_success 'setup remote repository' '
 
 setup_askpass_helper
 
-cat >exp <<EOF
-GET  /smart/test_repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
-POST /smart/test_repo.git/git-upload-pack HTTP/1.1 200
-EOF
-test_expect_success 'no empty path components' '
-	# In the URL, add a trailing slash, and see if git appends yet another
-	# slash.
-	cd "$ROOT_PATH" &&
-	git clone $HTTPD_URL/smart/test_repo.git/ test_repo_clone &&
-
-	# NEEDSWORK: If the overspecification of the expected result is reduced, we
-	# might be able to run this test in all protocol versions.
-	if test "$GIT_TEST_PROTOCOL_VERSION" = 0
-	then
-		check_access_log exp
-	fi
-'
-
 test_expect_success 'clone remote repository' '
 	rm -rf test_repo_clone &&
 	git clone $HTTPD_URL/smart/test_repo.git test_repo_clone &&
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index bc0719a4fc..10b7e7cda2 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -666,4 +666,13 @@ test_expect_success 'push warns or fails when using username:password' '
 	test_line_count -ge 1 warnings
 '
 
+test_expect_success 'no empty path components' '
+	# In the URL, add a trailing slash, and see if git appends yet another
+	# slash.
+	git clone $HTTPD_URL/smart/repo.git/ clone-with-slash &&
+
+	strip_access_log >log &&
+	! grep "//" log
+'
+
 test_done
-- 
2.40.0-rc0-32-ga0f05f6840

