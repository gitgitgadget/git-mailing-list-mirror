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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF25CC49361
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 14:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D77A261405
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 14:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhFQOhp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 10:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbhFQOhm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 10:37:42 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC689C061760
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 07:35:34 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so6306705oth.9
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 07:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t6n/adBdXcMs+fient3frCGWLqZWu05GW2wtPddQtGY=;
        b=f+einu2dpdnASoLm0yukovu1a73KQ8EFATNDFYQ7Kdu8Oa4b9expYhJjRJmIU1VlHK
         0a9685LS25xM8tZ/7cjzWmFawJnR06m7of54AxjUrnXsKbzMor3bg6n5mkUFHp07iHoS
         BMFyOHFL8d9GZgK80yoj50M8ffBEFGBvmISr8ASDApogDPaJ9CUdqX7NX9/ck0lLKLfN
         Jlynj1HDlRq52GfcCtxEZw7bGYL1fCVAeen1dyxyF0AulA6g3hv2wDHVQw/6MJvflL3d
         PbRfHli+QE8wlC1w4W5gAsTWVkNQaHD37RtSAEOyHKbN6wo3vZaUrBeoLcN/oe1GPYaI
         +Ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t6n/adBdXcMs+fient3frCGWLqZWu05GW2wtPddQtGY=;
        b=ITMdbUIynuq39HI2GTEYA5novPUj4xcTuEFCQqth0lQ1+eWSrXOlXVU9/ftWhJjGmO
         DIOfEWItH63g5L1zqoRQQB3XPSUQX+kL7xzBKumwcEal4xrUjRWA6RHc0j2Vq4PdkMes
         WaR8GsZFUoWolr1/l/+K2OJthmT8N8v+1KeqCgdsfn0fnBxuWdaYr8QdwvJT1jjVj6RI
         Cga6IjU8jbVcD5az6Rms944lVzf1ri0SRls+o52V3/oo5FgG6KH/GVSvLxy3AdpwBnKW
         rJk4T8HsRGYSBy0T4AFPsPfaY/uS+8OF1n4r/Y4pg4nxglpaH0J7xK3HjV6eKuSFZf+/
         +rug==
X-Gm-Message-State: AOAM532FoTKYqdke2Nh7BPDFwDCithup7+iQWy1QcGIVfzQ2kTUMNiIO
        VyXzVLa1Xlud8gXjNNVpwT7OQv/dNulKEw==
X-Google-Smtp-Source: ABdhPJxLyiy/K466i0vkFo4EXZzrCL5MZUbETM3Uwxws7+YbH8+ImM4Ajvz9lEusJLftS5xBd5sIcA==
X-Received: by 2002:a05:6830:190:: with SMTP id q16mr4791690ota.34.1623940534140;
        Thu, 17 Jun 2021 07:35:34 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id o2sm1135127oom.26.2021.06.17.07.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 07:35:33 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: [PATCH v4 3/4] completion: bash: fix for multiple dash commands
Date:   Thu, 17 Jun 2021 09:35:26 -0500
Message-Id: <20210617143527.77329-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617143527.77329-1-felipe.contreras@gmail.com>
References: <20210617143527.77329-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Otherwise options of commands like 'for-each-ref' are not completed.

Tested-by: David Aguilar <davvid@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 05606609f9..1feb2ee108 100644
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

