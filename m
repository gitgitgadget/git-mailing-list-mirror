Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AEEECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbiHaXTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbiHaXSx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEB010401A
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:48 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id az24-20020a05600c601800b003a842e4983cso452782wmb.0
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=iqKhvC+nrpAqv1FBqeosjwlMO0oh/ExwTBL5ZR/T8V4=;
        b=Mr0CZq7ApAhZD5Fl6t0vMSD0MNxGbFK4EeBVkXO7CaF/zGM19+ds1RqExQjUyA7ZtU
         jODKZGm3nMkdKLl/l/2x1J3GOdTTOeZPIvzo20azLws2t1O2o3izRB1sJvlT/UIC0aCo
         s9gfbTqZkSCDFa6+96fwmdZqCI2BEB83ZCHu7TwnY6Vv8E6fS4B4uP4UqOIKr36JRQjd
         A/OubGIKvEpbPOc08wJmyJ1hiMn7lgud5DV//+aDVt4VTbsZhEKPGHcCfSAkMbke7wVY
         XRNewr95YQ+SS9zKAzjl3oT5y6VWq1eKss3/POOQ593fJV7yEoR65acTuZ5Vwdtqijth
         Fyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=iqKhvC+nrpAqv1FBqeosjwlMO0oh/ExwTBL5ZR/T8V4=;
        b=Z0Fjibi9mJKSbxRh4G6KD62EhqrM0Y2+7zHYVUL8ne7KeZKiJPNXohivlkMSiPHb0O
         Rf8QAH5cMf3VAqr64bV4z9Td3phtak+/LeR4RtXH0A+vbsvp0xoYMG4uUupk3cdjCwn2
         nNYh8cPMNQ6VK4X/CNU3ofqaKQhm6dIv+xAuyX2Kc4i7o73yg1b0Aw27IOEN63riS6gd
         5jLNUS3kjVcMKumU3EWX2IDyZq0mnVJDYrT2E9XUWdfGQi0q0QQx9nN23LQleqUULkM5
         yvdXOIXleunqUUZWh4FHAZG1SVmN+mH2kqdVNYz2yDVxpWp+hQY7aUBFPLUsse07xyJJ
         szeA==
X-Gm-Message-State: ACgBeo3XWQ2fdK08Ci62RcExeJ6gDvBQVfCYil+nXzRsFJ7ovS/o6+Wl
        8kw6sAmq3zCfy+vBS4LH0vJSq48G6spD8A==
X-Google-Smtp-Source: AA6agR6B6xHQ2BrlfDqkqtCkKnbS2koHmDX/8DT+KsFeHvwLy8cpiUcfKjuxGIsCJhtay2h+pNyM4w==
X-Received: by 2002:a05:600c:1e1c:b0:3a5:b668:4e2 with SMTP id ay28-20020a05600c1e1c00b003a5b66804e2mr3309646wmb.112.1661987926796;
        Wed, 31 Aug 2022 16:18:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 33/33] submodule--helper: fix bad config API usage
Date:   Thu,  1 Sep 2022 01:18:15 +0200
Message-Id: <patch-v4-33.33-1e38bfa7f95-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix bad config API usage added in a452128a36c (submodule--helper:
introduce add-config subcommand, 2021-08-06). After
git_config_get_string() returns successfully we know the "char **dest"
will be non-NULL.

A coccinelle patch that transforms this turns up a couple of other
such issues, one in fetch-pack.c, and another in upload-pack.c:

	@@
	identifier F =~ "^(repo|git)_config_get_string(_tmp)?$";
	identifier V;
	@@
	  !F(..., &V)
	- && (V)

But let's focus narrowly on submodule--helper for now, we can fix
those some other time.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 3f822eac3a1..c4149f11e7f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3110,7 +3110,7 @@ static void configure_added_submodule(struct add_data *add_data)
 	 * is_submodule_active(), since that function needs to find
 	 * out the value of "submodule.active" again anyway.
 	 */
-	if (!git_config_get_string("submodule.active", &val) && val) {
+	if (!git_config_get_string("submodule.active", &val)) {
 		/*
 		 * If the submodule being added isn't already covered by the
 		 * current configured pathspec, set the submodule's active flag
-- 
2.37.3.1420.g76f8a3d556c

