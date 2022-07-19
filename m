Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D1AC43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 21:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239738AbiGSVFj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 17:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbiGSVFg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 17:05:36 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CC22E6BF
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:05:34 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id a11so3556683wmq.3
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jq8M7tzAEt5GpTpcvJoITsp+0sf/L+HZDF0aJSA29qs=;
        b=UfF8Ps2zFgrqK3cRBcb3BdVFX/Z5jSSdxoFzYG1JBEfVz7YCZz7WP+KlykUI6QFh5u
         bSHBCWmhJJX/kZlPQAYUlU+toGlGphhHNDtGo3ydI9l2EMlRKuDUeDNgSbW28t8qMO29
         3IZDixjLV6X5XtPYnw1UMzjjGbXIfAOb2B4mJt/QDCq0t7V1e177ExdQwI8Pe/aKNQ2F
         pSNGynD0W+Ygt4A0KZ7AP1XeWWHI6/ilcF40yEfos9TplawmHlwhWyy6MDB14xmS9r+8
         vdgZeEi00Per/GWUaBK9/j8dVvJdhlqSUVzEj8Fe1m7tEtlsXwJJqQfqeLUQ4wSmXgJt
         IWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jq8M7tzAEt5GpTpcvJoITsp+0sf/L+HZDF0aJSA29qs=;
        b=s6sr6+E52X6fkXZe1WT96RoEG5EYr+BgeIHndri3W88Dgj+2Q+8lx/gdfnUGoOux8r
         EXZRP8fP8YGrpMOCt9lpmdqzLmmr9ieOF0P2FnhR/vW0D1qeO6FFvjkOWB27LxtNgQ+/
         qyS8QXtCriWLXxEZ2+wb45j3jMMwf0Ckm65TSn1Ky+LMqpDogju7igUm2Mr8QFdowICy
         6cE2yFeK2iyb3kiZztggV2Kb1CGb9ajmvvLw/FOdOTYi96B+59NTArj44kDV/OfCJqMm
         zrWIj+YKeOcrl3rRYziJJUM6GKrkhcpnc7XMAHXyqw8FAxV7h06whjkMLAF9Oh2e1Te1
         sjDQ==
X-Gm-Message-State: AJIora8H5t0t6qe0GYvXnTmce1GMfuwGTr1RJdopGsRvmrL82+EOwjI9
        Y5O0c2XVPIX8Ai93wP2mYaexI1Ix3xXDXg==
X-Google-Smtp-Source: AGRyM1tNoePpKDlB7sAReWGqKO1IsU22PSD08DsvaW70DpgTmMZNGE9D7/QCq+iltvGlcWQInPhGvA==
X-Received: by 2002:a7b:c316:0:b0:3a3:c83:9001 with SMTP id k22-20020a7bc316000000b003a30c839001mr941735wmj.105.1658264732941;
        Tue, 19 Jul 2022 14:05:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m24-20020a05600c461800b003a050a391e8sm75091wmo.38.2022.07.19.14.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:05:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/10] leak test: add "check" test mode, mark leak-free tests
Date:   Tue, 19 Jul 2022 23:05:14 +0200
Message-Id: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1063.gd87c5b8cc23
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since release_revisions() we've had much fewer widespread leaks in the
test suite, so I think it's time to mark even more tests as running in
the linux-leaks CI job. The 9/10 here does that.

But before that we introduce a "GIT_TEST_PASSING_SANITIZE_LEAK=check"
leak mode, this uses test-lib.sh --invert-exit-code feature added here
to fail tests whose TEST_PASSES_SANITIZE_LEAK=true marking isn't
current.

I've been using this series for a while to help in submitting all the
other leak fixes I've been sending in. It's very useful to run the
"check" with "git rebase -x", i.e. to atomically mark tests as
leak-free as we fix leaks.

In adding "check" I needed to add a new
GIT_TEST_SANITIZE_LEAK_LOG=true setting, and integrate it with
"check". I.e. we have many cases where we lose exit codes from git, or
otherwise don't notice an abort, 08/10 here discusses why that is.

When "check" and "GIT_TEST_SANITIZE_LEAK_LOG=true" are combined we'll
take into account leaks that we log to decide whether to pass the
tests.

Writing out the leak logs is also very useful to analyze our remaining
leaks. I've got a local script that scrapes the logs, and emits a
sorted list of which leaks provide the best bang-for-the-buck in terms
of getting more tests passing. That's not being submitted here, but I
can follow-up and send that in if there's interest.

Ævar Arnfjörð Bjarmason (10):
  test-lib.sh: use $1, not $@ in test_known_broken_{ok,failure}_
  test-lib.sh: don't set GIT_EXIT_OK before calling test_atexit_handler
  test-lib.sh: fix GIT_EXIT_OK logic errors, use BAIL_OUT
  test-lib.sh: add a --invert-exit-code switch
  t/README: reword the "GIT_TEST_PASSING_SANITIZE_LEAK" description
  test-lib: add a SANITIZE=leak logging mode
  test-lib.sh: add a GIT_TEST_PASSING_SANITIZE_LEAK=check mode
  test-lib: have the "check" mode for SANITIZE=leak consider leak logs
  leak tests: mark passing SANITIZE=leak tests as leak-free
  log tests: don't use "exit 1" outside a sub-shell

 t/README                            |  36 +++++-
 t/t0000-basic.sh                    |  72 +++++++++++
 t/t0027-auto-crlf.sh                |   1 +
 t/t0032-reftable-unittest.sh        |   1 +
 t/t0033-safe-directory.sh           |   1 +
 t/t0050-filesystem.sh               |   1 +
 t/t0095-bloom.sh                    |   2 +
 t/t1405-main-ref-store.sh           |   1 +
 t/t1407-worktree-ref-store.sh       |   1 +
 t/t1418-reflog-exists.sh            |   1 +
 t/t1701-racy-split-index.sh         |   1 +
 t/t2006-checkout-index-basic.sh     |   1 +
 t/t2023-checkout-m.sh               |   1 +
 t/t2205-add-worktree-config.sh      |   1 +
 t/t3012-ls-files-dedup.sh           |   1 +
 t/t4017-diff-retval.sh              |   1 +
 t/t4051-diff-function-context.sh    |   1 +
 t/t4057-diff-combined-paths.sh      |   1 +
 t/t4114-apply-typechange.sh         |   1 +
 t/t4205-log-pretty-formats.sh       |   2 +-
 t/t4301-merge-tree-write-tree.sh    |   1 +
 t/t5315-pack-objects-compression.sh |   1 +
 t/t5351-unpack-large-objects.sh     |   1 +
 t/t5402-post-merge-hook.sh          |   1 +
 t/t5503-tagfollow.sh                |   1 +
 t/t6404-recursive-merge.sh          |   1 +
 t/t6405-merge-symlinks.sh           |   1 +
 t/t6407-merge-binary.sh             |   1 -
 t/t6408-merge-up-to-date.sh         |   1 +
 t/t6411-merge-filemode.sh           |   1 +
 t/t6413-merge-crlf.sh               |   1 +
 t/t6415-merge-dir-to-symlink.sh     |   1 +
 t/t6425-merge-rename-delete.sh      |   1 +
 t/t6431-merge-criscross.sh          |   1 +
 t/t7060-wtstatus.sh                 |   1 +
 t/t7062-wtstatus-ignorecase.sh      |   1 +
 t/t7110-reset-merge.sh              |   1 +
 t/t7111-reset-table.sh              |   1 +
 t/t7609-mergetool--lib.sh           |   1 +
 t/t9100-git-svn-basic.sh            |   1 -
 t/t9700-perl-git.sh                 |   6 +
 t/t9901-git-web--browse.sh          |   1 +
 t/test-lib.sh                       | 187 ++++++++++++++++++++++++----
 43 files changed, 310 insertions(+), 32 deletions(-)

-- 
2.37.1.1062.g385eac7fccf

