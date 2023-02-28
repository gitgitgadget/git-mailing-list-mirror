Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F77C64EC7
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 18:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjB1SxH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 13:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjB1SxG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 13:53:06 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1D1AD32
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 10:53:03 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id g13-20020a63f40d000000b005015be7b9faso3718735pgi.15
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 10:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kVeaCEzLnT0NIZjL7mZ63lO6vRGg7Q+Q3gLyVHeDrBY=;
        b=JGQaeLAcUOgFJuzXPM9m9dS0Q+S8N+oBAdS5IauwftOlqz+dKsrm1BFbwhqQcr1lBN
         wHVhgzWp5XRl04hnGxaeAD5uQf3UkK/clByAvK77Ex5cF60B3d+thOnzYJZKzLfXw45e
         880EoR524a3X4hW2KUUShQX/FxTw53t1AT7+a6ngF5CKaN0bW1rF6vrjMQDPaL/AbzxB
         9ivqrUUtR6z40LzxjhHhp1yhgY5Hy0ScAfDSLCkraDe++cAUlq8YatPNRXfGJQyRKbQG
         zArJQQPhvT29KOxmu+FOL2sHD0gTBA3O5gHLQWI+OTpjzzMX6M2D6vPrAAnbaKYPEIXH
         B1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kVeaCEzLnT0NIZjL7mZ63lO6vRGg7Q+Q3gLyVHeDrBY=;
        b=O6vywdMCxOKFp5HZAYKSlYsH2SQ37X86e/w4+1SZE6EEX9z86hadoQbsVfLG1KTLP+
         YOffgr14YN7C+07ArdZkV671i0KnFXVVkSSZEL6SmJ/T4TfnSD1ZDoTLlnddKJZvuNMI
         v3+7EpNaWStZUUyzwYu80CfQEKS34PdMZxEuK9hW29nqgkm3JsSIu+8wlbb58Ba/MReG
         HuGYSV46WvkfQPNfQ5KsulIUji+BocCLEZ5lUe/OGzVXip/ddie5Hvd8i2dw2c/oILnr
         F02nqsNIWY5XYLEtIZ6ligGYxLTvZhX47Z/JbxcTzISLkGSqT+Z8WNlPvFwVHfWI8IQG
         7K7A==
X-Gm-Message-State: AO0yUKU6ZVRXPaB2j2GVq10jHbfSL2Et8aBfK7Dg6TJeoF2YQqIeRgjN
        RAzHl8p+NbiD4wEBNJ81JcJtZuh7S4pPkQTz+GXQKomNHyi1+SNYFgpJeXyhFk0SEzMOQXRJnvp
        UhFIL4YYM1IR5dIQKkW6lqkYRN0noNwwWIv7pXOegwoUD+t82QdALTdUg7hr4kcGDbg==
X-Google-Smtp-Source: AK7set8DZvgzm3hph3geW412T61L1V3ZT7eb/glbf3pbpSwxVRqkTFG1tbnfWHHSTn4GziiWvyuEyWy67p/Rczw=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:f7d1:b0:19a:f153:b73e with SMTP
 id h17-20020a170902f7d100b0019af153b73emr1356953plw.4.1677610382733; Tue, 28
 Feb 2023 10:53:02 -0800 (PST)
Date:   Tue, 28 Feb 2023 18:52:53 +0000
In-Reply-To: <20230213182134.2173280-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230213182134.2173280-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230228185253.2356546-1-calvinwan@google.com>
Subject: [PATCH v2 0/6] add: block invalid submodules
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, steadmon@google.com,
        peff@peff.net, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A couple of significant changes were made since the RFC. From the
feedback gathered it seems like the idea of this series is worth
pursuing -- thanks Peff and Junio for the reviews!

In the initial RFC, we continued using `--no-warn-embedded-repo` to
allow the user to add an embedded repo, but the naming of that option
was not ideal. This reroll adds `--allow-embedded-repo` and deprecates
`--no-warn-embedded-repo`.

While I initially claimed that there were incorrectly setup .gitmodules
tests with duplicate paths, it turns out that was caused by patch 4/6 of
this series. I added a new patch (see 5/6) that fixes the issue.
Subsequently, this means that the memory leak does not occur any more
(maybe I should still include that patch -- it's an edge case that comes
from a manually misconfigured .gitmodules).

Lastly I cleaned up the advice message and some of the tests --
replacing `git add` with `git submodule add` only in submodule specific
cases and some style cleanups.

Calvin Wan (1):
  tests: remove duplicate .gitmodules path

Josh Steadmon (5):
  t4041, t4060: modernize test style
  tests: Use `git submodule add` instead of `git add`
  tests: use `git submodule add` and fix expected diffs
  tests: use `git submodule add` and fix expected status
  add: reject nested repositories

 Documentation/git-add.txt                    |  15 +-
 builtin/add.c                                |  37 ++-
 builtin/submodule--helper.c                  |   4 +-
 t/t0008-ignores.sh                           |   2 +-
 t/t2013-checkout-submodule.sh                |   4 +-
 t/t2103-update-index-ignore-missing.sh       |   2 +-
 t/t2107-update-index-basic.sh                |   2 +-
 t/t3040-subprojects-basic.sh                 |   5 +-
 t/t3050-subprojects-fetch.sh                 |   3 +-
 t/t3404-rebase-interactive.sh                |   3 +-
 t/t3701-add-interactive.sh                   |   5 +-
 t/t4010-diff-pathspec.sh                     |   2 +-
 t/t4020-diff-external.sh                     |   2 +-
 t/t4027-diff-submodule.sh                    |  58 ++---
 t/t4035-diff-quiet.sh                        |   2 +-
 t/t4041-diff-submodule-option.sh             | 232 +++++++++++++----
 t/t4060-diff-submodule-option-diff-format.sh | 226 ++++++++++++-----
 t/t5531-deep-submodule-push.sh               |   4 +-
 t/t6416-recursive-corner-cases.sh            |  12 +-
 t/t6430-merge-recursive.sh                   |   2 +-
 t/t6437-submodule-merge.sh                   |  12 +-
 t/t7400-submodule-basic.sh                   |   4 +-
 t/t7401-submodule-summary.sh                 |   4 +-
 t/t7402-submodule-rebase.sh                  |   2 +-
 t/t7412-submodule-absorbgitdirs.sh           |   2 +-
 t/t7414-submodule-mistakes.sh                |  29 ++-
 t/t7450-bad-git-dotfiles.sh                  |   2 +-
 t/t7506-status-submodule.sh                  |  15 +-
 t/t7508-status.sh                            | 248 ++++++++++++-------
 29 files changed, 649 insertions(+), 291 deletions(-)

Range-diff against v1:
1:  34eacaabbd < -:  ---------- leak fix: cache_put_path
2:  2da941fc59 ! 1:  3efc25bf0e t4041, t4060: modernize test style
    @@ Commit message
         easier to diagnose, because errors will caught immediately rather than
         in later unrelated test_expect blocks.
     
    +    While at it, have tests clean up after themselves with
    +    test_when_finished and fix other minor style issues.
    +
         Signed-off-by: Josh Steadmon <steadmon@google.com>
         Signed-off-by: Calvin Wan <calvinwan@google.com>
     
    @@ t/t4041-diff-submodule-option.sh: commit_file () {
     -fullhead1=$(cd sm1; git rev-parse --verify HEAD)
     +test_expect_success 'setup' '
     +	test_create_repo sm1 &&
    -+	add_file . foo >/dev/null &&
    ++	add_file . foo &&
     +	head1=$(add_file sm1 foo1 foo2) &&
    -+	fullhead1=$(cd sm1 && git rev-parse --verify HEAD)
    ++	fullhead1=$(git -C sm1 rev-parse --verify HEAD)
     +'
      
      test_expect_success 'added submodule' '
    @@ t/t4041-diff-submodule-option.sh: test_expect_success 'modified submodule(forwar
      
     -fullhead2=$(cd sm1; git rev-parse --verify HEAD)
      test_expect_success 'modified submodule(forward) --submodule=short' '
    -+	fullhead2=$(cd sm1 && git rev-parse --verify HEAD) &&
    ++	fullhead2=$(git -C sm1 rev-parse --verify HEAD) &&
      	git diff --submodule=short >actual &&
      	cat >expected <<-EOF &&
      	diff --git a/sm1 b/sm1
    @@ t/t4041-diff-submodule-option.sh: test_expect_success 'modified submodule(backwa
      
      test_expect_success 'typechanged submodule(submodule->blob), --cached' '
      	git diff --submodule=log --cached >actual &&
    +@@ t/t4041-diff-submodule-option.sh: test_expect_success 'typechanged submodule(submodule->blob), --cached' '
    + '
    + 
    + test_expect_success 'typechanged submodule(submodule->blob)' '
    ++	test_when_finished rm -rf sm1 &&
    + 	git diff --submodule=log >actual &&
    + 	cat >expected <<-EOF &&
    + 	diff --git a/sm1 b/sm1
     @@ t/t4041-diff-submodule-option.sh: test_expect_success 'typechanged submodule(submodule->blob)' '
      	test_cmp expected actual
      '
    @@ t/t4041-diff-submodule-option.sh: test_expect_success 'typechanged submodule(sub
     -rm -rf sm1 &&
     -git checkout-index sm1
      test_expect_success 'typechanged submodule(submodule->blob)' '
    -+	rm -rf sm1 &&
    ++	test_when_finished rm -f sm1 &&
     +	git checkout-index sm1 &&
      	git diff-index -p --submodule=log HEAD >actual &&
      	cat >expected <<-EOF &&
    @@ t/t4041-diff-submodule-option.sh: test_expect_success 'typechanged submodule(sub
     -head6=$(add_file sm1 foo6 foo7)
     -fullhead6=$(cd sm1; git rev-parse --verify HEAD)
      test_expect_success 'nonexistent commit' '
    -+	rm -f sm1 &&
     +	test_create_repo sm1 &&
     +	head6=$(add_file sm1 foo6 foo7) &&
    -+	fullhead6=$(cd sm1 && git rev-parse --verify HEAD) &&
    ++	fullhead6=$(git -C sm1 rev-parse --verify HEAD) &&
      	git diff-index -p --submodule=log HEAD >actual &&
      	cat >expected <<-EOF &&
      	Submodule sm1 $head4...$head6 (commits not present)
    @@ t/t4041-diff-submodule-option.sh: test_expect_success 'typechanged submodule(blo
      	git diff-index -p --submodule=log HEAD >actual &&
      	test_must_be_empty actual
      '
    +@@ t/t4041-diff-submodule-option.sh: test_expect_success 'submodule contains untracked and modified content (dirty ig
    + '
    + 
    + test_expect_success 'submodule contains untracked and modified content (all ignored)' '
    ++	test_when_finished rm -f sm1/new-file &&
    + 	echo new > sm1/foo6 &&
    + 	git diff-index -p --ignore-submodules --submodule=log HEAD >actual &&
    + 	test_must_be_empty actual
    + '
    + 
    + test_expect_success 'submodule contains modified content' '
    +-	rm -f sm1/new-file &&
    + 	git diff-index -p --submodule=log HEAD >actual &&
    + 	cat >expected <<-EOF &&
    + 	Submodule sm1 contains modified content
     @@ t/t4041-diff-submodule-option.sh: test_expect_success 'submodule contains modified content' '
      	test_cmp expected actual
      '
    @@ t/t4041-diff-submodule-option.sh: test_expect_success 'submodule contains modifi
      	git diff-index -p --submodule=log HEAD >actual &&
      	cat >expected <<-EOF &&
      	Submodule sm1 $head6..$head8:
    +@@ t/t4041-diff-submodule-option.sh: test_expect_success 'modified submodule contains untracked and modified content
    + '
    + 
    + test_expect_success 'modified submodule contains untracked and modified content (all ignored)' '
    ++	test_when_finished rm -f sm1/new-file &&
    + 	echo modification >> sm1/foo6 &&
    + 	git diff-index -p --ignore-submodules --submodule=log HEAD >actual &&
    + 	test_must_be_empty actual
    + '
    + 
    + test_expect_success 'modified submodule contains modified content' '
    +-	rm -f sm1/new-file &&
    ++	test_when_finished rm -rf sm1 &&
    + 	git diff-index -p --submodule=log HEAD >actual &&
    + 	cat >expected <<-EOF &&
    + 	Submodule sm1 contains modified content
     @@ t/t4041-diff-submodule-option.sh: test_expect_success 'modified submodule contains modified content' '
      	test_cmp expected actual
      '
      
     -rm -rf sm1
      test_expect_success 'deleted submodule' '
    -+	rm -rf sm1 &&
      	git diff-index -p --submodule=log HEAD >actual &&
      	cat >expected <<-EOF &&
    - 	Submodule sm1 $head6...0000000 (submodule deleted)
     @@ t/t4041-diff-submodule-option.sh: test_expect_success 'path filter' '
      	test_cmp expected actual
      '
    @@ t/t4041-diff-submodule-option.sh: test_expect_success 'given commit --submodule'
     -fullhead7=$(cd sm2; git rev-parse --verify HEAD)
     -
      test_expect_success 'given commit --submodule=short' '
    -+	fullhead7=$(cd sm2 && git rev-parse --verify HEAD) &&
    ++	fullhead7=$(git -C sm2 rev-parse --verify HEAD) &&
      	git diff-index -p --submodule=short HEAD^ >actual &&
      	cat >expected <<-EOF &&
      	diff --git a/sm1 b/sm1
    @@ t/t4060-diff-submodule-option-diff-format.sh: test_expect_success 'modified subm
      
     -fullhead2=$(cd sm1; git rev-parse --verify HEAD)
      test_expect_success 'modified submodule(forward) --submodule=short' '
    -+	fullhead2=$(cd sm1 && git rev-parse --verify HEAD) &&
    ++	fullhead2=$(git -C sm1 rev-parse --verify HEAD) &&
      	git diff --submodule=short >actual &&
      	cat >expected <<-EOF &&
      	diff --git a/sm1 b/sm1
    @@ t/t4060-diff-submodule-option-diff-format.sh: test_expect_success 'modified subm
      test_expect_success 'modified submodule(backward)' '
     +	commit_file sm1 &&
     +	head3=$(
    -+		cd sm1 &&
    -+		git reset --hard HEAD~2 >/dev/null &&
    -+		git rev-parse --short --verify HEAD
    ++		git -C sm1 reset --hard HEAD~2 >/dev/null &&
    ++		git -C sm1 rev-parse --short --verify HEAD
     +	) &&
      	git diff-index -p --submodule=diff HEAD >actual &&
      	cat >expected <<-EOF &&
    @@ t/t4060-diff-submodule-option-diff-format.sh: test_expect_success 'modified subm
      
      test_expect_success 'typechanged submodule(submodule->blob), --cached' '
      	git diff --submodule=diff --cached >actual &&
    +@@ t/t4060-diff-submodule-option-diff-format.sh: test_expect_success 'typechanged submodule(submodule->blob), --cached' '
    + '
    + 
    + test_expect_success 'typechanged submodule(submodule->blob)' '
    ++	test_when_finished rm -rf sm1 &&
    + 	git diff --submodule=diff >actual &&
    + 	cat >expected <<-EOF &&
    + 	diff --git a/sm1 b/sm1
     @@ t/t4060-diff-submodule-option-diff-format.sh: test_expect_success 'typechanged submodule(submodule->blob)' '
      	diff_cmp expected actual
      '
    @@ t/t4060-diff-submodule-option-diff-format.sh: test_expect_success 'typechanged s
     -rm -rf sm1 &&
     -git checkout-index sm1
      test_expect_success 'typechanged submodule(submodule->blob)' '
    -+	rm -rf sm1 &&
    ++	test_when_finished rm -f sm1 &&
     +	git checkout-index sm1 &&
      	git diff-index -p --submodule=diff HEAD >actual &&
      	cat >expected <<-EOF &&
    @@ t/t4060-diff-submodule-option-diff-format.sh: test_expect_success 'typechanged s
     -test_create_repo sm1 &&
     -head6=$(add_file sm1 foo6 foo7)
      test_expect_success 'nonexistent commit' '
    -+	rm -f sm1 &&
     +	test_create_repo sm1 &&
     +	head6=$(add_file sm1 foo6 foo7) &&
      	git diff-index -p --submodule=diff HEAD >actual &&
    @@ t/t4060-diff-submodule-option-diff-format.sh: test_expect_success 'typechanged s
      	head7=$(git -C sm1 rev-parse --short --verify HEAD) &&
      	git diff-index -p --submodule=diff HEAD >actual &&
      	test_must_be_empty actual
    +@@ t/t4060-diff-submodule-option-diff-format.sh: test_expect_success 'submodule contains untracked and modified content (dirty ig
    + '
    + 
    + test_expect_success 'submodule contains untracked and modified content (all ignored)' '
    ++	test_when_finished rm -f sm1/new-file &&
    + 	echo new > sm1/foo6 &&
    + 	git diff-index -p --ignore-submodules --submodule=diff HEAD >actual &&
    + 	test_must_be_empty actual
    + '
    + 
    + test_expect_success 'submodule contains modified content' '
    +-	rm -f sm1/new-file &&
    + 	git diff-index -p --submodule=diff HEAD >actual &&
    + 	cat >expected <<-EOF &&
    + 	Submodule sm1 contains modified content
     @@ t/t4060-diff-submodule-option-diff-format.sh: test_expect_success 'submodule contains modified content' '
      	diff_cmp expected actual
      '
    @@ t/t4060-diff-submodule-option-diff-format.sh: test_expect_success 'submodule con
     -(cd sm1; git commit -mchange foo6 >/dev/null) &&
     -head8=$(cd sm1; git rev-parse --short --verify HEAD) &&
      test_expect_success 'submodule is modified' '
    -+	(cd sm1 && git commit -mchange foo6 >/dev/null) &&
    -+	head8=$(cd sm1 && git rev-parse --short --verify HEAD) &&
    ++	(git -C sm1 commit -mchange foo6 >/dev/null) &&
    ++	head8=$(git -C sm1 rev-parse --short --verify HEAD) &&
      	git diff-index -p --submodule=diff HEAD >actual &&
      	cat >expected <<-EOF &&
      	Submodule sm1 $head7..$head8:
    +@@ t/t4060-diff-submodule-option-diff-format.sh: test_expect_success 'modified submodule contains untracked and modified content
    + '
    + 
    + test_expect_success 'modified submodule contains untracked and modified content (all ignored)' '
    ++	test_when_finished rm -f sm1/new-file &&
    + 	echo modification >> sm1/foo6 &&
    + 	git diff-index -p --ignore-submodules --submodule=diff HEAD >actual &&
    + 	test_must_be_empty actual
    +@@ t/t4060-diff-submodule-option-diff-format.sh: test_expect_success 'modified submodule contains untracked and modified content
    + 
    + # NOT OK
    + test_expect_success 'modified submodule contains modified content' '
    +-	rm -f sm1/new-file &&
    ++	test_when_finished rm -rf sm1 &&
    + 	git diff-index -p --submodule=diff HEAD >actual &&
    + 	cat >expected <<-EOF &&
    + 	Submodule sm1 contains modified content
     @@ t/t4060-diff-submodule-option-diff-format.sh: test_expect_success 'modified submodule contains modified content' '
      	diff_cmp expected actual
      '
      
     -rm -rf sm1
      test_expect_success 'deleted submodule' '
    -+	rm -rf sm1 &&
      	git diff-index -p --submodule=diff HEAD >actual &&
      	cat >expected <<-EOF &&
    - 	Submodule sm1 $head7...0000000 (submodule deleted)
     @@ t/t4060-diff-submodule-option-diff-format.sh: test_expect_success 'path filter' '
      	diff_cmp expected actual
      '
    @@ t/t4060-diff-submodule-option-diff-format.sh: test_expect_success 'deleted submo
     -echo submodule-to-blob>sm2
     -
      test_expect_success 'typechanged(submodule->blob) submodule with .git file' '
    ++	test_when_finished "rm sm2 && mv sm2-bak sm2" &&
     +	echo submodule-to-blob>sm2 &&
      	git diff-index -p --submodule=diff HEAD >actual &&
      	cat >expected <<-EOF &&
    @@ t/t4060-diff-submodule-option-diff-format.sh: test_expect_success 'typechanged(s
     -mv sm2-bak sm2
     -
      test_expect_success 'setup nested submodule' '
    -+	rm sm2 &&
    -+	mv sm2-bak sm2 &&
      	git -c protocol.file.allow=always -C sm2 submodule add ../sm2 nested &&
      	git -C sm2 commit -a -m "nested sub" &&
    - 	head10=$(git -C sm2 rev-parse --short --verify HEAD)
     @@ t/t4060-diff-submodule-option-diff-format.sh: test_expect_success 'diff --submodule=diff recurses into nested submodules' '
      	diff_cmp expected actual
      '
    @@ t/t4060-diff-submodule-option-diff-format.sh: test_expect_success 'diff --submod
      test_expect_success 'diff --submodule=diff recurses into deleted nested submodules' '
     +	(cd sm2 && commit_file nested) &&
     +	commit_file sm2 &&
    -+	head12=$(cd sm2 && git rev-parse --short --verify HEAD) &&
    ++	head12=$(git -C sm2 rev-parse --short --verify HEAD) &&
     +	mv sm2 sm2-bak &&
      	cat >expected <<-EOF &&
      	Submodule sm1 $head7...0000000 (submodule deleted)
3:  e1c7c2f63e ! 2:  a438f4072d tests: Use `git submodule add` instead of `git add`
    @@ Commit message
         Signed-off-by: Josh Steadmon <steadmon@google.com>
         Signed-off-by: Calvin Wan <calvinwan@google.com>
     
    - ## t/t0008-ignores.sh ##
    -@@ t/t0008-ignores.sh: test_expect_success 'setup' '
    - 		git add a &&
    - 		git commit -m"commit in submodule"
    - 	) &&
    --	git add a/submodule &&
    -+	git submodule add ./a/submodule ./a/submodule &&
    - 	cat <<-\EOF >.gitignore &&
    - 		one
    - 		ignored-*
    -
      ## t/t2013-checkout-submodule.sh ##
     @@ t/t2013-checkout-submodule.sh: test_expect_success 'setup' '
      	(cd submodule &&
    @@ t/t2103-update-index-ignore-missing.sh: test_expect_success basics '
      		git commit -m "sub initial"
      	) &&
     -	git add xyzzy &&
    -+	git submodule add ./xyzzy &&
    ++	git add ./xyzzy &&
      
      	test_tick &&
      	git commit -m initial &&
    @@ t/t4020-diff-external.sh: test_expect_success 'clean up crlf leftovers' '
      	git commit -m "add submodule" &&
      	( cd sub && test_commit sub2 ) &&
     
    - ## t/t4035-diff-quiet.sh ##
    -@@ t/t4035-diff-quiet.sh: test_expect_success 'git diff-index --cached HEAD^' '
    - test_expect_success 'git diff-index --cached HEAD^' '
    - 	echo text >>b &&
    - 	echo 3 >c &&
    -+	git submodule add ./test-outside/repo ./test-outside/repo &&
    - 	git add . &&
    - 	test_expect_code 1 git diff-index --quiet --cached HEAD^ >cnt &&
    - 	test_line_count = 0 cnt
    -
      ## t/t5531-deep-submodule-push.sh ##
     @@ t/t5531-deep-submodule-push.sh: test_expect_success setup '
      			git add junk &&
    @@ t/t6416-recursive-corner-cases.sh: test_expect_success 'setup conflicting entry
      
      		git checkout -b C A &&
     
    - ## t/t6430-merge-recursive.sh ##
    -@@ t/t6430-merge-recursive.sh: test_expect_success 'merging with triple rename across D/F conflict' '
    - 	echo content3 >sub2/file3 &&
    - 	mkdir simple &&
    - 	echo base >simple/bar &&
    -+	git -c protocol.file.allow=always submodule add ./sym &&
    - 	git add -A &&
    - 	test_tick &&
    - 	git commit -m base &&
    -
      ## t/t6437-submodule-merge.sh ##
     @@ t/t6437-submodule-merge.sh: test_expect_success setup '
      	 git add file &&
4:  a7630f5a4e ! 3:  336e095b38 tests: use `git submodule add` and fix expected diffs
    @@ t/t4041-diff-submodule-option.sh: test_expect_success 'typechanged submodule(sub
      	diff --git a/sm1 b/sm1
      	new file mode 100644
     @@ t/t4041-diff-submodule-option.sh: test_expect_success 'nonexistent commit' '
    - 	fullhead6=$(cd sm1 && git rev-parse --verify HEAD) &&
    + 	fullhead6=$(git -C sm1 rev-parse --verify HEAD) &&
      	git diff-index -p --submodule=log HEAD >actual &&
      	cat >expected <<-EOF &&
     +	diff --git a/.gitmodules b/.gitmodules
    @@ t/t4041-diff-submodule-option.sh: test_expect_success 'given commit' '
      	Submodule sm2 0000000...$head7 (new submodule)
      	EOF
     @@ t/t4041-diff-submodule-option.sh: test_expect_success 'given commit --submodule=short' '
    - 	fullhead7=$(cd sm2 && git rev-parse --verify HEAD) &&
    + 	fullhead7=$(git -C sm2 rev-parse --verify HEAD) &&
      	git diff-index -p --submodule=short HEAD^ >actual &&
      	cat >expected <<-EOF &&
     +	diff --git a/.gitmodules b/.gitmodules
5:  7182e1fb2f = 4:  40a4647ae3 tests: use `git submodule add` and fix expected status
-:  ---------- > 5:  caa2f228a0 tests: remove duplicate .gitmodules path
6:  6d2ef61fb4 ! 6:  28cb291edd add: reject nested repositories
    @@ Commit message
     
         Due to this experience, we believe that Git's default behavior should be
         changed to disallow adding embedded repositories. This commit changes
    -    the existing warning into a fatal error while preserving the
    -    `--no-warn-embedded-repo` flag as a way to bypass this check.
    +    the existing warning into a fatal error, rewrites the advice given, and
    +    deprecates `--no-warn-embedded-repo` in favor of `--allow-embedded-repo`
    +    to bypass the fatal error.
     
         Signed-off-by: Josh Steadmon <steadmon@google.com>
         Signed-off-by: Calvin Wan <calvinwan@google.com>
     
      ## Documentation/git-add.txt ##
     @@ Documentation/git-add.txt: for "git add --no-all <pathspec>...", i.e. ignored removed files.
    + 	be ignored, no matter if they are already present in the work
      	tree or not.
      
    - --no-warn-embedded-repo::
    +---no-warn-embedded-repo::
     -	By default, `git add` will warn when adding an embedded
    ++--allow-embedded-repo::
     +	By default, `git add` will error out when adding an embedded
      	repository to the index without using `git submodule add` to
     -	create an entry in `.gitmodules`. This option will suppress the
     -	warning (e.g., if you are manually performing operations on
    +-	submodules).
     +	create an entry in `.gitmodules`. This option will allow the
    -+	embedded repository to be added and suppress the error.
    -+	(e.g., if you are manually performing operations on
    - 	submodules).
    ++	embedded repository to be added. (e.g., if you are manually
    ++	performing operations on submodules).
    ++
    ++--no-warn-embedded-repo::
    ++	This option is deprecated in favor of '--add-embedded-repo'.
    ++	Passing this option still suppresses advice but does not bypass
    ++	the error.
      
      --renormalize::
    + 	Apply the "clean" process freshly to all tracked files to
     
      ## builtin/add.c ##
    -@@ builtin/add.c: static const char embedded_advice[] = N_(
    +@@ builtin/add.c: N_("The following paths are ignored by one of your .gitignore files:\n");
    + static int verbose, show_only, ignored_too, refresh_only;
    + static int ignore_add_errors, intent_to_add, ignore_missing;
    + static int warn_on_embedded_repo = 1;
    ++static int allow_embedded_repo = 0;
    + 
    + #define ADDREMOVE_DEFAULT 1
    + static int addremove = ADDREMOVE_DEFAULT;
    +@@ builtin/add.c: static struct option builtin_add_options[] = {
    + 		   N_("override the executable bit of the listed files")),
    + 	OPT_HIDDEN_BOOL(0, "warn-embedded-repo", &warn_on_embedded_repo,
    + 			N_("warn when adding an embedded repository")),
    ++	OPT_HIDDEN_BOOL(0, "allow-embedded-repo", &allow_embedded_repo,
    ++			N_("allow adding an embedded repository")),
    + 	OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
    + 	OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
    + 	OPT_END(),
    +@@ builtin/add.c: static int add_config(const char *var, const char *value, void *cb)
    + }
    + 
    + static const char embedded_advice[] = N_(
    +-"You've added another git repository inside your current repository.\n"
    ++"You attempted to add another git repository inside your current repository.\n"
    + "Clones of the outer repository will not contain the contents of\n"
    + "the embedded repository and will not know how to obtain it.\n"
    + "If you meant to add a submodule, use:\n"
      "\n"
    - "	git rm --cached %s\n"
    + "	git submodule add <url> %s\n"
      "\n"
    --"See \"git help submodule\" for more information."
    +-"If you added this path by mistake, you can remove it from the\n"
    +-"index with:\n"
     +"See \"git help submodule\" for more information.\n"
    -+"\n"
    + "\n"
    +-"	git rm --cached %s\n"
     +"If you cannot use submodules, you may bypass this check with:\n"
    -+"\n"
    -+"	git add --no-warn-embedded-repo %s\n"
    + "\n"
    +-"See \"git help submodule\" for more information."
    ++"	git add --allow-embedded-repo %s\n"
      );
      
     -static void check_embedded_repo(const char *path)
    @@ builtin/add.c: static const char embedded_advice[] = N_(
      	struct strbuf name = STRBUF_INIT;
      	static int adviced_on_embedded_repo = 0;
      
    - 	if (!warn_on_embedded_repo)
    +-	if (!warn_on_embedded_repo)
     -		return;
    ++	if (allow_embedded_repo)
     +		goto cleanup;
      	if (!ends_with(path, "/"))
     -		return;
    @@ builtin/add.c: static const char embedded_advice[] = N_(
     -	warning(_("adding embedded git repository: %s"), name.buf);
     +	error(_("cannot add embedded git repository: %s"), name.buf);
      	if (!adviced_on_embedded_repo &&
    - 	    advice_enabled(ADVICE_ADD_EMBEDDED_REPO)) {
    --		advise(embedded_advice, name.buf, name.buf);
    -+		advise(embedded_advice, name.buf, name.buf, name.buf);
    +-	    advice_enabled(ADVICE_ADD_EMBEDDED_REPO)) {
    ++		warn_on_embedded_repo &&
    ++		advice_enabled(ADVICE_ADD_EMBEDDED_REPO)) {
    + 		advise(embedded_advice, name.buf, name.buf);
      		adviced_on_embedded_repo = 1;
      	}
      
    @@ builtin/add.c: static int add_files(struct dir_struct *dir, int flags)
      		advise_on_updating_sparse_paths(&matched_sparse_paths);
      		exit_status = 1;
     
    + ## builtin/submodule--helper.c ##
    +@@ builtin/submodule--helper.c: static void configure_added_submodule(struct add_data *add_data)
    + 
    + 	add_submod.git_cmd = 1;
    + 	strvec_pushl(&add_submod.args, "add",
    +-		     "--no-warn-embedded-repo", NULL);
    ++		     "--allow-embedded-repo", NULL);
    + 	if (add_data->force)
    + 		strvec_push(&add_submod.args, "--force");
    + 	strvec_pushl(&add_submod.args, "--", add_data->sm_path, NULL);
    +@@ builtin/submodule--helper.c: static int module_add(int argc, const char **argv, const char *prefix)
    + 		cp.git_cmd = 1;
    + 		cp.no_stdout = 1;
    + 		strvec_pushl(&cp.args, "add", "--dry-run", "--ignore-missing",
    +-			     "--no-warn-embedded-repo", add_data.sm_path, NULL);
    ++			     "--allow-embedded-repo", add_data.sm_path, NULL);
    + 		if ((ret = pipe_command(&cp, NULL, 0, NULL, 0, &sb, 0))) {
    + 			strbuf_complete_line(&sb);
    + 			fputs(sb.buf, stderr);
    +
    + ## t/t0008-ignores.sh ##
    +@@ t/t0008-ignores.sh: test_expect_success 'setup' '
    + 		git add a &&
    + 		git commit -m"commit in submodule"
    + 	) &&
    +-	git add a/submodule &&
    ++	git add --allow-embedded-repo a/submodule &&
    + 	cat <<-\EOF >.gitignore &&
    + 		one
    + 		ignored-*
    +
    + ## t/t2103-update-index-ignore-missing.sh ##
    +@@ t/t2103-update-index-ignore-missing.sh: test_expect_success basics '
    + 		git add file &&
    + 		git commit -m "sub initial"
    + 	) &&
    +-	git add ./xyzzy &&
    ++	git add --allow-embedded-repo ./xyzzy &&
    + 
    + 	test_tick &&
    + 	git commit -m initial &&
    +
    + ## t/t4035-diff-quiet.sh ##
    +@@ t/t4035-diff-quiet.sh: test_expect_success 'git diff-index --cached HEAD^' '
    + test_expect_success 'git diff-index --cached HEAD^' '
    + 	echo text >>b &&
    + 	echo 3 >c &&
    +-	git add . &&
    ++	git add --allow-embedded-repo . &&
    + 	test_expect_code 1 git diff-index --quiet --cached HEAD^ >cnt &&
    + 	test_line_count = 0 cnt
    + '
    +
    + ## t/t6430-merge-recursive.sh ##
    +@@ t/t6430-merge-recursive.sh: test_expect_success 'merging with triple rename across D/F conflict' '
    + 	echo content3 >sub2/file3 &&
    + 	mkdir simple &&
    + 	echo base >simple/bar &&
    +-	git add -A &&
    ++	git add -A --allow-embedded-repo &&
    + 	test_tick &&
    + 	git commit -m base &&
    + 
    +
      ## t/t7400-submodule-basic.sh ##
     @@ t/t7400-submodule-basic.sh: test_expect_success 'setup - repository in init subdirectory' '
      test_expect_success 'setup - commit with gitlink' '
      	echo a >a &&
      	echo z >z &&
     -	git add a init z &&
    -+	git add --no-warn-embedded-repo a init z &&
    ++	git add --allow-embedded-repo a init z &&
      	git commit -m "super commit 1"
      '
      
    @@ t/t7400-submodule-basic.sh: test_expect_success 'set up for relative path tests'
      			test_commit foo
      		) &&
     -		git add sub &&
    -+		git add --no-warn-embedded-repo sub &&
    ++		git add --allow-embedded-repo sub &&
      		git config -f .gitmodules submodule.sub.path sub &&
      		git config -f .gitmodules submodule.sub.url ../subrepo &&
      		cp .git/config pristine-.git-config &&
    @@ t/t7412-submodule-absorbgitdirs.sh: test_expect_success 'absorb the git dir in a
      	git init sub2 &&
      	test_commit -C sub2 first &&
     -	git add sub2 &&
    -+	git add --no-warn-embedded-repo sub2 &&
    ++	git add --allow-embedded-repo sub2 &&
      	git commit -m superproject
      '
      
    @@ t/t7414-submodule-mistakes.sh: test_expect_success 'create embedded repository'
      '
      
     -test_expect_success '--no-warn-embedded-repo suppresses warning' '
    -+test_expect_success '--no-warn-embedded-repo suppresses error message' '
    ++test_expect_success '--allow-embedded-repo adds embedded repository and suppresses error message' '
      	test_when_finished "git rm --cached -f embed" &&
    - 	git add --no-warn-embedded-repo embed 2>stderr &&
    +-	git add --no-warn-embedded-repo embed 2>stderr &&
     -	test_i18ngrep ! warning stderr
    ++	git add --allow-embedded-repo embed 2>stderr &&
     +	test_i18ngrep ! fatal stderr
    ++'
    ++
    ++test_expect_success '--no-warn-embedded-repo dies and suppresses advice' '
    ++	test_must_fail git add --no-warn-embedded-repo embed 2>stderr &&
    ++	test_i18ngrep ! hint stderr &&
    ++	test_i18ngrep fatal stderr
      '
      
     -test_expect_success 'no warning when updating entry' '
     +test_expect_success 'no error message when updating entry' '
      	test_when_finished "git rm --cached -f embed" &&
     -	git add embed &&
    -+	git add --no-warn-embedded-repo embed &&
    ++	git add --allow-embedded-repo embed &&
      	git -C embed commit --allow-empty -m two &&
      	git add embed 2>stderr &&
     -	test_i18ngrep ! warning stderr
    @@ t/t7414-submodule-mistakes.sh: test_expect_success 'create embedded repository'
      '
      
     -test_expect_success 'submodule add does not warn' '
    -+test_expect_success 'submodule add does not issue error message' '
    ++test_expect_success 'submodule add neither fails nor issues error message' '
      	test_when_finished "git rm -rf submodule .gitmodules" &&
      	git -c protocol.file.allow=always \
      		submodule add ./embed submodule 2>stderr &&
    @@ t/t7450-bad-git-dotfiles.sh: test_expect_success 'git dirs of sibling submodules
      		git clone . thing1 &&
      		git clone . thing2 &&
     -		git add .gitmodules thing1 thing2 &&
    -+		git add --no-warn-embedded-repo .gitmodules thing1 thing2 &&
    ++		git add --allow-embedded-repo .gitmodules thing1 thing2 &&
      		test_tick &&
      		git commit -m nested
      	) &&
-- 
2.39.2.722.g9855ee24e9-goog

