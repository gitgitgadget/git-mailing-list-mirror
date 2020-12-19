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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3F7C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 14:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D870623A23
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 14:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgLSOHG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 09:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgLSOHG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 09:07:06 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6F6C061282
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 06:06:26 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id s75so6246509oih.1
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 06:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/605Qy9s5MEJFJHL+uiIa48BAgK80FPJPXrwEo0axfk=;
        b=twPhQ7fkUjMgSqJ6gVOFRJ8zqGmiH4nTTGrJzjgkKXgwp2epHu3RdJBunonp6rXhzW
         6/tJh6QSCiy9gQUyu0p/Bxg1mELt/hHj/zqTWKwpHdLL8vUgwWoqyaWt2Bh7hUaBJpix
         1pHyD8s4Dg+m759WWE8Ah7DYi9hNEkgKb/j2O5EBgvKhBiz3iwECP3QF/WsYoj6i2UA1
         7lUrBjl3Zl5v1mJiJ8GZdcAsNTyeWJveS1jp/uLs4fJEGiLPeiSSZiXWU+5FKkSLvRwz
         Z+8+KlO5uarokkOzpfeWCcLvvrId/uXD9riTPKq/LcDkurcZMV+01+bEUnl0P7ijNbzR
         mfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/605Qy9s5MEJFJHL+uiIa48BAgK80FPJPXrwEo0axfk=;
        b=Epfv3sahj4H1M3YK3a0l7HALmpVFiqVNKjm0NBn06dZHz3Om8lpcHVpDjBvgzhp0La
         Mdi/OZewMDXW+ldcjSgdXkBbTEn3cebP341mBYPHehSfVwTbGErYPPVVNT1PV3Vx3udP
         b/dSVbo/dAmeUCwMyAw4aF+qiEO6tj0Tq2XAZPn26UV7Ibs0mz2D8gs/xnNpZe19X6j7
         nd3NjH87JWRAB9ZexexZqqTNRhpF7RZoV3b1vaFBpdneovlRWuUdRWHhZ2OP4WH1IizW
         sPWq9RskAjfPMPdCeuwGrk5MrsOQZfaoV33nsTTd/9K/r9UpRuuAtKeisD1M5oagrlYa
         54HA==
X-Gm-Message-State: AOAM530r6wGo2I78J0xHKlOIQOYAEZTNHkSZjbUX0YeMMygbKbSfQm3/
        rcCjT4S/KNGt/LH68A1mrr0GRKpdexoxVw==
X-Google-Smtp-Source: ABdhPJxzfxTEqwyCmHe088lWZ/aXbECmmDqmWB8A281keX992EdyA+YPnDU7LLNYzAwgyJZiOITezw==
X-Received: by 2002:aca:a98e:: with SMTP id s136mr5838496oie.116.1608386785467;
        Sat, 19 Dec 2020 06:06:25 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id s9sm2408895oie.53.2020.12.19.06.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 06:06:24 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2 1/4] completion: bash: fix prefix detection in branch.*
Date:   Sat, 19 Dec 2020 08:06:18 -0600
Message-Id: <20201219140621.1961760-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
In-Reply-To: <20201219140621.1961760-1-felipe.contreras@gmail.com>
References: <20201219140621.1961760-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Otherwise we are completely ignoring the --cur argument.

The issue can be tested with:

  git clone --config=branch.<tab>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7c81e4ba49..b866b68b3c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2615,8 +2615,8 @@ __git_complete_config_variable_name ()
 		return
 		;;
 	branch.*)
-		local pfx="${cur%.*}."
-		cur_="${cur#*.}"
+		local pfx="${cur_%.*}."
+		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
 		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
 		return
-- 
2.30.0.rc0

