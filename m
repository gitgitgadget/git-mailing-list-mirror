Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A31C2D0A3
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F34D520936
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtQvV0Zt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766875AbgJYDOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766862AbgJYDOP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:14:15 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0562FC0613D2
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:15 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id k65so6392485oih.8
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l+SRCfB33G0oz+QQo6beD7LqhaEH7L3JtvHO/S6OsbM=;
        b=HtQvV0ZtyHXquCm8uZrQ8Nqyvcrv/lD7sOVoHMpnfmCM/x89+U0EQZ04RE1QG48zSn
         GbbNkEKc80FWzZtpnE6SEaNwvDvcxgVGFfOGTSlHyKIbt/07J7UeszA9oyG8fx24jM1B
         3JIJsGBtpS+lqsbDCpOlfd268YYp2nOU/KIruCqQLqKW3vRQvBh+4fY9FAbqnRsqMhyQ
         kRpR9pmjgulI45FHX+1Z++V3yN/8Hbtw//O4lVen2acyEGHsZhlmgKYJ+E10AztUDYOb
         CViuXOU/nyqIVGen2GzFmHejyaCqlK2k4OOlUDg/szzqs6HgFmG2v58nYsxha3U3ImwS
         392g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l+SRCfB33G0oz+QQo6beD7LqhaEH7L3JtvHO/S6OsbM=;
        b=FevPuWveR7sFrindl0aSl0rmvGlNWkT+a+r2dI6HQSKTebA9Wgge69PI0kmxoQaLkw
         q7ijTBY9YJ927AAFTmb4TPTpPwQtEPG/kZa0dDx2DNVI8LwFTuaP0lU9KxwDXAQLHM8u
         bC9DhxQgpehTpmF0ESQewYh0x+FDET1ftSflpb8sMoEOLuRBEYmvB8mpDWYXIsJin9iV
         1YrwFlPQtoAfHxjaShqjuizSJhLFdDLsC01kz8ZeeoX9xlq9kMZN0pDMOj9H44ebhtUR
         NNsnmbiWVNYq/S0hFtfyptUtDftBbltDTC8bwDJcQJ3Io8S0UCOIXhd8jljcZA0ybnni
         kk7w==
X-Gm-Message-State: AOAM531PdWJcK996vfNy1O77Qyftar1g9k8EjgSLQDyIdaK+6rihdW4/
        r7iR513VQVhIqL6Ky3gNWAJG73dVrsSpHg==
X-Google-Smtp-Source: ABdhPJz+Z9rYp0vcIz4ToudC39YkpxivQKw7N7H7PzH74U/q56FK5NYol5vM0RRjb7+pCmkBHRTo/A==
X-Received: by 2002:aca:5d07:: with SMTP id r7mr6415621oib.87.1603595654233;
        Sat, 24 Oct 2020 20:14:14 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id q22sm505962ood.32.2020.10.24.20.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:14:13 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 19/29] completion: zsh: simplify file_direct
Date:   Sat, 24 Oct 2020 22:13:33 -0500
Message-Id: <20201025031343.346913-20-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com>
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's exactly the same as __gitcomp_file() with no prefix.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 85365bd2f7..aa484ad9ba 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -117,9 +117,7 @@ __gitcomp_nl_append ()
 
 __gitcomp_file_direct ()
 {
-	emulate -L zsh
-
-	compadd -f -- ${(f)1} && _ret=0
+	__gitcomp_file "$1" ''
 }
 
 __gitcomp_file ()
-- 
2.29.0

