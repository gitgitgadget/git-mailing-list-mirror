Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C3FC28D13
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 13:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiHUN7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 09:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiHUN7N (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:59:13 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5712237D1
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:48 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h24so10285525wrb.8
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=zDcpI1HylAdjISL08lO4mdt4UujXGz4v4rtsca2e6z4=;
        b=SLtDSztGt9rciULPWL8j46qQGZCkw2wShjXxOAQSPcSC2V6bPDkyy3I/twaJBJRWeA
         sJyClyv8H3T7JdpuiYgk1rz2rqm1zAfN4bxALtop4oSF59n2HtCY0/lb6wzX7W8ARmuf
         a9rtL40ObYDrxaG5fstzm+ZzAF7nuPi5uQQqbzVAEU7t8i454kS1M7r6ItrnnhZ7IbZs
         L/vqgOTsFDVMTQtrq2V3k0wqrKwgRm/MGE9KuxGJ+4nlnwWwN1b0FnHmg+FmZa0D8fhb
         6kQTGw5ITOpIStxR+KqB1Tz4SPK09QlyFtNz9g5yAr2tCoFynOnTXLcU4t2sxS9WrjOd
         o2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=zDcpI1HylAdjISL08lO4mdt4UujXGz4v4rtsca2e6z4=;
        b=uVwgZoIZDZXcwtLYV/hXc5j3eKOsfLA7Cuw/KG7Ovouf56LpnsuT0uANbna38pgCGa
         6wxM+1Q/LxX1niMlUs8Myh18lzhYOcZcSU6C6eHUZdW2KSK5JjzWSSsOsNLoK5EJXgl7
         ivk9OT/WifwoXv4HfS0BN97VQUeeYgp3Il4kgeGv3k6S6ROlX2jwAz1vDQr76FXo2Ruy
         2lmGIvov7b3/6E6MsOBEVCO6SQzzApF5oBF63vdvwkmLDk5KyiZzTcezO9MsHyKB6NS2
         aVnVNFLfej7ZmoJluiqO8BI/pUbvSXz9YvZpeTk8j+v7mwUaondR/eoVDPNxZLrcTKX0
         e50g==
X-Gm-Message-State: ACgBeo1rptCF28NDvREztZGA81rdpYWIRsO0r7zNt6lbvr2wEJdvnvLU
        hSaWFp0lmF4HY4PioUxSAYbsHxRXNLAqkiNF
X-Google-Smtp-Source: AA6agR6k1mMZ7DAHkbXHFhYYEga7CiDA5B+OwcYMRup3R2BjTjaWQGNPR/eoV7MImmfK7yfpOuIQQw==
X-Received: by 2002:a5d:5311:0:b0:224:f76e:ad6f with SMTP id e17-20020a5d5311000000b00224f76ead6fmr9013625wrv.54.1661090326964;
        Sun, 21 Aug 2022 06:58:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 21/32] submodule--helper: don't call submodule_strategy_to_string() in BUG()
Date:   Sun, 21 Aug 2022 15:57:30 +0200
Message-Id: <patch-v3-21.32-2bb45302392-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
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
index ebd3e118eb7..75bba8621b2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2158,8 +2158,8 @@ static int run_update_command(struct update_data *ud, int subforce)
 		must_die_on_failure = 1;
 		break;
 	default:
-		BUG("unexpected update strategy type: %s",
-		    submodule_strategy_to_string(&ud->update_strategy));
+		BUG("unexpected update strategy type: %d",
+		    ud->update_strategy.type);
 	}
 	strvec_push(&cp.args, oid);
 
@@ -2184,8 +2184,8 @@ static int run_update_command(struct update_data *ud, int subforce)
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
@@ -2215,8 +2215,8 @@ static int run_update_command(struct update_data *ud, int subforce)
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
2.37.2.1279.g64dec4e13cf

