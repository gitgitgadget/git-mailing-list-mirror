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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0BBC432BE
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 05:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1FBB61028
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 05:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhHNFLo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 01:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbhHNFLn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 01:11:43 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2441C061575
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 22:11:15 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q10so16054383wro.2
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 22:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=G8fwbvhywTklp/0IxVKOVxMSS4C7/YD1ErKy2C7HAG8=;
        b=es4H8zryatfHxHUo2ZfFV6cLj5Pp7DCLH/Wbl/3EN4dB7u9Wzqb05JmRKFI/OjD6z+
         6S1mt/kq4W5YKYb2OdvyL7fuO5PIqgofw3SjacZViInEuPkeUEDIqF9WxvWOy0pw5f/k
         sH2omZst/G6B53ePqofty1WRB2J8hDEbXo6gwvC9Ctkv8qbzrG+fVY2b/qi9CNnZ/+a+
         PY2WVImt5qbQ2KYQWoIQspqCsM56mnEGTpGD6r5ElchEaWre09AfhE1UB6mD//SAtHuO
         w4m2f1d8smYBQKVLjaYixafXr15Yqpph0A3QV3An36eX7GV5WtdXSdWjPrfVZvyDO6w9
         BgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=G8fwbvhywTklp/0IxVKOVxMSS4C7/YD1ErKy2C7HAG8=;
        b=WzoF9QtSy0I6SQpUZvX++Ech3jF9aFdnXBftr5pH/IMyxr0htrJ80xzL7JTk3eRVxw
         UoyuVUgCYoYWr3xh1l8S1dDQKC6InyB4du5ket/dZnrePO7aBR88ebcDXJxZ4YwS4Jf0
         H10QxPVzlNk14d0qQvOXdloWOHoxNSXrO+FmsROdF8L6knaMHX0hrBtYkdYI7zLkjNqW
         /E/oGHMw5zfhkjWOAHFSYl/DtRPqegKls8+AFI7FZsx14aEuid9yiio09L/jsvgAZJIh
         mmPkuib8s8aHS8eoZeoRWzHyaDDXSGBh7WPG7Rq1Gsr+eudIgLPm+hGQA/HWgfyQubQV
         CD2A==
X-Gm-Message-State: AOAM532Ymi/EY624ftClU/EQJo0dKHBg4i6WMIUEbXWeUoHHuHuylGmA
        0+EKaTqouZTZzWvAY7Rm7mFnuzCc3bY=
X-Google-Smtp-Source: ABdhPJxU9a68f18113467oFZJcfrtXz35EDySmekFt3zNKb4+xJKrzfbMCR6HYYsgyRTq4xNHHCVlg==
X-Received: by 2002:adf:ebcd:: with SMTP id v13mr5722772wrn.400.1628917874254;
        Fri, 13 Aug 2021 22:11:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b18sm3533543wrr.89.2021.08.13.22.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 22:11:13 -0700 (PDT)
Message-Id: <pull.1012.v2.git.1628917872724.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.git.1628640954160.gitgitgadget@gmail.com>
References: <pull.1012.git.1628640954160.gitgitgadget@gmail.com>
From:   "Azeem Bande-Ali via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 14 Aug 2021 05:11:12 +0000
Subject: [PATCH v2] help.c: help.autocorrect=prompt waits for user action
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     David Barr <b@rr-dav.id.au>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Azeem Bande-Ali <me@azeemba.com>,
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
    
    Changes since v1:
    
     * Use bullet lists for documenting the various settings now supported
       by help.autoCorrect
     * Add a check for an interactive terminal early to bail if the user has
       the "prompt" setting
     * Make the output more compact so the user can see the suggestion and
       the prompt in one line.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1012%2Fazeemba%2Fautoprompt-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1012/azeemba/autoprompt-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1012

Range-diff vs v1:

 1:  7f72819b805 ! 1:  5819b872356 help.c: help.autocorrect=prompt waits for user action
     @@ Documentation/config/help.txt: help.format::
      -	is run immediately. If "never", suggestions are not shown at all. The
      -	default value is zero.
      +	to the error, git will try to suggest the correct command or even
     -+	run the intended command.
     -+	If this config value is 0, then the suggested command will be shown.
     -+	If it is positive, the suggested command will automatically
     -+	run after waiting for that many deciseconds (0.1 sec).
     -+	If it is "immediate", the suggested command will be
     -+	run immediately.
     -+	If it is "prompt", then the user will be shown the
     -+	suggestion and will be prompted for confirmation before the command
     -+	is run.
     -+	If it is "never", then no suggestion will be shown and no command
     -+	will be run.
     -+	0 is the default value for this config.
     ++	run the suggestion automatically. Possible config values are:
     ++	 - 0 (default): show the suggested command.
     ++	 - positive number: run the suggested command after specified
     ++deciseconds (0.1 sec).
     ++	 - "immediate": run the suggested command immediately.
     ++	 - "prompt": show the suggestion and prompt for confirmation to run
     ++the command.
     ++	 - "never": don't run or show any suggested command.
       
       help.htmlPath::
       	Specify the path where the HTML documentation resides. File system paths
     @@ help.c: static int git_unknown_cmd_config(const char *var, const char *value, vo
       			int v = git_config_int(var, value);
       			autocorrect = (v < 0)
      @@ help.c: const char *help_unknown_cmd(const char *cmd)
     + 
     + 	read_early_config(git_unknown_cmd_config, NULL);
     + 
     ++	/*
     ++	 * Disable autocorrection prompt in a non-interactive session
     ++	 */
     ++	if ((autocorrect == AUTOCORRECT_PROMPT) && (!isatty(0) || !isatty(2)))
     ++		autocorrect = AUTOCORRECT_NEVER;
     ++
     + 	if (autocorrect == AUTOCORRECT_NEVER) {
     + 		fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
     + 		exit(1);
     +@@ help.c: const char *help_unknown_cmd(const char *cmd)
       				   _("Continuing under the assumption that "
       				     "you meant '%s'."),
       				   assumed);
      -		else {
      +		else if (autocorrect == AUTOCORRECT_PROMPT) {
     -+			if (!isatty(STDIN_FILENO) | !isatty(STDERR_FILENO))
     -+				exit(1);
     -+
     -+			char *answer;
     -+			fprintf_ln(stderr, _("Assuming you meant: '%s'."),
     -+				   assumed);
     -+			answer = git_prompt(_("Continue? (y/N)"), PROMPT_ECHO);
     ++			char* answer;
     ++			struct strbuf msg = STRBUF_INIT;
     ++			strbuf_addf(&msg, _("Run '%s' instead? (y/N)"),
     ++				    assumed);
     ++			answer = git_prompt(msg.buf, PROMPT_ECHO);
     ++			strbuf_release(&msg);
      +			if (!(starts_with(answer, "y") ||
      +			      starts_with(answer, "Y")))
      +				exit(1);


 Documentation/config/help.txt | 16 +++++++++-------
 help.c                        | 22 +++++++++++++++++++++-
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/help.txt b/Documentation/config/help.txt
index 783a90a0f93..610701f9a37 100644
--- a/Documentation/config/help.txt
+++ b/Documentation/config/help.txt
@@ -9,13 +9,15 @@ help.format::
 
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
+	run the suggestion automatically. Possible config values are:
+	 - 0 (default): show the suggested command.
+	 - positive number: run the suggested command after specified
+deciseconds (0.1 sec).
+	 - "immediate": run the suggested command immediately.
+	 - "prompt": show the suggestion and prompt for confirmation to run
+the command.
+	 - "never": don't run or show any suggested command.
 
 help.htmlPath::
 	Specify the path where the HTML documentation resides. File system paths
diff --git a/help.c b/help.c
index 3c3bdec2135..22bb05e8e3d 100644
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
@@ -539,6 +543,12 @@ const char *help_unknown_cmd(const char *cmd)
 
 	read_early_config(git_unknown_cmd_config, NULL);
 
+	/*
+	 * Disable autocorrection prompt in a non-interactive session
+	 */
+	if ((autocorrect == AUTOCORRECT_PROMPT) && (!isatty(0) || !isatty(2)))
+		autocorrect = AUTOCORRECT_NEVER;
+
 	if (autocorrect == AUTOCORRECT_NEVER) {
 		fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
 		exit(1);
@@ -618,7 +628,17 @@ const char *help_unknown_cmd(const char *cmd)
 				   _("Continuing under the assumption that "
 				     "you meant '%s'."),
 				   assumed);
-		else {
+		else if (autocorrect == AUTOCORRECT_PROMPT) {
+			char* answer;
+			struct strbuf msg = STRBUF_INIT;
+			strbuf_addf(&msg, _("Run '%s' instead? (y/N)"),
+				    assumed);
+			answer = git_prompt(msg.buf, PROMPT_ECHO);
+			strbuf_release(&msg);
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
