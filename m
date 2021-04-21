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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF1AC433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B16D61427
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239163AbhDUKQO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 06:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239145AbhDUKQE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 06:16:04 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F94C06138C
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:15:29 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id w4so37033365wrt.5
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dkJt2g6a5YKn0WncXh/AC6VdXmOCE/JQodPV4gUeo+w=;
        b=Gf7DUnn8AH5WwJly/lsTPUElsni6KhIwrH9bXSyC+IftRP6COsrL9QSCgVpARicDXA
         oLGuystQbY8UxP4t5fJYatXkscJ8ZOGwod4I9sC1JOT+UZYSuA6STJwbgDrKA/6B0Qb7
         Cr1eZVrjJkCl1OOQinvnUdPRiQZ1pfDgYsxRNJBaEh1uis5YD0TyqgPPNElzCx0jBtkR
         iBRUUu+hCKYvfnSwBbk+HYzu4++yXvjvMyaMkd/emsdl365ToMbvNo30tDjGZ9Z0Ws3o
         gRimRxcoZG+2nY7AppX2kCO55+S20zgIcrDXFtB1BRTCT16EfSBSC0sahYVMphUidhf0
         hIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dkJt2g6a5YKn0WncXh/AC6VdXmOCE/JQodPV4gUeo+w=;
        b=EmETJ7s/fuDCa2Ll1qpR4JAai4r/3kMx7Uy8dxmFVxLqbKTrSIF3Ix0MQzINKPH88+
         nRcsrhhisgDvnEChsFtIIrwoen7VhRuHHN7Ht2hhlEVB3rl9FQ9aE5L0AqeQr6HSsLjS
         VzmOKed7zdZNJay9tYCnyajGKgX5o1pEs2jXMZGtNSjrpmMGJeOO/Eza19ba0X6nAaYC
         DIqyUwIaSRTZvMW3cw2lTfz/TWk6UoqeZ41BDxd6y+DCIkTpJ+HRq0ZRO2hIQbIEIXNc
         JW3xcBp9/7a8fx11mwjVYU40X7IwOajeYrFKFUG1NL2pCQnAkeSSH67cuuw6WZVJ+23d
         H+dw==
X-Gm-Message-State: AOAM533+arVuBCLonZeRm9JJ4sf8jDCPCEhnwYwGNmYd4VUHBAosQDkM
        KMg1wOpPi66/x9KKriEuby1qFF5l9pVzKg==
X-Google-Smtp-Source: ABdhPJwwnR2hWKgQ2G9s1WSQCyDrfEQzZBfaSlY7nxLIQs77o40ELoVb7ik9xF3fU2WrOb9tdGqEXg==
X-Received: by 2002:a05:6000:120b:: with SMTP id e11mr25806200wrx.299.1619000127928;
        Wed, 21 Apr 2021 03:15:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i9sm1843084wmg.2.2021.04.21.03.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 03:15:27 -0700 (PDT)
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
Subject: [PATCH v4 10/11] test-lib: do not show advice about init.defaultBranch under --verbose
Date:   Wed, 21 Apr 2021 12:15:15 +0200
Message-Id: <patch-10.11-6ba568df9f-20210421T101156Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.721.gbeb6a21927
In-Reply-To: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
References: <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com> <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
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
index 105c424bf5..ab1fe98ccc 100644
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
2.31.1.721.gbeb6a21927

