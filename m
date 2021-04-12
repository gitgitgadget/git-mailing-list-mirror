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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F79C43460
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E04461278
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243727AbhDLRQD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241822AbhDLRP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:15:59 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FF1C061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:41 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u20so2725681wmj.0
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AV+hxGlgoX8P/s7Er1F0kaEVyE2TK5pkE0YEhfBAGTM=;
        b=SBBo8QW/TEIxhkrL6OjMuCVDtByrlnDo1uX1lBH3qwmd0RO0reaRJXyjC17AEFEhT5
         AjLm8e6Af2Su2zWZsPp+tV7r3jx4w/tqNffKtl9YeBhshgQ/l31IJYIB9NXGTlUUqVCv
         a4V/sPPwnReE/DyT0GoCRnuxmg2jwV4T1L05/888inLc9UDMuDYU3uZybUlg1AdB60UH
         qgMF0FiI+DITMM3MqKzFcLQR0bC6wqD85WRCvDdw1g62BBL/H7yWI6fL2+uonEUNmGKQ
         X/YH4qbEDyU8ePbcRShiSgDygZBelRn15zwdhAvX+ZMiut6HO8aLxXbg3nPWmma94Y4P
         GvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AV+hxGlgoX8P/s7Er1F0kaEVyE2TK5pkE0YEhfBAGTM=;
        b=qBMKCEqP4XoWxD8JJMNKaNLO9VeGVWAH27J61ujcT827LuAf8DJAvsrBnDVCfRUm2p
         fPAqeLYUzYnMelnMhfzS+dV/KYzchx+gfbZWZ0/TCigpRDILJwl/JDJoqMeozgQtmr5c
         0M8MgrEYc1kuuo5xTQ1PJ5UPru/9YmkqrBMUQjG3qMJlQQzO2IIbK+wnV0Z4ZR9mF9KA
         1CMjNP4nAiTylcFxzeK3tnsz7OQKB9MkMqzrKd/6VgnGOR+gdNf6PdtIp6q04r15/s3x
         M48lZBN6vpvHXFZcn7mNPQ2VUp9ANb6qkYJsv9yLFyS2Y+N/lUl/WQE+hOZZtOZfPXDd
         ts5g==
X-Gm-Message-State: AOAM531b4YVpgKKba5e73YmTGfZpIBuuMsNcKz7agCsRS1d8+3zH6BGB
        sjpLJvvSPrEJ/kjj7djZ9xVUgu6nNdc7aQ==
X-Google-Smtp-Source: ABdhPJwesxpl4D894iW9v1AsfsMr8pxRCXmtMcJrzOi6Xuk/PdpbJhf7+KZuAPdggJTOB5ObOixV0Q==
X-Received: by 2002:a1c:a54a:: with SMTP id o71mr153343wme.172.1618247739507;
        Mon, 12 Apr 2021 10:15:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j1sm7828625wrr.33.2021.04.12.10.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:15:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/22] pickaxe tests: refactor to use test_commit --append --printf
Date:   Mon, 12 Apr 2021 19:15:09 +0200
Message-Id: <patch-02.22-413a330d3d6-20210412T170457Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.639.g3d04783866f
In-Reply-To: <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
References: <20210216115801.4773-1-avarab@gmail.com> <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the existing tests added in e0e7cb8080c (log -G: ignore
binary files, 2018-12-14) to use the --append option I added in
3373518cc8b (test-lib functions: add an --append option to
test_commit, 2021-01-12) and the --printf option added as part of an
in-flight topic of mine this commit depends on.

While I'm at it change some of the setup of the test to use a more
sensible pattern, e.g. setting up a temporary repo instead of creating
an orphan branch.

Since the -G and -S options will behave the same way with truncated
and removed content also change the "git rm" to emptying data.bin,
that's just catering to how test_commit works. The resulting test is
shorter.

See also f5d79bf7dd6 (tests: refactor a few tests to use "test_commit
--append", 2021-01-12) for prior similar refactoring.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4209-log-pickaxe.sh | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 5d06f5f45ea..ad45d8cfd0a 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -107,37 +107,35 @@ test_expect_success 'log -S --no-textconv (missing textconv tool)' '
 '
 
 test_expect_success 'setup log -[GS] binary & --text' '
-	git checkout --orphan GS-binary-and-text &&
-	git read-tree --empty &&
-	printf "a\na\0a\n" >data.bin &&
-	git add data.bin &&
-	git commit -m "create binary file" data.bin &&
-	printf "a\na\0a\n" >>data.bin &&
-	git commit -m "modify binary file" data.bin &&
-	git rm data.bin &&
-	git commit -m "delete binary file" data.bin &&
-	git log >full-log
+	test_create_repo GS-bin-txt &&
+	test_commit -C GS-bin-txt --printf A data.bin "a\na\0a\n" &&
+	test_commit -C GS-bin-txt --append --printf B data.bin "a\na\0a\n" &&
+	test_commit -C GS-bin-txt C data.bin "" &&
+	git -C GS-bin-txt log >full-log
 '
 
 test_expect_success 'log -G ignores binary files' '
-	git log -Ga >log &&
+	git -C GS-bin-txt log -Ga >log &&
 	test_must_be_empty log
 '
 
 test_expect_success 'log -G looks into binary files with -a' '
-	git log -a -Ga >log &&
+	git -C GS-bin-txt log -a -Ga >log &&
 	test_cmp log full-log
 '
 
 test_expect_success 'log -G looks into binary files with textconv filter' '
-	test_when_finished "rm .gitattributes" &&
-	echo "* diff=bin" >.gitattributes &&
-	git -c diff.bin.textconv=cat log -Ga >log &&
+	test_when_finished "rm GS-bin-txt/.gitattributes" &&
+	(
+		cd GS-bin-txt &&
+		echo "* diff=bin" >.gitattributes &&
+		git -c diff.bin.textconv=cat log -Ga >../log
+	) &&
 	test_cmp log full-log
 '
 
 test_expect_success 'log -S looks into binary files' '
-	git log -Sa >log &&
+	git -C GS-bin-txt log -Sa >log &&
 	test_cmp log full-log
 '
 
-- 
2.31.1.639.g3d04783866f

