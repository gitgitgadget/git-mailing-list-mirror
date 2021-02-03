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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF1EC433E9
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D6F64F6C
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhBCD3I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbhBCD3A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 22:29:00 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FA1C0613ED
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 19:28:19 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q7so22548794wre.13
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 19:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HP0yyJ4j7RACAlRFx8OBETIiftoiMIfiR5q9Tabuz8w=;
        b=JaH0w8ig6Gp7GM8wQ1wNaHsOjxjGCKEi9UBhFLjb87tliInKV9eZy0GRM0PGSzAzD/
         oHsdFirfFnUxMA1nYcIE2MkN1KqKJcBlIUb1LtwoMESIb7gal7nvxtbCzop5nH9yehNM
         0s1OhfOc2zbdIdsBt68uNKUkMG+JeRMkVB+0yoVu6+u9QRERvV2jkGkIAH5ljTrCnQUM
         0Eoi6gYggOM0ICm4OJPMH9yZEBDN67B7UYLqFnkovM1aUsK8RL/IgHFXS7/2xfbmR/4S
         5RUL04GRtHSy1olt/dA2HXHl9HyHNqgogkXeI9zDXZ8lzBGA+BvQ0M9AE3Jp2yLX6rw2
         uKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HP0yyJ4j7RACAlRFx8OBETIiftoiMIfiR5q9Tabuz8w=;
        b=p9OHTRbZABGEHnInIJnVYY0Dwytjr+KJV6TSsldXnru3KGRQzg9zXwI8PS4T2s7+Fs
         xsTv/jzBG39rsTFV1MCltlWTPPbeWJr8P2zULsaUhn6UdXtnIL8DLbnF5UbcaG2IloKM
         kqbgAfOr5jbJDnQEYR+HkDgifJykcn1/6KDK6UQLDXEnNflDcj39xllKtpRoXfoB973e
         +nMwdVHpGTvcPCKNczVWmJAOdBLsga55y+8SfZhrjXtzpD6JuCW35EOfSrAzF86pkYWT
         Cm1NQ/XSWglTYcofCAEiqk1NtTzye2SK8PI+UnpwFjO6OVZx8F0Kw0oRS2EdVayp9rbH
         W7xA==
X-Gm-Message-State: AOAM5319BcLipSZhtDZxcYSBVOlTJ0hHadO1sEZPlBWzZUcv8cOxRelI
        IkJa2BFmrH6NsS0ADg3kueg+FUI/MWZ5Bw==
X-Google-Smtp-Source: ABdhPJyVhUpQ3rxLcuIfiDMSj6pga3jftMFwhp2x4JMfnW6TOwFhBx8TFA2afgYFRMY20Xa6EW0Tgw==
X-Received: by 2002:adf:f508:: with SMTP id q8mr1042727wro.291.1612322898392;
        Tue, 02 Feb 2021 19:28:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c5sm971089wrn.77.2021.02.02.19.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:28:17 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/25] grep/pcre2: drop needless assignment + assert() on opt->pcre2
Date:   Wed,  3 Feb 2021 04:27:48 +0100
Message-Id: <20210203032811.14979-3-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
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

