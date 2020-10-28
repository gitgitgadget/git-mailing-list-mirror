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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BA3C55179
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85F3A20738
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uRTD7U5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404338AbgJ2COW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 22:14:22 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34670 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgJ1Vfr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 17:35:47 -0400
Received: by mail-oi1-f194.google.com with SMTP id z23so1130954oic.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 14:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oaPxypgvAa8C9LKBaA2PdQDmPILjY+4WEWIl8qkq+dc=;
        b=uRTD7U5x59EeESKSjUGB7uSi2AIzSsvlyieJDS99LZsj5SrASW/Q+9shOJ3WaLShWS
         oHK4mGN+ACBIV5PVFqG9TxVGYlHAhVUqJUn7h7AZiYA8YOYJ+IXGN2/9fgpDvh9lhAvK
         KsG2uBP02PT7ZO6/Euykq18WXYNiCvCoEH73yuzdweNM+35/1U3G/BfT5Y1FXHOqK5X6
         aDWDGk/yCFiGMS78DOS4NCX0mg4VsQXUeFXEYIC0If7cDj7oLYwvmZqL5EelHPmD3vpS
         ROh83TUjxz9EOcm2Eem9AiAVQ9iGwHvqnpPurGsNDOZoseAiQ+Q96AaMf2GPeTt2/p2C
         GLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oaPxypgvAa8C9LKBaA2PdQDmPILjY+4WEWIl8qkq+dc=;
        b=D59ciqLkYVQWNbTcEnk9R5dLTyfVLpp0xWP28KJPBawDjcZhl0svC/vFPai3XEmdQ5
         ycrjFPp+8dYln3fH1lAqNMFIyNOHO6FkRTHbGggUxg2xOP18Ia8kO75EScfxWwBbS777
         q/46sj1U+ljZzTd9OmzpYDixivnoLk8KoRs8UVBL3UoTzDlQMKtcFw6Z6s/t2ceQ4wZg
         WBMsXi6Y1XW7ojnQMkRwTwLa0iriFLkSPeQHCizBLJxA30SeLTN1n48q8JrS5QddqA5u
         zo2mEFLczUxI4ttILZk1zOlpOZ38yNM9OEMcJw3X5jIsYq2Tk0TUeQXWR2J9x5AkIsTA
         DN7g==
X-Gm-Message-State: AOAM533IrFsYQYsu7XVqxsURFOZO/GJXo//vnzLdJb6gprRgm1SZU7J9
        dIBmI6PEp+4FcfZihgD18XQHzc1vhAeSyQ==
X-Google-Smtp-Source: ABdhPJzYwOPFvUUwU737puINSNWewxnb1AFXMtsgJWuTrmW170zDjGz7hhO3DxuE19dsmJs9BBlrUQ==
X-Received: by 2002:aca:f0c5:: with SMTP id o188mr3447996oih.95.1603850865828;
        Tue, 27 Oct 2020 19:07:45 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id i16sm1763566otc.71.2020.10.27.19.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:45 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 19/29] completion: zsh: simplify file_direct
Date:   Tue, 27 Oct 2020 20:07:02 -0600
Message-Id: <20201028020712.442623-20-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com>
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
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
index 7126c75001..4834ebc889 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -124,9 +124,7 @@ __gitcomp_nl_append ()
 
 __gitcomp_file_direct ()
 {
-	emulate -L zsh
-
-	compadd -f -- ${(f)1} && _ret=0
+	__gitcomp_file "$1" ''
 }
 
 __gitcomp_file ()
-- 
2.29.1

