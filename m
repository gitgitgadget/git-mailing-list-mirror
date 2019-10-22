Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1C1B1F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 10:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbfJVKU2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 06:20:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43313 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfJVKU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 06:20:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id a2so10360566pfo.10
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 03:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M9Hfm7uzFXViHISjTnjItbxuE130vBvXPRHVPtuj7yk=;
        b=GwqX2ngBL2uFq8GRkdA4C8pFGBs4wiTRC/kcVNYxeM5ZjQnnYq40vhS66EGlxsH+NE
         wfjECN4qKGFuDK2/WvLUMjS3tvAMHTbefIE/LDhKCig0ir/4iC0LmIGf8nPRVJbWourX
         vx7E6tzlUzAYsPyMZHPX4KfPtzfIBQ+1QS6hPILlXerCCPfelhtjgf02QMpi/67qOhf0
         vjM0Nn33PYGgiK8XQriQys0wLy5G89PtDaB1g67BXyyNJckyv4+iuV42+0iBPrPFv0zE
         zkLoNwwDbgojnK+z3U05vRVrMV3u+/IjLtBaQP/XzkmjccSKisKOIDiIVv0S4/C8Mei4
         7T3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M9Hfm7uzFXViHISjTnjItbxuE130vBvXPRHVPtuj7yk=;
        b=racjVLkfDBIc3vzbaDOzeJMUBxtdvG73tbqGu6NO+Ia8xe/XWMr2FkEoFhxuiTaJho
         7QrRmS1UXkngndGZhgwlJ5WVq1ZnCYc7UtocFds/Scr1+JqJHHF38GBC4EiHC4ZmcjP4
         gLSiCNfEjTflYjyxfONxvcEtScGoLqlm9gigxLEizFIbNfGsh/hmN4DPzA+WHtXSY4gq
         pZ1ci53DHVscnIw5iSUyd4pyF14GoUBaHUDECaNhhoAmIETGy7xWAO3Cm2HMCKQy0GxC
         5ywQcygUy55Sbh0VoGaow/hYFJiRLQNStxRjttNG/9E9TV2yTtWP3fllD204F/Y/0deC
         YyYQ==
X-Gm-Message-State: APjAAAV/Bdvy+lPTnxMFjiWomL1NTdYG49MpkXwyeoStZhetCxJ5bEU0
        PqljpIaEL7TTUIaAssTmR1LogSF7
X-Google-Smtp-Source: APXvYqwKEzC0+IE+B1Zz4lWn0zt60rIhfh5synKD0ihaRlOUhtRCMlxz7Q7bOzxJXxjy/fYSQT8hbg==
X-Received: by 2002:a63:4625:: with SMTP id t37mr2904612pga.261.1571739626885;
        Tue, 22 Oct 2019 03:20:26 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id v68sm18935943pfv.47.2019.10.22.03.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 03:20:26 -0700 (PDT)
Date:   Tue, 22 Oct 2019 03:20:24 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 12/14] t5520: replace subshell cat comparison with test_cmp
Message-ID: <e9d50b8bb07ad3522e1b84e77d149785a6a5fa92.1571739459.git.liu.denton@gmail.com>
References: <cover.1571435195.git.liu.denton@gmail.com>
 <cover.1571739459.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571739459.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We currently have many instances of `test <line> = $(cat <file>)` and
`test $(cat <file>) = <line>`.  In the case where this fails, it will be
difficult for a developer to debug since the output will be masked.
Replace these instances with invocations of test_cmp().

This change was done with the following GNU sed expressions:

	s/\(\s*\)test \([^=]*\)= "$(cat \([^)]*\))"/\1echo \2>expect \&\&\n\1test_cmp expect \3/
	s/\(\s*\)test "$(cat \([^)]*\))" = \([^&]*\)\( &&\)\?$/\1echo \3 >expect \&\&\n\1test_cmp expect \2\4/

A future patch will clean up situations where we have multiple duplicate
statements within a test case. This is done to keep this patch purely
mechanical.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 105 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 70 insertions(+), 35 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 8ddf89e550..c9e4eec004 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -15,8 +15,10 @@ test_pull_autostash () {
 	git add new_file &&
 	git pull "$@" . copy &&
 	test_cmp_rev HEAD^ copy &&
-	test "$(cat new_file)" = dirty &&
-	test "$(cat file)" = "modified again"
+	echo dirty >expect &&
+	test_cmp expect new_file &&
+	echo "modified again" >expect &&
+	test_cmp expect file
 }
 
 test_pull_autostash_fail () {
@@ -110,9 +112,11 @@ test_expect_success 'test . as a remote' '
 	echo updated >file &&
 	git commit -a -m updated &&
 	git checkout copy &&
-	test "$(cat file)" = file &&
+	echo file >expect &&
+	test_cmp expect file &&
 	git pull &&
-	test "$(cat file)" = updated &&
+	echo updated >expect &&
+	test_cmp expect file &&
 	git reflog -1 >reflog.actual &&
 	sed "s/^[0-9a-f][0-9a-f]*/OBJID/" reflog.actual >reflog.fuzzy &&
 	echo "OBJID HEAD@{0}: pull: Fast-forward" >reflog.expected &&
@@ -125,9 +129,11 @@ test_expect_success 'the default remote . should not break explicit pull' '
 	git commit -a -m modified &&
 	git checkout copy &&
 	git reset --hard HEAD^ &&
-	test "$(cat file)" = file &&
+	echo file >expect &&
+	test_cmp expect file &&
 	git pull . second &&
-	test "$(cat file)" = modified &&
+	echo modified >expect &&
+	test_cmp expect file &&
 	git reflog -1 >reflog.actual &&
 	sed "s/^[0-9a-f][0-9a-f]*/OBJID/" reflog.actual >reflog.fuzzy &&
 	echo "OBJID HEAD@{0}: pull . second: Fast-forward" >reflog.expected &&
@@ -137,10 +143,12 @@ test_expect_success 'the default remote . should not break explicit pull' '
 test_expect_success 'fail if wildcard spec does not match any refs' '
 	git checkout -b test copy^ &&
 	test_when_finished "git checkout -f copy && git branch -D test" &&
-	test "$(cat file)" = file &&
+	echo file >expect &&
+	test_cmp expect file &&
 	test_must_fail git pull . "refs/nonexisting1/*:refs/nonexisting2/*" 2>err &&
 	test_i18ngrep "no candidates for merging" err &&
-	test "$(cat file)" = file
+	echo file >expect &&
+	test_cmp expect file
 '
 
 test_expect_success 'fail if no branches specified with non-default remote' '
@@ -148,11 +156,13 @@ test_expect_success 'fail if no branches specified with non-default remote' '
 	test_when_finished "git remote remove test_remote" &&
 	git checkout -b test copy^ &&
 	test_when_finished "git checkout -f copy && git branch -D test" &&
-	test "$(cat file)" = file &&
+	echo file >expect &&
+	test_cmp expect file &&
 	test_config branch.test.remote origin &&
 	test_must_fail git pull test_remote 2>err &&
 	test_i18ngrep "specify a branch on the command line" err &&
-	test "$(cat file)" = file
+	echo file >expect &&
+	test_cmp expect file
 '
 
 test_expect_success 'fail if not on a branch' '
@@ -160,10 +170,12 @@ test_expect_success 'fail if not on a branch' '
 	test_when_finished "git remote remove origin" &&
 	git checkout HEAD^ &&
 	test_when_finished "git checkout -f copy" &&
-	test "$(cat file)" = file &&
+	echo file >expect &&
+	test_cmp expect file &&
 	test_must_fail git pull 2>err &&
 	test_i18ngrep "not currently on a branch" err &&
-	test "$(cat file)" = file
+	echo file >expect &&
+	test_cmp expect file
 '
 
 test_expect_success 'fail if no configuration for current branch' '
@@ -172,10 +184,12 @@ test_expect_success 'fail if no configuration for current branch' '
 	git checkout -b test copy^ &&
 	test_when_finished "git checkout -f copy && git branch -D test" &&
 	test_config branch.test.remote test_remote &&
-	test "$(cat file)" = file &&
+	echo file >expect &&
+	test_cmp expect file &&
 	test_must_fail git pull 2>err &&
 	test_i18ngrep "no tracking information" err &&
-	test "$(cat file)" = file
+	echo file >expect &&
+	test_cmp expect file
 '
 
 test_expect_success 'pull --all: fail if no configuration for current branch' '
@@ -184,10 +198,12 @@ test_expect_success 'pull --all: fail if no configuration for current branch' '
 	git checkout -b test copy^ &&
 	test_when_finished "git checkout -f copy && git branch -D test" &&
 	test_config branch.test.remote test_remote &&
-	test "$(cat file)" = file &&
+	echo file >expect &&
+	test_cmp expect file &&
 	test_must_fail git pull --all 2>err &&
 	test_i18ngrep "There is no tracking information" err &&
-	test "$(cat file)" = file
+	echo file >expect &&
+	test_cmp expect file
 '
 
 test_expect_success 'fail if upstream branch does not exist' '
@@ -195,16 +211,19 @@ test_expect_success 'fail if upstream branch does not exist' '
 	test_when_finished "git checkout -f copy && git branch -D test" &&
 	test_config branch.test.remote . &&
 	test_config branch.test.merge refs/heads/nonexisting &&
-	test "$(cat file)" = file &&
+	echo file >expect &&
+	test_cmp expect file &&
 	test_must_fail git pull 2>err &&
 	test_i18ngrep "no such ref was fetched" err &&
-	test "$(cat file)" = file
+	echo file >expect &&
+	test_cmp expect file
 '
 
 test_expect_success 'fail if the index has unresolved entries' '
 	git checkout -b third second^ &&
 	test_when_finished "git checkout -f copy && git branch -D third" &&
-	test "$(cat file)" = file &&
+	echo file >expect &&
+	test_cmp expect file &&
 	test_commit modified2 file &&
 	git ls-files -u >unmerged &&
 	test_must_be_empty unmerged &&
@@ -226,21 +245,25 @@ test_expect_success 'fail if the index has unresolved entries' '
 test_expect_success 'fast-forwards working tree if branch head is updated' '
 	git checkout -b third second^ &&
 	test_when_finished "git checkout -f copy && git branch -D third" &&
-	test "$(cat file)" = file &&
+	echo file >expect &&
+	test_cmp expect file &&
 	git pull . second:third 2>err &&
 	test_i18ngrep "fetch updated the current branch head" err &&
-	test "$(cat file)" = modified &&
+	echo modified >expect &&
+	test_cmp expect file &&
 	test_cmp_rev third second
 '
 
 test_expect_success 'fast-forward fails with conflicting work tree' '
 	git checkout -b third second^ &&
 	test_when_finished "git checkout -f copy && git branch -D third" &&
-	test "$(cat file)" = file &&
+	echo file >expect &&
+	test_cmp expect file &&
 	echo conflict >file &&
 	test_must_fail git pull . second:third 2>err &&
 	test_i18ngrep "Cannot fast-forward your working tree" err &&
-	test "$(cat file)" = conflict &&
+	echo conflict >expect &&
+	test_cmp expect file &&
 	test_cmp_rev third second
 '
 
@@ -501,7 +524,8 @@ test_expect_success 'pull.rebase=interactive' '
 	test_set_editor "$TRASH_DIRECTORY/fake-editor" &&
 	test_when_finished "test_might_fail git rebase --abort" &&
 	test_must_fail git pull --rebase=interactive . copy &&
-	test "I was here" = "$(cat fake.out)"
+	echo "I was here" >expect &&
+	test_cmp expect fake.out
 '
 
 test_expect_success 'pull --rebase=i' '
@@ -512,7 +536,8 @@ test_expect_success 'pull --rebase=i' '
 	test_set_editor "$TRASH_DIRECTORY/fake-editor" &&
 	test_when_finished "test_might_fail git rebase --abort" &&
 	test_must_fail git pull --rebase=i . copy &&
-	test "I was here, too" = "$(cat fake.out)"
+	echo "I was here, too" >expect &&
+	test_cmp expect fake.out
 '
 
 test_expect_success 'pull.rebase=invalid fails' '
@@ -578,16 +603,20 @@ test_expect_success '--rebase with rebased upstream' '
 	git commit -m to-rebase file2 &&
 	git tag to-rebase-orig &&
 	git pull --rebase me copy &&
-	test "conflicting modification" = "$(cat file)" &&
-	test file = "$(cat file2)"
+	echo "conflicting modification" >expect &&
+	test_cmp expect file &&
+	echo file >expect &&
+	test_cmp expect file2
 '
 
 test_expect_success '--rebase -f with rebased upstream' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git reset --hard to-rebase-orig &&
 	git pull --rebase -f me copy &&
-	test "conflicting modification" = "$(cat file)" &&
-	test file = "$(cat file2)"
+	echo "conflicting modification" >expect &&
+	test_cmp expect file &&
+	echo file >expect &&
+	test_cmp expect file2
 '
 
 test_expect_success '--rebase with rebased default upstream' '
@@ -595,8 +624,10 @@ test_expect_success '--rebase with rebased default upstream' '
 	git checkout --track -b to-rebase2 me/copy &&
 	git reset --hard to-rebase-orig &&
 	git pull --rebase &&
-	test "conflicting modification" = "$(cat file)" &&
-	test file = "$(cat file2)"
+	echo "conflicting modification" >expect &&
+	test_cmp expect file &&
+	echo file >expect &&
+	test_cmp expect file2
 '
 
 test_expect_success 'rebased upstream + fetch + pull --rebase' '
@@ -607,8 +638,10 @@ test_expect_success 'rebased upstream + fetch + pull --rebase' '
 	git reset --hard to-rebase-orig &&
 	git fetch &&
 	git pull --rebase &&
-	test "conflicting modification" = "$(cat file)" &&
-	test file = "$(cat file2)"
+	echo "conflicting modification" >expect &&
+	test_cmp expect file &&
+	echo file >expect &&
+	test_cmp expect file2
 
 '
 
@@ -744,8 +777,10 @@ test_expect_success 'git pull --rebase does not reapply old patches' '
 test_expect_success 'git pull --rebase against local branch' '
 	git checkout -b copy2 to-rebase-orig &&
 	git pull --rebase . to-rebase &&
-	test "conflicting modification" = "$(cat file)" &&
-	test file = "$(cat file2)"
+	echo "conflicting modification" >expect &&
+	test_cmp expect file &&
+	echo file >expect &&
+	test_cmp expect file2
 '
 
 test_done
-- 
2.24.0.rc0.197.g0926ab8072

