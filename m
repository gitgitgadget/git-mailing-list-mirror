Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EA9C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 11:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242963AbiFCLPg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 07:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239623AbiFCLPd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 07:15:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861213C481
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 04:15:30 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t6so9993380wra.4
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 04:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kEnKywnDIJ7ApzGg1cjDYveMA4D18lcrxtBr/PkDv5k=;
        b=HqQJwIn1Y0DJR8yK2enhDxIazyHsPQ7GpKgn73m2PoVRM2AT3uxAE32qfkocMh6A77
         mfTiRFytWoMuRg2GLsfhPdBYHX2bNtnQwPF6d3vy6RWkV4SmPM9qIiN7sspm0bhwC/DD
         brvbOo67lCFbW/kWlJKbxOxhXUqpQF4mdf7zwyXHmCvUz8fTAD/m4NVN5dXwA2uwcDJZ
         BAneK+GuGBPXsBP13VrLoCeRK+JwsOTCq+6HRdBqCqEOoGqHcM+qiUf2s1hrFwld2fJW
         1w1oBWnRjmez12AB3mkIDg5/4Oh1cZ21/KvrAWu7i3p7xLrma4Fa7q4ENGA1xexW/Glm
         KGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kEnKywnDIJ7ApzGg1cjDYveMA4D18lcrxtBr/PkDv5k=;
        b=PCiNiW1qO4p6z5ADTqO2soNDMOcyT8uRflZAjpcPycm44d2cl7CU2pOQt+kiHhu1vm
         qkQZ3RagzKZcar4rVNLAG3WKvwn8CBOg7VogrtH4h67tuu4agnzQQhozovXIFMVkcXhz
         UjeIIPM96C1ajh6jxZ+s1k7UmD5Kjf4w9Lrcwgxbtqp3m8wMdm8uMkuR0r0Fwp8nLL++
         NHGh7hiXFmyQFIDdxtzd4uJ4i8mDuYqtIxhiwU3o1kAuLrGvri3OLkSe5bF4LnGCf+qB
         yZCr6N7FQ0VZXLSrSIW21K1omteplA0sPu1kXQrwSf3mWS/uFBW2Wy9Y3hUu2UAoQp70
         M0MA==
X-Gm-Message-State: AOAM53278FVSlkCGHVI2jPxBVDQmFI1Kv3ugxxZ1DyBZXpWci0W2hYRR
        1O+5tq5D9/hhK2MYuNpMgDZ0fmDrzdzRHw==
X-Google-Smtp-Source: ABdhPJzn7RFRTId5/cyvDoBXuHJJgi5P10RMFw3xZKvsoScZnxU5za0PW/a7KksaEj5kMOM+hNnGAA==
X-Received: by 2002:a5d:6d0c:0:b0:20f:e6c5:a01e with SMTP id e12-20020a5d6d0c000000b0020fe6c5a01emr7646671wrq.378.1654254928749;
        Fri, 03 Jun 2022 04:15:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h24-20020adfa4d8000000b0020d0a57af5esm7184357wrb.79.2022.06.03.04.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 04:15:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/7] tests: don't depend on "git init" using the template
Date:   Fri,  3 Jun 2022 13:15:02 +0200
Message-Id: <cover-v2-0.7-00000000000-20220603T110506Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1119.g5a713b43bd4
In-Reply-To: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reduced-in-scope re-roll of [1] changes those tests that
implicitly relied on the existence of the default "git init" template
to no longer do so. This makes the intent of the tests more explicit,
e.g. in the case of the .git/branch directory.

Parts of the v1 were already split up, re-rolled and merged as
a5bf611cc4f (Merge branch 'ab/hook-tests-updates', 2022-03-30).

Future goals: I then have a local topic on top of this to add the
"--no-template" option to "git init", and to have the test suite run
in that mode by default, that's currently one of the blockers for
making the test run without the bin-wrappers[2], which as noted in [3]
leaves us with some blind spots in our tests.

But for now this is all relatively straightforward conversion of
existing tests to make them not rely on "git init" giving them a
template, which they opt-in to with a new TEST_CREATE_REPO_NO_TEMPLATE
variable.

Junio: There's a trivial conflict in one of the tests with "next",
i.e.:

	diff --cc t/t6101-rev-parse-parents.sh
	index 5f55ab98d35,a3a41c7a3e4..00000000000
	--- a/t/t6101-rev-parse-parents.sh
	+++ b/t/t6101-rev-parse-parents.sh
	@@@ -8,7 -8,7 +8,11 @@@ test_description='Test git rev-parse wi
	  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
	  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME

	++<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< HEAD
	 +TEST_CREATE_REPO_NO_TEMPLATE=1
	++================================
	+ TEST_PASSES_SANITIZE_LEAK=true
	++>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> origin/seen

The resolution is to keep both sides, i.e. to end up with:

	TEST_CREATE_REPO_NO_TEMPLATE=1
	TEST_PASSES_SANITIZE_LEAK=true

1. https://lore.kernel.org/git/cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com/
2. https://lore.kernel.org/git/220405.86k0c3lt2l.gmgdl@evledraar.gmail.com/
3. https://lore.kernel.org/git/211124.86sfvld4cl.gmgdl@evledraar.gmail.com/

Ævar Arnfjörð Bjarmason (7):
  t0008: don't rely on default ".git/info/exclude"
  tests: don't depend on template-created .git/branches
  tests: don't assume a .git/info for .git/info/grafts
  tests: don't assume a .git/info for .git/info/attributes
  tests: don't assume a .git/info for .git/info/refs
  tests: don't assume a .git/info for .git/info/exclude
  tests: don't assume a .git/info for .git/info/sparse-checkout

 t/annotate-tests.sh                    |  3 ++-
 t/lib-submodule-update.sh              |  7 +++++--
 t/t0003-attributes.sh                  |  5 ++++-
 t/t0008-ignores.sh                     | 12 +++++++-----
 t/t0028-working-tree-encoding.sh       |  2 ++
 t/t1011-read-tree-sparse-checkout.sh   |  2 ++
 t/t1090-sparse-checkout-scope.sh       |  5 ++++-
 t/t1301-shared-repo.sh                 |  3 ++-
 t/t2018-checkout-branch.sh             |  4 +++-
 t/t2400-worktree-add.sh                |  4 ++++
 t/t3426-rebase-submodule.sh            |  1 +
 t/t3507-cherry-pick-conflict.sh        |  2 ++
 t/t5000-tar-tree.sh                    |  5 ++++-
 t/t5001-archive-attr.sh                |  5 ++++-
 t/t5002-archive-attr-pattern.sh        |  5 ++++-
 t/t5003-archive-zip.sh                 |  5 ++++-
 t/t5318-commit-graph.sh                |  3 ++-
 t/t5505-remote.sh                      |  6 ++++--
 t/t5516-fetch-push.sh                  | 16 ++++++++++++++--
 t/t5550-http-fetch-dumb.sh             |  3 ++-
 t/t6001-rev-list-graft.sh              |  1 +
 t/t6101-rev-parse-parents.sh           |  2 ++
 t/t6435-merge-sparse.sh                |  2 ++
 t/t7063-status-untracked-cache.sh      |  3 ++-
 t/t7418-submodule-sparse-gitmodules.sh |  3 ++-
 t/t7814-grep-recurse-submodules.sh     |  8 ++++++--
 t/t8001-annotate.sh                    |  1 +
 t/t8002-blame.sh                       |  1 +
 t/t8012-blame-colors.sh                |  1 +
 t/test-lib.sh                          |  4 +++-
 30 files changed, 97 insertions(+), 27 deletions(-)

Range-diff against v1:
 1:  5526d3dc838 <  -:  ----------- t0001: fix gaps in "TEMPLATE DIRECTORY" coverage
 2:  ef2b67768cf <  -:  ----------- init: split out template population from create_default_files()
 3:  784b7947512 <  -:  ----------- init: unconditionally create the "info" directory
 4:  3d4ea5c5d30 =  1:  21927e21832 t0008: don't rely on default ".git/info/exclude"
 5:  6bbb39f13fc <  -:  ----------- init & clone: add a --no-template option
 6:  2f478f7ba4a <  -:  ----------- init & clone: add init.templateDir=[bool]
 7:  9402fb23b40 <  -:  ----------- test-lib: create test data with "git init --no-template" (almost)
 8:  0c9b953dd43 <  -:  ----------- tests: don't depend on template-created .git/branches
 9:  d97122f5fd8 <  -:  ----------- t5540: don't rely on "hook/post-update.sample"
10:  ca55471d134 <  -:  ----------- test-lib-functions: add and use a "write_hook" wrapper
11:  6f805f7ebac <  -:  ----------- tests: change "cat && chmod +x" to use "write_hook"
12:  2acbaa77f8d <  -:  ----------- tests: migrate miscellaneous "write_script" to "write_hooks"
13:  d021a5981a1 <  -:  ----------- tests: don't depend on template-created .git/hooks
 -:  ----------- >  2:  c4d0e6c684b tests: don't depend on template-created .git/branches
 -:  ----------- >  3:  967762b4670 tests: don't assume a .git/info for .git/info/grafts
 -:  ----------- >  4:  64292c20c84 tests: don't assume a .git/info for .git/info/attributes
 -:  ----------- >  5:  b9f667bf292 tests: don't assume a .git/info for .git/info/refs
 -:  ----------- >  6:  29da5a3d431 tests: don't assume a .git/info for .git/info/exclude
 -:  ----------- >  7:  0149c80f09c tests: don't assume a .git/info for .git/info/sparse-checkout
-- 
2.36.1.1119.g5a713b43bd4

