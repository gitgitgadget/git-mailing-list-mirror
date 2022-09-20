Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA7AC54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 10:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiITKye (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 06:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiITKyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 06:54:16 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F91A6612A
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 03:54:14 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y8so3203625edc.10
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 03:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=F76GyNQVfUseiOidh+YV0AwUrHG4M6UPA6CKEvjOP/U=;
        b=YJEj8zGog5jEhzpkdFQzeKfCFFQS1ldloP5JLXfGv/yhOSDyEvFE2TDIRw3kT88s8N
         ITvP2namwOvPiuGoyKEYbXQ/XsC6k8TARFkaX7cvCB7mbt7ZzLnUJK9gkvv8dHfAdGQo
         KLCDiRJZDEXLQ4ZUfQsce5qYvLQtS+dmgfz1DxRXH72VLETshuwH6bJDK6y7FKdQq8ib
         EsjeFUqBRz+HipVG7RWg8G5LBb8mE6QAiHGjRGU4qhvp/hnXmwmkWvY7KlqjAvdd4ijn
         ysNABC4gZ6kk3JCPqqT0IZMPxWRdyujLZW1cZ55OzPzZ9PR+WY9sb25InVdwIY0lTnK9
         sDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=F76GyNQVfUseiOidh+YV0AwUrHG4M6UPA6CKEvjOP/U=;
        b=Jug5gj9ISkwQnOKY32+GIaG7cD+ZcFboHogotqd1E802fEd8nuYNe5vKCxH+WI8E9H
         D8bUraG2NpbVTvSO9Mxy13f+WayXbInXgiGGPf1jnoC0nho0MDGjLUVWzGjmsOh0I0nH
         NgsxEGF1CcgMqWEd75JLO02Uh9xMB4y7Y+rg7CBHKGLTvQLUf7WG/7AiuqZLDHYhiMMH
         uBJtFUB44xv/zEjONJ2qslhfG4uMW3bDJJeaX+8jESPm5xVhyTsz5y8NQlRPtKkhhWUc
         1Wsyjrj8geqTqh13FinLcO/muaRZP8cyRbaMXvh1Umwimud2K0CB4VOGiWkoekzppADn
         iWqQ==
X-Gm-Message-State: ACrzQf1Hr4an4Mzi1P+bHbL4FXJ242FJ0baahWEmiHu0JwUmdurwUJNF
        cFdNEtAi2e69+7+xSTToBEXudUbOWWA=
X-Google-Smtp-Source: AMsMyM7oD5Bg2iik4ojSUgexcGbjzMoUl8ISkyIJC/pRw/VQ26ENaQwVg7zqWGjVzT5lFEFwEGTdGw==
X-Received: by 2002:a05:6402:33c4:b0:448:e63e:4f40 with SMTP id a4-20020a05640233c400b00448e63e4f40mr19325102edc.203.1663671252834;
        Tue, 20 Sep 2022 03:54:12 -0700 (PDT)
Received: from localhost (78-131-17-3.pool.digikabel.hu. [78.131.17.3])
        by smtp.gmail.com with ESMTPSA id oz7-20020a1709077d8700b0072b13ac9ca3sm649091ejc.183.2022.09.20.03.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 03:54:12 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t/Makefile: remove 'test-results' on 'make clean'
Date:   Tue, 20 Sep 2022 12:54:07 +0200
Message-Id: <20220920105407.4700-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.3.1160.g17e5960226
In-Reply-To: <patch-v3-07.15-c7ea6dc013b-20220727T230800Z-avarab@gmail.com>
References: <patch-v3-07.15-c7ea6dc013b-20220727T230800Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 't/test-results' directory and its contents are by-products of the
test process, so 'make clean' should remove them, but, alas, this has
been broken since ee65b194d (t/Makefile: don't remove test-results in
"clean-except-prove-cache", 2022-07-28).

The 'clean' target in 't/Makefile' was not directly responsible for
removing the 'test-results' directory, but relied on its dependency
'clean-except-prove-cache' to do that [1].  ee65b194d broke this,
because it only removed the 'rm -r test-results' command from the
'clean-except-prove-cache' target instead of moving it to the 'clean'
target, resulting in stray 't/test-results' directories.

Add that missing cleanup command to 't/Makefile', and all sub-Makefiles
touched by ee65b194d as well.

[1] 60f26f6348 (t/Makefile: retain cache t/.prove across prove runs,
                2012-05-02)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/scalar/t/Makefile  | 1 +
 contrib/subtree/t/Makefile | 1 +
 t/Makefile                 | 1 +
 3 files changed, 3 insertions(+)

diff --git a/contrib/scalar/t/Makefile b/contrib/scalar/t/Makefile
index 1ed174a8cf..e0bf2e32cb 100644
--- a/contrib/scalar/t/Makefile
+++ b/contrib/scalar/t/Makefile
@@ -46,6 +46,7 @@ clean-except-prove-cache:
 	$(RM) -r valgrind/bin
 
 clean: clean-except-prove-cache
+	$(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
 	$(RM) .prove
 
 test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax
diff --git a/contrib/subtree/t/Makefile b/contrib/subtree/t/Makefile
index 3d278bb0ed..4655e0987b 100644
--- a/contrib/subtree/t/Makefile
+++ b/contrib/subtree/t/Makefile
@@ -51,6 +51,7 @@ clean-except-prove-cache:
 	$(RM) -r valgrind/bin
 
 clean: clean-except-prove-cache
+	$(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
 	$(RM) .prove
 
 test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax
diff --git a/t/Makefile b/t/Makefile
index 1c80c0c79a..cb04481114 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -66,6 +66,7 @@ clean-except-prove-cache: clean-chainlint
 	$(RM) -r valgrind/bin
 
 clean: clean-except-prove-cache
+	$(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
 	$(RM) .prove
 
 clean-chainlint:
-- 
2.37.3.1160.g17e5960226

