Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3A0C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9EFF22263
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnU0OyGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731997AbgJOR6P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731881AbgJOR6O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 13:58:14 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3818C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 10:58:14 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f19so2463029pfj.11
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 10:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ExaENDTxxzNqbrZgVFiEoUlckUZQ03w781uuK7Ti//Y=;
        b=RnU0OyGnPZBS6Pu4K2icDIEqaUG8X2Ua2fnJMfYogIGuLKOwdOF9PS6dUrd1Xd/Z1X
         +hA6easSphiGidYIYD9k+Y/DPKDM8L18ZC8pqdPfVulpH9UUgi0lav6wwEbGBdiKNSu1
         7iR3MdP7kCCUhFNk/1KdW7JynK1kpY/3Y/GJMnQcTOGD6uuw43xQXfXQ4gcYntm1/zep
         4EQchCecQgBKqjCfknG4LqxfjBIaatqCRgr7KFUwjGo3kfNvfMBa6sENaAWc9gMhixVD
         5X/PO7tsHfO2cTnbhwYUDT4nuQzjWykN6gz//gFoAVq8p6uI5GsZZL08T3TZm0JMgkGj
         uIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ExaENDTxxzNqbrZgVFiEoUlckUZQ03w781uuK7Ti//Y=;
        b=rs2McNbM9fw8vysxfCl2yJMoJAUhNQIbDAG0doCFBQf6e818MBgBARaoPfFHnduqOZ
         R2AAanx9bl+tYThGOkR1GCsaOb+txdeWM2OLMkcBnAbzTWolZUq6WK/clzO0HkTFrBeX
         FU4JL44n50zJ2S3Y5flwryQQUFruB2OjNhDJLzqJDlV4sEVVLQZDx13x97TCjlOTJglD
         eHvxOEyzVRw2DULTZ92k8BxuSurhykarxG9IyDa8m42y8towtO6Y9Hlx/a0pcYvzk4h5
         wxngX8VoWUtmlQ0yKn+kRvlH7JrT0LSWq6QaAaRkbQiRolnTEsPwGoqMvh48kEo+cJlD
         OF/w==
X-Gm-Message-State: AOAM530UEc0fgmnuLtAoggUa27DoznBekeqUJ/PFfPwoD0H+Ss26Zkce
        FWwcwLvcigOvlRitE/Qwj3J1AJEgaWfXOkqD
X-Google-Smtp-Source: ABdhPJzrCDRbH6goA1CJUd0D1CxLGGvHm6i2C2Haq34rG2lsj+FsHqofIdeIKIlTSz+2JPYhD8I5WQ==
X-Received: by 2002:a63:1b54:: with SMTP id b20mr26247pgm.161.1602784693934;
        Thu, 15 Oct 2020 10:58:13 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:1309:c8:79e1:6677:5d35:9a95])
        by smtp.gmail.com with ESMTPSA id n139sm3945930pfd.167.2020.10.15.10.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 10:58:13 -0700 (PDT)
From:   charvi-077 <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood123@gmail.com,
        sunshine@sunshineco.com, charvi-077 <charvi077@gmail.com>
Subject: [PATCH 2/5][Outreachy] t7102,t7201: remove unnecessary blank spaces in test body
Date:   Thu, 15 Oct 2020 23:27:06 +0530
Message-Id: <20201015175709.20121-3-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20201015175709.20121-1-charvi077@gmail.com>
References: <20201015175709.20121-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some tests use a deprecated style in which there are unnecessary blank lines after the opening quote of the test body and before the closing quote. So we should removed these unnecessary blank lines.

Signed-off-by: charvi-077 <charvi077@gmail.com>
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

