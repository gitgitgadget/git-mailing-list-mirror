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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8C0C4320A
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3836B61101
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbhHTRXw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 13:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbhHTRXm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 13:23:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870C0C061756
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 10:23:04 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q6so15261463wrv.6
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 10:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SQdUT9oL8l2cZy0O1q3jtU4MPIlqqu+yIOQk9cEGs6U=;
        b=GWg5uy0WxQi/z6Hp9D7rTAonZ6MXbMprnQiM3LpneCzChGHJGsZ08uXUEZ7KRWyt1r
         9i8dfr8XFU4Nx0GEbUosHyCZ2rMnc8R/rVbrbRppGWTvxacVfAam6z+OI/3P0Kgc2L4g
         ITfDQSZVPgtmiYBzgdmjusvYrQYvK1iQkg6N9vwXc5kCHulj5id/R8FJiBCo+c8Fh1FX
         rc/cSLMPPQRRInk+0i9bOFUuhIpju8DRd07fr1ZGObbwUNFQy2VM8SJwwJi9OrkGdRBB
         E6YhEKPipyGytwG6rIli3Gsw9nyUqU4WQ84gu7pPIOHlTHeZ7mGhnmtTFB6Chp60INfu
         bszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SQdUT9oL8l2cZy0O1q3jtU4MPIlqqu+yIOQk9cEGs6U=;
        b=QroJx8IUpwUJaT6TKeWimZIRYs/wXy/Tf/5AklJCBoat5Z0AZ2+AyxWTRdv4yAe8L1
         GVg0iciCNVc7ddeLOFZQ8vfUqQ3Mn8YWiQE/zqCT4fFmUm8SMUeVW0BbmyMlpjBx8ZK6
         AOpLNaFBCQ6w3mKIQmyi/vGAVg32k9WaFZIY6s0EL9V8Lw8EOjOH8SpqhGPAdIKOcZwE
         Zt4Tvc0fSO1iLA+HOrX11iWzHZZbCVckzkGPjKPHsZDetBex1owBFCvb4930N3t/FylW
         hq6v2hTMoMvMVn0TkUQ4MdSTaO8h34nftYHLqgz2YQ0YAAy3Q15GluaXhBMMkczaN7Ac
         3ojQ==
X-Gm-Message-State: AOAM531Av/6s1xdSzfmKrneaP/AiVqNh1jjHZVKB7BHRTM+vFcCbMUFk
        gvy8+Zovfmo7/E+xfnQrIqsW0NZgt5k=
X-Google-Smtp-Source: ABdhPJx4xe5mXkKObVj4WYce6Pt7xmi5dtU2/1shJ7pPUN9NFtbC2CxKyYN2C+5wVDZ5iXu/iB1Y4g==
X-Received: by 2002:a5d:4143:: with SMTP id c3mr11725828wrq.29.1629480183206;
        Fri, 20 Aug 2021 10:23:03 -0700 (PDT)
Received: from localhost.localdomain ([178.237.232.111])
        by smtp.gmail.com with ESMTPSA id x13sm6623278wrq.44.2021.08.20.10.23.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Aug 2021 10:23:02 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v5 6/6] bisect--helper: retire `--bisect-next-check` subcommand
Date:   Fri, 20 Aug 2021 19:21:48 +0200
Message-Id: <20210820172148.2249-7-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210820172148.2249-1-mirucam@gmail.com>
References: <20210820172148.2249-1-mirucam@gmail.com>
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
index 8d33c809aa..6e1e7c243d 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -22,7 +22,6 @@ static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-reset [<commit>]"),
-	N_("git bisect--helper --bisect-next-check <good_term> <bad_term> [<term>]"),
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
 	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
 					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
@@ -1227,12 +1226,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

