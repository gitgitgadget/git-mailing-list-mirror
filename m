Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A19D01F461
	for <e@80x24.org>; Wed, 17 Jul 2019 14:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfGQOl5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 10:41:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41107 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfGQOl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 10:41:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so21916736wrm.8
        for <git@vger.kernel.org>; Wed, 17 Jul 2019 07:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8bAEYP/5Ony482hTu/GBgV0DIOKx0kU7we/oqdgMykQ=;
        b=EE4UVeXyZNjuL5CxfQlILrJQ3oUSzjvVSMkZ5GdSXgwpAWuccpkIU/HzCpCnM9DQKj
         /GK/TbZ6tserZxG8kldv1Z5DdENVzLf1EWkaHIVvWsXLfK1dkZ23UQst23FqKJSG2Wj3
         WtT7aMftLG81ceufr9zprqoCXTOj0TeE0kguz2moXR2zTrGPg1IDxhejYXQ0IfkoW6Id
         dqMTCBT3BMg7Y9EdxsvcuU6kSiV3zXoCloRPeIAw5QHv9pjRZkb2x3izXWNFcRhGirn1
         MndqFSL+9yFp5zanXYCTeALjFgUuq0uvtFubguVs+fsRKcPmDupaf5Ze754hjctq1iVt
         kBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8bAEYP/5Ony482hTu/GBgV0DIOKx0kU7we/oqdgMykQ=;
        b=r1r5YY6ARj12XEmGs7LJGp14VKKuXshkiyJmtwOmj+ej7RuYHGEywNqUHA/GOWu42j
         3Ep4tgAkuXaZM/G+r7pitrzZlvM5n9WmOQBPHD07t49sdW60wr/mMfQORjbsMyUQHwYK
         eW2FX/Uej2z7x/dkhySpypT/Iom/gd6RuhFXNb1dkrn5GO0KuoU/q8/EilASP41Pc4O6
         zPOGrWAbh00QYPXIeM08DIObnmmf68LoFIg8Lul6inC/qW/T0j0Bo9khyqkTmTaVXG0C
         I8+PaTLkGqCJO17hGY+GFoKI0Aw2cDEWDi1W6pHcriLFf7IvP1ilf6U23oyoC/Cq2PVa
         yBPQ==
X-Gm-Message-State: APjAAAWz/iif+dOmX+tbfupltxEo8tZ/okUZyL+C3RybcQ8ZG+Tb3bLx
        /ib1V9PMG6PWqLlaNmtloXp6kqR5
X-Google-Smtp-Source: APXvYqwNFRdAhWpmLffHdqal5UsbKS0fH7ObZ8gXdANpJ3C7kPC0PZwDzPvspqGx7gsHh7LY6hCymA==
X-Received: by 2002:a5d:63c9:: with SMTP id c9mr7245359wrw.15.1563374515210;
        Wed, 17 Jul 2019 07:41:55 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-183-65.w86-199.abo.wanadoo.fr. [86.199.38.65])
        by smtp.googlemail.com with ESMTPSA id p18sm21815968wrm.16.2019.07.17.07.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 07:41:54 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH 2/9] t3429: demonstrate that rebase exec does not check for dropped commits
Date:   Wed, 17 Jul 2019 16:39:11 +0200
Message-Id: <20190717143918.7406-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190717143918.7406-1-alban.gruin@gmail.com>
References: <20190717143918.7406-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After executing a command, rebase reloads the todo list from the disk,
in case the script has modified it, but does not honour
rebase.missingCommitsCheck.

This adds three tests to t3429 to demonstrate this.  The first one is
not broken, as when `rebase.missingCommitsCheck' is not set, nothing
should be done for dropped commits.  The last two are, demonstrating the
problem.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 t/t3429-rebase-edit-todo.sh | 44 +++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/t/t3429-rebase-edit-todo.sh b/t/t3429-rebase-edit-todo.sh
index 76f6d306ea..2bb9fb65fa 100755
--- a/t/t3429-rebase-edit-todo.sh
+++ b/t/t3429-rebase-edit-todo.sh
@@ -4,15 +4,16 @@ test_description='rebase should reread the todo file if an exec modifies it'
 
 . ./test-lib.sh
 
+todo=.git/rebase-merge/git-rebase-todo
+
 test_expect_success 'rebase exec modifies rebase-todo' '
 	test_commit initial &&
-	todo=.git/rebase-merge/git-rebase-todo &&
 	git rebase HEAD -x "echo exec touch F >>$todo" &&
 	test -e F
 '
 
 test_expect_success SHA1 'loose object cache vs re-reading todo list' '
-	GIT_REBASE_TODO=.git/rebase-merge/git-rebase-todo &&
+	GIT_REBASE_TODO=$todo &&
 	export GIT_REBASE_TODO &&
 	write_script append-todo.sh <<-\EOS &&
 	# For values 5 and 6, this yields SHA-1s with the same first two digits
@@ -33,4 +34,43 @@ test_expect_success SHA1 'loose object cache vs re-reading todo list' '
 	git rebase HEAD -x "./append-todo.sh 5 6"
 '
 
+test_expect_success 'rebase exec respects rebase.missingCommitsCheck = ignore' '
+	test_config rebase.missingCommitsCheck ignore &&
+	git rebase HEAD~2 --keep-empty -x "echo >$todo" &&
+	test 5 = $(git cat-file commit HEAD | sed -ne \$p)
+'
+
+cat >expect <<EOF
+Warning: some commits may have been dropped accidentally.
+Dropped commits (newer to older):
+ - $(git rev-list --pretty=oneline --abbrev-commit -1 HEAD@{2})
+To avoid this message, use "drop" to explicitly remove a commit.
+
+Use 'git config rebase.missingCommitsCheck' to change the level of warnings.
+The possible behaviours are: ignore, warn, error.
+EOF
+
+test_expect_failure 'rebase exec respects rebase.missingCommitsCheck = warn' '
+	test_config rebase.missingCommitsCheck warn &&
+	git reset --hard HEAD@{2} &&
+	git rebase HEAD~2 --keep-empty -x "echo >$todo" 2>actual.2 &&
+	head -n8 actual.2 | tail -n7 >actual &&
+	test_i18ncmp expect actual &&
+	test 5 = $(git cat-file commit HEAD | sed -ne \$p)
+'
+
+test_expect_failure 'rebase exec respects rebase.missingCommitsCheck = error' '
+	test_config rebase.missingCommitsCheck error &&
+	git reset --hard HEAD@{2} &&
+	test_must_fail git rebase HEAD~2 --keep-empty -x "echo >$todo" 2>actual.2 &&
+	head -n8 actual.2 | tail -n7 >actual &&
+	test_i18ncmp expect actual &&
+	echo drop $(git rev-list --pretty=oneline -1 HEAD@{1}) >$todo &&
+	git rebase --continue 2>actual &&
+	test 5 = $(git cat-file commit HEAD | sed -ne \$p) &&
+	test_i18ngrep \
+		"Successfully rebased and updated refs/heads/master" \
+		actual
+'
+
 test_done
-- 
2.22.0

