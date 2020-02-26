Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6A9C4BA0B
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7282C20838
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwJnHKnJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgBZKQY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:16:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40731 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbgBZKQV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 05:16:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so2365439wmi.5
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 02:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4vP1F/2EPWvsd5i4FHZEtbX7J6rbdzxeMDK5RwREv4Q=;
        b=DwJnHKnJl4HiU4+msKBL7uaiAp6vJb4lIe4089nsF9/CuiDgNkFlOTXGzZACzUbV5H
         iSZZm1E8uaAqXhlIu6FaO5aqZ71QfMALct9CYgPXqDDY7GJIjGn2Z9yaDMK2gqcYPiX5
         PmRLkfpd4oU18XD7DaHRKGZkBhd7ExBWnUjxeEHnPQrJOhqR0JDEm/FNK1/dEaaDHQrC
         Q49C+nwy2MQ8DW0JyUqv79z98HmrzP2M8vMZktcj0jNt0sAxZO8QOuUIXAp36sLKZuQz
         5MjMYu7sbREgZB5O55Dsf+67Ay5E14VRxD8r933EwwWRlRNQxKtYZQoWNVeMqqPl2iKB
         FiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4vP1F/2EPWvsd5i4FHZEtbX7J6rbdzxeMDK5RwREv4Q=;
        b=aB6jRz4658b5DXeEW/vYvJhx9iVHeISvTe690wCgkcXs12Qn1HRmNehFJHgZCwhSAD
         b9ZGFKtPRvacjXGaaWrrRF3zGJ5OonVe1/dPTy2NHywgU4F4JT6GamCWwnWluVmQH+Uv
         Exgfec4rhQgM5l696QppEBud5ptHA2fvik0MIFTLnhKqfmbqX2CbMGEnBLmDVMCDbmqC
         Vc6L6YyOzU+0b95uWPaZr5CFlnsE8Kln5VRqJx+E0RMIf9pni9NncvPECGbPkDMgdVnh
         EQgu7l8E+RaNuqX6m8ln/c3fRqzkXgPI9eS5H2EsK3M3xpQ22zEpFOnZCwF6BJk6adI8
         eEAA==
X-Gm-Message-State: APjAAAWPVKzZDGFCW8+p8pJVqb4iRjTxEBG5mAB2f4VlCD3pHyBEVTK8
        YlyCkniaTLacXfXpVxLeEI2AsxkhoyA=
X-Google-Smtp-Source: APXvYqxhLXCMa3liSff8Jj5BZqL15bKMyX+uGlIffSRv7RhsHXixoIKyid+SN7RsUrVgJUQ1puO+Yg==
X-Received: by 2002:a7b:c851:: with SMTP id c17mr4541792wml.71.1582712180014;
        Wed, 26 Feb 2020 02:16:20 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id t3sm2577081wrx.38.2020.02.26.02.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 02:16:19 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 10/10] bisect--helper: retire `--bisect-autostart` subcommand
Date:   Wed, 26 Feb 2020 11:14:29 +0100
Message-Id: <20200226101429.81327-11-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226101429.81327-1-mirucam@gmail.com>
References: <20200226101429.81327-1-mirucam@gmail.com>
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
index 650ceefcd7..c692c660a4 100644
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
@@ -913,7 +912,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_START,
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
-		BISECT_AUTOSTART,
 		BISECT_STATE
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
@@ -934,8 +932,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("find the next bisection commit"), BISECT_NEXT),
 		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
 			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
-		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
-			 N_("start the bisection if BISECT_START is empty or missing"), BISECT_AUTOSTART),
 		OPT_CMDMODE(0, "bisect-state", &cmdmode,
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
@@ -997,12 +993,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
2.25.0

