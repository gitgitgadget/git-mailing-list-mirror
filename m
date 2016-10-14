Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0339E209AB
	for <e@80x24.org>; Fri, 14 Oct 2016 14:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757392AbcJNOOo (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 10:14:44 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:52105
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757317AbcJNOOT (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Oct 2016 10:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1476454456;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=kyfKKKsMbo54MmpGUMIeEnxDv50M/Vn/N6Cj6j0SbBQ=;
        b=KBwd9m1N7Rm9OmjrcUI6BO7VzN4PsAMmWR2QqML8ezoqeQnmctBA+hgx/81oGZp/
        zZcP9+/LCZE9pM6eMoyRFzK65/iBxDcBFHBteWlAUTiOJZECeyZf71SRwJDpj43vC4u
        UdPwtR38HFsoH9v+h10AfGjr3H98GzQyer1qpS2M=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020157c38b1b3c-d866ad23-6405-4571-bc5c-aeb917a49fea-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
Subject: [PATCH v15 20/27] bisect--helper: retire `--check-expected-revs`
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
index 1481c6d..d5fe35b 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -864,7 +864,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	enum {
 		WRITE_TERMS = 1,
 		BISECT_RESET,
-		CHECK_EXPECTED_REVS,
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
@@ -881,8 +880,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
-			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-write", &cmdmode,
 			 N_("write out the bisection state in BISECT_LOG"), BISECT_WRITE),
 		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
@@ -926,9 +923,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
