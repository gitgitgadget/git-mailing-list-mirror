Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5480AC433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DB27207D0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJMPiUjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731172AbgGANfo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731155AbgGANfm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 09:35:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBB9C08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 06:35:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 17so23261921wmo.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 06:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jRhE3tApwzz9qQbAyQgGqr8p2BgzyfGu4ALV1eTUN+A=;
        b=QJMPiUjZ7xAxlLG41FIPbUQF6ldZIT5HtJM+CwKXzbDMr4O0QAOrfhB+qjj7o5MTVv
         GlKri9RLrmkD5DvD8gE/jvNwl5WWI2HMwopYysPEbO6OX0VOGYqLkACMNf3v9oZaDvLP
         usK6J1kD0SnmYdGt+xVGFfuoYRjrQ3ioID3E3raYvC4ZeLh1f6JWLW053QLImpiJbYNP
         kY+zkWfyNIUDmwRrfTrnJlfqJXhLhZ+tSwqZMKqmGLIPd3WCiPEDKKBlSYrG+mjxd5ag
         lbUfI7Gof4jpYF0UfFD9AXnNMd0FkFjbkbGDiLqP0mSHDy/zHki3r18sE2dTz76ub6nz
         pESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jRhE3tApwzz9qQbAyQgGqr8p2BgzyfGu4ALV1eTUN+A=;
        b=R58p0ONWkiYNHN2sUizzSpLHcNyA9vUQMKcSx5pXSwq5V4IqsdZFvX6W5dS2XKgTwP
         uV1shdm+nU2Vq9ZOU9gnE1lQeEWytaF4U/g7Tr7bPzVI71mjISkDdXzWvvAgnXMxG2iC
         4HG6RtuvWpMh3Mt3zMpDZJ36P9MYrN9dsMIv059YiIMBMwyCEJydCtAicFz8/fXKFCpg
         PGCzKCyAwybuShc5juBsBYUXQ21822DBTCPl+1eBpHZmug/QIDUCXECctbG997QsxTfC
         ZEvEu7HeVUtN2IJ3UWEnbh+suIkKLPagYY+gZRSqdocl5zobDAOyvmiiI666SUWhA5p4
         QrpQ==
X-Gm-Message-State: AOAM532eVWksusV25UXw477GWS6aqnZJXcaKPWvCdVMiPZvFYFvyKqk+
        +lLKNv8MfYQPACalRHSFUBQvcLlU2yk=
X-Google-Smtp-Source: ABdhPJybjGxMrD+H5mhmzcjhHfwoQY3p/gSKc9aKoHqTBaowG3lDebjHPaJCQmgsKn56boyvnNnkMA==
X-Received: by 2002:a1c:3c83:: with SMTP id j125mr26467975wma.65.1593610539906;
        Wed, 01 Jul 2020 06:35:39 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.178])
        by smtp.gmail.com with ESMTPSA id 30sm7928840wrm.74.2020.07.01.06.35.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 06:35:38 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 08/13] bisect--helper: retire `--bisect-clean-state` subcommand
Date:   Wed,  1 Jul 2020 15:34:59 +0200
Message-Id: <20200701133504.18360-9-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200701133504.18360-1-mirucam@gmail.com>
References: <20200701133504.18360-1-mirucam@gmail.com>
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
index b52a925dc6..59385e2b9d 100644
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
@@ -864,7 +863,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	enum {
 		NEXT_ALL = 1,
 		WRITE_TERMS,
-		BISECT_CLEAN_STATE,
 		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
@@ -882,8 +880,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
-		OPT_CMDMODE(0, "bisect-clean-state", &cmdmode,
-			 N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
 		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
 			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
@@ -927,10 +923,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

