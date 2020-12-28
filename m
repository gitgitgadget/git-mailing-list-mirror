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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954E5C433E9
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 18:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6839122AAD
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 18:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgL1SXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 13:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbgL1SXP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 13:23:15 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8787EC061796
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 10:22:34 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 3so153433wmg.4
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 10:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=C3S63rIO5V5tFVqPOTawAdPG2ZYv5/c33jVcstMaICI=;
        b=Ad0XNIjvC6lYth0WrlyI4G/sablYJl/mctbzSxCU6HkFdRB+gllhaH4RmB4MPH9e2Z
         e9JOC6cwjJtHHlPjGVzSu+Yo4LJEjLMa2VcWyuIi0gLf/m+xQVAYb0ZNwSbOyDWJXDtU
         xc4Zht5WnYIHA5wwhrLnCtJFBXlqE5SsEyxihtN7uXj6PDEzJabOuwE0wotAWd7kffCr
         Mfz5osEuzo6XJIv+3YVyQKiOY41A0bknpU4Ayu1ce8Ra1sAuu91cofgsJPtEVFTqa7Ve
         LEVdwPotlwQMJ8a80vhTOxgHvkgqnDhbKykkrhu0BQHP+khu9ch/HaJyGPULaZgIjMLd
         u70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C3S63rIO5V5tFVqPOTawAdPG2ZYv5/c33jVcstMaICI=;
        b=HZJ/WPzDrtwLh2NJvqeSavgeFbRQWu7aL7+BOG/oi2jWgH5sx96U78zSg8P+fHL2iq
         KBDCm9rcq9waNSqTJB4cnt4Baf8y0B6hBmqILqsdwMt/XZxqoP5H3hzXfFJvi+c02BiD
         DGiCps6H+GXpt0iDIMmRmmo4BEw8yWvYoU1Y9jZTB6LPXoTpZsoiUeiGAXaflwqNGMBA
         V3Y4pXBT25fUmtS7/cbA8KLUjLUlW+QnWnc5+6Qy3RRwSZYyAfMGdXlAMl9pxmewXU8N
         Dqu5CITUVDxe0GiL/HoPfIpOM3cSaM9vVJirOd292wR9DXu7smva4z6y22zNe93Kofew
         u50g==
X-Gm-Message-State: AOAM533AGmpAUnQlKhXuBbR4ONXdJl/q1qz2ge4AWAN7nUo+XjpL3uQf
        bTRuMZPdP1blXBcOJpLpBMasw8EEdl8=
X-Google-Smtp-Source: ABdhPJxMzgw/ON3GJ46WesuGilTa68qAU2t0VXs8gpaEq+p7xMYa14Ck6Y7AqZ3z0JG4T4B8DvbEmg==
X-Received: by 2002:a1c:4483:: with SMTP id r125mr145704wma.80.1609179753055;
        Mon, 28 Dec 2020 10:22:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w8sm56271530wrl.91.2020.12.28.10.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 10:22:32 -0800 (PST)
Message-Id: <pull.825.git.1609179751864.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Dec 2020 18:22:31 +0000
Subject: [PATCH] mergetool--lib: fix '--tool-help' to correctly show available
 tools
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        pudinha <rogi@skylittlesystem.org>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Philippe Blain <philippe.blain@canada.ca>,
        Philippe Blain <philippe.blain@canada.ca>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <philippe.blain@canada.ca>

Commit 83bbf9b92e (mergetool--lib: improve support for vimdiff-style tool
variants, 2020-07-29) introduced a regression in the output of `git mergetool
--tool-help` and `git difftool --tool-help` [1].

In function 'show_tool_names' in git-mergetool--lib.sh, we loop over the
supported mergetools and their variants and accumulate them in the variable
'variants', separating them with a literal '\n'.

The code then uses 'echo $variants' to turn these '\n' into newlines, but this
behaviour is not portable, it just happens to work in some shells, like
dash(1)'s 'echo' builtin.

For shells in which 'echo' does not turn '\n' into newlines, the end result is
that the only tools that are shown are those that are found and have variants,
since the variants are separated by actual newlines in '$variants' because of
the several 'echo' calls in mergetools/{bc,vimdiff}::list_tool_variants.

Fix this bug by embedding an actual line feed into `variants` in
show_tool_names(). While at it, replace `sort | uniq` by `sort -u`.

To prevent future regressions, add a simple test that counts the number
of tools shown by 'git mergetool --tool-help', irrespective of their
installed status, by making use of the fact that mergetools are listed
by 'git mergetool --tool-help' on lines starting with tabs. Prefix the
`git config` commands used at the beginning of the test to remove the
fake tools used by the previous test with 'test_might_fail' so that the
test can be run independantly of the previous test without failing.

[1] https://lore.kernel.org/git/CADtb9DyozjgAsdFYL8fFBEWmq7iz4=prZYVUdH9W-J5CKVS4OA@mail.gmail.com/

Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
Based-on-patch-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    Fix regression in 'git {diff,merge}tool --tool-help'
    
    I went with Johannes' suggestion finally because upon further
    inspection, René's patch for some reason (I did not debug further)
    caused to code to never reach 'any_shown=yes' in show_tool_help,
    therefore changing the output of the command.
    
    I guess it's too late for inclusion in 2.30...

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-825%2Fphil-blain%2Fmergetool-tool-help-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-825/phil-blain/mergetool-tool-help-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/825

 git-mergetool--lib.sh |  6 ++++--
 t/t7610-mergetool.sh  | 10 ++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

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
index 70afdd06fa7..ebd3af139e5 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -828,4 +828,14 @@ test_expect_success 'mergetool -Oorder-file is honored' '
 	test_cmp expect actual
 '
 
+test_expect_success 'mergetool --tool-help shows all recognized tools' '
+	# Remove fake tools added in previous tests
+	test_might_fail git config --unset merge.tool &&
+	test_might_fail git config --remove-section mergetool.mytool &&
+	test_might_fail git config --remove-section mergetool.mybase &&
+	git mergetool --tool-help >output &&
+	grep "$(printf "\t")" output >mergetools &&
+	test_line_count = 30 mergetools
+'
+
 test_done

base-commit: 4a0de43f4923993377dbbc42cfc0a1054b6c5ccf
-- 
gitgitgadget
