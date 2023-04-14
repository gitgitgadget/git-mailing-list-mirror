Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75652C77B6E
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 12:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjDNMTC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjDNMSx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 08:18:53 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08228A27C
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:18:50 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id t25so74493oij.7
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681474729; x=1684066729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SealYxV1P0U6WM8/BkNmOSbeoydiMVThybk/G9EJ+VA=;
        b=Ae/niNOGXHNj5f3hO3VkwCrv74d03r5dE+OvJKzOG0IJR8shVhBLmfF0wsSr+i81/B
         CinvW5zAbzwLI/8XrARmPItSOcNbj1nTUd4/rcb+qNqWg3CstXTUKQG6a1kghpnAfInW
         ekoGsMBw7uWIgNq7OYuRrB8kMR/JXG58hoYOVVaEY0LEgVrJiap7D5vzwcTGdWFtOUh6
         PHrHYYO/DVAZAcgCY2oawop/1urKGb0TVOs6tKbPMBhE/xUtRbcRwPwHZudFZHDir2uw
         /R1xYKo9mQjYRQtLbsGmbsDwx7V6EUeUhXOrASwFtjumtHW+Pb77SRV93i6ZJhVBaq4H
         eJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681474729; x=1684066729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SealYxV1P0U6WM8/BkNmOSbeoydiMVThybk/G9EJ+VA=;
        b=V1c/ldb61AjFmxTWUPvPupmXtVjPO41dG3VeRFnDqNjRf3oBTirpp1yukKfCn8RAul
         2L1L1GlnytHSFajHbjC9o3W1KQxi2ZBapKgRn5L2vuSTbG8ILTOLKG+AGNUDB1doOLBz
         07tHEYnDt2eNa2tcbkk9us5BdG/hmp4/MNLmUoBgoy2rf/6USZbwOS0OxtMVJatJOuie
         p+/YfxLJDZHheRWfsr4Z26I+6mJGv1lBVK7fexXCvWwhcNcnajW7y6tu1R+jTm4s/97T
         hNAS+BYH1Hg28WgMIDAi0o7dbcSgiwBhqhKQUjQ4QV79SXJgUpGStcPnz/azXNguoWrG
         QInQ==
X-Gm-Message-State: AAQBX9ex8G8dntTs8uOfT/lO++1VKxIDCWZa3uOUb6jCHkjfbyVmvN2R
        4HmrGxy17D/ufbICV8AjIGYWeX/Yylo=
X-Google-Smtp-Source: AKy350ZdPzjo3n+kNm2aG2WrO8HXrIjxktVLzAw50ous9R8aj8ITKDoRLfzIIXSYBw6Qpzgiqy5m0A==
X-Received: by 2002:a05:6808:278e:b0:386:ee34:afb9 with SMTP id es14-20020a056808278e00b00386ee34afb9mr2344349oib.11.1681474729098;
        Fri, 14 Apr 2023 05:18:49 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id e131-20020acab589000000b00383d9700294sm1601171oif.40.2023.04.14.05.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:18:48 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 04/18] version-gen: simplify v prefix removal
Date:   Fri, 14 Apr 2023 06:18:27 -0600
Message-Id: <20230414121841.373980-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230414121841.373980-1-felipe.contreras@gmail.com>
References: <20230414121841.373980-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a much simpler way.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 0d00fa3d9a..c0f6bb242f 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -33,7 +33,7 @@ fi
 
 : "${VN:=$DEF_VER}"
 
-VN=$(expr "$VN" : 'v*\(.*\)')
+VN=${VN#v}
 
 if test -r $GVF
 then
-- 
2.40.0+fc1

