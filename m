Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCAEC48BE5
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 032CE611C1
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhFWRuy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhFWRut (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 13:50:49 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701CCC061756
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:31 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o22so1255596wms.0
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KGz5Vtx/XB3gd8CrUge3ne227L+ET6i5mI1HGXPkF58=;
        b=ioxfOfgnKZsJpdpR8swSNXrhQ196mnEUKIpEfu6LIK2aUWiE8auiXNTbu1T3wFrL6f
         ZoN6sjyw/I61SVqxKLLlaKdW24wdWeKUC/615w290JUCOnfbMnxYRF9a/96/k7uoJGRu
         z2Lxl7W/z3sBCPUaK4KLa6Vxy93o5EvZzuY/3QByWVv9HIdV30LHCbGCkkXI5SHhxL+F
         gh0wi3kMP3/5HXxwnGgARE40zUr2zW/XekmYGmv41beBnaxYYcZ4GlAO34KL+pP7H+UE
         CwARNcUKIgisrDVf/Rz8+VcVXJtV71QDO+R4DBM0w7QMaYEITfZl0Ge3C49owlytakGZ
         3zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KGz5Vtx/XB3gd8CrUge3ne227L+ET6i5mI1HGXPkF58=;
        b=dUn++0PHQdZ0AS0UkMPSncIQNsB/AHHkBJYLUD45o9Dy0NZ9gu3bXlPkTvXipnNa/S
         dJHFf5agLJkA9MVxRNCn05q5rEysSuTPTJMGqW2DtCkuefnvM4+aktbj1CYifN78etGE
         OgOnMYVqAWJIs23riexsWrRp9B0bwRgQcJ3byKhryl8DL/WKfFq62/vmzz+l9XerYF8P
         XhYZoA2Q0a7m2AH5lffc6ePQupYh1gJMMqNHTGtHXCWzPE+pmBMDfFIJOZLPhLhlNqtU
         NTwlU9Xn94HI85lS/xxZOdyIVghpTVt/nUvrmaz5hy7TjlDEP3mzljhRdfHrZrH8yjC0
         wHHg==
X-Gm-Message-State: AOAM531+a113jCMY2K/JdA04gGNBUBNFTU3R5RiUoE0Lxclt/F+MdIVJ
        tJai/ZNCJ2yXlgrmVrZfM17+Cel35RY=
X-Google-Smtp-Source: ABdhPJz/4VQbMBSBPQnuW0sjCTXSaxU7bl+tZdDsN1Ojlksa68GybXaoj1LPbObrxKn5dh3Kml+upA==
X-Received: by 2002:a05:600c:198f:: with SMTP id t15mr12297040wmq.27.1624470509771;
        Wed, 23 Jun 2021 10:48:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x25sm6678281wmj.23.2021.06.23.10.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:48:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/25] progress.c tests: fix breakage with COLUMNS != 80
Date:   Wed, 23 Jun 2021 19:48:01 +0200
Message-Id: <patch-01.25-cba5d88ca35-20210623T155626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
References: <YNKWsTsQgB2Ijxu7@nand.local> <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tests added in 2bb74b53a49 (Test the progress display, 2019-09-16)
broke under anything except COLUMNS=80, i.e. when running them under
the "-v" mode under a differently sized terminal.

Let's set the expected number of COLUMNS at the start of the test to
fix that bug. It's handy not do do this in test-progress.c itself, in
case we'd like to test for a different number of COLUMNS, either
manually or in a future test.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0500-progress-display.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index 22058b503ac..66c092a0fe3 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -8,6 +8,11 @@ show_cr () {
 	tr '\015' Q | sed -e "s/Q/<CR>\\$LF/g"
 }
 
+test_expect_success 'setup COLUMNS' '
+	COLUMNS=80 &&
+	export COLUMNS
+'
+
 test_expect_success 'simple progress display' '
 	cat >expect <<-\EOF &&
 	Working hard: 1<CR>
-- 
2.32.0.599.g3967b4fa4ac

