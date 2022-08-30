Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2AFECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiH3JcT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiH3JcK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:10 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBEDD99C0
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:31:51 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-11dca1c9c01so15397556fac.2
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cN/9QVEPFa0gEMZ6LgcZQAx36uetIV8xXC6pStWfzik=;
        b=oG0ikbVuU0BiN8LTVVP06WsDXehlFJgJiz9tLPg81t68hIte7L/8BmSyuzDLW4V6he
         Zt/frlvfxaPZS5VxXwO41l6lKhCcTHNhPjb+JDn/ks88tIxuZBgCT3l3yrOqvjQZrPis
         DkuTjyCpzrxrBku77tfgIaQQca8MtfEfTmajrFdYkTtc/8R87CGYX96ps7ZT1HCCS2bF
         zuv6mSxL5DQrrSdwNyOUuF7q8Ajw3GqCrDW2BhzwJsvS74r3BAg5I1HcoiFMgkO/PFlr
         SpKQz64Q5gJHkv9D/pjfbjxr5ot+ccRuC/rom2vixhbqULafsxHowiS/EljYUyl1YM7F
         6Keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cN/9QVEPFa0gEMZ6LgcZQAx36uetIV8xXC6pStWfzik=;
        b=6h0ysrRjS7cKAWxr+4zKnpH8XFhKZGiLsznZ6Th1F6GU+/JSPcty38Bjl1eWaP5Coq
         xTV/NUOd1raWn2xM0dtpwX8kwZfnHrPZsIg+KTXsPS+EuThZvRHfkRDwoyMoDWpYOY1c
         NDpppb1+BNIBc9dE5MTMvX9LeUIjY/WTDWmlREwuVdbf6de1KKYuqyPI/3Wgv3USLPsx
         A/5+q/1BVLjrZSjnzlwajbEJKQy6GZapnu6pEfqLN3MX6UToUj/CUZXDUeGoc+BeFQZB
         4DqiqJCpdNh+0/MTExk2ES9YoKh571WqqDgUvIBjoIwRnT1RyWK5DnBTMSlJ8h1bwg0n
         P8Ew==
X-Gm-Message-State: ACgBeo2glDe25PG9V6Q3gON89KiG7HQh8Wsp8x256mlCThovc3IEg6/C
        eEKG/hNsGEDQWsb9JeCmpuhJfP/+fYA=
X-Google-Smtp-Source: AA6agR7HdzyJD3S43FiNORuWqYWAkT2O21g3NwpGJGnCMEBsPFrLDjYVNCuq/+K3wziqGwCklLH3OQ==
X-Received: by 2002:a05:6870:b61e:b0:11c:d598:e612 with SMTP id cm30-20020a056870b61e00b0011cd598e612mr10089362oab.261.1661851910875;
        Tue, 30 Aug 2022 02:31:50 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id r130-20020aca4488000000b0032f0fd7e1f8sm5842509oia.39.2022.08.30.02.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:31:50 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com, Michael Bianco <iloveitaly@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 06/51] zsh: resolve symlink of script
Date:   Tue, 30 Aug 2022 04:30:53 -0500
Message-Id: <20220830093138.1581538-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael Bianco <iloveitaly@gmail.com>

When using zinit the completions are symlinked to ~/.zinit/completions,
this causes the zsh script to not be able to find the bash script.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 535cf03176..1a405ba0a2 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -33,7 +33,7 @@ if [ -z "$script" ]; then
 		bash_completion='/usr/share/bash-completion/completions/'
 
 	locations=(
-		"$(dirname ${funcsourcetrace[1]%:*})"/git-completion.bash
+		"$(dirname $(realpath ${funcsourcetrace[1]%:*}))"/git-completion.bash
 		"$HOME/.local/share/bash-completion/completions/git"
 		'/usr/local/share/bash-completion/completions/git'
 		"$bash_completion/git"
-- 
2.37.2.351.g9bf691b78c.dirty

