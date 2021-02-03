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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098ACC433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D22A864F6C
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbhBCDaJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbhBCD3r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 22:29:47 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC215C0617A9
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 19:28:30 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d16so22536091wro.11
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 19:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WzHtVGaIUvraLHudFSjghhXUnjs2aHOGw0DGSbLLQGU=;
        b=ftPlNFtxbsjje2rr9z2I66Uj3X3VNzcQSlL512J/oME7iK1uX5jTb9x25lL6Cf/SgV
         hvco0Sdwx1yrD2QOo7XFGwFu8P4a0qBfELq5zMfg6upR5zCT4PBs+hA9gEUJ3nPGwZ5A
         NLkf6YN3GyoEhUQrVnxj7E3fhbF/eLTjDwv9wQO3xYi6t5t048IK+ldZWsw7bRHSe98W
         R1eFwrBORi/QeLhXKZ4UPUbSafjMh82nHKHsbj0N7mz+CaCQLdTufK1oD3C4D8BmfXeg
         jDnNOQo9mBX++AHE4lWOt7GZQ2vHLaTT8b+seBfH0qBtLqqqAcFMKg4W0+vC+hS3rWSQ
         v5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WzHtVGaIUvraLHudFSjghhXUnjs2aHOGw0DGSbLLQGU=;
        b=QcUp4fqYGRyo0FXgMzOgkwQ/Kd3UmynZiCHesW1DSyf2lvehz51anvY7TEpnK/XUkw
         hJM1PDfus4PmO1vkDgrJnxFXW9+MDGEuMmTm0ALzYrLhMqXhBTnPTCicWD/IIVQE96Wo
         oyPi3+XNxoyW4JrR65Ofr2NyFiTaXPeZl26A9R+fuvgFzY04rla6mhpvFwjo3aKHk5Ui
         p+pQOP3cLx6YkmwXRD4SesTbF6LPAXB07xd2c0Z7Vi1wOqC5rKgOK/RCdE4f3bVSR8sM
         PQTuV1iJNmUEic/mjsLBHAkYp1mP5EzYiRY8vV4JTZRCoHvMO04esj9ph/Z69ncv/W1v
         1zaw==
X-Gm-Message-State: AOAM533dNbCpqwBVVMPLYg0SfdNI4D3BS0N2Sbz7og0y57dQChtCyt3Y
        d2G6l1u1S1b22DqRem6dinxMC+qjGv3miw==
X-Google-Smtp-Source: ABdhPJy1BT2RllzsF8n/m+70/WyxgevAL7W2NrRoTIbEdlonUg6vg/kszjvttihjG6gYABdxM45loQ==
X-Received: by 2002:adf:f782:: with SMTP id q2mr1056867wrp.181.1612322909317;
        Tue, 02 Feb 2021 19:28:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c5sm971089wrn.77.2021.02.02.19.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:28:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/25] pickaxe tests: refactor to use test_commit --append
Date:   Wed,  3 Feb 2021 04:27:58 +0100
Message-Id: <20210203032811.14979-13-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor existing tests added in e0e7cb8080c (log -G: ignore binary
files, 2018-12-14) to use the --append option I added in
3373518cc8b (test-lib functions: add an --append option to
test_commit, 2021-01-12).

See also f5d79bf7dd6 (tests: refactor a few tests to use "test_commit
--append", 2021-01-12) for prior similar refactoring.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4209-log-pickaxe.sh | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 5d06f5f45e..21d22b2a18 100755
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
+	test_commit -C GS-bin-txt --append A data.bin "a\na\0a\n" &&
+	test_commit -C GS-bin-txt --append B data.bin "a\na\0a\n" &&
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
+	(
+		cd GS-bin-txt &&
+		test_when_finished "rm .gitattributes" &&
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
2.30.0.284.gd98b1dd5eaa7

