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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CB6C433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2B7123102
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438149AbhALVhm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436890AbhALUTz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 15:19:55 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE2AC061575
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:59 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id e25so3335368wme.0
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uhSlRfILJOy/AuRh3HA96omy9eVjPDse/iZzuXuS2Dc=;
        b=L5mSRoKe68qofdoQfunFUVxPyaOP6La52kOHwW3ivgjDGEtCmztkdc0Aaou0tn0tUk
         djGabJYn59pHy6/+03uRQpXdRnm6uhgA5urZkAbWG5tabwkGL/l7EG8+wIJid42I8zKp
         EniL1xOjha7RFyJDyHCX2KjOOMrUZYlU3uml1jpFEcwfhPfDsSzE/62cQKw/HEPJdxn6
         m76RwQqxqLXLH9QQdT+YK+HFc7CONgPfsM77wCznH6lzOaxAqVIN+SuwpB0fTGLxNbZb
         e5vXK6FGT51nvMP86nl9ICsDGb+jGD1dWO+kVa/IOv8M/1Qui0Z7I7XostSEZRFB86dN
         a0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uhSlRfILJOy/AuRh3HA96omy9eVjPDse/iZzuXuS2Dc=;
        b=ZKHvk7OxeAz8ZxZLLSl8hedMEhb1KPPD40gZEZUlm9cGYFDNUf1pavQbFoAGTSLTPC
         ag8LnLrAfizaSijz48LqIYMFRl/0B64UdN6fhSOciGSanzQCRk7DXbzKV0k8IWom+jAs
         dWAl9gVr1Vn41k6qGXfqkLd66mmBtB1WOTae9fkwwwcn6rPGouLZSpaasHG9vKqQ41oQ
         y8yISQabbAQlh9fOi6lF9CKTrFWWb+qCjY2iKzk7gzUp7knLKoY8vd4/9pGuYTOGIwws
         kw3p2A9KG3caNCYH87wwi15EVnHpXTBigm8DftuLm8tYMbjH4cFBH8DwwmTmAGtELKMR
         Tvfw==
X-Gm-Message-State: AOAM530ZpBFAINTrX+W7SLNgq1ZPb4VcpB6z+v6Bcm3o2j8V6IWAqKPy
        cmblMwQF0F0vd0v5aPUwrdd60sFuE0HaEw==
X-Google-Smtp-Source: ABdhPJyrOImJnA8eqJQQ7W3al95alD1cVq8rvXrdrRhTb6e1b3Qt/9TsRFv5SwDsttQ3ogCkcDQ7FA==
X-Received: by 2002:a7b:cc90:: with SMTP id p16mr822583wma.105.1610482738228;
        Tue, 12 Jan 2021 12:18:58 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c10sm7095374wrb.92.2021.01.12.12.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 12:18:50 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 20/22] mailmap tests: add tests for empty "<>" syntax
Date:   Tue, 12 Jan 2021 21:18:04 +0100
Message-Id: <20210112201806.13284-21-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210105130359.21139-1-avarab@gmail.com>
References: <20210105130359.21139-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests for mailmap's handling of "<>", which is allowed on the RHS,
but not the LHS of a "<LHS> <RHS>" pair.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4203-mailmap.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 4f61655c04..f19736fef1 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -838,4 +838,31 @@ test_expect_success 'whitespace syntax: setup' '
 	test_cmp expect actual
 '
 
+test_expect_success 'empty syntax: setup' '
+	test_create_repo empty &&
+	test_commit -C empty --author "A <>" A &&
+	test_commit -C empty --author "B <b@example.com>" B &&
+	test_commit -C empty --author "C <c@example.com>" C &&
+
+	test_config -C empty mailmap.file ../empty.map &&
+	cat >>empty.map <<-\EOF &&
+	Ah <ah@example.com> <>
+	Bee <bee@example.com> <>
+	Cee <> <c@example.com>
+	EOF
+
+	cat >expect <<-\EOF &&
+	Author A <> maps to Bee <bee@example.com>
+	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
+
+	Author B <b@example.com> maps to B <b@example.com>
+	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
+
+	Author C <c@example.com> maps to C <c@example.com>
+	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
+	EOF
+	git -C empty log --reverse --pretty=format:"Author %an <%ae> maps to %aN <%aE>%nCommitter %cn <%ce> maps to %cN <%cE>%n" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.29.2.222.g5d2a92d10f8

