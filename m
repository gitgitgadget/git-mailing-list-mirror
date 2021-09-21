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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8949DC4332F
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70F7161050
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbhIUWmV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 18:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbhIUWmT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 18:42:19 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F33C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 15:40:50 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w29so1081975wra.8
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 15:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BZTjZQO81wyAK0NEQKOADR0s8JXeJAcNyhAnjPZ82+o=;
        b=L9cBzteHab6J2vHwjaHIzhWz9QN0i1in9Ou3rGjGL3vFf882TWvLbEB6Ujje5BzbWJ
         VLAORXmGEh996kPoXJ8c+iifkqLGIKlEN6x+hnf1RqGVzsEy3bxwKV5Gk68fK+csrpVE
         m6+Y1zH66FMZPs9BtDbfM4oSb9zyQWbBJJHUp1z8fHUed6o2xJd6yxoP91FBALK3oXtu
         OsiX42+3nfrugL3y4FC88/a1bAq5rcvFuLY3cwGBmEBMQQYqSKsQBCNfb679LNwG4Qlu
         nHk+2FAA4JqN529VMr//BLL9xJPtU3FlepF0smW+mo81AeIJcIOPxe6HbA2Arne3q0ZM
         HOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BZTjZQO81wyAK0NEQKOADR0s8JXeJAcNyhAnjPZ82+o=;
        b=DeYjTBS4phzsjp534gDliUN836ZWJHVKEwh3H0Jf5kWkrIHfneG1yKL7Vcohwpk8KR
         YudkcY3u51d2aqSVumDuTafaAYdZLO5TUDQtMHksdwkaji/uGIELcIE5kKy9cP1oHArj
         v7RHNtuXhMWOBSQT0iriQ4GK8LaFdYST6usLivpXXEmN0ElBSBG3xm8wGZfcOMy+jIhf
         ysDIaH1L+Ojs4SiZHZugDrQ+InhDSgPVWLQ89luZY4mitcueoOY2Umjh4msT/9tN+xgW
         KAYb5IbuMOSgHhsmmhZTGghRO+jN8FuujZLxCVK6S2YXXwdl7O3pKgrwCB3wtby0aI0g
         Dcsg==
X-Gm-Message-State: AOAM531JZQ7hiAoEd66PliSe07uMY1aGuJS6JAq006MvG+TJUCRWpesc
        GAPKYAtfJChl6Zuwzg/RGziBP+8dUsEOOA==
X-Google-Smtp-Source: ABdhPJzls2cE3lDxLPcQVqO1H30Tj6atIvLCz2DwoO0SbubDSalKQj0JIYkR2s0e7+Fa4XP8FZGJ9w==
X-Received: by 2002:adf:e546:: with SMTP id z6mr38059411wrm.346.1632264048922;
        Tue, 21 Sep 2021 15:40:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l7sm3846121wmp.48.2021.09.21.15.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 15:40:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/9] help: correct logic error in combining --all and --guides
Date:   Wed, 22 Sep 2021 00:40:35 +0200
Message-Id: <patch-v3-5.9-bf3ac71f256-20210921T223223Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-v3-0.9-00000000000-20210921T223223Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20210921T223223Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --all and --guides commands could be combined, which wouldn't have
any impact on the output except for:

    git help --all --guides --no-verbose

Listing the guide alongside that output was clearly not intended, so
let's error out here. See 002b726a400 (builtin/help.c: add
list_common_guides_help() function, 2013-04-02) for the initial
implementation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/help.c  | 4 ++++
 t/t0012-help.sh | 7 ++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/help.c b/builtin/help.c
index d0c9605dbb5..30f160a4669 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -559,6 +559,10 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		usage_msg_opt(_("--config and --all cannot be combined"),
 			      builtin_help_usage, builtin_help_options);
 
+	if (show_all && show_guides)
+		usage_msg_opt(_("--config and --guides cannot be combined"),
+			      builtin_help_usage, builtin_help_options);
+
 	if (show_config && show_guides)
 		usage_msg_opt(_("--config and --guides cannot be combined"),
 			      builtin_help_usage, builtin_help_options);
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index b4ed6229ed8..69e385d3b66 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -36,7 +36,12 @@ test_expect_success 'basic help commands' '
 
 test_expect_success 'invalid usage' '
 	test_expect_code 129 git help -g add &&
-	test_expect_code 129 git help -a -c
+	test_expect_code 129 git help -a -c &&
+
+	test_expect_code 129 git help -g add &&
+	test_expect_code 129 git help -a -g &&
+
+	test_expect_code 129 git help -g -c
 '
 
 test_expect_success "works for commands and guides by default" '
-- 
2.33.0.1098.gf02a64c1a2d

