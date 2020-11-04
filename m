Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A70C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC7B2067B
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVmHlpai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbgKDRrW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 12:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730773AbgKDRrV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 12:47:21 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52901C0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 09:47:21 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id l36so12097849ota.4
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 09:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jX1I/11xj2Js1SC6Xf3WAOTlZscFqgixgujNsZTgEKU=;
        b=cVmHlpaiBPGX5rj4v1m78GDcUQWX3N6ZpGmZFMlxfn3bwqbFDNbVaWtdvnVrURsT+y
         gSaET/E3bhqKkBJgk2O78w+o13tm0ansktoAD0ANs/YRPUHizfeq3/M1qF7Mm53bRgDY
         8n6BxsRFFwqThoVVccVJPJnrDSNZ3gOHez3Dw9MDefEWhNcuesHsU4EYklGObaXgRq7F
         9MVOMm/dI3wZo/xWbxfbSJCOGJT30sxymbM7q4om4zx3IT2lDGL41amiUTL7OFpim+mi
         EMygMa9v+arjSXZC3zR6cFsbpOYNZcRlb6hU89dBGo7pXiyBuqmUCOa66QpzK+sKGUCr
         LARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jX1I/11xj2Js1SC6Xf3WAOTlZscFqgixgujNsZTgEKU=;
        b=D0aLI6L0slJAfbRKy8EFl3ENXwrmbLOU8avePQgPFz0drA1la3OyDwik1ikpNAk6K9
         qhvlCUKyVMJ1URG1konFuotm04OiOGiAvLhRINIyBCPy5IAig9ftoAsiVW30ALr3FVWX
         V6fripKbEh0BC7NvPCwYq1tMNF0eCDaF5O+NMm3hcw6pZ9hvUbG0o40Wbb9uHeXnSVT5
         KaQ2hClZYaBCS+AWRXI4/e1krfc0UMhZBKHbx+pTofxjoIWjoBysAvIEN05sHL5iVBR0
         GMNBC+8JXqSI4ijtrngM59acEzF5KWHgi6YDMSkhYghSlB3xBd2lYO/JzXH+Mv39RuY2
         c3pg==
X-Gm-Message-State: AOAM533pm8iFYDAlmCQagyxrrWdUP1sJlvuQXuuAXTFmXkh4vUT8FG9d
        tu6rECWmwRIJr+FBAsm9SD8QCo+WIOfwPQ==
X-Google-Smtp-Source: ABdhPJxm8eFzCvUyX1GwHbdSSlxlkv/t0uL86p6btXfla+FXhugCEfZyaVE6pub9OubgEIvefXmvwQ==
X-Received: by 2002:a9d:d73:: with SMTP id 106mr3152901oti.36.1604512040478;
        Wed, 04 Nov 2020 09:47:20 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 8sm607872oii.45.2020.11.04.09.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 09:47:19 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 01/10] test: completion: add run_func() helper
Date:   Wed,  4 Nov 2020 11:47:07 -0600
Message-Id: <20201104174716.783348-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201104174716.783348-1-felipe.contreras@gmail.com>
References: <20201104174716.783348-1-felipe.contreras@gmail.com>
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
index 7b7bc6e4bd..ab5134cdcc 100755
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
@@ -538,7 +543,7 @@ test_expect_success '__gitcomp - expand/narrow all negative options' '
 '
 
 test_expect_success '__gitcomp - doesnt fail because of invalid variable name' '
-	__gitcomp "$invalid_variable_name"
+	run_func __gitcomp "$invalid_variable_name"
 '
 
 read -r -d "" refs <<-\EOF
@@ -577,7 +582,7 @@ test_expect_success '__gitcomp_nl - no suffix' '
 '
 
 test_expect_success '__gitcomp_nl - doesnt fail because of invalid variable name' '
-	__gitcomp_nl "$invalid_variable_name"
+	run_func __gitcomp_nl "$invalid_variable_name"
 '
 
 test_expect_success '__git_remotes - list remotes from $GIT_DIR/remotes and from config file' '
@@ -1077,8 +1082,7 @@ test_expect_success '__git_complete_refs - simple' '
 	EOF
 	(
 		cur= &&
-		__git_complete_refs &&
-		print_comp
+		run_func __git_complete_refs
 	) &&
 	test_cmp expected out
 '
@@ -1090,8 +1094,7 @@ test_expect_success '__git_complete_refs - matching' '
 	EOF
 	(
 		cur=mat &&
-		__git_complete_refs &&
-		print_comp
+		run_func __git_complete_refs
 	) &&
 	test_cmp expected out
 '
@@ -1104,8 +1107,7 @@ test_expect_success '__git_complete_refs - remote' '
 	EOF
 	(
 		cur= &&
-		__git_complete_refs --remote=other &&
-		print_comp
+		run_func __git_complete_refs --remote=other
 	) &&
 	test_cmp expected out
 '
@@ -1123,8 +1125,7 @@ test_expect_success '__git_complete_refs - track' '
 	EOF
 	(
 		cur= &&
-		__git_complete_refs --track &&
-		print_comp
+		run_func __git_complete_refs --track
 	) &&
 	test_cmp expected out
 '
@@ -1136,8 +1137,7 @@ test_expect_success '__git_complete_refs - current word' '
 	EOF
 	(
 		cur="--option=mat" &&
-		__git_complete_refs --cur="${cur#*=}" &&
-		print_comp
+		run_func __git_complete_refs --cur="${cur#*=}"
 	) &&
 	test_cmp expected out
 '
@@ -1149,8 +1149,7 @@ test_expect_success '__git_complete_refs - prefix' '
 	EOF
 	(
 		cur=v1.0..mat &&
-		__git_complete_refs --pfx=v1.0.. --cur=mat &&
-		print_comp
+		run_func __git_complete_refs --pfx=v1.0.. --cur=mat
 	) &&
 	test_cmp expected out
 '
@@ -1166,8 +1165,7 @@ test_expect_success '__git_complete_refs - suffix' '
 	EOF
 	(
 		cur= &&
-		__git_complete_refs --sfx=. &&
-		print_comp
+		run_func __git_complete_refs --sfx=.
 	) &&
 	test_cmp expected out
 '
@@ -1180,8 +1178,7 @@ test_expect_success '__git_complete_fetch_refspecs - simple' '
 	EOF
 	(
 		cur= &&
-		__git_complete_fetch_refspecs other &&
-		print_comp
+		run_func __git_complete_fetch_refspecs other
 	) &&
 	test_cmp expected out
 '
@@ -1192,8 +1189,7 @@ test_expect_success '__git_complete_fetch_refspecs - matching' '
 	EOF
 	(
 		cur=br &&
-		__git_complete_fetch_refspecs other "" br &&
-		print_comp
+		run_func __git_complete_fetch_refspecs other "" br
 	) &&
 	test_cmp expected out
 '
@@ -1206,8 +1202,7 @@ test_expect_success '__git_complete_fetch_refspecs - prefix' '
 	EOF
 	(
 		cur="+" &&
-		__git_complete_fetch_refspecs other "+" ""  &&
-		print_comp
+		run_func __git_complete_fetch_refspecs other "+" ""
 	) &&
 	test_cmp expected out
 '
@@ -1220,8 +1215,7 @@ test_expect_success '__git_complete_fetch_refspecs - fully qualified' '
 	EOF
 	(
 		cur=refs/ &&
-		__git_complete_fetch_refspecs other "" refs/ &&
-		print_comp
+		run_func __git_complete_fetch_refspecs other "" refs/
 	) &&
 	test_cmp expected out
 '
@@ -1234,8 +1228,7 @@ test_expect_success '__git_complete_fetch_refspecs - fully qualified & prefix' '
 	EOF
 	(
 		cur=+refs/ &&
-		__git_complete_fetch_refspecs other + refs/ &&
-		print_comp
+		run_func __git_complete_fetch_refspecs other + refs/
 	) &&
 	test_cmp expected out
 '
@@ -1714,8 +1707,7 @@ test_path_completion ()
 		# unusual characters in path names.  By requesting only
 		# untracked files we do not have to bother adding any
 		# paths to the index in those tests.
-		__git_complete_index_file --others &&
-		print_comp
+		run_func __git_complete_index_file --others
 	) &&
 	test_cmp expected out
 }
@@ -2200,8 +2192,7 @@ do
 		(
 			words=(git push '$flag' other ma) &&
 			cword=${#words[@]} cur=${words[cword-1]} &&
-			__git_complete_remote_or_refspec &&
-			print_comp
+			run_func __git_complete_remote_or_refspec
 		) &&
 		test_cmp expected out
 	'
@@ -2213,8 +2204,7 @@ do
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
2.29.2

