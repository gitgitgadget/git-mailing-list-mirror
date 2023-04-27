Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E43C77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 05:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242725AbjD0F12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 01:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjD0F11 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 01:27:27 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D001FC2
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 22:27:26 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-2fc3f1d6f8cso5076522f8f.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 22:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682573244; x=1685165244;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJywranT9wFKRLzQVk+JFMniy4yK1sbmYRTks7Lr16E=;
        b=U8Fg8CswW3j0T5Ibck+fmXWtofRYVd9J7m19N46OnDYWKesxhIlkgSPuQ8u3oaaynl
         fxkiXQwbMrK37w5REnlOHpPdcIpEZA/o4FjZCAXALYXOO1GWuduk78X4tx3DJ4OBIDlm
         cWXJHJxKpA6L8PfSEfZVf+wgUbdy7IlOdbiQFUdNGdC6wV/Y8/s/AxgGDhJE+HrpXAkT
         XTL6NcTSW2+bp0uXs/GmoOgys61+oCYHL9mY7iznbhrFo21D3TzK3SPeFA2PvhUUQwQI
         aB0+8sn/0zNAxibG9t7clCC1V2k4QTNLsmsnbwpH341c1xOShLYrJBP4YffIIk7T6vDT
         mp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682573244; x=1685165244;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJywranT9wFKRLzQVk+JFMniy4yK1sbmYRTks7Lr16E=;
        b=ij431MKJqZgr4F7HauyDSgmhkbzlSOwUEJinyANHkEuBNOCljMKZ7BiOQ3GoReM8Ke
         TX9BlIVKd7CbAIb7fRBYm1poMv7FpnVNF1lK9vaigzKUJ+Qi2wCazUB2jue7oZXawBDe
         OKtBe5rA5AmqsUAboYXKcgdC1ZMKlJoBvmHp0l8i+5MmZu/jeufZWQJ/C1la4QHUmZ3e
         SrrdLRUhLte32RATqfmtVnKajnpkD9GTwTACgps9EEfuz4Pdn4P5T8vqeMOHlYigRXck
         M0/xdRV2XSEiDdIJDXJE49KcCyIuoSAIWs758A391KMX1bZWVWZcZrVtqicA7VAqEZRN
         QDaw==
X-Gm-Message-State: AC+VfDyot+/7SbxLDKUx1VgqotBvQddby5Whk9EfHxNc/YqpwaIFa8hf
        shPkm0wpMyUqpqf6HPR05b0TOYuoZf4=
X-Google-Smtp-Source: ACHHUZ4pqn97/pbl9UM1hs39J5q7AUCzKRoaEYAee9Z4p+1wLPloEsysfFGv8lIOMLK8qAnYy0NUAw==
X-Received: by 2002:adf:ed12:0:b0:2ce:9d06:58c6 with SMTP id a18-20020adfed12000000b002ce9d0658c6mr241398wro.53.1682573244013;
        Wed, 26 Apr 2023 22:27:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t12-20020a5d690c000000b002f74578f494sm17465562wru.41.2023.04.26.22.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 22:27:23 -0700 (PDT)
Message-Id: <pull.1499.git.git.1682573243090.gitgitgadget@gmail.com>
From:   "Dimi via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Apr 2023 05:27:22 +0000
Subject: [PATCH] contrib/completion: fix zsh completion regression
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Dimi <dimitar+github@pagerduty.com>,
        Dimitar Roustchev <dimitar+github@pagerduty.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Dimitar Roustchev <dimitar+github@pagerduty.com>

From: Felipe Contreras <felipe.contreras@gmail.com> @ 2021-08-16  9:19 UTC
[1]

Despite 0b18023 addressing a regression from 59d85a2, the issue
described in [1] still persists as described:

  compdef _git ga=git-add
  ga <tab>
  ga __git_find_on_cmdline:[:16: unknown condition: -lt

The suggested fix to set __git_cmd_idx for the _git function wrapper
worked for me on:

- zsh v5.8.1
- git v2.40.1

Signed-off-by: Dimitar Roustchev <dimitar@pagerduty.com>

[1] https://lore.kernel.org/all/20210816091935.548555-1-felipe.contreras@gmail.com/
---
    contrib/completion: fix zsh completion regression
    
    Despite 0b18023 addressing a regression from 59d85a2, the issue
    described in
    https://lore.kernel.org/all/20210816091935.548555-1-felipe.contreras@gmail.com/T/
    still persists as described:
    
    compdef _git ga=git-add ga ga __git_find_on_cmdline:[:16: unknown
    condition: -lt
    
    The suggested fix to set __git_cmd_idx for the _git function wrapper
    worked for me on:
    
     * zsh v5.8.1
     * git v2.40.1

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1499%2Fdroustchev-pd%2Ffix-__git_cmd_idx-regression-zsh-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1499/droustchev-pd/fix-__git_cmd_idx-regression-zsh-v1
Pull-Request: https://github.com/git/git/pull/1499

 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index cac6f618817..a1f2d278179 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -271,7 +271,7 @@ __git_zsh_main ()
 _git ()
 {
 	local _ret=1
-	local cur cword prev
+	local cur cword prev __git_cmd_idx=0
 
 	cur=${words[CURRENT]}
 	prev=${words[CURRENT-1]}

base-commit: 2807bd2c10606e590886543afe4e4f208dddd489
-- 
gitgitgadget
