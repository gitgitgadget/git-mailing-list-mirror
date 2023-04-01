Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F13C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjDAIri (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjDAIrN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:47:13 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D92B2223E
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:46:49 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id cm7-20020a056830650700b006a11f365d13so11840404otb.0
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwPaSzTY7tGNZmZV6NfKWLJjnLy0H1qHBJiH/L9DCCQ=;
        b=NgO5bp4D2K6b56ML5EkhTvuVen4Dg/zcpo01NUdizPXbkjG2/whGNheGuuAlqmJHsM
         iYHDpHhkmf8WlEtQKuL4RWWS+WGpyLkt7hLIR/uNbijrjHb7MgDWfkr6QKCk5YgOWV1q
         6XU36SdNR/Es0rpQ96WFhMvVvIBp5f+SxhaecDZyUCY2Tp4ro3/MZIcrX7aB62wIbNV3
         wJRvINHe2lBil89vX5irs5O9dbIti9ecovt50d3q+0Cmph35r1OkxbEcJ94EJnRG/38R
         gBI6GaaHcuwADamoOAlkvpRAJVhlZde3+B7ol4BJpS8hXkxd6CX2FHNsBudK3ZY8Yf5B
         6i8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwPaSzTY7tGNZmZV6NfKWLJjnLy0H1qHBJiH/L9DCCQ=;
        b=5bIIvKRpuefRYUGeWyueccdDGDRnLZ6eahNnYuji9q23RQdgtS67MvhZXQ0fPUZIOS
         g2DkDO/2QdX8H1VxSS4qbY2D8lP3TdyR7D2T1El3tjw5h6cyC/N066AyCs8XToBcsSgU
         FBIfErlJ94UOC14Sw1SueV0Pfs7la8uc0h596ym4Cwgm4ImJnPs1qIuU8SRRZ/LxN9FA
         MWwn7DG7bgeOxOraDXBDGUj7K8FCSfndJoqlKftXlh1EdUfomoVKf6sVENi/o7AsauR6
         81BK8TvGATAusMUvUY6W8H87bT0R6D31AXJDUc5BUyvQ2X/3mgrTmKEdwkQOMJrZmqMu
         UtkQ==
X-Gm-Message-State: AAQBX9eneAAN1/7cR5KaM1a3JPankMiY6X7RBYGnVjTQuJJUK7qWApWs
        9wN2Yqj7cK0kz6DXCtBMGn+ZVU0OrQs=
X-Google-Smtp-Source: AKy350bFY8sAb2n4krNhTwWY6bfKltt0qBVywOw7VllEYYSWdHfA3AZEuZ43jBGd8U2DNx72iFMoOQ==
X-Received: by 2002:a9d:7ace:0:b0:6a1:6e94:4b1a with SMTP id m14-20020a9d7ace000000b006a16e944b1amr4979373otn.17.1680338808693;
        Sat, 01 Apr 2023 01:46:48 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id j5-20020a9d7385000000b006a14579a8besm2109947otk.43.2023.04.01.01.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:46:48 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 15/49] test: completion: add run_func() helper
Date:   Sat,  1 Apr 2023 02:45:52 -0600
Message-Id: <20230401084626.304356-16-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
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
index 9d973f21ce..a2f2f9dc09 100755
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
@@ -1931,8 +1924,7 @@ test_path_completion ()
 		# unusual characters in path names.  By requesting only
 		# untracked files we do not have to bother adding any
 		# paths to the index in those tests.
-		__git_complete_index_file --others &&
-		print_comp
+		run_func __git_complete_index_file --others
 	) &&
 	test_cmp expected out
 }
@@ -2487,8 +2479,7 @@ do
 			words=(git push '$flag' other ma) &&
 			cword=${#words[@]} cur=${words[cword-1]} &&
 			__git_cmd_idx=1 &&
-			__git_complete_remote_or_refspec &&
-			print_comp
+			run_func __git_complete_remote_or_refspec
 		) &&
 		test_cmp expected out
 	'
@@ -2501,8 +2492,7 @@ do
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
2.33.0

