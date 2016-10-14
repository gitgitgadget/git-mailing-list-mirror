Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36B341F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 14:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754074AbcJNO25 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 10:28:57 -0400
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:53676
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753007AbcJNO2z (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Oct 2016 10:28:55 -0400
X-Greylist: delayed 876 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Oct 2016 10:28:55 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1476454456;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=bYpXKt+l6a4VEvVvUfcgknEG4+q/h2vGJRcZWm/NxR4=;
        b=Jm1qRgcXYyN/GJQl7zpdwtFFU/5XvHT8dd51JlSGzhrE0lcFNmRGRsHUV4/MLd2v
        YxTkGNulwzEsM/Rh5uGiWb3SzWMqfJGEMjWKeXhCkP+hjJ1ZfSUkdNyWAGT4ioNyV4/
        OM0/8fASTMLkwVFICuHqgF1bFL63wr6ejfynLIV8=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020157c38b1b49-f17ea9d4-32d8-47da-bdcf-833bd7a9093d-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
Subject: [PATCH v15 24/27] bisect--helper: retire `--bisect-write`
 subcommand
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Oct 2016 14:14:16 +0000
X-SES-Outgoing: 2016.10.14-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `--bisect-write` subcommand is no longer used in the shell script
and the function `bisect_write()` is called from the C implementation.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index b367d8d..7f676e2 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -21,7 +21,6 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-reset [<commit>]"),
-	N_("git bisect--helper --bisect-write <state> <revision> <TERM_GOOD> <TERM_BAD> [<nolog>]"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <TERM_GOOD> <TERM_BAD>"),
 	N_("git bisect--helper --bisect-next-check [<term>] <TERM_GOOD> <TERM_BAD"),
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
@@ -990,7 +989,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		BISECT_RESET = 1,
-		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
@@ -1006,8 +1004,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "bisect-write", &cmdmode,
-			 N_("write out the bisection state in BISECT_LOG"), BISECT_WRITE),
 		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
 			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
 		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
@@ -1042,20 +1038,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_bisect_helper_usage, options);
 
 	switch (cmdmode) {
-	int nolog;
 	case BISECT_RESET:
 		if (argc > 1)
 			die(_("--bisect-reset requires either zero or one arguments"));
 		res = bisect_reset(argc ? argv[0] : NULL);
 		break;
-	case BISECT_WRITE:
-		if (argc != 4 && argc != 5)
-			die(_("--bisect-write requires either 4 or 5 arguments"));
-		nolog = (argc == 5) && !strcmp(argv[4], "nolog");
-		terms.term_good = xstrdup(argv[2]);
-		terms.term_bad = xstrdup(argv[3]);
-		res = bisect_write(argv[0], argv[1], &terms, nolog);
-		break;
 	case CHECK_AND_SET_TERMS:
 		if (argc != 3)
 			die(_("--check-and-set-terms requires 3 arguments"));

--
https://github.com/git/git/pull/287
