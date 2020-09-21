Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6AAC43468
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6C552076E
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgG9J4Ay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgIUKk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 06:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgIUKkU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 06:40:20 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5084EC061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:20 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e11so11198264wme.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1q8skUEkEgmD3KhZu5V9H1XxMJJc6nqiyeSZyK5mIgk=;
        b=fgG9J4AyS3OcEn45GRNXIs521sIZnoF05GhKutByejS4z2WZxL0ZDUG8SBwOR6yhm2
         t9gCzfQo1FLgW9yje36BRc05IkwJdMu+MJp63nCojfDJMSULazxlktPL5MMm8tA4udjB
         oZJH9qCAlJ4mtWE6bqAopFZkIjEOmh7YdX6Za6AOG0EV8kywK4bCe/2TjdMLHeFzbHkQ
         5X1e1UpcYdrc94/i/la7NIpLqNVFUdPTqz30xu4Z86tK6PvEtF+EHzmOnGinjtx08+9B
         Ivt30VGUN4vGmpDd2ILFp8TUPc17jtrwsYRVazcVs2RKqosSGc1mPAoH48DxA00fwJC/
         mGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1q8skUEkEgmD3KhZu5V9H1XxMJJc6nqiyeSZyK5mIgk=;
        b=jBvcQxpkJmc/7cPOE1sgWCd6sHy2L3U7XhUrokDLVQ0BYld7yhjXPdIhfsz+hFuTDR
         GyJGNXcPt29zGlIwlOirseo2Tog+6e1YVC/H4Gn+Ea0O83jFll1u/UIAMB61Pecf8+KO
         s7as8mWS8LGAipa8VOKdbf7GoB/tG3dFaHoUiYegpz6DlAylwzKf2DxNdCEp98dtU+VC
         B6Dz2mxwvTcjM4w7ZKtkwL3huztF7Mq6FDDDSYdU0wFBxWusgeRKri4DOScnWKPA6j1Q
         bTE2hp6OubmrkbkO7tLXdzWlg/5qQGFrZyUdfEPXut7xJbcOU2GbMmTOaRzM3zMpsyHA
         F7XA==
X-Gm-Message-State: AOAM533D7fLagFBh5Hkna8rRjji6Z5ccl6xgQw6kV61tnfmoPN9LdIpy
        9NQaRRvDvMpRKymG0t73HF8QvoDiu9eGgA==
X-Google-Smtp-Source: ABdhPJxca47zjmU8tL+LJjzpw2iGYuS69txHzEET/SZHWrDt6UuzaVN0fPoA9Vc6tmPjearExHpUNQ==
X-Received: by 2002:a1c:2403:: with SMTP id k3mr28718146wmk.153.1600684818810;
        Mon, 21 Sep 2020 03:40:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 9sm18647833wmf.7.2020.09.21.03.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:40:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, imon Legner <Simon.Legner@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/18] remote-mediawiki tests: use the login/password variables
Date:   Mon, 21 Sep 2020 12:39:46 +0200
Message-Id: <20200921104000.2304-5-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a hardcoded user/password for the corresponding variable
defined in contrib/mw-to-git/t/test.config.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh b/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
index 3ff3a09567..43580af3cf 100755
--- a/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
+++ b/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
@@ -27,8 +27,8 @@ test_git_reimport () {
 
 # Don't bother with permissions, be administrator by default
 test_expect_success 'setup config' '
-	git config --global remote.origin.mwLogin WikiAdmin &&
-	git config --global remote.origin.mwPassword AdminPass &&
+	git config --global remote.origin.mwLogin "$WIKI_ADMIN" &&
+	git config --global remote.origin.mwPassword "$WIKI_PASSW" &&
 	test_might_fail git config --global --unset remote.origin.mediaImport
 '
 
-- 
2.28.0.297.g1956fa8f8d

