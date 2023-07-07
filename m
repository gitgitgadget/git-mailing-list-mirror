Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFEDEB64D9
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 05:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjGGFn2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 01:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjGGFn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 01:43:26 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9B01BEE
        for <git@vger.kernel.org>; Thu,  6 Jul 2023 22:43:24 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-263036d54b9so1121036a91.0
        for <git@vger.kernel.org>; Thu, 06 Jul 2023 22:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688708604; x=1691300604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dYMjpSxCZe8sV4l4C90nTpGEz4EIj6MiXac08THsbI=;
        b=fENuXv04ym2Li5+F7SGrFeTM6allgK5lhuBzBjQnKTLPPfQ1PxtnZQ0MZq0nhQoyGo
         giPnL/7LptYRRaTRI56aRukNIgsqM5Vo4cHU8gLLtiiODR6PTiCbzWNdLtRFwBt82nXm
         WTjLYqgZ2ac2ueDXBXYxPiBapwpSVkDn78j4EEJEfDjJMSQ7zLU7dgD1WdD7uUoxqrMz
         PjxXcVQIWXi4GtO/Z0uDGrYdCm0Fz5UC4nXouY7wgCLzdn4DLMvBGk5jQbxac4AbQJQS
         Hjr2tpieA86AQkBNBOTH2vp9QhLlCWYT5ziIll62a/xtHaGZavcQkpEaOpO89fpHNjQ6
         vQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688708604; x=1691300604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dYMjpSxCZe8sV4l4C90nTpGEz4EIj6MiXac08THsbI=;
        b=YwUBi2pKo6B2K2tgKOk0ww7+9JB4AJBdV64DccWF1HGT+fIV0SCFpjPkeCTbavNjYP
         GI9oR7q9s2n3SzmvUlTHDczRi1Rd8sTLz54Nf01jGsRA7fcsMZzVdUaY7FRKe9U+DOoX
         08yvV3p8PVHfSfeSPBEwY9v2QmsaefUAmcXw1I+bcB8PnYjQQDKkAzmN5C1i+l5z91lQ
         ZRL6fBlYWdh8FVAzyGnLCqlcL/xH+CXyC/Ir3jT75BUtvtCDjaemLdF1KY3JZ4wdKJBh
         waHSTHP0aQHuBcmSbXF9nEK2drtco4aGcYxzjADQyAvq+yn3yUd5nypho0SeoRuKXs61
         SX/w==
X-Gm-Message-State: ABy/qLaltwUTqModPx24ASosSVML00q5d76eZSrHOSPH/+d3xx5Bd2cz
        KVHtXqHhROhxxZnRdxBvX+5E7psmCKc=
X-Google-Smtp-Source: APBJJlEYbbnFhbk4cieFCs5YTjVFDfaFIgQfM7pwKaeZ7LFJ4nplgssqGPMy9HJz3fH2eqphW1cavw==
X-Received: by 2002:a17:90a:fb8c:b0:262:e84f:ad80 with SMTP id cp12-20020a17090afb8c00b00262e84fad80mr3942997pjb.9.1688708603965;
        Thu, 06 Jul 2023 22:43:23 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id r8-20020a635d08000000b00553dcfc2179sm2132568pgb.52.2023.07.06.22.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 22:43:22 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email, gitster@pobox.com,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v4 0/2] advise about force-pushing as an alternative to reconciliation
Date:   Thu,  6 Jul 2023 23:42:46 -0600
Message-ID: <20230707054257.3366355-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706040111.81110-1-alexhenrie24@gmail.com>
References: <20230706040111.81110-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many times now, I have seen novices do the following:

1. Start work on their own personal topic branch
2. Push the branch to origin
3. Rebase the branch onto origin/master
4. Try to push again, but Git says they need to pull
5. Pull and make a mess trying to reconcile the older topic branch with
   the rebased topic branch

Help avoid this mistake by giving advice that mentions force-pushing,
rather than assuming that the user always wants to do reconciliation.

Changes from v3:
- Update the tests
- Don't explicitly credit Junio

Alex Henrie (2):
  remote: advise about force-pushing as an alternative to reconciliation
  push: advise about force-pushing as an alternative to reconciliation

 builtin/push.c    |  27 +++++++-----
 remote.c          |   5 ++-
 t/t7508-status.sh | 110 ++++++++++++++++++++++++++++++++++++----------
 3 files changed, 107 insertions(+), 35 deletions(-)

Range-diff against v3:
1:  9cbf5f138e < -:  ---------- remote: advise about force-pushing as an alternative to reconciliation
-:  ---------- > 1:  9626721c13 remote: advise about force-pushing as an alternative to reconciliation
2:  727e1f7636 = 2:  209e86588a push: advise about force-pushing as an alternative to reconciliation
-- 
2.41.0

