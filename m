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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5238C48BE8
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85BD2611AC
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbhFRS1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbhFRS1m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:27:42 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACC8C061767
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:27 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id s23so11483079oiw.9
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rIj5VHjfncGl08rsJXzX8Ox1qBPz3MsC2VSU9ACiJTw=;
        b=q5G8UdJ6REIYf6G07CJjeKLJnFrxQLB4Cvr1jFiV7dZhDuEMrH+obkvyWXkocvy3E4
         BgCQP9EPcQ/HBJ91V+j/ODUbauuvWMU89JfvT2Euvi8Bg4fUzYl2BnEDd5EKhPsffyr6
         UrVLCKNMM5Qxmko2pNZj2LtJCHWnTc2ZCuTHSY5DtzESrSRxQBoahDjCjRDCqDSCE210
         ZTtAt07vxSxs5+aKrJkF5lbU1sxzt5Y3HQztUtd04yS2vbchlvFZFLyp6051ZmjsDc/t
         MehYWFAiF52bsWSJ0lGd5PtI1H6CROiqzXpKzBWZo8jFFgV/SzZBwn9n9R2oxKpyOs3q
         Nymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rIj5VHjfncGl08rsJXzX8Ox1qBPz3MsC2VSU9ACiJTw=;
        b=XIh0eoIKDm+hjEh4ocVZu/yqqGbELajNr1F0DnvpOsYdTBjF1g6ltCHWIfVSCAED5i
         2gYkb7XwwThJqbuxHq4v+t01qZ9I916ymBSQihDIvy0zXZj498KvAIk90zrPo27CUviP
         5XCi+CFbSZAfEjWfoQuxI5ILlMgSmViHq1J6bFxyg8ldqEZIc5ov6AfxaRrdgbuOcup9
         fZVDu1dnvIf9yfolYFfqV5BUQDv0EOPTTc0EuZ0PcMf81jhANZhdrics5wvJQdERhgQd
         cAU1ATqMWMpnBRvAGuts9n1wIH7aeksyKq3Ltjod3Otw26oCCOLXAm4HgzgPdqVYE3/Z
         TttA==
X-Gm-Message-State: AOAM531fJu/wtFldyjkMbL55cg/pRdXrKyguziOCKjOhWhovtN8z1iA0
        bAWeL1YgPSRwJzchMMhCU6WuFGPpWyQzwQ==
X-Google-Smtp-Source: ABdhPJx9me5cka0tEA9tNs2jnyzfboErGROdjSmmHTRiuaeX7dzYnIPOBr7zGQL1sRqm9CsxlvG1yQ==
X-Received: by 2002:aca:4f52:: with SMTP id d79mr7932133oib.39.1624040726843;
        Fri, 18 Jun 2021 11:25:26 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id l24sm1910159oii.45.2021.06.18.11.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:25:26 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 04/45] completion: bash: fix for multiple dash commands
Date:   Fri, 18 Jun 2021 13:24:37 -0500
Message-Id: <20210618182518.697912-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Otherwise commands like 'for-each-ref' are not completed.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 80b7c3eda8..279d2d8b1e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -421,7 +421,7 @@ __gitcomp_builtin ()
 	local incl="${2-}"
 	local excl="${3-}"
 
-	local var=__gitcomp_builtin_"${cmd/-/_}"
+	local var=__gitcomp_builtin_"${cmd//-/_}"
 	local options
 	eval "options=\${$var-}"
 
-- 
2.32.0

