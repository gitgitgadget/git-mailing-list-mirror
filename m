Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E238C433ED
	for <git@archiver.kernel.org>; Sun, 16 May 2021 22:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 154DB61159
	for <git@archiver.kernel.org>; Sun, 16 May 2021 22:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhEPWB2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 May 2021 18:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhEPWB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 May 2021 18:01:27 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C832C061573
        for <git@vger.kernel.org>; Sun, 16 May 2021 15:00:11 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id b9-20020a17090a9909b029015cf9effaeaso4482057pjp.5
        for <git@vger.kernel.org>; Sun, 16 May 2021 15:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uS2z7qlP5QLTfs5EcIVo9nzS37wSxh/OSxGoRL3D6UA=;
        b=tyXoiZRw2oMd642b7xR+88s9+2LAdH/PmE58V/EglzATW4Rb6GUW0TrbL6IsWT1uIk
         MOJpJKinQkcn+M1qavxu4j11IKkOFyshkKuVv3lipbTEaeW/NODn+RbxKE9iYO3j9g3z
         cKUj7b0E53HBV0cpODmW9VY6vOpQVV9/ML0f2nxhMcn5as9lcZjzDZF740IxsHvt2ip/
         /nPkeAEMprmmWz3iIWsj8LqczeN92S62hL6O75VrbYqxBthfbDcy1Df6nc4JiIpJ12GC
         fcA0s1z2m/Qp3nX/67kAcHWh9BtwBkmlY/hMpIiIZgGRXEmTq5DtjAtG82kF5o+mQdKY
         kiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uS2z7qlP5QLTfs5EcIVo9nzS37wSxh/OSxGoRL3D6UA=;
        b=MENXkcI/h+oxszY9PHso3ULuoTKmdCkKriWZNm9yVAax+QQCAUW3lbRZkmO5ELW6fW
         OKmdq3cS2si384LD8k/7FLdriVxjSYdHgY2QeDTvjiyIewdLBJuRDOYJFxYFATqrmDMm
         CU22bAqumXBBzpxSrQM3z7XfdlsQGQNMZhazZNhX8YN0O+mmGogZ0kuNbuw5VU+1YIjG
         xXhx3oEIUbvjoBsxPI5ewoxHS7MkHm/35K3rbmr+RWWuRE7W3cb6exaVPJR2r+CPa2pe
         pbp7OS9/4JwDSar9ZVoE2OeRPRLdW5X38pEiKGaDzfUukUd0t99X2QJmxWBfru6na5uw
         VMjg==
X-Gm-Message-State: AOAM531uJwJNhD3/8E6nhsub99kBdaTzmJ0t/8KZxBHV3OuGINoKUz6W
        EncJ6mF7lpEjufoV8UuZo4D2H+5TCHyUbw==
X-Google-Smtp-Source: ABdhPJwhVkQ0UUm8EOyEg2zXWwZQTU9sWNk7UaO5F30d8GOl+UhP3Sikn/OU2bYAZ5EKPY593AoAaQ==
X-Received: by 2002:a17:902:bd09:b029:ec:7e58:a54a with SMTP id p9-20020a170902bd09b02900ec7e58a54amr58430341pls.62.1621202410788;
        Sun, 16 May 2021 15:00:10 -0700 (PDT)
Received: from xavier.bn-i.net ([2001:470:b:65c:3ff0:7a20:2df8:dfc8])
        by smtp.gmail.com with ESMTPSA id u1sm152004pfc.63.2021.05.16.15.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 15:00:10 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, pc44800@gmail.com, chriscool@tuxfamily.org,
        stefanbeller@gmail.com, kaartic.sivaraam@gmail.com,
        Johannes.Schindelin@gmx.de, shouryashukla.oo@gmail.com,
        gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] submodule: use the imperative mood to describe the --files option
Date:   Sun, 16 May 2021 15:59:57 -0600
Message-Id: <20210516215957.33341-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/submodule--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d55f6262e9..ae6174ab05 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1300,7 +1300,7 @@ static int module_summary(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "cached", &cached,
 			 N_("use the commit stored in the index instead of the submodule HEAD")),
 		OPT_BOOL(0, "files", &files,
-			 N_("to compare the commit in the index with that in the submodule HEAD")),
+			 N_("compare the commit in the index with that in the submodule HEAD")),
 		OPT_BOOL(0, "for-status", &for_status,
 			 N_("skip submodules with 'ignore_config' value set to 'all'")),
 		OPT_INTEGER('n', "summary-limit", &summary_limit,
-- 
2.31.1

