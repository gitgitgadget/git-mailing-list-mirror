Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932D5C07E9C
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 10:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 732C56157E
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 10:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhGHK4G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 06:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbhGHK4E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 06:56:04 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D066FC061574
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 03:53:21 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id w13so3795973wmc.3
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 03:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zIMHbyJi8ETSO35wjC1q+JADw0hQGH17jc457oFj1dA=;
        b=VjIDBNkOh1lbg0yweKEzW46HDxPhnH8TiF28wcv8R7Z4Gk0RZ/OLg6wU7KajM4exI7
         4srw5MbwZDHZel5B1TknbbsdL/14gSpAIpCPbgLPwux8uh4H6/HVCxdkq5dDgu5ZSme2
         pNnvr3f5H3j8ftRpyeACOI6nEGTirFo4Fj28X86lo6XLxXW6oOMPih0Q11oW8OhreJsi
         K3yETGbvdT1zKLi6o9d9CFS2SOPsdvG1JxiODZc/zb8glx4Wda2WsjYLI/k5AXpqZsJe
         oQP+Fmskwrw5OogB03MIZ7z8CeVjyQ06T9a2kgR6iiXLMx5skyWaXYW0FJD4WLc2qy3D
         bgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zIMHbyJi8ETSO35wjC1q+JADw0hQGH17jc457oFj1dA=;
        b=OKHxBlEgGn/36Vz8fQXSTA6FbiLs1eh+fe/kDd9hmJ1qVGyjb8UpC+qOVG5SfNK1Gq
         Ry8cUUx8g0JqGQdG1ewKc16cEebLKdgwXoHUtuzY6H1F0g6M5qV2LOp8qVlWTHyYndkn
         nPyPkJdNZPzY00NvQK5F+JDUNqj4ZhrscS8bTV7qGF0BNmUHu/YCoi7EVN40Q+IY2m6t
         jnyRRF9GWtrgxDa3jSdRKpebqrtGNm+EckyLg2zegvsL90h+QosgV3IOD7FMzCcVD0U8
         fENUAHw3y8qA2ytV9tWtGb7e6KmAstsJEP2d85asDxmpNYeeHRFxOUKeceo5n9Fo9SQ7
         Gv6w==
X-Gm-Message-State: AOAM533M6yLGIlNq9Xnf2Rodswj81Xqcu5NXSCyzEqtKp8T59tCm+eLc
        4Fh9q8bYY1T/7Yjw9Dj/YOul62TZvdYTmg==
X-Google-Smtp-Source: ABdhPJxR3UOExAh+xGriiXB26ceY0k0DVHaO1srQzt1b75tAqbpblAPw2oe/Qx9wcMmzirmsxXONyA==
X-Received: by 2002:a7b:c3c6:: with SMTP id t6mr32467392wmj.35.1625741600289;
        Thu, 08 Jul 2021 03:53:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e15sm1838920wrp.29.2021.07.08.03.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 03:53:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/3] fetch: fix segfault in --negotiate-only without --negotiation-tip=*
Date:   Thu,  8 Jul 2021 12:53:15 +0200
Message-Id: <patch-3.3-491d72c35a0-20210708T105034Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-0.3-00000000000-20210708T105034Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210630T163329Z-avarab@gmail.com> <cover-0.3-00000000000-20210708T105034Z-avarab@gmail.com>
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
 t/t5702-protocol-v2.sh | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

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
index 66af411057c..78de1ff2ad5 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -599,6 +599,22 @@ setup_negotiate_only () {
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
+	test_cmp err.expect err.actual
+'
+
 test_expect_success 'file:// --negotiate-only' '
 	SERVER="server" &&
 	URI="file://$(pwd)/server" &&
-- 
2.32.0.636.g43e71d69cff

