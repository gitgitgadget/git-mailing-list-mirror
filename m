Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 187121F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 14:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754196AbcJNOad (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 10:30:33 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:52498
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753979AbcJNOa3 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Oct 2016 10:30:29 -0400
X-Greylist: delayed 971 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Oct 2016 10:30:29 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1476454456;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=Z+bsqsnMN+7aHNah8ogSitdT5Pkf/xOS0I7kOeZ5ZxE=;
        b=YaEfOur5NQRnuoIr17/ZnCkBuidW3x6tKGtVQZuQlDSvi9Ut9UE9WLN4CY9uJtHX
        FcFEh+Rkd3uZZ/vZBsOZsCZdd3ETXPszrrLO+qmJj2Q30nvLztaXB57HZY/z8nQ4/LI
        xuKH1maeD8UXTykLpwCUHltXqJVK02COp1VI1mEU=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020157c38b1b47-1ec438cb-2643-4e6c-b010-b7585429f948-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
Subject: [PATCH v15 26/27] bisect--helper: retire `--bisect-auto-next`
 subcommand
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Oct 2016 14:14:16 +0000
X-SES-Outgoing: 2016.10.14-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `--bisect-auto-next` subcommand is no longer used in the shell
script and the function `bisect_auto_next` is called from the C
implementation.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 8653fde..d6c2efc 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -27,7 +27,6 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect start [--term-{old,good}=<term> --term-{new,bad}=<term>]"
 					      "[--no-checkout] [<bad> [<good>...]] [--] [<paths>...]"),
 	N_("git bisect--helper --bisect-next"),
-	N_("git bisect--helper --bisect-auto-next"),
 	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
 	N_("git bisect--helper --bisect-replay <filename>"),
@@ -993,7 +992,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_TERMS,
 		BISECT_START,
 		BISECT_NEXT,
-		BISECT_AUTO_NEXT,
 		BISECT_STATE,
 		BISECT_LOG,
 		BISECT_REPLAY
@@ -1012,8 +1010,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("start the bisect session"), BISECT_START),
 		OPT_CMDMODE(0, "bisect-next", &cmdmode,
 			 N_("find the next bisection commit"), BISECT_NEXT),
-		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
-			 N_("verify the next bisection state then find the next bisection state"), BISECT_AUTO_NEXT),
 		OPT_CMDMODE(0, "bisect-state", &cmdmode,
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_CMDMODE(0, "bisect-log", &cmdmode,
@@ -1069,12 +1065,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_next(&terms, prefix);
 		break;
-	case BISECT_AUTO_NEXT:
-		if (argc)
-			die(_("--bisect-auto-next requires 0 arguments"));
-		get_terms(&terms);
-		res = bisect_auto_next(&terms, prefix);
-		break;
 	case BISECT_STATE:
 		if (argc == 0)
 			die(_("--bisect-state requires at least 1 argument"));

--
https://github.com/git/git/pull/287
