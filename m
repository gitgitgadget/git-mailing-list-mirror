Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EABEF2018E
	for <e@80x24.org>; Tue, 23 Aug 2016 12:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757982AbcHWL7J (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 07:59:09 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:51307
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757089AbcHWL6W (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Aug 2016 07:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1471953233;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=BddoTjXYz+GmF/HIWyPwIP2Y5zEeVyYnEwq42fhQCvg=;
        b=AzfKSsNsL40fECk36MVVVu1a/R22r+B3Y2go6aYvK1h3zvHYQFnjL0jKwn8pYJDp
        gfsSmJRBagTI+YnW+f/3RbFPCRo7nAahom2Ko4zmOPCt504s2h84QJJg8DtcyFHFzXz
        gBMe/6RsilYKZtXK8/zEg70HQ0onYW5e7l4+8FDk=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020156b73fe6d2-1815fb4e-50a2-4176-900e-9f22c5bfb9ec-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
Subject: [PATCH v14 20/27] bisect--helper: retire `--write-terms` subcommand
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 23 Aug 2016 11:53:53 +0000
X-SES-Outgoing: 2016.08.23-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `--write-terms` subcommand is no longer used in the shell script and
the function `write_terms()` is called from the C implementation of
`set_terms()` and `bisect_start()`.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 6cc990b..1b6e5d8 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -20,7 +20,6 @@ static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 
 static const char * const git_bisect_helper_usage[] = {
-	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write <state> <revision> <TERM_GOOD> <TERM_BAD> [<nolog>]"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <TERM_GOOD> <TERM_BAD>"),
@@ -868,8 +867,7 @@ static int bisect_state(struct bisect_terms *terms, const char **argv,
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
-		WRITE_TERMS = 1,
-		BISECT_RESET,
+		BISECT_RESET = 1,
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
@@ -882,8 +880,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0;
 	struct option options[] = {
-		OPT_CMDMODE(0, "write-terms", &cmdmode,
-			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_CMDMODE(0, "bisect-write", &cmdmode,
@@ -920,11 +916,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 
 	switch (cmdmode) {
 	int nolog;
-	case WRITE_TERMS:
-		if (argc != 2)
-			die(_("--write-terms requires two arguments"));
-		res = write_terms(argv[0], argv[1]);
-		break;
 	case BISECT_RESET:
 		if (argc > 1)
 			die(_("--bisect-reset requires either zero or one arguments"));

--
https://github.com/git/git/pull/287
