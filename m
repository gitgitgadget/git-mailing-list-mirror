Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AB3C1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752423AbeFZHcS (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:32:18 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:39308 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbeFZHbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:31:16 -0400
Received: by mail-io0-f171.google.com with SMTP id f1-v6so15005832ioh.6
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YUSjL0DX7pQsoacGlGU+iSXBaOascNxfteWV3saRAoA=;
        b=gG4bcXpzPfwb33w3IgOSqB2a+hA153cEQB4IdYWxbHFqWXeXcmtPEVPrcLEyUMRElN
         C718MPJWge6tuvo5sEEkSdXTqAgCCC3qxR+dgmS7MpLfnupM+FgtjMnzdKQY2x8YlM6b
         mfggKtJ1WqB4Fjo5D6o2welijpkAGlHO9xC2xAAf4p4SXopR40NbHBg3glkOaDMLAVRU
         3xB37+Pxr+gnRWTq8WI6NTWtbF9YbCF8NtS5ens5Giy5J1X7XwssokGWr7NqvpbAqugM
         aMbXVddbZcy2QJVRJMZDww5o/dMI184EM/uhcv4T+EQTi5xsra+h7C/NBcbXBYy37N4M
         B34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=YUSjL0DX7pQsoacGlGU+iSXBaOascNxfteWV3saRAoA=;
        b=gM/YJRRuZGJeu0P6iiyJYoEWOoNDRp4JLkxvAY5bdIdLqvds99OxC9A31D3fhKDGHi
         ugEZFeEpgMZkwjjYqgP+7T2LAgo9kqlBhBwoZwQQ5wWgy3SjbIN6ebJEMJEsVippqeB7
         uCN2yutZXYSjsxRE/GK8dCYBahw9c/177iWbqSGp1AYFjSjFdbHyyCTODr5Xo1NzrT6o
         zrHBptfwLOPLUgBhIWoL7M2WA8zrXw62xhpORjLdpkZ8DApPEn4/BkD5JZ9atGtdqRGn
         sBFAozm2s3nd+Qmzy3Ht6UwQQ8RYY3N+NdNHddWjVYyhkYF/uu+Wnvz8rbhPxI1aFNe4
         MVeg==
X-Gm-Message-State: APt69E03U9cKFXNRcqa9aP+S1D8VPGAKoHTur/U1QNUcO4y4Nov0Jgk0
        2FnXpF8EHxS2IpevQNcg7Aux4w==
X-Google-Smtp-Source: AAOMgpdgRXMLCrqCp/rhBKR84kaO6ylou6B9/pPlJdOEoF+EL+huUFBJetrM8HNtKzV7lEBoWo5yRw==
X-Received: by 2002:a6b:3942:: with SMTP id g63-v6mr269819ioa.225.1529998275075;
        Tue, 26 Jun 2018 00:31:15 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k20-v6sm471361iok.9.2018.06.26.00.31.14
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:31:14 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 25/29] t6000-t6999: fix broken &&-chains in subshells
Date:   Tue, 26 Jun 2018 03:29:57 -0400
Message-Id: <20180626073001.6555-26-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t6010-merge-base.sh                |  2 +-
 t/t6029-merge-subtree.sh             | 16 ++++++++--------
 t/t6036-recursive-corner-cases.sh    |  6 +++---
 t/t6042-merge-rename-corner-cases.sh |  8 ++++----
 t/t6043-merge-rename-directories.sh  |  2 +-
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index aa2d360ce3..44c726ea39 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -245,7 +245,7 @@ test_expect_success 'using reflog to find the fork point' '
 			git commit --allow-empty -m "Derived #$count" &&
 			git rev-parse HEAD >derived$count &&
 			git checkout -B base $E || exit 1
-		done
+		done &&
 
 		for count in 1 2 3
 		do
diff --git a/t/t6029-merge-subtree.sh b/t/t6029-merge-subtree.sh
index 3e692454a7..7d5bc78472 100755
--- a/t/t6029-merge-subtree.sh
+++ b/t/t6029-merge-subtree.sh
@@ -55,7 +55,7 @@ test_expect_success 'initial merge' '
 	git checkout -b work &&
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o1 0	git-gui/git-gui.sh"
+		echo "100644 $o1 0	git-gui/git-gui.sh" &&
 		echo "100644 $o2 0	git.c"
 	) >expected &&
 	test_cmp expected actual
@@ -72,7 +72,7 @@ test_expect_success 'merge update' '
 	git pull -s subtree gui master2 &&
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o3 0	git-gui/git-gui.sh"
+		echo "100644 $o3 0	git-gui/git-gui.sh" &&
 		echo "100644 $o2 0	git.c"
 	) >expected &&
 	test_cmp expected actual
@@ -88,8 +88,8 @@ test_expect_success 'initial ambiguous subtree' '
 	git checkout -b work2 &&
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o1 0	git-gui/git-gui.sh"
-		echo "100644 $o1 0	git-gui2/git-gui.sh"
+		echo "100644 $o1 0	git-gui/git-gui.sh" &&
+		echo "100644 $o1 0	git-gui2/git-gui.sh" &&
 		echo "100644 $o2 0	git.c"
 	) >expected &&
 	test_cmp expected actual
@@ -101,8 +101,8 @@ test_expect_success 'merge using explicit' '
 	git pull -Xsubtree=git-gui gui master2 &&
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o3 0	git-gui/git-gui.sh"
-		echo "100644 $o1 0	git-gui2/git-gui.sh"
+		echo "100644 $o3 0	git-gui/git-gui.sh" &&
+		echo "100644 $o1 0	git-gui2/git-gui.sh" &&
 		echo "100644 $o2 0	git.c"
 	) >expected &&
 	test_cmp expected actual
@@ -114,8 +114,8 @@ test_expect_success 'merge2 using explicit' '
 	git pull -Xsubtree=git-gui2 gui master2 &&
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o1 0	git-gui/git-gui.sh"
-		echo "100644 $o3 0	git-gui2/git-gui.sh"
+		echo "100644 $o1 0	git-gui/git-gui.sh" &&
+		echo "100644 $o3 0	git-gui2/git-gui.sh" &&
 		echo "100644 $o2 0	git.c"
 	) >expected &&
 	test_cmp expected actual
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index b32ff8e1db..892cf08743 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -72,7 +72,7 @@ test_expect_success 'merge simple rename+criss-cross with no modifications' '
 		git rev-parse   >actual     \
 			:2:three   :3:three &&
 		git hash-object >>actual    \
-			three~HEAD three~R2^0
+			three~HEAD three~R2^0 &&
 		test_cmp expect actual
 	)
 '
@@ -148,7 +148,7 @@ test_expect_success 'merge criss-cross + rename merges with basic modification'
 		git rev-parse   >actual     \
 			:2:three   :3:three &&
 		git hash-object >>actual    \
-			three~HEAD three~R2^0
+			three~HEAD three~R2^0 &&
 		test_cmp expect actual
 	)
 '
@@ -228,7 +228,7 @@ test_expect_success 'git detects differently handled merges conflict' '
 			D:new_a  E:new_a &&
 		git rev-parse   >actual     \
 			:2:new_a :3:new_a &&
-		test_cmp expect actual
+		test_cmp expect actual &&
 
 		git cat-file -p B:new_a >ours &&
 		git cat-file -p C:new_a >theirs &&
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index 1cbd946fc2..661b633478 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -352,7 +352,7 @@ test_expect_success 'rename/directory conflict + content merge conflict' '
 			base:file   left-conflict:newfile  right:file &&
 		git rev-parse >actual                                 \
 			:1:newfile  :2:newfile             :3:newfile &&
-		test_cmp expect actual
+		test_cmp expect actual &&
 
 		test_path_is_file newfile/realfile &&
 		test_path_is_file newfile~HEAD
@@ -580,7 +580,7 @@ test_expect_failure 'detect conflict with rename/rename(1to2)/add-source merge'
 			C:a   A:a   B:b   C:C &&
 		git rev-parse >actual          \
 			:3:a  :1:a  :2:b  :3:c &&
-		test_cmp expect actual
+		test_cmp expect actual &&
 
 		test_path_is_file a &&
 		test_path_is_file b &&
@@ -680,13 +680,13 @@ test_expect_success 'rename/rename/add-dest merge still knows about conflicting
 			A:a   C:b   B:b   C:c   B:c &&
 		git rev-parse >actual                \
 			:1:a  :2:b  :3:b  :2:c  :3:c &&
-		test_cmp expect actual
+		test_cmp expect actual &&
 
 		git rev-parse >expect               \
 			C:c     B:c     C:b     B:b &&
 		git hash-object >actual                \
 			c~HEAD  c~B\^0  b~HEAD  b~B\^0 &&
-		test_cmp expect actual
+		test_cmp expect actual &&
 
 		test_path_is_missing b &&
 		test_path_is_missing c
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index 2e28f2908d..4a71f17edd 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -3583,7 +3583,7 @@ test_expect_success '11d-check: Avoid losing not-uptodate with rename + D/F conf
 		grep -q stuff z/c &&
 		test_seq 1 10 >expected &&
 		echo stuff >>expected &&
-		test_cmp expected z/c
+		test_cmp expected z/c &&
 
 		git ls-files -s >out &&
 		test_line_count = 4 out &&
-- 
2.18.0.419.gfe4b301394

