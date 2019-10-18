Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF8271F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 22:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390822AbfJRWKy (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 18:10:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42940 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390784AbfJRWKx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 18:10:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id f14so4068159pgi.9
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 15:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JFj037VppACIW60EHUgaVAhKbhf9QHZDzfY/bCKf8EA=;
        b=SqwaAmGhd8Ktxd05KAono/fcu5jhjNiiLkzUoKsBs7AsGgJ9JBP1WIH2EdJRKeDS74
         JH0zz+Ro6CKM/E2ki8j8zriXoNYzWPuNFA9OTCC15qWjFSKuEMdLQSD1GuDFz3PwB8JK
         R4jLcZfWTtI6/ar+lAqHFrY3Nc+vYV+MYpI6go5o+sVboWB2UXmdtW3E/30IANldM7p5
         rLiiIcfDA8GTDCbAbVNIM1NqDPRn6MqiiD+oNKeuFc3vbJ703rqzqJDZaWud0NJ9+I9x
         poT7pi2GRxSPa0thxTrDa5rB+ef6OHZZbHjRpBnbuc5sMsQY1Us7PhxDIJF8Z+QNqI6Z
         bbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JFj037VppACIW60EHUgaVAhKbhf9QHZDzfY/bCKf8EA=;
        b=M9HSG0xepI0V3IpUILX9znEWvp0XqMbCoGpnwbbVgY4K4Qbhr+vHD5UetbkOAaGTRr
         Siy3SUNlA0qBrnqwSLvhkehGOVQbLl+SaMvvf6axMChg+C2nUjLLUOt4TIPgdW3vTTSB
         TZo11zgrUUxf72/ML4pWeHNmG7Nf/fFIRjlISlcwed6+J7vQmVoaenrG+AkYWPC63NYS
         9L6hSKIEluUJ5P8Dt1EEyMSRJ3E71/lD/YEQiigOExLFMLW4yY9fZk6WfepPx86blvuk
         6nkg3NzTgI/JOSLJ+oQenuDTG4Q7xhpqLsvAVXY3npk0qU6TkFmH6JIlCkIEygU/qE++
         2mOg==
X-Gm-Message-State: APjAAAXrK9rZftreZ3HdGbVv7mT1TXIkjEsWfmDOiWLvCNx0TzaYxTOh
        ETVmjABFiu4gRmRHamlFouN2moo3
X-Google-Smtp-Source: APXvYqymRQo32JoiGPEa53XlD7D4iaK6zuuaC7ezNPlV64QojWRA8eP3iMgYB62DLgPL5k9kuByTGw==
X-Received: by 2002:a17:90a:ff0f:: with SMTP id ce15mr14235025pjb.14.1571436652498;
        Fri, 18 Oct 2019 15:10:52 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id f13sm7122974pgr.6.2019.10.18.15.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 15:10:51 -0700 (PDT)
Date:   Fri, 18 Oct 2019 15:10:50 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 13/15] t5520: replace subshell cat comparison with test_cmp
Message-ID: <b2d0ce21c8cd5fa3e2eb7003a9c56b2289cb5de4.1571435195.git.liu.denton@gmail.com>
References: <cover.1571354136.git.liu.denton@gmail.com>
 <cover.1571435195.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571435195.git.liu.denton@gmail.com>
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
2.23.0.897.g0a19638b1e

