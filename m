Return-Path: <SRS0=2Qsv=4E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9317CC2BA83
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 13:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B75E206E2
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 13:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Is01VMUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgBPNst (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 08:48:49 -0500
Received: from mail-pj1-f45.google.com ([209.85.216.45]:37177 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgBPNsr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 08:48:47 -0500
Received: by mail-pj1-f45.google.com with SMTP id m13so6045347pjb.2
        for <git@vger.kernel.org>; Sun, 16 Feb 2020 05:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=phce1YG89K2DiWi9AV0W3fuWNMTbfQqY3TC8VVb4d4A=;
        b=Is01VMUTx72W6pcsxUFNBnkDYsPzOmcpCUO5vrMNgaticJEKlI8IUfRnPXGlCyqWDg
         mTkFRNpbxeeipPwI9cTUyL10bi54F1/fMgq+E/yits0byVlHJ1i/3D4ombbJAxpwfXBZ
         dDExOicN88/aLI4ehWtn8e/TbzmGr8YM40gum0evC/z2qHd9zZbz5ghaoP4dP0fDArIN
         ++CBgPgAqxID+kTcgdYNnMGQE4UOJOziWg48MWV0KSPaZpipLNpkDx33FAYH/jGSLhR8
         tCAr4twbTvssmtyphwhzd30Dznvk2sZ5n4RxiBemn6vk/Qd4ohCPH9JE/fyGQJBRK/3M
         V7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=phce1YG89K2DiWi9AV0W3fuWNMTbfQqY3TC8VVb4d4A=;
        b=sXSpW/IMNMOLSBDq15XuO2UMeQNzxDiBOUYh3JeRGsl9Opdgpg5RRbkz3xZUVpLC56
         Au44e0NJusjYqMmEzr4kDR1vedtol+UUrQClVFau/Qc1AJF/9FOl5OKXoFDX/Hx/gRtg
         G8bKC4Ch0CAPDt4LqYA/LwV95X3wSPsh76acWjIw3CY/aGmmLn9bqpCZ2NzTNqegh2qM
         hh/N+fr1Qc3sLF8Kc/JRXaE+14g65Qub5FnqzQTN0JouDcw1vk5d2Rbs7HD0ZyaBtr1j
         qeqtckygn3nRgtnC+8oV5puHvqLtqy6130hg2MMCABfIgr3bEE13ROem6RNrs7xTPeP0
         6vRw==
X-Gm-Message-State: APjAAAVyoROM/vUTLeq6Lo1BZKSgUhUaZnOGPRz1h7LuAgkZiIzv4EV6
        owsRGLuztjPFKblToCK4fJb2xh4lpBE=
X-Google-Smtp-Source: APXvYqwMOdgkJQlCuXjoz3mmX54+P1JHPeoE9QVLn+r208vhHSsfUeL4K+QbLLrO2zoHP6GaLHh97g==
X-Received: by 2002:a17:90a:d80b:: with SMTP id a11mr14744800pjv.142.1581860926745;
        Sun, 16 Feb 2020 05:48:46 -0800 (PST)
Received: from Abhishek-Arch.nitk.ac.in ([218.248.46.83])
        by smtp.gmail.com with ESMTPSA id m12sm13302006pjf.25.2020.02.16.05.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 05:48:46 -0800 (PST)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [GSoC Patch 3/5] t4215: use lib-log-graph functions
Date:   Sun, 16 Feb 2020 19:17:48 +0530
Message-Id: <20200216134750.18947-3-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200216134750.18947-1-abhishekkumar8222@gmail.com>
References: <20200216134750.18947-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 t/t4215-log-skewed-merges.sh | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index 1d0d3240ff..bca478cb83 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -3,13 +3,7 @@
 test_description='git log --graph of skewed merges'
 
 . ./test-lib.sh
-
-check_graph () {
-	cat >expect &&
-	git log --graph --pretty=tformat:%s "$@" >actual.raw &&
-	sed "s/ *$//" actual.raw >actual &&
-	test_cmp expect actual
-}
+. "$TEST_DIRECTORY"/lib-log-graph.sh
 
 test_expect_success 'log --graph with merge fusing with its left and right neighbors' '
 	git checkout --orphan _p &&
@@ -22,7 +16,7 @@ test_expect_success 'log --graph with merge fusing with its left and right neigh
 	git checkout _p && git merge --no-ff _r -m G &&
 	git checkout @^^ && git merge --no-ff _p -m H &&
 
-	check_graph <<-\EOF
+	test_cmp_graph --pretty=tformat:%s <<-\EOF
 	*   H
 	|\
 	| *   G
@@ -50,7 +44,7 @@ test_expect_success 'log --graph with left-skewed merge' '
 	git checkout 0_p && git merge --no-ff 0_s -m 0_G &&
 	git checkout @^ && git merge --no-ff 0_q 0_r 0_t 0_p -m 0_H &&
 
-	check_graph <<-\EOF
+	test_cmp_graph --pretty=tformat:%s <<-\EOF
 	*-----.   0_H
 	|\ \ \ \
 	| | | | * 0_G
@@ -84,7 +78,7 @@ test_expect_success 'log --graph with nested left-skewed merge' '
 	git checkout 1_p && git merge --no-ff 1_r -m 1_G &&
 	git checkout @^^ && git merge --no-ff 1_p -m 1_H &&
 
-	check_graph <<-\EOF
+	test_cmp_graph --pretty=tformat:%s <<-\EOF
 	*   1_H
 	|\
 	| *   1_G
@@ -116,7 +110,7 @@ test_expect_success 'log --graph with nested left-skewed merge following normal
 	git checkout -b 2_s @^^ && git merge --no-ff 2_q -m 2_J &&
 	git checkout 2_p && git merge --no-ff 2_s -m 2_K &&
 
-	check_graph <<-\EOF
+	test_cmp_graph --pretty=tformat:%s <<-\EOF
 	*   2_K
 	|\
 	| *   2_J
@@ -152,7 +146,7 @@ test_expect_success 'log --graph with nested right-skewed merge following left-s
 	git checkout 3_p && git merge --no-ff 3_r -m 3_H &&
 	git checkout @^^ && git merge --no-ff 3_p -m 3_J &&
 
-	check_graph <<-\EOF
+	test_cmp_graph --pretty=tformat:%s <<-\EOF
 	*   3_J
 	|\
 	| *   3_H
@@ -183,7 +177,7 @@ test_expect_success 'log --graph with right-skewed merge following a left-skewed
 	git merge --no-ff 4_p -m 4_G &&
 	git checkout @^^ && git merge --no-ff 4_s -m 4_H &&
 
-	check_graph --date-order <<-\EOF
+	test_cmp_graph --pretty=tformat:%s --date-order <<-\EOF
 	*   4_H
 	|\
 	| *   4_G
@@ -219,7 +213,7 @@ test_expect_success 'log --graph with octopus merge with column joining its penu
 	git checkout 5_r &&
 	git merge --no-ff 5_s -m 5_H &&
 
-	check_graph <<-\EOF
+	test_cmp_graph --pretty=tformat:%s <<-\EOF
 	*   5_H
 	|\
 	| *-.   5_G
@@ -258,7 +252,7 @@ test_expect_success 'log --graph with multiple tips' '
 	git checkout 6_1 &&
 	git merge --no-ff 6_2 -m 6_I &&
 
-	check_graph 6_1 6_3 6_5 <<-\EOF
+	test_cmp_graph --pretty=tformat:%s 6_1 6_3 6_5 <<-\EOF
 	*   6_I
 	|\
 	| | *   6_H
@@ -337,7 +331,7 @@ test_expect_success 'log --graph with multiple tips' '
 	git checkout -b M_7 7_1 &&
 	git merge --no-ff 7_2 7_3 -m 7_M4 &&
 
-	check_graph M_1 M_3 M_5 M_7 <<-\EOF
+	test_cmp_graph --pretty=tformat:%s M_1 M_3 M_5 M_7 <<-\EOF
 	*   7_M1
 	|\
 	| | *   7_M2
-- 
2.25.0

