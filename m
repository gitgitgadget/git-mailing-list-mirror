Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CC3B2027C
	for <e@80x24.org>; Sun, 16 Jul 2017 19:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751244AbdGPTme (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 15:42:34 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34579 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbdGPTmd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 15:42:33 -0400
Received: by mail-wr0-f195.google.com with SMTP id o105so541735wrc.1
        for <git@vger.kernel.org>; Sun, 16 Jul 2017 12:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1PtHizTZSQWOemgndBtVP04pjQM1cpm/o93EzFqbb44=;
        b=a+N7KCdc4VKDQqokXQos+bqd7ZrLYwovI18zyORJ1B3iynLzwoYL2TECf4KP9tZjaS
         vJ9mXIm1eP1GRSrrzS2hYO0uhpAoWU0jhvnbqOYmmMcjqJa98YpgDsmfcTwI85VsH1Y+
         WrDQQaB3Bxb+zPN/0JUZ0HKfjz2GD3eKfT9PXuiwJhAxAa6ZEUzJWhqtY0tnAbL/Ejqc
         fNZTAA6sZ6feP1lIAROBE9lQhornYKLv9+NqfSR5lwN/f5Dwlvw74gvS0d3b6aWnQcAx
         dTdV597q5pCpdYMSnEXQOJMyBldFlKFRxrZoITtCRBf1EHdNKagtol7EL+nfvqpn5vFR
         57JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1PtHizTZSQWOemgndBtVP04pjQM1cpm/o93EzFqbb44=;
        b=ZYqsF37S4Jur35S9xDtzzSINxullTrNj3/yATn7VjY+LeYFL0RHqH5jujb60f1in2S
         I6FUMt592/ndXpXkmVmLgSCbiKhluyLQZWkaiHRv0MaAKm7GkZdT+n7KNRylgmytO/A7
         CzpXajbqsG02dIoyyzjd8INdyTfcKhpEWhO6ybSo64+dDi3CBtyF87xOxsikEd09Xfwq
         J1Kn6o5vqXqRyr+74O2oUmfIl/d55xIF0yuL7SFJXgOqpWUmmNFwkuLxMmpt9kLPaiND
         c/d5oSj7GsK9vKs9AyXsx3E8w9/UCfgQcIgvGvhDWA+5dybFpg6xX8IZb2kPSATz4nAH
         B3dQ==
X-Gm-Message-State: AIVw110dV2K87xYe0su7OOPmJt4ufLxr62+EWHe0u/O000U/UZaMaXv/
        2PzrLfcENnV0a8bt
X-Received: by 10.223.173.69 with SMTP id p63mr8726096wrc.25.1500234152490;
        Sun, 16 Jul 2017 12:42:32 -0700 (PDT)
Received: from localhost.localdomain (vil93-6-82-233-248-1.fbx.proxad.net. [82.233.248.1])
        by smtp.gmail.com with ESMTPSA id g5sm6574960wmf.5.2017.07.16.12.42.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jul 2017 12:42:31 -0700 (PDT)
From:   William Duclot <william.duclot@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, William Duclot <william.duclot@gmail.com>
Subject: [PATCH] rebase: make resolve message clearer for inexperienced users
Date:   Sun, 16 Jul 2017 21:42:20 +0200
Message-Id: <20170716194220.1304-1-william.duclot@gmail.com>
X-Mailer: git-send-email 2.13.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git UI can be improved by addressing the error messages to those
they help: inexperienced and casual git users. To this intent, it is
helpful to make sure the terms used in those messages can be understood
by this segment of users, and that they guide them to resolve the
problem.

In particular, failure to apply a patch during a git rebase is a common
problem that can be very destabilizing for the inexperienced user. It is
important to lead them toward the resolution of the conflict (which is a
3-steps process, thus complex) and reassure them that they can escape a
situation they can't handle with "--abort". This commit answer those two
points by detailling the resolution process and by avoiding cryptic git
linguo.

Signed-off-by: William Duclot <william.duclot@gmail.com>
---
Those new messages have been written thanks to Junio feedbacks and users
tests with a few inexperienced git users.

 git-rebase.sh   | 7 ++++---
 t/t5520-pull.sh | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 2cf73b88e..ef3409679 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -55,9 +55,10 @@ LF='
 '
 ok_to_skip_pre_rebase=
 resolvemsg="
-$(gettext 'When you have resolved this problem, run "git rebase --continue".
-If you prefer to skip this patch, run "git rebase --skip" instead.
-To check out the original branch and stop rebasing, run "git rebase --abort".')
+$(gettext 'Resolve all conflicts manually, mark them as resolved with
+"git add/rm <conflicted_files>", then run "git rebase --continue".
+You can instead skip this commit: run "git rebase --skip".
+To abort and get back to the state before "git rebase -i", run "git rebase --abort".')
 "
 unset onto
 unset restrict_revision
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index f15f7a332..59c4b778d 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -305,7 +305,7 @@ test_expect_success '--rebase with conflicts shows advice' '
 	test_tick &&
 	git commit -m "Create conflict" seq.txt &&
 	test_must_fail git pull --rebase . seq 2>err >out &&
-	test_i18ngrep "When you have resolved this problem" out
+	test_i18ngrep "Resolve all conflicts manually" out
 '
 
 test_expect_success 'failed --rebase shows advice' '
@@ -319,7 +319,7 @@ test_expect_success 'failed --rebase shows advice' '
 	git checkout -f -b fails-to-rebase HEAD^ &&
 	test_commit v2-without-cr file "2" file2-lf &&
 	test_must_fail git pull --rebase . diverging 2>err >out &&
-	test_i18ngrep "When you have resolved this problem" out
+	test_i18ngrep "Resolve all conflicts manually" out
 '
 
 test_expect_success '--rebase fails with multiple branches' '
-- 
2.13.0

