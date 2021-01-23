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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BD5C433E6
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 15:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CE95233E2
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 15:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725274AbhAWPmj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 10:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbhAWPmb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 10:42:31 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DC1C06178B
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 07:41:51 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m187so6811269wme.2
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 07:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ilXCEUegtv3IQ27IHuMgUysHTraXcfGWEwaeksPLNXE=;
        b=cB/GOJYnSnZT33ihpzjBVN+XOjHb5QW+WsgEURaWV9s/pM9k2abNog6UBLp7bOF8nd
         JgWBrQWivrUiiPHpqyZtO5lm9Ee46q/C+x7pbeUVisfZVNVnYcK5GhCQU5Zgkr8smgq2
         tJbEGhlixfHP59JZHfxJ4t7c63XDR/c2Ntd8axVpaotczrKtZe5teZzVU0ja/9BEU2F4
         3w+YUs8Ezokb+A1SkZ/la8SN+wbHML3bZzFK9BJqdU5TbNsa64plunL5aRbUximI/YUZ
         8IGWZ7/+Qj5qQSIsYc/64Gwd3siTjK0/0ycNA+IT1gmXOJDp9DQZ4rNISd9ZO/BFD+rO
         ECgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ilXCEUegtv3IQ27IHuMgUysHTraXcfGWEwaeksPLNXE=;
        b=eQ9nkC8Kmrb5Irgm35g5yixx4SdY6rZ+VKbWpNFA6/JOaOsz+A9rWAax3mHCBkOw5N
         V5fOqlgw2ljqAH9g72cirtcaW90IbVwhg3pEdnKMiE/aCZAIV1a8vibjvbytmDZu/J/d
         YnR87auijDF680mnL2JaZiQ3kWSyi1ZGpLIteVm1Nuoy2ZBpaZuZp8R0erRsgdZRauea
         H5eoQh3843frqXMsr3YbcJO/dp7v9UY0Qxl0LYaBJFymvePJNaYBL+4Je5k3xIrgR5w0
         OLfOneVVVajjLCWIwptrzFT/6ugfpNpNQd/mjG+4KsUw7oRdEm89c+4umrcnF71rgz4k
         o2Kg==
X-Gm-Message-State: AOAM530IAra6VqQIBeamoavhR4pJv5gxXiRSfO56bbUtnxFr2qUqqyZH
        LPlGjLGcHLJ/mYCzyFNuJHLpAmlOxsE=
X-Google-Smtp-Source: ABdhPJxvcvI2prFKppP1gDUlYoRDdbN0tT8tixJjnnQSWCCPnIAOTA95/7o7SdG4EcuqrerGhQ9RTA==
X-Received: by 2002:a1c:6005:: with SMTP id u5mr8762582wmb.122.1611416509790;
        Sat, 23 Jan 2021 07:41:49 -0800 (PST)
Received: from localhost.localdomain ([81.0.50.72])
        by smtp.gmail.com with ESMTPSA id o8sm16772353wrm.17.2021.01.23.07.41.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jan 2021 07:41:49 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 3/7] bisect--helper: retire `--bisect-write` subcommand
Date:   Sat, 23 Jan 2021 16:40:52 +0100
Message-Id: <20210123154056.48234-4-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210123154056.48234-1-mirucam@gmail.com>
References: <20210123154056.48234-1-mirucam@gmail.com>
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
 builtin/bisect--helper.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 4d8dca3717..1f731167f6 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -21,7 +21,6 @@ static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-reset [<commit>]"),
-	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-next-check <good_term> <bad_term> [<term>]"),
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
@@ -993,7 +992,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		BISECT_RESET = 1,
-		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
@@ -1009,8 +1007,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "bisect-write", &cmdmode,
-			 N_("write out the bisection state in BISECT_LOG"), BISECT_WRITE),
 		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
 			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
 		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
@@ -1047,11 +1043,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc > 1)
 			return error(_("--bisect-reset requires either no argument or a commit"));
 		return !!bisect_reset(argc ? argv[0] : NULL);
-	case BISECT_WRITE:
-		if (argc != 4 && argc != 5)
-			return error(_("--bisect-write requires either 4 or 5 arguments"));
-		set_terms(&terms, argv[3], argv[2]);
-		res = bisect_write(argv[0], argv[1], &terms, nolog);
 		break;
 	case CHECK_AND_SET_TERMS:
 		if (argc != 3)
-- 
2.29.2

