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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31585C433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 01:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D20DC2311E
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 01:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbhAGBJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 20:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbhAGBJt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 20:09:49 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96B0C0612EF
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 17:09:08 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id 91so4031197wrj.7
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 17:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EQj0gGIxK6KIS+yIMG+OieLyHi+Ttxe1sRh7o9XrhrY=;
        b=CrMeYi0uJU8vwI4X6Ib8A7uCoaNcqyqLs0a405zyWKn10Gb9xRl4s41IzUQGCdwbPZ
         Drr16eNl+7bD1ARwnC7wK/xy3KHGfT+CXA+NdXNv8rDogNKarWdSaXG5Lz77VZbizSxO
         yHk2S7NKh0AG1g5EpScG1fb9gBPgiyojRkkTMrfywLsBDA1tbbneMKWVF3a/8dXFIgIF
         F8Ov+G6Nj8HobdWvbMcn3Afnk+4O+SnijjMDmU+luvjwW8jbHPLAlDI/mKB2q5dx8Z/A
         RwT0byCHY1MN/hYqmMdaVoJ1wM9HoQRGa4MouyHRN+yTKuBP7oV7q1BbEeB7ciQMwOoG
         v8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EQj0gGIxK6KIS+yIMG+OieLyHi+Ttxe1sRh7o9XrhrY=;
        b=aH/NdWnpLo3PYBn9NksXreAub45NEc9+2fsClUVHVHp57zmcPIelL3A3/wrmm3TL05
         icwCUkCPm5ijmcAin5TmrlUuGoeeYylNZMj+cQ2HMd1B/D6RlD3GX5W1RSP89oAJod2f
         AWh7Lv7QsQPN4/8slALXxm+/38uoQ+M3Uo9K+4ssXN+JdmDjFX/ubCjWA3WK3xRk/dqO
         36c8J0z0gQvdY1H4lNOpXe5D87MtPB1sPMpPsAkbxYQaRQ2PGTxaxdpr1DWcduiTVW4X
         ie57lTlSBecUeWTO72L2m33Jpfgz1hElrfrp9MOkiyhJo1xLDbtNUSYC8/DY8cK8o0gD
         yhHQ==
X-Gm-Message-State: AOAM532TTl5CCUZ6eAfwyXkIm1VHobqOYSFcT6dx8vPupN0ent+QFAkz
        eZno8vGKorLBmiVEx/IBUe/h7uAwuAI=
X-Google-Smtp-Source: ABdhPJwQXVLNtZVRmGyY4eiZbcXpSySm2xJ0VBUydEOmCvVrsid3bpJ+vQ74/jm1jjB5yLOiYTYLyQ==
X-Received: by 2002:a5d:6a05:: with SMTP id m5mr6449086wru.96.1609981747444;
        Wed, 06 Jan 2021 17:09:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v1sm4996297wmj.31.2021.01.06.17.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 17:09:06 -0800 (PST)
Message-Id: <pull.825.v3.git.1609981745668.gitgitgadget@gmail.com>
In-Reply-To: <pull.825.v2.git.1609184505071.gitgitgadget@gmail.com>
References: <pull.825.v2.git.1609184505071.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 01:09:05 +0000
Subject: [PATCH v3] mergetool--lib: fix '--tool-help' to correctly show
 available tools
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        pudinha <rogi@skylittlesystem.org>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Commit 83bbf9b92e (mergetool--lib: improve support for vimdiff-style tool
variants, 2020-07-29) introduced a regression in the output of `git mergetool
--tool-help` and `git difftool --tool-help` [1].

In function 'show_tool_names' in git-mergetool--lib.sh, we loop over the
supported mergetools and their variants and accumulate them in the variable
'variants', separating them with a literal '\n'.

The code then uses 'echo $variants' to turn these '\n' into newlines, but this
behaviour is not portable, it just happens to work in some shells, like
dash(1)'s 'echo' builtin.

For shells in which 'echo' does not turn '\n' into newlines, the end
result is that the only tools that are shown are the existing variants
(except the last variant alphabetically), since the variants are
separated by actual newlines in '$variants' because of the several
'echo' calls in mergetools/{bc,vimdiff}::list_tool_variants.

Fix this bug by embedding an actual line feed into `variants` in
show_tool_names(). While at it, replace `sort | uniq` by `sort -u`.

To prevent future regressions, add a simple test that checks that a few
known tools are correctly shown (let's avoid counting the total number
of tools to lessen the maintenance burden when new tools are added or if
'--tool-help' learns additional logic, like hiding tools depending on
the current platform).

[1] https://lore.kernel.org/git/CADtb9DyozjgAsdFYL8fFBEWmq7iz4=prZYVUdH9W-J5CKVS4OA@mail.gmail.com/

Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
Based-on-patch-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    Fix regression in 'git {diff,merge}tool --tool-help'
    
    Changes since v1:
    
     * Changed commit authorship (v1 sent with wrong identity).
    
    v1: I went with Johannes' suggestion finally because upon further
    inspection, René's patch for some reason (I did not debug further)
    caused to code to never reach 'any_shown=yes' in show_tool_help,
    therefore changing the output of the command.
    
    I guess it's too late for inclusion in 2.30...

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-825%2Fphil-blain%2Fmergetool-tool-help-fix-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-825/phil-blain/mergetool-tool-help-fix-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/825

Range-diff vs v2:

 1:  2b9dce31fd0 ! 1:  f66421939ec mergetool--lib: fix '--tool-help' to correctly show available tools
     @@ Commit message
          behaviour is not portable, it just happens to work in some shells, like
          dash(1)'s 'echo' builtin.
      
     -    For shells in which 'echo' does not turn '\n' into newlines, the end result is
     -    that the only tools that are shown are those that are found and have variants,
     -    since the variants are separated by actual newlines in '$variants' because of
     -    the several 'echo' calls in mergetools/{bc,vimdiff}::list_tool_variants.
     +    For shells in which 'echo' does not turn '\n' into newlines, the end
     +    result is that the only tools that are shown are the existing variants
     +    (except the last variant alphabetically), since the variants are
     +    separated by actual newlines in '$variants' because of the several
     +    'echo' calls in mergetools/{bc,vimdiff}::list_tool_variants.
      
          Fix this bug by embedding an actual line feed into `variants` in
          show_tool_names(). While at it, replace `sort | uniq` by `sort -u`.
      
     -    To prevent future regressions, add a simple test that counts the number
     -    of tools shown by 'git mergetool --tool-help', irrespective of their
     -    installed status, by making use of the fact that mergetools are listed
     -    by 'git mergetool --tool-help' on lines starting with tabs. Prefix the
     -    `git config` commands used at the beginning of the test to remove the
     -    fake tools used by the previous test with 'test_might_fail' so that the
     -    test can be run independantly of the previous test without failing.
     +    To prevent future regressions, add a simple test that checks that a few
     +    known tools are correctly shown (let's avoid counting the total number
     +    of tools to lessen the maintenance burden when new tools are added or if
     +    '--tool-help' learns additional logic, like hiding tools depending on
     +    the current platform).
      
          [1] https://lore.kernel.org/git/CADtb9DyozjgAsdFYL8fFBEWmq7iz4=prZYVUdH9W-J5CKVS4OA@mail.gmail.com/
      
     @@ t/t7610-mergetool.sh: test_expect_success 'mergetool -Oorder-file is honored' '
       	test_cmp expect actual
       '
       
     -+test_expect_success 'mergetool --tool-help shows all recognized tools' '
     -+	# Remove fake tools added in previous tests
     -+	test_might_fail git config --unset merge.tool &&
     -+	test_might_fail git config --remove-section mergetool.mytool &&
     -+	test_might_fail git config --remove-section mergetool.mybase &&
     -+	git mergetool --tool-help >output &&
     -+	grep "$(printf "\t")" output >mergetools &&
     -+	test_line_count = 30 mergetools
     ++test_expect_success 'mergetool --tool-help shows recognized tools' '
     ++	# Check a few known tools are correctly shown
     ++	git mergetool --tool-help >mergetools &&
     ++	grep vimdiff mergetools &&
     ++	grep vimdiff3 mergetools &&
     ++	grep gvimdiff2 mergetools &&
     ++	grep araxis mergetools &&
     ++	grep xxdiff mergetools &&
     ++	grep meld mergetools
      +'
      +
       test_done


 git-mergetool--lib.sh |  6 ++++--
 t/t7610-mergetool.sh  | 11 +++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 7225abd8112..78f3647ed97 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -46,9 +46,11 @@ show_tool_names () {
 		while read scriptname
 		do
 			setup_tool "$scriptname" 2>/dev/null
-			variants="$variants$(list_tool_variants)\n"
+			# We need an actual line feed here
+			variants="$variants
+$(list_tool_variants)"
 		done
-		variants="$(echo "$variants" | sort | uniq)"
+		variants="$(echo "$variants" | sort -u)"
 
 		for toolname in $variants
 		do
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 70afdd06fa7..6ac75b5d4c0 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -828,4 +828,15 @@ test_expect_success 'mergetool -Oorder-file is honored' '
 	test_cmp expect actual
 '
 
+test_expect_success 'mergetool --tool-help shows recognized tools' '
+	# Check a few known tools are correctly shown
+	git mergetool --tool-help >mergetools &&
+	grep vimdiff mergetools &&
+	grep vimdiff3 mergetools &&
+	grep gvimdiff2 mergetools &&
+	grep araxis mergetools &&
+	grep xxdiff mergetools &&
+	grep meld mergetools
+'
+
 test_done

base-commit: 4a0de43f4923993377dbbc42cfc0a1054b6c5ccf
-- 
gitgitgadget
