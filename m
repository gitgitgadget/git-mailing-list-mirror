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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C71DC4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CAE260F94
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238398AbhHEHUN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 03:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238484AbhHEHUK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 03:20:10 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB583C061798
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 00:19:55 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so9527341pji.5
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 00:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wW5DjSZqp+Dhl/nWLGRg6nwqM/EOuy5TG7n2/Uyyfww=;
        b=sZSVzor1dJB8JD6LMVhxFQ0RTD/DPyLav1E7ti/pgKMmJIgyr9hgXGGSJuVz0D5Mul
         dccEUNoPYwTnwsbzniiB3N7ddaHh08A14K6MC5UlE4f3YFSUOHyyDfQP3rxd/9uUKG4p
         pVr1TPJDarHTlZSy42SJTK4wKa6nBXLnYE9jujAqsmU0UzyxdG0aTl3XIuIWuueYiR5F
         GsTUZ3my6VSNF6/i7fIeDc5sBCbniezwuEpt2d1cRjangn7ySHFKS82dzqwKP6fRFYsD
         f9a8djeHlZfCgG6gtdRiFncaXWZbDyLtoLkKrCTNNyy20C9GshxmguWDjy4Hw7zcGp9M
         n4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wW5DjSZqp+Dhl/nWLGRg6nwqM/EOuy5TG7n2/Uyyfww=;
        b=JJoduZbPJ+z6MfR5V+AwcjPEVA9rpYS/ZnUhYGem8ANV/ZBgZB6XsrOcPu3JExnsmH
         oksWDmVCdcVNu/iFG7+ckDKwyyknMu1WeoMlbQSTI0FV+hvNoLtj2CD1Q+IR6UTy+1Q3
         P6cZli49HkxK/iWGWZakh6bEeDoPVe/z7hhggDXJKPAuimjK1L69z9fovgl6qXShNEtL
         Mwk6gFLRLglXE7PD6rpifJUZR5GV8hkOWPBHWyDNaA/5kysO8kFoL/8G0WPtDLxZ7XXT
         eUYlsSbFhRg8LGk7R88ivnSAIgtzG/Cscr7Oq83KJF6Kbj8NTdeQWu3WtL/EBVHIyyZ2
         mLXQ==
X-Gm-Message-State: AOAM5329O9Y9WBE/q4Wtwv4Cv/tWxHzgy9mxXlSupuzUSPRh+kC8MFvM
        LcokSyvld3lzXYW+MSRspdXe+9u5SH/NBleL
X-Google-Smtp-Source: ABdhPJyY/XOkMb+g0uZq+hTjC3VNprrmQJXbDyuJq+2kfT0Wf7F1fvpvONTwXs6d0bkvTR+lxi8TyQ==
X-Received: by 2002:a63:cd4c:: with SMTP id a12mr694975pgj.449.1628147995309;
        Thu, 05 Aug 2021 00:19:55 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id p17sm8569603pjg.54.2021.08.05.00.19.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Aug 2021 00:19:55 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, "Emily Shaffer" <emilyshaffer@google.com>,
        "Jonathan Nieder" <jrnieder@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Christian Couder" <christian.couder@gmail.com>,
        "Shourya Shukla" <periperidip@gmail.com>,
        "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Prathamesh Chavan" <pc44800@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        "Rafael Silva" <rafaeloliveira.cs@gmail.com>
Subject: [GSoC] [PATCH 4/8] submodule--helper: remove constness of sm_path
Date:   Thu,  5 Aug 2021 12:49:13 +0530
Message-Id: <20210805071917.29500-5-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805071917.29500-1-raykar.ath@gmail.com>
References: <20210805071917.29500-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is needed so that it can be modified by normalize_path_copy() in
the next patch.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
---
 builtin/submodule--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9b676c12f8..99aabf1078 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2748,7 +2748,7 @@ struct add_data {
 	const char *prefix;
 	const char *branch;
 	const char *reference_path;
-	const char *sm_path;
+	char *sm_path;
 	const char *sm_name;
 	const char *repo;
 	const char *realrepo;
-- 
2.32.0

