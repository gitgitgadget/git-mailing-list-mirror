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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBF6C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A6E96115C
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhDZQQY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbhDZQQX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:16:23 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495E8C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:15:41 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso47826299otv.6
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uE+ln/DWyAKHmlptpr6V9OW1SY6SWtAUNqAMRFnMuDY=;
        b=GXCcaKPDuvTlORWA5fCUTDtwqF/lrpD1E5Bpxj0ieM5qjM1lDJnwkRmx1WA3VsbNXR
         pTbSWKeQNhEMs9j6bK7BTFJe4emRGPxN3l1oaorz997nzAk7PweeSvjor6jqrQFIYbOP
         pOChlv4A2tfRnzcFHtEGk3HHq4toD1+5kLJUG/AqDvjHYrZp1MVHGKGf0HQP+nsxxI8v
         i/IKq9jv5CD6H0J3xtXwi92bpASqtmT38YIERTxDAFL1KbjXDI7rzFWBqnbqb9fx632N
         MXPfG7/hJ/G4r28AtxG7uSgS/n9Apst0r2RZ1YUNfFsBOwUmFlDoXCqhTwMxT1WBttQa
         zbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uE+ln/DWyAKHmlptpr6V9OW1SY6SWtAUNqAMRFnMuDY=;
        b=Prjb/VH+sNKP8prbtSHErl0zOK3VYq456hin7A/TMVE15rtv2ed0hSqAYgeiPTLOrj
         fLqu0EYShCEOXcsgJfELqenwGXgr/rWFFkD9/Nfn1YBup5Tk8uSxZlIotqDy0nKdDgio
         VSf4Zd2TQhRcGLIzrih5/igXoi93zKh/XMlAbPsNmSB+Cq1bRahj2+ivPXQZDCPzbi83
         tEG86p0AqxyRtrbQYa8AA3ITrkWCWdJMKZEeEcxFeZwMHXmab/2pJAxptQZ/bUnn0m4b
         q5UQpuwthGCueHpK35Uk1SYozI7WcL1hBQK/KxZ5Oenl3AmSPttDp57gAv3N/+ZkgGV7
         mAKA==
X-Gm-Message-State: AOAM532u9whXlslMTYJ0vaduNaZoxySkdhVfooDMFqXnkX897oNwg+qQ
        pEZD5JouYVIO5RyLBx2K28TbZ1gV4u6L6w==
X-Google-Smtp-Source: ABdhPJxGnHe4lJhc/ilxBHbWXSIZSpzjAgQGtsA5J/Y5Q8Ttr3p9wHoFRIuIuJeAvOXEp7293fabNg==
X-Received: by 2002:a9d:6b0e:: with SMTP id g14mr15273404otp.214.1619453740478;
        Mon, 26 Apr 2021 09:15:40 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id b22sm3603330ots.59.2021.04.26.09.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:15:40 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 08/43] test: completion: add run_func() helper
Date:   Mon, 26 Apr 2021 11:14:23 -0500
Message-Id: <20210426161458.49860-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
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
index 13bdf634a6..3528463047 100755
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
@@ -2284,8 +2276,7 @@ do
 		(
 			words=(git push '$flag' other ma) &&
 			cword=${#words[@]} cur=${words[cword-1]} &&
-			__git_complete_remote_or_refspec &&
-			print_comp
+			run_func __git_complete_remote_or_refspec
 		) &&
 		test_cmp expected out
 	'
@@ -2297,8 +2288,7 @@ do
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
2.31.0

