Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5EBC43381
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 18:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FE6A233ED
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 18:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404352AbhATSfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 13:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbhATS3s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 13:29:48 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56C3C0613D6
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 10:28:07 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id m4so24010904wrx.9
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 10:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H/TTEqT2T5A8HDFacUn3tGgx1LsjpuzjJDBMD60E/uU=;
        b=X2GkTMK/fd6r6H1hdJDbeI6/VIHEDsWhudtd1AI/zz9DcRp6Qaf/6NB/gK6byzsJr6
         G276dVmIxTUSxYTO3Ij1da65IkQHObRptTPW+CegbaHIT5wk4YxT/WmDC4qML59E0A2K
         D+3p4kPOAY5Mh0EcBLaiVQ7OMq2KEz61l2gYEhJMLap0zFEQjva88N9xNsj4sLllIwG/
         lTsPB87S8UnM0+6J1vhXfEWBJVuUvXoKxyg3ce9rHyFBfMg3R4Wb0AWJ19JFh0YfxvWD
         9IgXe/HqSLoNsP8fAJ+TgohCBemYOUnqG4iWoJsfPw5PQxft6SnmiYwjAgGNwbCXhfHq
         OpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H/TTEqT2T5A8HDFacUn3tGgx1LsjpuzjJDBMD60E/uU=;
        b=QqM3LjZa2Qqm61jed5zynu+B9v7elJvvo91zaqBPF5Nw4Xo/8aKCNCN+wrUpgNy3MC
         yWHe8PB8ARgpwAc3LZ5qvvS/APYlflYHFH7p8uqNxe8iApka4rE0+LTNZl1pjwNLzaZI
         dTNfV6+WGT1HMVD9HTw3viAPk5ctD/r/+jRd2KDA1LCeNbCnY5/v0P/oJmYF3H1X0pXM
         Mpj21gz/gfPcJ9FEqfdxn/P9BotMsK1utK116DkED8arQadmO5SKkYIw+zoUXmSns+QT
         kSQvHijsG6bNJNV1EdNop+kcyOACP2nCevh1lIABn6SnetvXJjf/vwwuFBiRNAKb/pkX
         T9Ig==
X-Gm-Message-State: AOAM533r44hnaUY+PUce2HowQPEv1rSsg1PGqcnehR9Unzo7bKO44wTF
        IgLoFxOSlD9FkT6mrWRKeZ11GYfy7dEPRw==
X-Google-Smtp-Source: ABdhPJz+Po8Yc6/BzBUci9pp+J0WdRhTZrgA3Pd2FVRh1Bv6g5dVl5zovwR2uvKYJrq5AA9HwYy9hw==
X-Received: by 2002:adf:f58b:: with SMTP id f11mr4409496wro.3.1611167286308;
        Wed, 20 Jan 2021 10:28:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18sm5920942wrp.74.2021.01.20.10.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 10:28:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/3] tests: remove uses of GIT_TEST_GETTEXT_POISON=false
Date:   Wed, 20 Jan 2021 19:27:59 +0100
Message-Id: <20210120182759.31102-4-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210111144740.6092-1-avarab@gmail.com>
References: <20210111144740.6092-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in previous commits we are removing the use of
GIT_TEST_GETTEXT_POISON=false. These tests all relied on the facility
being off, it always is off after an earlier change, but we hadn't
removed the redundant assignments to "false" in the tests.

I'm preserving the deletion of "error" lines in 38b9197a76a (t5411:
add basic test cases for proc-receive hook, 2020-08-27), it turns out
that's useful even without GIT_TEST_GETTEXT_POISON=true in
play. Update a comment added in that commit to note that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1305-config-include.sh   | 4 +---
 t/t5411/common-functions.sh | 5 ++---
 t/t7201-co.sh               | 2 +-
 t/t9902-completion.sh       | 1 -
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index f1e1b289f9..f08cfcdfae 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -352,9 +352,7 @@ test_expect_success 'include cycles are detected' '
 	git init --bare cycle &&
 	git -C cycle config include.path cycle &&
 	git config -f cycle/cycle include.path config &&
-	test_must_fail \
-		env GIT_TEST_GETTEXT_POISON=false \
-		git -C cycle config --get-all test.value 2>stderr &&
+	test_must_fail git -C cycle config --get-all test.value 2>stderr &&
 	grep "exceeded maximum include depth" stderr
 '
 
diff --git a/t/t5411/common-functions.sh b/t/t5411/common-functions.sh
index 344d13f61a..13107fcdb6 100644
--- a/t/t5411/common-functions.sh
+++ b/t/t5411/common-functions.sh
@@ -36,9 +36,8 @@ create_commits_in () {
 # without having to worry about future changes of the commit ID and spaces
 # of the output.  Single quotes are replaced with double quotes, because
 # it is boring to prepare unquoted single quotes in expect text.  We also
-# remove some locale error messages, which break test if we turn on
-# `GIT_TEST_GETTEXT_POISON=true` in order to test unintentional translations
-# on plumbing commands.
+# remove some locale error messages. The emitted human-readable errors are
+# redundant to the more machine-readable output the tests already assert.
 make_user_friendly_and_stable_output () {
 	sed \
 		-e "s/  *\$//" \
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index b36a93056f..d10076efd7 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -245,7 +245,7 @@ test_expect_success 'checkout to detach HEAD' '
 	rev=$(git rev-parse --short renamer^) &&
 	git checkout -f renamer &&
 	git clean -f &&
-	GIT_TEST_GETTEXT_POISON=false git checkout renamer^ 2>messages &&
+	git checkout renamer^ 2>messages &&
 	grep "HEAD is now at $rev" messages &&
 	test_line_count -gt 1 messages &&
 	H=$(git rev-parse --verify HEAD) &&
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index c4a7758409..ea669cfaf5 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2363,7 +2363,6 @@ test_expect_success 'sourcing the completion script clears cached commands' '
 '
 
 test_expect_success 'sourcing the completion script clears cached merge strategies' '
-	GIT_TEST_GETTEXT_POISON=false &&
 	__git_compute_merge_strategies &&
 	verbose test -n "$__git_merge_strategies" &&
 	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
-- 
2.29.2.222.g5d2a92d10f8

