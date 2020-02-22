Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3428C35669
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 07:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3BE208C4
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 07:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=zom.bi header.i=@zom.bi header.b="bgVtlfuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgBVHUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 02:20:53 -0500
Received: from zom.bi ([78.46.176.20]:59644 "EHLO mx.zom.bi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbgBVHUw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Feb 2020 02:20:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=zom.bi; s=dkim;
        t=1582355625; bh=z3ILin2wEFFfs5tdaI062EmmTJZAWxZdEODggaj2n9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bgVtlfuHBs0/JFBG4EcgRbBFuMeKXcGz8512NoG/7ZoNnmnaW3oNwC6Zr8eQCEuRD
         9fQuASg4kaOpXLmKiR2JJp+sCeaUsw7ydVod+j3Ux5KGyzlnZXqst8dcCSQJCtpNxU
         mYYC6JVW57D6iJyK6eGHixbcUKPzFSpVAqMbZbAs=
From:   Rasmus Jonsson <wasmus@zom.bi>
To:     git@vger.kernel.org
Cc:     Rasmus Jonsson <wasmus@zom.bi>
Subject: [GSoC][PATCH 1/1] t1050: clean up checks for file existence
Date:   Sat, 22 Feb 2020 08:13:35 +0100
Message-Id: <20200222071335.27292-2-wasmus@zom.bi>
In-Reply-To: <20200222071335.27292-1-wasmus@zom.bi>
References: <20200222071335.27292-1-wasmus@zom.bi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace "test -f" with test_path_is_file, which gives more verbose
and accurate output.

Signed-off-by: Rasmus Jonsson <wasmus@zom.bi>
---
 t/t1050-large.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index d3b2adb28b..667fc2a745 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -53,7 +53,8 @@ test_expect_success 'add a large file or two' '
 	for p in .git/objects/pack/pack-*.pack
 	do
 		count=$(( $count + 1 ))
-		if test -f "$p" && idx=${p%.pack}.idx && test -f "$idx"
+		if test_path_is_file "$p" && idx=${p%.pack}.idx &&
+		   test_path_is_file "$idx"
 		then
 			continue
 		fi
@@ -65,7 +66,7 @@ test_expect_success 'add a large file or two' '
 	test $cnt = 2 &&
 	for l in .git/objects/??/??????????????????????????????????????
 	do
-		test -f "$l" || continue
+		test_path_is_file "$l" || continue
 		bad=t
 	done &&
 	test -z "$bad" &&
@@ -76,7 +77,8 @@ test_expect_success 'add a large file or two' '
 	for p in .git/objects/pack/pack-*.pack
 	do
 		count=$(( $count + 1 ))
-		if test -f "$p" && idx=${p%.pack}.idx && test -f "$idx"
+		if test_path_is_file "$p" && idx=${p%.pack}.idx &&
+		   test_path_is_file "$idx"
 		then
 			continue
 		fi
@@ -111,7 +113,7 @@ test_expect_success 'packsize limit' '
 		count=0 &&
 		for pi in .git/objects/pack/pack-*.idx
 		do
-			test -f "$pi" && count=$(( $count + 1 ))
+			test_path_is_file "$pi" && count=$(( $count + 1 ))
 		done &&
 		test $count = 2 &&
 
-- 
2.20.1

