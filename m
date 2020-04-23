Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1C3C54FD0
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 07:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9E6621569
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 07:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZuUoQTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgDWHJz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgDWHJv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 03:09:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B5FC03C1AB
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 00:09:51 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k13so5498515wrw.7
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 00:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/X2BnggV6TCXtyL0UyOGZtASS8zBP6Iv4SDOAr+jcPE=;
        b=gZuUoQTt6/fuea9x1AvGCo7N1kET6jaEVr2gCHvH8FHvqT6P9ZCUlu/u6cpPvnAMIJ
         ETah/Kw5p0GYt2lknBy6F4whgNkVjSq0pG+OW5ckiet9q3W+zYMEPUqqNtsxEa5+ZG0h
         7Fw5HZGa4TzschBbxFIei+MawZk2l4tY0pSe5TAXROtZTKYY8QRpsPhP6uwR0aVlemu8
         J3pOJkvAC4dOTWvRttCvTGeBbvI1S4Ri/x31UAsZz/nyt/kW3UUut7dEhVR6ANy/YI8Z
         QYgNnb8beknDbe9zYT890X+liR5t55Y33Bfm1jIyhLnpcgjx4g5E4TARodwjN+ohhfWj
         FF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/X2BnggV6TCXtyL0UyOGZtASS8zBP6Iv4SDOAr+jcPE=;
        b=lm/mJ4cGTbf7zPVZ6tiZqAsPYtAzsTCtKPybXuurYWUL2ubOnn6trCvffdUfTgYpBu
         uAmsu83nruItXeNaAaoE9V/nQ6uEO0i7SAEykq48VqCgpeo+ZzV3VhmLjUaBnGu4NeoX
         8MeKKwoF4GRT4RMR5N1eEou8oCnAzPmsdE4RgYf0c4L96iRppmtcfd0RfnfFj14B/Zew
         WI/jqPOqQdosLdoVx59hcTMFFyVtPEwKd9yJWjF4s+nw1YhBecxQG6gwf1yOyW2nbGj7
         7Wxw9wqh+/kNx6SlXxXKrVDx0rUWtBPps6T0JH9qAKUNnJBEFtJ0yz0A9ZcdFUjao/Mb
         PGvg==
X-Gm-Message-State: AGi0PuZqmLAYRTWqGMNZh+zwSM3D7f7FNjkwszIVFt0cJO9H+PZQr7rL
        hmbXgCG3Qx3bfxcB+V+AeTehZ1u/Xs+Ing==
X-Google-Smtp-Source: APiQypKzpIge8b+3LWpLgcFTWpPn0OnCYInE2mPDih+PGRA3ECniPWif83sLWcYcKvMeiL2OR0C0Sw==
X-Received: by 2002:adf:9564:: with SMTP id 91mr3325431wrs.246.1587625790111;
        Thu, 23 Apr 2020 00:09:50 -0700 (PDT)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u17sm2518585wra.63.2020.04.23.00.09.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 00:09:49 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 12/12] bisect--helper: retire `--bisect-autostart` subcommand
Date:   Thu, 23 Apr 2020 09:07:04 +0200
Message-Id: <20200423070704.39872-13-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200423070704.39872-1-mirucam@gmail.com>
References: <20200423070704.39872-1-mirucam@gmail.com>
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
index e7467dc1c7..66f9b8eab6 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -29,7 +29,6 @@ static const char * const git_bisect_helper_usage[] = {
 					     "[--no-checkout] [<bad> [<good>...]] [--] [<paths>...]"),
 	N_("git bisect--helper --bisect-next"),
 	N_("git bisect--helper --bisect-auto-next"),
-	N_("git bisect--helper --bisect-autostart"),
 	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
 	NULL
@@ -904,7 +903,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_START,
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
-		BISECT_AUTOSTART,
 		BISECT_STATE
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
@@ -925,8 +923,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("find the next bisection commit"), BISECT_NEXT),
 		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
 			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
-		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
-			 N_("start the bisection if BISECT_START is empty or missing"), BISECT_AUTOSTART),
 		OPT_CMDMODE(0, "bisect-state", &cmdmode,
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
@@ -988,12 +984,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
 		set_terms(&terms, "bad", "good");
 		get_terms(&terms);
-- 
2.25.0

