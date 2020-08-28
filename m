Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655BBC433E6
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B56A20872
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIqTEPPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgH1Msr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbgH1MrX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 08:47:23 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1025AC061237
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 05:47:21 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q9so817021wmj.2
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 05:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dqoj8YIWKOZHzn9GJCr2gqt5Uhl4GCOAZ0C4bFvsLPY=;
        b=eIqTEPPLT8MNOadAn6o+mmwlAAoqGSp1h/lpWooFOcg2YqOhuYfUCh9dezOIatuOzs
         c63+WjZAoXYCtdCoPi5Lg1XR4ul94nCd+mwWCWLxsQYnibWd7FN/FcH/jnMoxevadTWL
         0XbZ/IBUYNeEtUMEqtE4ICAtelZL7l2qR4yKEP5y4tpyyXn4g0Z/pKvKPSedDUAFYYlQ
         veSj+5bLo8KJvmRMQFxkBPeZ2KZPFxFgSxGAjYwsgfD0QbLMKrGmqF/c88Ag4VCpRYYQ
         ug69iPK4eIJVwRkvvROCmzUZegaGYo7RXod2g5CsdfgnJiH/hSILiIlylRUfyG8w5S2B
         aiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dqoj8YIWKOZHzn9GJCr2gqt5Uhl4GCOAZ0C4bFvsLPY=;
        b=cPKpXUDz0XhIc/NQavAFnHw4nnIwaRSdYFQSxFEFPw/LROwa/fpQ97Ug2KePmun4T4
         ORluFcTqy7R2BRTwtbMk0+EnwnAe+EpR/I0dowZlVSNxtQLqCgtbuXYplFcoqxCbkCjf
         ZqOL6au/0sNBQ3qrq3/sKwoNprs5Q71ibz6YL6/y+t2Je5dF6tR2FWaT56pc3KrGxflA
         CJnNdGhOjb6uPJBjNLupMJlmMUF7vG4lqTzTSJej+YMNHZ0N8QC5LfPIsu1VAwtodYtb
         Us77Dmtl8XsOCPqqvYOpu6PdWUU/oWuECrKZdnB9CRxsSWMeLBuTQ5Mt55DC/+2fWTxh
         /dDQ==
X-Gm-Message-State: AOAM532XUPX1BPCvKn+hrIpUwqqKnQaLp/MME/0cQ235jy40KpSRPf2g
        BUHZ6uqtmDKzIjvPyRgqUhTVXrR05WA=
X-Google-Smtp-Source: ABdhPJxhIAVzyw80zyK6IUAVf7uhSv0zpYow1176RmHi6oVl4YxsjAc0zFrV+vxFNa6klbo6Y22Lrg==
X-Received: by 2002:a05:600c:224e:: with SMTP id a14mr1518139wmm.80.1598618839497;
        Fri, 28 Aug 2020 05:47:19 -0700 (PDT)
Received: from localhost.localdomain ([178.237.236.228])
        by smtp.gmail.com with ESMTPSA id o66sm2176878wmb.27.2020.08.28.05.47.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Aug 2020 05:47:18 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v6 08/13] bisect--helper: retire `--bisect-clean-state` subcommand
Date:   Fri, 28 Aug 2020 14:46:12 +0200
Message-Id: <20200828124617.60618-9-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200828124617.60618-1-mirucam@gmail.com>
References: <20200828124617.60618-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--bisect-clean-state` subcommand is no longer used from the
git-bisect.sh shell script. Instead the function
`bisect_clean_state()` is directly called from the C
implementation.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 56da407871..106e5b788e 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -22,7 +22,6 @@ static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
-	N_("git bisect--helper --bisect-clean-state"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
@@ -872,7 +871,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	enum {
 		NEXT_ALL = 1,
 		WRITE_TERMS,
-		BISECT_CLEAN_STATE,
 		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
@@ -890,8 +888,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
-		OPT_CMDMODE(0, "bisect-clean-state", &cmdmode,
-			 N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
 		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
 			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
@@ -933,10 +929,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc != 2)
 			return error(_("--write-terms requires two arguments"));
 		return write_terms(argv[0], argv[1]);
-	case BISECT_CLEAN_STATE:
-		if (argc != 0)
-			return error(_("--bisect-clean-state requires no arguments"));
-		return bisect_clean_state();
 	case CHECK_EXPECTED_REVS:
 		check_expected_revs(argv, argc);
 		return 0;
-- 
2.25.0

