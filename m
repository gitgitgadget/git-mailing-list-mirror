Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982F5C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 09:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BAB361139
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 09:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349637AbhIHJuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 05:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347816AbhIHJuf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 05:50:35 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09CEC061757
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 02:49:27 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d6so2295820wrc.11
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 02:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EPek7zPE71UPQnRcrHy4dEprcD4wlseTed/S+Am4RYg=;
        b=Bs4amrTQ4CUeN0UAJBCQwiZKpd8QBKV8+Gn2WPQKwHSMyEVu1mhKGKZo6Pxgmiucci
         +3nGK9H85McuG0HHFVuDHxYjPtnx3rveOdGjCWUepw1uDnZqaXDyodSQsz4eDk/5SWB3
         3++4tBnLvLidilOKjeXJTnFu9goF6W8YPcChlL0uVDy/4NAYR5CzeU25zMTO0+qqc8y7
         KXrYbZa65UGfS63YxeqIPDTXpLoVaN1yTWE5DOK33yJzZefcB+7s3ARviuEkWzugRdEf
         c6osQc38kAa/+ydm2fPzOSmwWZwHe1JF+M/4X3dTw+xcrRfwyGnQx5xUku4ztHO2SV+Q
         vrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EPek7zPE71UPQnRcrHy4dEprcD4wlseTed/S+Am4RYg=;
        b=Bzap7wPmuVwnKzl9bd0F/wPi9ZZvmAheNBHuSoI8S9/8Z/+1kwbKEuSMmDjIqcOm3S
         2DHjHVJYBOvk5gYIRWH/kwbBnOHT7wn3CU8mNqRN0lUUW2K/mU5Vbgu/xcJRjreiBwuT
         XnBN7GOqTDmDpzyjh2gdl0fVSLD8Q5mCuse6Xqo8F5O0EBWO8V1ijUOQVwwxOVudsofq
         h9zFMusJYv5aTeJi2FpD2sx5n7dzBa2Eg2YbxmyYeQ7MOsnL74MRwdJ1NPxBOoq3X/mb
         SAGsvufEiZvyEvKBKDIdevVS+uzSoqonWoK/KZv9vIwvRWtq/fyx2pxVbhhmFR6N1vAL
         9ncw==
X-Gm-Message-State: AOAM532YKAzEpr/2hzYDexp+udY5pFp0p9B5V8bpEIvnFvjWVJywJIRM
        og+8/PTeyjPglShDFhp4G+gMVYNpQm4=
X-Google-Smtp-Source: ABdhPJy7jq0VAru7kphRy6megvJ02iyirfSzxcEIfNfIrIDWwY0Xyh2tDX1WMIlaALZROndw0UCx3g==
X-Received: by 2002:a05:6000:374:: with SMTP id f20mr2982348wrf.129.1631094566342;
        Wed, 08 Sep 2021 02:49:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i4sm1768983wmd.5.2021.09.08.02.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 02:49:26 -0700 (PDT)
Message-Id: <bef70d86d53714cc8e5ade1b65adf6cd1b0fde28.1631094563.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 09:49:15 +0000
Subject: [PATCH 04/11] t3407: rename a variable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

$dotest holds the name of the rebase state directory and was named
after the state directory used at the time the test was added. As we
no longer use that name rename the variable to reflect its purpose.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3407-rebase-abort.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 8d913d73bad..d36a3f2758b 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -21,35 +21,35 @@ test_expect_success setup '
 
 testrebase() {
 	type=$1
-	dotest=$2
+	state_dir=$2
 
 	test_expect_success "rebase$type --abort" '
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
 		test_must_fail git rebase$type main &&
-		test_path_is_dir "$dotest" &&
+		test_path_is_dir "$state_dir" &&
 		git rebase --abort &&
 		test_cmp_rev to-rebase pre-rebase &&
-		test ! -d "$dotest"
+		test ! -d "$state_dir"
 	'
 
 	test_expect_success "rebase$type --abort after --skip" '
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
 		test_must_fail git rebase$type main &&
-		test_path_is_dir "$dotest" &&
+		test_path_is_dir "$state_dir" &&
 		test_must_fail git rebase --skip &&
 		test_cmp_rev HEAD main &&
 		git rebase --abort &&
 		test_cmp_rev to-rebase pre-rebase &&
-		test ! -d "$dotest"
+		test ! -d "$state_dir"
 	'
 
 	test_expect_success "rebase$type --abort after --continue" '
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
 		test_must_fail git rebase$type main &&
-		test_path_is_dir "$dotest" &&
+		test_path_is_dir "$state_dir" &&
 		echo c > a &&
 		echo d >> a &&
 		git add a &&
@@ -57,7 +57,7 @@ testrebase() {
 		! test_cmp_rev HEAD main &&
 		git rebase --abort &&
 		test_cmp_rev to-rebase pre-rebase &&
-		test ! -d "$dotest"
+		test ! -d "$state_dir"
 	'
 
 	test_expect_success "rebase$type --abort does not update reflog" '
-- 
gitgitgadget

