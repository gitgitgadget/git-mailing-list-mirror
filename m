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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A9841F461
	for <e@80x24.org>; Wed, 17 Jul 2019 14:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfGQOmK (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 10:42:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54492 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbfGQOmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 10:42:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id p74so22416807wme.4
        for <git@vger.kernel.org>; Wed, 17 Jul 2019 07:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zKSBIwbiUSn2bZIJ1EMlrqfHiGBPqFZIqAghIfHxVCY=;
        b=k4iqJJh/doJ3hMwQ1zI+Y8MlPn7wOXX8aXQb17yUhOqlsxEs/CDSYA/pwp36Eo9bhQ
         G5ZhqaUkES6NYS3L16WrOfNzpus0p34RThrAK0V5qyhZz09tXFqWDmxWBALJK3TmfNM7
         NWGCE4geJtzIXeEwDVoRxOMWJa9hYe8cq9RERMjZGHxBxHNHY7QJSx7LiR++Ww1QJiYW
         RtLTl5rNswmN0IrXnbdefJABy2qXW387SpBC4cK5YY3N/TIw1NXpFFrwElNg3GuPQ8uF
         hR8Ea021APY93DLO6Kb3OoPOTvNoeuq7O/ErLPB1QS8FbDOYrgO5F2OcolB10f+ySKX2
         U7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zKSBIwbiUSn2bZIJ1EMlrqfHiGBPqFZIqAghIfHxVCY=;
        b=pXf3daSHk5c34Zeomn+ekjODXcg41q7sEi32uebQsS3t6pnZuMTLd+8LrGBJM+4O9q
         ov3MxnG4G6P8H0sSftmDmYstZKY/kcjWi+3pY57v3Kh/P0XHdnBXy2wm4Zt/5UgQe0GD
         C+chviGLJcJDMuqXJYY94t3zyEDC/vwuUWBLhzjWqwf3Ue4LCk02mgGXZZNnvjw6IbiL
         /VU803vM/GTlxkZ5853nvk+7LRikx6dWZm7HUNryQ0Dinc3QRiyM3aQ604bCXD9Nu0rj
         JW0b6f+iGHJVh4xgJJ7c1nmJp1DLm+POsADVOtMcYqU9x7pPV3OOwmmm5sp3JzfM2qDq
         C3MQ==
X-Gm-Message-State: APjAAAXJD+eBwr63TX/zonbTamKvprUDB1XYk6QG286ClcaVZkSdnzRF
        bmPaGhfdGNsla7WWsyw6UFTEM6ka
X-Google-Smtp-Source: APXvYqwkCqjWIJGkhxdPBpVOGCauGy3KPdokPOqhmnPQvbzeftRPw/zeS5ds/mbmmR/LdE2yeOQGVQ==
X-Received: by 2002:a05:600c:2243:: with SMTP id a3mr35678995wmm.83.1563374527403;
        Wed, 17 Jul 2019 07:42:07 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-183-65.w86-199.abo.wanadoo.fr. [86.199.38.65])
        by smtp.googlemail.com with ESMTPSA id p18sm21815968wrm.16.2019.07.17.07.42.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 07:42:06 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH 9/9] sequencer: have read_populate_todo() check for dropped commits
Date:   Wed, 17 Jul 2019 16:39:18 +0200
Message-Id: <20190717143918.7406-10-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190717143918.7406-1-alban.gruin@gmail.com>
References: <20190717143918.7406-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds the ability to check if commits were dropped when resuming a
rebase (with `--continue') or when reloading the todo list after an
`exec' command.

Tests added previously should work now.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c                   | 5 ++++-
 t/t3404-rebase-interactive.sh | 4 ++--
 t/t3429-rebase-edit-todo.sh   | 4 ++--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0638c92f12..d2c4459e7c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2360,7 +2360,6 @@ static int read_populate_todo(struct repository *r,
 	struct stat st;
 	const char *todo_file = get_todo_path(opts);
 	int res;
-
 	strbuf_reset(&todo_list->buf);
 	if (strbuf_read_file_or_whine(&todo_list->buf, todo_file) < 0)
 		return -1;
@@ -2378,6 +2377,10 @@ static int read_populate_todo(struct repository *r,
 		return error(_("unusable instruction sheet: '%s'"), todo_file);
 	}
 
+	res = todo_list_check_against_backup(r, todo_list);
+	if (res)
+		return -1;
+
 	if (!todo_list->nr &&
 	    (!is_rebase_i(opts) || !file_exists(rebase_path_done())))
 		return error(_("no commits parsed."));
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f5c0a8d2bb..090a496bcc 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1373,7 +1373,7 @@ EOF
 
 tail -n 8 <expect >expect.2
 
-test_expect_failure 'rebase --edit-todo respects rebase.missingCommitsCheck = warn' '
+test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = warn' '
 	test_config rebase.missingCommitsCheck warn &&
 	rebase_setup_and_clean missing-commit &&
 	set_fake_editor &&
@@ -1405,7 +1405,7 @@ EOF
 
 tail -n 9 <expect >expect.2
 
-test_expect_failure 'rebase --edit-todo respects rebase.missingCommitsCheck = error' '
+test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = error' '
 	test_config rebase.missingCommitsCheck error &&
 	rebase_setup_and_clean missing-commit &&
 	set_fake_editor &&
diff --git a/t/t3429-rebase-edit-todo.sh b/t/t3429-rebase-edit-todo.sh
index 2bb9fb65fa..79cd5657b3 100755
--- a/t/t3429-rebase-edit-todo.sh
+++ b/t/t3429-rebase-edit-todo.sh
@@ -50,7 +50,7 @@ Use 'git config rebase.missingCommitsCheck' to change the level of warnings.
 The possible behaviours are: ignore, warn, error.
 EOF
 
-test_expect_failure 'rebase exec respects rebase.missingCommitsCheck = warn' '
+test_expect_success 'rebase exec respects rebase.missingCommitsCheck = warn' '
 	test_config rebase.missingCommitsCheck warn &&
 	git reset --hard HEAD@{2} &&
 	git rebase HEAD~2 --keep-empty -x "echo >$todo" 2>actual.2 &&
@@ -59,7 +59,7 @@ test_expect_failure 'rebase exec respects rebase.missingCommitsCheck = warn' '
 	test 5 = $(git cat-file commit HEAD | sed -ne \$p)
 '
 
-test_expect_failure 'rebase exec respects rebase.missingCommitsCheck = error' '
+test_expect_success 'rebase exec respects rebase.missingCommitsCheck = error' '
 	test_config rebase.missingCommitsCheck error &&
 	git reset --hard HEAD@{2} &&
 	test_must_fail git rebase HEAD~2 --keep-empty -x "echo >$todo" 2>actual.2 &&
-- 
2.22.0

