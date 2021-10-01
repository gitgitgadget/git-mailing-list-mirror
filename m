Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CE7C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AB1661A40
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354536AbhJAObP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 10:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238622AbhJAObM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 10:31:12 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D127AC0613E2
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 07:29:27 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id s24so7374924wmh.4
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 07:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q2y8zrfRtDHg8OX+AT91kIksW2WfT5rFXf6dNBiaze8=;
        b=DbU6LGwDouGAxH6R0+TyRwPHjvwEpls6kpdaEguQZM3DWWeKUTTtCKMAx7ANKTd1jH
         G9aUUO/W7vm9M1FM3VWyZdsIcxo3iB6gvcr3/ggKWmCKfv660BzjMHcIbo6hzdRv6spc
         fwlQw6ZWd+89VfOOOBTJxwY+dkyc7qZ1/SmuVfO32fWi6Z2sjlBO3vblI0ipZ1kPmX6s
         lVKMEMRoqxSy4TIh7ncnUF8lMROSJlulSMEHhI98sPZKHGPAMkfp8nCfmUm1ScGiDH7Y
         p55csq2wUJoZMQO/aI4lGhiImaogvtWEAcY28C4UbG95trPqQQcS45ezh7W9VOOaW4Nf
         KEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q2y8zrfRtDHg8OX+AT91kIksW2WfT5rFXf6dNBiaze8=;
        b=DzGklaH5FTAnn2V7kVVbt4pffHTP20JIOCljPPXEoDdqfA6edbdjmDigWZlQmREz2l
         FGgcGWFEvJ9Jhu0LbRqUr1HGdSV/vzEPhVgs0fPRDYo4ij9yVutZH61dUgXhZiLjDwqs
         c1PR9rdXRNqW1hzXQSws6mfMA8ql6upGR75GBjVJEmOzp60CTDpwqHn0d1qkEltntCXp
         8DKPHLilrC4+KLltd2q1qtpWjjZa5gRAHCk0HroA9tGP/MjrO9e2nEJRAFA/K8uHUjUZ
         yty+6/gEHlCTfuKoC1zouj036xav4CV06dyGFtIvY2wOR+9QY6rutlSjJlUrF2nDH1Mn
         SaHg==
X-Gm-Message-State: AOAM530zXOPevu9iMOmBjUNZKYlE6IhyHq1Du+fnrHVL28dcWOh6fxXj
        rKO+ND86mWwtXZCEW7nBzsXqqZ6JzxAR1A==
X-Google-Smtp-Source: ABdhPJzyGhrIgb0RZ+pa/DbhdalafPogVaWWyoAZkl+gDT5k4gMypr9rfbGz8QFZmg6IjNyG0zyaRA==
X-Received: by 2002:a7b:c303:: with SMTP id k3mr4863029wmj.44.1633098566094;
        Fri, 01 Oct 2021 07:29:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 189sm9042069wmz.27.2021.10.01.07.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:29:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/11] parse-options.h: make the "flags" in "struct option" an enum
Date:   Fri,  1 Oct 2021 16:29:12 +0200
Message-Id: <patch-v2-06.11-34669327550-20211001T142631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1374.gc8f4fa74caf
In-Reply-To: <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "flags" members of "struct option" to refer to their
corresponding "enum" defined earlier in the file.

The benefit of changing this to an enum isn't as great as with some
"enum parse_opt_type" as we'll always check this as a bitfield, so we
can't rely on the compiler checking "case" arms for us. But let's do
it for consistency with the rest of the file.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.h b/parse-options.h
index a1c7c86ad30..74b66ba6e93 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -134,7 +134,7 @@ struct option {
 	const char *argh;
 	const char *help;
 
-	int flags;
+	enum parse_opt_option_flags flags;
 	parse_opt_cb *callback;
 	intptr_t defval;
 	parse_opt_ll_cb *ll_callback;
-- 
2.33.0.1374.gc8f4fa74caf

