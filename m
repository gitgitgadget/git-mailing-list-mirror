Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA23D1F516
	for <e@80x24.org>; Mon,  2 Jul 2018 00:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752779AbeGBAYx (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 20:24:53 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52621 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752733AbeGBAYu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 20:24:50 -0400
Received: by mail-it0-f68.google.com with SMTP id p4-v6so9878441itf.2
        for <git@vger.kernel.org>; Sun, 01 Jul 2018 17:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bBb9GkcHYAAFbMIBkSTbQANmm7PaKV+Lo/5/VyB/AQU=;
        b=Arp9PdVCw+wxBNA28GoxYvUfUgAVZQyTg/AtU9HE6bF1XqpCb2sivtp57WxqPv8ZW6
         vjFodvD6Mau2GNjA7fjwOYarWbPQDLu6S0ZzM/JZzYUU/dypRQ9Vn0Bd8gb2STRfPIf/
         mNkmliifsGJoi1YXmNDF+qAmI2MijYlvHL/iXM109Iv2mT9rlikqxE4L1Q2UGRM359kC
         y+QizB/IW9c+Xd5QhD5sd5peo/fLDffyP4ULn2MuYDamVuyaRekx/0jC3uDpqyZP/Jvu
         pMFMZK3OiKekhHwzusRa8VPLi1+gY4YVmKJfHuGTEOu6DnefZinrTEc6D5L+EM6arVOg
         EUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=bBb9GkcHYAAFbMIBkSTbQANmm7PaKV+Lo/5/VyB/AQU=;
        b=qW1sQTnVFBLF+nYmHtiZO8M2V537TuZxEMjh4OEi1e745lR/mdV0NzDojpySq+3dwc
         VWF0Mz1/TEGcXI6r6vDQJRNZgmPZ2bSXYWGX97bOqVPuvVZuhYN5ocmS0huyRifbGMZ1
         ZFdEshne36psKo9+bUd/rFn2M2X1czdCn0qgjSExFUDW2eAYtllHcLLqe67eIbhC3vfI
         2zSIsHP+FC+lk1e+9+S7Gaq5N/iVox3cFAzv5EH5m0jOgTNylQowK8zZAwZV9JXcUik3
         9+/AHtovwC/xhoVgHIzCTYPkW2Xx07tWAh4ewUAevIwxfQJkHrER0yq2Yx4ugcZqT60f
         cxjA==
X-Gm-Message-State: APt69E0QEcmmBpynDFa6Om20c4P8Vt5Sw+6nOxaH+sqVnsc52OGD5s4M
        EY2Y7fvn1mo1ufe+6jWVJudiZA==
X-Google-Smtp-Source: AAOMgpcCmHEfch6Z+nZNG5t7rtLknIERXAu7KThp/53lEXNn/MVxaOebDRcVYTmw5KKn5HFmv0ymUg==
X-Received: by 2002:a24:4112:: with SMTP id x18-v6mr4390169ita.83.1530491089611;
        Sun, 01 Jul 2018 17:24:49 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id o143-v6sm3302562itb.42.2018.07.01.17.24.48
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 01 Jul 2018 17:24:48 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 01/25] t: use test_might_fail() instead of manipulating exit code manually
Date:   Sun,  1 Jul 2018 20:23:41 -0400
Message-Id: <20180702002405.3042-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180702002405.3042-1-sunshine@sunshineco.com>
References: <20180702002405.3042-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These tests manually coerce the exit code of invoked commands to
"success" when they don't care if the command succeeds or fails since
failure of those commands should not cause the test to fail overall.
In doing so, they intentionally break the &&-chain. Modernize by
replacing manual exit code management with test_might_fail() and a
normal &&-chain.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t1507-rev-parse-upstream.sh | 6 +++---
 t/t1700-split-index.sh        | 2 +-
 t/t4012-diff-binary.sh        | 6 ++----
 t/t5400-send-pack.sh          | 4 ++--
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index 93c77eac45..349f6e10af 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -123,9 +123,9 @@ test_expect_success 'checkout -b new my-side@{u} forks from the same' '
 
 test_expect_success 'merge my-side@{u} records the correct name' '
 (
-	cd clone || exit
-	git checkout master || exit
-	git branch -D new ;# can fail but is ok
+	cd clone &&
+	git checkout master &&
+	test_might_fail git branch -D new &&
 	git branch -t new my-side@{u} &&
 	git merge -s ours new@{u} &&
 	git show -s --pretty=tformat:%s >actual &&
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 1e81b33b2e..39133bcbc8 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -435,7 +435,7 @@ test_expect_success 'writing split index with null sha1 does not write cache tre
 	commit=$(git commit-tree $tree -p HEAD <msg) &&
 	git update-ref HEAD "$commit" &&
 	GIT_ALLOW_NULL_SHA1=1 git reset --hard &&
-	(test-tool dump-cache-tree >cache-tree.out || true) &&
+	test_might_fail test-tool dump-cache-tree >cache-tree.out &&
 	test_line_count = 0 cache-tree.out
 '
 
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 0a8af76aab..6579c81216 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -102,10 +102,8 @@ test_expect_success 'apply binary patch' '
 
 test_expect_success 'diff --no-index with binary creation' '
 	echo Q | q_to_nul >binary &&
-	(: hide error code from diff, which just indicates differences
-	 git diff --binary --no-index /dev/null binary >current ||
-	 true
-	) &&
+	# hide error code from diff, which just indicates differences
+	test_might_fail git diff --binary --no-index /dev/null binary >current &&
 	rm binary &&
 	git apply --binary <current &&
 	echo Q >expected &&
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 911eae1bf7..f1932ea431 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -86,7 +86,7 @@ test_expect_success 'push can be used to delete a ref' '
 test_expect_success 'refuse deleting push with denyDeletes' '
 	(
 	    cd victim &&
-	    ( git branch -D extra || : ) &&
+	    test_might_fail git branch -D extra &&
 	    git config receive.denyDeletes true &&
 	    git branch extra master
 	) &&
@@ -119,7 +119,7 @@ test_expect_success 'override denyDeletes with git -c receive-pack' '
 test_expect_success 'denyNonFastforwards trumps --force' '
 	(
 	    cd victim &&
-	    ( git branch -D extra || : ) &&
+	    test_might_fail git branch -D extra &&
 	    git config receive.denyNonFastforwards true
 	) &&
 	victim_orig=$(cd victim && git rev-parse --verify master) &&
-- 
2.18.0.203.gfac676dfb9

