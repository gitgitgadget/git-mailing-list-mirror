Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7959EC43470
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51583613AE
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbhDZQQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbhDZQQy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:16:54 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA14C06175F
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:16:12 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso30109578otl.0
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RKoUy7drQJiipYRKCrljZ34NjTyXIpQgKkMvUxwB+VQ=;
        b=Oy3VnXZORjItuq349CyAiovmRvLnS8zyRvt63CB+nwjJIMi+24a3c7egUXRTLbvfVZ
         evkUtSQwpoxkHwlpXOZ13TAqfMjeyzOeCvKeuI9vwO+9glmeifLChe2C7icjqjOdd+WU
         AAHwemWsspPLcNgVEQi0yd3Hz99apfKY0wOm4ShuGrhrJ15iquhGY89ZqPxD/yK7aM87
         Npc4vdTJAO3sdgLvil2ZZhXz8/Qswd0J5nyhUGTYd1nGk6cKEbNaomaqd8GtzjelTE40
         BDU+aHybF2wuk3U+iByQjjYTe09H1htaOpmL0hwUmWDNdjtTah4ijU6+TG5hdibfDKgu
         671g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RKoUy7drQJiipYRKCrljZ34NjTyXIpQgKkMvUxwB+VQ=;
        b=KrQtlXzOBVFQoItF+du7FeNQ7yg2Cospq+cyzEhi/BMPUE0QikaCQ7mah/Oe43EBsW
         o+mFyrGEO8hv30u6WABfeV2zRbegjvC+7aguRhWKjuNsB9fMsVT1Oku2NDuZeUo7QGyC
         If9Z4rbzBkrhW9wZXjAtkZZzmOnbHbZFQ8XofzDUs5eMQOsNTnJHv2kr5mOI33Qtt1gB
         vxl69vEjRaVT36pYOJg49lKzFAWxBJzWU4YshgtUm2ne1y8dA2v6M20zXCskBK2dYgK/
         pZbeTyNzRgldudDq6+V80Nvmd7PbPbaAdcA78B93D5X/7N25as5WEFw1aHJK66PQc5Cc
         AWyQ==
X-Gm-Message-State: AOAM531MNafyY0jn5p4geBUTil7/DLwaaTzfLJCgIZurQ1hgk4ZwQhVg
        yEQXW6yXgkHvyAO41xl9szwTAM2j1S4Krg==
X-Google-Smtp-Source: ABdhPJysetSdk/ETN8uxoVMcwsdT/+gaF3trnIoWDus/W7UVAUCTvyrAFkujMok061f1ehmyKdRM7A==
X-Received: by 2002:a9d:2622:: with SMTP id a31mr16024529otb.275.1619453772202;
        Mon, 26 Apr 2021 09:16:12 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id h12sm3543283otk.55.2021.04.26.09.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:16:11 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 15/43] completion: zsh: fix for undefined completions
Date:   Mon, 26 Apr 2021 11:14:30 -0500
Message-Id: <20210426161458.49860-16-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The parseopt helper can generate the completions even if the function is
unspecified.

  git version --<tab>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index a9177c7dcb..46564126e4 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -140,6 +140,9 @@ __git_complete_command ()
 	if (( $+functions[$completion_func] )); then
 		emulate ksh -c $completion_func
 		return 0
+	elif emulate ksh -c "__git_support_parseopt_helper $command"; then
+		emulate ksh -c "__git_complete_common $command"
+		return 0
 	else
 		return 1
 	fi
-- 
2.31.0

