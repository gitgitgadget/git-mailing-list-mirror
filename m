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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E78C43333
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA3B3207A3
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbhAACRU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbhAACRS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:18 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFD5C06179F
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:38 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id d203so23463748oia.0
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VLMpSTRlAuM7u1xP18xf9xJUMa7+vzKwPBvt4h7lThY=;
        b=pbdQKwFe7Lm+NEZeBflKLwdAj9VoZp8KAbnx5b6JMxNpABwS+qp0mu95/rTA7hr80L
         rHhYVt3VDUenwi2EAwKz1wvqilKdjXzSALvmRcTESDyQiztmrKo7zSDIrvCKP6mlAWy2
         PH4dKUDPgl/L2i/Lk8JgyjJogyhZwItdaSAu7jmu2Y1UUk8tpDQ6OiWpaD1VhhfuKbbR
         h/qL2qrF88qvIyhcAGuGSX0gN6bslc0A3tqtQsqTTScroalNx6/MOmE5s5CQcGsvKyIL
         lBR+uQYaP+liJOOTISCydDCTE25POZcgV2lOYNXNkhAieTeGorlyHHmxDReO6XgE4DjA
         HBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VLMpSTRlAuM7u1xP18xf9xJUMa7+vzKwPBvt4h7lThY=;
        b=G7QnCUdky+JUMx7pKJI6ptcmfRSY/7ajDr3Flaro6wB9neHfPceSYwT3njoJVp1VCo
         vGOQTAbB0S67LseWID9J2q5CfQPfTwzv80IwN0HHS2y9e2OLOk/lKl5Sih7auHtWEWhK
         BxSAbrbBNnC99GMrjEyEjjDKHrRj2fl/d6uNeLH+aqIb5xY03nGcrURbZMphRlXU2/TL
         AP86X7lfSjOIkB2XMfWeS5DsxJN2ojl5meWwGq0AbGvSX+SioseLPY/DnIyX07yjjdFX
         U88BK6Qcw7FXg0YX524NaUVrZ6cOdWbOpJ7WUoqbHJMcMIRS7idVCorsDpyg8ero5SiJ
         GqXQ==
X-Gm-Message-State: AOAM530BVa+ozwxosqK4lmMKFYkpZTCImDsj1QyK2TvT4YecSSsFC/0B
        rM55ObMkySEr5XbDExkmT/QcDKAA/01k9w==
X-Google-Smtp-Source: ABdhPJzEFvDDFVf8+AikCzSvPsenbrk6LbkpPFBLzxJi7mOKnGIljkfTMpvPjp1KylUL0nvxLywhmg==
X-Received: by 2002:aca:d6c5:: with SMTP id n188mr9244858oig.131.1609467397830;
        Thu, 31 Dec 2020 18:16:37 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id v13sm11286359ook.13.2020.12.31.18.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:16:37 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 08/47] test: completion: add run_func() helper
Date:   Thu, 31 Dec 2020 20:15:43 -0600
Message-Id: <20210101021622.798041-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
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
index 82bf0ee2e2..f6c60c609a 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -75,6 +75,12 @@ run_completion ()
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
@@ -452,8 +458,7 @@ test_expect_success '__gitcomp_direct - puts everything into COMPREPLY as-is' '
 	EOF
 	(
 		cur=should_be_ignored &&
-		__gitcomp_direct "$(cat expected)" &&
-		print_comp
+		run_func __gitcomp_direct "$(cat expected)"
 	) &&
 	test_cmp expected out
 '
@@ -547,7 +552,7 @@ test_expect_success '__gitcomp - equal skip' '
 '
 
 test_expect_success '__gitcomp - doesnt fail because of invalid variable name' '
-	__gitcomp "$invalid_variable_name"
+	run_func __gitcomp "$invalid_variable_name"
 '
 
 read -r -d "" refs <<-\EOF
@@ -586,7 +591,7 @@ test_expect_success '__gitcomp_nl - no suffix' '
 '
 
 test_expect_success '__gitcomp_nl - doesnt fail because of invalid variable name' '
-	__gitcomp_nl "$invalid_variable_name"
+	run_func __gitcomp_nl "$invalid_variable_name"
 '
 
 test_expect_success '__git_remotes - list remotes from $GIT_DIR/remotes and from config file' '
@@ -1087,8 +1092,7 @@ test_expect_success '__git_complete_refs - simple' '
 	EOF
 	(
 		cur= &&
-		__git_complete_refs &&
-		print_comp
+		run_func __git_complete_refs
 	) &&
 	test_cmp expected out
 '
@@ -1100,8 +1104,7 @@ test_expect_success '__git_complete_refs - matching' '
 	EOF
 	(
 		cur=mat &&
-		__git_complete_refs &&
-		print_comp
+		run_func __git_complete_refs
 	) &&
 	test_cmp expected out
 '
@@ -1114,8 +1117,7 @@ test_expect_success '__git_complete_refs - remote' '
 	EOF
 	(
 		cur= &&
-		__git_complete_refs --remote=other &&
-		print_comp
+		run_func __git_complete_refs --remote=other
 	) &&
 	test_cmp expected out
 '
@@ -1133,8 +1135,7 @@ test_expect_success '__git_complete_refs - track' '
 	EOF
 	(
 		cur= &&
-		__git_complete_refs --track &&
-		print_comp
+		run_func __git_complete_refs --track
 	) &&
 	test_cmp expected out
 '
@@ -1146,8 +1147,7 @@ test_expect_success '__git_complete_refs - current word' '
 	EOF
 	(
 		cur="--option=mat" &&
-		__git_complete_refs --cur="${cur#*=}" &&
-		print_comp
+		run_func __git_complete_refs --cur="${cur#*=}"
 	) &&
 	test_cmp expected out
 '
@@ -1159,8 +1159,7 @@ test_expect_success '__git_complete_refs - prefix' '
 	EOF
 	(
 		cur=v1.0..mat &&
-		__git_complete_refs --pfx=v1.0.. --cur=mat &&
-		print_comp
+		run_func __git_complete_refs --pfx=v1.0.. --cur=mat
 	) &&
 	test_cmp expected out
 '
@@ -1176,8 +1175,7 @@ test_expect_success '__git_complete_refs - suffix' '
 	EOF
 	(
 		cur= &&
-		__git_complete_refs --sfx=. &&
-		print_comp
+		run_func __git_complete_refs --sfx=.
 	) &&
 	test_cmp expected out
 '
@@ -1190,8 +1188,7 @@ test_expect_success '__git_complete_fetch_refspecs - simple' '
 	EOF
 	(
 		cur= &&
-		__git_complete_fetch_refspecs other &&
-		print_comp
+		run_func __git_complete_fetch_refspecs other
 	) &&
 	test_cmp expected out
 '
@@ -1202,8 +1199,7 @@ test_expect_success '__git_complete_fetch_refspecs - matching' '
 	EOF
 	(
 		cur=br &&
-		__git_complete_fetch_refspecs other "" br &&
-		print_comp
+		run_func __git_complete_fetch_refspecs other "" br
 	) &&
 	test_cmp expected out
 '
@@ -1216,8 +1212,7 @@ test_expect_success '__git_complete_fetch_refspecs - prefix' '
 	EOF
 	(
 		cur="+" &&
-		__git_complete_fetch_refspecs other "+" ""  &&
-		print_comp
+		run_func __git_complete_fetch_refspecs other "+" ""
 	) &&
 	test_cmp expected out
 '
@@ -1230,8 +1225,7 @@ test_expect_success '__git_complete_fetch_refspecs - fully qualified' '
 	EOF
 	(
 		cur=refs/ &&
-		__git_complete_fetch_refspecs other "" refs/ &&
-		print_comp
+		run_func __git_complete_fetch_refspecs other "" refs/
 	) &&
 	test_cmp expected out
 '
@@ -1244,8 +1238,7 @@ test_expect_success '__git_complete_fetch_refspecs - fully qualified & prefix' '
 	EOF
 	(
 		cur=+refs/ &&
-		__git_complete_fetch_refspecs other + refs/ &&
-		print_comp
+		run_func __git_complete_fetch_refspecs other + refs/
 	) &&
 	test_cmp expected out
 '
@@ -1776,8 +1769,7 @@ test_path_completion ()
 		# unusual characters in path names.  By requesting only
 		# untracked files we do not have to bother adding any
 		# paths to the index in those tests.
-		__git_complete_index_file --others &&
-		print_comp
+		run_func __git_complete_index_file --others
 	) &&
 	test_cmp expected out
 }
@@ -2281,8 +2273,7 @@ do
 		(
 			words=(git push '$flag' other ma) &&
 			cword=${#words[@]} cur=${words[cword-1]} &&
-			__git_complete_remote_or_refspec &&
-			print_comp
+			run_func __git_complete_remote_or_refspec
 		) &&
 		test_cmp expected out
 	'
@@ -2294,8 +2285,7 @@ do
 		(
 			words=(git push other '$flag' ma) &&
 			cword=${#words[@]} cur=${words[cword-1]} &&
-			__git_complete_remote_or_refspec &&
-			print_comp
+			run_func __git_complete_remote_or_refspec
 		) &&
 		test_cmp expected out
 	'
-- 
2.30.0

