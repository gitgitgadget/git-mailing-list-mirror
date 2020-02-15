Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9CCC71150
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F636217F4
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uWsINMaZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgBOVgy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 16:36:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34631 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgBOVgw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 16:36:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id s144so4539931wme.1
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 13:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Nw0eSS2rjMRKATbtO4rQNZMP69QdvpcLcVkJ5jxheAM=;
        b=uWsINMaZ4d5Sg1RupDxZDYB6PsRxwDtaTWN5JCHv7EVyp8+WfE9hzWvQ4OhY1DZ9In
         WEMWYR7SdpfLNE3ct8cHxu1n354Hz9gUWkpc8HpgaVIo3S6FoH/ScG90Nk+RZq0UcXPq
         +H6ZEl9VYijejYx86nXhwQOSgdkXVfVPa+MJxSBMbzt5eBcUZNyt9OvDTf28809AmY0H
         TC8l6xx4vOXL7kVmEgYN36wn8Rg9oGHWBhGJ9GBv4/7NG3mThktTpnZ1lM66ZdJ8AqDE
         +RLvOebNvK1WdFH8rb7B1MOBWjf+iBGgZylZMB+YrCML/663vqn+gD/pt3GWE9k1SAKp
         MIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Nw0eSS2rjMRKATbtO4rQNZMP69QdvpcLcVkJ5jxheAM=;
        b=jxyfatjkOFzI42/abijBh3XRy2KVC3xsAwE86sD9Zww3xJ7PYlV2ATF/rBpiKYH6nG
         7CM2ephbcfUDyPUl7ZNhiZxMeX2s3wyXt2qI58gF/25zKVJnU3vbd1pkACvxRywaxnq7
         vBSnKcT3s7ykYNCMJrCFUh/Md8wYRHkKPLyjWOMW5/SlSCtio8J3piY2t5OZhRHTQaay
         3pU9cLWqYuiOfOC5O0SoPYElUPARxmWXEwnHr+5sWT/5G8yPzqtlPLR2tuXjt90rq77U
         dAW2Z2hd6lb+7/ALx7a7k2kSsfq4Zdg3JLAZCANMyMF/LVFCl3Z05o86lWGWDgwm4M6Z
         YNDQ==
X-Gm-Message-State: APjAAAWRXelV6ugcrTtKomM7b516PFJo91Igu7Z4SYyBw1xm2IEhWNAv
        QkwikAjqi1x3+ssAsoztmWhxC4p5
X-Google-Smtp-Source: APXvYqzE8FLrwi3DyfOPhtxpVhu8s+BHikLKo1Jz2GC9+UvBjZhBBB/6gMADsoHPBrYtXcVCUuJ2zA==
X-Received: by 2002:a1c:660a:: with SMTP id a10mr12275184wmc.122.1581802610148;
        Sat, 15 Feb 2020 13:36:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r1sm12687914wrx.11.2020.02.15.13.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 13:36:49 -0800 (PST)
Message-Id: <bcd04ec4ded1858a6e1d2292bbc0d34ec28c2f57.1581802602.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
        <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Feb 2020 21:36:30 +0000
Subject: [PATCH v5 09/20] t3432: make these tests work with either am or merge
 backends
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

t3432 had several stress tests for can_fast_forward(), whose intent was
to ensure we were using the optimization of just fast forwarding when
possible.  However, these tests verified that fast forwards had happened
based on the output that rebase printed to the terminal.  We can instead
test more directly that we actually fast-forwarded by checking the
reflog, which also has the side effect of making the tests applicable
for the merge/interactive backend.

This change does lose the distinction between "noop" and "noop-force",
but as stated in commit c9efc216830f ("t3432: test for --no-ff's
interaction with fast-forward", 2019-08-27) which introduced that
distinction: "These tests aren't supposed to endorse the status quo,
just test for what we're currently doing.".

This change does not actually run these tests with the merge/interactive
backend; instead this is just a preparatory commit.  A subsequent commit
which fixes can_fast_forward() to work with that backend will then also
change t3432 to add tests of that backend as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3432-rebase-fast-forward.sh | 48 ++++++++++++++++------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 92f95b57da1..7432c0e2415 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -44,19 +44,15 @@ test_rebase_same_head_ () {
 	test_expect_$status "git rebase$flag $* with $changes is $what with $cmp HEAD" "
 		oldhead=\$(git rev-parse HEAD) &&
 		test_when_finished 'git reset --hard \$oldhead' &&
+		cp .git/logs/HEAD expect &&
 		git rebase$flag $* >stdout &&
 		if test $what = work
 		then
-			# Must check this case first, for 'is up to
-			# date, rebase forced[...]rewinding head' cases
-			test_i18ngrep 'rewinding head' stdout
+			old=\$(wc -l <expect) &&
+			test_line_count '-gt' \$old .git/logs/HEAD
 		elif test $what = noop
 		then
-			test_i18ngrep 'is up to date' stdout &&
-			test_i18ngrep ! 'rebase forced' stdout
-		elif test $what = noop-force
-		then
-			test_i18ngrep 'is up to date, rebase forced' stdout
+			test_cmp expect .git/logs/HEAD
 		fi &&
 		newhead=\$(git rev-parse HEAD) &&
 		if test $cmp = same
@@ -71,14 +67,14 @@ test_rebase_same_head_ () {
 
 changes='no changes'
 test_rebase_same_head success noop same success work same
-test_rebase_same_head success noop same success noop-force same master
-test_rebase_same_head success noop same success noop-force diff --onto B B
-test_rebase_same_head success noop same success noop-force diff --onto B... B
-test_rebase_same_head success noop same success noop-force same --onto master... master
-test_rebase_same_head success noop same success noop-force same --keep-base master
-test_rebase_same_head success noop same success noop-force same --keep-base
-test_rebase_same_head success noop same success noop-force same --no-fork-point
-test_rebase_same_head success noop same success noop-force same --keep-base --no-fork-point
+test_rebase_same_head success noop same success work same master
+test_rebase_same_head success noop same success work diff --onto B B
+test_rebase_same_head success noop same success work diff --onto B... B
+test_rebase_same_head success noop same success work same --onto master... master
+test_rebase_same_head success noop same success work same --keep-base master
+test_rebase_same_head success noop same success work same --keep-base
+test_rebase_same_head success noop same success work same --no-fork-point
+test_rebase_same_head success noop same success work same --keep-base --no-fork-point
 test_rebase_same_head success noop same success work same --fork-point master
 test_rebase_same_head success noop same success work diff --fork-point --onto B B
 test_rebase_same_head success noop same success work diff --fork-point --onto B... B
@@ -91,14 +87,14 @@ test_expect_success 'add work same to side' '
 
 changes='our changes'
 test_rebase_same_head success noop same success work same
-test_rebase_same_head success noop same success noop-force same master
-test_rebase_same_head success noop same success noop-force diff --onto B B
-test_rebase_same_head success noop same success noop-force diff --onto B... B
-test_rebase_same_head success noop same success noop-force same --onto master... master
-test_rebase_same_head success noop same success noop-force same --keep-base master
-test_rebase_same_head success noop same success noop-force same --keep-base
-test_rebase_same_head success noop same success noop-force same --no-fork-point
-test_rebase_same_head success noop same success noop-force same --keep-base --no-fork-point
+test_rebase_same_head success noop same success work same master
+test_rebase_same_head success noop same success work diff --onto B B
+test_rebase_same_head success noop same success work diff --onto B... B
+test_rebase_same_head success noop same success work same --onto master... master
+test_rebase_same_head success noop same success work same --keep-base master
+test_rebase_same_head success noop same success work same --keep-base
+test_rebase_same_head success noop same success work same --no-fork-point
+test_rebase_same_head success noop same success work same --keep-base --no-fork-point
 test_rebase_same_head success noop same success work same --fork-point master
 test_rebase_same_head success noop same success work diff --fork-point --onto B B
 test_rebase_same_head success noop same success work diff --fork-point --onto B... B
@@ -112,8 +108,8 @@ test_expect_success 'add work same to upstream' '
 '
 
 changes='our and their changes'
-test_rebase_same_head success noop same success noop-force diff --onto B B
-test_rebase_same_head success noop same success noop-force diff --onto B... B
+test_rebase_same_head success noop same success work diff --onto B B
+test_rebase_same_head success noop same success work diff --onto B... B
 test_rebase_same_head success noop same success work diff --onto master... master
 test_rebase_same_head success noop same success work diff --keep-base master
 test_rebase_same_head success noop same success work diff --keep-base
-- 
gitgitgadget

