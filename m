Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4251EC433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 11:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240986AbiA0L4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 06:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240945AbiA0L4o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 06:56:44 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBE1C061749
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 03:56:43 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w11so4324644wra.4
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 03:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XKex4n5vsYSJoAwTHkyI5sGThoUowsAbtYI3zXt97rs=;
        b=aM/CqVj46isDSotd4nO1/bVZpQIn3l/eBedFbHREu0zekwCbKt2tjUCuM21VyTslZK
         ReJAJnWJeH6HIBCZZEoFOvZCyb5tjx2g2R6CwnFMwvc8HyxPxdMprvWKLx9BEWdVTcpS
         s0MdkKApdddYfhNzNKby4QN0h2R51lY1KQRmH+8bZaa3A9v2Z2/6WexWmuV2k/JpmISa
         n/WInD495IGPrQ96ecbvZ78JlFO2dUMbYblpbJQrtsieYhP1ugwdsSK42e+nrPGEcMNl
         rJFjNfmnkQw6ZO0C5wvZ7/MIGHH7QNutcHQUa1YpzbDFFjrublU3r/BHBm1Jg+ic0+Kn
         LUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XKex4n5vsYSJoAwTHkyI5sGThoUowsAbtYI3zXt97rs=;
        b=QwKHsbtHW0jdA9vmEDlZqbK4xlolCIrFhv+SyF4RNtfxMyQ2txWldYMgDL94pPxcXc
         /pLy0WwZHvMnKjhTXi99doUmVehKFOBh+UfTZFulO5yX3tsYzLdC2Jyw0Y27yA6HXlk4
         GqYLjLoH1C6O19MXJKY11OPmxjUQDJct6VQSeUiCVsN31DhRB9LB+wKKYFxUp8sObb1y
         F2qVrVq/7zdcwNrCC68ilGwvrg6BO4mBv0uD7z0Z9OBej9zkmOTvDTQXWViye5nWlQio
         WalHGd5a018Ah0Q47XzjG+BzgkmPQ/9FIDvRRmAw3nqorjHXAcFv91U+EmI2rHci/BiN
         c+IQ==
X-Gm-Message-State: AOAM5323QyJNL1uDiToio66H2ENeggmJmfzvxbO8S8GM7W/gyPrS+SCm
        XOY8M4SQIRvZizT8C6eFQgYSR2EIkqQA2Q==
X-Google-Smtp-Source: ABdhPJw+0b1ePtKu6jrYR/3mk7uEea8qdGkeh7JEeZCONxYUeVUy9/xVEm7mivlKu92RSCWtoOp4Tg==
X-Received: by 2002:a05:6000:1886:: with SMTP id a6mr2822296wri.565.1643284602345;
        Thu, 27 Jan 2022 03:56:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i94sm1910663wri.21.2022.01.27.03.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 03:56:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 8/9] grep.c: do "if (bool && memchr())" not "if (memchr() && bool)"
Date:   Thu, 27 Jan 2022 12:56:30 +0100
Message-Id: <patch-v9-8.9-61fc6a4dac8-20220127T115058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.894.g563b84683b9
In-Reply-To: <cover-v9-0.9-00000000000-20220127T115058Z-avarab@gmail.com>
References: <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com> <cover-v9-0.9-00000000000-20220127T115058Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code in compile_regexp() to check the cheaper boolean
"!opt->pcre2" condition before the "memchr()" search.

This doesn't noticeably optimize anything, but makes the code more
obvious and conventional. The line wrapping being added here also
makes a subsequent commit smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 35e12e43c09..60228a95a4f 100644
--- a/grep.c
+++ b/grep.c
@@ -492,7 +492,8 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	p->ignore_case = opt->ignore_case;
 	p->fixed = opt->fixed;
 
-	if (memchr(p->pattern, 0, p->patternlen) && !opt->pcre2)
+	if (!opt->pcre2 &&
+	    memchr(p->pattern, 0, p->patternlen))
 		die(_("given pattern contains NULL byte (via -f <file>). This is only supported with -P under PCRE v2"));
 
 	p->is_fixed = is_fixed(p->pattern, p->patternlen);
-- 
2.35.0.894.g563b84683b9

