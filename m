Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B67C77B6C
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjDAIs3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDAIrg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:47:36 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099C823B77
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:47:07 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id bj20so18419446oib.3
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbqCxcsV102S514Il6sHip0tz9GKcS3iM8S2LS0CY7Q=;
        b=kS6gHNGoZcAh89wVxJ75aeutPVvalyGrg1WHGz4wt17G+whpG6CCDwM4b27bxC9aHc
         HTG/Cn40mJMDj1iDoXn0xkGCElJ0G+iqy1J4b3LK71fzwgc+WoEaxFfDSWuqTjfIYaXh
         KKMf/8SYLN9NugyQ7XYQ3XmcUq8liQF6Lt/w7iVm1hO0qGbcjUXz8xllIVu8jx6Zzy9c
         /i6AYjCk0u72AZhjwhNBKkMcHPw1rj8mgkng3N+lXhcgByyjK6PnpK42JZ2d9gNEfvJ0
         U7HgRhaiib7+l2UHSeeKd92rX94OTQgIlhNT0CZykhdE66tne/uOLTscx9Wd4hNnkwK6
         KGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbqCxcsV102S514Il6sHip0tz9GKcS3iM8S2LS0CY7Q=;
        b=lXzanDUaGMyzRqQgvSEMdEpSPioSJEHtN4ZBNYGWnOGYbmMc1RTdFFBFI8m6d3/e7S
         LMMWcTwyklHWNafFzuyXwt25bNse7wNUBFVZWwecRjCQDVg8LNq+hmJDPoLtLxci4JIR
         SRbLkVe7nfqZyU05zr1yvKvYzC7a1z8KhEL68PwnFohU3/0X/KzW1SOrMW72CI+7g4xv
         JbA78Vl5S2wKr+sotJe54fqEjbOf6oM4KLF2NwiFzVJlx7I/aMgZ+6d4G/3KqYCFz7uG
         61+u9WD7kRFTPs0FDtgd9KqA6SgM1lc6yO1FX/IR4wkfIzQtsTBUUynOdPHY/CFU9dT8
         PITQ==
X-Gm-Message-State: AO0yUKVkUSg0d23/iICFNucbnBEIXCiIjE0ecjKbZrBGITf8u5/IIfqg
        2l/qjRFehrBoxVmLv9BkmuLmzSsxZHM=
X-Google-Smtp-Source: AK7set+NGfXltvJ4tqoSCUs65pLixcnsw1Fp974hey6Cvn6aaZDOS60OYVfGSkug06fWz1hP0Ji3pQ==
X-Received: by 2002:a05:6808:4ca:b0:387:85fc:f912 with SMTP id a10-20020a05680804ca00b0038785fcf912mr12766251oie.57.1680338826452;
        Sat, 01 Apr 2023 01:47:06 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id l2-20020acabb02000000b003896df086b0sm1864707oif.15.2023.04.01.01.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:47:06 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 28/49] completion: simplify equal suffix check
Date:   Sat,  1 Apr 2023 02:46:05 -0600
Message-Id: <20230401084626.304356-29-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We know the prefix is already '--no-', there's no need to check for the
first '--'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 contrib/completion/git-completion.zsh  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e07d5054cb..187350dbfc 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -355,7 +355,7 @@ __gitcomp ()
 			c="$c${4-}"
 			if [[ $c == "$cur_"* ]]; then
 				case $c in
-				--*=|*.) ;;
+				*=|*.) ;;
 				*) c="$c " ;;
 				esac
 				COMPREPLY[i++]="${2-}$c"
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 202f66a4f7..c9520589db 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -68,7 +68,7 @@ __gitcomp ()
 			fi
 			c="$c${4-}"
 			case $c in
-			--*=|*.) ;;
+			*=|*.) ;;
 			*) c="$c " ;;
 			esac
 			array+=("$c")
-- 
2.33.0

