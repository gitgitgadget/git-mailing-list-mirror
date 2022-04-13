Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D6EC433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238537AbiDMT74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbiDMT7y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:59:54 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3907960AB2
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:57:32 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l9-20020a05600c4f0900b0038ccd1b8642so3522706wmq.0
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T6u8JVIvYWBIj1TiJMEpYnW6E1PXN7DJBDAQPfCphcc=;
        b=DvPo5MQ58AMZNZXnO6gXbHh67qbUpoAKhit1DDqGOa8nA35iJ+Lsa6awpvTy5XsydA
         0N/uDMh8bjtdlpDw4BfnUQyRNKjNx7NVwDKxG8gu/n3wTRiQNJdpb5xDHwoCl4o8quAv
         5hiPv6n1zo4YcFM7vBV5mziL+ImK7KNJErIDHF4jcays0v3DBIBVXIQ3ofBy9Z4DLRM2
         0B3+DxAxEHTb0L2IZTSeSZahVnGAqCgIKT/u2gnLldM50J/L4odGzLBTOrP5Gws55NvZ
         cWvzu2+6RmsVKAKC06+gSE/XJRumdKskf09b5m6gfapMG+M5AV/GAuTuuH33QUeRbY5f
         O0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T6u8JVIvYWBIj1TiJMEpYnW6E1PXN7DJBDAQPfCphcc=;
        b=8AnedWZGmnO3ayHL3rDJbr75xTzpmKdWgO3slbBTympdGwghDfDoHePUS1KFWI3G1W
         zjQFDEad/aWtPzBFfuXWsQQUe19+Ip4Voi1JiCqPG7dTYQgzZvOe3iAfqbGEcaaA/4Uv
         0K4ABkga4t/D/4T71bq/OSD7nKEpWFslXXhEf9svTIanr6pLDZ8IXcAjdAEaxvhdyJ46
         GPgLlAOu+GvYy881WYBTZrVnNqX4AgQ4DEEmOHn6KdSBF5yFF46ub+qk8w392txmgJg3
         8sl5CaYtzmlkDZRiKn6pxiYGaCr/A4zKFaZtJgzpDhyfVKPGqnzXmOzkOZKymZkwA+ZX
         idLw==
X-Gm-Message-State: AOAM533FFDmWtYrYFVrYTYqD9K/dUDggoUmpilQPWOrdzvivBqcmo5yw
        RfjHtokG9k01sttJ+uC8NCHg7XD2F7OWNw==
X-Google-Smtp-Source: ABdhPJwJJKZ/f/7NYl62XlA4ushyNvjxk+VG/66V4S9IU8ZQ4jnMCzRlNm7FgI+s1tcgDgd5JBsm7Q==
X-Received: by 2002:a05:600c:34c4:b0:38e:b628:da95 with SMTP id d4-20020a05600c34c400b0038eb628da95mr297630wmq.150.1649879850396;
        Wed, 13 Apr 2022 12:57:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm4547802wmq.27.2022.04.13.12.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:57:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v4 0/6] CI: js/ci-github-workflow-markup rebased on "use $GITHUB_ENV"
Date:   Wed, 13 Apr 2022 21:57:22 +0200
Message-Id: <RFC-cover-v4-0.6-00000000000-20220413T195514Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <RFC-cover-v3-0.6-00000000000-20220325T183946Z-avarab@gmail.com>
References: <RFC-cover-v3-0.6-00000000000-20220325T183946Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See the "v3" for the "real" cover-letter:
https://lore.kernel.org/git/RFC-cover-v3-0.6-00000000000-20220325T183946Z-avarab@gmail.com/

The only change in this v4 is to rebase this series on the
just-submitted v3 of the parent series at:
https://lore.kernel.org/git/cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com/

Also seen in the range-diff is a rebasing on the --immediate behavior
for for t/test-lib.sh, which landed on master since tho "v3" was
submitted.

Johannes Schindelin (6):
  ci: make it easier to find failed tests' logs in the GitHub workflow
  tests: refactor --write-junit-xml code
  test(junit): avoid line feeds in XML attributes
  ci: optionally mark up output in the GitHub workflow
  ci: use `--github-workflow-markup` in the GitHub workflow
  ci: call `finalize_test_case_output` a little later

 .github/workflows/main.yml           |  20 +---
 ci/lib.sh                            |   3 +-
 ci/print-test-failures-github.sh     |  35 +++++++
 t/test-lib-functions.sh              |   4 +-
 t/test-lib-github-workflow-markup.sh |  50 ++++++++++
 t/test-lib-junit.sh                  | 132 +++++++++++++++++++++++++++
 t/test-lib.sh                        | 128 ++++----------------------
 7 files changed, 245 insertions(+), 127 deletions(-)
 create mode 100755 ci/print-test-failures-github.sh
 create mode 100644 t/test-lib-github-workflow-markup.sh
 create mode 100644 t/test-lib-junit.sh

Range-diff against v3:
1:  d88749c60c9 = 1:  cc137c69ee1 ci: make it easier to find failed tests' logs in the GitHub workflow
2:  ad1e1465a81 = 2:  91f96c4f210 tests: refactor --write-junit-xml code
3:  fc96e5b7296 = 3:  84c722969d5 test(junit): avoid line feeds in XML attributes
4:  429c256ac62 = 4:  8acaa800d3a ci: optionally mark up output in the GitHub workflow
5:  72058db67b0 ! 5:  4499f743dd1 ci: use `--github-workflow-markup` in the GitHub workflow
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## ci/lib.sh ##
    -@@ ci/lib.sh: MAKEFLAGS="DEVELOPER=$DEVELOPER SKIP_DASHED_BUILT_INS=$SKIP_DASHED_BUILT_INS"
    +@@ ci/lib.sh: MAKEFLAGS="$MAKEFLAGS SKIP_DASHED_BUILT_INS=$SKIP_DASHED_BUILT_INS"
      case "$CI_TYPE" in
      github-actions)
    - 	setenv --test GIT_PROVE_OPTS "--timer --jobs 10"
    + 	setenv --test GIT_PROVE_OPTS "--timer --jobs $NPROC"
     -	GIT_TEST_OPTS="--verbose-log -x"
     +	GIT_TEST_OPTS="--verbose-log -x --github-workflow-markup"
    - 	MAKEFLAGS="$MAKEFLAGS --jobs=10"
    ++	MAKEFLAGS="$MAKEFLAGS --jobs=10"
      	test Windows != "$RUNNER_OS" ||
      	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
    + 	setenv --test GIT_TEST_OPTS "$GIT_TEST_OPTS"
     
      ## ci/print-test-failures-github.sh ##
     @@ ci/print-test-failures-github.sh: github-actions)
6:  1d2b94436fc ! 6:  b291f64821c ci: call `finalize_test_case_output` a little later
    @@ t/test-lib.sh: trap '{ code=$?; set +x; } 2>/dev/null; exit $code' INT TERM HUP
      	test_failure=$(($test_failure + 1))
      	say_color error "not ok $test_count - $1"
      	shift
    - 	printf '%s\n' "$*" | sed -e 's/^/#	/'
    - 	test "$immediate" = "" || _error_exit
    +@@ t/test-lib.sh: test_failure_ () {
    + 		say_color error "1..$test_count"
    + 		_error_exit
    + 	fi
     +	finalize_test_case_output failure "$failure_label" "$@"
      }
      
-- 
2.36.0.rc2.843.g193535c2aa7

