Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC88F1F6C1
	for <e@80x24.org>; Tue, 23 Aug 2016 12:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758000AbcHWL7L (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 07:59:11 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:56028
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751214AbcHWL5t (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Aug 2016 07:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1471953233;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=ILdQI6PvYTQrsh1XQhDNxgcL8v+yI9U/LVtprBO62zA=;
        b=Cu+e+sEwkllf54RXjyB21HVpe/Wj1n9WcwOvnzuPKrd6b0hleLOEhvevWXae1tmQ
        3n4HMQZchu4C1v8gIK4WGw8RprfGlq8UJjKT+D4pCPfYbPugldEKOC46XUDJ7dzMpE+
        RtmPfvJIBjWyB8beIMiXOQwBelR+rvCOArH/6vcg=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020156b73fe6dd-4714236e-c26d-4ee8-b36e-caf516618d87-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
Subject: [PATCH v14 25/27] bisect--helper: retire `--bisect-autostart`
 subcommand
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 23 Aug 2016 11:53:53 +0000
X-SES-Outgoing: 2016.08.23-54.240.7.17
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
index 8982f29..a89e2f7 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -27,7 +27,6 @@ static const char * const git_bisect_helper_usage[] = {
 					      "[--no-checkout] [<bad> [<good>...]] [--] [<paths>...]"),
 	N_("git bisect--helper --bisect-next"),
 	N_("git bisect--helper --bisect-auto-next"),
-	N_("git bisect--helper --bisect-autostart"),
 	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
 	N_("git bisect--helper --bisect-replay <filename>"),
@@ -974,7 +973,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_START,
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
-		BISECT_AUTOSTART,
 		BISECT_STATE,
 		BISECT_LOG,
 		BISECT_REPLAY
@@ -993,8 +991,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("find the next bisection commit"), BISECT_NEXT),
 		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
 			 N_("verify the next bisection state then find the next bisection state"), BISECT_AUTO_NEXT),
-		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
-			 N_("start the bisection if BISECT_START empty or missing"), BISECT_AUTOSTART),
 		OPT_CMDMODE(0, "bisect-state", &cmdmode,
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_CMDMODE(0, "bisect-log", &cmdmode,
@@ -1050,13 +1046,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_auto_next(&terms, prefix);
 		break;
-	case BISECT_AUTOSTART:
-		if (argc)
-			die(_("--bisect-autostart requires 0 arguments"));
-		strbuf_addstr(&terms.term_good, "good");
-		strbuf_addstr(&terms.term_bad, "bad");
-		res = bisect_autostart(&terms);
-		break;
 	case BISECT_STATE:
 		if (argc == 0)
 			die(_("--bisect-state requires at least 1 argument"));

--
https://github.com/git/git/pull/287
