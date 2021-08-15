Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F72FC4338F
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 01:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D563C60FF2
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 01:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbhHOBvA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 21:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbhHOBu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 21:50:59 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4DEC061764
        for <git@vger.kernel.org>; Sat, 14 Aug 2021 18:50:30 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 79-20020a1c0452000000b002e6cf79e572so3086522wme.1
        for <git@vger.kernel.org>; Sat, 14 Aug 2021 18:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=afnMfjZHDdw/4yA8zxy4Ssew5UdFLn9aTHn2c6qcr3A=;
        b=P1Vsnd0HyqybqTPqY1tZD5xBssyDrl9MglbUmMZLXRe4DxpSx5PKpc74vKglJ/qa1h
         MFoeEpWr+gzxaS91JOfza29FQLKRvBfLkEaeHMNSASYrDCbiB9cbMxLJ39dByh3L4NYX
         uQ8lgZlr47BV6J3BPbQqOwglz+IDMgFhjy2MgjNn8t51KnDklf+wjSNrNULsPldP9Mr5
         HzK9F58WQiiYA6CmShpjL6C2/xkP6pF6OwktMNnvXfOIT7OrYo98z2INERqYzlXMeicV
         cZsiHcqYFFJWiSciEkiO6R7DgmLgFq0qTDiIU6Sfx23OT4CmiNFHjTzgHqRwhdv+e1r0
         ijew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=afnMfjZHDdw/4yA8zxy4Ssew5UdFLn9aTHn2c6qcr3A=;
        b=Si0gjMrBrCweC35iOJdMlJliTWeqSqhQ7XpcW+SwF4lWTZIPwJjblGEI2dpIyBKaUZ
         /QHzYdU5JhtSAosRXHogXahuZvjQbjvMQUqQ2QFnX487x/9dh+c4YSGySPULQ/iTNHt4
         Kb8T6bXXRGrZgSXUyqQJc8LU8++Djs2MwLNMn26s/KPcGrF7KgqmK3XaJjy4I+4BbHYc
         /lcziGW/i9aoIr20kR6I31cC+XWQ1482QnKxajrwlMzansZYnRMwcY5FFrg0T2BDmsIR
         MUlWQc/gf3MV1JRkzdbyMHWXd6t06JJhf2Xno9X5B2KJOLVXKlV0plJu+rjhNlSdhiOl
         fvrw==
X-Gm-Message-State: AOAM530a9YSq8lwwHJt/sQpLer7VzxfUOD6fYNnlJunaonerWMZKkufn
        wrDDkQOvvtpEt/gtqXJqjwQqs1bk4f0=
X-Google-Smtp-Source: ABdhPJz5i2GtvjMvZBZNkI1jVN6PZ49JFNpoMxUzxUw2RDls7yugdj2XY+cCkQ0aazAzpLBIDSy+7w==
X-Received: by 2002:a1c:9a86:: with SMTP id c128mr9123680wme.65.1628992227858;
        Sat, 14 Aug 2021 18:50:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11sm6386845wrw.67.2021.08.14.18.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 18:50:27 -0700 (PDT)
Message-Id: <pull.1012.v3.git.1628992226139.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.v2.git.1628917872724.gitgitgadget@gmail.com>
References: <pull.1012.v2.git.1628917872724.gitgitgadget@gmail.com>
From:   "Azeem Bande-Ali via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 15 Aug 2021 01:50:26 +0000
Subject: [PATCH v3] help.c: help.autocorrect=prompt waits for user action
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

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Azeem Bande-Ali <me@azeemba.com>
---
    New config for help.autocorrect to prompt user before action
    
    Only minor style changes have been made since v2:
    
     * Moved * to variable name instead of the type name
     * Keep code in the same line for readability

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1012%2Fazeemba%2Fautoprompt-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1012/azeemba/autoprompt-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1012

Range-diff vs v2:

 1:  5819b872356 ! 1:  f3f38f0d141 help.c: help.autocorrect=prompt waits for user action
     @@ Commit message
          Based on original patch by David Barr
          https://lore.kernel.org/git/1283758030-13345-1-git-send-email-david.barr@cordelta.com/
      
     +    Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
          Signed-off-by: Azeem Bande-Ali <me@azeemba.com>
      
       ## Documentation/config/help.txt ##
     @@ help.c: const char *help_unknown_cmd(const char *cmd)
       				   assumed);
      -		else {
      +		else if (autocorrect == AUTOCORRECT_PROMPT) {
     -+			char* answer;
     ++			char *answer;
      +			struct strbuf msg = STRBUF_INIT;
     -+			strbuf_addf(&msg, _("Run '%s' instead? (y/N)"),
     -+				    assumed);
     ++			strbuf_addf(&msg, _("Run '%s' instead? (y/N)"), assumed);
      +			answer = git_prompt(msg.buf, PROMPT_ECHO);
      +			strbuf_release(&msg);
      +			if (!(starts_with(answer, "y") ||


 Documentation/config/help.txt | 16 +++++++++-------
 help.c                        | 21 ++++++++++++++++++++-
 2 files changed, 29 insertions(+), 8 deletions(-)

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
index 3c3bdec2135..be2fa642415 100644
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
@@ -618,7 +628,16 @@ const char *help_unknown_cmd(const char *cmd)
 				   _("Continuing under the assumption that "
 				     "you meant '%s'."),
 				   assumed);
-		else {
+		else if (autocorrect == AUTOCORRECT_PROMPT) {
+			char *answer;
+			struct strbuf msg = STRBUF_INIT;
+			strbuf_addf(&msg, _("Run '%s' instead? (y/N)"), assumed);
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
