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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E89FC433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5074064F5F
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhBCV4v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 16:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbhBCV4s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 16:56:48 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3834C06178A
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 13:55:31 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id c12so1020755wrc.7
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 13:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=spbB+9a/qGy/GHfu1eZe/L4LU9K7gSjpfEPxZ03UfEo=;
        b=gCbQaWwJj6daR1xrlr/RgV15BDAwKkTQIroiG32YzI+9jWSv7Iq0j1ZzidFQvLQNyP
         R68GT8+a4t9gtkC1UnPChL7sAWiGe/wIawADqYuMsdBvjRrRlz2N/+OAsP/fjsZV66iv
         VuawADeM2fibeuu0WhLyoLjFlJ3HwbTaBirgpvclG1jJoRsI9BEFZV3A0hD96srjfN02
         UF1/Heio47cJ54C/tUxhtONINWVgBiYsAXo3w6ctE964K9NLPohUo4RzmJwPwV0vR4Ta
         WBox4rL/+YdDQLoBVZCS3c7xKoQRLe7pKyh1o3Lya8MgDm1xJ0ZLcjjV6X150iVesA7P
         i8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=spbB+9a/qGy/GHfu1eZe/L4LU9K7gSjpfEPxZ03UfEo=;
        b=piEYUgYlUBW/dmrjfK5O2Qs3BE/RyhmuAefL93ATJd5XMMQmd3zOqhM5WAx2ckFXUD
         Oh9/YhLsUvs0d+37P9W577o8ewbMNeOUWxdvLzKfOUvjOCi8QZDuLocd3nNMd7MuPaoS
         KOGAqLBOHV7Cq078/tDU/x5UJkc+hZigo+tvp6+f1LTtxslZA9kOLb7fMDXW9dG/xw02
         JnjKt/wU11W7caDgNADT34SI9e85kdr4hu7HNCr6rr46y45Zi7hoxMCl1zb1nfx9LiNq
         +CEnuySKfRecGp5KiUUQt3MnEhEcwgtZ31cZJPmEL24SHRyDi/pyL+G3wH7BXn0i0fYk
         OWZA==
X-Gm-Message-State: AOAM533kjKzU4JcZmNlLru7AE+u/FJJe0qjLkAHnnx0tJwKLCZli/4U6
        lXIQr6+R0OZX7isiW5xWNfxDchwwvo8=
X-Google-Smtp-Source: ABdhPJwvXZCgcIOv4Rh05ht0idyefa38awXpREQPoihNLUGhtjZt3AwXvwqGcXX7r0o00yqhRsHgNw==
X-Received: by 2002:adf:d20c:: with SMTP id j12mr5765988wrh.407.1612389330634;
        Wed, 03 Feb 2021 13:55:30 -0800 (PST)
Received: from localhost.localdomain ([81.0.37.148])
        by smtp.gmail.com with ESMTPSA id 143sm2609531wmb.47.2021.02.03.13.55.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 13:55:30 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     rafaeloliveira.cs@gmail.com, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v5 5/7] bisect--helper: retire `--bisect-auto-next` subcommand
Date:   Wed,  3 Feb 2021 22:54:36 +0100
Message-Id: <20210203215438.96760-6-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210203215438.96760-1-mirucam@gmail.com>
References: <20210203215438.96760-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The --bisect-auto-next subcommand is no longer used from the
git-bisect.sh shell script. Instead the function bisect_auto_next()
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
index fd018ddda5..31eba522ff 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -27,7 +27,6 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
 					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
 	N_("git bisect--helper --bisect-next"),
-	N_("git bisect--helper --bisect-auto-next"),
 	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
 	N_("git bisect--helper --bisect-replay <filename>"),
@@ -1003,7 +1002,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_START,
 		BISECT_AUTOSTART,
 		BISECT_NEXT,
-		BISECT_AUTO_NEXT,
 		BISECT_STATE,
 		BISECT_LOG,
 		BISECT_REPLAY
@@ -1022,8 +1020,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("start the bisect session"), BISECT_START),
 		OPT_CMDMODE(0, "bisect-next", &cmdmode,
 			 N_("find the next bisection commit"), BISECT_NEXT),
-		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
-			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
 		OPT_CMDMODE(0, "bisect-state", &cmdmode,
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_CMDMODE(0, "bisect-log", &cmdmode,
@@ -1076,12 +1072,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_next(&terms, prefix);
 		break;
-	case BISECT_AUTO_NEXT:
-		if (argc)
-			return error(_("--bisect-auto-next requires 0 arguments"));
-		get_terms(&terms);
-		res = bisect_auto_next(&terms, prefix);
-		break;
 	case BISECT_STATE:
 		set_terms(&terms, "bad", "good");
 		get_terms(&terms);
-- 
2.29.2

