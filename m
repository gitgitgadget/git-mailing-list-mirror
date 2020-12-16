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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA43C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C1AF2342C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbgLPSvw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731131AbgLPSvv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:51:51 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055F2C0611CC
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:42 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id s26so16309051lfc.8
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+8K6OnM3xJtODHrcf6a1GfluDn/pXoNN0TPuL/NciX8=;
        b=GK/2QpVfGwtspNXCubxYlvisTHPYkOVNE1+9cOxruRo3Ha/LBcOHWCkJU3BvnI41gt
         ZcNN5QuoDYkRRJtoj49F0b7Fgdo5hg6H9jY4mzoaEeVmSBeEIAMhuJH6+iokT/Klb6Qb
         XFtpxuB3kDn/rOwFG4eqWw5chilZaTKlqqfuGEBW43XR6O7dk17DAxvS94fumwoCqg35
         1iThxuhxVYG0Cfp6BpkaIHT9vjDbNw0efTmKpi86T2S1RJlD8tj0+MqJt4FLm7uofPBj
         ssvfPnJNtK1NehPbzaHEN4IwCWn/3eKyO3bsTjX9gydAexAQpk1iMBylGELCmOHiu3QW
         mMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+8K6OnM3xJtODHrcf6a1GfluDn/pXoNN0TPuL/NciX8=;
        b=JaKBrHa3J3Z6KXH4uVLTmFn+5p/juGoztfrrsKFDTG+Dy2X9ps/SFEuynn6WdrVAcg
         1mzZ0uitadr/ReO3BjlTWOpaA6I62/wSF7jxBU51fSMnMC4mcJHBeU82E0RH2LJOt4MZ
         I3HrzDdLfjnRGRjOGPjnpeO44s11sqpkRk3TTuQUQWtxK+qfMCIINlq/MBZnx2AEgKDq
         ezXIbj2dp7z1XoPJ20YkPBKdBwP42RC7rmvFQWIQHrwH+3zaT7MsR/+0OmK3AYcndxal
         Qs/Sujh8M6XnYrbhJZfEI1k+jIAMT/C87mAfxnvfLX4oyQX8F3X7KXxJzIoga6jg8xYj
         oeHg==
X-Gm-Message-State: AOAM531+547YfGWt/Zj3+uo4RZp+3fn87igTsig6pW3kc/EucC7hwly3
        xgjcwDBhNJe0t9MTF4lZhVc=
X-Google-Smtp-Source: ABdhPJymq8FmrI+AtI0GC+R4OBla36KGOm4yIgVqNB0yrWd7ihi9psfTAA4wdhoQ+Kz/pHboCJugew==
X-Received: by 2002:a05:6512:21a8:: with SMTP id c8mr14442576lft.139.1608144639631;
        Wed, 16 Dec 2020 10:50:39 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:38 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 13/33] diff-merges: revise revs->diff flag handling
Date:   Wed, 16 Dec 2020 21:49:09 +0300
Message-Id: <20201216184929.3924-14-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do not set revs->diff when we encounter an option that needs it, as
it'd be impossible to undo later. Besides, some other options than
what we handle here set this flag as well, and we'd interfere with
them trying to clear this flag later.

Rather set revs->diff, if finally needed, in diff_merges_setup_revs().

As an additional bonus, this also makes our code shorter.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index c99d77a318dc..76ddbc37bd59 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -37,16 +37,13 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
 		revs->ignore_merges = 0;
 		revs->match_missing = 1;
 	} else if (!strcmp(arg, "-c")) {
-		revs->diff = 1;
 		revs->dense_combined_merges = 0;
 		revs->combine_merges = 1;
 	} else if (!strcmp(arg, "--cc")) {
-		revs->diff = 1;
 		set_dense_combined(revs);
 	} else if (!strcmp(arg, "--no-diff-merges")) {
 		suppress(revs);
 	} else if (!strcmp(arg, "--combined-all-paths")) {
-		revs->diff = 1;
 		revs->combined_all_paths = 1;
 	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
 		if (!strcmp(optarg, "off")) {
@@ -94,4 +91,6 @@ void diff_merges_setup_revs(struct rev_info *revs)
 		revs->ignore_merges = 1;
 	if (revs->combined_all_paths && !revs->combine_merges)
 		die("--combined-all-paths makes no sense without -c or --cc");
+	if (revs->combine_merges)
+		revs->diff = 1;
 }
-- 
2.25.1

