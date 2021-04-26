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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2E0C43460
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682FC61158
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbhDZQQB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbhDZQQA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:16:00 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55641C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:15:18 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso38527174otm.4
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EXhQVrixx2+pq4Ekm+UdPUFL4GkJdNABGJxxo6XQMbQ=;
        b=U6RhpmaDmbcnN409DWcjMsvNkJpy7t68nzQkhbMmC+slWaR2sI1r1WvwsJVoopT2O4
         t+XpV63oYTCQuqWrThBXcqELu1h14PTo5iJ69uWnaKaTzyjlwMV1sS8UiaY8F4r8z3QG
         3a9WQESjEh7GfmWlJ7DV/16jrvKj898ryQPIglPDKDH3j0TEQzOeUUJGmzliHDg2pE4o
         QYuxHGQhRGo0pEFfa3YW9irzuokhmFW5NPFYMF/87HADEENJS0BkjyJ9QKtfQuBP/lWx
         9pandYpEoX6JmnFhp3SIzDz1NyoDNLo1OODWu8Wv9PsRJmcMGR4eLYx07H3vjD8Hto4d
         Nruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EXhQVrixx2+pq4Ekm+UdPUFL4GkJdNABGJxxo6XQMbQ=;
        b=i0kJ7MG/XLG11cXR0v6w/5K6kf+k2Ip/FbHcQ5XdrVtdf4pctCnOVzERKCbWsZ5ThV
         c2ag3gumrJtXe6it2XpAEOHt3PjHs9fCoNfga3emd2CIn9jw4YbSLaYwpiJD+H4FzaHL
         Ytw1KB/j+pR0xLMtTUTTUJ/Tu3KQ7PGlQ63XQsA8O/y6+qV7UpNvgtUOHqOLeZfYs6Cm
         kr4/nJQffAKo4AsTzuwxoQ+BaNLuAmPee0qZgjJYHwxYxlDcXF2NIRjtAngLc8wu9EWg
         lGnxjKNzJ4lml2YKt4nWqW/LAN6+bgG3/dq4nibWQY3FEbX7al2o4d4J4ahCWuYQvYaK
         vMOw==
X-Gm-Message-State: AOAM532WFlx4SyYaVHR+Y4N4GTr7RXcm77VRhe8mbHy4mHxxT/0DS0gM
        VquijOgi4/xbIA+roILXW391ZrHF8ayYpg==
X-Google-Smtp-Source: ABdhPJzcKPOFL4OeKTWX9FN6sv6XCUyQcMp3S14yMVbqUet9yFL61E1eQ2915XBHzTYn9yeCLaJgXQ==
X-Received: by 2002:a9d:5c87:: with SMTP id a7mr15595876oti.292.1619453717519;
        Mon, 26 Apr 2021 09:15:17 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id j125sm3115328oih.10.2021.04.26.09.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:15:17 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 03/43] completion: bash: fix for multiple dash commands
Date:   Mon, 26 Apr 2021 11:14:18 -0500
Message-Id: <20210426161458.49860-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
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
index e7173cfcdc..bc19792a51 100644
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
2.31.0

