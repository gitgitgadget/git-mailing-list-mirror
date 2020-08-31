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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0272DC433E6
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 10:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC5A2068F
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 10:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NI7ZwzWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgHaKwW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgHaKv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 06:51:27 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BFAC06123D
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 03:51:25 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a65so4915314wme.5
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 03:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QKmyIQ9aj2TmCg7rEZp9XmRDa/r98jYMzgK1OYEkziE=;
        b=NI7ZwzWhoeSmvlELDszmPMH3Z64km7/iQsYP+l7Z+79k4EVy5t9OxoSubvcc9Pacuo
         JVPrwKh/kYwf14UfKiKNKbiNf6H2k43Gm69QjXdCFAyWWeR0rAB3OF3Ime6kx4lYabP9
         jfO83/q8uV9Hj/sn5zaX2ra16fjcVUNU8e+SqnSzzVvamA9MdTl4JTkEOZU/5qnNgl2u
         nK2PIiYqgv9Y8csWpixqaOGhGNVfTT5FzWy2icYlaWeVHwW3tdRDp8e3IlXXWnt1wZ+r
         DIPwhzU9yJJT0fuUDjYzm16A2/MFX4njzK2LyTk27xq9YNnDUXPMc9Sh50HhI9IZLo/o
         Efpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QKmyIQ9aj2TmCg7rEZp9XmRDa/r98jYMzgK1OYEkziE=;
        b=uYg8rVazSrDILv0D/bkEf0Losx+eluwGlQEFJqSmAUuqQ9DyeJYzGbjWsesMtj5bAM
         59fM7NSUFwxUiPoE4EzJfZgDkuXJpKp01Yvtbrbu14khwRuHHfiMdGAjux0AjK8Kky1i
         viUFnHv7/q20Avt7DFfJsUADXeziRPzNV4jpu3KyOd3ioZxL/md12j01lDQmebvQjJV3
         lbvWDSI1vyN47RAqoZUmk1674HrpT5m0oorpDYEaDZqjVr1CXFOcBZztRlQ+SxWMAh+K
         ATPJE6RU5pQlqd30B/QlX2dQaXIUfN4yqqzrAsNWO2QKDQubHmx8sDTYSI3cYH1/Rc7t
         Iciw==
X-Gm-Message-State: AOAM532Y8F8wQhmIlL25MPJEHb85Diy6+7WTV8Jnd9QIe+mjE0mSBaac
        lvWoC1Y8qxWQllXatcW8WW1wH7FPdXk=
X-Google-Smtp-Source: ABdhPJzKJq8DLebMlU35F2klbLbmEFHR2j6xH6wYnzplA8bezbs8LDN0o1qIuuLkk31UiuISaHrLrA==
X-Received: by 2002:a1c:541b:: with SMTP id i27mr792872wmb.179.1598871084085;
        Mon, 31 Aug 2020 03:51:24 -0700 (PDT)
Received: from localhost.localdomain ([178.237.236.228])
        by smtp.gmail.com with ESMTPSA id k84sm7674454wmf.6.2020.08.31.03.51.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 03:51:23 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v7 13/13] bisect--helper: retire `--bisect-autostart` subcommand
Date:   Mon, 31 Aug 2020 12:50:43 +0200
Message-Id: <20200831105043.97665-14-mirucam@gmail.com>
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
index 46ddfd5710..8a48c1ef8e 100644
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
@@ -916,7 +915,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_START,
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
-		BISECT_AUTOSTART,
 		BISECT_STATE
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
@@ -937,8 +935,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("find the next bisection commit"), BISECT_NEXT),
 		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
 			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
-		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
-			 N_("start the bisection if it has not yet been started"), BISECT_AUTOSTART),
 		OPT_CMDMODE(0, "bisect-state", &cmdmode,
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -998,12 +994,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

