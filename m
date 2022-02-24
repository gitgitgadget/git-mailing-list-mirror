Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B8BC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 05:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiBXFsL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 00:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiBXFsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 00:48:09 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9C71C887E
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 21:47:38 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id e13so804063plh.3
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 21:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NLg00uUzPPA27CeESJ9fFzVnompV9hZH8ZL3j/6cjCo=;
        b=FwwkNicqQ5YV0puRNfb0c3bwfraxc+vrKlNyk6Oc2tMoZKSwc4RnWCKXtAUUplHvIL
         SJ5nfIC7fnKoLl5TZg+HR8CHSY62X/DxCeY3QS4JajrO3J5et1pNHvAOEae7G6n403Ac
         8HPHF5XbhS/oM0gLJce/pyjEOcCoFjjkyXmHDa7hCwBnJJvHTFwRleDAZMCBWT84p2qA
         bABIOkUL6fU0Xq/xKKb8t3PDgHby2bY7KAWcge1eDxdJCa04dbepWhOvKudb00fu4nZK
         41TBYMXff7T6xjmM2Iwrxf9DE37i79mrYNa+EZIOVAKXGYwoxgt9sFHgeWrvdXmTgBVx
         KLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NLg00uUzPPA27CeESJ9fFzVnompV9hZH8ZL3j/6cjCo=;
        b=r6FZeNp/LCtlo/P3Jsk2v33Nef1ZM/bOYErv1L4HakNCWaPQQCPyZHznT8URU9HwGv
         YKoaFhdZc7lmhwGzaWUKjF9Hp7UeXych1XwhAZKKSWfAyidjRZRPpO/0P1BwjGYWrnFf
         H7GAViYOfaAXsKM/IaXab38jMVKWRYEVOibyOZ1egC1JVeSonX7G/T1ey2oXYb6f23y7
         ZhOwOyFX3ZZ2JdSOKHkIUyNsNEBcwZzBuisu0akjC0iTDzdZ6CsLQIeyhf1pN889gmzo
         RDnfwLtp8oXVr8kqFGIaVGa+mXY0R9Isuy6rqaGFBehGqH8DexC5VTnXTUMA8kbdjsWP
         8KwQ==
X-Gm-Message-State: AOAM532hDN51synMt/Xk2x+9UT4+L5qwu+9QF/83DVYyOtZtIecszsX5
        FiEjjqPubGWjyAJeocB7wX8epascjDP2ANq4g3g=
X-Google-Smtp-Source: ABdhPJx6TT+CCHkAtby6rh/P//wdDXkkQJI+8R02eTBeOkmMCA30tSrkuP9PP2npCP/KKVey9WhNug==
X-Received: by 2002:a17:902:f785:b0:14d:d2b6:b7c with SMTP id q5-20020a170902f78500b0014dd2b60b7cmr1034092pln.68.1645681657261;
        Wed, 23 Feb 2022 21:47:37 -0800 (PST)
Received: from DESKTOP-MEF584H.localdomain ([103.108.4.99])
        by smtp.gmail.com with ESMTPSA id f12sm1497817pfv.106.2022.02.23.21.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 21:47:36 -0800 (PST)
From:   Shubham Mishra <shivam828787@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, Shubham Mishra <shivam828787@gmail.com>
Subject: [PATCH 2/2] t0030-t0050: avoid pipes with Git on LHS
Date:   Thu, 24 Feb 2022 11:17:20 +0530
Message-Id: <20220224054720.23996-3-shivam828787@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224054720.23996-1-shivam828787@gmail.com>
References: <20220224054720.23996-1-shivam828787@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pipes ignore error codes of LHS command and thus we should not use
them with Git in tests. As an alternative, use a 'tmp' file to write
the Git output so we can test the exit code.

Signed-off-by: Shubham Mishra <shivam828787@gmail.com>
---
 t/t0030-stripspace.sh | 81 ++++++++++++++++++++++++++++---------------
 t/t0050-filesystem.sh |  3 +-
 2 files changed, 56 insertions(+), 28 deletions(-)

diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index ae1ca380c1..4d0af9bf98 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -225,32 +225,48 @@ test_expect_success \
 
 test_expect_success \
     'text without newline at end should end with newline' '
-    test $(printf "$ttt" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$ttt" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$ttt$ttt" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$ttt$ttt$ttt" | git stripspace | wc -l) -gt 0
+    printf "$ttt" | git stripspace >tmp &&
+    test $(wc -l <tmp) -gt 0 &&
+    printf "$ttt$ttt" | git stripspace >tmp &&
+    test $(wc -l <tmp) -gt 0 &&
+    printf "$ttt$ttt$ttt" | git stripspace >tmp &&
+    test $(wc -l <tmp) -gt 0 &&
+    printf "$ttt$ttt$ttt$ttt" | git stripspace >tmp &&
+    test $(wc -l <tmp) -gt 0
 '
 
 # text plus spaces at the end:
 
 test_expect_success \
     'text plus spaces without newline at end should end with newline' '
-    test $(printf "$ttt$sss" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$ttt$sss" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$ttt$ttt$sss" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$sss$sss" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$ttt$sss$sss" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$sss$sss$sss" | git stripspace | wc -l) -gt 0
+    printf "$ttt$sss" | git stripspace >tmp &&
+    test $(wc -l <tmp) -gt 0 &&
+    printf "$ttt$ttt$sss" | git stripspace >tmp &&
+    test $(wc -l <tmp) -gt 0 &&
+    printf "$ttt$ttt$ttt$sss" | git stripspace >tmp &&
+    test $(wc -l <tmp) -gt 0 &&
+    printf "$ttt$sss$sss" | git stripspace >tmp &&
+    test $(wc -l <tmp) -gt 0 &&
+    printf "$ttt$ttt$sss$sss" | git stripspace >tmp &&
+    test $(wc -l <tmp) -gt 0 &&
+    printf "$ttt$sss$sss$sss" | git stripspace >tmp &&
+    test $(wc -l <tmp) -gt 0
 '
 
 test_expect_success \
     'text plus spaces without newline at end should not show spaces' '
-    ! (printf "$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (printf "$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (printf "$ttt$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (printf "$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (printf "$ttt$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (printf "$ttt$sss$sss$sss" | git stripspace | grep "  " >/dev/null)
+    printf "$ttt$sss" | git stripspace >tmp &&
+    ! (grep "  " tmp >/dev/null) &&
+    printf "$ttt$ttt$sss" | git stripspace &&
+    ! (grep "  " tmp >/dev/null) &&
+    printf "$ttt$ttt$ttt$sss" | git stripspace &&
+    ! (grep "  " tmp >/dev/nul) &&
+    printf "$ttt$sss$sss" | git stripspace &&
+    ! (grep "  " tmp >/dev/null) &&
+    printf "$ttt$ttt$sss$sss" | git stripspace &&
+    ! (grep "  " tmp >/dev/null) &&
+    printf "$ttt$sss$sss$sss" | git stripspace &&
+    ! (grep "  " tmp >/dev/null)
 '
 
 test_expect_success \
@@ -282,12 +298,18 @@ test_expect_success \
 
 test_expect_success \
     'text plus spaces at end should not show spaces' '
-    ! (echo "$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (echo "$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (echo "$ttt$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (echo "$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (echo "$ttt$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (echo "$ttt$sss$sss$sss" | git stripspace | grep "  " >/dev/null)
+    echo "$ttt$sss" | git stripspace >tmp &&
+    ! (grep "  " tmp >/dev/null) &&
+    echo "$ttt$ttt$sss" | git stripspace >tmp &&
+    ! (grep "  " tmp>/dev/null) &&
+    echo "$ttt$ttt$ttt$sss" &&
+    ! (grep "  " tmp >/dev/null) &&
+    echo "$ttt$sss$sss" | git stripspace >tmp &&
+    ! (grep "  " tmp >/dev/null) &&
+    echo "$ttt$ttt$sss$sss" | git stripspace >tmp &&
+    ! (grep "  " tmp >/dev/null) &&
+    echo "$ttt$sss$sss$sss" | git stripspace >tmp &&
+    ! (grep "  " tmp >/dev/null)
 '
 
 test_expect_success \
@@ -339,11 +361,16 @@ test_expect_success \
 
 test_expect_success \
     'spaces without newline at end should not show spaces' '
-    ! (printf "" | git stripspace | grep " " >/dev/null) &&
-    ! (printf "$sss" | git stripspace | grep " " >/dev/null) &&
-    ! (printf "$sss$sss" | git stripspace | grep " " >/dev/null) &&
-    ! (printf "$sss$sss$sss" | git stripspace | grep " " >/dev/null) &&
-    ! (printf "$sss$sss$sss$sss" | git stripspace | grep " " >/dev/null)
+    printf "" | git stripspace >tmp &&
+    ! ( grep " " tmp >/dev/null) &&
+    printf "$sss" | git stripspace >tmp &&
+    ! ( grep " " tmp >/dev/null) &&
+    printf "$sss$sss" | git stripspace >tmp &&
+    ! (grep " " tmp >/dev/null) &&
+    printf "$sss$sss$sss" | git stripspace >tmp &&
+    ! (grep " " tmp >/dev/null) &&
+    printf "$sss$sss$sss$sss" | git stripspace >tmp &&
+    ! (grep " " tmp >/dev/null)
 '
 
 test_expect_success \
diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index afc343cf9b..5c9dc90d0b 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -104,7 +104,8 @@ test_expect_failure CASE_INSENSITIVE_FS 'add (with different case)' '
 	rm camelcase &&
 	echo 1 >CamelCase &&
 	git add CamelCase &&
-	camel=$(git ls-files | grep -i camelcase) &&
+	git ls-files >tmp &&
+	camel=$(grep -i camelcase tmp) &&
 	test $(echo "$camel" | wc -l) = 1 &&
 	test "z$(git cat-file blob :$camel)" = z1
 '
-- 
2.25.1

