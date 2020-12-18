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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92454C2D0E4
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 630DD23B8C
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgLRVLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 16:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgLRVLw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 16:11:52 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B965C0611CE
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:10:50 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id k7so892317ooa.0
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WCoF4V5PqhUQYsEAL18dofYAQioY8Ya2E2hUmGPD06c=;
        b=OMRoJUr9SzmeweByYhjwFUf3w7R4MyCa/HPcM/8PYJFG9R+N2te9o6aK2v2cTluKfa
         Z9dvzTpWNWAkmk6gZ6grU+0UH6u+d7VkWgDWMJLJ9Y6PFaueyScqOGWBR+YAEJQzIGBc
         tnwjIKVPUUyDSFnlZ7ytr4hLMpBqDGIvDI0/rS+nLEgE+z94+9kpN4cfmcON0jexcT0x
         tjdOR+CVF6ujWcVR8eQgkt7JmB5ICIfO6CZoqDxhn0v0IExK+A1qKgV5OWwY+vMkRppG
         CJ69FCn2kMFXaxZZgNjxrkIhfJaIyTZfLm5u53z3Z3yHdYydnow8tr0DuL6bDqSW5GrP
         ZCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WCoF4V5PqhUQYsEAL18dofYAQioY8Ya2E2hUmGPD06c=;
        b=J7hq3Kg4C7EsjJYtuhFrcBARr72FJezJzLq+s/QgajK2d5Hq4rChPLqfjTKEArKZF8
         R3nR+epsy3MRvyNdf6guqdpm4grGaXbDUVe3reY2R+uIpg8pTKaHEDqQNy8y/G+SWzkt
         VU7+x6IhTbMlyECleVGgbcllB9ZL40/1w2JtWZ/ZlUBNbfwp0Nw1IxmK2mAZEcnuucKQ
         543Q5NVV8c/50xZBlWWNW7wZ6w1RvzULZoQ5TGuq9UDI7glyXWiH2USv4Y4rbm089L7X
         UUfoBiu+vxIP2j/Bm6g5rVCURZwLu/ZRSEiiIrfh2gmwP7g0PTCEaJvruNIuTE39Ad8k
         9DHQ==
X-Gm-Message-State: AOAM533me1ZkfLdbdaba7M0EQ+xpQ8aclc/ysBYO5AaAjiaUyqUfxGQ1
        1PWiz77I1vLZF2QNHrRjNWH++HLZM8NKtQ==
X-Google-Smtp-Source: ABdhPJz7o4UHhWudLcOoRe4TgRJpt1FpEQzkjPu5a8ZaE9xnTjxPwVdyqv0CRd7wwr/K+Vd8aclPtg==
X-Received: by 2002:a4a:4046:: with SMTP id n67mr4235869ooa.91.1608325849674;
        Fri, 18 Dec 2020 13:10:49 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id u3sm2130682otk.31.2020.12.18.13.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 13:10:49 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 12/13] pull: reorganize mode conditionals
Date:   Fri, 18 Dec 2020 15:10:25 -0600
Message-Id: <20201218211026.1937168-13-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
In-Reply-To: <20201218211026.1937168-1-felipe.contreras@gmail.com>
References: <20201218211026.1937168-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that everything is in place we can shuffle around the conditionals
so it's clearer what we are trying to do.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index ef23d8a52f..ad8afabe9b 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1118,12 +1118,12 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
-	if (mode == PULL_MODE_FAST_FORWARD && !can_ff)
-		die(_("The pull was not fast-forward, please either merge or rebase.\n"));
-
-	if (!opt_rebase && !can_ff) {
-		if (opt_verbosity >= 0)
+	if (!can_ff) {
+		if (!mode && opt_verbosity >= 0)
 			show_advice_pull_non_ff();
+
+		if (mode == PULL_MODE_FAST_FORWARD)
+			die(_("The pull was not fast-forward, please either merge or rebase.\n"));
 	}
 
 	if (opt_rebase >= REBASE_TRUE) {
-- 
2.30.0.rc0

