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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD318C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97B856134F
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240097AbhDLLJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240031AbhDLLJi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:09:38 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE3CC06138C
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:20 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h4so3449391wrt.12
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0nXQnEeqyKsUjE0RUMn+hQlwSRfV4F+S9KtwaPGs2KU=;
        b=lAGFdGOvUCa0MQwrZXdMwX4RQkPaXs61DzH7fD0iJ8A7KJebeND1fpZrpfjX2PqNK3
         IjWTvYiYpGAycumw2YBZR7iGlvkPMB8fE/soPFtlyL05tM/zPPKlOzmgi76YCT+d2iLa
         D08IMDthHTQozyj2ClUgbFlx+zplnl7vmKMEO7nzAzouRB4I5zbEj7fSkbK8sDFkW2E9
         QUorL2kU2cR/GvialV4BKT6YDKyZIiGjXq3Eedk29XY18y1AwgQfyD5VQTD9vq/gzVhL
         Z97N//f9wsO5yKF4kF9THt8YpSJMdbD70/52152XqykDMBAX9q3q4a1BXdgN00QIg3It
         O6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0nXQnEeqyKsUjE0RUMn+hQlwSRfV4F+S9KtwaPGs2KU=;
        b=fCj5jyL1/fSUQcrpTM/ScviuHS3c+oBVnTvZrvk1aDpC4fM1/QYyUEqiPMweGMPp5W
         ZBq3y+my8DviHXRPD8Yze1DWogjfsL8OtlA2YFMgEIxodfq/xrW7wUPDo5lZjnrVdiJl
         86Z8IcmjgPEFlJ3es/tKdQdpeul9gCNP8JmrCbAPQ9LiismiuZJi1i13btKfH1rHof+n
         0MgpMzhW1mg5xqtucLkPa+e/gmXftjfmdTb0USs5YYKGWm0gP7/XLETauBzLoR2Sshrg
         Eeo6A7f50JJkOCQMamxcQ2/pgaeXUfvhIdMGo+Q7wMg6sHIZtgTwGZdmPQYzA3c29Ya5
         3X+g==
X-Gm-Message-State: AOAM533aV915vVOZHXPFqD32Dz81ZjFMqMguv9c7LqelGXFweBFu3jgo
        swCGefZF1Mtjuaq4LjUTYIX/bewiPWemzQ==
X-Google-Smtp-Source: ABdhPJxfijPQ7DkbqsFjgF8srMhW3u5deKwhTTQ1txtEcZ6EteDZzk5p2qb8hTxRg7+bz9gdCthq1Q==
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr31614863wrj.145.1618225758974;
        Mon, 12 Apr 2021 04:09:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a8sm18158744wrh.91.2021.04.12.04.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:09:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/16] test-lib: do not show advice about init.defaultBranch under --verbose
Date:   Mon, 12 Apr 2021 13:09:00 +0200
Message-Id: <patch-11.16-cdbff4df362-20210412T110456Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.634.gb41287a30b0
In-Reply-To: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
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
index 674b865a20d..c81726acb9e 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1259,7 +1259,6 @@ test_create_repo () {
 	(
 		cd "$repo" || error "Cannot setup test environment"
 		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" \
-			-c init.defaultBranch="${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-master}" \
 			init \
 			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
 		error "cannot run git init -- have you built things yet?"
diff --git a/t/test-lib.sh b/t/test-lib.sh
index a8869eee58f..0057dfa69d0 100644
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
2.31.1.634.gb41287a30b0

