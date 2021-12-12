Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52185C433F5
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 20:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhLLUOg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 15:14:36 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:41720 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhLLUOf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 15:14:35 -0500
Received: by mail-wr1-f52.google.com with SMTP id a9so23824369wrr.8
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 12:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c1bO76HdOOrrCzb1mD2q8hBPK1gx/Q34LnpGATNqiEw=;
        b=mRufZ3LXZ0SS2WKgUNVoToSCPtLcpjN26tVKe6CVtjY4Sn+pHLYctZftpn6vADNrdC
         jaflRqSDZ2apw1oa164rhROcdztWHGtlafFygzczEx5ihVhZ0SpFpFd8nAGQFm/79MX+
         oRoprlV4X0U7+2BJDhc4/fHvARuuhvsGqInE8bjl1ZzjcL193ls8PVf69azMRGaBJI1l
         caGfVOXY5UVOY0AKDrQJKNyt0dShfcNFvD0vsIErXzkTm/kA/mOgoIcQGuctzrMIk5sk
         sDCNiGFf2OBCm5rBPpZxrgymyJccE5/dQDRU5mE3xGbSUsD8AXoA9eaSDrrnkWj412uH
         66gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c1bO76HdOOrrCzb1mD2q8hBPK1gx/Q34LnpGATNqiEw=;
        b=Nwhbcd17idTKXBmxn4ZNMdyIMIjPZmadZc6HWVVvL480lRER85HwivG6mVg0OKJH5y
         fOMdiGHV58sfLr6AlgWvDf5r2hpX0IFtFh1FxKOM71IH53eAEf6KqLeAAG8ADBmkYFS2
         po5BGRnIQibCAvno4mSjD4CDh9aCAZqMgk9pgszdvMjW9ctbgqwO5kI80UsDBPElsOaS
         NMm+JeriWZtmLEE30jBav/40rlGYbelsNnCpu46xyLyAE1piYFNjmqpLGJCP++QIcniX
         2EAXfH+cveLleFmPhTo/1GNTFOpPfXBax8U9xhvfX4Dk0uGj11dZ8UYLLO10Qet8qcfF
         Rxyg==
X-Gm-Message-State: AOAM530uWWL46QeOmseYSzYPfdpj1yBOFCx3keLMBx7YmS2JXfKyFju0
        Za1PqoQLtFG30G77sYBA+CMLxBPLUkcGKQ==
X-Google-Smtp-Source: ABdhPJyemHhYUlHkhfJokuKtmKoSw/0rEYIk1to7ETwF2a7L1bEdAmZVPQcS0x/KloBACff6ZGf0Rw==
X-Received: by 2002:adf:8bda:: with SMTP id w26mr27539004wra.534.1639340013976;
        Sun, 12 Dec 2021 12:13:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay21sm4824336wmb.7.2021.12.12.12.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 12:13:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/13] t0001: fix gaps in "TEMPLATE DIRECTORY" coverage
Date:   Sun, 12 Dec 2021 21:13:11 +0100
Message-Id: <patch-01.13-5526d3dc838-20211212T201308Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1020.gb1392dd1877
In-Reply-To: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests to assert that the priority order described in the "TEMPLATE
DIRECTORY" section in the "init" documentation is correct.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0001-init.sh | 85 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 3 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 7603ad2f82b..e0b965cdc8f 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -173,6 +173,55 @@ test_expect_success 'reinit' '
 	test_must_be_empty again/err2
 '
 
+setup_template_priority() {
+	test_when_finished "rm -rf template" &&
+	mkdir template &&
+	touch template/file &&
+
+	test_when_finished "rm -rf template2" &&
+	mkdir template2 &&
+	touch template2/file2 &&
+
+	# Created by the caller
+	test_when_finished "rm -rf repo"
+}
+
+test_expect_success 'usage priority: --template only' '
+	setup_template_priority &&
+	git init --template=template repo &&
+	test_path_is_file repo/.git/file
+'
+
+test_expect_success 'usage priority: --template takes precedence over GIT_TEMPLATE_DIR' '
+	setup_template_priority &&
+	GIT_TEMPLATE_DIR="$PWD/template2" git init --template=template repo &&
+	test_path_is_file repo/.git/file
+'
+
+test_expect_success 'usage priority: --template takes precedence over init.templateDir' '
+	setup_template_priority &&
+	git -c init.templateDir="$PWD/template2" init --template=template repo &&
+	test_path_is_file repo/.git/file
+'
+
+test_expect_success 'usage priority: --no-template takes precedence over init.templateDir' '
+	setup_template_priority &&
+	git -c init.templateDir="$PWD/template" init --no-template repo &&
+	test_path_is_missing repo/.git/file
+'
+
+test_expect_success 'usage priority: --no-template takes precedence over GIT_TEMPLATE_DIR' '
+	setup_template_priority &&
+	GIT_TEMPLATE_DIR="$PWD/template" git init --no-template repo &&
+	test_path_is_missing repo/.git/file
+'
+
+test_expect_success 'usage priority: GIT_NO_TEMPLATE_DIR=true takes precedence over GIT_TEMPLATE_DIR' '
+	setup_template_priority &&
+	GIT_TEMPLATE_DIR="$PWD/template" GIT_NO_TEMPLATE_DIR=true git init repo &&
+	test_path_is_missing repo/.git/file
+'
+
 test_expect_success 'init with --template' '
 	mkdir template-source &&
 	echo content >template-source/file &&
@@ -187,11 +236,15 @@ test_expect_success 'init with --template (blank)' '
 	test_path_is_missing template-blank/.git/info/exclude
 '
 
+no_templatedir_env () {
+	sane_unset GIT_TEMPLATE_DIR &&
+	NO_SET_GIT_TEMPLATE_DIR=t &&
+	export NO_SET_GIT_TEMPLATE_DIR
+}
+
 init_no_templatedir_env () {
 	(
-		sane_unset GIT_TEMPLATE_DIR &&
-		NO_SET_GIT_TEMPLATE_DIR=t &&
-		export NO_SET_GIT_TEMPLATE_DIR &&
+		no_templatedir_env &&
 		git init "$1"
 	)
 }
@@ -214,6 +267,32 @@ test_expect_success 'init with init.templatedir using ~ expansion' '
 	test_cmp templatedir-source/file templatedir-expansion/.git/file
 '
 
+test_expect_success 'init with init.templateDir=does-not-exist' '
+	test_when_finished "rm -rf repo" &&
+	(
+		no_templatedir_env &&
+
+		cat >expect <<-\EOF &&
+		warning: templates not found in does-not-exist
+		EOF
+		git -c init.templateDir=does-not-exist init repo 2>actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'init with init.templateDir=[bool]' '
+	test_when_finished "rm -rf repo" &&
+	(
+		no_templatedir_env &&
+
+		cat >expect <<-\EOF &&
+		warning: templates not found in false
+		EOF
+		git -c init.templateDir=false init repo 2>actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'init --bare/--shared overrides system/global config' '
 	test_config_global core.bare false &&
 	test_config_global core.sharedRepository 0640 &&
-- 
2.34.1.1020.gb1392dd1877

