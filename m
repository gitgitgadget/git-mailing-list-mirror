Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB843C433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A9B961164
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbhD0Kjs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 06:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238169AbhD0KjN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 06:39:13 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4F3C061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:30 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h4so49897255wrt.12
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bOBmRlj8UWbjfm8g34EQmDORL5pu96CWv+zC/JC0X+4=;
        b=lD2XW4y3bpSOiy4KWONIeKh0cfn8KISKGclrXt0KExH+eIF/VgH3iLsC+5yuP523GL
         8fndqq4fUJX96DHPYODzEd3p8XPORjlWMvxT9PXHhk9lre0vG4NlzNvLz7wiACilbwae
         pLpHLAqSK6OH758/kKp40hmxtHCpHSqq6Lg6aAxEk5/23Fdbs1qS21cNE0c09QQp2M9B
         BzBQjXHFYWPNZBY0Jcp49dA8bj/PuKnBcVs5vRwHtGvTHrVNkEPOzxORLYruYdllIDrt
         VCYh30GfsldykaWjqtLx/zZW23mrW49JzarhAzmJqGGT0+2wZVMa2q0DtwPVdmTIRzsa
         hSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bOBmRlj8UWbjfm8g34EQmDORL5pu96CWv+zC/JC0X+4=;
        b=N+d/pJRsuQYOiAo3Vqdp19aMGmT1eepoPJqIMuqDByf2w/ChgzxoQh/YKaif0YXV61
         t99lYyQKIkNInHXqxFQemstvQ3FmSNkx5ufCTR9KLUcZsI8vfi1jgdQ/VtxsKPQ9ulFg
         3bvPgki7bmyEsjnvjrD9erad7lJaZ89t4hFIhIXNaH3tGbnj/xIB5mZsgE+2yeJvqemG
         TLusklgTOaMsitunpTC15I3kGmk2kGFTttaq2M608hu6Sm38Us0ZAQegSu3IoO6NfZx1
         YeHHiPWGE+RSirqxNSgkV6JHbgg9s1TFs3hamFtXMHh+q8hfHGrW3dad1APCSk6JERUK
         uo7Q==
X-Gm-Message-State: AOAM5336fqUxMe8DnF860mUFO0C9Op9MeZvq5YHDNsd5k4unLCzUVmr3
        GfJl0o3zV5pAdpSKZwO2QkdfIGRXFjo=
X-Google-Smtp-Source: ABdhPJwS2ggn4iztB95aaQ72g/EHyqwA0HmXc4o3OGom0mo1YoDEMQF0mr6g4fsQ0EHy/9U53IPZew==
X-Received: by 2002:adf:efce:: with SMTP id i14mr1626355wrp.317.1619519909209;
        Tue, 27 Apr 2021 03:38:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h6sm10641wru.28.2021.04.27.03.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:38:28 -0700 (PDT)
Message-Id: <e67b90847c4eb78fff786944c04413f8a02cffb4.1619519903.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
        <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Apr 2021 10:38:09 +0000
Subject: [PATCH v2 08/21] t5000: reformat indentation to the latest fashion
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t5000-tar-tree.sh | 104 ++++++++++++++++++++++----------------------
 1 file changed, 53 insertions(+), 51 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 7204799a0b52..b6734cba7e65 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -111,25 +111,25 @@ test_expect_success 'setup' '
 	EOF
 '
 
-test_expect_success \
-    'populate workdir' \
-    'mkdir a &&
-     echo simple textfile >a/a &&
-     ten=0123456789 && hundred=$ten$ten$ten$ten$ten$ten$ten$ten$ten$ten &&
-     echo long filename >a/four$hundred &&
-     mkdir a/bin &&
-     test-tool genrandom "frotz" 500000 >a/bin/sh &&
-     printf "A\$Format:%s\$O" "$SUBSTFORMAT" >a/substfile1 &&
-     printf "A not substituted O" >a/substfile2 &&
-     if test_have_prereq SYMLINKS; then
-	ln -s a a/l1
-     else
-	printf %s a > a/l1
-     fi &&
-     (p=long_path_to_a_file && cd a &&
-      for depth in 1 2 3 4 5; do mkdir $p && cd $p; done &&
-      echo text >file_with_long_path) &&
-     (cd a && find .) | sort >a.lst'
+test_expect_success 'populate workdir' '
+	mkdir a &&
+	echo simple textfile >a/a &&
+	ten=0123456789 && hundred=$ten$ten$ten$ten$ten$ten$ten$ten$ten$ten &&
+	echo long filename >a/four$hundred &&
+	mkdir a/bin &&
+	test-tool genrandom "frotz" 500000 >a/bin/sh &&
+	printf "A\$Format:%s\$O" "$SUBSTFORMAT" >a/substfile1 &&
+	printf "A not substituted O" >a/substfile2 &&
+	if test_have_prereq SYMLINKS; then
+		ln -s a a/l1
+	else
+		printf %s a >a/l1
+	fi &&
+	(p=long_path_to_a_file && cd a &&
+		for depth in 1 2 3 4 5; do mkdir $p && cd $p; done &&
+		echo text >file_with_long_path) &&
+	(cd a && find .) | sort >a.lst
+'
 
 test_expect_success \
     'add ignored file' \
@@ -147,18 +147,18 @@ test_expect_success 'setup export-subst' '
 		>a/substfile1
 '
 
-test_expect_success \
-    'create bare clone' \
-    'git clone --bare . bare.git &&
-     cp .git/info/attributes bare.git/info/attributes'
+test_expect_success 'create bare clone' '
+	git clone --bare . bare.git &&
+	cp .git/info/attributes bare.git/info/attributes
+'
 
-test_expect_success \
-    'remove ignored file' \
-    'rm a/ignored'
+test_expect_success 'remove ignored file' '
+	rm a/ignored
+'
 
-test_expect_success \
-    'git archive' \
-    'git archive HEAD >b.tar'
+test_expect_success 'git archive' '
+	git archive HEAD >b.tar
+'
 
 check_tar b
 
@@ -194,26 +194,28 @@ check_added with_untracked2 untracked one/untracked
 check_added with_untracked2 untracked two/untracked
 
 test_expect_success 'git archive on large files' '
-    test_config core.bigfilethreshold 1 &&
-    git archive HEAD >b3.tar &&
-    test_cmp_bin b.tar b3.tar
+	test_config core.bigfilethreshold 1 &&
+	git archive HEAD >b3.tar &&
+	test_cmp_bin b.tar b3.tar
 '
 
-test_expect_success \
-    'git archive in a bare repo' \
-    '(cd bare.git && git archive HEAD) >b3.tar'
+test_expect_success 'git archive in a bare repo' '
+	(cd bare.git && git archive HEAD) >b3.tar
+'
 
-test_expect_success \
-    'git archive vs. the same in a bare repo' \
-    'test_cmp_bin b.tar b3.tar'
+test_expect_success 'git archive vs. the same in a bare repo' '
+	test_cmp_bin b.tar b3.tar
+'
 
-test_expect_success 'git archive with --output' \
-    'git archive --output=b4.tar HEAD &&
-    test_cmp_bin b.tar b4.tar'
+test_expect_success 'git archive with --output' '
+	git archive --output=b4.tar HEAD &&
+	test_cmp_bin b.tar b4.tar
+'
 
-test_expect_success 'git archive --remote' \
-    'git archive --remote=. HEAD >b5.tar &&
-    test_cmp_bin b.tar b5.tar'
+test_expect_success 'git archive --remote' '
+	git archive --remote=. HEAD >b5.tar &&
+	test_cmp_bin b.tar b5.tar
+'
 
 test_expect_success 'git archive --remote with configured remote' '
 	git config remote.foo.url . &&
@@ -224,13 +226,13 @@ test_expect_success 'git archive --remote with configured remote' '
 	test_cmp_bin b.tar b5-nick.tar
 '
 
-test_expect_success \
-    'validate file modification time' \
-    'mkdir extract &&
-     "$TAR" xf b.tar -C extract a/a &&
-     test-tool chmtime --get extract/a/a >b.mtime &&
-     echo "1117231200" >expected.mtime &&
-     test_cmp expected.mtime b.mtime'
+test_expect_success 'validate file modification time' '
+	mkdir extract &&
+	"$TAR" xf b.tar -C extract a/a &&
+	test-tool chmtime --get extract/a/a >b.mtime &&
+	echo "1117231200" >expected.mtime &&
+	test_cmp expected.mtime b.mtime
+'
 
 test_expect_success \
     'git get-tar-commit-id' \
-- 
gitgitgadget

