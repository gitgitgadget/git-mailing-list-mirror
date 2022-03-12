Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAF8C433EF
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 06:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiCLGXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Mar 2022 01:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiCLGXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Mar 2022 01:23:09 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6E7F8BBB
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 22:22:04 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id o26so9233483pgb.8
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 22:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NnFJq9E6n2+zNkiIktHKp1kCxuBQRmBIhSAoARfCzLI=;
        b=Imi3YPl8MMR2mUIeSLS0Q1xLMfR8pcx3IyY6GX1Zzit1hItaXksnE3uFKaunr5t9L1
         0S8yLI+gGwoDH4T5iVhr5lIQn78oomxrYuBVGpyPhKmxCkuhww+ZqcRncSKzvoPXOUxd
         FZ8gru4PVJ/cc+CUhR/Qy9bdCpHVXBKv3cB5H59LZujVXgcp7oVk37zgO3v2fW9ycexB
         2UzSnoOKchoERsx0oMTc7ph9lZetGiL0X69tgQS5s3rNs2xJGAbXKHDXV1wa5nTH6tP/
         pNh8BIWMQDBk8Dn6s6T1VyUyRMGHnzxj/czFIS924DE8ZIIC17bEk/PC9lZaXNODsds8
         YQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NnFJq9E6n2+zNkiIktHKp1kCxuBQRmBIhSAoARfCzLI=;
        b=PFhX77tSpXBpQAp5TDDcnXFNSc10UcAKA0oeomPCZ+GrRB7BL4DnyrsUbAsNBhsi4y
         ppE5XgITLeBovZ4QmFOg+CRfuzPkFCTmw41aojDzLxAceMCmtyhTzbwWeCoTC9D5U2x4
         HNcqJVTjVQgDMg6eoXLyKooaijd7viOKLfOI+M6WSV/OGwDfTFrQBKZBM8H4QhflKMX+
         Z6C/lO+x05y50dH/Kx8Nl/Gt3hORG2kFmQHq69aFlnT78weUSLB9P3LMtQ2Yu+K1YLfg
         M4Ge9yOLurEPCxgUmVcGG8+KiXv46eslgkrCNWV4KXutVHA3qIH7pOTNcZrfvIhJ0wmH
         1nog==
X-Gm-Message-State: AOAM53216bT/5dLkY3UV5FZYiHWQHcwRnZ6GNZ0kC0ZMLRXQyx4Taw0N
        JRkjf8kkFJDQiLLmKqRC01FG9YBQbu+wIBT8R9I=
X-Google-Smtp-Source: ABdhPJyx5VUB8ppms8uu5t73+Z3oizv9Qj7Ek4mwmdInHJnicQeZy2lgQwC9xqQHEDvHt3dGaiBx6g==
X-Received: by 2002:a63:d252:0:b0:363:271c:fe63 with SMTP id t18-20020a63d252000000b00363271cfe63mr11686584pgi.524.1647066123165;
        Fri, 11 Mar 2022 22:22:03 -0800 (PST)
Received: from DESKTOP-MEF584H.localdomain ([103.108.4.246])
        by smtp.gmail.com with ESMTPSA id z25-20020a637e19000000b0037c90292bebsm10225330pgc.55.2022.03.11.22.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 22:22:02 -0800 (PST)
From:   Shubham Mishra <shivam828787@gmail.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, me@ttaylorr.com, kaartic.sivaraam@gmail.com,
        Shubham Mishra <shivam828787@gmail.com>
Subject: [PATCH v3 2/2] t0030-t0050: avoid pipes with Git on LHS
Date:   Sat, 12 Mar 2022 11:51:26 +0530
Message-Id: <20220312062126.31988-3-shivam828787@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220312062126.31988-1-shivam828787@gmail.com>
References: <20220224054720.23996-1-shivam828787@gmail.com>
 <20220312062126.31988-1-shivam828787@gmail.com>
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
 t/t0030-stripspace.sh | 75 +++++++++++++++++++++++++++----------------
 t/t0050-filesystem.sh |  3 +-
 2 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index ae1ca380c1..0a5713c524 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -13,6 +13,10 @@ s40='                                        '
 sss="$s40$s40$s40$s40$s40$s40$s40$s40$s40$s40" # 400
 ttt="$t40$t40$t40$t40$t40$t40$t40$t40$t40$t40" # 400
 
+printf_git_stripspace () {
+    printf "$1" | git stripspace
+}
+
 test_expect_success \
     'long lines without spaces should be unchanged' '
     echo "$ttt" >expect &&
@@ -225,32 +229,38 @@ test_expect_success \
 
 test_expect_success \
     'text without newline at end should end with newline' '
-    test $(printf "$ttt" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$ttt" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$ttt$ttt" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$ttt$ttt$ttt" | git stripspace | wc -l) -gt 0
+    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt" &&
+    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt" &&
+    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$ttt" &&
+    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$ttt$ttt"
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
+    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$sss" &&
+    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$sss" &&
+    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$ttt$sss" &&
+    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$sss$sss" &&
+    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$sss$sss" &&
+    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$sss$sss$sss"
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
+    ! grep "  " tmp >/dev/null &&
+    printf "$ttt$ttt$sss" | git stripspace >tmp &&
+    ! grep "  " tmp >/dev/null &&
+    printf "$ttt$ttt$ttt$sss" | git stripspace >tmp &&
+    ! grep "  " tmp >/dev/null &&
+    printf "$ttt$sss$sss" | git stripspace >tmp &&
+    ! grep "  " tmp >/dev/null &&
+    printf "$ttt$ttt$sss$sss" | git stripspace >tmp &&
+    ! grep "  " tmp >/dev/null &&
+    printf "$ttt$sss$sss$sss" | git stripspace >tmp &&
+    ! grep "  " tmp >/dev/null
 '
 
 test_expect_success \
@@ -282,12 +292,18 @@ test_expect_success \
 
 test_expect_success \
     'text plus spaces at end should not show spaces' '
-    ! (echo "$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (echo "$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (echo "$ttt$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (echo "$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (echo "$ttt$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (echo "$ttt$sss$sss$sss" | git stripspace | grep "  " >/dev/null)
+    echo "$ttt$sss" | git stripspace >tmp &&
+    ! grep "  " tmp >/dev/null &&
+    echo "$ttt$ttt$sss" | git stripspace >tmp &&
+    ! grep "  " tmp >/dev/null &&
+    echo "$ttt$ttt$ttt$sss" | git stripspace >tmp &&
+    ! grep "  " tmp >/dev/null &&
+    echo "$ttt$sss$sss" | git stripspace >tmp &&
+    ! grep "  " tmp >/dev/null &&
+    echo "$ttt$ttt$sss$sss" | git stripspace >tmp &&
+    ! grep "  " tmp >/dev/null &&
+    echo "$ttt$sss$sss$sss" | git stripspace >tmp &&
+    ! grep "  " tmp >/dev/null
 '
 
 test_expect_success \
@@ -339,11 +355,16 @@ test_expect_success \
 
 test_expect_success \
     'spaces without newline at end should not show spaces' '
-    ! (printf "" | git stripspace | grep " " >/dev/null) &&
-    ! (printf "$sss" | git stripspace | grep " " >/dev/null) &&
-    ! (printf "$sss$sss" | git stripspace | grep " " >/dev/null) &&
-    ! (printf "$sss$sss$sss" | git stripspace | grep " " >/dev/null) &&
-    ! (printf "$sss$sss$sss$sss" | git stripspace | grep " " >/dev/null)
+    printf "" | git stripspace >tmp &&
+    ! grep " " tmp >/dev/null &&
+    printf "$sss" | git stripspace >tmp &&
+    ! grep " " tmp >/dev/null &&
+    printf "$sss$sss" | git stripspace >tmp &&
+    ! grep " " tmp >/dev/null &&
+    printf "$sss$sss$sss" | git stripspace >tmp &&
+    ! grep " " tmp >/dev/null &&
+    printf "$sss$sss$sss$sss" | git stripspace >tmp &&
+    ! grep " " tmp >/dev/null
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

