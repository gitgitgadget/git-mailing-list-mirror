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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD7AC433E6
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AAE864EA6
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhBIRdw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 12:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbhBIRdn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 12:33:43 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC62C06174A
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 09:33:03 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gx20so2083707pjb.1
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 09:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2lD9hLXj1kZ49O1mX/kkyMcx/jRXpws57cAEAX+y3gw=;
        b=tRXg6nTpgxWUOeTPx5Uye1DxOFKBTSUDcSnSEr4aSk5ZiIS3sWCGBIME2zMA1rDWe2
         Rzlv8nBMRMGxY2N3VFj6dzItxGqD4fQpK8EKVGJG6WF9R8JsQjCv+GaiITG2G1xqEoIP
         z3K5X33SlVXfYmeJKs6JEFoyCM+RwDkqt6NG2kyhXKuu6UXp2JlKXC3X8BPJHujmPoHY
         jyb1hK72NpRglntRtgg4JhArAPUmMF5GnznXqpxRfApUCOw8q/Zgo/LBnsRAPlaYAM72
         gPerEF1TIu9SSVfxP6UUGcyjDB0F4muFXEiRrFYTUmACvedESbx7dMuNKt6O47LqI0Yd
         qU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2lD9hLXj1kZ49O1mX/kkyMcx/jRXpws57cAEAX+y3gw=;
        b=m8IgY9wpIz+Dt9D833vaWgpiWFCK0T1ki7Y65I2h2lfxtsFowK2qAKULltSfqFwBs9
         /f0hQTzXU6ZKNgV+oYfp5Nf157GlcgBSDCJfhTaf5HmI58jqlq8HIcKMB9ggkdEJ/8pN
         RjmwmBXQY3fx5F4N4u/PulEA46iLXdDnYpDtAlUmCUK8OWZPoYRqqax6LC5MQJczyPiv
         +guX8UnTxfFOwtjDyfiDTjmHLy3AsfPOhjyNcM/QESsdWAIlXJ4RTbFLgjFhYdKXVG3S
         Y5qwX1A7R6O02YQMpmDRMDrHkQtKnzZZ5gqbkfj7O9NtOtXkZBVMSJhR0qIGIP0pICJn
         Qtjg==
X-Gm-Message-State: AOAM530booOyVv6tONSSVuMuMbw2HjRbeNo9CqFYU2PHnf4cNCYktMRl
        4k/kka1MDqkwyF2GOedJXZZwJ5cXBoV3Vg==
X-Google-Smtp-Source: ABdhPJxi/eNIzyitbb4kXSPOilsVatF+cGUDGF8Uo/8T1/A2Uf1Gf2WPkdo68k0aafk1tRHiuKfZHA==
X-Received: by 2002:a17:902:52a:b029:da:989f:6c01 with SMTP id 39-20020a170902052ab02900da989f6c01mr21388777plf.45.1612891982625;
        Tue, 09 Feb 2021 09:33:02 -0800 (PST)
Received: from localhost.localdomain ([47.9.143.68])
        by smtp.gmail.com with ESMTPSA id g3sm20682607pfo.149.2021.02.09.09.33.00
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:33:01 -0800 (PST)
From:   shubham verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 01/10] t7001: modernize test formatting
Date:   Tue,  9 Feb 2021 23:02:45 +0530
Message-Id: <20210209173254.17712-2-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210209173254.17712-1-shubhunic@gmail.com>
References: <20210209173254.17712-1-shubhunic@gmail.com>
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

