Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E142FC11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 16:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C353F61477
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 16:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhF3Qks (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 12:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbhF3Qkr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 12:40:47 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AFBC061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 09:38:17 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i94so4446937wri.4
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 09:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=36pGSabGB3NCxxaUzLA2Vmg6bamBwzIR2/j1fpjexv0=;
        b=g8LEIxuaJo0U7y3Eu/qhpgMkLzVFi3Xk26UbEzVxMs9byWb8HWzD4kvyXeRrYCe5zO
         MaDshWn57r83iWWN8u4pu9Mm6T+Xe3OxmlEG3w+V3QFvk75DGvlnmPps9RKzTOchbZYB
         26A/09i0+5UMzGjUAqBhvOkXgyiDH+/tAZboO5r9YS0zSGytLOfTKDnUl94rdbFfZauL
         KLcE06H1poJO2asYk830kqPKCJlwpG3GCM8UcFZS+QHwDOexT1wG/qYTTflHsyOPiJwT
         9GOUdJc3jt6jglq+aY6qRx4sc8bbgF/IaqB24G79ons+YGNRV0jbeSQyzxdp5DAV3f/k
         U6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=36pGSabGB3NCxxaUzLA2Vmg6bamBwzIR2/j1fpjexv0=;
        b=rrBO9aMYCmW64APtA4pRsv3MpR2gTb8RPsQlQ7iYBtYWvuzqbLr+Hay92FIUeqXOlS
         bXORtuZDjWglj4YIBr0Q6itRYdXXAEjNBIkgO7Tz0KalIU8JioXPopuw9tdhn/aeozib
         08RBPITXo/g8PFtuaYkENUr3MeBHvFEBdEI7X22pVkK2afqd0H/qIwN6SIvKDTHtwFGE
         FMbfRStWcElnFPlWZjLsC9gMwWobb7FgCWBsFSdDb1idbqMiv9IDE5CaMYk8Y1yv57o+
         UcIqrsP/+1orHjngqJ1dn7pdrkyCWDs25rIwsksaUg6DBU7wQDUOH7U+F2YaYeEpO4WI
         zdzg==
X-Gm-Message-State: AOAM5311SlXm4FrrbV3yuN3NF14APYaD84hk9Oivud3JR/PhxLMWq3tt
        o+OKD6WNepN8MlV4JcU7ONDHKM93i/Z6xw==
X-Google-Smtp-Source: ABdhPJzPQsVVhCBVgD2lyZMaC885H/ZYNgkc364xnfN6ribiJVT5MK5viXC8Si9t5fp1PCpYB1WcGg==
X-Received: by 2002:adf:9bd0:: with SMTP id e16mr40627882wrc.392.1625071096219;
        Wed, 30 Jun 2021 09:38:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l1sm1952066wme.11.2021.06.30.09.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 09:38:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] fetch: fix segfault in --negotiate-only without --negotiation-tip=*
Date:   Wed, 30 Jun 2021 18:38:12 +0200
Message-Id: <patch-3.3-38930024d95-20210630T163329Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.619.g53a98c35da0
In-Reply-To: <cover-0.3-00000000000-20210630T163329Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210630T163329Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The recent --negotiate-only option would segfault in the call to
oid_array_for_each() in negotiate_using_fetch() unless one or more
--negotiation-tip=* options were provided.

All of the other tests for the feature combine both, but nothing was
checking this assumption, let's do that and add a test for it. Fixes a
bug in 9c1e657a8fd (fetch: teach independent negotiation (no
packfile), 2021-05-04).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fetch.c        |  3 +++
 t/t5702-protocol-v2.sh | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 9191620e50c..25740c13df1 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1990,6 +1990,9 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		fetch_config_from_gitmodules(sfjc, rs);
 	}
 
+	if (negotiate_only && !negotiation_tip.nr)
+		die(_("--negotiate-only needs one or more --negotiate-tip=*"));
+
 	if (deepen_relative) {
 		if (deepen_relative < 0)
 			die(_("Negative depth in --deepen is not supported"));
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 66af411057c..920815478c7 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -599,6 +599,23 @@ setup_negotiate_only () {
 	test_commit -C client three
 }
 
+test_expect_success 'usage: --negotiate-only without --negotiation-tip' '
+	SERVER="server" &&
+	URI="file://$(pwd)/server" &&
+
+	setup_negotiate_only "$SERVER" "$URI" &&
+
+	cat >err.expect <<-\EOF &&
+	fatal: --negotiate-only needs one or more --negotiate-tip=*
+	EOF
+
+	test_must_fail git -c protocol.version=2 -C client fetch \
+		--negotiate-only \
+		origin 2>err.actual &&
+	cat err &&
+	test_cmp err.expect err.actual
+'
+
 test_expect_success 'file:// --negotiate-only' '
 	SERVER="server" &&
 	URI="file://$(pwd)/server" &&
-- 
2.32.0.619.g53a98c35da0

