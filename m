Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBCCC00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiHBPq0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiHBPqW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:46:22 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCBB1580F
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:21 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j1so10034051wrw.1
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=VvW3WPczGfSoBgGavD27zF7Rjcor4+sXptybSynaGf4=;
        b=RO0+av0rNG8kSx5WbnDPmGooUpp7aIl6pbJyf1KpTaqua1ZpUZfwdnLpyk1Nx/FHzz
         Ok9R5X8plmmK/LzVIxTEgigh57uJPP73T/WrjyQ7WyRwfgMs365/Dvztp79KEYCNKXrC
         If+h05L0q8EKa4yzpqcSdRFjIr/OBaEIA1sPDcbuYOZGU9hDof4b6qg6TSMlTG456OSv
         DYThF1kELkXDbummiJqJGTQC10/G2qnFyXWgLbeDll+MXBpd7YkYEVHuxhoqIxt2Komy
         KazxZvKR3MCTS3dvwM12tZrl2ruAL8WK9GV0py2N+YuEHLsENioZCSKApHRGLO1Z/wJf
         H8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=VvW3WPczGfSoBgGavD27zF7Rjcor4+sXptybSynaGf4=;
        b=Z+Vvvdy1IFXNZn+O1RiSOKggjhoLq4OK9X+2HsoMVXOYereWu8gvuHlDwHokwqRe78
         Gl1o6mmiR0PXqowZnNuY+okKY2UBYwjoofR3h1QWEevCjlUPRzkxhWFlvnM/PNA0TgVa
         b7blErXxonRcWQjUpCHJRdepVaMjgfg90Ph5I5qDdvSMvKeQGGDZ1/SyLakkBXKM0jYY
         sDxvI0t3V+UgoCDhlzniCyAbNUljMSNybawnGN1qm5Qm450Q5eSoUhM1mfGZ+IFqnj3n
         pg6Uyw/2A1YbgyerWFrs0CB5FGCu7VkrIJfS/fDWJ1ak7qKHk8RCyur4Vw9rgLPEzH+2
         Mjyg==
X-Gm-Message-State: ACgBeo1wbnVcMxY9GV9bCvWSEI+xx2GVD2LJEi0FhLSiYHIEuauUhSJq
        JLFygkjLIVO88a0JU1uWIeiIj9qTS1Z0ag==
X-Google-Smtp-Source: AA6agR7Es+uoUaCs/STF/aBbzPufnyQ6y/2hVkkyWh0wvYOLsQ9ttXawkp9AFxXlvM9A5Pz+H5LggQ==
X-Received: by 2002:adf:fecd:0:b0:21f:d78:743f with SMTP id q13-20020adffecd000000b0021f0d78743fmr13667836wrs.704.1659455179915;
        Tue, 02 Aug 2022 08:46:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/28] submodule--helper: remove unused "name" helper
Date:   Tue,  2 Aug 2022 17:45:47 +0200
Message-Id: <patch-v2-03.28-d981db49fa1-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "name" helper has not been used since e83e3333b57 (submodule: port
submodule subcommand 'summary' from shell to C, 2020-08-13).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fac52ade5e1..ac2553ba9d3 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -771,24 +771,6 @@ static int module_status(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int module_name(int argc, const char **argv, const char *prefix)
-{
-	const struct submodule *sub;
-
-	if (argc != 2)
-		usage(_("git submodule--helper name <path>"));
-
-	sub = submodule_from_path(the_repository, null_oid(), argv[1]);
-
-	if (!sub)
-		die(_("no submodule mapping found in .gitmodules for path '%s'"),
-		    argv[1]);
-
-	printf("%s\n", sub->name);
-
-	return 0;
-}
-
 struct module_cb {
 	unsigned int mod_src;
 	unsigned int mod_dst;
@@ -3359,7 +3341,6 @@ struct cmd_struct {
 
 static struct cmd_struct commands[] = {
 	{"list", module_list, 0},
-	{"name", module_name, 0},
 	{"clone", module_clone, SUPPORT_SUPER_PREFIX},
 	{"add", module_add, 0},
 	{"update", module_update, SUPPORT_SUPER_PREFIX},
-- 
2.37.1.1233.ge8b09efaedc

