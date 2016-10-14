Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A48A1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 15:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753610AbcJNPIM (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 11:08:12 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:60804
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753359AbcJNPII (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Oct 2016 11:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1476454456;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=jS4ZaptJE1kYa3NHvwGR9RAyyiKhyB+vx843DbzqVbY=;
        b=asQ7DHftrNkoDAiRUL2YNPLjoF61X7J4GkQGbT+XhLKI9R+DbM2VVId4wVVq3s3Q
        VGntac7B9JgezOQYEWMAnBIPH4ydBcCU0roVlTmSXTMrJx4kyUZLm4dBPezUt6h3Y0G
        mViW0gpL2EHs08LAhFHes5qwZTy9QDXPOO+R//JU=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020157c38b1b50-74ee305b-1121-4c0f-b827-30d115d0bf02-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
Subject: [PATCH v15 25/27] bisect--helper: retire `--bisect-autostart`
 subcommand
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Oct 2016 14:14:16 +0000
X-SES-Outgoing: 2016.10.14-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `--bisect-autostart` subcommand is no longer used in the shell
script and the function `bisect_autostart()` is called from the C
implementation.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 7f676e2..8653fde 100644
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
@@ -995,7 +994,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_START,
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
-		BISECT_AUTOSTART,
 		BISECT_STATE,
 		BISECT_LOG,
 		BISECT_REPLAY
@@ -1016,8 +1014,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("find the next bisection commit"), BISECT_NEXT),
 		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
 			 N_("verify the next bisection state then find the next bisection state"), BISECT_AUTO_NEXT),
-		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
-			 N_("start the bisection if BISECT_START empty or missing"), BISECT_AUTOSTART),
 		OPT_CMDMODE(0, "bisect-state", &cmdmode,
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_CMDMODE(0, "bisect-log", &cmdmode,
@@ -1079,13 +1075,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_auto_next(&terms, prefix);
 		break;
-	case BISECT_AUTOSTART:
-		if (argc)
-			die(_("--bisect-autostart requires 0 arguments"));
-		terms.term_good = "good";
-		terms.term_bad = "bad";
-		res = bisect_autostart(&terms);
-		break;
 	case BISECT_STATE:
 		if (argc == 0)
 			die(_("--bisect-state requires at least 1 argument"));

--
https://github.com/git/git/pull/287
