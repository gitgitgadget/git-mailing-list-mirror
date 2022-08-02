Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090A5C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbiHBPri (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237095AbiHBPrD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:47:03 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AC315FF1
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:39 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 8-20020a05600c024800b003a2fe343db1so7157801wmj.1
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=OWWST2Rlt2wr1zjTd22DOWwPlFiqyWnfiRH5l2rxZ94=;
        b=WxADNUnF9agsjGAgfS2yfritXUBqBSvYDVl4OWZ7snqOdD/VY9vBDTRPzaX0sTY7AK
         Pcj563+D2VqwBftA08xKgYuRbovFl2N8wWOSz4OMSbFaIDiZNEecRU6lqJ6Fa8vh7Qyd
         iKZj30QF6UVcsMe1KXhLlXeJcCEYuOrmE+IYaPyEbSEXldLssj3Pvjk3vo4Fx6gO8KuN
         4a/uH/NjflkhyD1iGgNyNzv/UDVaxlQrq2b3HS93fuOnJO/gf/9rV441n4lINmxwJyQ/
         lzPSJcPy0K99wV2ayQ8PHEbvnN3eNTEXUvfxxyVd5TkCr6fbsBMz+w9ui45PTiSlIUku
         lTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=OWWST2Rlt2wr1zjTd22DOWwPlFiqyWnfiRH5l2rxZ94=;
        b=eT/TqGksUiSDPJuog4k4gkBbKyuxF8Xzi6wfjLpS4mBdUDwBeBH8/zGsbSNY/LGvXJ
         2a7QgnTDTxECZecX/up188V9UqPYLzbnJn5paaEROJGKn0xkg+TxFMtontOV3uADG6wk
         47CWuL1lW/rPJD7ohmn0W94EPpJQqKGNsY3aYswWausDrKkGIruVKjVocdh4HzE0Huz8
         QBT8fzEf0I1cLR/KLwrc26EPINRMe5hQisHdspCVlNdFVrM/Xoj2v1nv+bqeQP+O8fwa
         QA0zUOAd0QU6XBOs6LFDSxqBgCJH71IgieagYj4icnQRlxTUZOBHXTv1nuVpuVwO4TIl
         xVcg==
X-Gm-Message-State: ACgBeo1QhN/8i0pmgVKuSWK/JR/tbBxlkLEXrHDzgTuhYIYXINwsayap
        GQ0jmKixRGNlsINPM1m4ixz9vili+K5tXg==
X-Google-Smtp-Source: AA6agR5gw8cLqQIiajZ6V7gSv2CikC1eAghPENvzSQpznnoPEqVjUNjWvQb5YhLzULqQRSR9TjB1yA==
X-Received: by 2002:a05:600c:19c9:b0:3a3:469f:c1e7 with SMTP id u9-20020a05600c19c900b003a3469fc1e7mr44470wmq.141.1659455197765;
        Tue, 02 Aug 2022 08:46:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 21/28] submodule--helper: don't call submodule_strategy_to_string() in BUG()
Date:   Tue,  2 Aug 2022 17:46:05 +0200
Message-Id: <patch-v2-21.28-bce1a014a2f-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
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
index 955deb375ee..b49528e1ba9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2155,8 +2155,8 @@ static int run_update_command(struct update_data *ud, int subforce)
 		must_die_on_failure = 1;
 		break;
 	default:
-		BUG("unexpected update strategy type: %s",
-		    submodule_strategy_to_string(&ud->update_strategy));
+		BUG("unexpected update strategy type: %d",
+		    ud->update_strategy.type);
 	}
 	strvec_push(&cp.args, oid);
 
@@ -2181,8 +2181,8 @@ static int run_update_command(struct update_data *ud, int subforce)
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
@@ -2212,8 +2212,8 @@ static int run_update_command(struct update_data *ud, int subforce)
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
2.37.1.1233.ge8b09efaedc

