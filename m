Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DD8E1F516
	for <e@80x24.org>; Mon,  2 Jul 2018 00:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932111AbeGBAZp (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 20:25:45 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52637 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752922AbeGBAZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 20:25:09 -0400
Received: by mail-it0-f68.google.com with SMTP id p4-v6so9878954itf.2
        for <git@vger.kernel.org>; Sun, 01 Jul 2018 17:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OhkdETOlO6easddiPwh7hsQSxUctiHbwtT0UKHIWDpc=;
        b=fIy5JCOZVQdwJ8cvUcyB+lWc3tSMj9q5JkdUy7v29AnMKxHPmrN6sgy0uXgi7H3Afr
         c8b4Te6A3X1pExFWX5pQofUED4uGazDJOaOv1CWX0pbyL+LsswLH3/ax0t74RceW1cQr
         nyNhSzJD60u/FCmLQM8WIAS7+DiAYSwP4OhTH3B+qwcmm9fv0sjzf+0HfPGDOWBUpO1M
         cO/t/TzDeg2L1ZNY8bNS0mk6ivOCkUpLxc7Rh2yK7FarUWURAj6umpeQIqW8ZbDf3aiA
         UOeEmiNboNRR7TK114pdH3q74QaHKSS6u1xbmjTpw7AK2qMw8zUcQx5E5TPcMeuRo184
         p28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=OhkdETOlO6easddiPwh7hsQSxUctiHbwtT0UKHIWDpc=;
        b=GLs60J2Mhz6oV3hu8o012sL4GAn10nHUtqugUovHgnvjIBV9enc5Bk3Zir1Ey2GE3H
         6P/ZFtYvEcSm1P3Mgaw1/ShJk5UvE9G3S3iZiZ9qWUgM4rtyNOFtO6saVFXpBPF+vx+m
         bIZk+/+l4woRwBZbS1pwiuixHCBGdbQfArhdFsVas7ZeQxn9U32Rm9kahKc75w/AurxR
         8zka0d1PjkM1oTLeUsxd2JGnfimNN1zeFjdmem7GJQ6iQ4ulv+7R1h7BDHjPWlZJVhO3
         0N4Chv6hBX8KFRJ+IpEVcfuzHmI+napg7v2snHjoT0xCilk70aYveoBUTpJW74VDdcUp
         xLmw==
X-Gm-Message-State: APt69E2iB5KrEC0zixfu8GJlYJxkDbHZtjKU74Xw5ZVFNF2lBHLWN7B0
        igwibj5wg07FqtSRgUHTxrD/dg==
X-Google-Smtp-Source: AAOMgpfiot9Bphy0IUH4n8XLghb9LMnb39fXRhwGXoHDhwthx1gVyMzo6C8QpegpXE9M4gWUN23TEg==
X-Received: by 2002:a24:5ccb:: with SMTP id q194-v6mr7673268itb.133.1530491108821;
        Sun, 01 Jul 2018 17:25:08 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id o143-v6sm3302562itb.42.2018.07.01.17.25.07
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 01 Jul 2018 17:25:08 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 20/25] t4000-t4999: fix broken &&-chains
Date:   Sun,  1 Jul 2018 20:24:00 -0400
Message-Id: <20180702002405.3042-21-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180702002405.3042-1-sunshine@sunshineco.com>
References: <20180702002405.3042-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t4001-diff-rename.sh                       |  2 +-
 t/t4024-diff-optimize-common.sh              | 16 ++++++++--------
 t/t4025-hunk-header.sh                       |  8 ++++----
 t/t4041-diff-submodule-option.sh             |  4 ++--
 t/t4060-diff-submodule-option-diff-format.sh |  2 +-
 t/t4121-apply-diffs.sh                       |  2 +-
 6 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index bf4030371a..c16486a9d4 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -180,7 +180,7 @@ test_expect_success 'setup for many rename source candidates' '
 	git add "path??" &&
 	test_tick &&
 	git commit -m "hundred" &&
-	(cat path1; echo new) >new-path &&
+	(cat path1 && echo new) >new-path &&
 	echo old >>path1 &&
 	git add new-path path1 &&
 	git diff -l 4 -C -C --cached --name-status >actual 2>actual.err &&
diff --git a/t/t4024-diff-optimize-common.sh b/t/t4024-diff-optimize-common.sh
index 7e76018296..6b44ce1493 100755
--- a/t/t4024-diff-optimize-common.sh
+++ b/t/t4024-diff-optimize-common.sh
@@ -127,17 +127,17 @@ test_expect_success setup '
 
 	for n in $sample
 	do
-		( zs $n ; echo a ) >file-a$n &&
-		( echo b; zs $n; echo ) >file-b$n &&
-		( printf c; zs $n ) >file-c$n &&
-		( echo d; zs $n ) >file-d$n &&
+		( zs $n && echo a ) >file-a$n &&
+		( echo b && zs $n && echo ) >file-b$n &&
+		( printf c && zs $n ) >file-c$n &&
+		( echo d && zs $n ) >file-d$n &&
 
 		git add file-a$n file-b$n file-c$n file-d$n &&
 
-		( zs $n ; echo A ) >file-a$n &&
-		( echo B; zs $n; echo ) >file-b$n &&
-		( printf C; zs $n ) >file-c$n &&
-		( echo D; zs $n ) >file-d$n &&
+		( zs $n && echo A ) >file-a$n &&
+		( echo B && zs $n && echo ) >file-b$n &&
+		( printf C && zs $n ) >file-c$n &&
+		( echo D && zs $n ) >file-d$n &&
 
 		expect_pattern $n || return 1
 
diff --git a/t/t4025-hunk-header.sh b/t/t4025-hunk-header.sh
index 7a3dbc1ea2..fa44e78869 100755
--- a/t/t4025-hunk-header.sh
+++ b/t/t4025-hunk-header.sh
@@ -12,12 +12,12 @@ NS="$N$N$N$N$N$N$N$N$N$N$N$N$N"
 test_expect_success setup '
 
 	(
-		echo "A $NS"
+		echo "A $NS" &&
 		for c in B C D E F G H I J K
 		do
 			echo "  $c"
-		done
-		echo "L  $NS"
+		done &&
+		echo "L  $NS" &&
 		for c in M N O P Q R S T U V
 		do
 			echo "  $c"
@@ -34,7 +34,7 @@ test_expect_success 'hunk header truncation with an overly long line' '
 
 	git diff | sed -n -e "s/^.*@@//p" >actual &&
 	(
-		echo " A $N$N$N$N$N$N$N$N$N2"
+		echo " A $N$N$N$N$N$N$N$N$N2" &&
 		echo " L  $N$N$N$N$N$N$N$N$N1"
 	) >expected &&
 	test_cmp actual expected
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 058ee0829d..4e3499ef84 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -498,7 +498,7 @@ test_expect_success 'given commit --submodule=short' '
 test_expect_success 'setup .git file for sm2' '
 	(cd sm2 &&
 	 REAL="$(pwd)/../.real" &&
-	 mv .git "$REAL"
+	 mv .git "$REAL" &&
 	 echo "gitdir: $REAL" >.git)
 '
 
@@ -527,7 +527,7 @@ test_expect_success 'diff --submodule with objects referenced by alternates' '
 		git commit -m "sub a"
 	) &&
 	(cd sub_alt &&
-		sha1_before=$(git rev-parse --short HEAD)
+		sha1_before=$(git rev-parse --short HEAD) &&
 		echo b >b &&
 		git add b &&
 		git commit -m b &&
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index 4b168d0ed7..0eba4620f0 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -721,7 +721,7 @@ test_expect_success 'given commit' '
 test_expect_success 'setup .git file for sm2' '
 	(cd sm2 &&
 	 REAL="$(pwd)/../.real" &&
-	 mv .git "$REAL"
+	 mv .git "$REAL" &&
 	 echo "gitdir: $REAL" >.git)
 '
 
diff --git a/t/t4121-apply-diffs.sh b/t/t4121-apply-diffs.sh
index aff551a1d7..66368effd5 100755
--- a/t/t4121-apply-diffs.sh
+++ b/t/t4121-apply-diffs.sh
@@ -27,6 +27,6 @@ test_expect_success 'setup' \
 
 test_expect_success \
 	'check if contextually independent diffs for the same file apply' \
-	'( git diff test~2 test~1; git diff test~1 test~0 )| git apply'
+	'( git diff test~2 test~1 && git diff test~1 test~0 )| git apply'
 
 test_done
-- 
2.18.0.203.gfac676dfb9

