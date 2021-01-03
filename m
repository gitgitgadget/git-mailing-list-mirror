Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0EAC433E0
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 17:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12D822078D
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 17:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbhACRnA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 12:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbhACRm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 12:42:59 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1AAC061573
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 09:42:19 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d13so28599948wrc.13
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 09:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MhfRjm/dzcrVVFNawVHqAVBy63CQ/cBupVKfCZl9Vw4=;
        b=J5VS1yIgRG+YSThSgxP39/rKMjpw8x6646YMX0XZQVlouAFyP/nDOVe+otv65eo9iv
         2xiZn0XPziavcW1KVbynevdilLQHQcGXvgshtLn2J75QDxsrieKwhb2DejBih3+ntg/r
         ovtTy05M/2Kwe871iSzA/MDSamonHGMT3u97sZJd9C38QjKJl0rzS/gD7/Xj7jYPWxb9
         NOP7AM1W+0T8vp1rOdjum19hsGgbI5qZ0n+7sKq0lIqskSq4MRefMpvBLSvvrO+qAVe8
         BHmCqXQXkd4zT2w+UB0fSPExJTa78Wwv0YLEoqNiO6ovzVEp7Hv6NdK7GBN/3lr7S4FB
         gNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MhfRjm/dzcrVVFNawVHqAVBy63CQ/cBupVKfCZl9Vw4=;
        b=eC27437la0se97wdsT3GQ4rC6e61s3T4SHtYktPO4eERejO00MuH6m+GKNQct9S2Xp
         3uABeLd9LDhlCnJUe21/8y8fIWmHcUuoztffsDu6Nrv6TtoJEobzANyWt6Go81uAngs3
         ZXWZuoU/klBRk9KEue0C1msUmvSGdI5d0VkxH1L/WuW0/wyppj4PiiTQ0ehn2YU+obwS
         uTWxdvEpd2VWDfqARNHvbqtXr3b4rh+7VTZFLhKHNqbdDDUyqOeeNk7FmK5Ovx9tzyfK
         uwO/VNNq+jhUrzebUkuPtkk9DkiqyR2MNi7k6GiKecGxFdTs5t75LXC4m0JslRsMfUsh
         3P6Q==
X-Gm-Message-State: AOAM532+Ibo0xz7bUgPlexNI9QyeLOyk0YZp7IsLDqVlW48vPuRlqrRu
        i9OZSHrwdThqyxd9FLkvDvwHfh9yLCU=
X-Google-Smtp-Source: ABdhPJx17i2/guZr2eYXN/cvFTYKUQFHlWtLloRHaHqGb3mhn8nRnXH1ImVmZYu8fUBMZkSK/+JwAw==
X-Received: by 2002:adf:ba49:: with SMTP id t9mr77408708wrg.183.1609695737601;
        Sun, 03 Jan 2021 09:42:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q1sm84498665wrj.8.2021.01.03.09.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 09:42:16 -0800 (PST)
Message-Id: <pull.942.v2.git.git.1609695736001.gitgitgadget@gmail.com>
In-Reply-To: <pull.942.git.git.1609616245412.gitgitgadget@gmail.com>
References: <pull.942.git.git.1609616245412.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 03 Jan 2021 17:42:15 +0000
Subject: [PATCH v2] gitmodules.txt: fix 'GIT_WORK_TREE' variable name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Gustaf Hendeby <hendeby@isy.liu.se>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

'gitmodules.txt' is a guide about the '.gitmodules' file that describes
submodule properties, and that file must exist at the root of the
repository. This was clarified in e5b5c1d2cf (Document clarification:
gitmodules, gitattributes, 2008-08-31).

However, that commit mistakenly uses the non-existing environment
variable 'GIT_WORK_DIR' to refer to the root of the repository.

Fix that by using the correct variable, 'GIT_WORK_TREE'. Take the
opportunity to modernize and improve the formatting of that guide,
and fix a grammar mistake.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    gitmodules.txt: fix 'GIT_WORK_TREE' variable name
    
    Changes since v1:
    
     * added Martin's suggestions

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-942%2Fphil-blain%2Fdoc-gitmodules-envvar-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-942/phil-blain/doc-gitmodules-envvar-v2
Pull-Request: https://github.com/git/git/pull/942

Range-diff vs v1:

 1:  8fa2238f4a0 ! 1:  4fca37ea043 gitmodules.txt: fix 'GIT_WORK_TREE' variable name
     @@ Commit message
          gitmodules.txt: fix 'GIT_WORK_TREE' variable name
      
          'gitmodules.txt' is a guide about the '.gitmodules' file that describes
     -    submodules properties, and that file must exist at the root of the
     +    submodule properties, and that file must exist at the root of the
          repository. This was clarified in e5b5c1d2cf (Document clarification:
          gitmodules, gitattributes, 2008-08-31).
      
     @@ Commit message
          variable 'GIT_WORK_DIR' to refer to the root of the repository.
      
          Fix that by using the correct variable, 'GIT_WORK_TREE'. Take the
     -    opportunity to modernize and improve the formatting of that guide.
     +    opportunity to modernize and improve the formatting of that guide,
     +    and fix a grammar mistake.
      
          Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
      
     @@ Documentation/gitmodules.txt: gitmodules - Defining submodule properties
       
       DESCRIPTION
      @@ Documentation/gitmodules.txt: submodule.<name>.path::
     + 	Defines the path, relative to the top-level directory of the Git
     + 	working tree, where the submodule is expected to be checked out.
     + 	The path name must not end with a `/`. All submodule paths must
     +-	be unique within the .gitmodules file.
     ++	be unique within the `.gitmodules` file.
     + 
       submodule.<name>.url::
       	Defines a URL from which the submodule repository can be cloned.
       	This may be either an absolute URL ready to be passed to
     @@ Documentation/gitmodules.txt: submodule.<name>.path::
       	command in the superproject. This is only used by `git
       	submodule init` to initialize the configuration variable of
       	the same name. Allowed values here are 'checkout', 'rebase',
     +@@ Documentation/gitmodules.txt: submodule.<name>.update::
     + 
     + submodule.<name>.branch::
     + 	A remote branch name for tracking updates in the upstream submodule.
     +-	If the option is not specified, it defaults to the remote 'HEAD'.
     ++	If the option is not specified, it defaults to the remote `HEAD`.
     + 	A special value of `.` is used to indicate that the name of the branch
     + 	in the submodule should be the same name as the current branch in the
     + 	current repository.  See the `--remote` documentation in
      @@ Documentation/gitmodules.txt: submodule.<name>.branch::
     + 
       submodule.<name>.fetchRecurseSubmodules::
       	This option can be used to control recursive fetching of this
     - 	submodule. If this option is also present in the submodules entry in
     +-	submodule. If this option is also present in the submodules entry in
      -	.git/config of the superproject, the setting there will override the
      -	one found in .gitmodules.
     ++	submodule. If this option is also present in the submodule's entry in
      +	`.git/config` of the superproject, the setting there will override the
      +	one found in `.gitmodules`.
       	Both settings can be overridden on the command line by using the
     @@ Documentation/gitmodules.txt: submodule.<name>.ignore::
       
       	dirty;; All changes to the submodule's work tree will be ignored, only
      -	    committed differences between the HEAD of the submodule and its
     -+	    committed differences between the 'HEAD' of the submodule and its
     ++	    committed differences between the `HEAD` of the submodule and its
       	    recorded state in the superproject are taken into account.
       
       	untracked;; Only untracked files in submodules will be ignored.
     @@ Documentation/gitmodules.txt: submodule.<name>.ignore::
       	    shown. This is the default option.
       
      -If this option is also present in the submodules entry in .git/config
     -+If this option is also present in the submodules entry in `.git/config`
     ++If this option is also present in the submodule's entry in `.git/config`
       of the superproject, the setting there will override the one found in
      -.gitmodules.
      +`.gitmodules`.


 Documentation/gitmodules.txt | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 539b4e1997e..8e333dde1ba 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -7,7 +7,7 @@ gitmodules - Defining submodule properties
 
 SYNOPSIS
 --------
-$GIT_WORK_DIR/.gitmodules
+$GIT_WORK_TREE/.gitmodules
 
 
 DESCRIPTION
@@ -27,19 +27,19 @@ submodule.<name>.path::
 	Defines the path, relative to the top-level directory of the Git
 	working tree, where the submodule is expected to be checked out.
 	The path name must not end with a `/`. All submodule paths must
-	be unique within the .gitmodules file.
+	be unique within the `.gitmodules` file.
 
 submodule.<name>.url::
 	Defines a URL from which the submodule repository can be cloned.
 	This may be either an absolute URL ready to be passed to
-	linkgit:git-clone[1] or (if it begins with ./ or ../) a location
+	linkgit:git-clone[1] or (if it begins with `./` or `../`) a location
 	relative to the superproject's origin repository.
 
 In addition, there are a number of optional keys:
 
 submodule.<name>.update::
 	Defines the default update procedure for the named submodule,
-	i.e. how the submodule is updated by "git submodule update"
+	i.e. how the submodule is updated by the `git submodule update`
 	command in the superproject. This is only used by `git
 	submodule init` to initialize the configuration variable of
 	the same name. Allowed values here are 'checkout', 'rebase',
@@ -49,7 +49,7 @@ submodule.<name>.update::
 
 submodule.<name>.branch::
 	A remote branch name for tracking updates in the upstream submodule.
-	If the option is not specified, it defaults to the remote 'HEAD'.
+	If the option is not specified, it defaults to the remote `HEAD`.
 	A special value of `.` is used to indicate that the name of the branch
 	in the submodule should be the same name as the current branch in the
 	current repository.  See the `--remote` documentation in
@@ -57,14 +57,14 @@ submodule.<name>.branch::
 
 submodule.<name>.fetchRecurseSubmodules::
 	This option can be used to control recursive fetching of this
-	submodule. If this option is also present in the submodules entry in
-	.git/config of the superproject, the setting there will override the
-	one found in .gitmodules.
+	submodule. If this option is also present in the submodule's entry in
+	`.git/config` of the superproject, the setting there will override the
+	one found in `.gitmodules`.
 	Both settings can be overridden on the command line by using the
-	"--[no-]recurse-submodules" option to "git fetch" and "git pull".
+	`--[no-]recurse-submodules` option to `git fetch` and `git pull`.
 
 submodule.<name>.ignore::
-	Defines under what circumstances "git status" and the diff family show
+	Defines under what circumstances `git status` and the diff family show
 	a submodule as modified. The following values are supported:
 +
 --
@@ -73,7 +73,7 @@ submodule.<name>.ignore::
 	    been staged).
 
 	dirty;; All changes to the submodule's work tree will be ignored, only
-	    committed differences between the HEAD of the submodule and its
+	    committed differences between the `HEAD` of the submodule and its
 	    recorded state in the superproject are taken into account.
 
 	untracked;; Only untracked files in submodules will be ignored.
@@ -84,12 +84,12 @@ submodule.<name>.ignore::
 	    differences, and modifications to tracked and untracked files are
 	    shown. This is the default option.
 
-If this option is also present in the submodules entry in .git/config
+If this option is also present in the submodule's entry in `.git/config`
 of the superproject, the setting there will override the one found in
-.gitmodules.
+`.gitmodules`.
 
 Both settings can be overridden on the command line by using the
-"--ignore-submodules" option. The 'git submodule' commands are not
+`--ignore-submodules` option. The `git submodule` commands are not
 affected by this setting.
 --
 
@@ -102,7 +102,7 @@ submodule.<name>.shallow::
 EXAMPLES
 --------
 
-Consider the following .gitmodules file:
+Consider the following `.gitmodules` file:
 
 ----
 [submodule "libfoo"]

base-commit: 71ca53e8125e36efbda17293c50027d31681a41f
-- 
gitgitgadget
