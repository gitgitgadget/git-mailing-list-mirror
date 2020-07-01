Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B162C433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA5A4206BE
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfSxQpLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731182AbgGANfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731169AbgGANfu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 09:35:50 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7296C08C5DB
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 06:35:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so20854780wrw.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 06:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Y/JPWZjlooegeuPzZAbvbNDZ80yoEyxQtQXJCYUFx0=;
        b=VfSxQpLC0OI+qYF/Ksga8WKtXyI55WAEG8Eo6npawc+UylJAyCwm3vPwlPk2ytFtG1
         1HHlggYHyfoEbyjG2M64rFLHEQ6TDgaja448sJopkrSqQwQBFZ8Sy65hfDB0gOb2T+Dv
         gprWD+DiaODcEwJXfpqeNy1bm9EjtvHKLuorCYl2EuG55ghC8YilWxrq6GGiHs7c/ETg
         SbeCs9hbp+ZZC9pxx3bs/AihoNfGeQHcb4osv+uFYvLa4+MjClLSMRgRGz5Kqt/1tPpM
         N6T1QlNfehGeTr7utoy1kdeujnHnk7eO1bhDkllcxW2v0Ym9szL4NQKYOhhliUv6PEhI
         iyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Y/JPWZjlooegeuPzZAbvbNDZ80yoEyxQtQXJCYUFx0=;
        b=mrXDAwFAiovOI5S/5EJ56AYhFusnL+Ih0Z2GzGQ3GpoqryacBhWR7KVFahHRT44K0G
         kyfm11Sn+7oCbWvC6VrEG6F/o9WuXwFot9MqFk3vAIBPzw8DbNk9uXCmmcWN0SOY21gA
         P0a56k79YJKt5wZ+zRoxF4WvOzRIEE/q59PfAXlfMYTWKWwDnGIvwXWl/I8iwMB/albS
         mgs3bpmg2qK2akV+1vyVoYrZyQrQ/Cs9aQBIDXMKOK2wpMZaoj4yhhKI8Wo/IkFfLLry
         KiAFuAlx2byUrOeU5Kw7Lph1bi/8KejZY/t4wue549LlYq+NlG8YC+zibrIeSAYdapPg
         7mJw==
X-Gm-Message-State: AOAM532wHAvDz+921eJuc2DPOMl381rB8RJ5QXab1DOpoWDnrH4ZWULm
        bB4kLbTFNhv+Q+AVP7ToFp06Vl66R4wfGw==
X-Google-Smtp-Source: ABdhPJwBMb7vgHEpkE8r2QmGBZbc6hfMoEyhLheeEdWGOvNLRU4ukRuDDiSXz84cp4RdXaNchqmyig==
X-Received: by 2002:a5d:4e87:: with SMTP id e7mr28402176wru.12.1593610548221;
        Wed, 01 Jul 2020 06:35:48 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.178])
        by smtp.gmail.com with ESMTPSA id 30sm7928840wrm.74.2020.07.01.06.35.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 06:35:47 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 13/13] bisect--helper: retire `--bisect-autostart` subcommand
Date:   Wed,  1 Jul 2020 15:35:04 +0200
Message-Id: <20200701133504.18360-14-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200701133504.18360-1-mirucam@gmail.com>
References: <20200701133504.18360-1-mirucam@gmail.com>
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
index ca9d27b005..7a9fa4de78 100644
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
@@ -920,7 +919,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_START,
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
-		BISECT_AUTOSTART,
 		BISECT_STATE
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
@@ -941,8 +939,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("find the next bisection commit"), BISECT_NEXT),
 		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
 			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
-		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
-			 N_("start the bisection if it has not yet been started"), BISECT_AUTOSTART),
 		OPT_CMDMODE(0, "bisect-state", &cmdmode,
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
@@ -1004,12 +1000,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

