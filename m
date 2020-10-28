Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB86C55179
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 00:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5415E207DE
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 00:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxxtrG97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgJ2AVJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 20:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgJ2AUY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 20:20:24 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93F5C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 17:20:23 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id y186so1510828oia.3
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 17:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6OpLt9KP5FdRbA1PYkIm1on1UULzoMeoulti4k0DJzo=;
        b=AxxtrG973N5tOzoNQ6Eu3Ea+6HR7t3ghqBqy7QgljIfBEInSK6BtSw8+WVlVdV0ks6
         AuPiRCDuLFSeMLcNUGAjREDjVSPqhwdIfEitLj2xlXMmSfphojVAswblmYxXu/gVvewG
         CmoostUP/4YMFN8eWQe2XHFQlH2ZFwPICwDAc258Ac1ejr/yWKAaIiIpODc+Ck47ShCQ
         okiDy/LWkHA6JxhNa29PwfB62hhsMIp7/l9lUduGyTurNGhKpiCIL4IZi3T9EFoksxdx
         FITqcA5O1JSTWafMO+EHrPiDSgfPIlro9x2vrnroaZfByfCBA5qp1NylpVnTU98Cch1q
         vQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6OpLt9KP5FdRbA1PYkIm1on1UULzoMeoulti4k0DJzo=;
        b=Ve9BwIjBhAN13JvEIyVgkFQhlgx1xZqpCQdBU8m2HC5WrLECwxK7UdsGDov5dZdDAL
         abYoMlF50x2IyQ92bH5lI/DWVPdAZ0CXqLhFV3JyopBPSGinOjHhcIocQzG3DKH3+6WL
         Xa133EK2PmRrnkO/y3XLda4vNPfHUryJvut8JFhY3dEkLi63u2/EbvLz1eE6wWxWoVeZ
         OjxOBAGmKkmWTvvUHlPYKy29M0KzyJ0YYWlochsAn5tjDqgm0oCfFMzViap6xu7R6X+k
         FA6W0Py408EaJ8lAFDXdZa0Jo0/y+eEBQy416XwaI5TveNH/rrvz2pEgUbLH9uQucPdG
         dGNQ==
X-Gm-Message-State: AOAM531ibnNVyBYFIuPmwgiCudaXUFv4vXuMvXVZwJ5gBkOgVVW5ANQo
        qOS3G8gKk9UCsZMXC5dAd9F/xXMtCi3JqVXw
X-Google-Smtp-Source: ABdhPJwge6hssqVWPYiXdrhVSWmdLW9rCTFP7KWCs5yfqv24QwUo2+5IgClC7UC5qmwYd765ZSzH9g==
X-Received: by 2002:aca:cdc4:: with SMTP id d187mr3786486oig.19.1603850878815;
        Tue, 27 Oct 2020 19:07:58 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 81sm1840326oti.79.2020.10.27.19.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:58 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 27/29] completion: bash: cleanup cygwin check
Date:   Tue, 27 Oct 2020 20:07:10 -0600
Message-Id: <20201028020712.442623-28-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com>
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid Yoda conditions, and use $OSTYPE.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ed059f35c3..980ce73b0f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3499,6 +3499,6 @@ __git_complete gitk __gitk_main
 # when the user has tab-completed the executable name and consequently
 # included the '.exe' suffix.
 #
-if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
-__git_complete git.exe __git_main
+if [ "$OSTYPE" = cygwin ]; then
+	__git_complete git.exe __git_main
 fi
-- 
2.29.1

