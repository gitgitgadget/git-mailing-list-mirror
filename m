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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C57C433DB
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 05:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C80422B2C
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 05:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbhAZFCz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731671AbhAYTSf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 14:18:35 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5783DC06178C
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 11:17:30 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m2so429188wmm.1
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 11:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ybB2MQ6aSbsZbCq4sPLMz0ZvIE1tHEBXUXe4CME2QCY=;
        b=k6ua57qWr9HMM/3qPu3IHaCErmAGqRSdab3RWAumDsK2GQy9DDo2HnwrWAOxR0j0vd
         wojCB5tvzXtWAvAwEBkLCdtP10J+o8WqZ4HOwDPTl9a/eJz5cic+iuAqiv8KVCq0m7IH
         r1Zv18r8ZJUtzdZT9P10y5V6vVV3xAQeNB6Eog3O+0u+UhGv1vafncACYlHYtdG91+sw
         qTlhZ0wDLGgsjr8IGOX+H333d2+/4JSDSorEkLL1U83IIg5A/zKhVjlWmtFMFo/3jeNx
         ECqBmm/ACjbdqiABBsTJ1jnqgX7+9rFX1CTPKUpKRbFDVaCzKFLEDq1wwKNbE/+XpXOw
         L3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ybB2MQ6aSbsZbCq4sPLMz0ZvIE1tHEBXUXe4CME2QCY=;
        b=LRV+zN4muUy1lA543goEEkyacnbRI6UveZR+tMsIfCCpMFCVvEIpv7CRnKTbWB/XM+
         ysWBAv4v5pDzdok1LZzZH6sxPBShvzcNTgAt/pXdlPSKJ7XBrWtX0awGAybvgmG6U9NT
         EaEDYCqaTKmkNsdXv9crunO+7nuFJ0rE0PjnqfWOn4e/ExlrTvhKJsz5sI002jr3NpvP
         dPdI83WF3rczaDgB9eTlqtV5Tn4ZAVZJWcv8zj/OUXmF/4efMmg3K4qP+hn1G/EY7q4Y
         n1QiEMlUU/VHgfUi6BpfkyIfK4/vZDME9PKEgaTYvvelOOP1ViqwuNdK7uuh8/rpno+6
         8xvg==
X-Gm-Message-State: AOAM530JgSn0kcvjHI5CywTJwuBICNCt7AgLpCz9hidrhNnox7GR1mrl
        BnNLvjYOzgm6POlqGDhkKuaeuoD+Ht0=
X-Google-Smtp-Source: ABdhPJzCYXniTvTShngnx9ofFzIje79L1ZHNjwOC2spithE2NGf247gqOVR4213WS3bIciqhVbUYRw==
X-Received: by 2002:a1c:3b44:: with SMTP id i65mr1441723wma.53.1611602249132;
        Mon, 25 Jan 2021 11:17:29 -0800 (PST)
Received: from localhost.localdomain ([81.0.37.108])
        by smtp.gmail.com with ESMTPSA id e4sm11665895wrw.96.2021.01.25.11.17.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 11:17:28 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 5/7] bisect--helper: retire `--bisect-auto-next` subcommand
Date:   Mon, 25 Jan 2021 20:17:08 +0100
Message-Id: <20210125191710.45161-6-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210125191710.45161-1-mirucam@gmail.com>
References: <20210125191710.45161-1-mirucam@gmail.com>
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
index 8232e795fa..3672994c19 100644
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
@@ -999,7 +998,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_START,
 		BISECT_AUTOSTART,
 		BISECT_NEXT,
-		BISECT_AUTO_NEXT,
 		BISECT_STATE,
 		BISECT_LOG,
 		BISECT_REPLAY
@@ -1018,8 +1016,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("start the bisect session"), BISECT_START),
 		OPT_CMDMODE(0, "bisect-next", &cmdmode,
 			 N_("find the next bisection commit"), BISECT_NEXT),
-		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
-			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
 		OPT_CMDMODE(0, "bisect-state", &cmdmode,
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_CMDMODE(0, "bisect-log", &cmdmode,
@@ -1072,12 +1068,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

