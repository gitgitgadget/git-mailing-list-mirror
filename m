Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DD2C433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 10:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1676206F0
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 10:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSx1nccn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgHaKwH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgHaKvU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 06:51:20 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8AEC061575
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 03:51:19 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c19so4166603wmd.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 03:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LTDMjVi2Mz9bRPnbb6JXdOSiMTMzq1b0Krp0/r9I70g=;
        b=QSx1nccn3Q6/kTzoNgW3L9k4oVjx1y2VLonVu1fTNoz3uaiZhQCyxWf9ASfmpTVU8F
         1OAXaNuHDtSWD8MrMZuusc/cxb9LXY/DjTB5mzRcrv/nRsv6LPoqLPDrUYaaNgOf6hpU
         MuPpzzttFhe0zG658vCSvXVymiI4Lx1ANtTUaY7w7Fr3+6QzGoEzRQ/+b8ZrZB55Ehh4
         XNk+W0w3l2ylHSeEnIMaTVmdPPovaZ4svaMrZ6l6DTQ+yWvhXi+ba+FMVJN4xZ507aTU
         BWjNE/20Uz4isG94HSuXJU8o48PLotP5xapPgibQuDt6i2o3CjYVPwPn5Ms9KFdlZOOd
         Frdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LTDMjVi2Mz9bRPnbb6JXdOSiMTMzq1b0Krp0/r9I70g=;
        b=VVkbLagCKfW5EjvZ0OiEEF2N24STRLMiRzqNZbrk5kBIVgK5F4y/c4CiDcHEKcoFSs
         2ZSJCrk/SJXn+G+BTooA18O0rxk0ZJvMOLs30K1AVztfBm42tve3mIbpsoFZhvn0uD6u
         pJm5qvdqEEHjTltwlxDmOwMWlMiPgMXAm5IghEpgqQBBTCKg6hscdqPzaH2t1KPelP6S
         iUEpSFyl0mQviuGfxHYEnZVyzCfuGLTtARCJN2NWXFcgSJIa7buWo9xtnqeq/Ffj9YLY
         nJ37IsDhgEZhDc0q68BPTZeqOHxz8pl/b9Eoscs16FXNk1HLioKjJjrq40LpQ2KQoKdN
         exWw==
X-Gm-Message-State: AOAM531N0ZmtInJ3oHMUqp79XsE3jzEM9AR8nZpUaQJGUIM1Z9AmjPkz
        EjcnZTngu0FCbtbjA5eTsHC/GsiNuD0=
X-Google-Smtp-Source: ABdhPJzTVp5AhjQrqG1JWeKGeRJYBcRg7cgz4w5sVOewj280rq8GFOTw0SGJAxZSSbJgoOuQAy2sUQ==
X-Received: by 2002:a1c:6254:: with SMTP id w81mr824064wmb.94.1598871078427;
        Mon, 31 Aug 2020 03:51:18 -0700 (PDT)
Received: from localhost.localdomain ([178.237.236.228])
        by smtp.gmail.com with ESMTPSA id k84sm7674454wmf.6.2020.08.31.03.51.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 03:51:17 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v7 08/13] bisect--helper: retire `--bisect-clean-state` subcommand
Date:   Mon, 31 Aug 2020 12:50:38 +0200
Message-Id: <20200831105043.97665-9-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200831105043.97665-1-mirucam@gmail.com>
References: <20200831105043.97665-1-mirucam@gmail.com>
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
index b40369e8aa..b8b8a7473c 100644
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
@@ -869,7 +868,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	enum {
 		NEXT_ALL = 1,
 		WRITE_TERMS,
-		BISECT_CLEAN_STATE,
 		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
@@ -887,8 +885,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
-		OPT_CMDMODE(0, "bisect-clean-state", &cmdmode,
-			 N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
 		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
 			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
@@ -930,10 +926,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

