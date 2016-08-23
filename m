Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 331A7206FB
	for <e@80x24.org>; Tue, 23 Aug 2016 12:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932887AbcHWMBU (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 08:01:20 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:37738
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932882AbcHWMBS (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Aug 2016 08:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1471953233;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=IoD37YGvxYr0POMgr9srXzcatZ6jGq3hIhRndQ/bIvw=;
        b=dZxV/g8cxL4RTk4XRE539+tLFzYPFKhLEe8vNmTMwX+BVus4cS2pWXC2Vqn7ssiv
        voZKD/gJq/5/b5DGzx8gcIgmM4HdLN6/MbEYdwlX5GJBG/suoPyYrpt+B67stm5tZLV
        CUtUT8MoVrnnvaMgWhgCcmyFjaNKoj2An5vL30wc=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020156b73fe6d0-0e2c0b03-999c-4ce9-9432-8cf1a6858c48-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
Subject: [PATCH v14 19/27] bisect--helper: retire `--check-expected-revs`
 subcommand
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 23 Aug 2016 11:53:53 +0000
X-SES-Outgoing: 2016.08.23-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `--check-expected-revs` subcommand is no longer used in the shell
script and the function `check_expected_revs()` is called from the C
implementation of `bisect_next()`.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 861c07d..6cc990b 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -870,7 +870,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	enum {
 		WRITE_TERMS = 1,
 		BISECT_RESET,
-		CHECK_EXPECTED_REVS,
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
@@ -887,8 +886,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
-			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-write", &cmdmode,
 			 N_("write out the bisection state in BISECT_LOG"), BISECT_WRITE),
 		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
@@ -933,9 +930,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			die(_("--bisect-reset requires either zero or one arguments"));
 		res = bisect_reset(argc ? argv[0] : NULL);
 		break;
-	case CHECK_EXPECTED_REVS:
-		res = check_expected_revs(argv, argc);
-		break;
 	case BISECT_WRITE:
 		if (argc != 4 && argc != 5)
 			die(_("--bisect-write requires either 4 or 5 arguments"));

--
https://github.com/git/git/pull/287
