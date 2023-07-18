Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A17DEB64DC
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 23:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjGRX3s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 19:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGRX3r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 19:29:47 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7299BEC
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 16:29:42 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-635e5b06aaeso33831026d6.0
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 16:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689722981; x=1692314981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcjyOdylbZMXZKh6qS4U2TRH1fnfqpaOkwFJE4LTIvE=;
        b=Lc3bzGhxktIBijzUTDVeiSuu7fpBuvyb/J0USHfXz5Q2sTubXVKDpmAxCICU6Naq+c
         cm07dtw/FzoJGvYzTX7X5dPb2Q/WnK+h+RS+nRPqjzPu8m8SXDws4bPBXpSaHaYB55AY
         7o54KTYQQ4rOjIn5mDGOPDSHdvYjxwUWhyV6N2yRFi3maFchO7Ej9ooAXmQughPXzIFM
         Y1D4fteBzmA0vA1TocTxd1clGSSGG+U/gDcOwOeQ61qY2bO5ncn015pr1/xqhoHmK46V
         ZgedCzcF4J0y9GXvL3SK1RJBWdJpjYcDioPSa+XIW53lqGcEpU/PVcM6HvwEvXuwuQj6
         nd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689722981; x=1692314981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcjyOdylbZMXZKh6qS4U2TRH1fnfqpaOkwFJE4LTIvE=;
        b=QcqjdKfYSSvtawCiPGQqyz7rSdkbxSHZAbME6uIkOZy+fVfuX+iMZa/hzmcZDh4g77
         41nwurB2qQ/wx5fCMTl3ZezgL3Ptppi4t18xD6zsBbWuc931XHSVyQSzZ6zTMSjLEKMx
         Ig8t8HIn2zSUQm5I/9cWTcyodTWmuXts/4fccC38uAONu1B9NIowUv68wzNIpvStjYIE
         bGWfJwKVYMVusGFLfX7dLmMoVlQ1PhBJv24R99DWi9yoWhan0RXaHEftmX+jMJhu2KwZ
         Ux6qbaTzcqquyJUGyy1bhkSk32N4w10H+TloUanCexssLWV5I526xssljEmOBXaH3ASi
         n+mw==
X-Gm-Message-State: ABy/qLZopUHdUJRAhkpQPx970LN0cXYECK8dQAd6N/Gtfq8JkQwjhlRx
        pSkyPiN8TFtC85yzxDNZQ1JVaimpapNqJw==
X-Google-Smtp-Source: APBJJlH6uPQxwZxMCp7SN/ATPj9ibD2gX4cEcL45yQbFeH7pPCPjZbeCzFGnlYKU3GQXxeXe0GpEAA==
X-Received: by 2002:a05:6214:4402:b0:635:f546:83c4 with SMTP id oj2-20020a056214440200b00635f54683c4mr3174448qvb.54.1689722981128;
        Tue, 18 Jul 2023 16:29:41 -0700 (PDT)
Received: from localhost.localdomain ([69.158.190.118])
        by smtp.googlemail.com with ESMTPSA id h18-20020a0cf212000000b0063640486254sm1057695qvk.116.2023.07.18.16.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 16:29:40 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com
Subject: [PATCH v4 0/3] check-attr: integrate with sparse-index
Date:   Tue, 18 Jul 2023 19:29:13 -0400
Message-Id: <20230718232916.31660-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230711133035.16916-1-cheskaqiqi@gmail.com>
References: <20230711133035.16916-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

change against v3:

* update a new commit message

* update read_attr_from_index function

* The order of the patches has been rearranged to better illustrate
the problem and its solution.

1.t1092: add tests for git check-attr 
2.attr.c: read attributes in a sparse directory
3.check-attr: integrate with sparse-index

The new order of patches allows us to introduce a failing test case in
the patch 1, which then hen back to  "test_expect_success" in patch 2.
This approach is designed to concretely show why reading attributes
from a sparse directory is needed: without this functionality, the
sparse index case doesn't work correctly for git check-attr.

* Enhanced the comments in the code to provide more detail. Added
explanations as to why 1) it matters whether 'pos' identifies a
value that exists in the index or not, and 2) the rationale behind
looking for the sparse directory containing the path

* Add a test 'diff --check with pathspec outside sparse definition'.
It starts by disabling the trailing whitespace and space-before-tab
checks using the core.whitespace configuration option. Then, it
specifically re-enables the trailing whitespace check for a file located
in a sparse directory. This is accomplished by adding a
whitespace=trailing-space rule to the .gitattributes file within that
directory. To ensure that only the .gitattributes file in the index is
being read, and not any .gitattributes files in the working tree, the
test removes the .gitattributes file from the working tree after adding
it to the index. The final part of the test uses 'git diff --check' to
verify the correct application of the attribute rules. This ensures that
the .gitattributes file is correctly read from index and applied, even
when the file's path falls outside of the sparse-checkout definition.

* fix whitespace error 

Shuqi Liang (3):
  t1092: add tests for 'git check-attr'
  attr.c: read attributes in a sparse directory
  check-attr: integrate with sparse-index

 attr.c                                   | 60 +++++++++++++++-------
 builtin/check-attr.c                     |  3 ++
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 63 ++++++++++++++++++++++++
 4 files changed, 109 insertions(+), 18 deletions(-)

Range-diff against v3:
1:  199cc90a5b < -:  ---------- attr.c: read attributes in a sparse directory
2:  eefce85083 ! 1:  9c43eea9cc t1092: add tests for `git check-attr`
    @@ Metadata
     Author: Shuqi Liang <cheskaqiqi@gmail.com>
     
      ## Commit message ##
    -    t1092: add tests for `git check-attr`
    +    t1092: add tests for 'git check-attr'
     
    -    Add smudge/clean filters in .gitattributes files inside the affected
    -    sparse directories in test 'merge with conflict outside cone', make sure
    -    it behaves as expected when path is outside of sparse-checkout.
    +    Add tests for `git check-attr`, make sure attribute file does get read
    +    from index when path is either inside or outside of sparse-checkout
    +    definition.
     
    -    Add tests for `git check-attr`, make sure it behaves as expected when
    -    path is both inside or outside of sparse-checkout definition.
    +    Add a test named 'diff --check with pathspec outside sparse definition'.
    +    It starts by disabling the trailing whitespace and space-before-tab
    +    checks using the core.whitespace configuration option. Then, it
    +    specifically re-enables the trailing whitespace check for a file located
    +    in a sparse directory. This is accomplished by adding a
    +    whitespace=trailing-space rule to the .gitattributes file within that
    +    directory. To ensure that only the .gitattributes file in the index is
    +    being read, and not any .gitattributes files in the working tree, the
    +    test removes the .gitattributes file from the working tree after adding
    +    it to the index. The final part of the test uses 'git diff --check' to
    +    verify the correct application of the attribute rules. This ensures that
    +    the .gitattributes file is correctly read from index and applied, even
    +    when the file's path falls outside of the sparse-checkout definition.
     
         Helped-by: Victoria Dye <vdye@github.com>
         Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
     
      ## t/t1092-sparse-checkout-compatibility.sh ##
    -@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'merge with conflict outside cone' '
    - 
    - 	test_all_match git checkout -b merge-tip merge-left &&
    - 	test_all_match git status --porcelain=v2 &&
    -+
    -+	echo "a filter=rot13" >>.gitattributes &&
    -+	run_on_sparse mkdir folder1 &&
    -+	run_on_all cp ../.gitattributes ./folder1 &&
    -+	git -C full-checkout add folder1/.gitattributes &&
    -+	run_on_sparse git add --sparse folder1/.gitattributes &&
    -+	run_on_all git commit -m "add .gitattributes" &&
    -+	test_sparse_match git sparse-checkout reapply &&
    -+	git config filter.rot13.clean "tr 'A-Za-z' 'N-ZA-Mn-za-m'" &&
    -+	git config filter.rot13.smudge "tr 'A-Za-z' 'N-ZA-Mn-za-m'" &&
    -+
    - 	test_all_match test_must_fail git merge -m merge merge-right &&
    - 	test_all_match git status --porcelain=v2 &&
    - 
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'worktree is not expanded' '
      	ensure_not_expanded worktree remove .worktrees/hotfix
      '
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'worktree is not e
     +	test_all_match git check-attr -a --cached -- deep/a
     +'
     +
    -+test_expect_success 'check-attr with pathspec outside sparse definition' '
    ++test_expect_failure 'check-attr with pathspec outside sparse definition' '
     +	init_repos &&
     +
     +	echo "a -crlf myAttr" >>.gitattributes &&
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'worktree is not e
     +	test_sparse_match git sparse-checkout reapply &&
     +	test_all_match git check-attr  -a --cached -- folder1/a
     +'
    ++
    ++test_expect_failure 'diff --check with pathspec outside sparse definition' '
    ++	init_repos &&
    ++
    ++	write_script edit-contents <<-\EOF &&
    ++	echo "a " >"$1"
    ++	EOF
    ++
    ++	git config core.whitespace -trailing-space,-space-before-tab &&
    ++
    ++	echo "a whitespace=trailing-space,space-before-tab" >>.gitattributes &&
    ++	run_on_all mkdir -p folder1 &&
    ++	run_on_all cp ../.gitattributes ./folder1 &&
    ++	git -C full-checkout add folder1/.gitattributes &&
    ++	run_on_sparse git add --sparse folder1/.gitattributes &&
    ++	run_on_all rm folder1/.gitattributes &&
    ++	run_on_all  ../edit-contents folder1/a &&
    ++	test_all_match test_must_fail git diff --check -- folder1/a
    ++'
     +
      test_done
-:  ---------- > 2:  63ff110b1c attr.c: read attributes in a sparse directory
3:  65c2624504 ! 3:  7a9c2da30d check-attr: integrate with sparse-index
    @@ Metadata
      ## Commit message ##
         check-attr: integrate with sparse-index
     
    -    Set the requires-full-index to false for "diff-tree".
    +    Set the requires-full-index to false for "check-attr".
     
         Add a test to ensure that the index is not expanded whether the files
         are outside or inside the sparse-checkout cone when the sparse index is
    @@ t/perf/p2000-sparse-operations.sh: test_perf_on_all git diff-files -- $SPARSE_CO
      test_done
     
      ## t/t1092-sparse-checkout-compatibility.sh ##
    -@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'check-attr with pathspec outside sparse definition' '
    - 	test_all_match git check-attr  -a --cached -- folder1/a
    +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'diff --check with pathspec outside sparse definition' '
    + 	test_all_match test_must_fail git diff --check -- folder1/a
      '
      
     +test_expect_success 'sparse-index is not expanded: check-attr' '
-- 
2.39.0

