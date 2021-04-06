Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F227DC433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 14:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C978A61399
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 14:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344834AbhDFOA5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 10:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbhDFOA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 10:00:56 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5873FC061756
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 07:00:48 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o20-20020a05600c4fd4b0290114265518afso4562189wmq.4
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 07:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ktwW0UL4la9TjUNgfJsFb8356bjPWIHqOPL3YdaolNU=;
        b=Go5x8NV1fAkbvl4BCB59kD1Gid/ZJ7rqsFbMOlz0YgQjQr+pdtL9GHaqA385aAVJ9h
         X+xm1ziunvaTDxrv9HuctAabzTPQ+OyFMM+g0gXRmRw6HtymrQVCUIiPhzJpqdqIlGdC
         vgyP1tO2FAwFrwHkvYzUsTJHmDWIvoQMTGpPb84o0EgcRmHEZgTMWHaI4EJgpFzM4HCv
         2YCYtp9YJXjLNKPozle+xzXsRFw+UZh/VsI3c0ggvSf17DLfISeMDxj3B6NSANgeRbHJ
         Nx8JPXD3aTASXFjeAOF5uBC7tiXOTn6yWQCIQASJvPfXrifmqMQWcmmnrx8NuMJS3PfM
         JQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ktwW0UL4la9TjUNgfJsFb8356bjPWIHqOPL3YdaolNU=;
        b=n0U4IP8caO6I5AWF44l2e4xmM8ZuDb5xDivSLW6Ejg+HU7MzR/Hmi9OP/mwkxq3QGm
         nXXwpdAQdxpyf1xYbR2vdTybURknnr4ozv7SUwm3QUKBMhp+RtAqHZRfSfMG6QKNIQVw
         zrbTt32/XfnhjIqC7izd5gg7qR4nmVAwhapyXHlEkrs7sfV9Q6FkJUI5OTPjsFxW1D9+
         CBCWA76X78aOulpS74QliXUxSoKuU5EHABQLY33F4kT8dwN1w2DO21SdmhIES7AeuOO3
         aQ6P+0M2Nw0TpG7EpcjUIGq9VBsgE/jze0pg+bz7t3KpBHlHB3OHoegTOyHZZMB0g5FY
         5Mww==
X-Gm-Message-State: AOAM531zNiI25ccAKlAEghtESZ6kNOjHV3iTKeKgOOUQJDxuuet3gVfF
        JSZCaicp2jvRFtWWBvBq0pIAcS5Of9U=
X-Google-Smtp-Source: ABdhPJxqc7JQvG/b+NhGlt33D5ASBMPTP7NrFD3m191pNn/DZdiMXKZ8dguWI1Xj8+LeGA1DugFnBg==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr4324888wmc.90.1617717646790;
        Tue, 06 Apr 2021 07:00:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h6sm20029696wrr.21.2021.04.06.07.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 07:00:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/3] git-send-email: test full --validate output
Date:   Tue,  6 Apr 2021 16:00:35 +0200
Message-Id: <patch-1.4-6e1009e5bed-20210406T135716Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.527.g9b8f7de2547
In-Reply-To: <cover-0.4-00000000000-20210406T135715Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210404T091649Z-avarab@gmail.com> <cover-0.4-00000000000-20210406T135715Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the tests that grep substrings out of the output to use a full
test_cmp, in preparation for improving the output.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t9001-send-email.sh | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 1a1caf8f2ed..74225e3dc7a 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -422,8 +422,12 @@ test_expect_success $PREREQ 'reject long lines' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		--transfer-encoding=8bit \
 		$patches longline.patch \
-		2>errors &&
-	grep longline.patch errors
+		2>actual &&
+	cat >expect <<-\EOF &&
+	fatal: longline.patch: 35: patch contains a line longer than 998 characters
+	warning: no patches were sent
+	EOF
+	test_cmp expect actual
 '
 
 test_expect_success $PREREQ 'no patch was sent' '
@@ -527,9 +531,13 @@ test_expect_success $PREREQ "--validate respects relative core.hooksPath path" '
 		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		--validate \
-		longline.patch 2>err &&
+		longline.patch 2>actual &&
 	test_path_is_file my-hooks.ran &&
-	grep "rejected by sendemail-validate" err
+	cat >expect <<-\EOF &&
+	fatal: longline.patch: rejected by sendemail-validate hook
+	warning: no patches were sent
+	EOF
+	test_cmp expect actual
 '
 
 test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
@@ -540,9 +548,13 @@ test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
 		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		--validate \
-		longline.patch 2>err &&
+		longline.patch 2>actual &&
 	test_path_is_file my-hooks.ran &&
-	grep "rejected by sendemail-validate" err
+	cat >expect <<-\EOF &&
+	fatal: longline.patch: rejected by sendemail-validate hook
+	warning: no patches were sent
+	EOF
+	test_cmp expect actual
 '
 
 for enc in 7bit 8bit quoted-printable base64
-- 
2.31.1.527.g9b8f7de2547

