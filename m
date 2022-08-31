Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35969C0502C
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiHaXTS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiHaXSj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:39 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7EAA00FB
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:38 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v16so17401261wrm.8
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=qbyGlxngVgIzQasfNvWqkh0fgMjNTSF0KfpDS4yWhUc=;
        b=eqxo80j0Eg7bVcTPDinNP9BgSlm4cQ61iFsnqRURBmwD5OhKALcE4Gh+xjP3uD4FK6
         TMRC0z1H1K8sBHGiwjI5ZVgvM+71wJl7ZrLNw8R6oXg5f0SLD5mFpB7Sgxs7HkCBti/z
         8GHWq5QXOHHyN1nkGuqh2YTYmiA7B+O5pldHpHnUgAIYERaasDa5ojGp0JTm2u9p45tA
         /vywty/2aT0U9JyLtgmsubZ/zq5NZxVG/UFiAKrFDFhG8bZ2ev5zfKOCopUfINon2lzu
         brKYgy35y6ZOtah9CMEwntlLdfhuGFZLZvd9teM0c8wyLohbHIlFUFeTfh2FMEEELKGq
         NBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qbyGlxngVgIzQasfNvWqkh0fgMjNTSF0KfpDS4yWhUc=;
        b=eBmPvUJa0cblkmBwt15jruPRCqfAHYwiHz9F5aNX7aAdMeBajJK/Wb7CARfE6ZsL3O
         NkiENM8+fIT1oqTwsmKviGv5Sg4bLR4QWg18vcBW8HCBGfDGFjlgj4ZlONGFrGLO1Xik
         xOHr5ujim2uYNEG0ARC61c8pyfQjcr5A96WxGBLtp6l0XykR8nDd7PwHJlM3rhV4qrZA
         MvrrpldFCqQwzVXtOFUMVT+wbYgk5LtM8FyDyAccRTbjR+7rcDxo5h+xUfWk2YPocYvu
         9AFpjLXuxFLKpZ4ByNi2C/8HYJ3X2gAOtMUI3TCUKwlEUmoUSkKXP79rM+qH2T+RMTXn
         7/nQ==
X-Gm-Message-State: ACgBeo15HgOxdT71Xp0KTbMu3If4Mez5ULMvkDaRkywFcFb2Y01qDp5Z
        luW60MCetYnnmOVm1g3PWz9cEpgp8H2mIg==
X-Google-Smtp-Source: AA6agR4qF3Zp8/A+NZtkblNwaVIY/EYZY8BkZ1CqK/AWl6lXJbGo6Fa0HlJeF5r+b7afKPFX/QUHRQ==
X-Received: by 2002:a5d:47a8:0:b0:226:f124:ad74 with SMTP id 8-20020a5d47a8000000b00226f124ad74mr1407190wrb.18.1661987917871;
        Wed, 31 Aug 2022 16:18:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 22/33] submodule--helper: don't call submodule_strategy_to_string() in BUG()
Date:   Thu,  1 Sep 2022 01:18:04 +0200
Message-Id: <patch-v4-22.33-f0ada6854c2-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't call submodule_strategy_to_string() in a BUG() message. These
calls added in c51f8f94e5b (submodule--helper: run update procedures
from C, 2021-08-24) don't need the extra information
submodule_strategy_to_string() gives us, as we'll never reach the
SM_UPDATE_COMMAND case here.

That case is the only one where we'd get any information beyond the
straightforward number-to-string mapping.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6c40be3170f..965196a005d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2159,8 +2159,8 @@ static int run_update_command(const struct update_data *ud, int subforce)
 		must_die_on_failure = 1;
 		break;
 	default:
-		BUG("unexpected update strategy type: %s",
-		    submodule_strategy_to_string(&ud->update_strategy));
+		BUG("unexpected update strategy type: %d",
+		    ud->update_strategy.type);
 	}
 	strvec_push(&cp.args, oid);
 
@@ -2185,8 +2185,8 @@ static int run_update_command(const struct update_data *ud, int subforce)
 			    ud->update_strategy.command, oid, ud->displaypath);
 			break;
 		default:
-			BUG("unexpected update strategy type: %s",
-			    submodule_strategy_to_string(&ud->update_strategy));
+			BUG("unexpected update strategy type: %d",
+			    ud->update_strategy.type);
 		}
 		if (must_die_on_failure)
 			exit(128);
@@ -2216,8 +2216,8 @@ static int run_update_command(const struct update_data *ud, int subforce)
 		       ud->displaypath, ud->update_strategy.command, oid);
 		break;
 	default:
-		BUG("unexpected update strategy type: %s",
-		    submodule_strategy_to_string(&ud->update_strategy));
+		BUG("unexpected update strategy type: %d",
+		    ud->update_strategy.type);
 	}
 
 	return 0;
-- 
2.37.3.1420.g76f8a3d556c

