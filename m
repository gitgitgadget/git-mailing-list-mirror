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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE4CC433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2052B64F6C
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbhBCV44 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 16:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbhBCV4t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 16:56:49 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50FDC06178C
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 13:55:33 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id b3so1049377wrj.5
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 13:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mkYGtGgbgi7zNnwSPavbqMHadABSk3fc72upqSEr/CA=;
        b=KJdgQRQ4Cdwfs3l6Pk8BDMB0GXq7Vyr3zA/nwxNY0fA7yBHrBoRwa0KgKbuW29d1MW
         or161KEdc9DnVCNyxcTT5vfOzxh26YPcd9Rj8GBj+7kLVseUKly9Y4+97APBs/D/6ewT
         JfSlm5eSsMatTceXUC3xzB5tHu6bFXOycG6LvtpegSKppvjzVyLYVoJEjdciVRhm0Po4
         kaU+2dz/cBbcoy2yUOfYOy/DW+Sg76d5pNVui1sXOfdjBKj9jyo/doi0tn1jjHHSPhU2
         sqC4/YjjitDXoR/Oo9VyfJEtPXYA22Hb/L0nQikNttrBZPZ3sPdYv5QFUVg2nVh/K6sa
         H6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mkYGtGgbgi7zNnwSPavbqMHadABSk3fc72upqSEr/CA=;
        b=t5A5gWybUR7AFTMwXZ/sSdiS3JgUozPXilAR8UtOl2c3Q6MdU113A3sueE2o+zEklK
         YQTbEsSEA7s/+/LjI8UYqY7C0/3NyT0+TSq6IuE77RN5P46Tr1JfHX7kbaCsyXMd0avM
         eMvs1uiyC/H43OqroXEs4Us5GDd0mqkLxHF/OwPaIARpMjl/H8sxXrcD2BNcUHY4lN0Y
         0gk/PD3w/uIgxQc+9AAEdlQVuixr1ejSu8D/t1e+UZvbpBpXodN0sc8LwcwF4qX1xZ9u
         3S4uUOyAhBIWQTk/saOS/ueKILmMCUkyn7xr/TuT3SRXo5WlCkEVezaKePVTIvd+h6nP
         QFug==
X-Gm-Message-State: AOAM531MxLxU38R41UVmIx8rMjPLn6ByxCL/vq4kp8mOvpOmCRiScu7m
        zySPGZ/7N/kCJX7tFoNqApE0J6mRVdE=
X-Google-Smtp-Source: ABdhPJyTYDxS7eOeOUUQL8672Zcvz5NLgai641LqFUtzPzP7JUyPEmsGxeDxO8GCIfL1B3jKvsJyeA==
X-Received: by 2002:adf:9261:: with SMTP id 88mr5678139wrj.227.1612389332501;
        Wed, 03 Feb 2021 13:55:32 -0800 (PST)
Received: from localhost.localdomain ([81.0.37.148])
        by smtp.gmail.com with ESMTPSA id 143sm2609531wmb.47.2021.02.03.13.55.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 13:55:32 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     rafaeloliveira.cs@gmail.com, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v5 7/7] bisect--helper: retire `--check-and-set-terms` subcommand
Date:   Wed,  3 Feb 2021 22:54:38 +0100
Message-Id: <20210203215438.96760-8-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210203215438.96760-1-mirucam@gmail.com>
References: <20210203215438.96760-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--check-and-set-terms` subcommand is no longer from the
git-bisect.sh shell script. Instead the function
`check_and_set_terms()` is called from the C implementation.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 7ad9b4d55b..d69e13335d 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -21,7 +21,6 @@ static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-reset [<commit>]"),
-	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-next-check <good_term> <bad_term> [<term>]"),
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
 	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
@@ -1032,7 +1031,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		BISECT_RESET = 1,
-		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
 		BISECT_START,
@@ -1047,8 +1045,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
-			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
 		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
 			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
 		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
@@ -1084,12 +1080,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			return error(_("--bisect-reset requires either no argument or a commit"));
 		res = bisect_reset(argc ? argv[0] : NULL);
 		break;
-	case CHECK_AND_SET_TERMS:
-		if (argc != 3)
-			return error(_("--check-and-set-terms requires 3 arguments"));
-		set_terms(&terms, argv[2], argv[1]);
-		res = check_and_set_terms(&terms, argv[0]);
-		break;
 	case BISECT_NEXT_CHECK:
 		if (argc != 2 && argc != 3)
 			return error(_("--bisect-next-check requires 2 or 3 arguments"));
-- 
2.29.2

