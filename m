Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20131C4332F
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 10:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbiCQKOz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 06:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbiCQKOv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 06:14:51 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D468DAFE2
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:13:32 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l1-20020a05600c4f0100b00389645443d2so2874623wmq.2
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iPcpUpL7PXaG6/vchu5bTzrqF9Tdt4djVanDaNy/rFo=;
        b=Z46xjQ0U5b+NXnn3Y+EYnj6xLIgOJGddQSymwLC31zTfcvh6yBXcivenGKZrqG0oDb
         CMZzT3V4mQH3w+DJmCOTBEXQ2+qNks0U86nlLlFTAhZIsqbiFh7i6z1A6T7EeYL5UmT7
         Wk3VFsjKwwX8SSOAjMcOfbbUzC6H735iTRomZCxAC99TtwgCT8RLDVzR/Sg7Nnn237WH
         wbKTXERBPYUReGHD1VIa4/xbGeSNabvnV7r3OB8HSDzf4dE1XMqtLNmGPvK0xLiYl2sV
         L1js2AER5oBaTs5qrJUQQhB3UHSrcxbyRxf0P/dPAHg/W1vsUJWHbGaqh/3zrZfiVugn
         pp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iPcpUpL7PXaG6/vchu5bTzrqF9Tdt4djVanDaNy/rFo=;
        b=HDpCk74LADFR6YAM2KsecRedrLsoljWketTbUN2q1BlSok00+RG42+nOOTj3GR8mGZ
         bp1CQpwAwOzQH/aidiYTym0ao+j/dKNTqgv2Q4khoFJvBCQMZcsBGiFWtv6SVxMVT2lN
         y8bNtVXRU0a/mrjja5P5CJpgaBt77WEQS2u4DxtWDqwnv604206z5xYRGYiAZjW6dWka
         tTqC+CcVm6e+kQ8SjGEQZnUHNkXBxSWiy/N810fgfCYeLx2S2gA2+Wu1huenVIjiKflJ
         cr+krH0NcmfaJS4AsEM6LrtT3v0n3OUXdh+X6K1n/2Q88tgSBr6mw1FeOznI36ixCzSH
         h/+g==
X-Gm-Message-State: AOAM530jBnFrF1JpN3V9/X4RE+aiLO6PVE8qWTxiF/qtBVkugDnepqlX
        fXfKiP3LwWDuOGxYp5P6ICuHO3k3ooE=
X-Google-Smtp-Source: ABdhPJxp/gMIvAxrclQyeVZMq6lKJ1tfo+Hxlo53hSCs4cz2Yw+gZ1/hhYohB9+UJ2Wxy3gZYf2vxQ==
X-Received: by 2002:a05:600c:14a:b0:389:948e:eb2f with SMTP id w10-20020a05600c014a00b00389948eeb2fmr3125071wmm.141.1647512010189;
        Thu, 17 Mar 2022 03:13:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i206-20020a1c3bd7000000b0038bfc3ab76csm3903236wma.48.2022.03.17.03.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 03:13:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 08/13] tests: change "cat && chmod +x" to use "test_hook"
Date:   Thu, 17 Mar 2022 11:13:13 +0100
Message-Id: <patch-v3-08.13-bb25560d432-20220317T100820Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com> <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor various test code to use the "test_hook" helper. This change:

 - Fixes the long-standing issues with those tests using "#!/bin/sh"
   instead of "#!$SHELL_PATH". Using "#!/bin/sh" here happened to work
   because this code was so simple that it e.g. worked on Solaris
   /bin/sh.

 - Removes the "mkdir .git/hooks" invocation, as explained in a
   preceding commit we'll rely on the default templates to create that
   directory for us.

For the test in "t5402-post-merge-hook.sh" it's easier and more
correct to unroll the for-loop into a test_expect_success, so let's do
that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5402-post-merge-hook.sh | 16 +++++++++-------
 t/t5601-clone.sh           |  4 +---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t5402-post-merge-hook.sh b/t/t5402-post-merge-hook.sh
index 3e5e19c7191..915af2de95e 100755
--- a/t/t5402-post-merge-hook.sh
+++ b/t/t5402-post-merge-hook.sh
@@ -25,13 +25,15 @@ test_expect_success setup '
 	GIT_DIR=clone2/.git git update-index --add a
 '
 
-for clone in 1 2; do
-	cat >clone${clone}/.git/hooks/post-merge <<'EOF'
-#!/bin/sh
-echo $@ >> $GIT_DIR/post-merge.args
-EOF
-	chmod u+x clone${clone}/.git/hooks/post-merge
-done
+test_expect_success 'setup clone hooks' '
+	test_when_finished "rm -f hook" &&
+	cat >hook <<-\EOF &&
+	echo $@ >>$GIT_DIR/post-merge.args
+	EOF
+
+	test_hook --setup -C clone1 post-merge <hook &&
+	test_hook --setup -C clone2 post-merge <hook
+'
 
 test_expect_success 'post-merge does not run for up-to-date ' '
 	GIT_DIR=clone1/.git git merge $commit0 &&
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 83c24fc97a7..4a61f2c901e 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -79,12 +79,10 @@ test_expect_success 'clone from hooks' '
 	cd .. &&
 	git init r1 &&
 	cd r1 &&
-	cat >.git/hooks/pre-commit <<-\EOF &&
-	#!/bin/sh
+	test_hook pre-commit <<-\EOF &&
 	git clone ../r0 ../r2
 	exit 1
 	EOF
-	chmod u+x .git/hooks/pre-commit &&
 	: >file &&
 	git add file &&
 	test_must_fail git commit -m invoke-hook &&
-- 
2.35.1.1384.g7d2906948a1

