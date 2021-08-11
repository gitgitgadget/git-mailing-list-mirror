Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850D0C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 00:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56E6160F25
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 00:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbhHKAQU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 20:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbhHKAQT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 20:16:19 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F80C061765
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 17:15:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o1-20020a05600c5101b02902e676fe1f04so2720798wms.1
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 17:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Ch1SuKGoXvGKQZSFDqm9/Ya1aTQV9O4M/mo1Mzz5v9M=;
        b=n/HrLIdE+I4zzlkFAn1k0F0iFnwJhxx6G8A7aCifH44Gc9Wiyj97bK2VnuW5ZN3Rlz
         UaJwFfAMBC47WQGN6ir/wy4XRBv727PhmYeibM4d6sXPGQ4jdFAGrsQ5/q9bCOtbq0yg
         6T2pDHNf8AvCxnNxqI3zK2JR7Q2gihLlzRiEYFmjW/ZQ9QWvQVoin8cjc/6hPYhZlyf8
         tGkUFdsOuWjXsbAXPXovMswtM0gq6tQ2UM4ttTsSEZCqZSH1migoGkbYqUYWQ8ElCng0
         ht5Nobvsf4RjQgVT8oR1+BLIO7K25i9J3F51mI3LHhoKHxtoeQU8CSNL86I19DotDjwP
         j3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ch1SuKGoXvGKQZSFDqm9/Ya1aTQV9O4M/mo1Mzz5v9M=;
        b=NnK8BN8RZt2qpUqt7cSNZoVLMZAewScZfXhchBkkbor1CtalRI/TaL80cFi/KXWn9f
         xX54DD+A8618FAT3XLRNOcqCoUb0bZNad00LEklTwoNMveHy4CRzxJs3OeeN9yRsN4M0
         D+3bGltrNcHE69fZnBvAQVSQlBOCr8rrbNj+Glg6/G7HZOvwIemCf7mVbPnJLS/5UQRP
         w4LBp2b9BasrBtSrhOrrXMRwZL4ayIJCvVuxJ0cYhtzeR5WJ9sBwej2Y+riNZ5q8/TSa
         q5qfK0lL3hhQxBtsg7wa8t4VgZbc70nB72XwKKM5CfkGWuWgO69nhS6rfaMk6lU9waDY
         7jqA==
X-Gm-Message-State: AOAM531/tcLbP9PIGjiqsxsR9svQ2mr94FRDuDjWFhGi18xIfFrlHzON
        qeK2EQztHBUTkHmsgsNbhDQ+bCPneC4=
X-Google-Smtp-Source: ABdhPJy/qQsqTPN7Z+OjnJswpHRiKQBgb6+zKuKJsMafw7w1BdavJiw2jVeFPkCp+ql/PgYBQkBogg==
X-Received: by 2002:a1c:4c02:: with SMTP id z2mr13313080wmf.62.1628640955379;
        Tue, 10 Aug 2021 17:15:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4sm22220032wmi.22.2021.08.10.17.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 17:15:54 -0700 (PDT)
Message-Id: <pull.1012.git.1628640954160.gitgitgadget@gmail.com>
From:   "Azeem Bande-Ali via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Aug 2021 00:15:53 +0000
Subject: [PATCH] help.c: help.autocorrect=prompt waits for user action
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     David Barr <b@rr-dav.id.au>,
        Azeem Bande-Ali <A.BandeAli@gmail.com>,
        Azeem Bande-Ali <me@azeemba.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Azeem Bande-Ali <me@azeemba.com>

If help.autocorrect is set to 'prompt', the user is prompted
before the suggested action is executed.

Based on original patch by David Barr
https://lore.kernel.org/git/1283758030-13345-1-git-send-email-david.barr@cordelta.com/

Signed-off-by: Azeem Bande-Ali <me@azeemba.com>
---
    New config for help.autocorrect to prompt user before action
    
    Currently the prompt setting will wait X amount of time before taking an
    action. Adding a new config that will instead prompt the user for a
    confirmation before taking the action.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1012%2Fazeemba%2Fautoprompt-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1012/azeemba/autoprompt-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1012

 Documentation/config/help.txt | 20 +++++++++++++-------
 help.c                        | 17 ++++++++++++++++-
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/help.txt b/Documentation/config/help.txt
index 783a90a0f93..d36d98dd119 100644
--- a/Documentation/config/help.txt
+++ b/Documentation/config/help.txt
@@ -9,13 +9,19 @@ help.format::
 
 help.autoCorrect::
 	If git detects typos and can identify exactly one valid command similar
-	to the error, git will automatically run the intended command after
-	waiting a duration of time defined by this configuration value in
-	deciseconds (0.1 sec).  If this value is 0, the suggested corrections
-	will be shown, but not executed. If it is a negative integer, or
-	"immediate", the suggested command
-	is run immediately. If "never", suggestions are not shown at all. The
-	default value is zero.
+	to the error, git will try to suggest the correct command or even
+	run the intended command.
+	If this config value is 0, then the suggested command will be shown.
+	If it is positive, the suggested command will automatically
+	run after waiting for that many deciseconds (0.1 sec).
+	If it is "immediate", the suggested command will be
+	run immediately.
+	If it is "prompt", then the user will be shown the
+	suggestion and will be prompted for confirmation before the command
+	is run.
+	If it is "never", then no suggestion will be shown and no command
+	will be run.
+	0 is the default value for this config.
 
 help.htmlPath::
 	Specify the path where the HTML documentation resides. File system paths
diff --git a/help.c b/help.c
index 3c3bdec2135..079156e0421 100644
--- a/help.c
+++ b/help.c
@@ -11,6 +11,7 @@
 #include "version.h"
 #include "refs.h"
 #include "parse-options.h"
+#include "prompt.h"
 
 struct category_description {
 	uint32_t category;
@@ -472,6 +473,7 @@ int is_in_cmdlist(struct cmdnames *c, const char *s)
 static int autocorrect;
 static struct cmdnames aliases;
 
+#define AUTOCORRECT_PROMPT (-3)
 #define AUTOCORRECT_NEVER (-2)
 #define AUTOCORRECT_IMMEDIATELY (-1)
 
@@ -486,6 +488,8 @@ static int git_unknown_cmd_config(const char *var, const char *value, void *cb)
 			autocorrect = AUTOCORRECT_NEVER;
 		} else if (!strcmp(value, "immediate")) {
 			autocorrect = AUTOCORRECT_IMMEDIATELY;
+		} else if (!strcmp(value, "prompt")) {
+			autocorrect = AUTOCORRECT_PROMPT;
 		} else {
 			int v = git_config_int(var, value);
 			autocorrect = (v < 0)
@@ -618,7 +622,18 @@ const char *help_unknown_cmd(const char *cmd)
 				   _("Continuing under the assumption that "
 				     "you meant '%s'."),
 				   assumed);
-		else {
+		else if (autocorrect == AUTOCORRECT_PROMPT) {
+			if (!isatty(STDIN_FILENO) | !isatty(STDERR_FILENO))
+				exit(1);
+
+			char *answer;
+			fprintf_ln(stderr, _("Assuming you meant: '%s'."),
+				   assumed);
+			answer = git_prompt(_("Continue? (y/N)"), PROMPT_ECHO);
+			if (!(starts_with(answer, "y") ||
+			      starts_with(answer, "Y")))
+				exit(1);
+		} else {
 			fprintf_ln(stderr,
 				   _("Continuing in %0.1f seconds, "
 				     "assuming that you meant '%s'."),

base-commit: 2d755dfac9aadab25c3e025b849252b8c0a61465
-- 
gitgitgadget
