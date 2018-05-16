Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03E111F406
	for <e@80x24.org>; Wed, 16 May 2018 01:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752565AbeEPB6y (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 21:58:54 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47442 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752535AbeEPB6w (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 May 2018 21:58:52 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CC9C06074B;
        Wed, 16 May 2018 01:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526435931;
        bh=2EqZeLsV5DlZf+tHplzQNzUojW0Sl8W2gW5NIUZQYaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=jvAB4zasZnJ3eCqkKAA7+8ee3TyvbyI00Wxok1jr5tTGgBAmIpv1fr4HW2tPkx3se
         mHuRw/W7OCM4rXSuh8YCef99fb7li1hRuozICgsCVe9VKYAyVltbbONHvrb8mSlyhH
         jxmohjLzhaoenQjMRXKbTA8rAe6adjXoB7FmJZ+fE/QlLrCAIPil4i7Gzi8wa0wnC8
         LcxhOuN+fUZREPiUXHkQBv3y/PTSQJeCU/8zAU4QjQJzM9EpgCtYQPEMp+X+irEE8o
         X9qKFc7Z1ZGMn/lVECo54Tjw7Owx2fcl8tChIE90vIBdG8X7hJP/8i4DYkWk1Xr30u
         11sx5/f7Ni6rPvC7Ez1VGwqq0EKW3teflxQAZnW8VOFn09pOyy5d0Vgw9lGTKvC+V1
         Z8YugY2V8jj1dp/Gx09SDYhPWuxw4ot1Z3KCedO7HlmGe4L+gVBOdckPvrWTcpqLps
         SSlxD921sbQ2h+lJWXX1pXux77msLEbitUKt9ZIxqH25LMGEVG1
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 15/28] t4007: abstract away SHA-1-specific constants
Date:   Wed, 16 May 2018 01:56:17 +0000
Message-Id: <20180516015630.661349-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180516015630.661349-1-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for blobs and uses the
ZERO_OID variable instead of using hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4007-rename-3.sh | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/t/t4007-rename-3.sh b/t/t4007-rename-3.sh
index dae327fabb..b187b7f6c6 100755
--- a/t/t4007-rename-3.sh
+++ b/t/t4007-rename-3.sh
@@ -17,6 +17,7 @@ test_expect_success 'prepare reference tree' '
 	echo $tree
 '
 
+blob=$(git hash-object "$TEST_DIRECTORY/diff-lib/COPYING")
 test_expect_success 'prepare work tree' '
 	cp path0/COPYING path1/COPYING &&
 	git update-index --add --remove path0/COPYING path1/COPYING
@@ -26,8 +27,8 @@ test_expect_success 'prepare work tree' '
 # path1 both have COPYING and the latter is a copy of path0/COPYING.
 # Comparing the full tree with cache should tell us so.
 
-cat >expected <<\EOF
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 6ff87c4664981e4397625791c8ea3bbb5f2279a3 C100	path0/COPYING	path1/COPYING
+cat >expected <<EOF
+:100644 100644 $blob $blob C100	path0/COPYING	path1/COPYING
 EOF
 
 test_expect_success 'copy detection' '
@@ -46,8 +47,8 @@ test_expect_success 'copy detection, cached' '
 # path1/COPYING suddenly appearing from nowhere, not detected as
 # a copy from path0/COPYING.
 
-cat >expected <<\EOF
-:000000 100644 0000000000000000000000000000000000000000 6ff87c4664981e4397625791c8ea3bbb5f2279a3 A	path1/COPYING
+cat >expected <<EOF
+:000000 100644 $ZERO_OID $blob A	path1/COPYING
 EOF
 
 test_expect_success 'copy, limited to a subtree' '
@@ -64,8 +65,8 @@ test_expect_success 'tweak work tree' '
 # path0/COPYING.  Showing the full tree with cache should tell us about
 # the rename.
 
-cat >expected <<\EOF
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 6ff87c4664981e4397625791c8ea3bbb5f2279a3 R100	path0/COPYING	path1/COPYING
+cat >expected <<EOF
+:100644 100644 $blob $blob R100	path0/COPYING	path1/COPYING
 EOF
 
 test_expect_success 'rename detection' '
@@ -78,8 +79,8 @@ test_expect_success 'rename detection' '
 # path0/COPYING.  When we say we care only about path1, we should just
 # see path1/COPYING appearing from nowhere.
 
-cat >expected <<\EOF
-:000000 100644 0000000000000000000000000000000000000000 6ff87c4664981e4397625791c8ea3bbb5f2279a3 A	path1/COPYING
+cat >expected <<EOF
+:000000 100644 $ZERO_OID $blob A	path1/COPYING
 EOF
 
 test_expect_success 'rename, limited to a subtree' '
