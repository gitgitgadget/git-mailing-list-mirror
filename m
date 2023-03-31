Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459F8C6FD18
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 06:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjCaGwl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 02:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjCaGwj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 02:52:39 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250B21B36A
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 23:52:09 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso14718694wmb.0
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 23:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680245527;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HUGjxmM9Pp8lmJriCmSNs+VjKXlAR4i8DabPSn0jovg=;
        b=C0T2a4mObbRraMImgm2ZaikiY4KflLZ/IgwVLDVWstJ249Z8qjBtFTq3YA29TX+g4s
         MOD+2t6r7WijDAOUfmKYIuJdSViuXiEuHZRQ5r8bvjHFePKd1FL8J312HXOySf3dnJJP
         8n0Nyv1O5CPrw7DxHSGIfEnl8zPpuN2GgmiYcWwH+5AkZswnyO5ocHX74qV2pBHELa3m
         zgJFTvIci9Qu0DwaoFOKNg9hfbIxam7iS77G6xdeq70mzrgfpWoFOFxuKsPg1+NTTK5/
         toDvXFv5OBcRDewTtoGMf8kH6tX9BO1VZxPzRcJzXcSWJWwnWJot+kXUK00C0/Axvx1M
         tx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680245527;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUGjxmM9Pp8lmJriCmSNs+VjKXlAR4i8DabPSn0jovg=;
        b=K8EaU4VeIY9gdyRF7yd4qiHXdELvULq0kOOZV7rNnyABEMdIDAZarxv9EwsEKJGAAP
         AWHTfN3U/ztX/liaJL4Ca7N230firWhZaqoFoixy77IujYNiCaNKLryo9XH/jt3lNx/0
         WfbyX0ay8VC4ATPD132Namcikuc09BR8TvX6HUkJDj6rSGUmQ2kuvUkxJ4VW7a2KYAVI
         5nuIVlDg3zzblsP1YjCHDH2wViXb6I15nmpTpndCF5jgPOv2UbKk4UkMmjM+kUKngDto
         QBenlyuEOQzNosUylmCGU4Besq27E8CixQmqTW8rpWsoYmjcCQF9p/zrwWzTvlvpcrrp
         7FEA==
X-Gm-Message-State: AAQBX9eI3PArUN7O0pP7LR8nPqRvpwzF/Qjg3yKrqeK55LZbFkaZthES
        N1j5FA1q0HmQ9zOBAGQ+l6vGUIVMUp4=
X-Google-Smtp-Source: AKy350ZmdVWYN4Eq9XBtLr1piJ+BJ4TmYiHeDfaSX4W5b9GpkPTP2lz+Yrc+XAJ+2JqdI+H4Qlq7OA==
X-Received: by 2002:a05:600c:3d87:b0:3ee:501f:c795 with SMTP id bi7-20020a05600c3d8700b003ee501fc795mr6532148wmb.1.1680245526651;
        Thu, 30 Mar 2023 23:52:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o23-20020a05600c379700b003ef684c5e32sm1563636wmr.48.2023.03.30.23.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 23:52:06 -0700 (PDT)
Message-Id: <pull.1507.git.1680245525637.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Mar 2023 06:52:05 +0000
Subject: [PATCH] t5563: prevent "ambiguous redirect"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew John Cheetham <mjcheetham@outlook.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When I ran this test using `TEST_SHELL_PATH=/bin/bash` in my Ubuntu
setup (where Bash is at version 5.0.17(1)-release), I was greeted with
this error message:

	./test-lib.sh: line 1072: $CHALLENGE: ambiguous redirect

This commit fixes that error by quoting the `CHALLENGE` variable (which
has as value a path containing spaces), and by avoiding to cuddle the
empty string parameter in the `printf` call with the redirect character
(in fact, the `printf ''>$CHALLENGE` is removed because the next line
overwrites the file anyway because it _also_ uses a single `>` to
redirect the output).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    t5563: prevent "ambiguous redirect"
    
    I ran into this issue while running the tests with
    TEST_SHELL_PATH=/bin/bash.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1507%2Fdscho%2Ffix-ambiguous-redirect-in-t5563-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1507/dscho/fix-ambiguous-redirect-in-t5563-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1507

 t/t5563-simple-http-auth.sh | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
index ccf7e54b073..f45a43b4b5e 100755
--- a/t/t5563-simple-http-auth.sh
+++ b/t/t5563-simple-http-auth.sh
@@ -252,15 +252,14 @@ test_expect_success 'access using basic auth with wwwauth header empty continuat
 
 	# Note that leading and trailing whitespace is important to correctly
 	# simulate a continuation/folded header.
-	printf "">$CHALLENGE &&
-	printf "WWW-Authenticate: FooBar param1=\"value1\"\r\n" >$CHALLENGE &&
-	printf " \r\n" >>$CHALLENGE &&
-	printf " param2=\"value2\"\r\n" >>$CHALLENGE &&
-	printf "WWW-Authenticate: Bearer authorize_uri=\"id.example.com\"\r\n" >>$CHALLENGE &&
-	printf " p=1\r\n" >>$CHALLENGE &&
-	printf " \r\n" >>$CHALLENGE &&
-	printf " q=0\r\n" >>$CHALLENGE &&
-	printf "WWW-Authenticate: Basic realm=\"example.com\"\r\n" >>$CHALLENGE &&
+	printf "WWW-Authenticate: FooBar param1=\"value1\"\r\n" >"$CHALLENGE" &&
+	printf " \r\n" >>"$CHALLENGE" &&
+	printf " param2=\"value2\"\r\n" >>"$CHALLENGE" &&
+	printf "WWW-Authenticate: Bearer authorize_uri=\"id.example.com\"\r\n" >>"$CHALLENGE" &&
+	printf " p=1\r\n" >>"$CHALLENGE" &&
+	printf " \r\n" >>"$CHALLENGE" &&
+	printf " q=0\r\n" >>"$CHALLENGE" &&
+	printf "WWW-Authenticate: Basic realm=\"example.com\"\r\n" >>"$CHALLENGE" &&
 
 	test_config_global credential.helper test-helper &&
 	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
@@ -298,11 +297,10 @@ test_expect_success 'access using basic auth with wwwauth header mixed line-endi
 
 	# Note that leading and trailing whitespace is important to correctly
 	# simulate a continuation/folded header.
-	printf "">$CHALLENGE &&
-	printf "WWW-Authenticate: FooBar param1=\"value1\"\r\n" >$CHALLENGE &&
-	printf " \r\n" >>$CHALLENGE &&
-	printf "\tparam2=\"value2\"\r\n" >>$CHALLENGE &&
-	printf "WWW-Authenticate: Basic realm=\"example.com\"" >>$CHALLENGE &&
+	printf "WWW-Authenticate: FooBar param1=\"value1\"\r\n" >"$CHALLENGE" &&
+	printf " \r\n" >>"$CHALLENGE" &&
+	printf "\tparam2=\"value2\"\r\n" >>"$CHALLENGE" &&
+	printf "WWW-Authenticate: Basic realm=\"example.com\"" >>"$CHALLENGE" &&
 
 	test_config_global credential.helper test-helper &&
 	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&

base-commit: 5f2117b24f568ecc789c677748d70ccd538b16ba
-- 
gitgitgadget
