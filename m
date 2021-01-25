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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D26C433DB
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 05:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 140A922573
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 05:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbhAZFCB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731675AbhAYTSf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 14:18:35 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3360EC061794
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 11:17:32 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id i9so587910wmq.1
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 11:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SStzSCRIL9dliRtQBfGa5wPeZR1qlbqiwnb2P1Nrq+M=;
        b=XKRlf658AlMnu/GJTFurrzGYyjdaYUrEFzZ9CaPMHxxkrrFB9kDx1Ck92yGK9YQIKG
         s115GBhoPYiPjTOWQRI9TW0bol2zS3T/9fIyUeazJC6dBsCW0zOJRSsRKO4YE/CnEEmh
         x9+mFydL7pRiZ+au3rd6abPn5mDtEyLpv9Qb7i/lvZiU9aco60T1s5d/rjF2R1yG48Vf
         kMqQmIUgZJNqN4RssndmYs1PmTD9xSbtEMJdfCrtrzCYAco4zqr5XLryccRDb907XFRR
         rlBhAftDRvkGAiV4cULGvqz4NrencRL1JRXx5m+6hVW5lfUlS4wa9MjVD6JadIg8f1LZ
         0IQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SStzSCRIL9dliRtQBfGa5wPeZR1qlbqiwnb2P1Nrq+M=;
        b=Gq715ThXv83Pvr/0rpLpDg7yyjShz60EIkOZdeGMfI+LoY5j4m7taUBVJAJsA/KQ67
         U3GFIu555QRqjvWlGKa4hWj+ouvPA2NVVVMXVM+P3/yjU/HusPKbJWKAL0WdhXZ611m3
         vwb2zNJ3u+5Af3XF4M2s07Wu8DKv8ukjP49xa9gfziRrAXaPQMUHe7ASuEBYOPCaJCrI
         o8mp8YuOYgFn95OpFqDVuz0lrjcOmO1RuVfJNrQWPt8qvY/TTn0dIsIf6lIVuGVuHlkA
         T4T/19ehLENr2AkopH/W+t205615qqhuljRK05Pa0mWAU7d3k2Ji5rZEMOouzNm9/Afe
         GUrw==
X-Gm-Message-State: AOAM531A6xRqJMiUwq5Mkt8RKGpjoF1C92VrfhXTKq9zGHOLl3PM5ddq
        QV9ENuyzJjFW9W0G5VKbA6/CsVT0HJA=
X-Google-Smtp-Source: ABdhPJyEiza53qqYuGtG2nAcKR13Fzq1UZ4iPuNNFOrN60TyMTl+udtUOCBNtBZCJyHS/Au7x6woUA==
X-Received: by 2002:a1c:4b14:: with SMTP id y20mr1513544wma.6.1611602250984;
        Mon, 25 Jan 2021 11:17:30 -0800 (PST)
Received: from localhost.localdomain ([81.0.37.108])
        by smtp.gmail.com with ESMTPSA id e4sm11665895wrw.96.2021.01.25.11.17.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 11:17:30 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 7/7] bisect--helper: retire `--check-and-set-terms` subcommand
Date:   Mon, 25 Jan 2021 20:17:10 +0100
Message-Id: <20210125191710.45161-8-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210125191710.45161-1-mirucam@gmail.com>
References: <20210125191710.45161-1-mirucam@gmail.com>
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
index 145e1a6998..e26d9baa18 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -21,7 +21,6 @@ static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-reset [<commit>]"),
-	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-next-check <good_term> <bad_term> [<term>]"),
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
 	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
@@ -1028,7 +1027,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		BISECT_RESET = 1,
-		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
 		BISECT_START,
@@ -1043,8 +1041,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
-			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
 		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
 			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
 		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
@@ -1080,12 +1076,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

