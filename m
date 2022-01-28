Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E25DC433FE
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 00:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344531AbiA1AMo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 19:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238679AbiA1AMk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 19:12:40 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B769AC061748
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 16:12:39 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e8so7785912wrc.0
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 16:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kHw3oPYgtl9TKEaskM7/b5rVUaY/eEHOcDJQMigxLHw=;
        b=dChvK3haIVnTnIF6GvqkR0+B3h2aPheeB28ZDuABi8C9Fgfq5OFsnPIJ7DO+mIoml5
         qOP9vX877wrUyMDcuV+SxFNuwCALIEHP7YSos8VSemEXEYUn/Pr2SeNAikZk1wxX0dtV
         Tr7gz0IxrnYiQftDfKHgO4vFqSu91gzqp8Kme1YzzUnCeMFfKCqsWcNW6Aj01WppLOmg
         oVrjIDHrnQaFrZ/2/FwgxR1HCvBzUYMhWKYBoEnwPrm80NyFNFe5PP27w+LWW0jefBUN
         X3MnPHv/J3+o1Tu6DEVT0u8RiaRCKfPm/ZPAvUa8/FGWBJQjx3t1vZEeNRaZ3flQfJkU
         pjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kHw3oPYgtl9TKEaskM7/b5rVUaY/eEHOcDJQMigxLHw=;
        b=W+pFredwhHEsBkx4SWsx7VWDDgRfM0H4lMN0yh7CzB0F3eUh9UZjYK9oTG6oKKFlQQ
         4L1SBbxAiouixOnW2TJWStEjrAqJK7zR0kBGh7ndf6/6o3iv5kI1AxWFH69AiugczWbl
         zXAMjkoLfHjMdfUiEl46kp3oeYFjZYyLswq4wfnpnBOpB/eNFNlzt8yW6hFErFfhENNh
         BDNnX4lZ5yQsAU1zpFerj+ZrHGR8z6H64kr/JM9Cmbk5nZR60MIed04Zwo//qEAuxdxq
         Cl/PdiGAzSGtXVT9Eq9TlmxjHgBTWeQMsp63zjZ8pEcrfflDpOfCqpGLIQVjXcyO+ooQ
         MM2A==
X-Gm-Message-State: AOAM533nK6tS+mvzXug+xlToWTpYHuEHZpK7UrZeStWJelCTBNaCjEp2
        aSl7dJU2xKJdwYZdmx287PYuXCXJhto=
X-Google-Smtp-Source: ABdhPJzA15ErKybqOS2Gd393gvS3JEccko/3fCmQyucTdgYATMm0nER8ob74r+aXipdzjcBSpLUJxQ==
X-Received: by 2002:a5d:6e88:: with SMTP id k8mr4802121wrz.384.1643328758183;
        Thu, 27 Jan 2022 16:12:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e17sm564417wme.29.2022.01.27.16.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 16:12:37 -0800 (PST)
Message-Id: <eddbdde222a01113d8facdcb17d6ec85676edbe7.1643328752.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Jan 2022 00:12:27 +0000
Subject: [PATCH 06/11] bisect--helper: make `--bisect-state` optional
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In preparation for making `git bisect` a real built-in, let's prepare
the `bisect--helper` built-in to handle `git bisect--helper good` and
`git bisect--helper bad`, i.e. do not require the `--bisect-state`
option to be passed explicitly.

To prepare for converting `bisect--helper` to a full built-in
implementation of `git bisect` (which must not require the
`--bisect-state` option to be specified at all), let's move the handling
toward the end of the `switch (cmdmode)` block.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index cc5a9ca41b9..219fa99cd0b 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -26,8 +26,8 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
 					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
 	N_("git bisect--helper --bisect-next"),
-	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
-	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
+	N_("git bisect--helper [--bisect-state] (bad|new) [<rev>]"),
+	N_("git bisect--helper [--bisect-state] (good|old) [<rev>...]"),
 	N_("git bisect--helper --bisect-replay <filename>"),
 	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
 	N_("git bisect--helper --bisect-visualize"),
@@ -1210,6 +1210,13 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			     git_bisect_helper_usage,
 			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN);
 
+	if (!cmdmode && argc > 0) {
+		set_terms(&terms, "bad", "good");
+		get_terms(&terms);
+		if (!check_and_set_terms(&terms, argv[0]))
+			cmdmode = BISECT_STATE;
+	}
+
 	if (!cmdmode)
 		usage_with_options(git_bisect_helper_usage, options);
 
@@ -1218,11 +1225,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		set_terms(&terms, "bad", "good");
 		res = bisect_start(&terms, argv, argc);
 		break;
-	case BISECT_STATE:
-		set_terms(&terms, "bad", "good");
-		get_terms(&terms);
-		res = bisect_state(&terms, argv, argc);
-		break;
 	case BISECT_TERMS:
 		if (argc > 1)
 			return error(_("--bisect-terms requires 0 or 1 argument"));
@@ -1265,6 +1267,13 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_run(&terms, argv, argc);
 		break;
+	case BISECT_STATE:
+		if (!terms.term_good) {
+			set_terms(&terms, "bad", "good");
+			get_terms(&terms);
+		}
+		res = bisect_state(&terms, argv, argc);
+		break;
 	default:
 		BUG("unknown subcommand %d", cmdmode);
 	}
-- 
gitgitgadget

