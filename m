Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ABEC433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 14:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B218F22B37
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 14:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbgLDOfH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 09:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgLDOfG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 09:35:06 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44164C061A4F
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 06:34:26 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id f190so7271195wme.1
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 06:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ivx7ab8NjjlA1gBdcGVBDpISkEKaIoakHVAlZnO5jyw=;
        b=Rq++lbnokTeV0VQ2ftYuvvRVdJR1vkIL2D61pWs5jJX1IKZBoxLojmD8mDvhrbFtCF
         hBmLeOY0aF9KlIhK6IkItyezqtHo4hHBpfNNjR1fF1nx9hKfjBf7lu+oNajEPpZ8HIcd
         x6YrJ2fqdiz89uEasQZUQ4mA6SnaOnrSE9igFucIc83GPJbYt7VEQG5GoBWI3nxeW1P4
         Q4hrA0s7Ha3dgp7DofQlEVZNT80dD/8SogwFmg6hA8QeJ1PJlGCB7VEkJecbLNFF124y
         0e6EM8RJW/WTznELkEFxhFZhWuR3ENaYniUHcAo5wqsdPqZSeS2DZaZ3CiBSfQ0r65pa
         RghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ivx7ab8NjjlA1gBdcGVBDpISkEKaIoakHVAlZnO5jyw=;
        b=YCcpZmPqztd+wGwFFHoPmp+bTsv4IFNR/iC+bU6QSV1QuF87d8CCarmOeOXOTVay7I
         uzLnO5rpQ9fUos3azVHwd/bO2FDnTcyCLQO3UzXppKNvL6141+t7DaPiSQ9ivBUs8NOZ
         1H57+qTHFuu+0j9+IEqWxSZhnBxMwidnJERAJEMBIRCoqAtjAHaAm+v4b0XiptCCEdyc
         wU+/4QQEZ4TV1tx2XJWB/WM1q5XGeAkE7AYxZEKpIvy/5kIJMvjUcK2DvHGwm1/64Lv1
         aDYFu4r2Ho2lcgpGgF9zvCdcJyceR5hQC4KckQe5NyKx3ilXrduV+Zcb0CCFPbbcn+eN
         p2Aw==
X-Gm-Message-State: AOAM530xlDHhD1WnKcyL/zpxXtW6Ts8cnY11zqN3PT6Y4+g+yJPZBzni
        uxpu0qkUIxhh6VJdR/kz4uA7zcvK5S8=
X-Google-Smtp-Source: ABdhPJynNqZdi0KUK0nIfKp6TMTC52GCegpvz7gtuS3I9IuW8zb2In2VW/tcst++yLX6tbI3D5QqbA==
X-Received: by 2002:a1c:f017:: with SMTP id a23mr4468715wmb.56.1607092464650;
        Fri, 04 Dec 2020 06:34:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s8sm3681985wrn.33.2020.12.04.06.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 06:34:24 -0800 (PST)
Message-Id: <f23d7ab8ac3500bcf0ac4a1e1dafd9c2ebf972b6.1607092462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.806.git.1607092462.gitgitgadget@gmail.com>
References: <pull.806.git.1607092462.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Dec 2020 14:34:21 +0000
Subject: [PATCH 1/2] t5526: avoid depending on a specific default branch name
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

While at it, use different default branch names for the three different
repositories involved in the test script: this makes it easier to debug
failures, too (otherwise you have to wonder which `master` branch was
meant: the super project's? The submodule's? The nested submodule's?).

Note: this touches code that was originally modified to prepare for
renaming the default branch name to `main`. This patch side-steps that
effort completely by overriding the initial branch name explicitly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5526-fetch-submodules.sh | 41 ++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index dd8e423d25..6469120ded 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -18,7 +18,7 @@ add_upstream_commit() {
 		head2=$(git rev-parse --short HEAD) &&
 		echo "Fetching submodule submodule" > ../expect.err &&
 		echo "From $pwd/submodule" >> ../expect.err &&
-		echo "   $head1..$head2  main       -> origin/main" >> ../expect.err
+		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.err
 	) &&
 	(
 		cd deepsubmodule &&
@@ -30,7 +30,7 @@ add_upstream_commit() {
 		head2=$(git rev-parse --short HEAD) &&
 		echo "Fetching submodule submodule/subdir/deepsubmodule" >> ../expect.err
 		echo "From $pwd/deepsubmodule" >> ../expect.err &&
-		echo "   $head1..$head2  main       -> origin/main" >> ../expect.err
+		echo "   $head1..$head2  deep       -> origin/deep" >> ../expect.err
 	)
 }
 
@@ -41,7 +41,8 @@ test_expect_success setup '
 		git init &&
 		echo deepsubcontent > deepsubfile &&
 		git add deepsubfile &&
-		git commit -m new deepsubfile
+		git commit -m new deepsubfile &&
+		git branch -M deep
 	) &&
 	mkdir submodule &&
 	(
@@ -50,10 +51,12 @@ test_expect_success setup '
 		echo subcontent > subfile &&
 		git add subfile &&
 		git submodule add "$pwd/deepsubmodule" subdir/deepsubmodule &&
-		git commit -a -m new
+		git commit -a -m new &&
+		git branch -M sub
 	) &&
 	git submodule add "$pwd/submodule" submodule &&
 	git commit -am initial &&
+	git branch -M super &&
 	git clone . downstream &&
 	(
 		cd downstream &&
@@ -245,7 +248,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion stops when no new submodu
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." > expect.err.sub &&
-	echo "   $head1..$head2  main       -> origin/main" >>expect.err.sub &&
+	echo "   $head1..$head2  super      -> origin/super" >>expect.err.sub &&
 	head -3 expect.err >> expect.err.sub &&
 	(
 		cd downstream &&
@@ -263,7 +266,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion doesn't happen when new s
 	git commit -m "new file" &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." > expect.err.file &&
-	echo "   $head1..$head2  main       -> origin/main" >> expect.err.file &&
+	echo "   $head1..$head2  super      -> origin/super" >> expect.err.file &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
@@ -287,7 +290,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion picks up config in submod
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." > expect.err.sub &&
-	echo "   $head1..$head2  main       -> origin/main" >> expect.err.sub &&
+	echo "   $head1..$head2  super      -> origin/super" >> expect.err.sub &&
 	cat expect.err >> expect.err.sub &&
 	(
 		cd downstream &&
@@ -316,14 +319,14 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "Recursion picks up all submodules w
 		head2=$(git rev-parse --short HEAD) &&
 		echo "Fetching submodule submodule" > ../expect.err.sub &&
 		echo "From $pwd/submodule" >> ../expect.err.sub &&
-		echo "   $head1..$head2  main       -> origin/main" >> ../expect.err.sub
+		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.err.sub
 	) &&
 	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." > expect.err.2 &&
-	echo "   $head1..$head2  main       -> origin/main" >> expect.err.2 &&
+	echo "   $head1..$head2  super      -> origin/super" >> expect.err.2 &&
 	cat expect.err.sub >> expect.err.2 &&
 	tail -3 expect.err >> expect.err.2 &&
 	(
@@ -349,7 +352,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "'--recurse-submodules=on-demand' do
 		head2=$(git rev-parse --short HEAD) &&
 		echo Fetching submodule submodule > ../expect.err.sub &&
 		echo "From $pwd/submodule" >> ../expect.err.sub &&
-		echo "   $head1..$head2  main       -> origin/main" >> ../expect.err.sub
+		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.err.sub
 	) &&
 	(
 		cd downstream &&
@@ -368,7 +371,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "'--recurse-submodules=on-demand' re
 	head2=$(git rev-parse --short HEAD) &&
 	tail -3 expect.err > expect.err.deepsub &&
 	echo "From $pwd/." > expect.err &&
-	echo "   $head1..$head2  main       -> origin/main" >>expect.err &&
+	echo "   $head1..$head2  super      -> origin/super" >>expect.err &&
 	cat expect.err.sub >> expect.err &&
 	cat expect.err.deepsub >> expect.err &&
 	(
@@ -397,7 +400,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "'--recurse-submodules=on-demand' st
 	git commit -m "new file" &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." > expect.err.file &&
-	echo "   $head1..$head2  main       -> origin/main" >> expect.err.file &&
+	echo "   $head1..$head2  super      -> origin/super" >> expect.err.file &&
 	(
 		cd downstream &&
 		git fetch --recurse-submodules=on-demand >../actual.out 2>../actual.err
@@ -418,7 +421,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "'fetch.recurseSubmodules=on-demand'
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." > expect.err.2 &&
-	echo "   $head1..$head2  main       -> origin/main" >>expect.err.2 &&
+	echo "   $head1..$head2  super      -> origin/super" >>expect.err.2 &&
 	head -3 expect.err >> expect.err.2 &&
 	(
 		cd downstream &&
@@ -446,7 +449,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "'submodule.<sub>.fetchRecurseSubmod
 	git commit -m "new submodule" &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." > expect.err.2 &&
-	echo "   $head1..$head2  main       -> origin/main" >>expect.err.2 &&
+	echo "   $head1..$head2  super      -> origin/super" >>expect.err.2 &&
 	head -3 expect.err >> expect.err.2 &&
 	(
 		cd downstream &&
@@ -472,7 +475,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "don't fetch submodule when newly re
 	git commit -m "submodule rewound" &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." > expect.err &&
-	echo "   $head1..$head2  main       -> origin/main" >> expect.err &&
+	echo "   $head1..$head2  super      -> origin/super" >> expect.err &&
 	(
 		cd downstream &&
 		git fetch >../actual.out 2>../actual.err
@@ -481,7 +484,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "don't fetch submodule when newly re
 	test_i18ncmp expect.err actual.err &&
 	(
 		cd submodule &&
-		git checkout -q master
+		git checkout -q sub
 	)
 '
 
@@ -497,7 +500,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH "'fetch.recurseSubmodules=on-demand'
 	git commit -m "new submodule without .gitmodules" &&
 	head2=$(git rev-parse --short HEAD) &&
 	echo "From $pwd/." >expect.err.2 &&
-	echo "   $head1..$head2  main       -> origin/main" >>expect.err.2 &&
+	echo "   $head1..$head2  super      -> origin/super" >>expect.err.2 &&
 	head -3 expect.err >>expect.err.2 &&
 	(
 		cd downstream &&
@@ -663,9 +666,9 @@ test_expect_success 'fetch new submodule commits on-demand without .gitmodules e
 	git config -f .gitmodules --remove-section submodule.sub1 &&
 	git add .gitmodules &&
 	git commit -m "delete gitmodules file" &&
-	git checkout -B master &&
+	git checkout -B super &&
 	git -C downstream fetch &&
-	git -C downstream checkout origin/master &&
+	git -C downstream checkout origin/super &&
 
 	C=$(git -C submodule commit-tree -m "yet another change outside refs/heads" HEAD^{tree}) &&
 	git -C submodule update-ref refs/changes/7 $C &&
-- 
gitgitgadget

