Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34DEC00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 14:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiHUOAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiHUN7m (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:59:42 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE4C23BC6
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u5so2473969wrt.11
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=4ueQ3IGlJxs5Pe3SIF8DZUo8OKjXpkm5eSKbmPEzut0=;
        b=eiPI+Tq+4C+86+zUhoNqfLNzEYSkR+uNQIAz+PAJ2rZpp3DHymOz/GFP4HjE+RL5iY
         R2mvA1rfJqxqB+aX+0U4hcDimzi30s+QuqNmWrX8jd7UHilPslZcl4zNWRYNUl+nmW99
         rjs25krNAccwG+mFnv8pLzmwah7DX3Rp1523j+vKW2O+W+dxMMXpbI5z0zT6JsIm7rL/
         gw+F35LMQ0owFncjY8AMgLowt47QK4E5AaoKmxvj4MRbnvYC9Cl+jA/8xI9tgCterizV
         e7waIIBbS/b2ReLiYjucuYUGiU8bAySGqCllBzw3AJ1N5JejH0leeeTaUDx0L9COikBW
         +PEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=4ueQ3IGlJxs5Pe3SIF8DZUo8OKjXpkm5eSKbmPEzut0=;
        b=ghrwd/UGE5/o9lg6jyZf6OIKCLICmeuqkXraoCD5oTEA44vCYpo6FjuFWTk9MAO3w0
         nAwTXTg0D/SrivUtRw1ltmgo/CojQ0VWUJ++yUHOYza7p6+JsaMvYne7WBRCmkqc5Ogi
         8FFF4+ngJaF/Mc94S5/m1KkYe340+g4+biW9qV2AGmoMDo+OAQIpE/S4Br1I326hpWl4
         5WjV6dvCw22WoeZ+rY/UMqrd9S9ynoTC/dQbflu/FDO6LmPljwVgE/Dw/3je/WH9luOd
         0gix+jcVtWnGTITjt2s6GFiVCaUEF3XLl8QmuqQTIy1a2SiC4ZSGdswmGJFaw8vk8F8v
         qYvw==
X-Gm-Message-State: ACgBeo19sW2BmZIs/4oEQ2r9ZZ7fsKNxBE1yaCjdnj0gfqOtoozxDdTx
        iYMkhOYcuOvjIPbZMTrMOC0khhnArauU6uxV
X-Google-Smtp-Source: AA6agR4DsmfzU0PryRbHyx6eQEB/P5SAwT+5myEeXvLLvYGLhoZ+3fjyLHucxpBT93pcPvyiCUluog==
X-Received: by 2002:a5d:684a:0:b0:225:4363:c4e9 with SMTP id o10-20020a5d684a000000b002254363c4e9mr3841333wrw.309.1661090339078;
        Sun, 21 Aug 2022 06:58:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 32/32] submodule--helper: fix bad config API usage
Date:   Sun, 21 Aug 2022 15:57:41 +0200
Message-Id: <patch-v3-32.32-d133402462f-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
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
index 65909255760..e489a0f6b10 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3108,7 +3108,7 @@ static void configure_added_submodule(struct add_data *add_data)
 	 * is_submodule_active(), since that function needs to find
 	 * out the value of "submodule.active" again anyway.
 	 */
-	if (!git_config_get_string("submodule.active", &val) && val) {
+	if (!git_config_get_string("submodule.active", &val)) {
 		/*
 		 * If the submodule being added isn't already covered by the
 		 * current configured pathspec, set the submodule's active flag
-- 
2.37.2.1279.g64dec4e13cf

