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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05C4C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99C5D613AB
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhGEMfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhGEMfX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:23 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63184C061760
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:32:46 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id r29so4177374oiw.13
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f/XjHp84gR4nhhd/wr7xj9B256dmgyCzuJvw0eFg7QM=;
        b=AauQqA6JbMkgUT9c2O22ffCIsgGdge1uHCANK7fIW/u2YpQwRtTT5/BZptjdAox/FK
         gFDRlbEepngJsI2A9fDbp3lsbftBn0pIb+7xQER3LhwFHJ5yxwiQ/YEj6z4Ntpc36TtP
         K51w5f6sW8b98cEp16JE/2tmfH3J6XtTxQOvx5FhMB1npyuxlLEGQqNmquV6ImaxK4IN
         sITMQqko/522xobw6qeOs1QM8jr9K4WYNEzeGHsfq+LvAg2u6dFl9+j9pnsCeXoe/EFv
         4s/K/7T59NRCea5y93xS6dEGByW7pl05PnlpIXS7a24eL71tkst+nvG8My2/JwBXl188
         JFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f/XjHp84gR4nhhd/wr7xj9B256dmgyCzuJvw0eFg7QM=;
        b=GeDwtCOsRxSgjA/Y1nvq1ICONaCeN9IiDVCaA/lP87cmSrVNS6bIQlVMPAf2hbr65Y
         Vhv3h4qAsNelolUzZzR0t36lMFiLZdZ45E0iXaMj5aK7Zeh6mwqZwC4oN0xeaIubXQ26
         X7qBcHQFVL+WXM0ZNRL+tb4Gjt5Vrg6yU1s3gb+WnGyYfMlbxm57XUnv6CsuLyHQU19G
         JJHgosQBTBWN5ohqCeElU04X6RGVQ8YyyZB7A2Ws+RrlziOzUOjgR9oSKML269DSSpcQ
         aVoiS1m22T0OSVmQHQJxXyYkE21sKr9lulFZN9q7hv+u7VpBb8UNFMYfIWdOrCBxdZQT
         xDIA==
X-Gm-Message-State: AOAM5316/YXQCZCqYswO8tOY9BnoYscnOfg4GfUBiys6ey5s0jvYD9hQ
        dXInPmckwRx/w6yhy1IopCXX8RIJ0lalIQ==
X-Google-Smtp-Source: ABdhPJzYI86GeMxxu+E9EDoo/eP+PzfvseLyaBkIrAbdHed1NyXmfjrNlzf84MrNR5gDBauAz94quA==
X-Received: by 2002:a05:6808:15a6:: with SMTP id t38mr10326275oiw.157.1625488365631;
        Mon, 05 Jul 2021 05:32:45 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id n20sm2609036otj.11.2021.07.05.05.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:45 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 20/35] pull: trivial cleanup
Date:   Mon,  5 Jul 2021 07:31:54 -0500
Message-Id: <20210705123209.1808663-21-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to store ran_ff. Now it's obvious from the conditionals.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index a22293b7db..80e2f55cbc 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1053,7 +1053,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	if (opt_rebase) {
 		int ret = 0;
-		int ran_ff = 0;
 
 		struct object_id newbase;
 		struct object_id upstream;
@@ -1068,11 +1067,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		if (can_ff) {
 			/* we can fast-forward this without invoking rebase */
 			opt_ff = "--ff-only";
-			ran_ff = 1;
 			ret = run_merge();
-		}
-		if (!ran_ff)
+		} else {
 			ret = run_rebase(&newbase, &upstream);
+		}
 
 		if (!ret && (recurse_submodules == RECURSE_SUBMODULES_ON ||
 			     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND))
-- 
2.32.0.36.g70aac2b1aa

