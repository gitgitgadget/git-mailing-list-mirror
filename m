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
	by dcvr.yhbt.net (Postfix) with ESMTP id B1C771F454
	for <e@80x24.org>; Thu,  7 Nov 2019 18:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfKGSvu (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 13:51:50 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:47053 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfKGSvt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 13:51:49 -0500
Received: by mail-pl1-f195.google.com with SMTP id l4so2104816plt.13
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 10:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MRV2ZywY1gvncpNluWSVtjtjNJA88SGWi8emPfvjL8w=;
        b=I7/DK+Y5vU3iDT5UZ+1qhq0p7BcJTIsBeTGXjA4YHmM5HXpyV8zQiBwW0k3Egf8JCa
         7l6URagLay8tJpLcwhLeiwPpe/GLbMVfqYaYG9lPiJs8hOPJn1qWZwHGokitjj0NjUDN
         O6XokVY6hFKiHRZL8k5O6TONxe0pLzG8F1VfRTikGJxP0br2r1wx6pB25eBnv92yOZiH
         lTLdr1fRL39fWL8UcZw6wMJ7SwqLq/S2PLKQAa0lffkqQRqHsfLnv/+iQvmkSC863pea
         SKCD7PXI7lePl0xtaAujhSupG8+spzc6xdU7xMCxDjRqdGrwS55DOFd/w8tZPaZvboaL
         Y8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MRV2ZywY1gvncpNluWSVtjtjNJA88SGWi8emPfvjL8w=;
        b=fvoXwENfROCGHa4/5QsxJGYAgHeIGjsds5uQJdVZoRh7909fiWcJOC/DqOU1VIa2Nr
         erS5l/3Paubr0cgcwE3EVa8gpcx0biQGc3io81gEm0CbgsjZcH8uT6wWlq6YdNNcmwXb
         XJd0kzv9wV4Y0dSlXh94GymBWUayZgoWH+mbkJ+7nxZo2gG+FPX4d4qL9gP13gKSrlmI
         PQasGNISArch0svupaUAuHiBTEwfFKnOetxwd9B1A/YiAAAXUPR/UV4FQefppwKeeXNQ
         pGmYNuDZYSrf28AtlGa4pBMjNSDGauo/B2u1/HV4mlbJu091EioXCkET1pKt2YEWTcOP
         ANqg==
X-Gm-Message-State: APjAAAWWLOH3UC5kKOliKIoyPLKfWO9qSBnoONi+Ga4Yg3q1k6ugH30e
        BsFps4U7mF65YUElhXN+zySy/mU0
X-Google-Smtp-Source: APXvYqxBw+MXs9baahgQH6ZxEfd6oYRj5vjB/6xol0XtiBMzZg7/7iT3DFKLPnCaJEpoJG8NIi+QNw==
X-Received: by 2002:a17:90a:d152:: with SMTP id t18mr7163060pjw.119.1573152708683;
        Thu, 07 Nov 2019 10:51:48 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id c2sm3398599pfn.55.2019.11.07.10.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 10:51:48 -0800 (PST)
Date:   Thu, 7 Nov 2019 10:51:46 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 12/14] t5520: replace subshell cat comparison with test_cmp
Message-ID: <bb529ad84ac23ca9015d1b6b18b8804c83f6b93f.1573152599.git.liu.denton@gmail.com>
References: <cover.1571739459.git.liu.denton@gmail.com>
 <cover.1573152598.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573152598.git.liu.denton@gmail.com>
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
2.24.0.rc2.262.g2d07a97ef5

