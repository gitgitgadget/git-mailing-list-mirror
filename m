Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C59C433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 21:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAFA82087D
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 21:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kA1X+RlI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgIPVBN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 17:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgIPQaY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 12:30:24 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7DCC061352
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:05 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x14so6286696wrl.12
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p53YYIlZ9Ykouq3lNDEqa/eH2lNKrF5GXZRj4455gEw=;
        b=kA1X+RlIcRzc1ms5LmOIgQyg57NsMLh21h3HsjOZSirVvjqQgE34t+1iGlbmlWnng3
         irAxYWMoUX2Hu+jBryPf/qr2i9FzUQHPad4yHRtLDv+q7uGE0hlTKkHDx4hTrm1aPSDP
         unI63ak1JysHo8CfHrrCN98ZTXInnmTM6xvv9OO/qF4jUWx6lEMwtXXzNzydE6RhvOkS
         SLDqTUE6NKz6qJBLDm8yMwPoVjF3YwZZgggmgPYTqev4hTDPEtvtwpiUyF9/3CN3q0ET
         xHtarhHb2w2PrcpCOlgQyiSiycEq+rTm8EB3axnH48etnTOQO0oyIFOYLEzBrsLr0BK+
         HCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p53YYIlZ9Ykouq3lNDEqa/eH2lNKrF5GXZRj4455gEw=;
        b=ez26A39gk4CcaJD2uOcY1hixHxHscGBz93VM7hdFPP37dep+Zfp1xEfhNY1MyrLqgE
         ASUSSSoLjKKg4VVg22m15NcnTObO5dS/No4nEHGmdJKpBGNiZNHQ6cxT9PP99B09JQIU
         ukkQZOSc9Ooh6pk6OCiq01IPrVc/+hOjrnIeJHNcchiiF1uMGXmtlcpEzB6ZqQeUI/1g
         KUsf2PMHwWpDd2s6xym3aAm2/2k8n5LpyMwsEFb9yY6XfjvSIiGafPMdHERUIce9AeC9
         fQao91MS0/1uu6xLkJZETkGMq6WHNh+C1+2gQltmx+/4XeAt0ul2m9LdYidg/szH81bu
         3KJw==
X-Gm-Message-State: AOAM533O0Pxb8Tc9A4bS1Wh87uyNP5UYSrcRX7U3cdS9kjylQQ57+3a+
        8QuubpZTNX7qzc+5l0FAH74Oq4MnE1Ny0PhN
X-Google-Smtp-Source: ABdhPJzPO/cyWJlX5egt3OrtMOR54gcGrMHiU6i+icnf4rX2aAoHLNFn5nmfGG6WCUUqlOVIhkmGLA==
X-Received: by 2002:a5d:6404:: with SMTP id z4mr27268774wru.423.1600252204309;
        Wed, 16 Sep 2020 03:30:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n11sm32172916wrx.91.2020.09.16.03.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 03:30:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        Simon Legner <Simon.Legner@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/15] remote-mediawiki tests: use a 10 character password
Date:   Wed, 16 Sep 2020 12:29:08 +0200
Message-Id: <20200916102918.29805-6-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In more recent versions of MediaWiki this is a requirement, e.g. the current stable version of 1.32.2.

The web installer now refuses our old 9 character password, the
command-line one (will be used in a subsequent change) will accept it,
but trying to use it in the web UI will emit an error asking the user
to reset the password. Let's use a password that'll just work and
allow us to log in as the admin user.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/mw-to-git/t/test.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/t/test.config b/contrib/mw-to-git/t/test.config
index b6fb0b3993..3ab56c7165 100644
--- a/contrib/mw-to-git/t/test.config
+++ b/contrib/mw-to-git/t/test.config
@@ -3,7 +3,7 @@ WIKI_DIR_NAME=wiki
 
 # Login and password of the wiki's admin
 WIKI_ADMIN=WikiAdmin
-WIKI_PASSW=AdminPass
+WIKI_PASSW=AdminPass1
 
 # Address of the web server
 SERVER_ADDR=localhost
-- 
2.28.0.297.g1956fa8f8d

