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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEB4C433FE
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 11:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67DAC6112F
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 11:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbhIVLVg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 07:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbhIVLVc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 07:21:32 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE77C061757
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 04:20:02 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w17so5576152wrv.10
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 04:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qmKtkcs60pYUOC3Tiq9nkRSkco6uyllJdHmRTYfQ4sM=;
        b=GyeCFOhjpDWUswa7dSMhDZBsTatlF8AZoPpLN+SQgpWD4DTkYt+iJcf48p/gx/npF0
         WqdiHJ78xbrNcfKavgiYtrth/LFm4BNkQkVHZMBxG06O0JgUC3ciIuT00p5Kn+Pj1jch
         FPC1VwNALO1L4u8sqZMVSLOVjROyJ2MHClpWK4BsmNrbWEjPgLAjfGvujdUop0wfB2Qw
         f0nWCV/aAgUUxMbH+gq22s/21wC741Z73lkrtrGQeb9GVwwQerHbEct4CLGpuoqvP0KB
         zI0Pxcg91t+Pu6URLh/QZN30RY3L2JXDixtRtnzjnspLyQB6vydtbxSlp6vaYUuKh1mq
         m0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qmKtkcs60pYUOC3Tiq9nkRSkco6uyllJdHmRTYfQ4sM=;
        b=JrAf7tlA0r39+Ko8/8L678Jk2msI5DUaf4r/HxW5oXkQA2StlTjPJB8AiM3wEI2ppK
         nOh4bG+bpdVVh7pbmDQSc4vlm6oKbiIPLQkNHzvrbgqu2WO4ilTy76atCQJ0/FF0H5C6
         SiRaWlQn7/8n6Mg0sF2nVhTeU/TAjjFA+SDfC7hF6oWzcXW2apYoamHqrjlg7NXbJdHL
         gFptYVb/sp/Mu46IRa+GA6jMPGWXSj5YLFyQyX1HIHJkhWRKzwKkdPdOTLMg3vBvlaHY
         6hyhXnuJyS6uE2VgKj3937i/kapQvZARvjhxAWZRSm8YIJhfdKJtJwL1fFEqb30jIq22
         biTA==
X-Gm-Message-State: AOAM530WSEE5kRCPE52G+R9ovtHSMxzOWyaPaE78FlqawylCtGTtHISo
        Gh9+NVk6zUnavmX8fxCNEjvNz5uDPstHpg==
X-Google-Smtp-Source: ABdhPJzbUTh8KMfjvBl17kJ2gxQbxXKa1DTMsdrWiwNQZV/sHSF9aNE9rs/sKNQEEMtAV/ik1VJVJw==
X-Received: by 2002:a5d:63d2:: with SMTP id c18mr39915532wrw.311.1632309600913;
        Wed, 22 Sep 2021 04:20:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d70sm1679165wmd.3.2021.09.22.04.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 04:20:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Ilya Bobyr <ilya.bobyr@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 4/7] test-lib tests: avoid subshell for "test_cmp" for readability
Date:   Wed, 22 Sep 2021 13:19:50 +0200
Message-Id: <patch-v4-4.7-a581bff6e62-20210922T111734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1225.g9f062250122
In-Reply-To: <cover-v4-0.7-00000000000-20210922T111734Z-avarab@gmail.com>
References: <cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com> <cover-v4-0.7-00000000000-20210922T111734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The use of a sub-shell for running the test_cmp of stdout/stderr for
the test author was introduced in this form in 565b6fa87bb (tests:
refactor mechanics of testing in a sub test-lib, 2012-12-16), but from
looking at the history that seemed to have diligently copied my
original ad-hoc implementation in 7b905119703 (t/t0000-basic.sh: Run
the passing TODO test inside its own test-lib, 2010-08-19).

There's no reason to use a subshell here, we try to avoid it in
general. It also improves readability, if the test fails we print out
the relative path in the trash directory that needs to be looked
at.

Before that was mostly obscured, since the "write_sub_test_lib_test"
will pick the directory for you from the test name.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-subtest.sh | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/t/lib-subtest.sh b/t/lib-subtest.sh
index cdbc2d93320..0737fab98ad 100644
--- a/t/lib-subtest.sh
+++ b/t/lib-subtest.sh
@@ -79,22 +79,16 @@ run_sub_test_lib_test_err () {
 
 check_sub_test_lib_test () {
 	name="$1" # stdin is the expected output from the test
-	(
-		cd "$name" &&
-		test_must_be_empty err &&
-		sed -e 's/^> //' -e 's/Z$//' >expect &&
-		test_cmp expect out
-	)
+	test_must_be_empty "$name"/err &&
+	sed -e 's/^> //' -e 's/Z$//' >"$name"/expect &&
+	test_cmp "$name/"expect "$name"/out
 }
 
 check_sub_test_lib_test_err () {
 	name="$1" # stdin is the expected output from the test
 	# expected error output is in descriptor 3
-	(
-		cd "$name" &&
-		sed -e 's/^> //' -e 's/Z$//' >expect.out &&
-		test_cmp expect.out out &&
-		sed -e 's/^> //' -e 's/Z$//' <&3 >expect.err &&
-		test_cmp expect.err err
-	)
+	sed -e 's/^> //' -e 's/Z$//' >"$name"/expect.out &&
+	test_cmp "$name"/expect.out "$name"/out &&
+	sed -e 's/^> //' -e 's/Z$//' <&3 >"$name"/expect.err &&
+	test_cmp "$name"/expect.err "$name"/err
 }
-- 
2.33.0.1225.g9f062250122

