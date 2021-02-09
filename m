Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05B7C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B3A564E9C
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbhBIRdx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 12:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbhBIRdr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 12:33:47 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6B2C061756
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 09:33:05 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id fa16so1969947pjb.1
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 09:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TqSEzUV0TZIhWWT2AHFl4GcnRuwudeyumYU5QwgjQos=;
        b=NBGore3nmWUNyrwy5i5LpoOO64HwzSGOAh/yyN3hEM4WD0SoXD4wBLHkkl3W4weLwp
         mk+mJiDb61wCHLN5YynQ9cHw48TGr7LU+vYrzz4xtqimlMvOo10IDg7/zHUHyBGI17Yx
         oSjB+erZLCp3e0RBurNXjQfZW4eCcMRtdO2EoFL+plOVdu7Wz3EoPQgFAJLwn4bzMNCo
         fTDL+/Moo5g7Bu6GjG5cHS94MC/W5G0/SRcImG3p/3g1WEaiXedhsoPG9L8HeG/gO59n
         /sGM5NgpHtwgGG0XbryEnKtBgjz50f9vaJjipibVOcm9yag4XJetZrqMvtAeJxe0aBvl
         fqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TqSEzUV0TZIhWWT2AHFl4GcnRuwudeyumYU5QwgjQos=;
        b=XH13NJ4qbv9pGA66dLJfY7IE6aQPTlVSRO85f9ySd4B4/ShIu3xokNr8G2Ezw38hri
         trY+tsqvKCKk4GflKtNj3IUVMyV/wtMPvamvXD1kUxXXw6pw/UtdwBWz2hWPyP4MSpBb
         pzFNid0FDLC5sNBaYAwCILspthPB68RGy0UQvCfc8+CMvt3JvGjV/6jy67KRoDFmI4BL
         KUNe07B9GuvIy/1Ca4o4XBWQ56feK3NmpZPv691kbjQ7FB14C5XTYxDRaaBVuQbqK3P7
         f0EKfgeIWkt+Kye+Ug7o9eEHv8nAtawpyAHXL41mQJ10OqdAfOmOrO9aJVFm9V5E5Mr7
         OjFg==
X-Gm-Message-State: AOAM531DEDLoYk5VAsPW2KdkEVOkbmp7+uNT1NpFZQtsFkGKyrdn8D+J
        seha/YJ02/5F5gSq2i65op8KBi3k1TGQow==
X-Google-Smtp-Source: ABdhPJzYTBpd2+vLM03RFDxLzGecwdesDO41l7Mq9t5NJaW+ArfxDewhc0fO+Dr1hl1REOxUKn1Omw==
X-Received: by 2002:a17:902:f1c2:b029:e2:fb7d:7e58 with SMTP id e2-20020a170902f1c2b02900e2fb7d7e58mr2068938plc.54.1612891984955;
        Tue, 09 Feb 2021 09:33:04 -0800 (PST)
Received: from localhost.localdomain ([47.9.143.68])
        by smtp.gmail.com with ESMTPSA id g3sm20682607pfo.149.2021.02.09.09.33.02
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:33:04 -0800 (PST)
From:   shubham verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 02/10] t7001: indent with TABs instead of spaces
Date:   Tue,  9 Feb 2021 23:02:46 +0530
Message-Id: <20210209173254.17712-3-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210209173254.17712-1-shubhunic@gmail.com>
References: <20210209173254.17712-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: shubham verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 120 +++++++++++++++++++++++++-------------------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 4bbb51e578..7503233814 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -4,72 +4,72 @@ test_description='git mv in subdirs'
 . ./test-lib.sh
 
 test_expect_success 'prepare reference tree' '
-     mkdir path0 path1 &&
-     cp "$TEST_DIRECTORY"/../COPYING path0/COPYING &&
-     git add path0/COPYING &&
-     git commit -m add -a
+	mkdir path0 path1 &&
+	cp "$TEST_DIRECTORY"/../COPYING path0/COPYING &&
+	git add path0/COPYING &&
+	git commit -m add -a
 '
 
 test_expect_success 'moving the file out of subdirectory' '
-     cd path0 && git mv COPYING ../path1/COPYING
+	cd path0 && git mv COPYING ../path1/COPYING
 '
 
 # in path0 currently
 test_expect_success 'commiting the change' '
-     cd .. && git commit -m move-out -a
+	cd .. && git commit -m move-out -a
 '
 
 test_expect_success 'checking the commit' '
-     git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
-     grep "^R100..*path0/COPYING..*path1/COPYING" actual
+	git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
+	grep "^R100..*path0/COPYING..*path1/COPYING" actual
 '
 
 test_expect_success 'moving the file back into subdirectory' '
-     cd path0 && git mv ../path1/COPYING COPYING
+	cd path0 && git mv ../path1/COPYING COPYING
 '
 
 # in path0 currently
 test_expect_success 'commiting the change' '
-     cd .. && git commit -m move-in -a
+	cd .. && git commit -m move-in -a
 '
 
 test_expect_success 'checking the commit' '
-     git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
-     grep "^R100..*path1/COPYING..*path0/COPYING" actual
+	git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
+	grep "^R100..*path1/COPYING..*path0/COPYING" actual
 '
 
 test_expect_success 'mv --dry-run does not move file' '
-     git mv -n path0/COPYING MOVED &&
-     test -f path0/COPYING &&
-     test ! -f MOVED
+	git mv -n path0/COPYING MOVED &&
+	test -f path0/COPYING &&
+	test ! -f MOVED
 '
 
 test_expect_success 'checking -k on non-existing file' '
-     git mv -k idontexist path0
+	git mv -k idontexist path0
 '
 
 test_expect_success 'checking -k on untracked file' '
-     touch untracked1 &&
-     git mv -k untracked1 path0 &&
-     test -f untracked1 &&
-     test ! -f path0/untracked1
+	touch untracked1 &&
+	git mv -k untracked1 path0 &&
+	test -f untracked1 &&
+	test ! -f path0/untracked1
 '
 
 test_expect_success 'checking -k on multiple untracked files' '
-     touch untracked2 &&
-     git mv -k untracked1 untracked2 path0 &&
-     test -f untracked1 &&
-     test -f untracked2 &&
-     test ! -f path0/untracked1 &&
-     test ! -f path0/untracked2
+	touch untracked2 &&
+	git mv -k untracked1 untracked2 path0 &&
+	test -f untracked1 &&
+	test -f untracked2 &&
+	test ! -f path0/untracked1 &&
+	test ! -f path0/untracked2
 '
 
 test_expect_success 'checking -f on untracked file with existing target' '
-     touch path0/untracked1 &&
-     test_must_fail git mv -f untracked1 path0 &&
-     test ! -f .git/index.lock &&
-     test -f untracked1 &&
-     test -f path0/untracked1
+	touch path0/untracked1 &&
+	test_must_fail git mv -f untracked1 path0 &&
+	test ! -f .git/index.lock &&
+	test -f untracked1 &&
+	test -f path0/untracked1
 '
 
 # clean up the mess in case bad things happen
@@ -79,77 +79,77 @@ rm -f idontexist untracked1 untracked2 \
 rmdir path1
 
 test_expect_success 'moving to absent target with trailing slash' '
-     test_must_fail git mv path0/COPYING no-such-dir/ &&
-     test_must_fail git mv path0/COPYING no-such-dir// &&
-     git mv path0/ no-such-dir/ &&
-     test_path_is_dir no-such-dir
+	test_must_fail git mv path0/COPYING no-such-dir/ &&
+	test_must_fail git mv path0/COPYING no-such-dir// &&
+	git mv path0/ no-such-dir/ &&
+	test_path_is_dir no-such-dir
 '
 
 test_expect_success 'clean up' '
-     git reset --hard
+	git reset --hard
 '
 
 test_expect_success 'moving to existing untracked target with trailing slash' '
-     mkdir path1 &&
-     git mv path0/ path1/ &&
-     test_path_is_dir path1/path0/
+	mkdir path1 &&
+	git mv path0/ path1/ &&
+	test_path_is_dir path1/path0/
 '
 
 test_expect_success 'moving to existing tracked target with trailing slash' '
-     mkdir path2 &&
-     >path2/file && git add path2/file &&
-     git mv path1/path0/ path2/ &&
-     test_path_is_dir path2/path0/
+	mkdir path2 &&
+	>path2/file && git add path2/file &&
+	git mv path1/path0/ path2/ &&
+	test_path_is_dir path2/path0/
 '
 
 test_expect_success 'clean up' '
-     git reset --hard
+	git reset --hard
 '
 
 test_expect_success 'adding another file' '
-     cp "$TEST_DIRECTORY"/../README.md path0/README &&
-     git add path0/README &&
-     git commit -m add2 -a
+	cp "$TEST_DIRECTORY"/../README.md path0/README &&
+	git add path0/README &&
+	git commit -m add2 -a
 '
 
 test_expect_success 'moving whole subdirectory' '
-     git mv path0 path2
+	git mv path0 path2
 '
 
 test_expect_success 'commiting the change' '
-     git commit -m dir-move -a
+	git commit -m dir-move -a
 '
 
 test_expect_success 'checking the commit' '
-     git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
-     grep "^R100..*path0/COPYING..*path2/COPYING" actual &&
-     grep "^R100..*path0/README..*path2/README" actual
+	git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
+	grep "^R100..*path0/COPYING..*path2/COPYING" actual &&
+	grep "^R100..*path0/README..*path2/README" actual
 '
 
 test_expect_success 'succeed when source is a prefix of destination' '
-     git mv path2/COPYING path2/COPYING-renamed
+	git mv path2/COPYING path2/COPYING-renamed
 '
 
 test_expect_success 'moving whole subdirectory into subdirectory' '
-     git mv path2 path1
+	git mv path2 path1
 '
 
 test_expect_success 'commiting the change' '
-     git commit -m dir-move -a
+	git commit -m dir-move -a
 '
 
 test_expect_success 'checking the commit' '
-     git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
-     grep "^R100..*path2/COPYING..*path1/path2/COPYING" actual &&
-     grep "^R100..*path2/README..*path1/path2/README" actual
+	git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
+	grep "^R100..*path2/COPYING..*path1/path2/COPYING" actual &&
+	grep "^R100..*path2/README..*path1/path2/README" actual
 '
 
 test_expect_success 'do not move directory over existing directory' '
-     mkdir path0 && mkdir path0/path2 && test_must_fail git mv path2 path0
+	mkdir path0 && mkdir path0/path2 && test_must_fail git mv path2 path0
 '
 
 test_expect_success 'move into "."' '
-     git mv path1/path2/ .
+	git mv path1/path2/ .
 '
 
 test_expect_success "Michael Cassar's test case" '
-- 
2.25.1

