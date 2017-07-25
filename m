Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79A941F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 14:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752402AbdGYOjW (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 10:39:22 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:46448
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752297AbdGYOjV (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 25 Jul 2017 10:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1500993560;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=Kl5thVxUVpa876tTvN7tUbbB082McI7mt81AFoOTFC4=;
        b=jodHXn3wI5K6Ql+OxCNhJ0GXbMgA+zF6hIH6F48aHDUL4YpxjPOdL255GZfw6KD3
        zQdeW8Vgl+CDARaRySw8ERVXWQSV06PmEu7TgqusG0nw+0i7zsLrNYqnoqwWY6L3oFo
        NmDRMp0PZymyj154BCSG/mRiJXaHFeQl+DKek7eI=
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015d7a301def-0d802f3e-6052-4e32-b331-c42c3160012b-000000@eu-west-1.amazonses.com>
Subject: [PATCH] branch: change the error messages to be more meaningful
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 25 Jul 2017 14:39:20 +0000
X-SES-Outgoing: 2017.07.25-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The error messages shown when the branch command is misused
by supplying it wrong number of parameters wasn't meaningful
as it used the the phrase, "too many branches" which is not
meaningful in the following case,

        $ git branch
          foo
        * master

        $ git branch -m foo foo test
        fatal: too many branches for a rename operation

It's not meaningful as the implementation assumed all parameters
to be branch names. It's not always the case as exemplified above.

Change the messages to be more general thus making no asssumptions
about the "parameters".

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 builtin/branch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index a3bd2262b3367..59fedf085d3db 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -707,12 +707,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		else if (argc == 2)
 			rename_branch(argv[0], argv[1], rename > 1);
 		else
-			die(_("too many branches for a rename operation"));
+			die(_("too many parameters for a rename operation"));
 	} else if (new_upstream) {
 		struct branch *branch = branch_get(argv[0]);
 
 		if (argc > 1)
-			die(_("too many branches to set new upstream"));
+			die(_("too many parameters to set new upstream"));
 
 		if (!branch) {
 			if (!argc || !strcmp(argv[0], "HEAD"))
@@ -735,7 +735,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		struct strbuf buf = STRBUF_INIT;
 
 		if (argc > 1)
-			die(_("too many branches to unset upstream"));
+			die(_("too many parameters to unset upstream"));
 
 		if (!branch) {
 			if (!argc || !strcmp(argv[0], "HEAD"))

--
https://github.com/git/git/pull/387
