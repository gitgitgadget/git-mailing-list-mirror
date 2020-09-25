Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDEAC4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23B0F20936
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eL++Cw21"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgIYRDQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 13:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgIYRDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 13:03:16 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D30C0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:03:15 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id y14so3091278pgf.12
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vmW/fZstOZhPLL4ZmE2ESKtzfWsrN1mWmcALpZxf0Lk=;
        b=eL++Cw21yJC3egS58hzC69RK4rqsyVXKIKesA83DKeBkyOD9RKsJcktj3E2EfrELES
         cwLaCmchnoAd560NjpjLClVMskZqRZB3UYvMLGc79oJvFD+G029gPGjZ0nN4W/SYLxwd
         Cc4KWZU93DwuvqUaQmXCuHmY/9qOVDdQzRXiAMAulwQZSS6Ij1mS83f6TyTGCrSZRF/b
         /+2KSf/PTHOACkxlyFFSJ4/VOkaqCUFDKNRbPGqJtx/ufqMpiPoDT6YOKat+vf5Tcqc8
         WqgS/mftyoO9oPVDqs2R9zf4IyUlnRLYKBaTc+MFynjLzW0rGsdZeVBg/wFbZFD2YD2s
         deSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vmW/fZstOZhPLL4ZmE2ESKtzfWsrN1mWmcALpZxf0Lk=;
        b=RFuOGuilP4YsOaTvatYUEdFnk1bKF7zlX/n8ZyTRlKIt4mvlPELHngOlFUVIImFybg
         fgNOAd+E4bK1xuwY8FsEqK59XqqnsKzJYzcWUcZT9oQSMpYZZrTKLBqui+YwMZCpqzI/
         PaYfBHtU3CK779BeJKp9mguZY39VArkwA7T09sszgJBU4ritWoILPyduDz9FsrmNcRmC
         nQLtAYvqZKWe0ikRBfsnfvFXsEl+Etu3BkuF2ijVIS5/asjMAQCoCOn/ummHi39H11kN
         hzgJPQ4dM+vreEamX0vrIwBBQqboPiTHjw9dlRERsX74Al6K13iUf2SZ0GA6Oy/B6x5f
         oJ9Q==
X-Gm-Message-State: AOAM532Sq+3Lm0Hnf8w20k131khhE9+SnUknyoLMaYbpSoEqERk2zHb7
        SNFblIIGzDGoO8LirU3xwWIwGJNynSQu+Q==
X-Google-Smtp-Source: ABdhPJxN2oXHHLoxV4jO9iypEwjXogo8pAi/ayu985SQ3ouXi3JJ66zkuk5US/f8UKXCUsI0PxAfvQ==
X-Received: by 2002:a63:c30a:: with SMTP id c10mr807993pgd.377.1601053394821;
        Fri, 25 Sep 2020 10:03:14 -0700 (PDT)
Received: from localhost.localdomain ([47.9.163.48])
        by smtp.gmail.com with ESMTPSA id k27sm2822467pgm.29.2020.09.25.10.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 10:03:14 -0700 (PDT)
From:   shubham verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Cc:     Shubham Verma <shubhunic@gmail.com>
Subject: [PATCH 01/11] t7001: convert tests from the old style to the current style
Date:   Fri, 25 Sep 2020 22:32:46 +0530
Message-Id: <20200925170256.11490-2-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925170256.11490-1-shubhunic@gmail.com>
References: <20200925170256.11490-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Shubham Verma <shubhunic@gmail.com>

To modernize the t7001 test script, let's change the style of
its tests from an old one to the modern one.

Signed-off-by: shubham verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 192 +++++++++++++++++++++++++-------------------------
 1 file changed, 96 insertions(+), 96 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 63d5f41a12..4bbb51e578 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -3,74 +3,74 @@
 test_description='git mv in subdirs'
 . ./test-lib.sh
 
-test_expect_success \
-    'prepare reference tree' \
-    'mkdir path0 path1 &&
+test_expect_success 'prepare reference tree' '
+     mkdir path0 path1 &&
      cp "$TEST_DIRECTORY"/../COPYING path0/COPYING &&
      git add path0/COPYING &&
-     git commit -m add -a'
+     git commit -m add -a
+'
 
-test_expect_success \
-    'moving the file out of subdirectory' \
-    'cd path0 && git mv COPYING ../path1/COPYING'
+test_expect_success 'moving the file out of subdirectory' '
+     cd path0 && git mv COPYING ../path1/COPYING
+'
 
 # in path0 currently
-test_expect_success \
-    'commiting the change' \
-    'cd .. && git commit -m move-out -a'
+test_expect_success 'commiting the change' '
+     cd .. && git commit -m move-out -a
+'
 
-test_expect_success \
-    'checking the commit' \
-    'git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
-    grep "^R100..*path0/COPYING..*path1/COPYING" actual'
+test_expect_success 'checking the commit' '
+     git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
+     grep "^R100..*path0/COPYING..*path1/COPYING" actual
+'
 
-test_expect_success \
-    'moving the file back into subdirectory' \
-    'cd path0 && git mv ../path1/COPYING COPYING'
+test_expect_success 'moving the file back into subdirectory' '
+     cd path0 && git mv ../path1/COPYING COPYING
+'
 
 # in path0 currently
-test_expect_success \
-    'commiting the change' \
-    'cd .. && git commit -m move-in -a'
-
-test_expect_success \
-    'checking the commit' \
-    'git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
-    grep "^R100..*path1/COPYING..*path0/COPYING" actual'
-
-test_expect_success \
-    'mv --dry-run does not move file' \
-    'git mv -n path0/COPYING MOVED &&
+test_expect_success 'commiting the change' '
+     cd .. && git commit -m move-in -a
+'
+
+test_expect_success 'checking the commit' '
+     git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
+     grep "^R100..*path1/COPYING..*path0/COPYING" actual
+'
+
+test_expect_success 'mv --dry-run does not move file' '
+     git mv -n path0/COPYING MOVED &&
      test -f path0/COPYING &&
-     test ! -f MOVED'
+     test ! -f MOVED
+'
 
-test_expect_success \
-    'checking -k on non-existing file' \
-    'git mv -k idontexist path0'
+test_expect_success 'checking -k on non-existing file' '
+     git mv -k idontexist path0
+'
 
-test_expect_success \
-    'checking -k on untracked file' \
-    'touch untracked1 &&
+test_expect_success 'checking -k on untracked file' '
+     touch untracked1 &&
      git mv -k untracked1 path0 &&
      test -f untracked1 &&
-     test ! -f path0/untracked1'
+     test ! -f path0/untracked1
+'
 
-test_expect_success \
-    'checking -k on multiple untracked files' \
-    'touch untracked2 &&
+test_expect_success 'checking -k on multiple untracked files' '
+     touch untracked2 &&
      git mv -k untracked1 untracked2 path0 &&
      test -f untracked1 &&
      test -f untracked2 &&
      test ! -f path0/untracked1 &&
-     test ! -f path0/untracked2'
+     test ! -f path0/untracked2
+'
 
-test_expect_success \
-    'checking -f on untracked file with existing target' \
-    'touch path0/untracked1 &&
+test_expect_success 'checking -f on untracked file with existing target' '
+     touch path0/untracked1 &&
      test_must_fail git mv -f untracked1 path0 &&
      test ! -f .git/index.lock &&
      test -f untracked1 &&
-     test -f path0/untracked1'
+     test -f path0/untracked1
+'
 
 # clean up the mess in case bad things happen
 rm -f idontexist untracked1 untracked2 \
@@ -78,79 +78,79 @@ rm -f idontexist untracked1 untracked2 \
      .git/index.lock
 rmdir path1
 
-test_expect_success \
-    'moving to absent target with trailing slash' \
-    'test_must_fail git mv path0/COPYING no-such-dir/ &&
+test_expect_success 'moving to absent target with trailing slash' '
+     test_must_fail git mv path0/COPYING no-such-dir/ &&
      test_must_fail git mv path0/COPYING no-such-dir// &&
      git mv path0/ no-such-dir/ &&
-     test_path_is_dir no-such-dir'
+     test_path_is_dir no-such-dir
+'
 
-test_expect_success \
-    'clean up' \
-    'git reset --hard'
+test_expect_success 'clean up' '
+     git reset --hard
+'
 
-test_expect_success \
-    'moving to existing untracked target with trailing slash' \
-    'mkdir path1 &&
+test_expect_success 'moving to existing untracked target with trailing slash' '
+     mkdir path1 &&
      git mv path0/ path1/ &&
-     test_path_is_dir path1/path0/'
+     test_path_is_dir path1/path0/
+'
 
-test_expect_success \
-    'moving to existing tracked target with trailing slash' \
-    'mkdir path2 &&
+test_expect_success 'moving to existing tracked target with trailing slash' '
+     mkdir path2 &&
      >path2/file && git add path2/file &&
      git mv path1/path0/ path2/ &&
-     test_path_is_dir path2/path0/'
+     test_path_is_dir path2/path0/
+'
 
-test_expect_success \
-    'clean up' \
-    'git reset --hard'
+test_expect_success 'clean up' '
+     git reset --hard
+'
 
-test_expect_success \
-    'adding another file' \
-    'cp "$TEST_DIRECTORY"/../README.md path0/README &&
+test_expect_success 'adding another file' '
+     cp "$TEST_DIRECTORY"/../README.md path0/README &&
      git add path0/README &&
-     git commit -m add2 -a'
+     git commit -m add2 -a
+'
 
-test_expect_success \
-    'moving whole subdirectory' \
-    'git mv path0 path2'
+test_expect_success 'moving whole subdirectory' '
+     git mv path0 path2
+'
 
-test_expect_success \
-    'commiting the change' \
-    'git commit -m dir-move -a'
+test_expect_success 'commiting the change' '
+     git commit -m dir-move -a
+'
 
-test_expect_success \
-    'checking the commit' \
-    'git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
+test_expect_success 'checking the commit' '
+     git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
      grep "^R100..*path0/COPYING..*path2/COPYING" actual &&
-     grep "^R100..*path0/README..*path2/README" actual'
+     grep "^R100..*path0/README..*path2/README" actual
+'
 
-test_expect_success \
-    'succeed when source is a prefix of destination' \
-    'git mv path2/COPYING path2/COPYING-renamed'
+test_expect_success 'succeed when source is a prefix of destination' '
+     git mv path2/COPYING path2/COPYING-renamed
+'
 
-test_expect_success \
-    'moving whole subdirectory into subdirectory' \
-    'git mv path2 path1'
+test_expect_success 'moving whole subdirectory into subdirectory' '
+     git mv path2 path1
+'
 
-test_expect_success \
-    'commiting the change' \
-    'git commit -m dir-move -a'
+test_expect_success 'commiting the change' '
+     git commit -m dir-move -a
+'
 
-test_expect_success \
-    'checking the commit' \
-    'git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
+test_expect_success 'checking the commit' '
+     git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
      grep "^R100..*path2/COPYING..*path1/path2/COPYING" actual &&
-     grep "^R100..*path2/README..*path1/path2/README" actual'
+     grep "^R100..*path2/README..*path1/path2/README" actual
+'
 
-test_expect_success \
-    'do not move directory over existing directory' \
-    'mkdir path0 && mkdir path0/path2 && test_must_fail git mv path2 path0'
+test_expect_success 'do not move directory over existing directory' '
+     mkdir path0 && mkdir path0/path2 && test_must_fail git mv path2 path0
+'
 
-test_expect_success \
-    'move into "."' \
-    'git mv path1/path2/ .'
+test_expect_success 'move into "."' '
+     git mv path1/path2/ .
+'
 
 test_expect_success "Michael Cassar's test case" '
 	rm -fr .git papers partA &&
-- 
2.25.1

