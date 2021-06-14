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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FE9C4743C
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22414614A7
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbhFNK5b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbhFNKyR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:54:17 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896DFC0611BD
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:48:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id s70-20020a1ca9490000b02901a589651424so9140459wme.0
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ANLM2U1RrQ+E65WNgvnj4IGfQkSMGs1u66iP9WTO9YA=;
        b=ntrk+K82+3W6hHW5zQ4SnB8L27s1hKS/9VNZVQSXeMJqB8Aopo8HpttN1sTirpkhCC
         lQH322tIqEFx/ET3KkaPHfz6CBaxRphU9TRb26Ltwy5choSmiBBWCdBTvgCb+HuwbDc+
         +fGWijN+moW8qAfYIPgqA+w2oyfMW43sIPjWBRWRlLCl/of5DmkVSZL3kyJ47IcriLNt
         el9dMeoXuU6LgLN000zk+eYDXK1NsqVWn6YaklYYg4O9A8+tmkQpgzio76FmdD4readY
         Zc3n0zMNjz3tjotl9cEIU7ZrgA5OkN/aOF1P3lpGnw+dLA2VAU0otBJQ16Og6ZQvsCx4
         cULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ANLM2U1RrQ+E65WNgvnj4IGfQkSMGs1u66iP9WTO9YA=;
        b=SLaDkN0skoP+Kz3p+VknJ1wCw2d/Qq/M55funTlKUEIG+mrITOJPOJZmjeZ4QQtgJs
         YvP44rW4WHghGJaBqaa/yy9OuQWRzvid0hhs9JSLdC7ONhilSJa7cXeZJB6x2Jr5BAiB
         j9eUjnsC556oqq5WOGpE6oHybHmxn2VruAIjp9VXHpPTWOxHvmYCQnKopHnRdVX1veao
         eEm8uMs0ee+SFYrcA3alzDN6bjdtEpbVKZugisZPggxUxNKsBVWwFIYVpqAoIGQpocX1
         FZid5l4gS71vB6lLMnBLZ1WXKW7EpexXwUojxl3XQtc8k0ZBksBB2EaBSR2rgL1jFZbv
         Pmng==
X-Gm-Message-State: AOAM532AD53n8rvL27cM/dPl0vq81ia2c3SrscTFOC7fffizMe6BPqcJ
        25llTYBZs58ePpVo0JI8xtwU/ITMKKcqMw==
X-Google-Smtp-Source: ABdhPJyiF4k4PXeS2jTaRFWjO8rkRzvJ3zYNHvCLEcjHyVGicHP4ylS4ovJ2M0T4tAABCWv/Umw4rA==
X-Received: by 2002:a05:600c:2103:: with SMTP id u3mr16097985wml.0.1623667701913;
        Mon, 14 Jun 2021 03:48:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m23sm15153732wms.2.2021.06.14.03.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:48:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Ilya Bobyr <ilya.bobyr@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/8] test-lib tests: stop using a subshell in write_sub_test_lib_test()
Date:   Mon, 14 Jun 2021 12:48:09 +0200
Message-Id: <patch-3.8-cd6c740c912-20210614T104351Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that this function doesn't handle running the test anymore we can
do away with the sub-shell, which was used to scope an "unset" and
"export" shell variables.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-subtest.sh | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/t/lib-subtest.sh b/t/lib-subtest.sh
index 0ece41c0e5f..465f8f373e9 100644
--- a/t/lib-subtest.sh
+++ b/t/lib-subtest.sh
@@ -1,20 +1,17 @@
 write_sub_test_lib_test () {
 	name="$1" descr="$2" # stdin is the body of the test code
 	mkdir "$name" &&
-	(
-		cd "$name" &&
-		write_script "$name.sh" "$TEST_SHELL_PATH" <<-EOF &&
-		test_description='$descr (run in sub test-lib)
+	write_script "$name/$name.sh" "$TEST_SHELL_PATH" <<-EOF &&
+	test_description='$descr (run in sub test-lib)
 
-		This is run in a sub test-lib so that we do not get incorrect
-		passing metrics
-		'
+	This is run in a sub test-lib so that we do not get incorrect
+	passing metrics
+	'
 
-		# Point to the t/test-lib.sh, which isn't in ../ as usual
-		. "\$TEST_DIRECTORY"/test-lib.sh
-		EOF
-		cat >>"$name.sh"
-	)
+	# Point to the t/test-lib.sh, which isn't in ../ as usual
+	. "\$TEST_DIRECTORY"/test-lib.sh
+	EOF
+	cat >>"$name/$name.sh"
 }
 
 _run_sub_test_lib_test_common () {
-- 
2.32.0.rc3.434.gd8aed1f08a7

