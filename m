Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6353BEB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 06:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjFUGIM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 02:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjFUGIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 02:08:09 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCBC1728
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 23:08:08 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f85966b0f2so6715739e87.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 23:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687327686; x=1689919686;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XYHpTPAt1nPf8C4m4ASjBMBDckmL586S+hP9gekLTLE=;
        b=Gy/BqCW2kPb9qget2ccDiFxQr2NellMoWM3FZBItw6HfSBojTpmV97X5IofaG11ASm
         93BJEL8m9WfEN/Y1A/ns53Ak54B4kx6G5q9qgF649IJe3DAmaqlPb5M1JIk9A/EmQWPL
         33nR41pfmX7xSD41lmi9Q7fOP/pIJ12kd1kkMTLQnwRht8FQ7xUC6nBYeLzGoOHSSWnV
         m07XpTMaC58TqCUUYAnuWj7FgyiIbgUTMQyYRWj099rzcNnKOY6d1IW+eeKf9/LPOcok
         xBexUbG8j4RUoTxMzLfpqmmRzDXZizD/LaTRk25w+s9Rij0e3QHm8EIW5aHJU7XmWlgB
         Gz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687327686; x=1689919686;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XYHpTPAt1nPf8C4m4ASjBMBDckmL586S+hP9gekLTLE=;
        b=PlFWKv/VOus3K9ibykAaY62W4AgOOcLzQ75F+mA+tH65CeZ6s2FRBM2DIUzisH8Yyx
         h5f4eWEnGdncZrJFAgO3pkhj1+V79ir4fUFP0nnXMbVGsrfaYj9ZZ/I1Zs8uqX109dl6
         +iIDbhdB4AngUecy1nS8hmJX3ZqbCVD1U9D8sxKFvv7H98deKfcSC07PwtJv5Ra6aBSI
         gUAnehiFYsOUYJOlJDNZQQ5Y8HrqluXjPB6ZTsrvpmSOIMa8rdCskeRLKHv7mtleHcS/
         +VmDLWBCJ7SaG2GueKir/82aB4EtlcgCe5rs38Exw++IW8uvVgt1G0vI0EW8PlWme6FT
         lp6Q==
X-Gm-Message-State: AC+VfDzLaeaauYcD0mWyALdR+SGHEjDW2XL2DJYT1tiZ9cduEj+e5k6g
        zw2VJakQWOE7xpkA6N7XUkhX+tAuTxU=
X-Google-Smtp-Source: ACHHUZ4V+jd/LWDVhLeEeoxgfFlKxv47qhRrO9srVCOCJkVFotLbCvfNx9mBSLvII0cXasewBeUnZg==
X-Received: by 2002:a19:7b06:0:b0:4f3:a051:58df with SMTP id w6-20020a197b06000000b004f3a05158dfmr8504806lfc.59.1687327686299;
        Tue, 20 Jun 2023 23:08:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c214800b003f42314832fsm3993322wml.18.2023.06.20.23.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 23:08:05 -0700 (PDT)
Message-Id: <pull.1549.git.1687327684909.gitgitgadget@gmail.com>
From:   "Guido =?UTF-8?Q?Mart=C3=ADnez?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 21 Jun 2023 06:08:04 +0000
Subject: [PATCH] ls-files: add an --exclude-links option
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Guido =?UTF-8?Q?Mart=C3=ADnez?= <mtzguido@gmail.com>,
        =?UTF-8?q?Guido=20Mart=C3=ADnez?= <mtzguido@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <mtzguido@gmail.com>

Add an option to exclude symlinks from the listed files. This is useful
in case we are listing the files in order to process the contents,
for instance to do some text replacement with `sed -i`. In that case,
there is no point in processing the links, and it could even be
counterproductive as some tools (like sed) will replace the link with a
fresh regular file.

This option enables a straightforward implementation of a `git sed`:

    #!/bin/bash
    git ls-files --exclude-links -z | xargs -0 -P $(nproc) -- sed -i -e "$@"

Signed-off-by: Guido Martínez <mtzguido@gmail.com>
---
    ls-files: add an --exclude-links option
    
    Hi, not sure if this is desirable, but I found it very useful to
    implement the git sed shown in the commit message to do some
    replacements in a big repo. I placed the option right after
    --exclude-standard and (I think) updated the relevant docs. The flag
    applies to all modes: -c, -d, -m and -o, though I think it's mostly
    useful on the default -c.
    
    Also is there interest in a standard git sed?

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1549%2Fmtzguido%2Fls_files_exclude_links-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1549/mtzguido/ls_files_exclude_links-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1549

 Documentation/git-ls-files.txt |  5 ++++-
 builtin/ls-files.c             | 10 ++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 1bc0328bb78..138ba49bd8c 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -18,7 +18,7 @@ SYNOPSIS
 		[-x <pattern>|--exclude=<pattern>]
 		[-X <file>|--exclude-from=<file>]
 		[--exclude-per-directory=<file>]
-		[--exclude-standard]
+		[--exclude-standard] [--exclude-links]
 		[--error-unmatch] [--with-tree=<tree-ish>]
 		[--full-name] [--recurse-submodules]
 		[--abbrev[=<n>]] [--format=<format>] [--] [<file>...]
@@ -126,6 +126,9 @@ OPTIONS
 	Add the standard Git exclusions: .git/info/exclude, .gitignore
 	in each directory, and the user's global exclusion file.
 
+--exclude-links::
+	Do not list symbolic links.
+
 --error-unmatch::
 	If any <file> does not appear in the index, treat this as an
 	error (return 1).
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 72012c0f0f7..0826e89a496 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -46,6 +46,7 @@ static int show_eol;
 static int recurse_submodules;
 static int skipping_duplicates;
 static int show_sparse_dirs;
+static int exclude_links;
 
 static const char *prefix;
 static int max_prefix_len;
@@ -171,6 +172,11 @@ static void show_other_files(struct index_state *istate,
 		struct dir_entry *ent = dir->entries[i];
 		if (!index_name_is_other(istate, ent->name, ent->len))
 			continue;
+		if (exclude_links) {
+			struct stat st;
+			if (!lstat(ent->name, &st) && S_ISLNK(st.st_mode))
+				continue;
+		}
 		show_dir_entry(istate, tag_other, ent);
 	}
 }
@@ -451,6 +457,8 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 			continue;
 		if (ce->ce_flags & CE_UPDATE)
 			continue;
+		if (exclude_links && S_ISLNK(ce->ce_mode))
+			continue;
 		if ((show_cached || show_stage) &&
 		    (!show_unmerged || ce_stage(ce))) {
 			show_ce(repo, dir, ce, fullname.buf,
@@ -780,6 +788,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			N_("add the standard git exclusions"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 			option_parse_exclude_standard),
+		OPT_BOOL(0, "exclude-links", &exclude_links,
+			 N_("do not print symbolic links")),
 		OPT_SET_INT_F(0, "full-name", &prefix_len,
 			      N_("make the output relative to the project top directory"),
 			      0, PARSE_OPT_NONEG),

base-commit: 6640c2d06d112675426cf436f0594f0e8c614848
-- 
gitgitgadget
