Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39D5C43460
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82936613C1
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbhDTMWz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbhDTMWv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:22:51 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3449BC061342
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:22:18 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h4so28363167wrt.12
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tKDKLk+PjKYvWkPm8sNaufz+xJcQq+vr1o1v7Bvbpd8=;
        b=gvsOz114pd3+UtwncjP5XUy67eaNSKN0deO92A/Tc+98DjpHW/S0Pe/8mQW0ybYoWM
         6iW4S2E5I+197aVD1erulIlOpjjRioLjHuANVtrICXaG76FOFVoV4mTv54R1i+tXG4t0
         if+hFoq95/n4ZraBcxpIpkFkut9RhT45ivtN3SA3GXOfJMi3IO0bXJ58knAxA0JLcs2/
         Y2M0hZmql7iXRaQTaSP5Zx5qWiuHGRyZmzm/MBzhPtlrUgmj7ALazeGSVTHHbxGIpecm
         QKpKQp9LyBsZUmcntfjGg+Bg4ih29kmYs+tPRV/8BSJM2ZwhMAaPrlXUzujm2EP21vKg
         psuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tKDKLk+PjKYvWkPm8sNaufz+xJcQq+vr1o1v7Bvbpd8=;
        b=aYjkej9YnIfY+Ayu1iaydgiuueSSjvvH46LH9Y3gPGuXSXjM7dcJ8OiRwa5vQIN/Kz
         y0srnEearm0k6xcfb2G93zfVZf8Zw3ceVs7YpvPgNXu47WiUH8zpD468CHHQqUCTgXTh
         b0LiFlfLWBIaADrpB/LqmsjcSNNy5Qt+17JJIrgGTH1LUAvJhFNUb5gZdIPMFAhLRlHh
         DrNlAbd1BWYWpYy+V7wJR5LamLNfJ6bCVe/LoeLT8nCz9vUouHrCcpUHi+prOGTptf5y
         jJYMw6CMlPPEHG8/Cr0Tq9BMrcw2fLAL+nG0p5WHpKOf7q8anxhQ+WfuObYUoFG0YuUC
         rHWw==
X-Gm-Message-State: AOAM530fwkjmfUKssb/rS9pChLPrkLcnDdkiUzDJvjyopa810LNU7gZ2
        u3xwANO+Iae8z6AfWUxUgdgnEdrnqWLsPQ==
X-Google-Smtp-Source: ABdhPJzMFsARQCiJeel4FwFh8Y+1+Tvr74max1iackOuTNbV+LiC7hrotTrpSmJ3cY3LO9CRKQNGIw==
X-Received: by 2002:a5d:6447:: with SMTP id d7mr20661419wrw.1.1618921337170;
        Tue, 20 Apr 2021 05:22:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1sm30541768wru.90.2021.04.20.05.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:22:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 11/12] test-lib: do not show advice about init.defaultBranch under --verbose
Date:   Tue, 20 Apr 2021 14:22:02 +0200
Message-Id: <patch-11.12-cedf5d383b-20210420T121833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.gf6bad1b9ba1
In-Reply-To: <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com> <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Arrange for the advice about naming the initial branch not to be shown
in the --verbose output of the test suite.

Since 675704c74dd (init: provide useful advice about
init.defaultBranch, 2020-12-11) some tests have been very chatty with
repeated occurrences of this multi-line advice. Having it be this
verbose isn't helpful for anyone in the context of git's own test
suite, and it makes debugging tests that use their own "git init"
invocations needlessly distracting.

By setting the GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME variable early in
test-lib.sh itself we'll squash the warning not only for
test_create_repo(), as 675704c74dd explicitly intended, but also for
other "git init" invocations.

And once we'd like to have this configuration set for all "git init"
invocations in the test suite we can get rid of the init.defaultBranch
configuration setting in test_create_repo(), as
repo_default_branch_name() in refs.c will take the GIT_TEST_* variable
over it being set.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 1 -
 t/test-lib.sh           | 5 +++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 21271020c7..8e75a013a4 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1258,7 +1258,6 @@ test_create_repo () {
 	(
 		cd "$repo" || error "Cannot setup test environment"
 		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" \
-			-c init.defaultBranch="${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-master}" \
 			init \
 			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
 		error "cannot run git init -- have you built things yet?"
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7522faf39f..9ebb595c33 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -64,6 +64,11 @@ then
 	export GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS
 fi
 
+# Explicitly set the default branch name for testing, to avoid the
+# transitory "git init" warning under --verbose.
+: ${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME:=master}
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 ################################################################
 # It appears that people try to run tests without building...
 "${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X" >/dev/null
-- 
2.31.1.723.gf6bad1b9ba1

