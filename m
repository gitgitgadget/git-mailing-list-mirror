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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB026C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 19:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BED7861350
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 19:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhFOTkn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 15:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhFOTkm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 15:40:42 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DD8C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 12:38:36 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id f2so19539417wri.11
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 12:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=Vz2WalI0xsSWYR4w8QNNv0UShEYWnVyMtW/dylXHGgM=;
        b=iNY8eNlUEb4RT12olJd25q+fvqQlX3siz6wAik1MCP1TNgkWF8nM7WMXd8o/ENxp4v
         Y3/ByvyTH7MTzsk63lgSlj9Gf7Eh7ZJU3CD/MtUEtvQZbbYqD+fLnGbOebOEsQKmcTvf
         tCU9WLxvmyDUIkR7fe0UqL+XwDNTs/Ez+bCz607kJYCNs6ZYOs8ypWZUBhI+2gMjp6kI
         YuPgUqA9W1ivLLuc/VIREnJcDk4NAWDdYyEL+XTECFx6oE80VPg4AhIs8xKJWdmRFYEF
         gaz+UApt1jbSqtyr5cLvzM8GzuuAfJe26Tu5ELLtZFE50dETd+jT9Ii7+Ckk6U8xXXhF
         rNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Vz2WalI0xsSWYR4w8QNNv0UShEYWnVyMtW/dylXHGgM=;
        b=br0rtRuWsmF9DXa9v1x5V5407kpjf2lxh4t+boSEMAhEvK0i9Dx0aUTI6Ee10JVCEM
         QXS4M9VYACryVU3/54g+V4YMDCZj5WYhtwXJ08zuYOuj+4RGHNmikaFBk10WmnMWpECp
         bdS+1MXE6bdbYwOOfld/TLT/fo8yb8nkiC5BUnDWTu5IRn+4rHt5JpgXUXuqCdghGoHA
         7dGYssFu/hEUUbrUopQvXYBhLm97R1sxFvPU0VTcL5y5Udz46A1eIoXwcROG7AdHAEZj
         tsB0WyJnq9wxgTl7PmaMemKEz3iK3/C/f/DeO45DN8BHrDQ27OpCuIp1tIMDr4I5ZfJn
         nT1g==
X-Gm-Message-State: AOAM530zdr345pdzbKUddQFzF24tHO0KCgnpgaCMChlJqw+bMua0GyDD
        Ru9DFnkPC/bRVSEbJZoITIF0peEgZWM=
X-Google-Smtp-Source: ABdhPJzKRcPYER8kuiYOkAvRLUubpHWNo17Xi2709ZSXu3GLBVUzrT7gUNEKM65rZ7FpzqgK55i3iw==
X-Received: by 2002:a5d:6a0d:: with SMTP id m13mr825721wru.318.1623785915165;
        Tue, 15 Jun 2021 12:38:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 6sm16545927wmg.17.2021.06.15.12.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 12:38:34 -0700 (PDT)
Message-Id: <pull.912.git.git.1623785914202.gitgitgadget@gmail.com>
From:   "Daniel =?UTF-8?Q?H=C3=B6pfl?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 15 Jun 2021 19:38:33 +0000
Subject: [PATCH] Add config variable besides env variable to squelch
 "do-not-use" warning.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Daniel =?UTF-8?Q?H=C3=B6pfl?= <github@hoepfl.de>,
        =?UTF-8?q?Daniel=20H=C3=B6pfl?= <daniel@hoepfl.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Daniel=20H=C3=B6pfl?= <daniel@hoepfl.de>

In addition to the environment variable FILTER_BRANCH_SQUELCH_WARNING,
the git config filter-branch.squelchWarning is checked to see if the
usage warning should be squelched.

Signed-off-by: Daniel Höpfl <daniel@hoepfl.de>
---
    Add filter-branch.squelchWarning git config alongside
    FILTER_BRANCH_SQUELCH_WARNING
    
    In addition to the environment variable FILTER_BRANCH_SQUELCH_WARNING,
    the git config filter-branch.squelchWarning is checked to see if the
    usage warning should be squelched.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-912%2Fdhoepfl%2FFILTER_BRANCH_SQUELCH_WARNING-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-912/dhoepfl/FILTER_BRANCH_SQUELCH_WARNING-v1
Pull-Request: https://github.com/git/git/pull/912

 git-filter-branch.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index fea796461721..d33db14a2a84 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -83,7 +83,8 @@ set_ident () {
 	finish_ident COMMITTER
 }
 
-if test -z "$FILTER_BRANCH_SQUELCH_WARNING$GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS"
+if test -z "$FILTER_BRANCH_SQUELCH_WARNING$GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS" &&
+   test "$(git config --bool filter-branch.squelchWarning)" != true
 then
 	cat <<EOF
 WARNING: git-filter-branch has a glut of gotchas generating mangled history
@@ -91,7 +92,12 @@ WARNING: git-filter-branch has a glut of gotchas generating mangled history
 	 alternative filtering tool such as 'git filter-repo'
 	 (https://github.com/newren/git-filter-repo/) instead.  See the
 	 filter-branch manual page for more details; to squelch this warning,
-	 set FILTER_BRANCH_SQUELCH_WARNING=1.
+	 set FILTER_BRANCH_SQUELCH_WARNING=1 or run the following command:
+
+	    git config filter-branch.squelchWarning true
+
+	 You can replace "git config" with "git config --global" to disable
+	 the warning for all repositories.
 EOF
 	sleep 10
 	printf "Proceeding with filter-branch...\n\n"

base-commit: e4d83eee9239207622e2b1cc43967da5051c189c
-- 
gitgitgadget
