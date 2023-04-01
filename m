Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697A6C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjDAIsd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjDAIrn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:47:43 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621E422928
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:47:09 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id f19-20020a9d5f13000000b00693ce5a2f3eso13139857oti.8
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXjHHK/LBHkZDi7Sw4UnHfuXPId30xB8hrZ9iOTLeg4=;
        b=XNa2CgzsQU9IIfwVaZZhBh4Iugzz2/1vGebnAhKeQa9JkSP2muzF0uKeEnUkICzOYe
         f/aS5koert0ldkWjbuwgK8kAruZAPVcAdRt0vhf1poKE2cQSz2SVnt/7cZpHZavFPonL
         j5v76jurhOOIkTpokEeaI26gHkuGW3Y8jNzpayVNQhWJq4pS3UsIv0YRTZ4/5P+45XKv
         ZWjCI47Cxi1pwNKqVrSdOK3pJh6RPSsYZFR6V+EOuKzjyQ+qGDyMeFmA+a+PFPxLm7zn
         2xOlsycEzOsQKN1ncxxbPnx0APu6xOlRLBSlEKG6S5TrSYfDZVsgtRKz+gzQS/sWEoUt
         LZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXjHHK/LBHkZDi7Sw4UnHfuXPId30xB8hrZ9iOTLeg4=;
        b=fTL2WLoek35nExuw7Y8MxB8aV8FAlpTZZ8NmngTcRx7fHfSrsW/V2nUxWfYhwyffJx
         wSYdf5V4mQqptjxb6RGLdGhQq2kaQ33foKJBSczIcapWEMqxDAOd9XTZOZP9FeT95KSG
         f5LkVY0cDIU0/RQs3HJI/WbHpiHJmWKIc7ElQoWrmd+xHSmtZ1mHorQoriU9+iXpNFOX
         wKTNrKLLPjueYr+M4NIkVowkgaiReviQ52JipuouGsEsWZU2cA5DPhfjQN2b9aZh2Mrs
         588m+vdmIUsh91qg4KRLWh7MkBv/hO2V++mmUuRsFjjap9htWybFE3VeK7Ja1h4vjulM
         l8Bg==
X-Gm-Message-State: AO0yUKVebOkO0RUzL1iwF8RuGO4x2jZX/bC6SOfKwVlKRT0IhxTzeG9n
        IF/pHXs3lnpSrRRIYJnqBtzwZ/ETv0c=
X-Google-Smtp-Source: AK7set+snAyq0UFNkzbIAXMbIM6SoTxnA0byaLyl8l7rcJHRZxHe2G2cXiVOnXt49w+wVeKH3OzZ7Q==
X-Received: by 2002:a9d:7514:0:b0:69f:cb63:2f18 with SMTP id r20-20020a9d7514000000b0069fcb632f18mr14094181otk.15.1680338828905;
        Sat, 01 Apr 2023 01:47:08 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id u1-20020a056830118100b0069fb749271bsm2065193otq.15.2023.04.01.01.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:47:08 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 30/49] completion: simplify __gitcomp
Date:   Sat,  1 Apr 2023 02:46:07 -0600
Message-Id: <20230401084626.304356-31-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not possible for $cur_ to have anything more than --no- at this
point, so there's no need to add a suffix, nor check anything else.

All we are doing is checking that $cur_ matches --no, and adding a
completion if so.

This way the code reflects what we are doing.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 5 ++---
 contrib/completion/git-completion.zsh  | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9de394b223..502a1657a1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -352,9 +352,8 @@ __gitcomp ()
 				continue
 			fi
 
-			c="--no-...${4-}"
-			if [[ $c == "$cur_"* ]]; then
-				COMPREPLY[i++]="${2-}$c "
+			if [[ --no == "$cur_"* ]]; then
+				COMPREPLY[i++]="--no-... "
 			fi
 			break
 		fi
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 029ca23e50..04265bcb22 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -63,7 +63,7 @@ __gitcomp ()
 	for c in ${=1}; do
 		if [[ $c == "--" ]]; then
 			[[ "$cur_" == --no-* ]] && continue
-			array+=("--no-...${4-} ")
+			array+=("--no-... ")
 			break
 		fi
 		c="$c${4-}"
-- 
2.33.0

