Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14375C433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 00:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C534B64D9A
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 00:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhBRAIU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 19:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhBRAIR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 19:08:17 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C5CC061786
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 16:07:35 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r21so645647wrr.9
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 16:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UX2eXBBhEEDJfsLptNGBqMzNjoIRcQURYNG8N6HPQTg=;
        b=omoDpxvX0IlZnN0BMBE5i0W7LF42VmLLF+COfnjjuYr4eU8oyGlW4PFQhvRL4FX12D
         zS2rkLClG5f2rB24SFEztqit8OhVqBscU/WnGAORp8jF4qeJUNvWIHcbuOI9W9+2n7VM
         J0rGkxp7X8b1IDOi4iqojAobstBibc4A2djpRb6U4EUYVMLhzO3IdH4y78dj/+xvV90e
         e01UcrGXmsRqELkJKJcP4qqCPAVXovPqlBR8/CAqEt35uBfDSywSD3npBV1ufDunLptG
         F6fjlg3iQ2B0kr/+G44V4JoMj7LR+ZNhzCccUECWcBY3XAYYjXTHL7EWSlXdnmILJ4TS
         LGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UX2eXBBhEEDJfsLptNGBqMzNjoIRcQURYNG8N6HPQTg=;
        b=LunMZcql/RLv7gHIAfKMlw5ZtkVbCvGZ4nd4x19+URWF9siwidiIhUHg43whK1peUO
         NXaZQMFeIxHFCfyQQZsy6gO7WlEMUHBGK4URH/Koqf7Y4mIGw9pDNkZpqj974Hc8lCob
         jQ35b1QuZkwRNzIXVjWidlHjkL6yppr9lRdRuOs1ikd4D8HCOBtT0Qm9iNYjy+i5AMX4
         UZxlMg0IL0xD4SwwKkv7w5DChuItvT2a3JZaW1lukyPNWOat/+uT+ZiiedwgOaoot6xz
         56s1IlzHXbpVzNZviLz6Rl4UaHShtJQsRJWIUIqk/fFE67qY/r+e/+RigLYPf3fbd4Xg
         qspg==
X-Gm-Message-State: AOAM532ep6HJKmmkpPOMfSWJEEy6Q0wdE5oxOBMvbnJsv6qOb/jEBJ9c
        3k2ioqPYovP2Ub4wTEnKqy5WHbpOXTmmpA==
X-Google-Smtp-Source: ABdhPJynO9Dzuip8eH8M9A/bDmvG0qnaQgvfXKo7h42anBGlzKoVYTAHNRBFz4UV9lHnMFgW0Uq9Tw==
X-Received: by 2002:a5d:54c6:: with SMTP id x6mr1558295wrv.216.1613606854074;
        Wed, 17 Feb 2021 16:07:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r17sm6232795wrx.82.2021.02.17.16.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 16:07:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/10] grep/pcre2: correct reference to grep_init() in comment
Date:   Thu, 18 Feb 2021 01:07:21 +0100
Message-Id: <20210218000728.13995-4-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210204210556.25242-1-avarab@gmail.com>
References: <20210204210556.25242-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Correct a comment added in 513f2b0bbd4 (grep: make PCRE2 aware of
custom allocator, 2019-10-16). This comment was never correct in
git.git, but was consistent with an older version of the patch[1].

1. https://lore.kernel.org/git/20190806163658.66932-3-carenas@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index f27c5de7f56..b9adcd83e7a 100644
--- a/grep.c
+++ b/grep.c
@@ -373,7 +373,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	int patinforet;
 	size_t jitsizearg;
 
-	/* pcre2_global_context is initialized in append_grep_pattern */
+	/* pcre2_global_context is initialized in grep_init */
 	if (opt->ignore_case) {
 		if (!opt->ignore_locale && has_non_ascii(p->pattern)) {
 			if (!pcre2_global_context)
-- 
2.30.0.284.gd98b1dd5eaa7

