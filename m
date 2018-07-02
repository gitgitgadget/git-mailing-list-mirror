Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 677921F516
	for <e@80x24.org>; Mon,  2 Jul 2018 00:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932095AbeGBAZi (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 20:25:38 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40152 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752945AbeGBAZL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 20:25:11 -0400
Received: by mail-it0-f68.google.com with SMTP id 188-v6so9832242ita.5
        for <git@vger.kernel.org>; Sun, 01 Jul 2018 17:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=joR0FYiTMqs52HB0G8cC64SVo/EWna7AWIrHcyzf0Sk=;
        b=h0A98IkzdV5HIxWRhO9sPaTw0fZmJZdsdZQM4vcudsDNw1WFfZ/6ryKH1mL3LJLk9K
         cJkqpjLhynAfT5zzqmkyE+nWCa/iHFwTHWM5+Ds+V07HrRdjwSnvGbQDIz3oLXpe5obv
         X0nsRSdv8XI04qL+rzgVht4aWy040Y0UoQM/bvHN/KZmLZt1j+ZZ9piwEy2z5IHvPrNV
         qnI2+gnN0rFJYar0pG/RDSBwXNx4V3Id48Wy3ngaJMxlcON1A7Bxrr/HKWzVsEsHSp09
         bSYGXFSTtUQenD8M2W5v1prB03Id6NM8MCnwfxQ2mAc2m+NrfAIajpUhHiT2v0e9D6Fx
         ikmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=joR0FYiTMqs52HB0G8cC64SVo/EWna7AWIrHcyzf0Sk=;
        b=V3zCUCIRy7gO4JzD9O0rJ+8J9nKFk3EywW1R+FHySwp+VlVnOiFGM1bTrT6L/k93en
         qfTXrZoAHNPcE5gH94FFcdNNo/8i0Xrmaj7yLEaEfT81xnNlJs5hE4YRqgl4hJlmdBsM
         3eUlEBtJrRdtav8AbNZqDHFnIDb0f8TVGznVCY1sqIcro+/wjqCx7/lLmcePlVs4KniA
         Yd1Gul8B0XtUR7pHxmHOJd864XUTcArM2D74F39l0cri9Hpuvh32WVwnqqux5I50+aUM
         H/qFuqx3910xBvpA1xZKSPsoC7XN+JuF/2O5ZpuRD9r71rvdmKKGOCIBKECxmOSfidCR
         KeIQ==
X-Gm-Message-State: APt69E10wbaEuem2kHusi5cTcjaNLjK4h8C+YMEVtnBIEBkUKwe+UsK3
        NDA5txzfaI5nsNWJlWMx518seQ==
X-Google-Smtp-Source: AAOMgpds8i5IKNEIrmOcfszXgMWK/FWioVo2XiZmSWo4+XggVBH/yVZiZaKj3CJJGulqo49HVdUOeg==
X-Received: by 2002:a24:46d4:: with SMTP id j203-v6mr4650093itb.93.1530491110782;
        Sun, 01 Jul 2018 17:25:10 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id o143-v6sm3302562itb.42.2018.07.01.17.25.09
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 01 Jul 2018 17:25:10 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 22/25] t6000-t6999: fix broken &&-chains
Date:   Sun,  1 Jul 2018 20:24:02 -0400
Message-Id: <20180702002405.3042-23-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180702002405.3042-1-sunshine@sunshineco.com>
References: <20180702002405.3042-1-sunshine@sunshineco.com>
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
2.18.0.203.gfac676dfb9

