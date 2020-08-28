Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89633C433E6
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6056120872
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCgiwDXQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbgH1Mtr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729455AbgH1Mrg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 08:47:36 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56EFC06123C
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 05:47:27 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y3so1194096wrl.4
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 05:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NXxMtopeJlIDy0Y/iz+K2ZtFarELYfjiV1J6/3GJVEU=;
        b=PCgiwDXQMm55pVzOQOwkoBhG7VU6kaL3hrGr47e3fpcDJI47aeHZ/ypNI0TzpxZzz6
         nsS1yHKhjg+ovYTQ3dVs2vI/CS8/PfMxCOtl78y7LCPIps44Dg9d6DR1TxHq5mKmp1C3
         SewS9BO+PuDFbC0MGyRsm858+H3HI8THzolHAl1X8YsWPLBLIY6pcWFJTkuw/vIHTsTE
         Ta0iyGlTCjiJjxhyqruSmeLLtX91TcaEwChOYj+DcSJSmlScZseiqljY3qles/GqjKeS
         6+GGKq0MpMmySxdNCKnb0J+JBqy/Q8WS6TCV8k2TgGJnxXkNUV3/Vo1FTquPNZoEY7bX
         sx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NXxMtopeJlIDy0Y/iz+K2ZtFarELYfjiV1J6/3GJVEU=;
        b=TQGGWb01ZIjlkW4YMOVsSEAIYjO94wjhA4KNqiPd1ZOwfnjnZ9QkA8dvd3X/UjrMJS
         kL9w/oGoUynVhwZgr828OH8Dr85kmQhe/rRwKpCTITSVY23TkBy5wppV+7vjWj3IRFwd
         SKQdjrAdRt7oLr4rtsVBqiEvpi5kl7SD7ElqtseQz80P/aMLKcM7bWib3RjBuVAeik4e
         7Zd9mRecDXGE789KMslcHDramRp9S9ijHePnJaXG3FffB0wTDFXAloYTWju5leJw+t1C
         udo4VdODdtnUHV7WXcSN9VUK9t295HXheiagWyTX/NV5ELx+amgLp7NXfWssv8FAFEti
         +z8Q==
X-Gm-Message-State: AOAM532Cm+BuaTOj3Iy8s5/RCGmrTzhBMZpTa5XnGpxxX5+CWXwMSS1J
        5gozOYXheOEw6eGDfmgqs3EUSOgUOrQ=
X-Google-Smtp-Source: ABdhPJyIytkUUM0wzn/u24jlHwcaZ8Cu3xMwL2KkM95KJyDK8KoiK6fBpqX9sg7uztzIctpWaqjJpQ==
X-Received: by 2002:a5d:56c1:: with SMTP id m1mr1322330wrw.87.1598618846065;
        Fri, 28 Aug 2020 05:47:26 -0700 (PDT)
Received: from localhost.localdomain ([178.237.236.228])
        by smtp.gmail.com with ESMTPSA id o66sm2176878wmb.27.2020.08.28.05.47.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Aug 2020 05:47:25 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v6 13/13] bisect--helper: retire `--bisect-autostart` subcommand
Date:   Fri, 28 Aug 2020 14:46:17 +0200
Message-Id: <20200828124617.60618-14-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200828124617.60618-1-mirucam@gmail.com>
References: <20200828124617.60618-1-mirucam@gmail.com>
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
index a6282d54a2..be1291f036 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -29,7 +29,6 @@ static const char * const git_bisect_helper_usage[] = {
 					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
 	N_("git bisect--helper --bisect-next"),
 	N_("git bisect--helper --bisect-auto-next"),
-	N_("git bisect--helper --bisect-autostart"),
 	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
 	NULL
@@ -919,7 +918,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_START,
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
-		BISECT_AUTOSTART,
 		BISECT_STATE
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
@@ -940,8 +938,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("find the next bisection commit"), BISECT_NEXT),
 		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
 			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
-		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
-			 N_("start the bisection if it has not yet been started"), BISECT_AUTOSTART),
 		OPT_CMDMODE(0, "bisect-state", &cmdmode,
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -1001,12 +997,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_auto_next(&terms, prefix);
 		break;
-	case BISECT_AUTOSTART:
-		if (argc)
-			return error(_("--bisect-autostart does not accept arguments"));
-		set_terms(&terms, "bad", "good");
-		res = bisect_autostart(&terms);
-		break;
 	case BISECT_STATE:
 		set_terms(&terms, "bad", "good");
 		get_terms(&terms);
-- 
2.25.0

