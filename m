Return-Path: <SRS0=MMY4=4L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8CBC35669
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 00:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582CB206EF
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 00:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=zom.bi header.i=@zom.bi header.b="MK62MC8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgBWAu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 19:50:57 -0500
Received: from zom.bi ([78.46.176.20]:39288 "EHLO mx.zom.bi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbgBWAu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Feb 2020 19:50:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=zom.bi; s=dkim;
        t=1582419055; bh=Q2Zm8oGyMrMRHKV+yv6nVU6/ZWWRJlieAknkXiOzRtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MK62MC8pH8ftXBFESIxmouCYsOCyZ8SaM41TX1em1mXeuBg+ShQH05hoqujTeHR/l
         QdMh2wAJJIKR45m56qREWPGRNIneKp5LQTG3iLZaLP72cKHyls+EW1+VwGA5mCv44x
         WgCUpshoGD3o2ejkA2q4LTzhNZ3rw97u3MOB1mz0=
From:   Rasmus Jonsson <wasmus@zom.bi>
To:     git@vger.kernel.org
Cc:     Rasmus Jonsson <wasmus@zom.bi>
Subject: [GSoC][PATCH v2] t1050: replace test -f with test_path_is_file
Date:   Sun, 23 Feb 2020 01:50:49 +0100
Message-Id: <20200223005049.2840-1-wasmus@zom.bi>
In-Reply-To: <20200222071335.27292-1-wasmus@zom.bi>
References: <20200222071335.27292-1-wasmus@zom.bi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use test_path_is_file() instead of 'test -f' for better debugging
information.

Signed-off-by: Rasmus Jonsson <wasmus@zom.bi>
---

Improved formatting of the code as suggested and corrected the commit
message.

 t/t1050-large.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index d3b2adb28b..184b479a21 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -53,7 +53,8 @@ test_expect_success 'add a large file or two' '
 	for p in .git/objects/pack/pack-*.pack
 	do
 		count=$(( $count + 1 ))
-		if test -f "$p" && idx=${p%.pack}.idx && test -f "$idx"
+		if test_path_is_file "$p" &&
+		   idx=${p%.pack}.idx && test_path_is_file "$idx"
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
+		if test_path_is_file "$p" &&
+		   idx=${p%.pack}.idx && test_path_is_file "$idx"
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

