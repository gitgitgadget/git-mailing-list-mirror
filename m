Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026F5C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9A4206D3
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcDRHNxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfLTRJ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:09:58 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39237 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfLTRJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 12:09:56 -0500
Received: by mail-ed1-f68.google.com with SMTP id t17so8937260eds.6
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 09:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mETJKZCWTZRi4+3xkXNP6NhsWJqh1Sg8aoa0G2CeAOc=;
        b=UcDRHNxb/cRxhVscuWkrSHejTas73OcovE4UBoVD3tEAl2TVWl3o679WClSC4/Pr2D
         gxQBeMSkddvre5Qw/X5OwsfifbBWfPh8olB3lXKWrQ/Othn15RRFRs5OyuSeuFdGei/P
         u22q/Fv7gwG88Qpg0WEUdYKbyllaDalw5XGChtUh7rAVI1u2Pr3xt5tNnEyoftcVnvJi
         Eb+VTjDsHJRtTq60wF9p0NwU0seb4CbxKuW+2h6wGBpPDgSepIdabEDJRz/1/bMppjdD
         UiEmTZWIxRTJ8ilrS7Z6+rZq7t3lYYoDqhoDOci2Pp/XgA0E6vj4TUkoftoA0wv0DEyL
         XRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mETJKZCWTZRi4+3xkXNP6NhsWJqh1Sg8aoa0G2CeAOc=;
        b=CsQaY45T2mFV43OmFms/QMcs7sbKUBg7zqTk+TgdHMFljfPePrDTXTxb2cYDF2fchU
         XHGc6gy8ThJLr5J0jsN51YkwJUYcLkfoMDbbQZjjfPa9+u9iQOZml1+bOtejGMeaMn7u
         /eRCVPmTKZvUr4RCSezg2MdDMoF26SY/O2Tw0YodGxClSreVCgHkE3VAzWtl68SCa1Me
         Ux4rjFuMJyIVZuC0IcWkcSdoLvJAg70lQKXSSpy8iihFw9CeJRu13uAQgxkJ6EgrQsnP
         FEEPW0Ra8nqiKSDnw8LN0ClrFzFaycAhRgqnP7e85GRnIjWYyHdu/WHPDdF28x/9MhDG
         2TUg==
X-Gm-Message-State: APjAAAWDubhD5GVosdTv68Q6T8fmO+P7dOOir/NJrmU3rAvmmJavokNt
        h4bM9rGUqExOMpvf7ddNte8B8P+G
X-Google-Smtp-Source: APXvYqzjGHk7ZP2G+MvDY8VykU9irzyX/wEy4X9Q8eQ+GuN7BdRB65y5ogSXS8Sc4KoTUM8yQb49VA==
X-Received: by 2002:aa7:da13:: with SMTP id r19mr17051561eds.188.1576861794668;
        Fri, 20 Dec 2019 09:09:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w12sm1017209edq.94.2019.12.20.09.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 09:09:54 -0800 (PST)
Message-Id: <9b1ad46c58b7f8397acbf2a8339e150dfb04c956.1576861788.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 17:09:39 +0000
Subject: [PATCH 06/15] t3432: make these tests work with either am or merge
 backends
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
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
 t/t3432-rebase-fast-forward.sh | 53 ++++++++++++++++------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 92f95b57da..3879a43fa0 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -44,19 +44,16 @@ test_rebase_same_head_ () {
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
+			wc -l .git/logs/HEAD >old &&
+			wc -l .git/logs/HEAD >new &&
+			test_line_count '-gt' $(($old + 2)) .git/logs/HEAD
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
@@ -71,14 +68,14 @@ test_rebase_same_head_ () {
 
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
@@ -91,14 +88,14 @@ test_expect_success 'add work same to side' '
 
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
@@ -112,13 +109,13 @@ test_expect_success 'add work same to upstream' '
 '
 
 changes='our and their changes'
-test_rebase_same_head success noop same success noop-force diff --onto B B
-test_rebase_same_head success noop same success noop-force diff --onto B... B
+test_rebase_same_head success noop same success work diff --onto B B
+test_rebase_same_head success noop same success work diff --onto B... B
 test_rebase_same_head success noop same success work diff --onto master... master
 test_rebase_same_head success noop same success work diff --keep-base master
 test_rebase_same_head success noop same success work diff --keep-base
-test_rebase_same_head failure work same success work diff --fork-point --onto B B
-test_rebase_same_head failure work same success work diff --fork-point --onto B... B
+test_rebase_same_head success work same success work diff --fork-point --onto B B
+test_rebase_same_head success work same success work diff --fork-point --onto B... B
 test_rebase_same_head success noop same success work diff --fork-point --onto master... master
 test_rebase_same_head success noop same success work diff --fork-point --keep-base master
 
-- 
gitgitgadget

