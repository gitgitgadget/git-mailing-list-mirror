Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C33C64E7C
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 01:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4065246B0
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 01:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltzKFwQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbgKSBwS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 20:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbgKSBwO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 20:52:14 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A01AC0617A7
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 17:52:14 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id o25so4603887oie.5
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 17:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xDjeYERVmZBgLAnqXkqNSn+x8uE0/N1xNl0tBZNq1xk=;
        b=ltzKFwQZsmZ9dgHVD5aVJ/y9PsvHNxtTEA1bP827gE6iPpmh31jhTeyhnhbhyyWWyD
         /hXqFuNsyRqvg4HYWeQSzo6XK/jU9DY5K1vOu583kseY5P1zj1AuOT+TR12xW9L3ivSh
         wf0aUAp/x3teI2vhheP0oUAo9wT9mqvGBG6Pzchs3Npb7pijE0vgtZ8MS6t1NAUjLxRR
         5O/8rKHQwWeA6xHHE7Nj5WywJcMy1eaSgRMRey3M6C6BJ+bhMVK4PS1jrs9ckZy71AoB
         FKujG50cS07KDsmsCyvU8ro1Q68H7RXtggRwUU8bYa2scRIZbnb65bY+o0wyCtvSjQ0F
         nUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xDjeYERVmZBgLAnqXkqNSn+x8uE0/N1xNl0tBZNq1xk=;
        b=nMo/eUc2IDGyIBA9CvDdZNOZ/ZEuMFl4oROrXtLmfjNAuKbIJcFLQDiN0gozYK35ht
         5Hy7J4vwIuTvGMR6FBL6O0UA0IAEuuz9+c9RjWciusSKS54JD6VEkH3I30tfUQbmKuPC
         h1HchZhXYjmCyl0S7Wc8tX+GScUUX1fs1T1txP7FubR8gdRQiCnZrmPbtSJ86pmvxuGx
         ldlBZ4rdx+P0vff0lRzcwyx6lENIR8C60sv2zD/Y+w2Bn55KRWUlGQVaQU9LGsy8NUpG
         5Aj/E61o5byingoeFWgXquUfNPfPFBQ5fJVHUQbihiuyEvgjA+2k8FJppMONtmwejqhS
         9o9w==
X-Gm-Message-State: AOAM532XU4h7NIWhPh/XURFgliPEHYI6SO4CqsNFWdLZ1LiyWvBhGBEJ
        48cLaTm6voWfSI0ZD4WsjanI9UZdrJQ+NA==
X-Google-Smtp-Source: ABdhPJzkjKq38xl3qpNox49LUStzDWFxzeB0yA40MKMyExCkA8PB605BbZO5180pIyzI3ZeU24efCQ==
X-Received: by 2002:aca:fc16:: with SMTP id a22mr1392425oii.133.1605750733727;
        Wed, 18 Nov 2020 17:52:13 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id p13sm4047338oip.0.2020.11.18.17.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 17:52:13 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/4] completion: bash: fix prefix detection in branch.*
Date:   Wed, 18 Nov 2020 19:52:06 -0600
Message-Id: <20201119015209.1155170-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119015209.1155170-1-felipe.contreras@gmail.com>
References: <20201119015209.1155170-1-felipe.contreras@gmail.com>
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
2.29.2

