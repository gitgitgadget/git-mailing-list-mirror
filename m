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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6598C433E9
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A213B64F6D
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhBCV4V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 16:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbhBCV4K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 16:56:10 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DCEC061786
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 13:55:30 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id q7so976183wre.13
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 13:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vhtAgoXno4N6+SiJYt28nArGCglWhtCa5Chnj6tZBUg=;
        b=h/HX2Lk7Ql9Abk3uTUS+tR5rLnj3aBp9UThWQeBETAC2IDlGkZ+kfTXczIMmZdSTnm
         H8uarPau2M82pxefg1ofC4cwYyVONt57G649NA0O6GHn4kKZhWi4wv4jrwRv9+kGVACe
         AXGiyy36cekE9Wr/Fx3g3ecErYy0c2o+oovwr468cXTV5ef0lfCOv5BYXpKQeJR5ny1m
         hhjGs7v9yrkYK8uyeuC230mbrkiWj0XSzbrLG6355ZdAGtBxQK2epOzdWBjuFNZR5gg1
         U6KmGfgszreRf5d6TFMUNa9yWX42BbHMX1A/pE6eygcy+tXYe46B/+txhIu+iu8sWjVH
         9bAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vhtAgoXno4N6+SiJYt28nArGCglWhtCa5Chnj6tZBUg=;
        b=JGaHzwWoKJUD3YrDtK6GXcqNnXNLIRmc8f7tHN2j2yDED7+1ypgd2iQPpI8Pq31ys2
         1Cp8NQ0IIOrTIMb+21kZ8KTeTQopaaM+gPo2K5qVN0zcWg4d0g7mids49omGD++6lcB/
         hGzVVWR/xOWAtE4OjkgkyWAaIl3MJd++nfjyAk2brnfygPjVU/nd3NJaq4C2af00nDz/
         2E4wf/TsqP+aPxc8y5BgQGUzVYoy7sADqmi9KibkBUrbmGbwojd8umdV/54r3olrERAN
         lcplP/WfwMwkL8XIRkra07ZTzzKiGwoFkMgnlTiR+vl+dRGvvo/GYlnX7dlwBxSZt8Ck
         uy/A==
X-Gm-Message-State: AOAM530mf2Njr/RbZgyD7BNyBsAFkmFhpwreehbQjKmNXJhjhGFmlQe9
        k1U5+RlxSL/uaiosH7HXfqwcgOvzy0o=
X-Google-Smtp-Source: ABdhPJyO8pbCCtRHHDYZT/wqUZf31+mxEprQDZMV6Nmz5NOfaM284Z+U5w6WAD16JsB2iYhYxICUSQ==
X-Received: by 2002:a5d:414c:: with SMTP id c12mr5917947wrq.251.1612389328808;
        Wed, 03 Feb 2021 13:55:28 -0800 (PST)
Received: from localhost.localdomain ([81.0.37.148])
        by smtp.gmail.com with ESMTPSA id 143sm2609531wmb.47.2021.02.03.13.55.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 13:55:28 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     rafaeloliveira.cs@gmail.com, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v5 3/7] bisect--helper: retire `--bisect-write` subcommand
Date:   Wed,  3 Feb 2021 22:54:34 +0100
Message-Id: <20210203215438.96760-4-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210203215438.96760-1-mirucam@gmail.com>
References: <20210203215438.96760-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--bisect-write` subcommand is no longer used from the
git-bisect.sh shell script. Instead the function `bisect_write()`
is directly called from the C implementation.

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
index 24489f4411..36b50e3aa8 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -21,7 +21,6 @@ static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-reset [<commit>]"),
-	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-next-check <good_term> <bad_term> [<term>]"),
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
@@ -998,7 +997,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		BISECT_RESET = 1,
-		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
@@ -1014,8 +1012,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "bisect-write", &cmdmode,
-			 N_("write out the bisection state in BISECT_LOG"), BISECT_WRITE),
 		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
 			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
 		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
@@ -1052,12 +1048,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc > 1)
 			return error(_("--bisect-reset requires either no argument or a commit"));
 		return !!bisect_reset(argc ? argv[0] : NULL);
-	case BISECT_WRITE:
-		if (argc != 4 && argc != 5)
-			return error(_("--bisect-write requires either 4 or 5 arguments"));
-		set_terms(&terms, argv[3], argv[2]);
-		res = bisect_write(argv[0], argv[1], &terms, nolog);
-		break;
 	case CHECK_AND_SET_TERMS:
 		if (argc != 3)
 			return error(_("--check-and-set-terms requires 3 arguments"));
-- 
2.29.2

