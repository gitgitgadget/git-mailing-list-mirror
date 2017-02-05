Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3FBD1FAF4
	for <e@80x24.org>; Sun,  5 Feb 2017 12:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbdBEM6C (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 07:58:02 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36182 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbdBEM6A (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 07:58:00 -0500
Received: by mail-pg0-f66.google.com with SMTP id 75so6506105pgf.3
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 04:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oaw1l96qeBwD0Kwap18wm1TzLDrV0joCn43nTkRZdc0=;
        b=RaS0U6wBkTHEehc+1gAilndvR8v0uNLQUUZyZrBPtD2yBohrlHLUh/TTAQJXT8wQz8
         4pbiA6KWemVSG7yy4lwHF6H2W9VdVV8BUXu+d0U8BIx6yDa9Fs71jO5anx5KDNkZXLRA
         sf0+lMD+wogOvLW0OqXQfF1ZV/vH6QFuerSFkgP5+w92gv1x96dWlHi3v4uKsGs5iS5A
         lw0GTgMq43v4KZpqJ5zbZ+rct2UHNTWPIZIdXk3C3aFdUe78OtZxaeQDpxds6t4VhPn5
         8jThi9lrjYpVngZ6thg5fzO1LBwF4r0TzbZ15j2pji9rdXOWUqPSOM/0DbbAk6ePUkDt
         0KJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oaw1l96qeBwD0Kwap18wm1TzLDrV0joCn43nTkRZdc0=;
        b=CQO8BUz6zBpblewKqPqdfwkrLbfuQdXMdyCCDlowl6C8uiKSY4j3WCiCrCoXvuZMNG
         6Q+afvLrpYkpTKp/hpd8xnIeMDAwkcwGwpFBvZHorE6Gm4plvYhsUuc090zPj6Kp4a/6
         k8W0nafvxkxEBWhpL+R/YG7qqCzhKV2Juh8gmu2hefL5xkInpstb1DsmGt1ArJZicMj+
         1wr09IC0NjOsPocssD87Agdfq4nlGXjRiTQhjBSQhjlNmdm4YL4Xo1m8n5nGsLItEds0
         EsQe+2x6VsENgZwhKod8++GMsreXryXc1lUTbVUY1uReW8CJVLRx9oXRYli6/WP1aSnq
         ZYJA==
X-Gm-Message-State: AIkVDXJZ52b88CdIfDFXN5aIpOXERrBLYMdlh5had2tGlGN6pu3WU6lMLCq3D7bEcmm/Ww==
X-Received: by 10.98.192.72 with SMTP id x69mr7656826pff.129.1486299479692;
        Sun, 05 Feb 2017 04:57:59 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id 75sm81219701pfp.80.2017.02.05.04.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Feb 2017 04:57:58 -0800 (PST)
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     git@vger.kernel.org
Cc:     pranit.bauva@gmail.com, Matthieu.Moy@imag.fr, peff@peff.net,
        gitster@pobox.com, pclouds@gmail.com,
        sandals@crustytoothpaste.ath.cx,
        Siddharth Kannan <kannan.siddharth12@gmail.com>
Subject: [PATCH/RFC] WIP: log: allow "-" as a short-hand for "previous branch"
Date:   Sun,  5 Feb 2017 12:57:19 +0000
Message-Id: <1486299439-2859-1-git-send-email-kannan.siddharth12@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Search and replace "-" (written in the context of a branch name) in the argument
list with "@{-1}". As per the help text of git rev-list, this includes the following four
cases:

  a. "-"
  b. "^-"
  c. "-..other-branch-name" or "other-branch-name..-"
  d. "-...other-branch-name" or "other-branch-name...-"

(a) and (b) have been implemented as in the previous implementations of
this abbreviation. Namely, 696acf45 (checkout: implement "-" abbreviation, add
docs and tests, 2009-01-17), 182d7dc4 (cherry-pick: allow "-" as
abbreviation of '@{-1}', 2013-09-05) and 4e8115ff (merge: allow "-" as a
short-hand for "previous branch", 2011-04-07)

(c) and (d) have been implemented by using the strbuf API, growing it to the
right size and placing "@{-1}" instead of "-"

Signed-off-by: Siddharth Kannan <kannan.siddharth12@gmail.com>
---
This is a patch for one of the microprojects of SoC 2017. [1]

I have implemented this using multiple methods, that I have re-written again and
again for better versions ([2]). The present version I feel is the closest that
I could get to the existing code in the repository. This patch only uses
functions that are commonly used in the rest of the codebase.

I still have to write tests, as well as update documentation as done in 696acf45
(checkout: implement "-" abbreviation, add docs and tests, 2009-01-17).

I request your comments on this patch. Also, I have the following questions
regarding this patch:

1. Is the approach that I have used to solve this problem fine?
2. Is the code I am writing in the right function? (I have put it right
before the revisions data structure is setup, thus these changes affect only
git-log)

[1]: https://git.github.io/SoC-2017-Microprojects/
[2]: https://github.com/git/git/compare/6e3a7b3...icyflame:7e286c9.patch (Uses
strbufs for the starting 4 characters, and last 4 characters and compares those
to the appropriate strings for case (c) and case (d). I edited this patch to use
strstr instead, which avoids all the strbuf declarations)

 builtin/log.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 55d20cc..a5aac99 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -132,7 +132,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			 struct rev_info *rev, struct setup_revision_opt *opt)
 {
 	struct userformat_want w;
-	int quiet = 0, source = 0, mailmap = 0;
+	int quiet = 0, source = 0, mailmap = 0, i = 0;
 	static struct line_opt_callback_data line_cb = {NULL, NULL, STRING_LIST_INIT_DUP};

 	const struct option builtin_log_options[] = {
@@ -158,6 +158,51 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,

 	if (quiet)
 		rev->diffopt.output_format |= DIFF_FORMAT_NO_OUTPUT;
+
+	/*
+	 * Check if any argument has a "-" in it, which has been referred to as a
+	 * shorthand for @{-1}.  Handles methods that might be used to list commits
+	 * as mentioned in git rev-list --help
+	 */
+
+	for(i = 0; i < argc; ++i) {
+		if (!strcmp(argv[i], "-")) {
+			argv[i] = "@{-1}";
+		} else if (!strcmp(argv[i], "^-")) {
+			argv[i] = "^@{-1}";
+		} else if (strlen(argv[i]) >= 4) {
+
+			if (strstr(argv[i], "-...") == argv[i] || strstr(argv[i], "-..") == argv[i]) {
+				struct strbuf changed_argument = STRBUF_INIT;
+
+				strbuf_addstr(&changed_argument, "@{-1}");
+				strbuf_addstr(&changed_argument, argv[i] + 1);
+
+				strbuf_setlen(&changed_argument, strlen(argv[i]) + 4);
+
+				argv[i] = strbuf_detach(&changed_argument, NULL);
+			}
+
+			/*
+			 * Find the first occurence, and add the size to it and proceed if
+			 * the resulting value is NULL
+			 */
+			if (!(strstr(argv[i], "...-") + 4)  ||
+					!(strstr(argv[i], "..-") + 3)) {
+				struct strbuf changed_argument = STRBUF_INIT;
+
+				strbuf_addstr(&changed_argument, argv[i]);
+
+				strbuf_grow(&changed_argument, strlen(argv[i]) + 4);
+				strbuf_setlen(&changed_argument, strlen(argv[i]) + 4);
+
+				strbuf_splice(&changed_argument, strlen(argv[i]) - 1, 5, "@{-1}", 5);
+
+				argv[i] = strbuf_detach(&changed_argument, NULL);
+			}
+		}
+	}
+
 	argc = setup_revisions(argc, argv, rev, opt);

 	/* Any arguments at this point are not recognized */
--
2.1.4

