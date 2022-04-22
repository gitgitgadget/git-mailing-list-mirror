Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EDBC433FE
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 09:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbiDVJRA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 05:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445855AbiDVJKi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 05:10:38 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0AB51E6E
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:07:45 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v12so3300839wrv.10
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WAofSxgNZM/NsWsnBvdlUXY92iBc6eKlrtlstoIyNy8=;
        b=ccl0zRGIcc3dbn/PH3et509ZPy4R6D3yawOo1f98mHBwJVoRYpZDgZX3cgoqeoOazv
         xyHxekg64YuSy4gm98TNtgb11Vdj1PyhxBlBO2AtUxdiT3DpN9SLyRFTYwpvKz3t4Eh/
         rbLpQEEDNPdq99TExT3uVgGmGQFUqRI3xYN3C2oNg7ggZitJ0zInF4rLA3Qibkbfl8ig
         70EZmmc70QQNwx6ohdq5W+ApFbgzaT6gka6YrSsQOov/f17UGf5e3eFiheycGLYWQ3g8
         +6jVNr6qNOiXeRlUIhvWt3hblOyej+K0VGFRFk9CRoHgtiX1VRzGcO+VcFx0BIrdQ3al
         E30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WAofSxgNZM/NsWsnBvdlUXY92iBc6eKlrtlstoIyNy8=;
        b=A2xdq21NZYxWCVP7bbeIoCv8loiuTDxnREd+3yQNNppVQaFQdWlS2jeQ4FP80YiQfN
         m1BWa6jOuyMlJaQQnqp9cvZiyELky3M56AprVVFEC79ThXlD6K4RMQuLokycB7aWXNmf
         ERc4kcsz1MgsyOIGZzPzda/0MCumiUVUGIb8xqDiDq7eouEZE23YMtraj+cs6GtaXmQd
         YF/go3OstzUcEUs0mN5ydwoc1QYky6PcWXQh9/t0kjDgikeHVEXSmOdogFnJ6XQeaNw5
         vNfICGINDA15gWBbEuCimzIFOyQAHP/0PnTVXq6SDpd3QPH3mK5e8ETEGC1dRuNMZV7Z
         m2DQ==
X-Gm-Message-State: AOAM533vhYlkJO18Vtotkg72TGZvuqlbBlRxPg9UaeSk5HVM3osPCkxp
        c/5pjX7IfsSw9hLDv3lt+hcWrjsH+/AFbw==
X-Google-Smtp-Source: ABdhPJyGE+2cPo7WrULvdJkNKI9thBhWSp37b+CERozUQKs4R9/LjWY6UkMWfgz2nvCAKaEVs//Ugw==
X-Received: by 2002:a5d:6487:0:b0:20a:a575:c136 with SMTP id o7-20020a5d6487000000b0020aa575c136mr2896121wri.402.1650618464120;
        Fri, 22 Apr 2022 02:07:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n68-20020a1c2747000000b0038e6b4d5395sm1282700wmn.16.2022.04.22.02.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 02:07:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/3] CI: run "brew install perforce" without past workarounds
Date:   Fri, 22 Apr 2022 11:07:37 +0200
Message-Id: <patch-v2-1.3-dcedf03c2d7-20220422T085958Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g56a83971f3f
In-Reply-To: <cover-v2-0.3-00000000000-20220422T085958Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20220422T085958Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the alternating between --no-quarantine, --cask and fallback
"git pull" updating of the "perforce" package.

As can be seen in [1], [2] and [3] these were workarounds for various
past CI issues. Running "brew install perforce" works now in GitHub
CI, so there's no need to alternate between package names, and the
"git pull" method was a workaround for some staleness issue on the
Azure pipelines removed in [4].

We do have a really common issue with this failing, but that's
unrelated to any of those past fixes, and removing these old
workarounds makes dealing with that a lot easier.

1. 0eb3671ed96 (ci(osx): use new location of the `perforce` cask, 2019-10-23)
2. 5ed9fc3fc86 (ci: prevent `perforce` from being quarantined, 2020-02-27)
3. 3831132ace6 (ci/install-depends: attempt to fix "brew cask" stuff, 2021-01-14)
4. 6081d3898fe (ci: retire the Azure Pipelines definition, 2020-04-11)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/install-dependencies.sh | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index dbcebad2fb2..82fa87f97af 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -37,13 +37,7 @@ macos-latest)
 	test -z "$BREW_INSTALL_PACKAGES" ||
 	brew install $BREW_INSTALL_PACKAGES
 	brew link --force gettext
-	brew install --cask --no-quarantine perforce || {
-		# Update the definitions and try again
-		cask_repo="$(brew --repository)"/Library/Taps/homebrew/homebrew-cask &&
-		git -C "$cask_repo" pull --no-stat --ff-only &&
-		brew install --cask --no-quarantine perforce
-	} ||
-	brew install homebrew/cask/perforce
+	brew install perforce
 
 	if test -n "$CC_PACKAGE"
 	then
-- 
2.36.0.879.g56a83971f3f

