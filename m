Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 958C7211B4
	for <e@80x24.org>; Sun,  6 Jan 2019 00:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfAFA0d (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Jan 2019 19:26:33 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44688 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfAFA0c (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jan 2019 19:26:32 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so20032625pfh.11
        for <git@vger.kernel.org>; Sat, 05 Jan 2019 16:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=AOKP/w1CtgQPV1B9uxhMuHW1hETCGi+cuoWRGM4z+C4=;
        b=LjK/K+H0wIUN2KPAItwJ6S4LN2nn0ekUYS8r7e6bZT9Zy8yhu84RjBgi9PJYeCJOVs
         /CqKSuuJ78RfJI8pGTw9PnlgZBjoTLhKjdzrPG4ibsg4U3MHhQGA+D8hzXO4gg19TCFj
         ecKQYvcXtykDTzlV/Ml+zuSMCblibbfqFmfD8xFwxsGT/gz+XFHcMCEUnYFBO4OZGmBV
         bdaHCXcJqcZQ8tjlgSqyzGV3VAcJmGifs6FZYjP/Pl7UP5+aQSFinynnUxZ2DeO4S4BL
         l9mybRnZZAywSHgfQiAAXVpWnOamFJtrH580Q65q1T4IYqBg1PeSQYLPul3gwiho5p6f
         0EUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=AOKP/w1CtgQPV1B9uxhMuHW1hETCGi+cuoWRGM4z+C4=;
        b=LszrQl37+EgStEScB+ArHmKf3dtqT1TR8WNm3cHTebhZBkN/ViXfvzR8FJjBqvmnp0
         Xt2mF0//qAxanu+lSmr7X3USZa+krA0DrJDolScVb4o38g/ORps5z9A0dA7TTRe6+Rfj
         goZpHjDomrZGHQO+T/wIo5sDuczwhUtgF5j4KOTlOC/IzueTvpU5Gk0jSRlxBWFT1ocL
         E39scWdLC+BHmTzeeqCVZZBXISE/UnOQ21BeJarf8l67xDA8Q0siNd36vb6tuqLq9R9h
         5g1OLehZHLTJpymIW1pTvrntQC4tuCXoZZULyN/RRetx+dncvcnDYihCM+bvtZt8R5Q7
         KaLA==
X-Gm-Message-State: AJcUukcTs7ZYUrGf+C7u95U8gSDK3B/2qJTlUgbUL3HySYVAT6ISD/Sl
        TZReIOvDb4xlv4Df9jVkpgQE5XtK
X-Google-Smtp-Source: AFSGD/XV9cDnWZr6TBJ9qKNwWzyf13XzcUpKNeZqIDU7JogoS5fk3MsMIyKuUizF5S24lBlPIkduRA==
X-Received: by 2002:a62:868b:: with SMTP id x133mr60827661pfd.252.1546734391596;
        Sat, 05 Jan 2019 16:26:31 -0800 (PST)
Received: from localhost.localdomain (cpe-23-241-199-231.socal.res.rr.com. [23.241.199.231])
        by smtp.gmail.com with ESMTPSA id e16sm85376485pfn.46.2019.01.05.16.26.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 05 Jan 2019 16:26:31 -0800 (PST)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, rafa.almas@gmail.com, gitster@pobox.com,
        avarab@gmail.com, Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v5 2/3] branch: Mark and color a branch differently if it is checked out in a linked worktree
Date:   Sat,  5 Jan 2019 16:26:18 -0800
Message-Id: <20190106002619.54741-3-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20190106002619.54741-1-nbelakovski@gmail.com>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190106002619.54741-1-nbelakovski@gmail.com>
In-Reply-To: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
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
 Documentation/git-branch.txt | 15 ++++++++-------
 builtin/branch.c             | 12 ++++++++----
 t/t3200-branch.sh            |  8 ++++----
 t/t3203-branch-output.sh     | 21 +++++++++++++++++++++
 4 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index bf5316ffa9..b3eca6ffdc 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -26,13 +26,14 @@ DESCRIPTION
 -----------
 
 If `--list` is given, or if there are no non-option arguments, existing
-branches are listed; the current branch will be highlighted with an
-asterisk.  Option `-r` causes the remote-tracking branches to be listed,
-and option `-a` shows both local and remote branches. If a `<pattern>`
-is given, it is used as a shell wildcard to restrict the output to
-matching branches. If multiple patterns are given, a branch is shown if
-it matches any of the patterns.  Note that when providing a
-`<pattern>`, you must use `--list`; otherwise the command is interpreted
+branches are listed; the current branch will be highlighted in green and
+marked with an asterisk.  Any branches checked out in linked worktrees will
+be highlighted in cyan and marked with a plus sign. Option `-r` causes the
+remote-tracking branches to be listed, and option `-a` shows both local and
+remote branches. If a `<pattern>` is given, it is used as a shell wildcard to
+restrict the output to matching branches. If multiple patterns are given, a
+branch is shown if it matches any of the patterns.  Note that when providing
+a `<pattern>`, you must use `--list`; otherwise the command is interpreted
 as branch creation.
 
 With `--contains`, shows only the branches that contain the named commit
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

