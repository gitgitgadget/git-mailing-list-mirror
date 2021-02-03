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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B82C433E6
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1A4C64F74
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbhBCDaj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbhBCD3z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 22:29:55 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D56CC061356
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 19:28:39 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m1so3956853wml.2
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 19:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lLlQAJiavAXKtnme2QRCK4Rju6MwNFZoNLSbPUrplcs=;
        b=oabDgqj+aRRRZ5TCks5DqZeSCc3mRxujb8IvvfoB310JpYh+SvRWZ5Sy2e6w9r8ar9
         ncSbAF2zOG8jKpWj6dussd4hxZqM7Qzep/wc1WRTa/VhjM2Yg+kSqfiLanXKYAIfIOLU
         ljU2jYlOBsL7k0eWl9RrnVu5kVbsNrg0ZPuIXVxnh+EqILAZqu3QHK3mESIWN6aGJvp3
         9hHZg3TgTD1EAYF56j2AuzUTUQD9Q/PxusRcXmVEz/4D15coe2ci2ZFX1AaFB3aKHEBr
         f8s3IQRf0Sc4qkedZImoXl848Q79YLYoFlFZdd4Si+BL6fvpLcXzZ7Tueu25Rh1YZS08
         UDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lLlQAJiavAXKtnme2QRCK4Rju6MwNFZoNLSbPUrplcs=;
        b=fs6debMpHMMQMDpekMapOpkid7YoWN6YiPK+IR9yMdg63fiZKbZjB94L9NUrKk40nL
         p4H0ER6Ug7P/4JdBs+MN0FIFNJ7Vp2dEBkS7PEvrFNuCmIeoCa3tjVBuLOvW9l6IWtnA
         Re9XAlBqnkcF6ZVUxAEYYtQSxhJZ6ehSiqxyw9dBNAkIb0ZA7P7TePxm5iY+SirST2T/
         rGPH9gZEuw7GxPJ0xlTaG/QRqgMagDY/hPPoxh/74DSURxXzqEDEUx0MAQeLfsypqFAa
         1UrrKXsNCR/mb1vXQb/WV0itZdrlfSVVP7XmegeTdJUKpcD7/GiyiDn1ougKE+Rtd0te
         zrYg==
X-Gm-Message-State: AOAM532WrpgVGdA/BpGhq7HzKLA+NLkgfTwM5q7SjV+287s9D/Qa8xDW
        xCNOlwUkzkyfdXi1YGlJwvnJslo0Pgzh1w==
X-Google-Smtp-Source: ABdhPJw/YTuCRYPeuzw5NsX5JH1ut0QXB174Ypt+WOCVGyYZDIUhr4A9Axe2xzIhpokD7YK0HwQzRQ==
X-Received: by 2002:a05:600c:4f93:: with SMTP id n19mr818717wmq.163.1612322917516;
        Tue, 02 Feb 2021 19:28:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c5sm971089wrn.77.2021.02.02.19.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:28:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 20/25] grep.h: make patmatch() a public function
Date:   Wed,  3 Feb 2021 04:28:06 +0100
Message-Id: <20210203032811.14979-21-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'd like to use the PCRE & ERE etc. code in grep.c for more things in
git, starting with diffcore-pickaxe.c.

The current API just exposes grep_{source,buffer}() for that
purpose. I could use those, but they're very fat entry points into the
entire set of bells and whistles that grep.c supports for "git
grep". I just want the equivalent of a light regexec() wrapper for my
compiled patterns.

So let's expose patmatch() for that purpose. It's not perfect, in
particular it's a bit ugly that we need to pop a pattern off the
opt->pattern_list if all we've got is the "grep_opt" wrapper struct,
but it'll do for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 4 ++--
 grep.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index 636ac48bf0..8d84313d6e 100644
--- a/grep.c
+++ b/grep.c
@@ -906,8 +906,8 @@ static void show_name(struct grep_opt *opt, const char *name)
 	opt->output(opt, opt->null_following_name ? "\0" : "\n", 1);
 }
 
-static int patmatch(struct grep_pat *p, char *line, char *eol,
-		    regmatch_t *match, int eflags)
+int patmatch(struct grep_pat *p, char *line, char *eol,
+	     regmatch_t *match, int eflags)
 {
 	int hit;
 
diff --git a/grep.h b/grep.h
index 72f82b1e30..66e2ee37f3 100644
--- a/grep.h
+++ b/grep.h
@@ -205,6 +205,8 @@ void grep_source_load_driver(struct grep_source *gs,
 
 
 int grep_source(struct grep_opt *opt, struct grep_source *gs);
+int patmatch(struct grep_pat *p, char *line, char *eol,
+	     regmatch_t *match, int eflags);
 
 struct grep_opt *grep_opt_dup(const struct grep_opt *opt);
 int grep_threads_ok(const struct grep_opt *opt);
-- 
2.30.0.284.gd98b1dd5eaa7

