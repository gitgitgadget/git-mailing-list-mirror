Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA17BC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 11:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242691AbiEYL1B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 07:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241446AbiEYL0a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 07:26:30 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DA89CCA3
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:29 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i20-20020a05600c355400b0039456976dcaso2376651wmq.1
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=81i54p+ZvlCjphPi5WrP1T3usfVvTKA0/PaQjD9/9+k=;
        b=TNVZztJ//CIJBEWWcRxQAeh8GE/atpI6O281rN2L2j7AfY2FWGeFwp1mZgauKD1hFT
         kSTHpzenguMa9Rr1rQm+CsKIcpfc1Ehnz+arInWGFMHdaC7L+AnI5KVv6bcD89PYXrS7
         lCMBeJjtve1QwA8OP/fT/DienTpePZO1/1Ct+O8yPTEOMXXZgJ2oAlOMPiz3jr2aJ9Z5
         4fGYMi7aUPEd2Up6gTuYg2tVtR8r9bp7NQzDizHOHKt2wOleZVzSEzh4SqOrXmx1goLQ
         lOH4J3rHYtnM1e9uRYYBMY7Ig8Cvr6krDmQd90pZsbq/qN3mNHd/s1cW0UZwHB7WKFZ7
         SULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=81i54p+ZvlCjphPi5WrP1T3usfVvTKA0/PaQjD9/9+k=;
        b=OT9cRMOBhkPCJdXKXecKQk9c+RMdA6dldxwEo3yw1+C9PjlxnHDPPnOK9eILf4fGCz
         xZlTGmJebWCDblACvxawDNLqHrIOiSVM1IET3LoTpUzP5LidA875YRhemWuq0GxXzkXQ
         1zvdzEtgaHf7+/I5kunfDY2RrvfvlHtjziR6xL1ySTm3YUcUw4pMtKKH9bE4Qj5fnC6u
         PzsiJbngH/s9Bgs1kNHbKVGR1lT8zGXNY7FvUDo+2p7ekI36Qfo40HNwEVeZVKKk3bMF
         1p4WvL+MS6SyY9qShio46cdHZxqVE6MAq28hA6ood3fgR4sOTU2AFjihqX2sBE26xzrd
         vQ0g==
X-Gm-Message-State: AOAM532Du+e+vrbO++12b9J4EXVO+4Qoogt9xFQRrbhEGZWkjGtrap8C
        B4gyzDQCsDkjYTZMitbMSAtqcGjbhNNMXQ==
X-Google-Smtp-Source: ABdhPJyT4+5CTNocDzyN4lMSGfKcqQNGaFEm7OXiMvoWpVogzbtDfB22PpLW5ScOFUWRKf4LBPnu/A==
X-Received: by 2002:a7b:cf11:0:b0:397:33e3:87b2 with SMTP id l17-20020a7bcf11000000b0039733e387b2mr7739677wmg.152.1653477987807;
        Wed, 25 May 2022 04:26:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z13-20020adfd0cd000000b0020d0dfcd10asm1851095wrh.65.2022.05.25.04.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 04:26:27 -0700 (PDT)
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
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 08/14] ci(github): skip the logs of the successful test cases
Date:   Wed, 25 May 2022 13:25:57 +0200
Message-Id: <patch-v6-08.14-9c9fd24fffa-20220525T100743Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.14-00000000000-20220525T100743Z-avarab@gmail.com>
References: <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com> <cover-v6-00.14-00000000000-20220525T100743Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In most instances, looking at the log of failed test cases is enough to
identify the problem.

In some (rare?) instances, a previous test case that was marked as
successful actually has information pertaining to a later test case that
fails.

In some (rare?) instances, a previous test case that was marked as
successful actually has information pertaining to a later test case that
fails.

To allow the page to load relatively quickly, let's only show the logs
of the failed test cases to be shown. The full logs are available for
download as artifacts, should a deeper investigation become necessary.

Co-authored-by: Victoria Dye <vdye@github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-github-workflow-markup.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/test-lib-github-workflow-markup.sh b/t/test-lib-github-workflow-markup.sh
index d8dc969df4a..1ef0fd5ba87 100644
--- a/t/test-lib-github-workflow-markup.sh
+++ b/t/test-lib-github-workflow-markup.sh
@@ -40,6 +40,10 @@ finalize_test_case_output () {
 	fixed)
 		echo >>$github_markup_output "::notice::fixed: $this_test.$test_count $1"
 		;;
+	ok)
+		# Exit without printing the "ok" tests
+		return
+		;;
 	esac
 	echo >>$github_markup_output "::group::$test_case_result: $this_test.$test_count $*"
 	test-tool >>$github_markup_output path-utils skip-n-bytes \
-- 
2.36.1.1045.gf356b5617dd

