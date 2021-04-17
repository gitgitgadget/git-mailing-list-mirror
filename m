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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEED4C43461
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B76E6611C2
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbhDQMyP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 08:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236535AbhDQMyM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 08:54:12 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058E6C061756
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:53:45 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so15548199wmj.2
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q3vFfZBtvABEMfKPjwdFQ/CNeu1eSyPRsdkY84Me3Us=;
        b=blI82oPFnsVtuDk7r7g1omRMrzKSiVoeqY/adXCBTTJT+52t8e6rd5Y4CLOrzs3Fdh
         EGvYSF7urd+2wjXsbMUOMl4zXlvEUPJf4zBULfttq6azny9bz3EKlqYVS1DpmvsIRiVb
         ya0edqKKYb5ozH5RUnZvNFJ/bO6jwjnjUJfl4kOneJGs/PecgS/QPWDUq66noIanTX+s
         ihJnsmwEsxomvAGrRsyniSTTDebWMihnRKHQoekqJWRv6mAitFhlgJbCrNi2vagxS82N
         X+SBURdHrZewF4+ZzDLNYQfR/4dNe0BkwTYwfDUXPPIIKCHbpVvYPdUWLwZhMiBfEdXN
         Rdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q3vFfZBtvABEMfKPjwdFQ/CNeu1eSyPRsdkY84Me3Us=;
        b=TpUOuh2rpx3StDaXPAgdpMOT1qfc15hwILlQUmXUrTpm5gEb06N9Y3+5CWEKJ37BPv
         R661z4bS5fDyqCJk7UYetwJ9NVwFfpmh6t20D7/4xAdIFPdj51Zisw5RPRT8Hb5K8/SU
         hAm1NtsD8enIB8WG5BLywjSpjzOTnXS9mPr8/sc0Zf1bcqWBIcBbQU4QxhfdfnO7DktR
         lZk7ZNCUSvyb47NdTbyplUyKXVNoiMs1dNyebzaO2rGej6FYO28/Eg1cU74K6kSvcgN7
         kcjZ85ofrt+QSB9k0rEllWpq9FzP23TRF1aHc+IqjJMr0vAfcWBBzlbG6l4Anj4uz/rX
         js5A==
X-Gm-Message-State: AOAM5304sfCvJlwry0u+BocG+41L9c0pF7M00LGY79IDKy4B8EnvbJkv
        sFsOW1tcJFmDBZh7pA6Sk3lbXRKNWjkspg==
X-Google-Smtp-Source: ABdhPJzJspaUuB2x9u3RyxOSY8gTGYBd0Zxthy09fJ3V8R7retr1hP6LpNpQm+r/1uxgw1coq0Acmg==
X-Received: by 2002:a05:600c:2dc8:: with SMTP id e8mr12406398wmh.10.1618664023562;
        Sat, 17 Apr 2021 05:53:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4sm11594529wme.14.2021.04.17.05.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 05:53:43 -0700 (PDT)
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
Subject: [PATCH v2 09/12] submodule tests: use symbolic-ref --short to discover branch name
Date:   Sat, 17 Apr 2021 14:52:42 +0200
Message-Id: <patch-09.12-90bf55d2d42-20210417T124424Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.722.g788886f50a2
In-Reply-To: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com> <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a use of $GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME added in
704fed9ea22 (tests: start moving to a different default main branch
name, 2020-10-23) to simply discover the initial branch name of a
repository set up in this function with "symbolic-ref --short".

That's something done in another test in 704fed9ea22, so doing it like
this seems like an omission, or rather an overly eager
search/replacement instead of fixing the test logic.

There are only three uses of the GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
variable in the test suite, this gets rid of one of those.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-submodule-update.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 4b714e93083..f7c7df0ca42 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -63,6 +63,7 @@ create_lib_submodule_repo () {
 	git init submodule_update_repo &&
 	(
 		cd submodule_update_repo &&
+		branch=$(git symbolic-ref --short HEAD) &&
 		echo "expect" >>.gitignore &&
 		echo "actual" >>.gitignore &&
 		echo "x" >file1 &&
@@ -144,7 +145,7 @@ create_lib_submodule_repo () {
 		git checkout -b valid_sub1 &&
 		git revert HEAD &&
 
-		git checkout "${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-master}"
+		git checkout "$branch"
 	)
 }
 
-- 
2.31.1.722.g788886f50a2

