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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4078EC433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C88B61404
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241166AbhDWHWS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 03:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241173AbhDWHWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 03:22:09 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A861DC06138D
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:21:32 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r9so72455160ejj.3
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DZduldtTihhi6Qk7geq1tMxUx6hCXehRHu6g0a2726k=;
        b=c8/KY8nDzMR96uK1mXPUylYUaHLnMAsTLkMSy45sQYutVetGsJZO/TpoNWIVvMSFl5
         AIsYoYDbcQsJ1LG3sMQE1w7EQslU9xc9CsG//ASlglhZNBjyT0jLhZp8weZBbEPaIVBI
         FgEaGDla//G14ZG//r4eUDVhNbYG2gPyz0FX5FJz/yZF9vDtKfJcH49q4ebdiod0P1HH
         qzeQ6b1/xE0vgxKFwKAjhjcQpRSkfi39Ou1oZsbogHFtVyPF8FgaiqoW80dpOlZYt3Dr
         hCfLztLW7rZB+RgzybTzoDbx3HnhfjS8vzzHtkqsfh0GKs2azaLpRd93wmzuU7vUqe02
         Blmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DZduldtTihhi6Qk7geq1tMxUx6hCXehRHu6g0a2726k=;
        b=jlGYOrOZU943lS+4Gk6hmwPVODlnybXML1bNsi6yzDttibXJvLzM8aYio5wyujbmyp
         b64UlgpOAEdo3o7k+3z4h5skSIENKYFOynVSuSeSsCI/4Jrh9Ame4NGswf67MgZKhzTK
         RRKzZIApQyEEsCuFS4sVmcYGj5bs3eF80QCUgfZ+c5PrAEcC6HNda+5Rua/66C4b9FlJ
         s2pmepm2G7KQAq9gq2wsH80TeyK1ZBQFNYuZfx3Pmf2N+0+8UAvROO9NUGvCDYmDBnqW
         ish4Jif8lejjB0BcHvdn7Zz31AwM74/FEd+DcfbgV/aDJPtZQSdkuuXhrvMi+NrAPRnC
         JcNQ==
X-Gm-Message-State: AOAM5310/1rTeou1fmCDfBfuR2kZ3j3JKTB7BI7YVG5erSGQkyIjVm4n
        z1mR6JCAXbK4uVaWuzp0GLLGYhzQ6L0+hQ==
X-Google-Smtp-Source: ABdhPJwXmvZAQAjex8IjQjB8TAfqojwaCfCxQ0/X8s/elXBtn3ZEOH4NfqT69GV5vltULE0gI10qkQ==
X-Received: by 2002:a17:906:1c8f:: with SMTP id g15mr2701422ejh.20.1619162491198;
        Fri, 23 Apr 2021 00:21:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e5sm3328892ejq.85.2021.04.23.00.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 00:21:30 -0700 (PDT)
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
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 10/11] test-lib: do not show advice about init.defaultBranch under --verbose
Date:   Fri, 23 Apr 2021 09:21:14 +0200
Message-Id: <patch-10.11-37338c88300-20210423T072006Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.737.g98b508eba36
In-Reply-To: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
References: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com> <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
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
index 7101030f042..c9f33b79151 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1251,7 +1251,6 @@ test_create_repo () {
 	(
 		cd "$repo" || error "Cannot setup test environment"
 		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" \
-			-c init.defaultBranch="${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-master}" \
 			init \
 			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
 		error "cannot run git init -- have you built things yet?"
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 105c424bf56..ab1fe98ccce 100644
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
2.31.1.737.g98b508eba36

