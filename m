Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57556C54FD0
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 07:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37935208E4
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 07:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tWbrldY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgDWHJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgDWHJp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 03:09:45 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77AFC03C1AB
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 00:09:44 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g13so5490543wrb.8
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 00:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6nh3q5T05d/rmpBzzqkvyp/gkxm+rUM9UNUlc6oSKmc=;
        b=tWbrldY7dpFiD88cGyW5EpJWu5UJzupvW5jFtev8KY18oMvPOQKF3bpoVgRc/d+JTa
         zUUbxnKZ/LIyLUUCAgXU5oC/jqF7yDRnCuXxeS4My8A69ntNeyBpUyxvEx991j/bilz0
         6nFJjzm+y30+NAioqXNufrsHf4ATBxUVL/tvno6VzrZdRcMflshNDej8bnhAb+lnILfj
         F/b9ifxDvkK8kZBV1Bgcu6HPzPiQZGvd22BnEG3jch2hAoMQfh06352qqU7pNBmV19b6
         8AJjXzEZS2oUYsCFjs6/G2CrI+q+tP3FwqcricN1igEF++5msW7S5CZnYQEWiF3suCQy
         7Y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6nh3q5T05d/rmpBzzqkvyp/gkxm+rUM9UNUlc6oSKmc=;
        b=Xb8vRQcbig5L1tuRSghppNrkzRg6uzd+FQgkvqyDnCjEZvvar0mewW1xiyyprH8MIu
         itP9IVtKe311mKgjisWmNV7CcuMada1eeEBHhLRwoAbK9O6iLyCmm9iHT5/2CyCb//qz
         xRcIyAurpYSuZG5dGi4IXdyA6OJjoM7/VTYhXPxwrQILNzOtsSvx1f6pWGb6CBp0gDaa
         cPhUtY3gCnodd0uGR7McRlI5WQSqHRwmmqtWNWbzu1zL+SznAYfvys7qMsGagRqKH9SI
         8NXwPKCssQfEel+SPhnJE8k7sYyJbJZJIwzNPovnE+eD6MQVp7cTCML287MXmRlXgkDM
         laWg==
X-Gm-Message-State: AGi0PuZSCNyAO4osk6X9MModA5F3+JFH/sQ95sB4lp26e6tAVRgsg2Tz
        avW0cO0UdPYX1LV+3h1CW6z+wuck6Mg=
X-Google-Smtp-Source: APiQypJ/2NN720lySmkA1NcJ+zEd2ecxNnlje1NZF1lBNUXakLMXfztOP7VkjKymoiYCKlUfGlrHHQ==
X-Received: by 2002:adf:a18c:: with SMTP id u12mr3134419wru.325.1587625783502;
        Thu, 23 Apr 2020 00:09:43 -0700 (PDT)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u17sm2518585wra.63.2020.04.23.00.09.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 00:09:43 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 07/12] bisect--helper: retire `--bisect-clean-state` subcommand
Date:   Thu, 23 Apr 2020 09:06:59 +0200
Message-Id: <20200423070704.39872-8-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200423070704.39872-1-mirucam@gmail.com>
References: <20200423070704.39872-1-mirucam@gmail.com>
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
index f2ec7f89e4..1b4d0a0f87 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -22,7 +22,6 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
-	N_("git bisect--helper --bisect-clean-state"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
@@ -841,7 +840,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	enum {
 		NEXT_ALL = 1,
 		WRITE_TERMS,
-		BISECT_CLEAN_STATE,
 		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
@@ -859,8 +857,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
-		OPT_CMDMODE(0, "bisect-clean-state", &cmdmode,
-			 N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
 		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
 			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
@@ -904,10 +900,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

