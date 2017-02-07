Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D4691FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 20:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754249AbdBGUvm (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 15:51:42 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36273 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753259AbdBGUvl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 15:51:41 -0500
Received: by mail-pf0-f193.google.com with SMTP id 19so9992036pfo.3
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 12:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=31CIupBR1evVjWCyLS4LzisswZJQoIFX677v7yuJYmE=;
        b=ilaMxDfcdhQZ8noKBYtgCW5SOv2LjzleXo+XVZDQ23AoZamUbTERtiwugODtVODPYC
         BAA7ZTUN8mhNRBOqsbu506NIm1A64LD8voGUCai2cfA3WHg+Q6gOgcPenPHbOItEqLQA
         l8r7M/ZQ2D5iFDH5hxiOm6NY/7SNSRv0si4fkvV0reqIhSqrArqhWE4L/q0gxgVvyYvr
         uwMgPGFEyfyVhW3hQFI7YAO8x4B94WwBSA+3gc1Ll99+W+5aWBJI2GaWoheDJaDLuH3F
         z/WXS9lKQNRY08Dn1LG48/7V010SM8EQlgxaHMjoJO7z5fF4YPLFnL41aCt/b+ArVmhV
         Jo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=31CIupBR1evVjWCyLS4LzisswZJQoIFX677v7yuJYmE=;
        b=t1r9KYRW5p/LnjoK5x8zvaBb6nyheP7s5ZbgVg92ZKHWvg5lVbT+pdOSLCZWWFZtd2
         lw2Sk/xKgRmRojyW6ja7Arg/5gbB9Ib7Z5gwv2e4FPLwXiIctRmoSd7lDo6JAvp2E3eG
         KAV9Pct5L9wT7/jMgImGU34757+aRxcao4ICs1nnH/mB+E2ytgrkHCIqZ21kbrCEZYr2
         pAymHA7vrbVqG4BmiAyir2BPxAIvoWod04ZNfakewtSTkcFPOapCP6kr0GPPi++EZcf6
         nBtwMkdzdTTMcPDUjKZbxjyDYZAdHKDs71XwSg5kcFeeUgsa25/3epnMXmnuPqptZ314
         1Czw==
X-Gm-Message-State: AIkVDXIUM6mmFavMF1506gKaF9lnJHFfiJmGwnDEInY+yyh4jIZgw9qax5aOH5exUxMe/g==
X-Received: by 10.98.159.80 with SMTP id g77mr21874315pfe.34.1486500701072;
        Tue, 07 Feb 2017 12:51:41 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id j185sm13753463pgd.35.2017.02.07.12.51.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 12:51:39 -0800 (PST)
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pranit.bauva@gmail.com, Matthieu.Moy@imag.fr,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx,
        Siddharth Kannan <kannan.siddharth12@gmail.com>
Subject: [PATCH/RFC v2] WIP: log: allow "-" as a short-hand for "previous branch"
Date:   Tue,  7 Feb 2017 20:51:26 +0000
Message-Id: <1486500686-6623-1-git-send-email-kannan.siddharth12@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach revision.c:setup_revisions that an argument starting with "-" can be an
argument also. `left` variable needs to be incremented only when the supplied
arg is neither an argument, nor an option.

Teach sha1_name.c:get_sha1_1 that "-" is equivalent to "@{-1}"

Signed-off-by: Siddharth Kannan <kannan.siddharth12@gmail.com>
---
I have run the test suite locally and on Travis CI. [1]

Whenever the argument begins with a "-" then the function "handle_revision_arg" 
is called twice. I can fix this using a variable that would store whether the
function has been called earlier or not. For doing that I have to investigate
some more on what the valid return values for "handle_revision_arg" are. (Or
a simpler approach would be to use an integer flag, this would also not be
affected if in case "handle_revision_arg" is changed in the future)

I have also written a very basic test for git-log only. I have based this on the
tests that were added in 696acf4 (checkout: implement "-" abbreviation, add docs
and tests, 2009-01-17). It tests revisions, revision ranges, and open-ended
revision ranges (where the start or the finish argument is inferred) If the
code in this patch is okay, or close to okay, then please tell me if further
tests need to be added for git-log and/or other commands.

This change touches a few commands, other than log. notably, git-format-patch,
git-whatchanged and git-show, all of which are defined inside builtin/log.c. In
general, it affects commands that call setup_revisions at some point in their
codepath. (eg: git-diff-index)

Thanks a lot, Junio, for your comments on the previous version of this patch and
further discussion on that thread!

[1]: https://travis-ci.org/icyflame/git/builds/199350136

 revision.c               |  9 +++++--
 sha1_name.c              |  5 ++++
 t/t4214-log-shorthand.sh | 62 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 2 deletions(-)
 create mode 100755 t/t4214-log-shorthand.sh

diff --git a/revision.c b/revision.c
index b37dbec..e14f62c 100644
--- a/revision.c
+++ b/revision.c
@@ -2206,7 +2206,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	for (left = i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (*arg == '-') {
-			int opts;
+			int opts, args;
 
 			opts = handle_revision_pseudo_opt(submodule,
 						revs, argc - i, argv + i,
@@ -2234,7 +2234,12 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			}
 			if (opts < 0)
 				exit(128);
-			continue;
+
+			args = handle_revision_arg(arg, revs, flags, revarg_opt);
+			if (args)
+				continue;
+			else
+				--left;
 		}
 
 
diff --git a/sha1_name.c b/sha1_name.c
index 73a915f..d774e46 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -947,6 +947,11 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned l
 	if (!ret)
 		return 0;
 
+	if (!strcmp(name, "-")) {
+		name = "@{-1}";
+		len = 5;
+	}
+
 	ret = get_sha1_basic(name, len, sha1, lookup_flags);
 	if (!ret)
 		return 0;
diff --git a/t/t4214-log-shorthand.sh b/t/t4214-log-shorthand.sh
new file mode 100755
index 0000000..95cf2d4
--- /dev/null
+++ b/t/t4214-log-shorthand.sh
@@ -0,0 +1,62 @@
+#!/bin/sh
+
+test_description='log can show previous branch using shorthand - for @{-1}'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo hello >world &&
+	git add world &&
+	git commit -m initial &&
+	echo "hello second time" >>world &&
+	git add world &&
+	git commit -m second &&
+	echo "hello other file" >>planet &&
+	git add planet &&
+	git commit -m third &&
+	echo "hello yet another file" >>city &&
+	git add city &&
+	git commit -m fourth
+'
+
+test_expect_success '"log -" should not work initially' '
+	test_must_fail git log -
+'
+
+test_expect_success '"log -" should work' '
+	git checkout -b testing-1 master^ &&
+	git checkout -b testing-2 master~2 &&
+	git checkout master &&
+
+	git log testing-2 >expect &&
+	git log - >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'revision range should work when one end is left empty' '
+	git checkout testing-2 &&
+	git checkout master &&
+	git log ...@{-1} > expect.first_empty &&
+	git log @{-1}... > expect.last_empty &&
+	git log ...- > actual.first_empty &&
+	git log -... > actual.last_empty &&
+	test_cmp expect.first_empty actual.first_empty &&
+	test_cmp expect.last_empty actual.last_empty
+'
+
+test_expect_success 'symmetric revision range should work when both ends are given' '
+	git checkout testing-2 &&
+	git checkout master &&
+	git log -...testing-1 >expect &&
+	git log testing-2...testing-1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'asymmetric revision range should work when both ends are given' '
+	git checkout testing-2 &&
+	git checkout master &&
+	git log -..testing-1 >expect &&
+	git log testing-2..testing-1 >actual &&
+	test_cmp expect actual
+'
+test_done
-- 
2.1.4

