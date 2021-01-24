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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8D1C433E6
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 02:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1092D22B51
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 02:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbhAXCN7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 21:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbhAXCNg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 21:13:36 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB2FC06178B
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 18:12:55 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id u14so915946wml.4
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 18:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AM9QuCZGS+PF11PLhLic4kof6DkGWJzpkhV96cwlf/0=;
        b=CgVXbVgwKvDyjinYzjsBkCAcfvBUMNkpus6Mt9p3FDrEcQ1DY8eM5EuZobyLYd91Qj
         ISK1+vFZutzADxxa+PMUV3ATqyotqzDQR2D2CI9zVMPkSiNSkZH/LmOb3cszh+3Spq0T
         cK1ilOuDeLrHKu052aPQbrftoXNSU4U3foPcMmAvwh5ShvgcuVxUqdTZJMaueqH/yBYN
         Lv/DTgw0WApeCnXnDJi1cQRej/qIdOcj9s/PssK9Af8MPPzeT7GWtmqAi1oOcyXPNkRp
         ne5ZP9jDF+XbkKn0jRlcjcKUG5Y3JPLR7wGtKZg5gIQPBqW0Pm3PsQq9HBJYerXuMq7O
         UHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AM9QuCZGS+PF11PLhLic4kof6DkGWJzpkhV96cwlf/0=;
        b=VkztUrIcvtVnFwT5tYFz8szW66JdBv1SLlYOi9VtA0z0Q19/wU0EKN+Jkpf964Edfp
         1/MnZUD3gSq3gAervqlYSQsm/hD15k9jWM32xRw8c1hT9tOfqprQI9QhBOCPg/XFFXvb
         Ace9TyPW5hjr9mxRcK/6Du7pJefwGof95qeQ8xxQjHd7HSPAwQ4+55xUGDcwHZl/t6PW
         TJZJCvY+lZzyyaZXCu2UX+dJdl0RR7lMN/0XZ/6ObFD/rrxMxjn5z6IcDrbWxgx0FvGu
         NAvg9vcZ4302wAHOXcTA+bydoRR/qle6Qe+PepF39v12NuAOmCPGUFh/9NXeEDp6fWiC
         GsZg==
X-Gm-Message-State: AOAM533vQcPGkbwLnLYDJvKEv6fPq4YJwOWF3z1hLoVBFqVS7kqc9bAP
        uJDrUVPKE32hLSN0MvT5R8K6LBTqsOZsIw==
X-Google-Smtp-Source: ABdhPJwy3cq3x2S8BPIQQbmCjDGj1OdCe808vlm4VNhrIvWbZOkNWd8HPpeOaG4nzUo9eFTXclMUcQ==
X-Received: by 2002:a1c:2003:: with SMTP id g3mr9850080wmg.90.1611454373921;
        Sat, 23 Jan 2021 18:12:53 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z184sm17380129wmg.7.2021.01.23.18.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 18:12:53 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/4] grep/pcre2: further simplify boolean spaghetti
Date:   Sun, 24 Jan 2021 03:12:28 +0100
Message-Id: <20210124021229.25987-4-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20190726150818.6373-9-avarab@gmail.com>
References: <20190726150818.6373-9-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Follow-up the last commit by splitting the fixed check for the
PCRE2_UTF flag into a variable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 0bb772f727..242b4a3506 100644
--- a/grep.c
+++ b/grep.c
@@ -473,6 +473,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	int jitret;
 	int patinforet;
 	size_t jitsizearg;
+	const int fixed = p->fixed || p->is_fixed;
 
 	assert(opt->pcre2);
 
@@ -491,7 +492,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 		options |= PCRE2_CASELESS;
 	}
 	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern) &&
-	    (opt->ignore_case || !(p->fixed || p->is_fixed)))
+	    (opt->ignore_case || !fixed))
 		options |= PCRE2_UTF;
 
 	p->pcre2_pattern = pcre2_compile((PCRE2_SPTR)p->pattern,
-- 
2.29.2.222.g5d2a92d10f8

