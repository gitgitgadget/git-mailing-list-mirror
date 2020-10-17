Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9B4C43457
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 07:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C78AF2072D
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 07:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tUCiJdta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437529AbgJQH4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 03:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437522AbgJQH4D (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 03:56:03 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A878C061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 00:56:03 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n14so2850014pff.6
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 00:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9qW5LCiX3cg+QaZyzahzhwWLREwCttKhkFE7l1/60W8=;
        b=tUCiJdta3AjeTOLlFd+e26MA3sLF1u5JMQypttQZWgNgkDzDjo5uYaMvyn7BNmtN1r
         JfmRetMH1327IyyIb6y5X2tNQRWQKJF/TMXEFll9Ca159c4h8zAtEjrkEo2f9bWmyPRc
         ZaVRuZCvdobvYPSJLAnDQrcINykZ8C/bJw4PxtF6qlMRJN8V0bih184IEsIAyhVe8DsQ
         Qac6NJ0dsDm6Kqtxjg/33nbGNKGWzcn0BZDGdZu2o+bNlWpa/pTs2YQNlBOJt40k6sNZ
         kW5lt1Nh9EoiNqmu6noDbr6pjc8y7pU/uclqgwebdIrtnXbb4JX4JqwYHrvp9QDrREQ6
         p+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9qW5LCiX3cg+QaZyzahzhwWLREwCttKhkFE7l1/60W8=;
        b=jxJw3rGh997o4zFK3ytrE9T2sH4UVok8C+owWXBV4BsQQKZncUzJD7OP2V2BQ7VxCa
         GLSEh2CLluohkJGqVj58AT7QmCKhgs7SCshGxQw7LRw8dyWoGtitFu/Dk1f7rX/Q+j0Q
         c0XJMZo1RP2+CT9ljkh0sW1ElAoC1wPqUQjSQpyvWzwjOKSsJaDqmDggKtIodFW8+dOZ
         01rvGFcKXHA64VPfXozSMtH8dZ1QYlWN1wfburuaEYR/YmDTibY0oG+pVimI/vz+qQYB
         VbQKHTYHTWs6uPipARA7zpfexyB20F5D/R01JFu+J19B3JYiUVMoVMFkz6P0P4KErgqr
         vz9Q==
X-Gm-Message-State: AOAM533JgCEO/kqnLJPDfKKiv/vavKlPyP3ULnDoRs16iWXzjgaZuY5S
        au7Ck7eeye0jPxg+PAOacXzq3M7bl7wYIQ==
X-Google-Smtp-Source: ABdhPJyXpXANkvuFj+S6zmxhbfg9bBHx50sSBCQxQOvTIFSsTZjtF+1duUbXxJFccHb6rxAveEztRg==
X-Received: by 2002:a63:f741:: with SMTP id f1mr6048981pgk.38.1602921362510;
        Sat, 17 Oct 2020 00:56:02 -0700 (PDT)
Received: from localhost.localdomain ([106.201.2.128])
        by smtp.gmail.com with ESMTPSA id t2sm4994162pji.12.2020.10.17.00.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 00:56:02 -0700 (PDT)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        sunshine@sunshineco.com, Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v2 2/5][Outreachy] t7102,t7201: remove unnecessary blank spaces in test body
Date:   Sat, 17 Oct 2020 13:24:52 +0530
Message-Id: <20201017075455.9660-3-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20201017075455.9660-1-charvi077@gmail.com>
References: <20201015175709.20121-1-charvi077@gmail.com>
 <20201017075455.9660-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some tests use a deprecated style in which there are unnecessary blank lines after the opening quote of the test body and before the closing quote. So we should remove these unnecessary blank lines.

Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t7102-reset.sh |  9 ---------
 t/t7201-co.sh    | 25 -------------------------
 2 files changed, 34 deletions(-)

diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index fe43f77513..2b4cfb2c83 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -439,7 +439,6 @@ test_expect_success 'test --mixed <paths>' '
 '
 
 test_expect_success 'test resetting the index at give paths' '
-
 	mkdir sub &&
 	>sub/file1 &&
 	>sub/file2 &&
@@ -452,7 +451,6 @@ test_expect_success 'test resetting the index at give paths' '
 	echo "$U" &&
 	test_must_fail git diff-index --cached --exit-code "$T" &&
 	test "$T" != "$U"
-
 '
 
 test_expect_success 'resetting an unmodified path is a no-op' '
@@ -490,7 +488,6 @@ test_expect_success 'resetting specific path that is unmerged' '
 '
 
 test_expect_success 'disambiguation (1)' '
-
 	git reset --hard &&
 	>secondfile &&
 	git add secondfile &&
@@ -499,11 +496,9 @@ test_expect_success 'disambiguation (1)' '
 	test -z "$(git diff --cached --name-only)" &&
 	test -f secondfile &&
 	test_must_be_empty secondfile
-
 '
 
 test_expect_success 'disambiguation (2)' '
-
 	git reset --hard &&
 	>secondfile &&
 	git add secondfile &&
@@ -511,11 +506,9 @@ test_expect_success 'disambiguation (2)' '
 	test_must_fail git reset secondfile &&
 	test -n "$(git diff --cached --name-only -- secondfile)" &&
 	test ! -f secondfile
-
 '
 
 test_expect_success 'disambiguation (3)' '
-
 	git reset --hard &&
 	>secondfile &&
 	git add secondfile &&
@@ -524,11 +517,9 @@ test_expect_success 'disambiguation (3)' '
 	test_must_fail git diff --quiet &&
 	test -z "$(git diff --cached --name-only)" &&
 	test ! -f secondfile
-
 '
 
 test_expect_success 'disambiguation (4)' '
-
 	git reset --hard &&
 	>secondfile &&
 	git add secondfile &&
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index a800bda5e3..b527f8009c 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -33,7 +33,6 @@ fill () {
 
 
 test_expect_success setup '
-
 	fill x y z > same &&
 	fill 1 2 3 4 5 6 7 8 >one &&
 	fill a b c d e >two &&
@@ -63,7 +62,6 @@ test_expect_success setup '
 '
 
 test_expect_success 'checkout from non-existing branch' '
-
 	git checkout -b delete-me master &&
 	git update-ref -d --no-deref refs/heads/delete-me &&
 	test refs/heads/delete-me = "$(git symbolic-ref HEAD)" &&
@@ -72,7 +70,6 @@ test_expect_success 'checkout from non-existing branch' '
 '
 
 test_expect_success 'checkout with dirty tree without -m' '
-
 	fill 0 1 2 3 4 5 6 7 8 >one &&
 	if git checkout side
 	then
@@ -81,11 +78,9 @@ test_expect_success 'checkout with dirty tree without -m' '
 	else
 		echo "happy - failed correctly"
 	fi
-
 '
 
 test_expect_success 'checkout with unrelated dirty tree without -m' '
-
 	git checkout -f master &&
 	fill 0 1 2 3 4 5 6 7 8 >same &&
 	cp same kept &&
@@ -96,7 +91,6 @@ test_expect_success 'checkout with unrelated dirty tree without -m' '
 '
 
 test_expect_success 'checkout -m with dirty tree' '
-
 	git checkout -f master &&
 	git clean -f &&
 
@@ -121,7 +115,6 @@ test_expect_success 'checkout -m with dirty tree' '
 '
 
 test_expect_success 'checkout -m with dirty tree, renamed' '
-
 	git checkout -f master && git clean -f &&
 
 	fill 1 2 3 4 5 7 8 >one &&
@@ -139,11 +132,9 @@ test_expect_success 'checkout -m with dirty tree, renamed' '
 	! test -f one &&
 	git diff --cached >current &&
 	test_must_be_empty current
-
 '
 
 test_expect_success 'checkout -m with merge conflict' '
-
 	git checkout -f master && git clean -f &&
 
 	fill 1 T 3 4 5 6 S 8 >one &&
@@ -166,7 +157,6 @@ test_expect_success 'checkout -m with merge conflict' '
 '
 
 test_expect_success 'format of merge conflict from checkout -m' '
-
 	git checkout -f master && git clean -f &&
 
 	fill b d > two &&
@@ -190,7 +180,6 @@ test_expect_success 'format of merge conflict from checkout -m' '
 '
 
 test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
-
 	git checkout -f master && git reset --hard && git clean -f &&
 
 	fill b d > two &&
@@ -216,7 +205,6 @@ test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
 '
 
 test_expect_success 'switch to another branch while carrying a deletion' '
-
 	git checkout -f master && git reset --hard && git clean -f &&
 	git rm two &&
 
@@ -228,7 +216,6 @@ test_expect_success 'switch to another branch while carrying a deletion' '
 '
 
 test_expect_success 'checkout to detach HEAD (with advice declined)' '
-
 	git config advice.detachedHead false &&
 	rev=$(git rev-parse --short renamer^) &&
 	git checkout -f renamer && git clean -f &&
@@ -267,7 +254,6 @@ test_expect_success 'checkout to detach HEAD' '
 '
 
 test_expect_success 'checkout to detach HEAD with branchname^' '
-
 	git checkout -f master && git clean -f &&
 	git checkout renamer^ &&
 	H=$(git rev-parse --verify HEAD) &&
@@ -283,7 +269,6 @@ test_expect_success 'checkout to detach HEAD with branchname^' '
 '
 
 test_expect_success 'checkout to detach HEAD with :/message' '
-
 	git checkout -f master && git clean -f &&
 	git checkout ":/Initial" &&
 	H=$(git rev-parse --verify HEAD) &&
@@ -299,7 +284,6 @@ test_expect_success 'checkout to detach HEAD with :/message' '
 '
 
 test_expect_success 'checkout to detach HEAD with HEAD^0' '
-
 	git checkout -f master && git clean -f &&
 	git checkout HEAD^0 &&
 	H=$(git rev-parse --verify HEAD) &&
@@ -315,7 +299,6 @@ test_expect_success 'checkout to detach HEAD with HEAD^0' '
 '
 
 test_expect_success 'checkout with ambiguous tag/branch names' '
-
 	git tag both side &&
 	git branch both master &&
 	git reset --hard &&
@@ -327,11 +310,9 @@ test_expect_success 'checkout with ambiguous tag/branch names' '
 	test "z$H" = "z$M" &&
 	name=$(git symbolic-ref HEAD 2>/dev/null) &&
 	test "z$name" = zrefs/heads/both
-
 '
 
 test_expect_success 'checkout with ambiguous tag/branch names' '
-
 	git reset --hard &&
 	git checkout master &&
 
@@ -351,11 +332,9 @@ test_expect_success 'checkout with ambiguous tag/branch names' '
 	else
 		: happy
 	fi
-
 '
 
 test_expect_success 'switch branches while in subdirectory' '
-
 	git reset --hard &&
 	git checkout master &&
 
@@ -366,11 +345,9 @@ test_expect_success 'switch branches while in subdirectory' '
 	) &&
 	! test -f subs/one &&
 	rm -fr subs
-
 '
 
 test_expect_success 'checkout specific path while in subdirectory' '
-
 	git reset --hard &&
 	git checkout side &&
 	mkdir subs &&
@@ -385,7 +362,6 @@ test_expect_success 'checkout specific path while in subdirectory' '
 		git checkout side -- bero
 	) &&
 	test -f subs/bero
-
 '
 
 test_expect_success 'checkout w/--track sets up tracking' '
@@ -608,7 +584,6 @@ test_expect_success 'failing checkout -b should not break working tree' '
 	test $(git symbolic-ref HEAD) = refs/heads/master &&
 	git diff --exit-code &&
 	git diff --cached --exit-code
-
 '
 
 test_expect_success 'switch out of non-branch' '
-- 
2.29.0.rc1

