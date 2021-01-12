Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384E4C43332
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE3EB23122
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438045AbhALVhT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436855AbhALUTa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 15:19:30 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D15C0617BB
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:48 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id y187so3318890wmd.3
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1/KwABnLhIWPuW6zI9VQL7LiE4m978JsQXxUfjG0lXY=;
        b=uLjAhUQLu6Kl32mdVqeLVHkw7d4My29L6Etlfx1gRZImQATODqqOKHGuQCjA43hX65
         irV+CE+ag1CQb/0KmTtOWae4BcypYhcIPnhwsB16GQL1coKg+mGsqjgeqqa1C8FwQhiQ
         lshszjndiJ/S00dN0cOMEDso3cC5uK3WKBzIQ0Q7w1rkFJTQFIfCEckw5h1PrJM+vmsj
         bO9AjxK+ijCvOpbi2GAGWfsFLHcenG5s1O4ro8wAx2fjrPYSfDU5vLmFG2U25L5Rmeqz
         VGlw3cB4Jn/CiKk0QBCi+Sjkm60U+hbDqLzagZxisIEM3J4/aLqv0csWC9BjSXFdtjHY
         ZtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1/KwABnLhIWPuW6zI9VQL7LiE4m978JsQXxUfjG0lXY=;
        b=JvXr9BrakD/HDlJF7fKJMSeEKGqTqY7lTMm4E2dwk5S6SB2dAIdQKyP2ipkZ6zTvPz
         dGouOlLhOXCkUUi9lIElrNUg1XEH+hNt1sqG5kPXq9RVa3PHkxItXxhJuBGypOKfRnmm
         x9ZaVKReuVIbI3RihD/4++OQnkpvk8vu2oA2wXUfndINmu/ghBAZcZp5aCnf8b9Xde3J
         4g3bKcpuOLNYJOnh7KOsxYtuwFM0YgQgk3+flCto4n3NmGqUFS7Vx/NNRsElgX6PYSFk
         7JxjLl0W7MZsQDuOi5EBz0dYAU3wUIRp+fHmYjGWyqXzfSGE0O1ng9mGbWJ17VeAvsVk
         5t0Q==
X-Gm-Message-State: AOAM531FodpZxmTAanFJoqvE5kX9BQVZGAloooHKHrlVpMbux9CPPjyN
        ZY8pTcwz+wzCO2Cc2ec+2EMCl2d8ITnjOQ==
X-Google-Smtp-Source: ABdhPJxbvxDw/dnFykY6Fxewv1eaJXo5ZdGEfvWZc/gMZSob1zcaRVJ+8TH2KVBmZvL82FTi5Nel6g==
X-Received: by 2002:a05:600c:410d:: with SMTP id j13mr857586wmi.95.1610482727006;
        Tue, 12 Jan 2021 12:18:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c10sm7095374wrb.92.2021.01.12.12.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 12:18:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH 18/22] mailmap tests: add a test for comment syntax
Date:   Tue, 12 Jan 2021 21:18:02 +0100
Message-Id: <20210112201806.13284-19-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210105130359.21139-1-avarab@gmail.com>
References: <20210105130359.21139-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for mailmap comment syntax. As noted in [1] there was no
test coverage for this. Let's make sure a future change doesn't break
it.

1. https://lore.kernel.org/git/CAN0heSoKYWXqskCR=GPreSHc6twCSo1345WTmiPdrR57XSShhA@mail.gmail.com/

Reported-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4203-mailmap.sh | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 96ba5367c6..10e672e006 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -753,4 +753,37 @@ test_expect_success 'commit --author honors mailmap' '
 	test_cmp expect actual
 '
 
+test_expect_success 'comment syntax: setup' '
+	test_create_repo comm &&
+	test_commit -C comm --author "A <a@example.com>" A &&
+	test_commit -C comm --author "B <b@example.com>" B &&
+	test_commit -C comm --author "C <#@example.com>" C &&
+	test_commit -C comm --author "D <d@e#ample.com>" D &&
+
+	test_config -C comm mailmap.file ../doc.map &&
+	cat >>doc.map <<-\EOF &&
+	# Ah <a@example.com>
+
+	; Bee <b@example.com>
+	Cee <cee@example.com> <#@example.com>
+	Dee <dee@example.com> <d@e#ample.com>
+	EOF
+
+	cat >expect <<-\EOF &&
+	Author A <a@example.com> maps to A <a@example.com>
+	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
+
+	Author B <b@example.com> maps to ; Bee <b@example.com>
+	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
+
+	Author C <#@example.com> maps to Cee <cee@example.com>
+	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
+
+	Author D <d@e#ample.com> maps to Dee <dee@example.com>
+	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
+	EOF
+	git -C comm log --reverse --pretty=format:"Author %an <%ae> maps to %aN <%aE>%nCommitter %cn <%ce> maps to %cN <%cE>%n" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.29.2.222.g5d2a92d10f8

