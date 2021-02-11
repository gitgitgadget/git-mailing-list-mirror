Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158CDC433E9
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD2B464E4D
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhBKTtM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 14:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhBKTsR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 14:48:17 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8825EC0617AA
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:47:21 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id o63so4644203pgo.6
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=59HdyrGbW0mTL24biggdJfhnFcKsv/h3JsK/7auLcxk=;
        b=tPZPIdPnty1M2zzHGHCiJ+L5beaXpSJOIxf+GYd3LqpZG36lVHn9PCs8/WPY82I0C+
         EH+2Ip4KxNpaI9d+4M5IWeIWjtEDHT4+87lLV1beECCjL0aLlqHrE6dB1hoCYu6m1hmw
         hAaUP7h71zmElSNS7sC8hx3m0hw27XrGTRdQlhszgLuEvW7gNSw+ZRpk4FcLTaHqS7z1
         r5s94V6GdXw9cFwvFhncNoD7xjjm892DS+XSPEH+aoNmKPC/4NNprdqdY3o9omZ9dXPC
         rx3HNJylUuhJ/LwPAr6EvtOkg3ZOGXcEhEXf5NOcOHbsoFN3eMWMwD5sG/6bxgc1ZvJm
         zZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=59HdyrGbW0mTL24biggdJfhnFcKsv/h3JsK/7auLcxk=;
        b=U41WIPcLlpdGd/bo54+gfHvM1YegIgs/3gtyxe+I0NZuQ/9+yrJRPR8mgYa4sUKy+0
         XvGgATGcsdT+og+x8/nPHYj5Z5UyKQXvPXXbDVquchBafYvH1DlS4j5ILDovmY/6Gxbm
         GQwWg1Tl7AUpUNcZ08J/nFnymZZXIFynNGQC6MCNmu59uU4ng5AvUmXDxF0PaugT3HT5
         HZpnjp2hRLDAKn3Yorq7QmB5op2Tcj2uLodKv05Z6O3eSnQps55Ipne73ZX3s7yvmZbL
         EeumfS/bCgV4AkQIoDE81uKEmJbyLU/DdsVRM1p1aSA7O9yjw6Cb1wII7HWZI95f4tHv
         8GYA==
X-Gm-Message-State: AOAM533hBfXhLTnrgsawlOICeyzxWxsEiDdaz3lWOE8Bwjmrwufalcay
        YVT8wytLAqTEhjVRvQzfgU5dwW0zWNGW3w==
X-Google-Smtp-Source: ABdhPJwHhwQqXnhtwYCpX4Cv0fDaEV6G7W5nKVbwzw+6qA2TCNFCyuf7dl85ubzT+EVoB4pVF6KuQA==
X-Received: by 2002:a63:3648:: with SMTP id d69mr9564712pga.155.1613072840813;
        Thu, 11 Feb 2021 11:47:20 -0800 (PST)
Received: from localhost.localdomain ([47.8.36.172])
        by smtp.gmail.com with ESMTPSA id a141sm6524778pfa.189.2021.02.11.11.47.19
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 11:47:20 -0800 (PST)
From:   Shubham Verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 04/10] t7001: modernize subshell formatting
Date:   Fri, 12 Feb 2021 01:16:58 +0530
Message-Id: <20210211194704.28913-5-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211194704.28913-1-shubhunic@gmail.com>
References: <20210211194704.28913-1-shubhunic@gmail.com>
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

Signed-off-by: Shubham Verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 74 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index e98b44f7a1..7fd4341988 100755
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

