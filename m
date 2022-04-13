Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE81C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbiDMUAM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238562AbiDMUAG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:00:06 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250D978917
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:57:37 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b19so4125914wrh.11
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8uVe9d8sAvjxx0iHyXXOFQnVr6Rp4yrkKQdMc44jdq8=;
        b=dIoUCeitEvS2mQCmPcD/4JJNr0n4veKDnRSudrhRE5E4B9CpSgqojDvzKzPIxI+Yrt
         cb61Lto8M8jZua6jg7Fo8D6cx88rP26FGtBhJSefxp/a38MfVVwBYZuIixkjmfLGUKUf
         /WCRZMaPqXCr7MyC1AfY7cib3hc1gsnwQynRBwnXIF/YXZASyiSl4Uu7t/5lu61awIFe
         0nTwDDA5xvTu4RD+7pImhNGpt3lZSCKDLd6XyF0Bt/r3h+UzgL1q+GPZMMousv0omqot
         pY/mNrCRvdl+dm0rEZx/rw9EdyJyk6h8k+GMvpMzlA9m9b0BXVPpMwfNT1fnDOyhWNpx
         RcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8uVe9d8sAvjxx0iHyXXOFQnVr6Rp4yrkKQdMc44jdq8=;
        b=vQm5Z3w5CIFg8UDpnO/CfwwzKaPzTP+0IO8YUryz0u7XVh8FaG43ufUUSwXSqQf4XG
         UEzOrBYyhyNZ5aHXKfbJy92oUYmb2d3WelpNrk6H9Jel7B82zS5KBxHjwXSJsg/wvE78
         Tblsn4d5zyjp7prtOWs1kW7L2TwYqwJxsxvps/0/M69TFdPOiu6DCeExlkQQ2JUVkNQj
         P4z5UyaBgupKlYc/rTk0t34I1COzI8N50B2wvNc68W3xyR8oS9dDEwNjozQ40Lyzsdz4
         n4HZ9MLZfftzdePI6J8QJHDQaicybUXX2BNrEptYV6kN0y8g+5y7mRwxG8IMpZ6cPCXg
         CJZQ==
X-Gm-Message-State: AOAM531FC+YOznsAV/VcNBBMj+QelBBK6duL8nOCy2y/hPzcbACfKJu+
        HN2f7te132I8BHIMZl07034L51OChYnpow==
X-Google-Smtp-Source: ABdhPJwAxCW4kV+Yajdzv0GQAqo54grVL6NrzLFyR9MQWw0MRrT2Z6nAoSF7SNFSnKFBEVwkn9y60g==
X-Received: by 2002:adf:ebc7:0:b0:1ee:945a:ffb4 with SMTP id v7-20020adfebc7000000b001ee945affb4mr319421wrn.641.1649879855336;
        Wed, 13 Apr 2022 12:57:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm4547802wmq.27.2022.04.13.12.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:57:34 -0700 (PDT)
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
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v4 5/6] ci: use `--github-workflow-markup` in the GitHub workflow
Date:   Wed, 13 Apr 2022 21:57:27 +0200
Message-Id: <RFC-patch-v4-5.6-4499f743dd1-20220413T195514Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <RFC-cover-v4-0.6-00000000000-20220413T195514Z-avarab@gmail.com>
References: <RFC-cover-v3-0.6-00000000000-20220325T183946Z-avarab@gmail.com> <RFC-cover-v4-0.6-00000000000-20220413T195514Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

[Ævar: due to re-structuring on top of my series the {begin,end}_group
in CI isn't needed at all to get "group" output for the test
suite. This commit includes the now-squashed "ci/run-build-and-tests:
add some structure to the GitHub workflow output":]

The current output of Git's GitHub workflow can be quite confusing,
especially for contributors new to the project.

To make it more helpful, let's introduce some collapsible grouping.
Initially, readers will see the high-level view of what actually
happened (did the build fail, or the test suite?). To drill down, the
respective group can be expanded.

Note: sadly, workflow output currently cannot contain any nested groups
(see https://github.com/actions/runner/issues/802 for details),
therefore we take pains to ensure to end any previous group before
starting a new one.

[Ævar: The above comment isn't true anymore, as that limitation has
been removed by basing this on my patches to run "make" and "make
test" directly from the top-level of main.yml.

Those are now effectively their own "group", effectively giving this
stage another group "level" to use. This means that the equivalent of
"make test" won't be on the same level as an individual test failure.

We no longer take any pains to ensure balanced group output as a
result (which was a caveat the previous ci/lib.sh implementation had
to deal with., We just need to "cat" the generated *.markup]

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh                        | 3 ++-
 ci/print-test-failures-github.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 3fd5291bc80..718c3252789 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -145,7 +145,8 @@ MAKEFLAGS="$MAKEFLAGS SKIP_DASHED_BUILT_INS=$SKIP_DASHED_BUILT_INS"
 case "$CI_TYPE" in
 github-actions)
 	setenv --test GIT_PROVE_OPTS "--timer --jobs $NPROC"
-	GIT_TEST_OPTS="--verbose-log -x"
+	GIT_TEST_OPTS="--verbose-log -x --github-workflow-markup"
+	MAKEFLAGS="$MAKEFLAGS --jobs=10"
 	test Windows != "$RUNNER_OS" ||
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
 	setenv --test GIT_TEST_OPTS "$GIT_TEST_OPTS"
diff --git a/ci/print-test-failures-github.sh b/ci/print-test-failures-github.sh
index 218aaf19763..e432a601621 100755
--- a/ci/print-test-failures-github.sh
+++ b/ci/print-test-failures-github.sh
@@ -17,7 +17,7 @@ github-actions)
 			test_name="${test_exit%.exit}"
 			test_name="${test_name##*/}"
 			printf "\\e[33m\\e[1m=== Failed test: ${test_name} ===\\e[m\\n"
-			cat "t/test-results/$test_name.out"
+			cat "t/test-results/$test_name.markup"
 
 			trash_dir="t/trash directory.$test_name"
 			cp "t/test-results/$test_name.out" t/failed-test-artifacts/
-- 
2.36.0.rc2.843.g193535c2aa7

