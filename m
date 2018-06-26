Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EE9D1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752530AbeFZHcW (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:32:22 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37522 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752724AbeFZHbN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:31:13 -0400
Received: by mail-it0-f65.google.com with SMTP id j129-v6so870669ita.2
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PT/RG22cmzM5UWpC87ncAiWAPyrxkx+SHqVucNvS110=;
        b=T8qeocrWAXqAvdrFdrfRcQ9NV5LL6LCd9+oo6pTzBlXHrtvN14aToOoqFUtNjBuDSM
         SblCMckWRV68jyIj4QCIbXTL9KpoTsurDmBHlTGMRi04HkC6Rifw57IxjSSNG6Aif+n2
         NqLTVY5/eOkofwIMqYuLd4l7md+Em2JB7fXsLziDTghHMbzBxxY3SvJjlezZmMN1l/ei
         EIa8adZeCfXahDtYJEEa1xGNlnE9zDovayhPjbz3QaGJ3tm7CU0EBy9DHVGuyu2kxQCs
         Ax7V9UZ8eh2VKrkgb9lcqYG6ELC6GDK5+FMmkQECtZqCkpyU8g01Rmcdmcav661aOizL
         cTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=PT/RG22cmzM5UWpC87ncAiWAPyrxkx+SHqVucNvS110=;
        b=jIJmvIHuo6ZDAJGt7nCvu+WEj9gbxaNkXTFquZXsIy296o5VTJpuaklh1VYSr5ialn
         dgKq2c9uYwVHVltsCbyDqru13Eb/t5ssdGuVr9pipLis+IqzStGIlYvcuiEnVykEBfDO
         xqUeZ3WGbYwGIn1VrMdEjswoRYjdR6/nI7/eUyzNL7dLf2XoxH7qdNX15CyZZipkeOdt
         iqw+4t47uFdBXrNsYmzGsSqlnscjul9hI3Q0dkrSKRGkMDQ/MSkK9byt5jRLd8+1Xw4M
         WX7wlIM6hn1fLnP2SBFGwjuizfafjnROd8u50DnteJwsWv9cgkorZutM5G9+tjJ5m5Ck
         NYkg==
X-Gm-Message-State: APt69E14H9Y/5IClnl7kW2CC4QbdHXXL0VTE4l01/M10XGNJNlrV2TKV
        vE63rvQhN+Vu0FNS/Wy3tC5c/g==
X-Google-Smtp-Source: AAOMgpde3jp8skHJe3uq3e+nobU2OuorKcXUbY9Jw/iX1mZ/8mtCiiHlQ6CAhobABWx1F+T9xJtmCw==
X-Received: by 2002:a24:50d1:: with SMTP id m200-v6mr510905itb.11.1529998272942;
        Tue, 26 Jun 2018 00:31:12 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k20-v6sm471361iok.9.2018.06.26.00.31.11
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:31:12 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 23/29] t4000-t4999: fix broken &&-chains in subshells
Date:   Tue, 26 Jun 2018 03:29:55 -0400
Message-Id: <20180626073001.6555-24-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t4001-diff-rename.sh                       | 2 +-
 t/t4025-hunk-header.sh                       | 8 ++++----
 t/t4041-diff-submodule-option.sh             | 4 ++--
 t/t4060-diff-submodule-option-diff-format.sh | 2 +-
 t/t4121-apply-diffs.sh                       | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

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
2.18.0.419.gfe4b301394

