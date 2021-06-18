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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64301C49361
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4996B611ED
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbhFRS1z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbhFRS1w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:27:52 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD4EC06175F
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:41 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id v22-20020a0568301416b029044e2d8e855eso1374703otp.8
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p02Z3d8avkruD7P/4TyjJlR1dmPLjE+yztJ/CH9AeWI=;
        b=B0NH4Vwi/JeoLqFLE0gqPTyO8LeujUezt0xmcOjlEIJrbljIdCi6K5BpXdkFXKbXfC
         DTtLfkxJbr2Avh1PgYwXBnG7axdzbwXa84BlkJVgJgN6B9VZa/vcMK+Dno/wFMUeBgQy
         uttMAEv4YODFiqIL3blDTQSEybbG5gvmHpxQoM3cN1D6JheYZ5Xfih/4S0glrUPRRlKs
         6RgtelmXwtLb0t3xRVmGNA7r3st4WOaMuUmdJKtcz6vdWC7dF6wBhVEIvgvAq1hWh816
         2/Vk7oNMA9ZhapjVH55JI6Yy1NXUAjBDeMYE6wMs8hRX2F4KL+5MSvsyQsVo6PfU5Nbt
         xd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p02Z3d8avkruD7P/4TyjJlR1dmPLjE+yztJ/CH9AeWI=;
        b=q65BOtRcfWaU/cz3GmH25zeKOLk3wsZ9nyvRgs5BvCKJXbY0gBcyO3ivSp+FWx7zoU
         djlvQH3GU+u4JWvxWDY7ILQQiR9gc//eemOqep1ZJ7UK9q2Mq+VjJ3AI3x2Hnl+LNaF0
         qrfbIs13UB2bD54ugpZzthycRTApMS91m83lbvi3sePbmlteeLHtoq52eFggCrAsYUgn
         DPuPtSutRVApFrQOrZqhpDCIhmyP7L0iil9C8SUINffNQLsrzMdaTe2kcKRo2BGQJYuV
         X87XqldiG76QPrh/w/cTHfXk/564oHHMtzVEG8YZOY0zj6l/oY1ZkpzIS5BxOGds/lAE
         EPJA==
X-Gm-Message-State: AOAM5319gYQ6EGdVwDbVJ/MAJf9h3I3AbF2BRMmTdfoDwgTmh09cI0wT
        DPwL7VGBSjkpYRdBTCd/cnrcgFMqgD3S/A==
X-Google-Smtp-Source: ABdhPJxXEdds2yoei4ugJOR/jCJV6ZL9dSB+HRpT2RTKD+LlEYA+2K+k0BDBxzPfFTTTV6zuyjk/uA==
X-Received: by 2002:a9d:74c2:: with SMTP id a2mr10539966otl.324.1624040740423;
        Fri, 18 Jun 2021 11:25:40 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id v203sm1955550oib.37.2021.06.18.11.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:25:40 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 11/45] test: completion: add run_func() helper
Date:   Fri, 18 Jun 2021 13:24:44 -0500
Message-Id: <20210618182518.697912-12-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pretty straightforward: runs functions.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 58 ++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 34 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index d21dca4abd..bb3eebffb7 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -78,6 +78,12 @@ run_completion ()
 	__git_wrap__git_main && print_comp
 }
 
+run_func ()
+{
+	local -a COMPREPLY &&
+	"$@" && print_comp
+}
+
 # Test high-level completion
 # Arguments are:
 # 1: typed text so far (cur)
@@ -455,8 +461,7 @@ test_expect_success '__gitcomp_direct - puts everything into COMPREPLY as-is' '
 	EOF
 	(
 		cur=should_be_ignored &&
-		__gitcomp_direct "$(cat expected)" &&
-		print_comp
+		run_func __gitcomp_direct "$(cat expected)"
 	) &&
 	test_cmp expected out
 '
@@ -550,7 +555,7 @@ test_expect_success '__gitcomp - equal skip' '
 '
 
 test_expect_success '__gitcomp - doesnt fail because of invalid variable name' '
-	__gitcomp "$invalid_variable_name"
+	run_func __gitcomp "$invalid_variable_name"
 '
 
 read -r -d "" refs <<-\EOF
@@ -589,7 +594,7 @@ test_expect_success '__gitcomp_nl - no suffix' '
 '
 
 test_expect_success '__gitcomp_nl - doesnt fail because of invalid variable name' '
-	__gitcomp_nl "$invalid_variable_name"
+	run_func __gitcomp_nl "$invalid_variable_name"
 '
 
 test_expect_success '__git_remotes - list remotes from $GIT_DIR/remotes and from config file' '
@@ -1090,8 +1095,7 @@ test_expect_success '__git_complete_refs - simple' '
 	EOF
 	(
 		cur= &&
-		__git_complete_refs &&
-		print_comp
+		run_func __git_complete_refs
 	) &&
 	test_cmp expected out
 '
@@ -1103,8 +1107,7 @@ test_expect_success '__git_complete_refs - matching' '
 	EOF
 	(
 		cur=mat &&
-		__git_complete_refs &&
-		print_comp
+		run_func __git_complete_refs
 	) &&
 	test_cmp expected out
 '
@@ -1117,8 +1120,7 @@ test_expect_success '__git_complete_refs - remote' '
 	EOF
 	(
 		cur= &&
-		__git_complete_refs --remote=other &&
-		print_comp
+		run_func __git_complete_refs --remote=other
 	) &&
 	test_cmp expected out
 '
@@ -1136,8 +1138,7 @@ test_expect_success '__git_complete_refs - track' '
 	EOF
 	(
 		cur= &&
-		__git_complete_refs --track &&
-		print_comp
+		run_func __git_complete_refs --track
 	) &&
 	test_cmp expected out
 '
@@ -1149,8 +1150,7 @@ test_expect_success '__git_complete_refs - current word' '
 	EOF
 	(
 		cur="--option=mat" &&
-		__git_complete_refs --cur="${cur#*=}" &&
-		print_comp
+		run_func __git_complete_refs --cur="${cur#*=}"
 	) &&
 	test_cmp expected out
 '
@@ -1162,8 +1162,7 @@ test_expect_success '__git_complete_refs - prefix' '
 	EOF
 	(
 		cur=v1.0..mat &&
-		__git_complete_refs --pfx=v1.0.. --cur=mat &&
-		print_comp
+		run_func __git_complete_refs --pfx=v1.0.. --cur=mat
 	) &&
 	test_cmp expected out
 '
@@ -1179,8 +1178,7 @@ test_expect_success '__git_complete_refs - suffix' '
 	EOF
 	(
 		cur= &&
-		__git_complete_refs --sfx=. &&
-		print_comp
+		run_func __git_complete_refs --sfx=.
 	) &&
 	test_cmp expected out
 '
@@ -1193,8 +1191,7 @@ test_expect_success '__git_complete_fetch_refspecs - simple' '
 	EOF
 	(
 		cur= &&
-		__git_complete_fetch_refspecs other &&
-		print_comp
+		run_func __git_complete_fetch_refspecs other
 	) &&
 	test_cmp expected out
 '
@@ -1205,8 +1202,7 @@ test_expect_success '__git_complete_fetch_refspecs - matching' '
 	EOF
 	(
 		cur=br &&
-		__git_complete_fetch_refspecs other "" br &&
-		print_comp
+		run_func __git_complete_fetch_refspecs other "" br
 	) &&
 	test_cmp expected out
 '
@@ -1219,8 +1215,7 @@ test_expect_success '__git_complete_fetch_refspecs - prefix' '
 	EOF
 	(
 		cur="+" &&
-		__git_complete_fetch_refspecs other "+" ""  &&
-		print_comp
+		run_func __git_complete_fetch_refspecs other "+" ""
 	) &&
 	test_cmp expected out
 '
@@ -1233,8 +1228,7 @@ test_expect_success '__git_complete_fetch_refspecs - fully qualified' '
 	EOF
 	(
 		cur=refs/ &&
-		__git_complete_fetch_refspecs other "" refs/ &&
-		print_comp
+		run_func __git_complete_fetch_refspecs other "" refs/
 	) &&
 	test_cmp expected out
 '
@@ -1247,8 +1241,7 @@ test_expect_success '__git_complete_fetch_refspecs - fully qualified & prefix' '
 	EOF
 	(
 		cur=+refs/ &&
-		__git_complete_fetch_refspecs other + refs/ &&
-		print_comp
+		run_func __git_complete_fetch_refspecs other + refs/
 	) &&
 	test_cmp expected out
 '
@@ -1779,8 +1772,7 @@ test_path_completion ()
 		# unusual characters in path names.  By requesting only
 		# untracked files we do not have to bother adding any
 		# paths to the index in those tests.
-		__git_complete_index_file --others &&
-		print_comp
+		run_func __git_complete_index_file --others
 	) &&
 	test_cmp expected out
 }
@@ -2302,8 +2294,7 @@ do
 			words=(git push '$flag' other ma) &&
 			cword=${#words[@]} cur=${words[cword-1]} &&
 			__git_cmd_idx=1 &&
-			__git_complete_remote_or_refspec &&
-			print_comp
+			run_func __git_complete_remote_or_refspec
 		) &&
 		test_cmp expected out
 	'
@@ -2316,8 +2307,7 @@ do
 			words=(git push other '$flag' ma) &&
 			cword=${#words[@]} cur=${words[cword-1]} &&
 			__git_cmd_idx=1 &&
-			__git_complete_remote_or_refspec &&
-			print_comp
+			run_func __git_complete_remote_or_refspec
 		) &&
 		test_cmp expected out
 	'
-- 
2.32.0

