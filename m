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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97311C433E9
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6183664E45
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhBKTs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 14:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbhBKTsM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 14:48:12 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C62C061794
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:47:14 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id q72so4015996pjq.2
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uXSTEO0o7kDrTeqO38qlBwvzZxRkZ+or+LkXW1C9FOU=;
        b=WJOfKyDKFDiIG+1+wC3oORlGosKr3K98RGPjU5mWPsamtBox1W3VUxVKuMo3Oe7hvT
         NEHzDFyJeRl4A5TYv6bG2wBnNIH5LHYnzZC1BwIhDw+Ksjot60mwyF1C5y1HdSnC4GsH
         8dvSgk/dsqr0+cYauvqMxg0BF5R01m54/Rf+kTA4gNwhxAhX85Sxy1g9bqtXKPdRLpAW
         MsIdGfhiGg66au4e5mYCQCLuI9kfVe5/BgaEl/noP94HrUV/Dh2RCrYhdkkwnpZK2PkQ
         YIFXHAl0rsncdBF1nYwFNp9jRHt+lsw6gcLgWqXk7XM35Hp55Bqct+I9/0ZfzdRRAX0U
         m2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uXSTEO0o7kDrTeqO38qlBwvzZxRkZ+or+LkXW1C9FOU=;
        b=WPLLvR9MtIwJEbuSOIinO6jXVSpzprNrq3g5mBZZGb1hpbQEBIbF6/2Grem3bLeXle
         cjDNId9D0WnEfo+//OlqE4x+W3yRe+EMTZjxQkEJXs459ZyS0Sv5OjoujNq75j/aZX6f
         aWTwmuaJ6Pn4K+tFUxTSxagp9CbQrjoqVHYE/nyqeW0fBy56GiZ4T0JyQFdDWqevxVH1
         mfb4puPd0WakDEJdT/44Zug8ORt0VQUCZeQ+5PYUQJf/PLX6MLR5UrEZCgXvU6CXkHhq
         1GIfSHLDoAsdnjICB86vYxCOd+93jHtONMPnqskwetuOgGC+mDwSzc8AFnHBYU3Dpfjm
         IdHA==
X-Gm-Message-State: AOAM533xvQWZ3O+6YUBC/4WbkgS5g51Uph9xcXmBqu8iR0Z4S2IarI0C
        I/04A3lugwmENgdUQdj225G3hbUJhNLczA==
X-Google-Smtp-Source: ABdhPJz903d7C37wLSbQkbGifUknFg9+8iKZZiclyAkxkND63ZYh18y45mXUeP+xpZeX1nJIRdnF7g==
X-Received: by 2002:a17:90a:ca09:: with SMTP id x9mr5492963pjt.52.1613072833697;
        Thu, 11 Feb 2021 11:47:13 -0800 (PST)
Received: from localhost.localdomain ([47.8.36.172])
        by smtp.gmail.com with ESMTPSA id a141sm6524778pfa.189.2021.02.11.11.47.11
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 11:47:13 -0800 (PST)
From:   Shubham Verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 01/10] t7001: modernize test formatting
Date:   Fri, 12 Feb 2021 01:16:55 +0530
Message-Id: <20210211194704.28913-2-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211194704.28913-1-shubhunic@gmail.com>
References: <20210211194704.28913-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some tests in this script are formatted using a very old style:

        test_expect_success \
            'title' \
            'body line 1 &&
            body line 2'

Update the formatting to the modern style:

        test_expect_success 'title' '
            body line 1 &&
            body line 2
        '

Signed-off-by: Shubham Verma <shubhunic@gmail.com>
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

