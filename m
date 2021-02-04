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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E1EC433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 21:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B8A164FA7
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 21:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhBDVHC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 16:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhBDVGy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 16:06:54 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEF3C061788
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 13:06:13 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f16so4304140wmq.5
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 13:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nb2aFZd97c/wh37Gd4ijmsU13GYAH3g2f72fzvQUjWA=;
        b=F5IEN0BNEB75rxE/slhRUsXsL/La/MDuuA7A1wUyo2j1Ue4fDrgPHp/WQWtPhorRIz
         2yxIOEecHq/GoBs+RPU750zA6Dmo3Uxk+Dp8plaJi44gId9+SH1wNB+31/GXOT0oF8MP
         VhcJ+iYhoCPTpZKHPQWd6F3Epi2/mbZ+cQqHYUADYrisDDPaIbb2jaoT4PDEadNLVCup
         bDTOBhUVR0FDn55xnQysrKGsQeJO2Gt6zA42ysWy4dzgC0CPfZGLGjMhKeqfmfVWDsce
         0/lecOhObpTPB7fEBOqIg/U8Z4Ywe4H31QgX4gKnYwN6KVXzrQ4TnslUDvhn+4nu9kxK
         ioAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nb2aFZd97c/wh37Gd4ijmsU13GYAH3g2f72fzvQUjWA=;
        b=cS4BMo7qSfIfu6pSpzQIRlSNMUkuTfftIzHByNCqNR5gAZrlsFWQBI8St+aU4mTGQq
         rknEIFydVCQRFqZ0iYDiJjnpeanj5yHhtMNK75iuLpyVEIqJnAZp6BFLyx6PTfP+NfOs
         8C5x6i488rFGeGfJYuPJxWLn51/tb3pGMmqwz8w5mOd/NLqO9SDd+3AS1UHpjrcZpfNu
         2+Dh69z1flWJTMFULom6shTt4Rk2v+/jyKMSvQHeU6tDRpF9ScU1XX4ZcHtBOLkuhT5D
         T4u0WfIub2D7PNSU9cKKb1SkNMXjJmcfcV0IvO60e/o3EfktH4jL4Cvidu8TAk7IzWqq
         0Bag==
X-Gm-Message-State: AOAM532HGQuQcS6dhe7oS1emtH4DfpJOti44tXb8ZBTShOsvL5pVu0K0
        aGy2Ne65yUMfpU8T+sAFF5PIPprPctGWxw==
X-Google-Smtp-Source: ABdhPJyaEOjpwdskl1lfyym0d8XaI6yHWING38r/wRAbUpjEtkdfWwnGNqghs9s62xoFCSLmgMdEGw==
X-Received: by 2002:a1c:a553:: with SMTP id o80mr874438wme.20.1612472772169;
        Thu, 04 Feb 2021 13:06:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n5sm6779318wmq.7.2021.02.04.13.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 13:06:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/10] grep/pcre2: drop needless assignment to NULL
Date:   Thu,  4 Feb 2021 22:05:48 +0100
Message-Id: <20210204210556.25242-3-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <191d3a2280232ff98964fd42bfe0bc85ee3708f5.1571227824.git.gitgitgadget@gmail.com>
References: <191d3a2280232ff98964fd42bfe0bc85ee3708f5.1571227824.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a redundant assignment of pcre2_compile_context dating back to
my 94da9193a6e (grep: add support for PCRE v2, 2017-06-01). In
create_grep_pat() we xcalloc() the "grep_pat" struct, so there's no
need to NULL out individual members here.

I think this was probably something left over from an earlier
development version of mine.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/grep.c b/grep.c
index 816e23f17e..f27c5de7f5 100644
--- a/grep.c
+++ b/grep.c
@@ -373,8 +373,6 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	int patinforet;
 	size_t jitsizearg;
 
-	p->pcre2_compile_context = NULL;
-
 	/* pcre2_global_context is initialized in append_grep_pattern */
 	if (opt->ignore_case) {
 		if (!opt->ignore_locale && has_non_ascii(p->pattern)) {
-- 
2.30.0.284.gd98b1dd5eaa7

