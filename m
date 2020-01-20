Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7D2C33CBA
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55AF217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOX68NQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgATOjA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:39:00 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38556 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgATOjA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:39:00 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so29850818wrh.5
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+wkLrKabkIpcF6ub4Zs4YogBSr046SKAALErewvEhNo=;
        b=bOX68NQyN8ZFCCixAjGD8wP5OsuYc6VoEwflwMJD1NJW2yy+ZFbCRwMP/WiYCpTEeT
         O9D3b5Cxh+7IpKs6Hg+SQx8bg4EPq/HQngo/Q5M+FhwLg4FZGt+yRss3rPLn4TMWtKN2
         hdY/2gj67FxjUYTYYZG1Q0LJpS2M5RL1vmcmAEBXVoHFZ/Ki0bwzTKWV63yBcGM96NZ8
         qKC3i1TICChos/4aGWQNxOXPvXeFrHgXDGzFhi/R0XgFwJg9/vZrKPqy72y8USArofZr
         RpltZWl0x9eSu2Zg1bTL/zhHnd8lwrSuruXdA+QElttgLLkPRzsP5/bN9WW7znMyR1mG
         tpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+wkLrKabkIpcF6ub4Zs4YogBSr046SKAALErewvEhNo=;
        b=peYKPoMlH/7CjmmSQSY/iHhy7vczgE68B4I6rV+3FN2YlmydEirj3qg1ARy6OL/7Di
         LknIGCNPoN1p6R/HcdaBfBPSp+Ps4tuFoERsS+H/6x6Hhzwvx4ZNDXcAXblX/xLzJG6Y
         1jUZ68jPJUatgC6zFzEZ/WQtkXrZw5zQbS7ez97U1TzEcoHvJ0wr4JBsnl8T/+R8BXOa
         +A4owFi38/3ldOw+dSLt1w7wiP6f1MZTCo102a9oQW9eXoHI8R27yX4lVbpQx3o8LJg8
         t4KhcEu6ntxwXNvv6I1mxJT16f79z93VVxAbKvtt8TC6HB0iMCUoafTJHrT+UimVfx33
         QwrQ==
X-Gm-Message-State: APjAAAXZ3bd7VYiNn+1It4GNa/R0w7aDZffHdovlXT1gu8zzOYzQ1qCM
        zITTV9EL5hX2pQQbqY99wlieslzz7uQ=
X-Google-Smtp-Source: APXvYqyWzvJh5dv/nEx3Q8BX9x8wrgwQ9+FE2AFIVfgEedEC+Uo2whr7NL7DtxdvnDscyu/U4Go6ug==
X-Received: by 2002:adf:f288:: with SMTP id k8mr19566733wro.301.1579531137923;
        Mon, 20 Jan 2020 06:38:57 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.38.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:38:57 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 24/29] bisect--helper: retire `--bisect-autostart` subcommand
Date:   Mon, 20 Jan 2020 15:37:55 +0100
Message-Id: <20200120143800.900-25-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200120143800.900-1-mirucam@gmail.com>
References: <20200120143800.900-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--bisect-autostart` subcommand is no longer used from the
git-bisect.sh shell script. Instead the function
`bisect_autostart()` is directly called from the C implementation.

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
index 378b41cf70..9becc1d514 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -28,7 +28,6 @@ static const char * const git_bisect_helper_usage[] = {
 					     "[--no-checkout] [<bad> [<good>...]] [--] [<paths>...]"),
 	N_("git bisect--helper --bisect-next"),
 	N_("git bisect--helper --bisect-auto-next"),
-	N_("git bisect--helper --bisect-autostart"),
 	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
 	N_("git bisect--helper --bisect-replay <filename>"),
@@ -1029,7 +1028,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_START,
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
-		BISECT_AUTOSTART,
 		BISECT_STATE,
 		BISECT_LOG,
 		BISECT_REPLAY
@@ -1050,8 +1048,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("find the next bisection commit"), BISECT_NEXT),
 		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
 			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
-		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
-			 N_("start the bisection if BISECT_START is empty or missing"), BISECT_AUTOSTART),
 		OPT_CMDMODE(0, "bisect-state", &cmdmode,
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_CMDMODE(0, "bisect-log", &cmdmode,
@@ -1112,12 +1108,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_auto_next(&terms, prefix);
 		break;
-	case BISECT_AUTOSTART:
-		if (argc)
-			return error(_("--bisect-autostart requires 0 arguments"));
-		set_terms(&terms, "bad", "good");
-		res = bisect_autostart(&terms);
-		break;
 	case BISECT_STATE:
 		if (!argc)
 			return error(_("--bisect-state requires at least one revision"));
-- 
2.21.1 (Apple Git-122.3)

