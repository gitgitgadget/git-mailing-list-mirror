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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7448C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A09FD6109E
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352028AbhIHPZn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 11:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348652AbhIHPZj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 11:25:39 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70FDC061757
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 08:24:30 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n5so3845227wro.12
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 08:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t5LbAozKjshRVXrGUscdqiWPP24wJcMZ3huXfGwYW8k=;
        b=i3/6PKNQfEoWBv69S4Bom4uHYNWk0Q9MbWamGe9nkLPOB8BkJM3Hqh+lUz4pJD+4om
         blJK7amZRhkyx6pjslRBbo7zHPNYxT4quleNFAFGBgGoCJTJOyw+5LHR0nNuoANpnG2v
         iXB/A4bAGsA2uxfnhFEA7yT7GjzrUx5fW4og/2e7S0WCTXeLxisLOoHEtX/xTPGPn0T7
         hm34fQsty8lStJat/74gFSMlx8emA3WS3Xou6nwzsChzjfx/6Wt+xt5omllyuyPYYd8b
         J+X5yMYaYzG4yB0BdZjsRM8lJjIjTzMjydAjcqFWmEtOu/n4Us7JcWi+LW09/cJezybz
         6y5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t5LbAozKjshRVXrGUscdqiWPP24wJcMZ3huXfGwYW8k=;
        b=te/njrQ5iZZuCm9JiwjiHtztQZPv0aJ6EpiS5U1wqnLhQbNQG/x8KUwLB0WR5XnD9T
         dpBnH/5HKZRFcsaJs6toV1kegAihdUItuzGQCMHF/KP2DoUySvA9/mt0lQ12pcjTdSuw
         4DZ1WBu+sdG1NQsIIQucX+2myxK2+qRhaCVuM7dOv7I/OYRRhDgHedaIPk6BxsaJXXZm
         sZLeoUjypnXQHBBNMpI9PECb+pWKyLwPDmCWxCS7Rz6x9CyVyorXQ4UBH7AbmXMez5jt
         mIpfJKMqf2wP7A4LoflAfSGUeEIxn9jRa5ZUJAOQ0iRJFQzJevE/s0FGE3242ZQSYeiy
         83/Q==
X-Gm-Message-State: AOAM531nvAgUJtqaXqen5er7j0kGCcgur6Uq2EafWC3NSSeTiqlD0/pg
        WQIc/73vTVLDrxy+fMq4mzoAtmuX+bHx/w==
X-Google-Smtp-Source: ABdhPJzKa2mRhZype1ni72rkPWUcnMLzOG9wdBKKIwYdw5+C+GJtU+MV9KNgX5MXYvfnuILzh77LFg==
X-Received: by 2002:adf:fc43:: with SMTP id e3mr4684809wrs.436.1631114668760;
        Wed, 08 Sep 2021 08:24:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x21sm2365240wmi.15.2021.09.08.08.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 08:24:28 -0700 (PDT)
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
Subject: [PATCH 3/6] help tests: add test for --config output
Date:   Wed,  8 Sep 2021 17:24:19 +0200
Message-Id: <patch-3.6-d0a8045c9ed-20210908T151949Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.825.g2bf60429931
In-Reply-To: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a missing test for checking what the --config output added in
ac68a93fd2 (help: add --config to list all available config,
2018-05-26) looks like. We should not be emitting anything except
config variables and the brief usage information at the end here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0012-help.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 6e01da614f0..94d1f481c8b 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -78,6 +78,19 @@ test_expect_success 'git help -g' '
 	test_i18ngrep "^   tutorial   " help.output
 '
 
+test_expect_success 'git help -c' '
+	git help -c >help.output &&
+	cat >expect <<-\EOF &&
+
+	'"'"'git help config'"'"' for more information
+	EOF
+	grep -v -E \
+		-e "^[^.]+\.[^.]+$" \
+		-e "^[^.]+\.[^.]+\.[^.]+$" \
+		help.output >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'generate builtin list' '
 	git --list-cmds=builtins >builtins
 '
-- 
2.33.0.825.g2bf60429931

