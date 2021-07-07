Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2B0C07E9C
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 02:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A68561CAA
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 02:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbhGGCef (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 22:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhGGCee (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 22:34:34 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC45C06175F
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 19:31:54 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so841673oti.2
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 19:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JuykJGXW2IoV62Ky5yvn5UIC10MTAqFTdOSI2+8lGcw=;
        b=RDd4SqDnLRhH34m3aQKOh1tnO9l75W7gNHJ0xDifS7MbUw5Deq2dhIo2K1Eqzs/fFY
         nTOm+ZXhtZ59eBlN9h2gWbjEe93na3hkksPi7d9lRUyZVaBGPi4q4LYy3vTHVw1NQ8Vk
         jLIbxKJLYHUYaFFB6yesELFr0ZpEpI8SxdHPkX7WbrilL2njsdiQhWkkbPTagU/b2KZK
         kH4qxsvo+aD1nuRe3A6FInBwIbo8lWLo/RLS0g2XndhIkLC2H+NAVAL253936rBp4UXU
         nvHEUe7n50hqTZ+RrjBMGvGt4GBYPTGZx1Fd4q6ScdvWZnZzt2/hQH3dqcyiDWyhpli7
         9dTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JuykJGXW2IoV62Ky5yvn5UIC10MTAqFTdOSI2+8lGcw=;
        b=lwnS9U4mSTFYTjP+LMdBBCpCHLLNLzACtjTVhascrGj0Kfc3bCJYxoWAa+lPxXFAx4
         GZjbLmT0pxMIxKFK2bcJMrejDsQvmAF3ay4Us4iIbJWB1nhL8Q9eXP5cC+RIuZ9vUmlc
         MPg3cbk4W1HcB36R4dlDJWYLtSVrxqIUXzUoERsfPvlHqasahiGyVo8d4fGp0Lls5AFD
         dzdJNrcHZ2TnK1OwdNuYQgldudIMo9pDSkIEH4RInv+S9erf6bqEhXP0jpUNelVbDOG2
         Q0kZbQ0elCwc9SyQ0Fxq9FinLyNAAwst7TU5FunbnfsDh7U0hEGACsBN3DkHACJam2pn
         WUmg==
X-Gm-Message-State: AOAM530M630Qi38jlzVWRj3Yq7YDOMGRT8M2EoeTqWKT0DI7q01UdsjU
        rnSfgXItGLC56ecg1FdZtKBt3L93T60=
X-Google-Smtp-Source: ABdhPJwZjdzehsW1p3+hr3TY7/ra6UN3owqQmYtDSgMWnUUHIr/L/ovXziFv0uFHLFf5+u9bNIvHvw==
X-Received: by 2002:a9d:585:: with SMTP id 5mr17909222otd.12.1625625113245;
        Tue, 06 Jul 2021 19:31:53 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id 91sm3030102oty.73.2021.07.06.19.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 19:31:52 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 3/4] completion: bash: fix for multiple dash commands
Date:   Tue,  6 Jul 2021 21:31:45 -0500
Message-Id: <20210707023146.3132162-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210707023146.3132162-1-felipe.contreras@gmail.com>
References: <20210707023146.3132162-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Otherwise options of commands like 'for-each-ref' are not completed.

Tested-by: David Aguilar <davvid@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 05606609f9..1feb2ee108 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -421,7 +421,7 @@ __gitcomp_builtin ()
 	local incl="${2-}"
 	local excl="${3-}"
 
-	local var=__gitcomp_builtin_"${cmd/-/_}"
+	local var=__gitcomp_builtin_"${cmd//-/_}"
 	local options
 	eval "options=\${$var-}"
 
-- 
2.32.0.36.g70aac2b1aa

