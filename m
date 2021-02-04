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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971C4C433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 21:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CDAE64FA7
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 21:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhBDVGz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 16:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhBDVGw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 16:06:52 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0F1C061786
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 13:06:12 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id w4so4312630wmi.4
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 13:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HP0yyJ4j7RACAlRFx8OBETIiftoiMIfiR5q9Tabuz8w=;
        b=b/aeuef1XntTT0mrnRQ6xSn18zX9n37yTSt+FXsbMWcjf7AiE3ja6Kzu2+kKYzwNQJ
         rodHER4RNY9ne4H8YskaNO9kN89uYW9Y9kDaJMNzGfF/mRBGKIEa3RU0IDIIAMhMxERz
         RArfSYm3AzX6qp7vXLPAdXVSIeTLtR+YSwVPFFnPqeqaGs4FF/F3ox2fWpNMb4U/QbC1
         IRSDDIq9dt1Qg3Hh/63KrGXTQivH6MROH00kiLPWs/+x/VRhfG/7fUgjZhCaJZ2f/S9h
         cD6JwQVCF1Qgmp3ku93fKMx9c+AAnEcHLl+8cUHS242CejR7tEEyAxrWch/EOn/ImHG2
         oMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HP0yyJ4j7RACAlRFx8OBETIiftoiMIfiR5q9Tabuz8w=;
        b=bJOgOT92yM2YOOIQZV/Yeq6YKqmqQgmE34svG19lnI+3QLBBJKPyKNI7QJoiNetsTl
         QtSCYUEAyeSRd7aAsl2ZAKz9iRzJA7DUe8VG3FL661U0tuoA3BCrd9iMOUNoGU02DlHA
         Kudds/aKk413nNGGEw2eo+adTcUGRRhIT8vrutMpaE+9zIXwmM6wXXA9JFbrKLBAg5jf
         5R0YXV3UovJ5fKA3rAcgs8tW+VVjlOfmOVnd3x8SjidFCrTcl92df9abwt1/P5voSMJ7
         wwzsCgTv1O3/WXn8eKlenrLZRf5EhaIEEwUNRTjujAT/IHwzsaGCWAlbi+CgRTYqCUqU
         8sow==
X-Gm-Message-State: AOAM533F2dXnMHvH5H5WdH87q//8Ep8bcTHpIEJcgdbf+tNbW55/+R5w
        l58lFulfC7jn8vqMerEBdEFpffHfep4=
X-Google-Smtp-Source: ABdhPJxtMn6G0slgEV/KKEKqW2FCzb8tWodf75MI0I2oF4dDlbmJiJy6xdfo6D2lwePrJaugfn9Vfg==
X-Received: by 2002:a1c:bc46:: with SMTP id m67mr898485wmf.82.1612472770993;
        Thu, 04 Feb 2021 13:06:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n5sm6779318wmq.7.2021.02.04.13.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 13:06:10 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/10] grep/pcre2: drop needless assignment + assert() on opt->pcre2
Date:   Thu,  4 Feb 2021 22:05:47 +0100
Message-Id: <20210204210556.25242-2-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <191d3a2280232ff98964fd42bfe0bc85ee3708f5.1571227824.git.gitgitgadget@gmail.com>
References: <191d3a2280232ff98964fd42bfe0bc85ee3708f5.1571227824.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Drop an assignment added in b65abcafc7a (grep: use PCRE v2 for
optimized fixed-string search, 2019-07-01) and the overly cautious
assert() I added in 94da9193a6e (grep: add support for PCRE v2,
2017-06-01).

There was never a good reason for this, it's just a relic from when I
initially wrote the PCREv2 support. We're not going to have confusion
about compile_pcre2_pattern() being called when it shouldn't just
because we forgot to cargo-cult this opt->pcre2 option, and "opt"
is (mostly) used for the options the user supplied, let's avoid the
pattern of needlessly assigning to it.

With my in-flight removal of PCREv1 [1] ("Remove support for v1 of the
PCRE library", 2021-01-24) there'll be even less confusion around what
we call where in these codepaths, which is one more reason to remove
this.

1. https://lore.kernel.org/git/xmqqmtwy29x8.fsf@gitster.c.googlers.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/grep.c b/grep.c
index aabfaaa4c3..816e23f17e 100644
--- a/grep.c
+++ b/grep.c
@@ -373,8 +373,6 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	int patinforet;
 	size_t jitsizearg;
 
-	assert(opt->pcre2);
-
 	p->pcre2_compile_context = NULL;
 
 	/* pcre2_global_context is initialized in append_grep_pattern */
@@ -555,7 +553,6 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 #endif
 	if (p->fixed || p->is_fixed) {
 #ifdef USE_LIBPCRE2
-		opt->pcre2 = 1;
 		if (p->is_fixed) {
 			compile_pcre2_pattern(p, opt);
 		} else {
-- 
2.30.0.284.gd98b1dd5eaa7

