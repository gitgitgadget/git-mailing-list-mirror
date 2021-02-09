Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FFFC433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B37E64E7E
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbhBIRd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 12:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbhBIRdv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 12:33:51 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00FBC061786
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 09:33:10 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id z7so228188plk.7
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 09:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=k0orSRUqVuqAAjknd8gNpZ+OTr37Fkr/H3F2+BOctpo=;
        b=LOj7j//Zmip3oc3+vPtP2nuyaw7jKUCNBs9aE4zp4x5YvlGe5UCZx8r4kB10Z6FAFg
         WTMVmaJKfydz1jzxwgyrZZWZoOKx5o2gN7J1MDPQMrTRcFbp68SMldFwUmAv5ipr/u7V
         BgNo3F0akYGVwQYaC5nXi0FOmBCJJYi1vS294d4lQ1EENF7+jITcPbNtRsCzR1WLeTG1
         EJ9cCf4QNUF3PtRXGLh9uULk0RBUh/61Y5XDuPa1ALy2lQdITOs/eebWD8dgWgFSnhp8
         VH+FhMWlYqDWDgKU2RCbLwRroa+i5wk9UExow/RS6RgTCLIIR+YXM+U4BHL3vb++/vUk
         kHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k0orSRUqVuqAAjknd8gNpZ+OTr37Fkr/H3F2+BOctpo=;
        b=dAlLe9M5GhseZnAqWA4CcmuulBM8PmMCeQS/SUGOh7f90Dd29iWGIqhaeLExf7BfWl
         K8rb8xlCaspUuaB0pVtm0Z5/SRaaBJ7PKuga4TrnvIvh2C5mypoQftJRxhzy7KIjEsyK
         CWd9ea+TBG1xMFUilrjjTh3LAHaiPblFTBQ/X/KISe7L2ZQkW1y558llg3cWi4UvZ2oU
         l6j8mbU6tZnCBDEWqg3cHUVKU7jx14g4QDGQN0DsMy9G9YeB5Elos2l0jbvy2yG3/gXp
         XezIP4PTfnJy2pjCjYqw6mdknoktuvbl0qv7weGNXu6QujlssPxp9TeKaRQpfQdhh67v
         SW+g==
X-Gm-Message-State: AOAM533a9vsT1tlA+MlEI+hQsMYYWak2CVhcaicn4fyfJYfmV6/udS8j
        6f9xhhWVdSBcmJ11ar/t3svaC8YGbSLr0Q==
X-Google-Smtp-Source: ABdhPJygFbFgx5UcZGyPCUvIoh0m+mwRTZJgIaBmlEI40i2m47/Uh7SwWM7cL+FRa9KMnC3MeQ48vg==
X-Received: by 2002:a17:902:a9ca:b029:e1:b3e:406c with SMTP id b10-20020a170902a9cab02900e10b3e406cmr22143547plr.84.1612891989900;
        Tue, 09 Feb 2021 09:33:09 -0800 (PST)
Received: from localhost.localdomain ([47.9.143.68])
        by smtp.gmail.com with ESMTPSA id g3sm20682607pfo.149.2021.02.09.09.33.07
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:33:09 -0800 (PST)
From:   shubham verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 04/10] t7001: modernize subshell formatting
Date:   Tue,  9 Feb 2021 23:02:48 +0530
Message-Id: <20210209173254.17712-5-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210209173254.17712-1-shubhunic@gmail.com>
References: <20210209173254.17712-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some test use an old style for formatting subshells:

        (command &&
            ...

Update them to the modern style:

        (
            command &&
            ...

Signed-off-by: shubham verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 74 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index f63802442b..a4a14a3b2e 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -181,38 +181,42 @@ test_expect_success "Sergey Vlasov's test case" '
 	git mv ab a
 '
 
-test_expect_success 'absolute pathname' '(
-	rm -fr mine &&
-	mkdir mine &&
-	cd mine &&
-	test_create_repo one &&
-	cd one &&
-	mkdir sub &&
-	>sub/file &&
-	git add sub/file &&
-
-	git mv sub "$(pwd)/in" &&
-	! test -d sub &&
-	test -d in &&
-	git ls-files --error-unmatch in/file
-)'
-
-test_expect_success 'absolute pathname outside should fail' '(
-	rm -fr mine &&
-	mkdir mine &&
-	cd mine &&
-	out=$(pwd) &&
-	test_create_repo one &&
-	cd one &&
-	mkdir sub &&
-	>sub/file &&
-	git add sub/file &&
-
-	test_must_fail git mv sub "$out/out" &&
-	test -d sub &&
-	! test -d ../in &&
-	git ls-files --error-unmatch sub/file
-)'
+test_expect_success 'absolute pathname' '
+	(
+		rm -fr mine &&
+		mkdir mine &&
+		cd mine &&
+		test_create_repo one &&
+		cd one &&
+		mkdir sub &&
+		>sub/file &&
+		git add sub/file &&
+
+		git mv sub "$(pwd)/in" &&
+		! test -d sub &&
+		test -d in &&
+		git ls-files --error-unmatch in/file
+	)
+'
+
+test_expect_success 'absolute pathname outside should fail' '
+	(
+		rm -fr mine &&
+		mkdir mine &&
+		cd mine &&
+		out=$(pwd) &&
+		test_create_repo one &&
+		cd one &&
+		mkdir sub &&
+		>sub/file &&
+		git add sub/file &&
+
+		test_must_fail git mv sub "$out/out" &&
+		test -d sub &&
+		! test -d ../in &&
+		git ls-files --error-unmatch sub/file
+	)
+'
 
 test_expect_success 'git mv to move multiple sources into a directory' '
 	rm -fr .git && git init &&
@@ -503,14 +507,16 @@ test_expect_success 'moving a submodule in nested directories' '
 test_expect_success 'moving nested submodules' '
 	git commit -am "cleanup commit" &&
 	mkdir sub_nested_nested &&
-	(cd sub_nested_nested &&
+	(
+		cd sub_nested_nested &&
 		touch nested_level2 &&
 		git init &&
 		git add . &&
 		git commit -m "nested level 2"
 	) &&
 	mkdir sub_nested &&
-	(cd sub_nested &&
+	(
+		cd sub_nested &&
 		touch nested_level1 &&
 		git init &&
 		git add . &&
-- 
2.25.1

