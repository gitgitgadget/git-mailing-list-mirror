Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F959C6FD18
	for <git@archiver.kernel.org>; Sun, 23 Apr 2023 13:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjDWNrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Apr 2023 09:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjDWNq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2023 09:46:57 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870B7171E
        for <git@vger.kernel.org>; Sun, 23 Apr 2023 06:46:56 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4edc114c716so3608343e87.1
        for <git@vger.kernel.org>; Sun, 23 Apr 2023 06:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682257614; x=1684849614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cS+eJAC+tQD6AE2KEtPmgNZ4XUTSlytBBlAUIfOxx0U=;
        b=oi6zT7cUZp5TjG6FeAWGz08gAKRCMODGlvDg10KYrhVYU/1xAq7FHBudl7o66WYyX6
         lT0awPmp79bKVwGfB76lWaOpP+3Oy40E/wbApDaPJGECjUQYu8M9aARFJNxRnPsfmSAk
         663yHYyHWou8hYJhEj5s8wPaAvYuh/vldzc0kpDqzIfZf+7Z0zAMuq5E9JDojN5rfpNO
         BOJTXD+PBv2nedhMlVqYI+zKNI4NWYo3c5v9zVKvICv09ZNFok8iGIwqFJ4kFME524Yg
         U5scHEkSh8b/68YTWn26xPNNJWRXWz0Exr1cQi5zCNyRiIgvWXvpLvseGoPtJaBYHC/m
         Q1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682257614; x=1684849614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cS+eJAC+tQD6AE2KEtPmgNZ4XUTSlytBBlAUIfOxx0U=;
        b=eULnVZM12RBsIuME2cBN4BrdCBa2mqy3kXZH4R0PrJ3p8+r6ykpRCn5/vlBmLB+942
         3RJlCbWNVQ8Tff0i3SExb9zqEh50jQ8yRawFGIlYvGJe83t9BOVLTtF24gZafDXHduWI
         vzb8GsbY0+6q71JnLq2uZ+hk4l/SZQ60OdRSvF6okeZevp+pemJQj6AAA24kymJ4BSzt
         tYnFpYn1Ks42nAmYzqOgblhQIGm9NY4M4Lg+0ll6CAbhyCk9vWN8ST79bf65pdVlSUm/
         qO2vncbuUV9lJXv7olP/+j/cieD0OwolWKUnSNlBZmeNfm1S+9RugK6uBUU18pvQ82HQ
         cAeg==
X-Gm-Message-State: AAQBX9fe2+WlHTPQoW6pZYvejeThEt90Cog4Q+816sufn0EirF9rnXgT
        wyq2W8X5WGWKD7lrZNfuOoWaMyr0GxiooSwbGFI=
X-Google-Smtp-Source: AKy350YifDm9J4b8aNFNFzUBzkPuRVMakf3AQLjc/qxRU4bXqkqIqGQZpYhqlISVsEVbiuZWlXDqPg==
X-Received: by 2002:a19:c518:0:b0:4eb:3b58:c558 with SMTP id w24-20020a19c518000000b004eb3b58c558mr2491605lfe.59.1682257614518;
        Sun, 23 Apr 2023 06:46:54 -0700 (PDT)
Received: from titov.fritz.box ([195.246.120.55])
        by smtp.gmail.com with ESMTPSA id j24-20020ac24558000000b004db3eff4b12sm1272641lfm.171.2023.04.23.06.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 06:46:54 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/3] t1300: check stderr for "ignores pairs" tests
Date:   Sun, 23 Apr 2023 15:46:48 +0200
Message-Id: <20230423134649.431783-3-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230423134649.431783-1-rybak.a.v@gmail.com>
References: <20230418175034.982433-1-rybak.a.v@gmail.com>
 <20230423134649.431783-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tests "git config ignores pairs ..." in t1300-config.sh validate that
"git config" ignores various kinds of supplied pairs of environment
variables GIT_CONFIG_KEY_* GIT_CONFIG_VALUE_* depending on
GIT_CONFIG_COUNT.  By "ignores" here we mean that "git config" abides by
the value of environment variable GIT_CONFIG_COUNT and doesn't use
key-value pairs outside of the supplied GIT_CONFIG_COUNT when trying to
produce a value for config key "pair.one".

These tests also validate that "git config" doesn't complain about
mismatched environment variables to standard error.  This is validated
by redirecting the standard error to a file called "error" and asserting
that it is empty.  However, two of these tests incorrectly redirect to
standard output while calling the file "error", and test 'git config
ignores pairs exceeding count' doesn't validate standard error at all.

Fix these tests by redirecting standard error to file "error" and
asserting its emptiness.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1300-config.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 696dca17c6..20a15ede5c 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1462,24 +1462,25 @@ test_expect_success 'git config ignores pairs exceeding count' '
 	GIT_CONFIG_COUNT=1 \
 		GIT_CONFIG_KEY_0="pair.one" GIT_CONFIG_VALUE_0="value" \
 		GIT_CONFIG_KEY_1="pair.two" GIT_CONFIG_VALUE_1="value" \
-		git config --get-regexp "pair.*" >actual &&
+		git config --get-regexp "pair.*" >actual 2>error &&
 	cat >expect <<-EOF &&
 	pair.one value
 	EOF
-	test_cmp expect actual
+	test_cmp expect actual &&
+	test_must_be_empty error
 '
 
 test_expect_success 'git config ignores pairs with zero count' '
 	test_must_fail env \
 		GIT_CONFIG_COUNT=0 GIT_CONFIG_KEY_0="pair.one" GIT_CONFIG_VALUE_0="value" \
-		git config pair.one >error &&
+		git config pair.one 2>error &&
 	test_must_be_empty error
 '
 
 test_expect_success 'git config ignores pairs with empty count' '
 	test_must_fail env \
 		GIT_CONFIG_COUNT= GIT_CONFIG_KEY_0="pair.one" GIT_CONFIG_VALUE_0="value" \
-		git config pair.one >error &&
+		git config pair.one 2>error &&
 	test_must_be_empty error
 '
 
-- 
2.40.0

