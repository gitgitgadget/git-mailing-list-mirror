Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542ADC433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 11:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347028AbiAGLRg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 06:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347023AbiAGLRf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 06:17:35 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1F7C061245
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 03:17:35 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id l10so10429462wrh.7
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 03:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5agAh/syT4U88kMESEnfK9fJ5pj1EjazSWzC9dIXF+Q=;
        b=nehQBNF4QbldBD1ZkNDKLcywHHf9X8+JtMJrB3zqLDFhG0mjaoNZ2WlrOhTiTNdla5
         u7QWARWxgIebsALRBa9nE9rO1a6beTf6bjh4W4DIJWuPY5YLcu/7wU6VRlJ6wK00cc+p
         Ayn432nASutnn5z1dtgWHwAL3ReJTPx7E2/BtKK9erQd4Gs662KPGcTq4d1JLQiCsoFQ
         s5C+eLxHK23gGLPaEftiSyMRr3ASAPlwaRHehqqBi3rztQ1xfSbszY8YmmQafjQ8bG4s
         FBC7JAR4DA2TY9zMKh9twP5ZvUuof7ofvrHuVjVQjR6n5kdwR2F2WIdaaJSLKLV+3Glk
         aNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5agAh/syT4U88kMESEnfK9fJ5pj1EjazSWzC9dIXF+Q=;
        b=pSPn8ayRwQZ9XUMI+XJ7e6tboeVaTKnEtLfHMyDL6jBL7jJT1bcM/dEZL+GGrwKNwn
         DhZ7TUxmcH1QAGrvB08sO7d294lACaWNdzBACA5+ojNJ5ltZrZnQDsUKLuPhhLrztTfl
         wDViT86JPSU2e1jLpLPo42Wk8OZJHI7Y+mcOy1G7/QRme6p8QM7C30Kqie0YSzYVYIDh
         Ni4S9NkpGQSHhqcxLkq9eNXKsAEvRNCIhAE/gZcV790liHzha//RLUcFxj3w1QRG1brH
         jLhket7tdczDT3L11Bl5879w7cdz/8YLYapnhYbQMo1YuToGe5tT0tvjegFMDM6AsLe1
         6vEA==
X-Gm-Message-State: AOAM531w17al+uoOGryAxqXfrQ8jBhD1TL6uuqsILzmSGHGgYi5hpP/R
        +MHg4UzqRI27DUU302YG8W0i2/DKAko=
X-Google-Smtp-Source: ABdhPJxtAXuYKfw3Xu1lB+vKhnITpCtwdKBDmDbHHYgBrGqqkRNLHbn6YG1Sy4voEqoxtFEeQ8V63w==
X-Received: by 2002:a5d:6d45:: with SMTP id k5mr29890617wri.397.1641554253447;
        Fri, 07 Jan 2022 03:17:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5sm4588541wrb.77.2022.01.07.03.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 03:17:32 -0800 (PST)
Message-Id: <pull.1105.v4.git.1641554252.gitgitgadget@gmail.com>
In-Reply-To: <pull.1105.v3.git.1641508499.gitgitgadget@gmail.com>
References: <pull.1105.v3.git.1641508499.gitgitgadget@gmail.com>
From:   "Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 07 Jan 2022 11:17:27 +0000
Subject: [PATCH v4 0/4] update-index: refresh should rewrite index in case of racy timestamps
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch makes update-index --refresh write the index if it contains racy
timestamps, as discussed at [1].

Changes since v3:

 * test-lib: improve API for verifying file mtime
   * fix quoting around "$1"
   * use "rm -f" for cleanup of auxiliary files
   * improve API description comments
 * Note that gitgitgadget's "freebsd_12" check is failing since a couple of
   days (unrelated to this pull request); hence, this check hasn't been
   applied to this patch series

Changes since v2:

 * new patch: test-lib: introduce API for verifying file mtime
 * new patch: t7508: fix bogus mtime verification for test
   "--no-optional-locks prevents index update"
 * change new tests in t2108 and t7508 to use new test-lib mtime API
 * fix "--refresh has no racy timestamps to fix" to use +60s mtime to be
   save on VFAT

Changes since v1:

 * main commit message now uses 'git update-index' and the paragraph was
   dropped
 * t/t7508-status.sh: two tests added which capture status racy handling
 * builtin/update-index.c: comment improved
 * t/t2108-update-index-refresh-racy.sh: major overhaul
   * one test case added
   * mtime-manipulations simplified and aligned to t7508
   * code style fixes, as discussed

[1]
https://lore.kernel.org/git/d3dd805c-7c1d-30a9-6574-a7bfcb7fc013@syntevo.com/

Marc Strapetz (4):
  test-lib: introduce API for verifying file mtime
  t7508: fix bogus mtime verification
  t7508: add tests capturing racy timestamp handling
  update-index: refresh should rewrite index in case of racy timestamps

 builtin/update-index.c               | 11 +++++
 cache.h                              |  1 +
 read-cache.c                         |  2 +-
 t/t2108-update-index-refresh-racy.sh | 64 ++++++++++++++++++++++++++++
 t/t7508-status.sh                    | 30 ++++++++++---
 t/test-lib-functions.sh              | 33 ++++++++++++++
 6 files changed, 135 insertions(+), 6 deletions(-)
 create mode 100755 t/t2108-update-index-refresh-racy.sh


base-commit: dcc0cd074f0c639a0df20461a301af6d45bd582e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1105%2Fmstrap%2Ffeature%2Fupdate-index-refresh-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1105/mstrap/feature/update-index-refresh-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1105

Range-diff vs v3:

 1:  e6301e9d770 ! 1:  37c11bfafc4 test-lib: introduce API for verifying file mtime
     @@ t/test-lib-functions.sh: test_region () {
       	perl -le 'print readlink($_) for @ARGV' "$@"
       }
      +
     -+# Set a fixed "magic" mtime to the given file,
     -+# with an optional increment specified as second argument.
     -+# Use in combination with test_is_magic_mtime.
     ++# Set mtime to a fixed "magic" timestamp in mid February 2009, before we
     ++# run an operation that may or may not touch the file.  If the file was
     ++# touched, its timestamp will not accidentally have such an old timestamp,
     ++# as long as your filesystem clock is reasonably correct.  To verify the
     ++# timestamp, follow up with test_is_magic_mtime.
     ++#
     ++# An optional increment to the magic timestamp may be specified as second
     ++# argument.
      +test_set_magic_mtime () {
     -+	# We are using 1234567890 because it's a common timestamp used in
     -+	# various tests. It represents date 2009-02-13 which should be safe
     -+	# to use as long as the filetime clock is reasonably accurate.
      +	local inc=${2:-0} &&
      +	local mtime=$((1234567890 + $inc)) &&
     -+	test-tool chmtime =$mtime $1 &&
     -+	test_is_magic_mtime $1 $inc
     ++	test-tool chmtime =$mtime "$1" &&
     ++	test_is_magic_mtime "$1" $inc
      +}
      +
     -+# Test whether the given file has the "magic" mtime set,
     -+# with an optional increment specified as second argument.
     -+# Use in combination with test_set_magic_mtime.
     ++# Test whether the given file has the "magic" mtime set.  This is meant to
     ++# be used in combination with test_set_magic_mtime.
     ++#
     ++# An optional increment to the magic timestamp may be specified as second
     ++# argument.  Usually, this should be the same increment which was used for
     ++# the associated test_set_magic_mtime.
      +test_is_magic_mtime () {
      +	local inc=${2:-0} &&
      +	local mtime=$((1234567890 + $inc)) &&
      +	echo $mtime >.git/test-mtime-expect &&
     -+	test-tool chmtime --get $1 >.git/test-mtime-actual &&
     ++	test-tool chmtime --get "$1" >.git/test-mtime-actual &&
      +	test_cmp .git/test-mtime-expect .git/test-mtime-actual
      +	local ret=$?
     -+	rm .git/test-mtime-expect
     -+	rm .git/test-mtime-actual
     ++	rm -f .git/test-mtime-expect
     ++	rm -f .git/test-mtime-actual
      +	return $ret
      +}
 2:  d15a23cc804 = 2:  c97a41af389 t7508: fix bogus mtime verification
 3:  3567ef91e7a = 3:  82d0b6ab8d2 t7508: add tests capturing racy timestamp handling
 4:  4a6b18fb304 = 4:  e31edb74e24 update-index: refresh should rewrite index in case of racy timestamps

-- 
gitgitgadget
