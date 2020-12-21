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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5543C433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F2D022D49
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgLUSEI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgLUSEI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:04:08 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8045BC061793
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:03:27 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id q75so11806781wme.2
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6tiXz/t4UiV/XSnd2ixEMzrxraYDb6koYQUu1uHN3t8=;
        b=VcThca1p+xhcmoJByr2dpv7tqmcSL6/0qeahXff+I4HGTx3VVz4Bz8ByDfb2Ze3O7K
         ygbiLMZw6mpgRhhjo+z2cwB5b1zvZ1d3K0gSV9b11AZMTre+NETVYK4eVsJTYC5ltQOM
         8NA7LHYwmPub21uDdNDNaea9XcPJaPoo1UokNhdHeQWEvV/ICo9s49E28sAlBofNMzzW
         HvjYyDMm0CUsLGG0UspUsdylnPqUkWurHz9geY1AB0EOteeow86Fz/UD9aW1vn/HDTe/
         sKF+xSa2j7as+jAyqgbL4e4ZEquTtjFsiRNCFwRGXC227O8lFBZQDXpcXiAfkGFIbSFM
         XSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6tiXz/t4UiV/XSnd2ixEMzrxraYDb6koYQUu1uHN3t8=;
        b=q8OEkgfYEgdAzSVlW80ngB715YDMDFw37ewvsJ67mAPuivlVKp/nAa3etiHa3eUSie
         k2WSYQEAkTtyFX3Wu+wE8aH+/iiV8rfKGd+BDbYAA7N01fFoIfuwR2PQ9X4dhVU9kdNb
         7KrWNbdHfrO7hctyxBAl2l4i9YaP6Bv7siQAcRo6+cLt6QFwQ0kO6nSJ3+bXUgPvzXPS
         neaBAAeex7SruW+YITvLIlB3b6zLaUUb8vdODRiQO2NUFTSKV9p6FVSyvsvQA6wVmbJT
         Ob52H5mHxqQXI4tWswLVvdczkk051IKA+gNM09H1jZLfKrLuzRt3cf90ekPU4pAFI3Cx
         FVpA==
X-Gm-Message-State: AOAM530C+mkcNSE41Mlk6yNVkAC094NFeqWci0NE3X/jP7TVX/n0fb1a
        RRaGjVDB5oY09lNWNBZ/KaTuy2O6IYiq7A==
X-Google-Smtp-Source: ABdhPJwoMma52ze3aBC/QksBxtD+v+mDCDINm+j55Gi7KaXd48YWAn1xuQ2OmIILEpbmjdZfYJSaKw==
X-Received: by 2002:a1c:4c14:: with SMTP id z20mr17668153wmf.149.1608568172415;
        Mon, 21 Dec 2020 08:29:32 -0800 (PST)
Received: from localhost.localdomain ([81.0.34.85])
        by smtp.gmail.com with ESMTPSA id w18sm28523532wrn.2.2020.12.21.08.29.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Dec 2020 08:29:31 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 5/7] bisect--helper: retire `--bisect-auto-next` subcommand
Date:   Mon, 21 Dec 2020 17:27:41 +0100
Message-Id: <20201221162743.96056-6-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201221162743.96056-1-mirucam@gmail.com>
References: <20201221162743.96056-1-mirucam@gmail.com>
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
index e2e568823e..d570a165de 100644
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
@@ -1041,7 +1040,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_START,
 		BISECT_AUTOSTART,
 		BISECT_NEXT,
-		BISECT_AUTO_NEXT,
 		BISECT_STATE,
 		BISECT_LOG,
 		BISECT_REPLAY
@@ -1060,8 +1058,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("start the bisect session"), BISECT_START),
 		OPT_CMDMODE(0, "bisect-next", &cmdmode,
 			 N_("find the next bisection commit"), BISECT_NEXT),
-		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
-			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
 		OPT_CMDMODE(0, "bisect-state", &cmdmode,
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_CMDMODE(0, "bisect-log", &cmdmode,
@@ -1114,12 +1110,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

