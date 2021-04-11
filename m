Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7BAC43460
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 09:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A51ED611EF
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 09:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbhDKJ4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 05:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbhDKJ4a (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 05:56:30 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC8AC061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 02:56:14 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso6979241wmq.1
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 02:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gbPBT1+NJysDMjw4zJOQIIRrpKYLuIjhBBOU1NdvHaA=;
        b=WNrY+d/bA9+2Lx8fXEqNHHoqxPLzn3PkS7hVBKkDOkpBYXP+lcayH6OEKMJseEuwJB
         Nk23sxPZf6nVlK1gT6jQOcLeG9Xc3GKwm6irEJGC1efBbXiJhDo7j2bfEw3tI9vLPVVZ
         6Dtx5KO7XDF9EGQms30Okcf/M+m5bScZwWNmWKwwGVqmjhD48OMbwzw8wdDUMHRuMzsx
         Gftl4O8OTQtHJFjnlwtlhO/teOl8P8sEoq44Uk8pHVchluHMen2aytrhVJAt1hpuDcNG
         mm4018KJSEijq1sR0gK9qXBk9j2hgawhUp1XVFbs1SN8l8QQ37/8G/iNQUDMuHh2DioV
         s9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gbPBT1+NJysDMjw4zJOQIIRrpKYLuIjhBBOU1NdvHaA=;
        b=LQ5O66AyVQFPARPyM6ijic52bEBlPdJqqGxvX4+iGhyd/G/2AXhm75F0fDnfmUAIMP
         yhJffufOmdU2SofeELflavhhzELmzOjc1dksJ++ZSYnWjdzUO2ITmuuXh7OeuYyNlC03
         Q/uKBbxrfa05yHCSBjvdEfnHL48VI+/oVsI5fqjIRyQNY7M/MLP2qEi5xSe2JcgKvxt9
         k++Ev7rHHnXm2BvlcspkrKAK/h6eZ8JBkmrHpp3T16zWsf5xoHH0At8Qlb9fbRr7CcM/
         4dII3+B76EvHhAmwGmvEaUk4lfAh2l10USUvuiVYiH/XEblI9fPfstvqIn0ERp5nSRDe
         r0Hw==
X-Gm-Message-State: AOAM531byjS9i3lM4RMwsQDWKOLg241i06u/WJoMTW+nprd0ayvoKwmZ
        P1osGiH/uu1vLKTnCl3c2qlZZLFBvSU=
X-Google-Smtp-Source: ABdhPJy1VVHQhAKe79vBMhYBCEM+2Jam0A0rM++uhmJtoZfR9CTTTSi1iqRvcxtLAim43JCn5886xg==
X-Received: by 2002:a7b:cd98:: with SMTP id y24mr9977462wmj.52.1618134973568;
        Sun, 11 Apr 2021 02:56:13 -0700 (PDT)
Received: from localhost.localdomain ([81.0.37.230])
        by smtp.gmail.com with ESMTPSA id j30sm12994099wrj.62.2021.04.11.02.56.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Apr 2021 02:56:13 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 4/4] bisect--helper: retire `--bisect-next-check` subcommand
Date:   Sun, 11 Apr 2021 11:55:38 +0200
Message-Id: <20210411095538.34129-5-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210411095538.34129-1-mirucam@gmail.com>
References: <20210411095538.34129-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After reimplementation of `git bisect run` in C,
`--bisect-next-check` subcommand is not needed anymore.

Let's remove it from options list and code.

Mentored by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index dc87fc7dd0..0ff34007be 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -22,7 +22,6 @@ static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-reset [<commit>]"),
-	N_("git bisect--helper --bisect-next-check <good_term> <bad_term> [<term>]"),
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
 	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
 					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
@@ -1206,12 +1205,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			return error(_("--bisect-reset requires either no argument or a commit"));
 		res = bisect_reset(argc ? argv[0] : NULL);
 		break;
-	case BISECT_NEXT_CHECK:
-		if (argc != 2 && argc != 3)
-			return error(_("--bisect-next-check requires 2 or 3 arguments"));
-		set_terms(&terms, argv[1], argv[0]);
-		res = bisect_next_check(&terms, argc == 3 ? argv[2] : NULL);
-		break;
 	case BISECT_TERMS:
 		if (argc > 1)
 			return error(_("--bisect-terms requires 0 or 1 argument"));
-- 
2.29.2

