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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E27C432C3
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 23:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 317FB22582
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 23:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgL1Wzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 17:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729312AbgL1Tm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 14:42:28 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07783C0613D6
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 11:41:48 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t30so12373464wrb.0
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 11:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4ty5t80CkvaTO9x0e/BYSZjUBuy7o+sx6kApff4jMTQ=;
        b=Iy8fE7jrPdm+SdjE2v27uCWauvAUiDMsk3eigIymo/x816bgI1LrlOswhgE3UzKkpF
         cSEiXuguasnG8vqC0Magh+SO86H/nSFhyW8z7744Ahpt0K6/q2DL0OUzzwGUNepx4GHd
         IyZlZE79A6j2hEy/RK1kxmgR0HSrbqlisl1w2psghBL2/rRTafzeu5rvjnSLHYdKnp68
         mR2bU1bl574gpdE0qApA1W76bDwZjLDfS+qBJid22LAquXDgj5p3Wh9xKsvHpSxgopNZ
         gOd8ookwyt+oLO1qy7rS3XyDL8NzukEvsH15fVJrNA10BLSTCxOQ6DZSWkNkkaBTg1ko
         z+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4ty5t80CkvaTO9x0e/BYSZjUBuy7o+sx6kApff4jMTQ=;
        b=CTVQxRsz5HWud1DtYNFbYAOfD3C+5tpasAHagoKstJwFkDa9TXw8Yo7PjmODw/IJ/7
         vgRsvBIj8pptsuDR9HOqUBI0EebIUmDxwVQ/Vg+GVoJt6LOc9jK0nxGj1OhdtuBI/PTc
         k7PaldfLYKvSIRXFn9kDF3nTR2ky+iFWRrj6EXfhY+FKBZIVu3nCPH3AFDOdhCJo/gah
         0Lbq458BNei8uu6zT2MBLIkepOhc73wUii/Hhzz5ev1ORMSNsmqKmohXlv1MKihbbnhe
         f34NZfI+OsYvLdpy66ENLsGw75XPJDsoTxCq/u1tYKs0mMUMbRXjFeyqJn05VltZxiZV
         5UqA==
X-Gm-Message-State: AOAM532LjUX3QQE0rE+edhZTz5FseihC33UQzQ0Tpdm5vTJUequ+LtFO
        l7NyvxzFZQZyHvGlqHuZ5bKfV7ONCL4=
X-Google-Smtp-Source: ABdhPJxCUN2KLnDkMKG3lZfH29nqjAroo8OjswA1YU/iUT9klmfmTJz+qHjJEUO+eaW930Gl7cr/qg==
X-Received: by 2002:adf:f605:: with SMTP id t5mr51462614wrp.39.1609184506564;
        Mon, 28 Dec 2020 11:41:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g192sm330253wme.48.2020.12.28.11.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 11:41:45 -0800 (PST)
Message-Id: <pull.825.v2.git.1609184505071.gitgitgadget@gmail.com>
In-Reply-To: <pull.825.git.1609179751864.gitgitgadget@gmail.com>
References: <pull.825.git.1609179751864.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Dec 2020 19:41:44 +0000
Subject: [PATCH v2] mergetool--lib: fix '--tool-help' to correctly show
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
    
    Changes since v1:
    
     * Changed commit authorship (v1 sent with wrong identity).
    
    v1: I went with Johannes' suggestion finally because upon further
    inspection, René's patch for some reason (I did not debug further)
    caused to code to never reach 'any_shown=yes' in show_tool_help,
    therefore changing the output of the command.
    
    I guess it's too late for inclusion in 2.30...

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-825%2Fphil-blain%2Fmergetool-tool-help-fix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-825/phil-blain/mergetool-tool-help-fix-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/825

Range-diff vs v1:

 1:  a79d0a09daa ! 1:  2b9dce31fd0 mergetool--lib: fix '--tool-help' to correctly show available tools
     @@
       ## Metadata ##
     -Author: Philippe Blain <philippe.blain@canada.ca>
     +Author: Philippe Blain <levraiphilippeblain@gmail.com>
      
       ## Commit message ##
          mergetool--lib: fix '--tool-help' to correctly show available tools


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
