Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13E64206A3
	for <e@80x24.org>; Tue, 23 Aug 2016 12:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932871AbcHWMBO (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 08:01:14 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:54306
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758042AbcHWMAr (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Aug 2016 08:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1471953233;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=tTfSif9Vl9x3BznUv176wEVkGLX2kvzEUujANl2BVQI=;
        b=PFtPGNepkZ2pkIOOrnkqpPsue+DcEAbgQCy4gjDtKEXHrtvdjS5gH1qjeW/RKIb0
        kHmJuLGvhVqu6A5lJihFTuhxf9b3LH/Ioz4WMWwEzptTMz1rgGDOOFpV+/5OpSCzP8/
        8Saa41SA/or6jv+5tYorW8qHBd4JhmIxaFOlrdMI=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020156b73fe6de-17b295fa-cf29-4b4d-a85d-b9b0176213e7-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
Subject: [PATCH v14 24/27] bisect--helper: retire `--check-and-set-terms`
 subcommand
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 23 Aug 2016 11:53:53 +0000
X-SES-Outgoing: 2016.08.23-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `--check-and-set-terms` subcommand is no longer used in the shell
script and the function `check_and_set_terms()` is called from the C
implementation.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 4ab6488..8982f29 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -21,7 +21,6 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-reset [<commit>]"),
-	N_("git bisect--helper --bisect-check-and-set-terms <command> <TERM_GOOD> <TERM_BAD>"),
 	N_("git bisect--helper --bisect-next-check [<term>] <TERM_GOOD> <TERM_BAD"),
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
 	N_("git bisect--helper --bisect start [--term-{old,good}=<term> --term-{new,bad}=<term>]"
@@ -970,7 +969,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		BISECT_RESET = 1,
-		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
 		BISECT_START,
@@ -985,8 +983,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
-			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
 		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
 			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
 		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
@@ -1025,13 +1021,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			die(_("--bisect-reset requires either zero or one arguments"));
 		res = bisect_reset(argc ? argv[0] : NULL);
 		break;
-	case CHECK_AND_SET_TERMS:
-		if (argc != 3)
-			die(_("--check-and-set-terms requires 3 arguments"));
-		strbuf_addstr(&terms.term_good, argv[1]);
-		strbuf_addstr(&terms.term_bad, argv[2]);
-		res = check_and_set_terms(&terms, argv[0]);
-		break;
 	case BISECT_NEXT_CHECK:
 		if (argc != 2 && argc != 3)
 			die(_("--bisect-next-check requires 2 or 3 arguments"));

--
https://github.com/git/git/pull/287
