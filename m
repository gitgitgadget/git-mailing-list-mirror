Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66AAC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391432AbiDUSjk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391413AbiDUSjd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:39:33 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B61DFAE
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:36:43 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 17-20020a05600c021100b00393a19f8f98so979151wmi.4
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gerUcm0RQ7FKi3rPBSNYEkF1iOo7Dtn1rz8L3WP1hjk=;
        b=GYjdlhdqkFSf581tPiwQ7mgOuXcFjq14jTSgJWkcNH8IP3ZfFNLH8ijioYVRi/j4iA
         ijQJeMnMuHvlf60RS1zKp6VuwydNXD8KBx/fe4GF2Li5xOpF/LiczOFZWqF31VXrSxXy
         tM6cm8Loc5GeLM6LVCMu+2ueKHrFPPapTc8ZNOlwwrBuoBJ9Dy1B24jNrPUvMJbXXxm1
         HHg7twu3bgL6tSlKmAAWvDIZRytFKpKYsILAc5qEcbTaHB04EWjdbP3cBTTT6PB/TQhB
         T+NWamb4P8SZ9z2FyaeZl+YoQZr8E7/xG+6STqiDGktKHY8f9ASte3239O02neKt8tXA
         TMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gerUcm0RQ7FKi3rPBSNYEkF1iOo7Dtn1rz8L3WP1hjk=;
        b=DUuFp8219vAx7AyNXha436O058mVCwk55yKTk12jzUNCvA20Bf6VRgV8+jSxaQSPUy
         OZ0saAKv0PbFZNCA2SGhms8FUBZqFQLjre4+fl5I4xWip4khMAPiQ/SfWyb9rSspp2uB
         BDHbSt2C9+gTxPa1UQxCY0NY2ba1ht8BpDPQdeAmHXp/UgTR4RIHcAYZCAD7A4VqOhA5
         zShU+HbsFhJdCoHXCWEPkCx6VvD0KFS2uiOzf2QUihspx3i4kyOc8ECYtXMdtAQL7f8I
         3GzfwSf/tCL18hQoGlkoMcB/TEJHii30ggexEhREWNwF8+g+N/WfNcghJzJ6TpPdqSgx
         Pn2g==
X-Gm-Message-State: AOAM533+SSXdkE5ue+hCPepE9jC+K5oO7HUIXbAWkzjb3v93naKdPk5K
        HJLk89iMTKcAXYhsW6ocwFyOQ4pEGpnllQ==
X-Google-Smtp-Source: ABdhPJxRZ/RQCFuHcIIPiqvjgWnsCFkmIxfCbiHlg65LUQ5HG6QtQq/gGINYWOsqWpTiASEPWsTODA==
X-Received: by 2002:a05:600c:34c4:b0:38e:b628:da95 with SMTP id d4-20020a05600c34c400b0038eb628da95mr641074wmq.150.1650566201559;
        Thu, 21 Apr 2022 11:36:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o40-20020a05600c512800b0038ebf2858cbsm3108624wms.16.2022.04.21.11.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:36:41 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v5 04/10] CI: stop setting FAILED_TEST_ARTIFACTS N times
Date:   Thu, 21 Apr 2022 20:36:28 +0200
Message-Id: <RFC-patch-v5-04.10-1482f840f64-20220421T183001Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com>
References: <RFC-cover-v4-0.6-00000000000-20220413T195514Z-avarab@gmail.com> <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com>
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
 ci/print-test-failures.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index 23324021f13..27df5081f8b 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -49,7 +49,6 @@ do
 		case "$CI_TYPE" in
 		github-actions)
 			mkdir -p t/failed-test-artifacts
-			echo "FAILED_TEST_ARTIFACTS=t/failed-test-artifacts" >>$GITHUB_ENV
 			cp "t/test-results/${TEST_OUT}" t/failed-test-artifacts/
 			(
 				cd t &&
@@ -62,6 +61,11 @@ done
 
 if test -n "$failed"
 then
+	if test -n "$GITHUB_ENV"
+	then
+		echo "FAILED_TEST_ARTIFACTS=t/failed-test-artifacts" >>$GITHUB_ENV
+	fi
+
 	if test -n "$exit_code"
 	then
 		exit 1
-- 
2.36.0.879.g3659959fcca

