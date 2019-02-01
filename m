Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D3381F453
	for <e@80x24.org>; Fri,  1 Feb 2019 22:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfBAWEe (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 17:04:34 -0500
Received: from mail-pf1-f171.google.com ([209.85.210.171]:34108 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfBAWEd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 17:04:33 -0500
Received: by mail-pf1-f171.google.com with SMTP id h3so3894101pfg.1
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 14:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=DgcsEEBQ7zqXoqZfk8dCwAjSesrHri9rmB3M150BI+E=;
        b=pXSI8AVONF9E+rvO1c/WsmK76SmbCvBYytxs9goHkkqBVwD8AF15bJjfWWcMeDT9vL
         xJLVNQjAdgLLFDo3flvyxr2oMoXnFTLHvcBVQQl6D/d6SpmLKwiQLgsVpI+4jjdAnIP/
         SBtOMwJF/uYAHANOb72/t84QU9cd0fKGHUlrZMEqZW6JipJzdeG24zHYVkLDCepeTPPj
         25C+fuf/OjNYR49G1Pv9WPtlQqphMehPPBgut6pBODotCFXRy5X+whtAwxMx4lzeGuoz
         qRlV9qRZY/5UXyZU7ZWks7ioHxP4/C8GebD/hQObjaLvbCOMdH8RW8w3q3fx0lcQCLky
         IS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=DgcsEEBQ7zqXoqZfk8dCwAjSesrHri9rmB3M150BI+E=;
        b=qmKVYk8wQ7B/nADaFREMPdr6qoKyJoP6rNtnkqEc+1hZ9CR5+0NVxvh6Rdk/TVgM/S
         2EyvXAvYU/csEpnLdYI/8aqOA+002nIwuRD4bJiE8Fl47cZ/sWDi3jzymeEYxZPry8ZZ
         KbEC9J6uJcK0UwFIwazv0PGTVVMVI2Pcn41KvEzATAYAt0UwpYn+8GhWrqyVhEs4w2WL
         nQ5m3zKOGytESNhp8ljXhoDz+u/35dlhG1ZS1oiU/n75zvJSCYHTbSXacj2FxaFYCash
         0bkyoWPXePwQjvjU0Js6/znrZklKy4MYAtEjWWxS3ZdoJnPH/LYZieZrI/P9rdkrAKja
         +Lnw==
X-Gm-Message-State: AJcUukccEMfp2635CYRs31hstcl8LRpsv1gR0TBHbs9Xp5sDgofE6yis
        tyuLNk8KWI4s2hpRSvBA+IOEcwGHrRA=
X-Google-Smtp-Source: ALg8bN6wkdDF+0AehklxFbN5upb5XEQ/Nq67jkIbP6/Nn+BlVVW7Vu4TI2Ohr611Ta3IMBnoti/4aQ==
X-Received: by 2002:a62:83ce:: with SMTP id h197mr40889696pfe.187.1549058671997;
        Fri, 01 Feb 2019 14:04:31 -0800 (PST)
Received: from localhost.localdomain (cpe-23-241-199-231.socal.res.rr.com. [23.241.199.231])
        by smtp.gmail.com with ESMTPSA id h128sm12131281pgc.15.2019.02.01.14.04.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Feb 2019 14:04:31 -0800 (PST)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, rafa.almas@gmail.com, gitster@pobox.com,
        avarab@gmail.com, Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v7 2/3] branch: Mark and color a branch differently if it is checked out in a linked worktree
Date:   Fri,  1 Feb 2019 14:04:19 -0800
Message-Id: <20190201220420.36216-3-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20190201220420.36216-1-nbelakovski@gmail.com>
References: <"<CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>">
 <20190201220420.36216-1-nbelakovski@gmail.com>
In-Reply-To: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>

The output of git branch is modified to mark branches checkout out in a
linked worktree with a "+" and color them in cyan (in contrast to the
current branch, which will still be denoted with a "*" and colored in green)

This is meant to communicate to the user that the branches that are
marked or colored will behave differently from other branches if the user
attempts to check them out or delete them, since branches checked out in
another worktree cannot be checked out or deleted.

Signed-off-by: Nickolai Belakovski <nbelakovski@gmail.com>
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
index 1be727209b..c2a86362bb 100644
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

