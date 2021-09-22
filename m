Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AF0C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 11:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1FE6610A0
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 11:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbhIVLTY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 07:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhIVLTW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 07:19:22 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A85C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 04:17:53 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 5-20020a9d0685000000b0054706d7b8e5so2972633otx.3
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 04:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0k4uH2wP8cv8KQAJtNEGlGaRMUM6b8rVt2AxHxok+u4=;
        b=BvHG1oK7NFZuoppHkgv5yPcNl2L90nArW9VH/nFyK3bpeAlImtIV1oZ9e1FYbBCNig
         AvZq22mDPvrtbR4+Av8SvJSUf09nvaSIK+lFaUpApZ1+SMGp9AMjecW6IZBydMY9jXP0
         MAzmAZ4DdohOM8ZcmRDEZvwLFb778We7YginLnNRnUOlgbGT2VJ9oV+WGjZACewXpc1L
         1LeU3JptzmyVeLntIDvs5Mo6IXkFhOWQQrMEUmy+tn4InEYFeogT6RQAt4UraKyBunzj
         j/RGtIMJtEXkvJOAhyILCQkWYezyPnzws/ZByJmqoAX+PJcKZmBvtdKR6qMi/3ohx/k1
         OpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0k4uH2wP8cv8KQAJtNEGlGaRMUM6b8rVt2AxHxok+u4=;
        b=PYsoTaRH48M7HwB7TbXtt66gXBMrSbNyz9kpwigvC5DoeRQe1U5V/QlElr/M9k6yAQ
         2c6brAu8+YzDRyNoctYdM4bh4YOoTZB+NdmF+7wvukj7q/yXVdgv+9gfVyG8Sz+uBuBp
         I9RmyIWb9fmOSfA/PvwCj5NsHqkhF/jS2vCWE3NWqnCP4wMFnlfLw4NI656TfEqBYWu1
         Vd2BoqWa5KLTKqVudWKRuMA2cLECZvxrXBO06s1lXzpoolLY8/soCL4hf4fjcFolrvm3
         On6mt8H7yRIZqwM2craPgrfns6wzg7CP1+ejQttcu5p1dpZNKuwDWOc1eg4H4vM/IxtU
         9Rgw==
X-Gm-Message-State: AOAM533m3R5NWJ7kCzYZMYJOTritXJMMK0/0THnuGYMcpk7YFoq8D0xT
        a8WerK7l2rNXZ2YN6Q6HmPKMEzFP7J4=
X-Google-Smtp-Source: ABdhPJykIU3hk74DdA187d1VEBBVqohcMNR6KwMIWBZMPDDHkiEgp1jaiqyIDlXjaKrcGHHIsDA65Q==
X-Received: by 2002:a9d:77d4:: with SMTP id w20mr16069701otl.321.1632309472424;
        Wed, 22 Sep 2021 04:17:52 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id y84sm443143oie.16.2021.09.22.04.17.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Sep 2021 04:17:52 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] fixup! tests: add a test mode for SANITIZE=leak, run it in CI
Date:   Wed, 22 Sep 2021 04:17:41 -0700
Message-Id: <20210922111741.82142-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.911.gbe391d4e11
In-Reply-To: <patch-v7-2.2-56592952db5-20210919T075619Z-avarab@gmail.com>
References: <patch-v7-2.2-56592952db5-20210919T075619Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

runs cleanly in seen as shown by :

  https://github.com/carenas/git/runs/3673976105

previously failing in the extended checks as shown at at least by :

  https://github.com/git/git/runs/3657308323

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/t0016-oidmap.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t0016-oidmap.sh b/t/t0016-oidmap.sh
index 0faef1f4f1..f81aa9ea03 100755
--- a/t/t0016-oidmap.sh
+++ b/t/t0016-oidmap.sh
@@ -2,7 +2,6 @@
 
 test_description='test oidmap'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This purposefully is very similar to t0011-hashmap.sh
-- 
2.33.0.911.gbe391d4e11

