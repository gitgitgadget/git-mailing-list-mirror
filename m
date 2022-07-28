Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCADC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbiG1QTO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbiG1QSi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:18:38 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D737E73924
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:18:07 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id i8so2828916wro.11
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=zg6jHweM7GeAnOCe4SdhzIz22duhKo1wGcbZckbVZUw=;
        b=qqbHXmLU09DdLN3gzX5LX4r+uLPap95aqEGM2mWAyVMtW11tNUZQMpF5i9AbV8EcjN
         gORZP0/NJHHTIUQy3yK1InCtU7pNA2XqQxZ+NhUH/6kVwJ5hCW8ENO3pPHfN2rxl64WJ
         uEoF4lJCdkNfYoSE5Snj6l/0GMul8I7N9fTVymjDx2A6knA2wzd6CAE8Uqk25CeYa8iO
         Zsoi1fcYF/r8/dO0iPJ518JeNG1Gvu9PUUnhU0kwFh/z8j2aikHqA26ZfoSaQxB/WhxW
         meFwK/B/0r8NmlxDo4soWq/IusfaJYn+H/Nrhs8k0TDJygEMXmVqCfofNB9CxE4to8cT
         DgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=zg6jHweM7GeAnOCe4SdhzIz22duhKo1wGcbZckbVZUw=;
        b=mxkElrp5Zj7qNkYmQslPtIZpEkcqWYYw6OxQaScpWxiboQhOPAp1cwrNP/EHIA1DEu
         nKxXH6OYQknbTOp7QQhG/IU0UMAbGXoumlbI3LAO0IqHFrvwHDJYLeX8H/S1wK/Brn+m
         2pH0ziS17K/zXXPFLoE5MEaBUNR8htm/yaLi1eTn6LntqwM8fJGNvK4brDS8w/sWrdT/
         mB/xUddaXmG6+xGuFNVcvaOvHCGnxgtzRqBufhLv8oW4KGBCwGIglM5HNOSBDTDx9xAk
         THF21PioqOuUdE62x44bRtZfHAxpAYnRLOAj94qZiIrFrGPouuVb902EqiQyJkDwtmR7
         XIbw==
X-Gm-Message-State: AJIora/yk6xDaKB3TxL1uuoXxDk1rFBM/fX7yi+YX3w3v39JPi6uHqpK
        p28HuItpjigAh8PZjslZnIKkn7TqfJeWYw==
X-Google-Smtp-Source: AGRyM1tUJ+niDd+28lqtJvL0Jzd7esyO5QqEcBOuJkewfET408xFQ4H8cTcYfCWtRIxUnMsUJK7nIg==
X-Received: by 2002:a5d:6d0b:0:b0:21d:9f26:f84a with SMTP id e11-20020a5d6d0b000000b0021d9f26f84amr17950762wrq.155.1659025087042;
        Thu, 28 Jul 2022 09:18:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w13-20020adfee4d000000b0021f0af83142sm1220117wro.91.2022.07.28.09.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:18:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 20/20] submodule--helper: fix bad config API usage
Date:   Thu, 28 Jul 2022 18:17:05 +0200
Message-Id: <patch-20.20-579560cb9a8-20220728T161116Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1167.g38fda70d8c4
In-Reply-To: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
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
index d3f22f03766..22c79353bb0 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3083,7 +3083,7 @@ static void configure_added_submodule(struct add_data *add_data)
 	 * is_submodule_active(), since that function needs to find
 	 * out the value of "submodule.active" again anyway.
 	 */
-	if (!git_config_get_string("submodule.active", &val) && val) {
+	if (!git_config_get_string("submodule.active", &val)) {
 		/*
 		 * If the submodule being added isn't already covered by the
 		 * current configured pathspec, set the submodule's active flag
-- 
2.37.1.1167.g38fda70d8c4

