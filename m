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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F2BC433B4
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2476611AC
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbhDQMyT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 08:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbhDQMyO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 08:54:14 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE7BC061574
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:53:46 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k26so12829569wrc.8
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KFHvSblHb6gwBootmTUNIBrJVd3q+m/RBQapP/wRMKM=;
        b=TwyYjwI9VbDekbc4euteeO7iGI/Gc6tjm9FSyD4s2eaP2WrZokhVEoazg2DVIRuxTe
         bzuKyIog/iQlpHGHY86dleZgN0TWU0DAzXyW0pqTRsedUtuUu0eZE3phbe3ZIF1LcQdH
         Q1ftUzWzwYq+BsZJP2T53WDHB3ziDm6vm9ewIhBzsZXYRdJ30vCpd+wBxh+frrjO6HJQ
         oAJszQSzeO79VplRuLSmJ3I+R+yDpv/3cEzI2YsEV0b5V2SCAxr362ZNOF2sg8iz7uHD
         wJoF9+hCyziCzOekTZsfrYUHfmGq1bRc3Mk2oHGyYUZXkyPys15K6Vnvd0cvAaZtljZ5
         1dJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KFHvSblHb6gwBootmTUNIBrJVd3q+m/RBQapP/wRMKM=;
        b=gCqYZU84M8d/X7r8hEZH3q4ICxsBr57uKEnIKzV9IbpEaOVAwHI+nFjE9vP4j92ViC
         YslU311MMKXNN8C6pqmyBertY89rF9dVgIhbxTEueE7jpKQIQLx2gJXrm8kY9ldBJFFZ
         dy5SntQVT3K3MJMAElW6CvBUGEu8GViKrojL08PREUW39F+pyy1QmDjjkQhDzWKSC2bI
         3w2iUhbUcPhHJw59zR89F0AvEnqVVW4Th5hWUzryYTyg6/NeMfngmCU1W55rttl7eUg5
         dj/6t3r73gPHvZdqtLKI7mVCaiI1rcB71qD2gDZL32+U1FBx7RTPoFVoLGB81uAc+BkK
         66Lw==
X-Gm-Message-State: AOAM532rP+fAftICGaqrW9hiKJG7zZK9f60kO9sbWYlHGt4vR+OIvLWK
        1YFAsx2avpPjOBuPVjhva6+yMe3BnotM8A==
X-Google-Smtp-Source: ABdhPJxinKd8/rBvyxEoUotyi7ZaxKngW15q9e+BXybhj9rARpeyfzCiB2aoWzFIwRFy6B+mSEKjmA==
X-Received: by 2002:a5d:534f:: with SMTP id t15mr4032708wrv.275.1618664025367;
        Sat, 17 Apr 2021 05:53:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4sm11594529wme.14.2021.04.17.05.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 05:53:44 -0700 (PDT)
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
Subject: [PATCH v2 11/12] test-lib: do not show advice about init.defaultBranch under --verbose
Date:   Sat, 17 Apr 2021 14:52:44 +0200
Message-Id: <patch-11.12-cedf5d383b0-20210417T124424Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.722.g788886f50a2
In-Reply-To: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com> <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
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
index 21271020c79..8e75a013a43 100644
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
index 7522faf39fc..9ebb595c335 100644
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
2.31.1.722.g788886f50a2

