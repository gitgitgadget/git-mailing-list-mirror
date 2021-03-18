Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD0EC433DB
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 09:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3750964F10
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 09:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhCRJra (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 05:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhCRJrI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 05:47:08 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C18C061760
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 02:47:08 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id bt4so2618914pjb.5
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 02:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2AhOuynnxz3rTaWffeciWEZJbuzWh556g87pLPwc1po=;
        b=i3pktuFPxbCz9IsIIJLArfknUiUPz7RfyHCKDf/hI7VVByFchajcq1ubqO9iblikwF
         4f4i2HvmJS9pGrMSZWvuLp4jE6TJlbmqTcZwYYM8lBBjVvc5aI3Hs659rWPlhUgrlkXd
         OHE22D0wFqviCAvhTd/Y42JKPEeqzBh6hxCh3LRqFPYOOA+ZwbWEDOjofsD+bY6bRDtl
         1m7udbsZCiyEt4zfeSUaWFpLcRwlun8pjovcIFLYaXcGqI64PSWgYmsRKZfUIKKSY9lI
         21m/jqaAjL3iTsamj6ckS50sNBVmYS0ZV3RfoR4E5HEKNndR5rwm3/W62taGCwixVEih
         kFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2AhOuynnxz3rTaWffeciWEZJbuzWh556g87pLPwc1po=;
        b=LkFTC5umCTDgp2PYgrC+vAvGQxMDt7w1B3wmxdOenHYvnpdUpILK5sdACNV/9SLA2W
         s3Ynb3oJrAFIM7/kyr/X3lpRz2ohl3oKQ6Kfn6J8km0K6OZVHih8ILxZkAzPrIMFJRrH
         ubXZO2eFiauQvfxNPBj2JRFrirCr6zDCYSzmL7GPCTkgRVtkciVjWKTgV2Z0qwlzG14C
         Tgu5LFkO1sMJ3uzlkycS8Fu8g9SzOyUDS3LACveREAf7LAAgCYRKn6jZBJGrpHYBvCo5
         LrpB5cUMCUmU4sQcK4EB/2O22ePVWyJGVs/axUVKjSHoV4tgJ4u/LyUSL8d79LnxWrGx
         AnhA==
X-Gm-Message-State: AOAM531CysA1sWS+2TePw2vLWsIbcGpv39J3rAF9QcNjYBu8k2lA4TAT
        AANV+wp3Z+b/xj4SIqQ32mJ5G+/azxw=
X-Google-Smtp-Source: ABdhPJxPdA5sgSgxgCkLDYHLK6dhUiYHGud7Ca0uQdxd6yUQZHSd3L6YbmmInSH6PfEGY32qhHGrDA==
X-Received: by 2002:a17:902:fe0d:b029:e5:ffb8:1c28 with SMTP id g13-20020a170902fe0db02900e5ffb81c28mr8710460plj.62.1616060827524;
        Thu, 18 Mar 2021 02:47:07 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id b186sm1902326pfb.170.2021.03.18.02.47.06
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 02:47:07 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [RESEND PATCH 2/3] git-completion.bash: fix `git <args>... stash branch` bug
Date:   Thu, 18 Mar 2021 02:46:55 -0700
Message-Id: <be727d0171b16e488a357a959176e60bf9210d40.1616060793.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620
In-Reply-To: <cover.1616060793.git.liu.denton@gmail.com>
References: <cover.1615855962.git.liu.denton@gmail.com> <cover.1616060793.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When completions are offered for `git stash branch<TAB>`, the user is
supposed to receive refs. This works in the case where the main git
command is called without arguments but if options are provided, such as
`git -C dir stash branch<TAB>`, then the `$cword -eq 3` provides
incorrect results.

Count the words relative to the first instance of "stash" so that we
ignore arguments to the main git command.

Unfortunately, this still does not work 100% correctly. For example, in
the case of something like `git -C stash stash branch<TAB>`, this will
incorrectly identify the first "stash" as the command. This seems to be
an edge-case that we can ignore, though, as other functions, such as
_git_worktree(), suffer from the same problem.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/completion/git-completion.bash | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index fe79f6b71c..da46f46e3c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3016,6 +3016,9 @@ _git_stash ()
 	local save_opts='--all --keep-index --no-keep-index --quiet --patch --include-untracked'
 	local subcommands='push list show apply clear drop pop create branch'
 	local subcommand="$(__git_find_on_cmdline "$subcommands save")"
+	local stash_idx="$(__git_find_on_cmdline --show-idx stash)"
+	stash_idx="${stash_idx% *}"
+
 	if [ -z "$subcommand" -a -n "$(__git_find_on_cmdline "-p")" ]; then
 		subcommand="push"
 	fi
@@ -3060,7 +3063,7 @@ _git_stash ()
 	branch,--*)
 		;;
 	branch,*)
-		if [ $cword -eq 3 ]; then
+		if [ $((cword - stash_idx)) -eq 2 ]; then
 			__git_complete_refs
 		else
 			__gitcomp_nl "$(__git stash list \
-- 
2.31.0.rc2.261.g7f71774620

