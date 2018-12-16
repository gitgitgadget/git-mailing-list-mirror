Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FCF41F405
	for <e@80x24.org>; Sun, 16 Dec 2018 21:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbeLPV6P (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 16:58:15 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:43100 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730977AbeLPV6O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 16:58:14 -0500
Received: by mail-pf1-f178.google.com with SMTP id w73so5337221pfk.10
        for <git@vger.kernel.org>; Sun, 16 Dec 2018 13:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=04gmjA1tsZAFBadJev/euijJH2ZaHjDOhtyaoQxntNw=;
        b=ov9l2a6vj3EYekhI5TwBho36H6Fu3JJ+hCMdokwCO/Ekndn5Jo4LHmkNQ/pVnNw5Gn
         54Iu2oiBZ56uc5UR6ZPl3/IBmr9bMCgm6lg2MI+YLpEQ/3FVxFalUz4QFdHhqlsr8k86
         aenLYci3rWOKoKXOA+2MHvaf5M6hJrWnAF3QvKlRxj0dcrUIv0ekJNwg23lkRaHCyjGR
         aJIn3utEqbltC/vSwAk1qj761eLb+lXa6/Mw3rpw0kM4Xmz+Fiao6hyiTNm/4VpdF5nK
         QcjfhVnLv6d9eUOTwb76vnBiUdb3PFDGSB912OSvf8khJWeeqawCXoqHJPruF2tm+yA/
         pFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=04gmjA1tsZAFBadJev/euijJH2ZaHjDOhtyaoQxntNw=;
        b=NXCGI4X5zFM/0msbIi333r7F1m7RQZcqiIpnIOGn80T6Fl2krzyqXzxIhyQSWS1Hs3
         QwoNyxNULLaFj2uBtWXBA59+4NmMw9PLI1ch0oZ9w/ipMXFMKYPFgCECddBmzqOVRmyP
         bEmiwFFR7OFx68ygq5Lzy2/CMKAJl2l2Yb8+HAvlCTeYAeGbMYPuR8CI0ZQWUgovC0QK
         h4CJXhFOSlGcMfm3h2uFrpOwVKYDEe+T1BPDkZeCH77RTl2f0+uBd9yoEm9u1yNtmTLc
         nB6A5u2fPZpabxGGUJe1AvH2v9qQ5eTAjiBTEhfoq8yPJfHbEUKcz14rXuYxogprQKtu
         /QaQ==
X-Gm-Message-State: AA+aEWZsRpJIZApZBH+NahnInWF76/LjWAXRDUO1CBIHEO6zQl6fXw0D
        og5z4WtiE9G/wy612DKFJ983FmMk
X-Google-Smtp-Source: AFSGD/Vc6faj79QCTrwyWTVmPW7Rrlkiqaqpxaze8d5ukhQQ12BRdtoY6SMIm/hNK+YTJY2iZmbu+w==
X-Received: by 2002:a63:557:: with SMTP id 84mr9772466pgf.411.1544997492766;
        Sun, 16 Dec 2018 13:58:12 -0800 (PST)
Received: from localhost.localdomain (cpe-23-241-199-231.socal.res.rr.com. [23.241.199.231])
        by smtp.gmail.com with ESMTPSA id k191sm12736056pgd.9.2018.12.16.13.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Dec 2018 13:58:12 -0800 (PST)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, rafa.almas@gmail.com, gitster@pobox.com,
        avarab@gmail.com, Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v3 2/3] branch: Mark and color a branch differently if it is checked out in a linked worktree
Date:   Sun, 16 Dec 2018 13:57:58 -0800
Message-Id: <20181216215759.24011-3-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20181216215759.24011-1-nbelakovski@gmail.com>
References: <20181111235831.44824-1-nbelakovski@gmail.com>
 <20181216215759.24011-1-nbelakovski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>

In order to more clearly display which branches are active, the output
of git branch is modified to mark branches checkout out in a linked
worktree with a "+" and color them in cyan (in contrast to the current
branch, which will still be denoted with a "*" and colored in green)

This is meant to simplify workflows related to worktree, particularly
due to the limitations of not being able to check out the same branch in
two worktrees and the inability to delete a branch checked out in a
worktree. When performing branch operations like checkout and delete, it
would be useful to know more readily if the branches in which the user
is interested are already checked out in a worktree.

The git worktree list command contains the relevant information, however
this is a much less frquently used command than git branch.
---
 builtin/branch.c         | 12 ++++++++----
 t/t3200-branch.sh        |  8 ++++----
 t/t3203-branch-output.sh | 21 +++++++++++++++++++++
 3 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0c55f7f065..2a24153b78 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -47,6 +47,7 @@ static char branch_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NORMAL,       /* LOCAL */
 	GIT_COLOR_GREEN,        /* CURRENT */
 	GIT_COLOR_BLUE,         /* UPSTREAM */
+	GIT_COLOR_CYAN,         /* WORKTREE */
 };
 enum color_branch {
 	BRANCH_COLOR_RESET = 0,
@@ -54,7 +55,8 @@ enum color_branch {
 	BRANCH_COLOR_REMOTE = 2,
 	BRANCH_COLOR_LOCAL = 3,
 	BRANCH_COLOR_CURRENT = 4,
-	BRANCH_COLOR_UPSTREAM = 5
+	BRANCH_COLOR_UPSTREAM = 5,
+	BRANCH_COLOR_WORKTREE = 6
 };
 
 static const char *color_branch_slots[] = {
@@ -64,6 +66,7 @@ static const char *color_branch_slots[] = {
 	[BRANCH_COLOR_LOCAL]	= "local",
 	[BRANCH_COLOR_CURRENT]	= "current",
 	[BRANCH_COLOR_UPSTREAM] = "upstream",
+	[BRANCH_COLOR_WORKTREE] = "worktree",
 };
 
 static struct string_list output = STRING_LIST_INIT_DUP;
@@ -342,9 +345,10 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
 	struct strbuf local = STRBUF_INIT;
 	struct strbuf remote = STRBUF_INIT;
 
-	strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %s%%(else)  %s%%(end)",
-		    branch_get_color(BRANCH_COLOR_CURRENT),
-		    branch_get_color(BRANCH_COLOR_LOCAL));
+	strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %s%%(else)%%(if)%%(worktreepath)%%(then)+ %s%%(else)  %s%%(end)%%(end)",
+			branch_get_color(BRANCH_COLOR_CURRENT),
+			branch_get_color(BRANCH_COLOR_WORKTREE),
+			branch_get_color(BRANCH_COLOR_LOCAL));
 	strbuf_addf(&remote, "  %s",
 		    branch_get_color(BRANCH_COLOR_REMOTE));
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 478b82cf9b..e404f6e23c 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -292,7 +292,7 @@ test_expect_success 'git branch --list -v with --abbrev' '
 test_expect_success 'git branch --column' '
 	COLUMNS=81 git branch --column=column >actual &&
 	cat >expected <<\EOF &&
-  a/b/c     bam       foo       l       * master    n         o/p       r
+  a/b/c   + bam       foo       l       * master    n         o/p       r
   abc       bar       j/k       m/m       master2   o/o       q
 EOF
 	test_cmp expected actual
@@ -307,7 +307,7 @@ test_expect_success 'git branch --column with an extremely long branch name' '
 	cat >expected <<EOF &&
   a/b/c
   abc
-  bam
++ bam
   bar
   foo
   j/k
@@ -332,7 +332,7 @@ test_expect_success 'git branch with column.*' '
 	git config --unset column.branch &&
 	git config --unset column.ui &&
 	cat >expected <<\EOF &&
-  a/b/c   bam   foo   l   * master    n     o/p   r
+  a/b/c + bam   foo   l   * master    n     o/p   r
   abc     bar   j/k   m/m   master2   o/o   q
 EOF
 	test_cmp expected actual
@@ -349,7 +349,7 @@ test_expect_success 'git branch -v with column.ui ignored' '
 	cat >expected <<\EOF &&
   a/b/c
   abc
-  bam
++ bam
   bar
   foo
   j/k
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index ee6787614c..94ab05ad59 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -240,6 +240,27 @@ test_expect_success 'git branch --format option' '
 	test_i18ncmp expect actual
 '
 
+test_expect_success '"add" a worktree' '
+	mkdir worktree_dir &&
+	git worktree add -b master_worktree worktree_dir master
+'
+
+cat >expect <<'EOF'
+* <GREEN>(HEAD detached from fromtag)<RESET>
+  ambiguous<RESET>
+  branch-one<RESET>
+  branch-two<RESET>
+  master<RESET>
++ <CYAN>master_worktree<RESET>
+  ref-to-branch<RESET> -> branch-one
+  ref-to-remote<RESET> -> origin/branch-one
+EOF
+test_expect_success TTY 'worktree colors correct' '
+	test_terminal git branch >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success "set up color tests" '
 	echo "<RED>master<RESET>" >expect.color &&
 	echo "master" >expect.bare &&
-- 
2.14.2

