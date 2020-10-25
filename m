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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2188EC4363A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC8C420936
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhOinPD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766853AbgJYDOL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766850AbgJYDOK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:14:10 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997F1C0613D5
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:10 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id j6so1552412oot.3
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DNIK1e9CQuZfwAqrisDNxC3kemDUT/aDUy5+puQzhOY=;
        b=PhOinPD5YOXfyeubd64bfkXE2Dg+OkNXkRu4ycgaq0OIDYxBC5FD4pEeyVh3HqkA9e
         Vng5c7EOEG7MLTWcOBO7xBwf4OoXw2OSozFtfv8/9Dy4nLftupa2h8Gk+hRMLLuO8fY2
         LobO//vZHlhu1mfFspd35Q5tknPX9EJbwyH5ksVHUdrxHe2O+WCHjLU9xg/lDeCEymNo
         vpJAcpn0BIku9hkf+gx7MZZaxL7XK3lzEaxedUuUOQXsbbG96ArsqBG3t5E9saribO/U
         2mCcmYzN8SV4A5UGLRymMClonzOst+rZqejXMeF7M1KBfxdhBqxXLcQUOkN7BHcc1Lzb
         LqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DNIK1e9CQuZfwAqrisDNxC3kemDUT/aDUy5+puQzhOY=;
        b=KvQtdyZxrWQXJYAJKbr4Zvl1xNgUFmLBZ4w7j5Cf+spt13gxpj7kFg5W2DOTICxsG9
         ZVdH9DTOw6N34crl+viFU/PycCnliPSwJg6l0SMWhoGwwJISNrse7gw2UpDQuMJ0gqIa
         +FIMuZC2eUhVrXAUqTRSFkZK4arMq6ACM4zLVpcDG+zpjBh7tF/COSnjrBmXX3TbJoeT
         p3oa9X74jvr8IHLkyGJhiz6AN/aNVHNQsNLoJvYaVjbAutjYuJs6s+tc59+JV7JX2Oxn
         ukdp/WtjIsmKhGrNpFITxTAN6l2VLi89BVVdt95eeGcCH/MRhKJQ0LLJyuJDG93OOZN+
         wE/g==
X-Gm-Message-State: AOAM533/bRTBTSZA6JByVrTgvFqdkjmSwKV87P7UQTmhUbsH7qrzSNyH
        oEG1unbAnhy/HIRjjBb+moLOE21lREQZwQ==
X-Google-Smtp-Source: ABdhPJy45NhoEHj+f0IRcwx0O8fsQtDPv03OQ4cuuGQe2wMpucPtURWatVqxzxHXq9COw1KfInpyoA==
X-Received: by 2002:a4a:be92:: with SMTP id o18mr2832840oop.22.1603595649752;
        Sat, 24 Oct 2020 20:14:09 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id e78sm78875ote.50.2020.10.24.20.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:14:09 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 16/29] completion: zsh: simplify direct compadd
Date:   Sat, 24 Oct 2020 22:13:30 -0500
Message-Id: <20201025031343.346913-17-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com>
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of manually removing the suffix so zsh can add its own, we can
tell zsh to add no suffix, so we don't have to remove it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 2f20fe386a..b955404fdd 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -94,7 +94,7 @@ __gitcomp_direct ()
 	emulate -L zsh
 
 	compset -P '*[=:]'
-	compadd -Q -- ${${(f)1}% } && _ret=0
+	compadd -Q -S '' -- ${(f)1} && _ret=0
 }
 
 __gitcomp_direct_append ()
-- 
2.29.0

