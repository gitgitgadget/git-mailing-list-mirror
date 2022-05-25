Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1764EC433FE
	for <git@archiver.kernel.org>; Wed, 25 May 2022 11:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242030AbiEYL0d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 07:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237020AbiEYL0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 07:26:25 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C139CCA2
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:24 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k30so29681100wrd.5
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8mblGx6pFdQlsypWTrdNcDZYS6qoOJE6NOKFvWW6TxA=;
        b=AfbXvJabA9w5aNpl+DynxX4PEcSnKddMWejc8nwQ4HtFV8uJfNAi+ld5zb3JE5VPOi
         v6M+nEMsG3z8t07S0MJoD6xMEJCNX1DgOw/oIZ7yVBXz1llVypTNhUNnpHvcL+vTy5XF
         4C/xtP/fa8GdlnF4ZKDTNsOm05WvshUmbue8Xctdy3s/uyVT+0aExoV0euzUTdm2aphE
         LYhG54tfpUI40v4LkyLk5mZ2j8GBkMpoDO5MyfjUzt4og0x9YhmlNavOox4uAKyO/bDW
         GuCGO9QiasQIuZLUBAzWIUJhGZdPuz/kgR9O2pmZy3NrZDwcNEehjsJzcvHMwevaj0ZO
         fBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8mblGx6pFdQlsypWTrdNcDZYS6qoOJE6NOKFvWW6TxA=;
        b=WLcj04GNy3aZpx08TyIVnh1l5Hq1h4+VbL5TkVQIW8tOdWeiGk8A/FzviT/Qda1Z+3
         7Llbgg0x+rSPoGRstqaeI9Twcrz9EBYmpdd7RteZpn90r2RSUh7QKR+sb4rgB22ZfOTf
         Kbtx2vd52cnNTzjNMJo8lfO87eVw487vx2OoQoYuOSOFTzCYoMUjAwM+/+X2TXe+YQwS
         WoxfBqglSxeWNx4ORP5qaPuRzuNUdwv/xDyZOY8GeznpECP40v6ELPHEP1wUU1+G4rJX
         CW1FIas5fd+ZdGBOw5qeBqymEM1gWBAs+XTTY9SLSV+G+xsJFaNxEUx6CXpn67mOyld/
         0NmQ==
X-Gm-Message-State: AOAM531iXqBQL7Fbg6VOLtOzp/KdUOO0o1KcZdnfC6JJMPkZBMfzndYd
        gK17iPi2L2PL8M/5lZSd1sYjNrYMlTRILg==
X-Google-Smtp-Source: ABdhPJwL0E9yogVBm3ily6lWoLodD7iS2iVk65xwUKwVXm3i6BCrb47HhvOc9C/wVv+oCfEPAS1pNQ==
X-Received: by 2002:a05:6000:1546:b0:20f:c62a:b0e with SMTP id 6-20020a056000154600b0020fc62a0b0emr16640536wry.283.1653477982710;
        Wed, 25 May 2022 04:26:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z13-20020adfd0cd000000b0020d0dfcd10asm1851095wrh.65.2022.05.25.04.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 04:26:22 -0700 (PDT)
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
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 03/14] CI: stop setting FAILED_TEST_ARTIFACTS N times
Date:   Wed, 25 May 2022 13:25:52 +0200
Message-Id: <patch-v6-03.14-fdc5b534644-20220525T100743Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.14-00000000000-20220525T100743Z-avarab@gmail.com>
References: <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com> <cover-v6-00.14-00000000000-20220525T100743Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The FAILED_TEST_ARTIFACTS variable introduced in f72f328bc57 (ci: let
GitHub Actions upload failed tests' directories, 2020-04-11) is only
used once in the main.yml, there is no need to set it N times if we
have N failing tests.

See also 92bf1b60673 (ci: avoid `set-env` construct in
print-test-failures.sh, 2020-11-17) which moved it to using
$GITHUB_ENV, we'll now check if it's set like ci/lib.sh, this makes it
easier to test this script locally.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/print-test-failures.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index 1249bb0c0cf..8d4d2225371 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -32,7 +32,6 @@ do
 		case "$CI_TYPE" in
 		github-actions)
 			mkdir -p t/failed-test-artifacts
-			echo "FAILED_TEST_ARTIFACTS=t/failed-test-artifacts" >>$GITHUB_ENV
 			cp "t/test-results/${TEST_OUT}" t/failed-test-artifacts/
 			(
 				cd t &&
@@ -42,3 +41,11 @@ do
 		esac
 	fi
 done
+
+if test -n "$failed"
+then
+	if test -n "$GITHUB_ENV"
+	then
+		echo "FAILED_TEST_ARTIFACTS=t/failed-test-artifacts" >>$GITHUB_ENV
+	fi
+fi
-- 
2.36.1.1045.gf356b5617dd

