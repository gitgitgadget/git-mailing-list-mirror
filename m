Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A078C4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 17:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiKCRH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 13:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbiKCRG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 13:06:58 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809771D0CB
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 10:06:22 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id a13so4114260edj.0
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 10:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbCKGfcmkuV7v/AkYV8iPf+qXBNsASCkA7PorE1ecrg=;
        b=T3VR20EjTHf4tQjRbjTIgj/qup9Q9rssz5vSUxpfM8pdSy6jjfTmdDwG/EnAZ7/mA9
         YOuSdiP3EQApcCHAwJj89gmuK5OvxaG9pFOcP9y+Si8rwbU6fPouc4iZdVkidZ1d8Xby
         gK7Erelc373cjLTmfwF7xgGfIVkOlGyGXkyAgW6CyLDt/7X3V+mVTjGExaSWt9GOnc4o
         fwUzwVh1Xu6vc0n4fI4Yz0kunMZGfs7X+BV/6DXWGqN/6cB6HYmtLUj5SlULSt5n9gr5
         Apyrb2xdruwhDSAYqGoFpwSnDHYRt5giNHZltDrysfBVnYSudRbM3uHNzrVxWvNdF9Ur
         4dJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbCKGfcmkuV7v/AkYV8iPf+qXBNsASCkA7PorE1ecrg=;
        b=dBpMD7fYDb1XvLPKlR37HkdZAclVnz0esQg6j6bzMv4jsLluao7HW0qNUUBkuzDX5L
         T4CX7vDlpKGocYkNqwA2GHn8qr7qsaX2hs4xTABLO6iDiHxjkpbh9pg6pm/FZ7iQYysR
         Lob4FQZtnrwtxLOSPCy60U3G/TBk/V3VtbvqitcC6x3+XQgwxbP/QZ88yPrgJWkh5eGd
         yT+jKQu7KvBsr4K6uD0OUVqhlIWAfUS+ITozcc2fYrzpHaZwIP6NLh+W82TzjK6pkmSR
         iiaAdscJW2u33WqoWR2QeRwY14fcZfvk0yHfsF9Sj5ILhIxnfd+2gr8Ia7zYTzyXpHa1
         WPYA==
X-Gm-Message-State: ACrzQf01/HRdtQczl42msbw6qdcFNN8W8sk3gG72mJUomPmFPnaHPPBe
        4lZc07iG2xNOMAvqKR0jZpf4Z+qvWu83TQ==
X-Google-Smtp-Source: AMsMyM7MZP/P7Sy8y7KrdIvrf4eCBp/rR52b4U/QZo83Hj0HR4U+DUrvKbk9azT7nwFWqyQ8jjV88w==
X-Received: by 2002:a05:6402:174f:b0:463:12ed:3f8f with SMTP id v15-20020a056402174f00b0046312ed3f8fmr29181867edx.67.1667495180666;
        Thu, 03 Nov 2022 10:06:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4-20020aa7d644000000b0044e01e2533asm741882edr.43.2022.11.03.10.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:06:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/17] tests: mark tests as passing with SANITIZE=leak
Date:   Thu,  3 Nov 2022 18:06:00 +0100
Message-Id: <patch-01.17-7fe724599a7-20221103T164632Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This marks tests that have been leak-free since various recent
commits, but which were not marked us such when the memory leak was
fixed. These were mostly discovered with the "check" mode added in
faececa53f9 (test-lib: have the "check" mode for SANITIZE=leak
consider leak logs, 2022-07-28).

Commits that fixed the last memory leak in these tests. Per narrowing
down when they started to pass under SANITIZE=leak with "bisect":

- t1022-read-tree-partial-clone.sh:
  7e2619d8ff0 (list_objects_filter_options: plug leak of filter_spec
  strings, 2022-09-08)

- t4053-diff-no-index.sh: 07a6f94a6d0 (diff-no-index: release prefixed
  filenames, 2022-09-07)

- t6415-merge-dir-to-symlink.sh: bac92b1f39f (Merge branch
  'js/ort-clean-up-after-failed-merge', 2022-08-08).

- t5554-noop-fetch-negotiator.sh:
  66eede4a37c (prepare_repo_settings(): plug leak of config values,
  2022-09-08)

Let's mark all of these as passing with
"TEST_PASSES_SANITIZE_LEAK=true", to have it regression tested,
including as part of the "linux-leaks" CI job.

Additionally, let's remove the "!SANITIZE_LEAK" prerequisite from
tests that now pass, these were marked as failing in:

- 77e56d55ba6 (diff.c: fix a double-free regression in a18d66cefb,
  2022-03-17)
- c4d1d526312 (tests: change some 'test $(git) = "x"' to test_cmp,
  2022-03-07)

These were not spotted with the new "check" mode, but manually, it
doesn't cover these sort of prerequisites. There's few enough that we
shouldn't bother to automate it. They'll be going away sooner than
later.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1022-read-tree-partial-clone.sh | 2 +-
 t/t4015-diff-whitespace.sh         | 4 ++--
 t/t4053-diff-no-index.sh           | 1 +
 t/t5554-noop-fetch-negotiator.sh   | 2 ++
 t/t6415-merge-dir-to-symlink.sh    | 1 +
 t/t7103-reset-bare.sh              | 2 +-
 6 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t1022-read-tree-partial-clone.sh b/t/t1022-read-tree-partial-clone.sh
index a9953b6a71c..d08563de5c9 100755
--- a/t/t1022-read-tree-partial-clone.sh
+++ b/t/t1022-read-tree-partial-clone.sh
@@ -3,7 +3,7 @@
 test_description='git read-tree in partial clones'
 
 TEST_NO_CREATE_REPO=1
-
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'read-tree in partial clone prefetches in one batch' '
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index f3e20dd5bba..b298f220e01 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1638,7 +1638,7 @@ test_expect_success 'no effect on diff from --color-moved with --word-diff' '
 	test_cmp expect actual
 '
 
-test_expect_success !SANITIZE_LEAK 'no effect on show from --color-moved with --word-diff' '
+test_expect_success 'no effect on show from --color-moved with --word-diff' '
 	git show --color-moved --word-diff >actual &&
 	git show --word-diff >expect &&
 	test_cmp expect actual
@@ -2024,7 +2024,7 @@ test_expect_success '--color-moved rewinds for MIN_ALNUM_COUNT' '
 	test_cmp expected actual
 '
 
-test_expect_success !SANITIZE_LEAK 'move detection with submodules' '
+test_expect_success 'move detection with submodules' '
 	test_create_repo bananas &&
 	echo ripe >bananas/recipe &&
 	git -C bananas add recipe &&
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 3feadf0e359..4e9fa0403d3 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -2,6 +2,7 @@
 
 test_description='diff --no-index'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5554-noop-fetch-negotiator.sh b/t/t5554-noop-fetch-negotiator.sh
index 2ac7b5859e7..06991e8e8aa 100755
--- a/t/t5554-noop-fetch-negotiator.sh
+++ b/t/t5554-noop-fetch-negotiator.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test noop fetch negotiator'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'noop negotiator does not emit any "have"' '
diff --git a/t/t6415-merge-dir-to-symlink.sh b/t/t6415-merge-dir-to-symlink.sh
index 2655e295f5a..ae00492c768 100755
--- a/t/t6415-merge-dir-to-symlink.sh
+++ b/t/t6415-merge-dir-to-symlink.sh
@@ -4,6 +4,7 @@ test_description='merging when a directory was replaced with a symlink'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create a commit where dir a/b changed to symlink' '
diff --git a/t/t7103-reset-bare.sh b/t/t7103-reset-bare.sh
index a60153f9f32..18bbd9975eb 100755
--- a/t/t7103-reset-bare.sh
+++ b/t/t7103-reset-bare.sh
@@ -63,7 +63,7 @@ test_expect_success '"mixed" reset is not allowed in bare' '
 	test_must_fail git reset --mixed HEAD^
 '
 
-test_expect_success !SANITIZE_LEAK '"soft" reset is allowed in bare' '
+test_expect_success '"soft" reset is allowed in bare' '
 	git reset --soft HEAD^ &&
 	git show --pretty=format:%s >out &&
 	echo one >expect &&
-- 
2.38.0.1451.g86b35f4140a

