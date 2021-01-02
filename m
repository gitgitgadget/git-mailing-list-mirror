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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2B5C433DB
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 19:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13F06206CA
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 19:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbhABTiL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Jan 2021 14:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbhABTiK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jan 2021 14:38:10 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AC5C061573
        for <git@vger.kernel.org>; Sat,  2 Jan 2021 11:37:29 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t16so26994263wra.3
        for <git@vger.kernel.org>; Sat, 02 Jan 2021 11:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=r51vJTRjrKI8VLWpUMGA2uur8Is38OlkTfSGB9ad7rc=;
        b=W9gfgPQI/G/1F+bCXYmlFW1lmmJGG/HGQX1YY7NWtmV/PQbpQMbI8u+OdYmV95RfMt
         zkbbwqbyVBvEsdEnFUki3zKzolEhVn4mwRUHUSvM/xzHbqDKfYknL2EyMPXoneDHeT0j
         0HsdH+5h8GGVvItt3dqpjavIYg993vy5ox/1J1DW6hPJhCvv9pLmJ+vKtm1d8gF6WYY4
         xJbb+H4VLUvT/s2hQbgz1e/I5d7g4Io4zFLrG3lP5tF/KTkhR96SWeEq+axXnH7HivdJ
         U4IaW5e80SPa6pW/FGDaqfJDSuFHGDLDWlhYHAEKWhsC0wfA2makJ7lygr7CcQCDktra
         2gog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r51vJTRjrKI8VLWpUMGA2uur8Is38OlkTfSGB9ad7rc=;
        b=j0s0CHeW1ZIbNu84qD+oBX5pRKRhnpoikn2Q5J371LwRJtinllRaIHcmuQWNAJqpOK
         u52ReMBv2gN9JrQQW+z8tAPbF5Fu2JFdlTsw56j3sBKVljLo5TmGrvFT7Wz25EvxC2jJ
         OuGHT79kKfdcpxjsDT7Ruk6s8dv47m8GVfcANfQS2Xd0a1YKkTGdR5qoLAgl7HX7OyBh
         9mtK25d5g/IX3bOiECCpgUbdTueQzEtt7sQuPa5omoGdcSX5ABlYBso6vwjicCZTmdxJ
         vhKRHuHVxpJgRwAJGtmpq+5hsgnWctBFavxQ3P4608Fzpcn65ExUmwjfjEpJbjZmjVvO
         184g==
X-Gm-Message-State: AOAM532wx8VMaYkUpWLaS59Px2Zq70prmwywG40kjKW54uIQyF+VVBK9
        xYHo1Hi5I6dUIywsYU28YkaeSbqwvp8=
X-Google-Smtp-Source: ABdhPJzQb2psyf27dZ5K+e+vfTG+wB5I5u8ciObo9FMU6Yr4q6cd/mlrhaOysQjIMC9XXO66OkHItQ==
X-Received: by 2002:a5d:4d4f:: with SMTP id a15mr73322706wru.315.1609616246883;
        Sat, 02 Jan 2021 11:37:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y68sm25343588wmc.0.2021.01.02.11.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jan 2021 11:37:26 -0800 (PST)
Message-Id: <pull.942.git.git.1609616245412.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 02 Jan 2021 19:37:25 +0000
Subject: [PATCH] gitmodules.txt: fix 'GIT_WORK_TREE' variable name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Gustaf Hendeby <hendeby@isy.liu.se>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

'gitmodules.txt' is a guide about the '.gitmodules' file that describes
submodules properties, and that file must exist at the root of the
repository. This was clarified in e5b5c1d2cf (Document clarification:
gitmodules, gitattributes, 2008-08-31).

However, that commit mistakenly uses the non-existing environment
variable 'GIT_WORK_DIR' to refer to the root of the repository.

Fix that by using the correct variable, 'GIT_WORK_TREE'. Take the
opportunity to modernize and improve the formatting of that guide.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    gitmodules.txt: fix 'GIT_WORK_TREE' variable name

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-942%2Fphil-blain%2Fdoc-gitmodules-envvar-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-942/phil-blain/doc-gitmodules-envvar-v1
Pull-Request: https://github.com/git/git/pull/942

 Documentation/gitmodules.txt | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 539b4e1997e..07f3af6bae4 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -7,7 +7,7 @@ gitmodules - Defining submodule properties
 
 SYNOPSIS
 --------
-$GIT_WORK_DIR/.gitmodules
+$GIT_WORK_TREE/.gitmodules
 
 
 DESCRIPTION
@@ -32,14 +32,14 @@ submodule.<name>.path::
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
@@ -58,13 +58,13 @@ submodule.<name>.branch::
 submodule.<name>.fetchRecurseSubmodules::
 	This option can be used to control recursive fetching of this
 	submodule. If this option is also present in the submodules entry in
-	.git/config of the superproject, the setting there will override the
-	one found in .gitmodules.
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
+	    committed differences between the 'HEAD' of the submodule and its
 	    recorded state in the superproject are taken into account.
 
 	untracked;; Only untracked files in submodules will be ignored.
@@ -84,12 +84,12 @@ submodule.<name>.ignore::
 	    differences, and modifications to tracked and untracked files are
 	    shown. This is the default option.
 
-If this option is also present in the submodules entry in .git/config
+If this option is also present in the submodules entry in `.git/config`
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
