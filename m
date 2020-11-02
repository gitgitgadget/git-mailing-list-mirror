Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D45C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 23:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB442084C
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 23:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlPtVX/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgKBXzN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 18:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgKBXzM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 18:55:12 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45B3C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 15:55:10 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id e2so11107748wme.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 15:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Rez4TfngmA5bMTZ2TesS67OwbSEUFhLK/JRoX1kGWzo=;
        b=FlPtVX/W9bYZxnadDIwLtTkULoOwbBfnQmQxcJnsVuLUbnhHR2Ec4VyU2JccHur0RB
         +OaRu6yVYlqCQK5NIGkXFatl3QjLX1NDs0gP6mhhoj9eeUJ3npM4+6UZsqxWzhGTG0Kn
         wo3o2zNhjRv7dXf7mTI8Xtq5LOC57JsHUPhwAEKZKuVjP9oAnfbutEQuaiPqiF3OGO2b
         obVg7RShgVxpeWlbFnH7yazRWI4M32dYCGo9P9mTOwhnwpREWs5GysN0jWvyVYbnmt7H
         u2RNZ5O0Gsq494fZV+1G7rlceZLWmsJfj2/Tau+mw49gqxXQV56x1uJ9c9qGW4zgUSwl
         Eqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Rez4TfngmA5bMTZ2TesS67OwbSEUFhLK/JRoX1kGWzo=;
        b=ea+nZW4B3El2df9cWiq7bS33xTgamDIZbec9ERvZtX5rLx+mERLGf2Y5Inu49KbKwB
         SI8OcqmpmaBFlTWZH4JPC1M8PCYvtW6NCTB9w2YnxHt6wiqN3tuWE84cFy0XJC1DfgRX
         F5uF3vhoUC81/0kPMmh7QLNgbcN+6KJoeFlKu1t3CbUoy5s8oEK6vlriWaYKXJqpP4+S
         iTBOpF5yRGzrlFsGK1k/DZUAEoUdiMT8XiVDPpCfvc/a2cIVd+TV2+XT7SoZc2uJg1Iw
         PF0sCMP2sgma5IqxvooxvixC/RMjGvGaPMmPleT6UPergzOEfSJeqhz31vw6sQj7qF/F
         /P2Q==
X-Gm-Message-State: AOAM530t7JCPxSpQIsPjAo8PbM435mkl/lJiOhbLph4Ozd8z51lQX0ZS
        cq4253fmkMJx1V9XpYq8VDN8ApDos9Y=
X-Google-Smtp-Source: ABdhPJxtDtKc+pALUBr9z7Y26E5DJNNknyUgXBME/n1q5oqm9qBIYagudwxSSIZRU7R2dzDcCnnJkA==
X-Received: by 2002:a7b:c309:: with SMTP id k9mr504606wmj.125.1604361309433;
        Mon, 02 Nov 2020 15:55:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 30sm23863414wrs.84.2020.11.02.15.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 15:55:08 -0800 (PST)
Message-Id: <159b82a94c7e9be62a5d15bf9ec4a704f55433cc.1604361307.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.761.git.1604361307.gitgitgadget@gmail.com>
References: <pull.761.git.1604361307.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Nov 2020 23:55:04 +0000
Subject: [PATCH 1/4] t5515: use `main` as the name of the main branch for
 testing (part 1)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As part of the effort to change the default branch name to `main`, let's
prepare t5515.

In addition to adjusting the references to the branch name itself, this
also requires two commit hashes to be adjusted (actually four, as there
is a SHA-1 _and_ a SHA-256 of both).

That trick was performed by running

    sed -i -e 's/master/main/g' -e 's/Master/Main/g' \
        -e 's/6c9dec2b923228c9ff994c6cfe4ae16c12408dc5/ecf3b3627b498bdcb735cc4343bf165f76964e9a/g' \
	-e 's/8521c3072461fcfe8f32d67f95cc6e6b832a2db2fa29769ffc788bce85ebcd75/fff666109892bb4b1c80cd1649d2d8762a0663db8b5d46c8be98360b64fbba5f/g' \
	-e 's/754b754407bf032e9a2f9d5a9ad05ca79a6b228f/b4ab76b1a01ea602209932134a44f1e6bd610832/g' \
	-e 's/6c7abaea8a6d8ef4d89877e68462758dc6774690fbbbb0e6d7dd57415c9abde0/380ebae0113f877ce46fcdf39d5bc33e4dc0928db5c5a4d5fdc78381c4d55ae3/g' \
	-- t/t5515-*.sh

These commit hashes have been determined manually, of course, by running
the test after adjusting only the branch names, and then copying the
hashes from the log of the failed run.

Note: this patch only touches the t5515 script so far, not the
supporting material in t/t5515/. The resulting patch would have weighed
over 100kB and therefore the Git mailing list would have dropped it. The
files in t/t5515/ will be adjusted in the next two commits. As t5515
would fail without these adjustments, we temporarily skip it via the
`PREPARE_FOR_MAIN_BRANCH` prereq.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5515-fetch-merge-logic.sh | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index 70a9d2d8ab..1a81991cf7 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -11,11 +11,19 @@ test_description='Merge logic in fetch'
 GIT_TEST_PROTOCOL_VERSION=0
 export GIT_TEST_PROTOCOL_VERSION
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
+test_have_prereq PREPARE_FOR_MAIN_BRANCH || {
+	test_skip="In transit for the default branch name 'main'"
+	test_done
+}
+
 build_script () {
 	script="$1" &&
-	for i in one three_file master topic_2 one_tree three two two2 three2
+	for i in one three_file main topic_2 one_tree three two two2 three2
 	do
 		echo "s/$(test_oid --hash=sha1 "$i")/$(test_oid "$i")/g" >>"$script"
 	done
@@ -40,8 +48,8 @@ test_expect_success setup '
 	three_file sha1:0e3b14047d3ee365f4f2a1b673db059c3972589c
 	three_file sha256:bc4447d50c07497a8bfe6eef817f2364ecca9d471452e43b52756cc1a908bd32
 
-	master sha1:6c9dec2b923228c9ff994c6cfe4ae16c12408dc5
-	master sha256:8521c3072461fcfe8f32d67f95cc6e6b832a2db2fa29769ffc788bce85ebcd75
+	main sha1:ecf3b3627b498bdcb735cc4343bf165f76964e9a
+	main sha256:fff666109892bb4b1c80cd1649d2d8762a0663db8b5d46c8be98360b64fbba5f
 
 	one_tree sha1:22feea448b023a2d864ef94b013735af34d238ba
 	one_tree sha256:6e4743f4ef2356b881dda5e91f5c7cdffe870faf350bf7b312f80a20935f5d83
@@ -52,8 +60,8 @@ test_expect_success setup '
 	two sha1:525b7fb068d59950d185a8779dc957c77eed73ba
 	two sha256:3b21de3440cd38c2a9e9b464adb923f7054949ed4c918e1a0ac4c95cd52774db
 
-	topic_2 sha1:754b754407bf032e9a2f9d5a9ad05ca79a6b228f
-	topic_2 sha256:6c7abaea8a6d8ef4d89877e68462758dc6774690fbbbb0e6d7dd57415c9abde0
+	topic_2 sha1:b4ab76b1a01ea602209932134a44f1e6bd610832
+	topic_2 sha256:380ebae0113f877ce46fcdf39d5bc33e4dc0928db5c5a4d5fdc78381c4d55ae3
 
 	two2 sha1:6134ee8f857693b96ff1cc98d3e2fd62b199e5a8
 	two2 sha256:87a2d3ee29c83a3dc7afd41c0606b11f67603120b910a7be7840accdc18344d4
@@ -80,9 +88,9 @@ test_expect_success setup '
 	git tag -a -m "Tag Three file" tag-three-file HEAD^{tree}:file &&
 	git branch three &&
 
-	echo master >> file &&
-	git commit -a -m Master &&
-	git tag -a -m "Tag Master" tag-master &&
+	echo main >> file &&
+	git commit -a -m Main &&
+	git tag -a -m "Tag Main" tag-main &&
 
 	git checkout three &&
 
@@ -91,7 +99,7 @@ test_expect_success setup '
 	git config remote.origin.url ../.git/ &&
 
 	git config remote.config-explicit.url ../.git/ &&
-	git config remote.config-explicit.fetch refs/heads/master:remotes/rem/master &&
+	git config remote.config-explicit.fetch refs/heads/main:remotes/rem/main &&
 	git config --add remote.config-explicit.fetch refs/heads/one:remotes/rem/one &&
 	git config --add remote.config-explicit.fetch two:remotes/rem/two &&
 	git config --add remote.config-explicit.fetch refs/heads/three:remotes/rem/three &&
@@ -104,7 +112,7 @@ test_expect_success setup '
 	mkdir -p .git/remotes &&
 	{
 		echo "URL: ../.git/"
-		echo "Pull: refs/heads/master:remotes/rem/master"
+		echo "Pull: refs/heads/main:remotes/rem/main"
 		echo "Pull: refs/heads/one:remotes/rem/one"
 		echo "Pull: two:remotes/rem/two"
 		echo "Pull: refs/heads/three:remotes/rem/three"
@@ -149,7 +157,7 @@ done > tests
 # but does depend on Pull: or fetch lines.
 # Use two branches completely unrelated from the arguments,
 # the clone default and one without branch properties
-for branch in master br-unconfig ; do
+for branch in main br-unconfig ; do
     echo $branch
     for remote in $remotes ; do
 	echo $branch $remote
@@ -158,7 +166,7 @@ done >> tests
 
 # Merge logic does not depend on branch properties
 # neither in the Pull: or .fetch config
-for branch in master br-unconfig ; do
+for branch in main br-unconfig ; do
     cat <<EOF
 $branch ../.git
 $branch ../.git one
-- 
gitgitgadget

