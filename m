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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3500FC433E6
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF77964DE9
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhBKTso (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 14:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhBKTsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 14:48:16 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D7EC0617A7
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:47:17 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id k22so3885068pll.6
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uGrxZl9dAzunzOcvSDb8Ny+ykoCovHrWNq9nuBmoDZE=;
        b=R2RO1gF2X+bc56digNfWWwnep1BBJzMGvGSGB9FsxL0DCSEEkMxA2IbPDm3rEgY3RW
         GkwJX/5pOHZqMDD+PYRYkY18tiyXMHcv3WzPK+CGUEt7mQoHrZqxNf8UXbcgoDNv+fP0
         wRKsmVsYqX0Z5GLGAJ48oZyi84LmW5kOVoztvbB2/sdqteEn9zkbGjRzej/lg9PaD/7m
         qVcwf2co4ya1iitRa0u9KbiK8xujAJTkIVLO14eUhmRikbADw3NFtJonRoamhXJGQbtT
         wCEOzOyCe/yUQ9tWstD+s/cIy9JnnKNZoiN3vezN5TLzuBlPdio3i3vUmCxrD2kzACcT
         m2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uGrxZl9dAzunzOcvSDb8Ny+ykoCovHrWNq9nuBmoDZE=;
        b=SacK+PWJUgZSKhLRm4UyiLkR/OIx/pRS8GIyy5haIBP3FLw90/DkLh9Z0o8l7+wavw
         zDDKpS+zig6Dxk+nNJRHZZOc1xyWdLpNpNs0vKRuwzvLpeaaOzY372+XqRe+0N9ZH+Qn
         e+qTvbmZ8gM2eP0eBJ2Aty81uQRP1LaBtWYeqSJ+GWjCZjTnHoXUXXnrF99qav6AQ/W7
         7rRjQYBftIVsCRLF5CMnobiXEfZ1rbjpw6el1OglakYYFSEAUXWjLzr5mb8GjaBRwhLd
         G+XdfsHAEwS56FAtYwWUBVFKG967o6E+ILeCGhY76gQlw58pzBEWIt9guNHSwZEENkNp
         d9+Q==
X-Gm-Message-State: AOAM531Ezg+hic1k0W2UgpXPetjE/JCIoPFW/b10YhaBMOtEXqib5fNM
        sQPUfQfX0HfRYwapOwAUTDsvXEOsGSGmrw==
X-Google-Smtp-Source: ABdhPJzRxqgDmSOsuZK3sqaY1lEbKxTa9Bhr7GnMrZaNEvkup71IUtkAXrScxijF3hcik0xKQXygzg==
X-Received: by 2002:a17:902:6808:b029:e2:b405:fc0d with SMTP id h8-20020a1709026808b02900e2b405fc0dmr8701088plk.10.1613072835912;
        Thu, 11 Feb 2021 11:47:15 -0800 (PST)
Received: from localhost.localdomain ([47.8.36.172])
        by smtp.gmail.com with ESMTPSA id a141sm6524778pfa.189.2021.02.11.11.47.14
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 11:47:15 -0800 (PST)
From:   Shubham Verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 02/10] t7001: indent with TABs instead of spaces
Date:   Fri, 12 Feb 2021 01:16:56 +0530
Message-Id: <20210211194704.28913-3-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211194704.28913-1-shubhunic@gmail.com>
References: <20210211194704.28913-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Shubham Verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 120 +++++++++++++++++++++++++-------------------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 4bbb51e578..0f74c6339c 100755
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
+ 	grep "^R100..*path2/README..*path1/path2/README" actual
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

