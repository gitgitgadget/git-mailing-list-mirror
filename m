Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 072E61F6C1
	for <e@80x24.org>; Tue, 23 Aug 2016 12:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757970AbcHWL7J (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 07:59:09 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:56028
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757159AbcHWL6W (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Aug 2016 07:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1471953233;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=ZkxxpfKkXW1njVu7XCgRAs6rU1ODErdOATIvY3d6MWI=;
        b=ciXLHkc8pemqRDVMiuNj1ev2EyroffFYT4ddHfSDDudFXZzOl73tOdUPmXGMYxOj
        DpwDLAKbaWC/B26r88SDlpaoye3IacXiDkSpLrmC6+rVpJhMXx1oYcgQfBI2DXFItfU
        mXZv+zKpGK70N3hepis4MYXPw90PjzWTnjwBJd/c=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020156b73fe6d8-0e494417-0873-4f57-894b-fece73e21124-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
Subject: [PATCH v14 23/27] bisect--helper: retire `--bisect-write`
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

The `--bisect-write` subcommand is no longer used in the shell script
and the function `bisect_write()` is called from the C implementation.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 9c1108d..4ab6488 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -21,7 +21,6 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-reset [<commit>]"),
-	N_("git bisect--helper --bisect-write <state> <revision> <TERM_GOOD> <TERM_BAD> [<nolog>]"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <TERM_GOOD> <TERM_BAD>"),
 	N_("git bisect--helper --bisect-next-check [<term>] <TERM_GOOD> <TERM_BAD"),
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
@@ -971,7 +970,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		BISECT_RESET = 1,
-		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
@@ -987,8 +985,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "bisect-write", &cmdmode,
-			 N_("write out the bisection state in BISECT_LOG"), BISECT_WRITE),
 		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
 			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
 		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
@@ -1024,20 +1020,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
-		strbuf_addstr(&terms.term_good, argv[2]);
-		strbuf_addstr(&terms.term_bad, argv[3]);
-		res = bisect_write(argv[0], argv[1], &terms, nolog);
-		break;
 	case CHECK_AND_SET_TERMS:
 		if (argc != 3)
 			die(_("--check-and-set-terms requires 3 arguments"));

--
https://github.com/git/git/pull/287
