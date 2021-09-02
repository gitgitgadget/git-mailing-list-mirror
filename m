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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20376C43216
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08FB1610A1
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245002AbhIBJGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 05:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244999AbhIBJGV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 05:06:21 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7D7C061757
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 02:05:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q11so1713677wrr.9
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 02:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U1IYr6wSLSOS9ynBQprCVzNN5PqVHGvk59TqSNhbNSc=;
        b=N1wwlQPDS9uQ4OoQS6u6h7WfFKtvKYhTp4nlGVs/wUk9sJIgAaqwvhM0DORvLr8VAq
         +ylkmYZdSx5EFWH66twUnnqqFshDp3/7f3RGbWdPLFouDx1aADDM0L314HqQde/0lZFC
         ncT7UCIEKWJmXDZbrJSH02I5Se3vivy+zwslNCGCPXk9paEuIEi6O+r4akY215pNddXH
         Ivo4dnIOUTrsxn+xxNsakjaTzu6QRdfGrAP5ArLkPOK0n6MbUGwOCh4HZxvohEXdUwea
         uZkC/ODGYjtSgFF0nqwPud7oSyRYKdc8t2hhsKKq983zzbxD8NLKdd/U5pD+R3+XUdV2
         s40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U1IYr6wSLSOS9ynBQprCVzNN5PqVHGvk59TqSNhbNSc=;
        b=sRN2keFrrx6OinB7L/Tnz9LuOHOsG4hf/OqnJVbpvrjufEmFMajAZ2IRTWrDV5jW/S
         inhXu8UtRQF3jIIGkGmEFR+KbgouJiubMl/fNIH7YUal9ucRl2PEUC2YNjMWruQdu7S5
         SXCv+UZAArMscOWIq0lJxJo2L0LXu9/7J7gbT3n6zh08ZswZLUrbvg/Ue/2mJ8uyxv98
         30XdiFpZrtLRdtCMJ44YvjpULu/Y1s8KIZUx3jJIMTt1dANi0LVKsUfan19XRQup6HDH
         9BB5tNIzL6iY6+ENKn7ncxnXTMIIn4mTa4nO2UYbyxDUrZVUwe7i6cL/zeA/qNTgPmbn
         P6kg==
X-Gm-Message-State: AOAM530MOC/HhBBOozInE2gE2wrKmKfGBPmx9kex2teI9HnWnlBgW9Y1
        pgCEDLT31dA+MEynnTQ4BXgt27H+4i8=
X-Google-Smtp-Source: ABdhPJzEJg595Ieq13NnAx7opyDvDha8MxIA6/jkBNZL7iq0F1fZ0HBwZdi5DRaGsor3xLUemoMyqw==
X-Received: by 2002:adf:80e2:: with SMTP id 89mr2341601wrl.43.1630573522108;
        Thu, 02 Sep 2021 02:05:22 -0700 (PDT)
Received: from localhost.localdomain ([178.237.237.111])
        by smtp.gmail.com with ESMTPSA id l17sm1262516wrz.35.2021.09.02.02.05.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Sep 2021 02:05:21 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v6 6/6] bisect--helper: retire `--bisect-next-check` subcommand
Date:   Thu,  2 Sep 2021 11:04:21 +0200
Message-Id: <20210902090421.93113-7-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210902090421.93113-1-mirucam@gmail.com>
References: <20210902090421.93113-1-mirucam@gmail.com>
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
index 8e9ed9c318..10c4cd24a1 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -22,7 +22,6 @@ static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-reset [<commit>]"),
-	N_("git bisect--helper --bisect-next-check <good_term> <bad_term> [<term>]"),
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
 	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
 					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
@@ -1222,12 +1221,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

