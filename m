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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA50EC433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9894E64EA6
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhBIRfk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 12:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbhBIReb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 12:34:31 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C3EC06178B
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 09:33:15 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id k22so5759548pll.6
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 09:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kMTSMccCEqbDu4PyMUsL69kEc2V3WsXSmJCj8lXCwU0=;
        b=YDbDKNjKXjuZUoUve45N+pQgA6fZZ//QMbxCvdBqdJzChieh91pmGC9Q+1p8S2fyzk
         XuumMDMZsnfNf951JTwR6lY12r8Fg5h/BWHl3r+NoWIKIpoUYBPzrcQF8tKVWv7Vv4kO
         Ip9+rgXn9uOdaVJTcRWpzvg9aEh387+B6iIYHTCk9S37LZVXgj1MZdbXKV6qWcS/rM0q
         O7+OXdC8jNHurXcnB3/AtXdqkH5UPksWsDQ6rI19UsdQh1GUAH2tEYkaPO2UKc490M7f
         HUfR5NZMtdg+yNebF9Zjpu6XBpbQwy71UgHuU4+vAugv9m4yMX/6YHv9zv4eKNlsz4I1
         XAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kMTSMccCEqbDu4PyMUsL69kEc2V3WsXSmJCj8lXCwU0=;
        b=brRtmTnrI+VyUuZxe4ZNXdyQC9nSU+U+w0hF6deuliylAt0whauBElLGXbWERPFZON
         PAElXHxLkfUTzA5PKr4ZliKm6+hi3l5CdAm3xhYyUqaOpt8Yk3M22h7qXvZz13CAUsj2
         7lNpu8hV6sYWDkVVyej/U4GBl6bse4VtPdo26loDsx5MHiY2CO41pLufj1BGuH2qYttd
         dfjJiMKbOZg6/1k8M4VAwA/tb6n3HqCpwdCVKcOdFuOlJ7HEM/M1DP/5zsxSOmEhDvsb
         8s4Zz1wxndO673mazELnmW9jh43H/buhJP2JWlmR1KDx3pvFXQwnA3bj1UZ6C8moQeLG
         XCiQ==
X-Gm-Message-State: AOAM530CxvuRbty+O8BoS/I1TZBeokOAZL+9P2IZ6WL0Ed6+1aMzt5s+
        S7O/2dbBBsAx4af0vFGrYQdmjIt2GpNU3g==
X-Google-Smtp-Source: ABdhPJwMOBH+LeIq1kuOC2o3iG8UHQZ+927WmDxX5pVDMIiep742aXjcCaQZehGaFj3EEUXbIt/H5Q==
X-Received: by 2002:a17:902:7201:b029:e0:ee2:dae6 with SMTP id ba1-20020a1709027201b02900e00ee2dae6mr21482463plb.25.1612891994839;
        Tue, 09 Feb 2021 09:33:14 -0800 (PST)
Received: from localhost.localdomain ([47.9.143.68])
        by smtp.gmail.com with ESMTPSA id g3sm20682607pfo.149.2021.02.09.09.33.12
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:33:14 -0800 (PST)
From:   shubham verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 06/10] t7001: avoid using `cd` outside of subshells
Date:   Tue,  9 Feb 2021 23:02:50 +0530
Message-Id: <20210209173254.17712-7-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210209173254.17712-1-shubhunic@gmail.com>
References: <20210209173254.17712-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid using `cd` outside of subshells since, if the test fails,
there is no guarantee that the current working directory is the
expected one, which may cause subsequent tests to run in the wrong
directory.

While at it, make some other tests more concise by replacing
simple subshells with `git -C`.

Signed-off-by: shubham verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 45 +++++++++++----------------------------------
 1 file changed, 11 insertions(+), 34 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 02fbc90dea..81897a3095 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -11,12 +11,11 @@ test_expect_success 'prepare reference tree' '
 '
 
 test_expect_success 'moving the file out of subdirectory' '
-	cd path0 && git mv COPYING ../path1/COPYING
+	git -C path0 mv COPYING ../path1/COPYING
 '
 
-# in path0 currently
 test_expect_success 'commiting the change' '
-	cd .. && git commit -m move-out -a
+	git commit -m move-out -a
 '
 
 test_expect_success 'checking the commit' '
@@ -25,12 +24,11 @@ test_expect_success 'checking the commit' '
 '
 
 test_expect_success 'moving the file back into subdirectory' '
-	cd path0 && git mv ../path1/COPYING COPYING
+	git -C path0 mv ../path1/COPYING COPYING
 '
 
-# in path0 currently
 test_expect_success 'commiting the change' '
-	cd .. && git commit -m move-in -a
+	git commit -m move-in -a
 '
 
 test_expect_success 'checking the commit' '
@@ -328,10 +326,7 @@ test_expect_success 'git mv moves a submodule with a .git directory and no .gitm
 	git mv sub mod/sub &&
 	! test -e sub &&
 	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
-	(
-		cd mod/sub &&
-		git status
-	) &&
+	git -C mod/sub status &&
 	git update-index --refresh &&
 	git diff-files --quiet
 '
@@ -351,10 +346,7 @@ test_expect_success 'git mv moves a submodule with a .git directory and .gitmodu
 	git mv sub mod/sub &&
 	! test -e sub &&
 	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
-	(
-		cd mod/sub &&
-		git status
-	) &&
+	git -C mod/sub status &&
 	echo mod/sub >expected &&
 	git config -f .gitmodules submodule.sub.path >actual &&
 	test_cmp expected actual &&
@@ -368,16 +360,10 @@ test_expect_success 'git mv moves a submodule with gitfile' '
 	git submodule update &&
 	entry="$(git ls-files --stage sub | cut -f 1)" &&
 	mkdir mod &&
-	(
-		cd mod &&
-		git mv ../sub/ .
-	) &&
+	git -C mod mv ../sub/ . &&
 	! test -e sub &&
 	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
-	(
-		cd mod/sub &&
-		git status
-	) &&
+	git -C mod/sub status &&
 	echo mod/sub >expected &&
 	git config -f .gitmodules submodule.sub.path >actual &&
 	test_cmp expected actual &&
@@ -396,10 +382,7 @@ test_expect_success 'mv does not complain when no .gitmodules file is found' '
 	test_must_be_empty actual.err &&
 	! test -e sub &&
 	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
-	(
-		cd mod/sub &&
-		git status
-	) &&
+	git -C mod/sub status &&
 	git update-index --refresh &&
 	git diff-files --quiet
 '
@@ -420,10 +403,7 @@ test_expect_success 'mv will error out on a modified .gitmodules file unless sta
 	test_must_be_empty actual.err &&
 	! test -e sub &&
 	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
-	(
-		cd mod/sub &&
-		git status
-	) &&
+	git -C mod/sub status &&
 	git update-index --refresh &&
 	git diff-files --quiet
 '
@@ -441,10 +421,7 @@ test_expect_success 'mv issues a warning when section is not found in .gitmodule
 	test_i18ncmp expect.err actual.err &&
 	! test -e sub &&
 	[ "$entry" = "$(git ls-files --stage mod/sub | cut -f 1)" ] &&
-	(
-		cd mod/sub &&
-		git status
-	) &&
+	git -C mod/sub status &&
 	git update-index --refresh &&
 	git diff-files --quiet
 '
-- 
2.25.1

