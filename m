Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD622C11F69
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 10:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0294613F3
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 10:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhGBKHo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 06:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhGBKHo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 06:07:44 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61319C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 03:05:11 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id b17-20020a4aba110000b029024c219a3d83so2325356oop.10
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 03:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4jHVazujQbddjLakZftMfVe06Y33hs5KXwOJycWp33U=;
        b=aDAxEVuEOm47E5VGMdXm7aaexBVBoZNtmAEBXA2smDs2nFCc8IoZXQvY7TDbZ+rLbH
         R5nqizlZv016OZYdFux9y0alahTrvWXZnci8TrXnKycYD41vrdRWbGoksIq5pZTLF08N
         amy4EePpXPm4P4g+0DRwgnQ5Pm/mq0XowUPFsF48O6UZvQFapTYX35Pi5BGyjEr2TFma
         p0BWxvUr6WCOaKM/gpwtN5ZedgyiZZMvhBo/UNSz6I+3JES+qCA3ImwYdi83tn8dPMjL
         LpIBCY1cThrvzU1GUY8fiNbWuRI3jD328yqs7vS7IIHsV5PEKli1yrIbbuib3xk4srqZ
         bdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4jHVazujQbddjLakZftMfVe06Y33hs5KXwOJycWp33U=;
        b=Ds2ifL+BsAWMP8lO69QuImZnmMOw4wjrdf39VlIr3SuHbl/LTHivytG4uUAkotrzFj
         Q3lzXLoL9TgOYYdfAroCBSENzD+Ec1SsJntet8dJrkG+56swmOvYOgTvwTFkXkPPu7RU
         +RFERLe0MafOjca+xqd3FuuteWceNhwsDK2P+OHEQRbs2Zm8ZFc8oXCYYLpUOoUjh0jO
         0sTUNsSDxfYcojclG28EoCZ3XXdNzI3WQjjmMk6M6MT3BHD7ZwnY/gSZ5+/Or09TW82D
         3XyIv2aFwu7igkhB6IGyO4eQHCiSWeIvG0hrqHkZMJUPlngF+3lsIUYvWKgZf9Mipmlk
         Kc+A==
X-Gm-Message-State: AOAM532yUie0ITsapwM+MDqI6OEv+YQyZXwEvPK+9Ie9eB+ggZAsFw2D
        f/1fDnbLwXdVisZ/BQ6EaBFF0mIk2PGznA==
X-Google-Smtp-Source: ABdhPJzF+v01EMdL+G3uKBHCQN+9X1wIp/TlEX9Fp0rMUKWdX2QI+HxYIjN1WQI06QKSdBRbS9rjbQ==
X-Received: by 2002:a4a:da05:: with SMTP id e5mr3679958oou.87.1625220310390;
        Fri, 02 Jul 2021 03:05:10 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id 5sm517823oot.29.2021.07.02.03.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 03:05:10 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/5] test: add missing whitespaces
Date:   Fri,  2 Jul 2021 05:05:02 -0500
Message-Id: <20210702100506.1422429-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.94.g4574ca548c
In-Reply-To: <20210702100506.1422429-1-felipe.contreras@gmail.com>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t1300-config.sh | 1 +
 t/test-lib.sh     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 9ff46f3b04..453222b32f 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -335,6 +335,7 @@ test_expect_success 'working --list' '
 	git config --list > output &&
 	test_cmp expect output
 '
+
 test_expect_success '--list without repo produces empty output' '
 	git --git-dir=nonexistent config --list >output &&
 	test_must_be_empty output
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 54938c6427..49b80a4eb5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -430,6 +430,7 @@ unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" -e '
 	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);
 ')
+
 unset XDG_CACHE_HOME
 unset XDG_CONFIG_HOME
 unset GITPERLLIB
-- 
2.32.0.94.g4574ca548c

