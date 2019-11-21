Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FD3C432C3
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2A820855
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIeIEs2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfKUAqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:46:35 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36203 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfKUAqf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 19:46:35 -0500
Received: by mail-pj1-f66.google.com with SMTP id cq11so630519pjb.3
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 16:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/3XZZCqEhVUgxOkp4BVLUiMpYidG0kVUgKK0Cm306EU=;
        b=mIeIEs2PfDkNm6wh35JkeFHYWYrL6SQITkZmwES3GGc/Wt7W3bmtUFWuAoq0B0BzlZ
         pMKISeqdouiQ0fik36CNZQKE9PO860evMb8vas1O+vfUzgm7sITmzUOsBZJrDzwHlUKe
         +/tLou8mqsgHjM7TNBGSFuI0slvi3+5LI1dYuwpa4TpXdtumx7X/zJZd/Cdc97lJk2I/
         kqfF1Ff2tdvT+xFMnYIWXqCOVNHPO3ne4MQW/jPLw4InAM9GSRtVY+AGndj5/C2YFMxk
         tt4cM2RmsYfn3mwTxnCLk7wVIEw8LzX9VqD4KlK9UAs2i6hsyeyxA7K6ub9gD7bSisJG
         42oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/3XZZCqEhVUgxOkp4BVLUiMpYidG0kVUgKK0Cm306EU=;
        b=Wag4boT6GE2i7v++dawEO2JipsmNVdYJ4U9gUg7XFgElxnZrpTrmJ3tKHaS6OylCTE
         gBGqY53Tbo2PTne1d9NmiEwxujSsLNJusLDRk4YuAMbI6TGEQUeS10gXgo59CQi0Ob5I
         +g6asLAqudAdiu6Z9bVIXFovluDgl4/obf9oC3SE/BAlTGCYNU1ZMv53QFNDaOw/Gl69
         bsUKCrKVi159PT3PlMsW5UHt2JcfcWVdg7rK+pLD89BGYL1IAsVhkCVjiQt2GIkb/5T+
         SdaKyP+KLtC7sw+ypfz0T7bdvlCZ7T6RojByj6fMzRKVwh1ZU7YeQ7Z6Zo3ItlquSNPq
         8BAw==
X-Gm-Message-State: APjAAAWLBhBEnAwJXar4lk4Kx/KSKLH6mErAfnIG/U8UZ3yOXUuV9sof
        OMAVMZZsxqIkxDtwBGeSmDG7blTE
X-Google-Smtp-Source: APXvYqzoucUdqSsErLCDk4BkYT5dXQnVt+I7t8oIqXYF3AKT9wNsdmGc9uWdyU79ss83zlHlade6yQ==
X-Received: by 2002:a17:902:868f:: with SMTP id g15mr5719211plo.294.1574297193754;
        Wed, 20 Nov 2019 16:46:33 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id w15sm585381pfi.168.2019.11.20.16.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 16:46:33 -0800 (PST)
Date:   Wed, 20 Nov 2019 16:46:31 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 19/21] t7700: move keywords onto their own line
Message-ID: <9389a74fe01cbf1c599b2e4ef7830beeb93808c3.1574296987.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
 <cover.1574296987.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574296987.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code style for tests is to have statements on their own line if
possible. Move keywords onto their own line so that they conform with
the test style.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7700-repack.sh | 51 +++++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 8936928387..a96e876c4e 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -29,10 +29,12 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 	mv pack-* .git/objects/pack/ &&
 	git repack -A -d -l &&
 	git prune-packed &&
-	for p in .git/objects/pack/*.idx; do
+	for p in .git/objects/pack/*.idx
+	do
 		idx=$(basename $p)
 		test "pack-$packsha1.idx" = "$idx" && continue
-		if git verify-pack -v $p | egrep "^$objsha1"; then
+		if git verify-pack -v $p | egrep "^$objsha1"
+		then
 			found_duplicate_object=1
 			echo "DUPLICATE OBJECT FOUND"
 			break
@@ -45,10 +47,12 @@ test_expect_success 'writing bitmaps via command-line can duplicate .keep object
 	# build on $objsha1, $packsha1, and .keep state from previous
 	git repack -Adbl &&
 	test_when_finished "found_duplicate_object=" &&
-	for p in .git/objects/pack/*.idx; do
+	for p in .git/objects/pack/*.idx
+	do
 		idx=$(basename $p)
 		test "pack-$packsha1.idx" = "$idx" && continue
-		if git verify-pack -v $p | egrep "^$objsha1"; then
+		if git verify-pack -v $p | egrep "^$objsha1"
+		then
 			found_duplicate_object=1
 			echo "DUPLICATE OBJECT FOUND"
 			break
@@ -61,10 +65,12 @@ test_expect_success 'writing bitmaps via config can duplicate .keep objects' '
 	# build on $objsha1, $packsha1, and .keep state from previous
 	git -c repack.writebitmaps=true repack -Adl &&
 	test_when_finished "found_duplicate_object=" &&
-	for p in .git/objects/pack/*.idx; do
+	for p in .git/objects/pack/*.idx
+	do
 		idx=$(basename $p)
 		test "pack-$packsha1.idx" = "$idx" && continue
-		if git verify-pack -v $p | egrep "^$objsha1"; then
+		if git verify-pack -v $p | egrep "^$objsha1"
+		then
 			found_duplicate_object=1
 			echo "DUPLICATE OBJECT FOUND"
 			break
@@ -83,8 +89,10 @@ test_expect_success 'loose objects in alternate ODB are not repacked' '
 	git commit -m commit_file3 &&
 	git repack -a -d -l &&
 	git prune-packed &&
-	for p in .git/objects/pack/*.idx; do
-		if git verify-pack -v $p | egrep "^$objsha1"; then
+	for p in .git/objects/pack/*.idx
+	do
+		if git verify-pack -v $p | egrep "^$objsha1"
+		then
 			found_duplicate_object=1
 			echo "DUPLICATE OBJECT FOUND"
 			break
@@ -99,10 +107,13 @@ test_expect_success 'packed obs in alt ODB are repacked even when local repo is
 	git repack -a &&
 	myidx=$(ls -1 .git/objects/pack/*.idx) &&
 	test -f "$myidx" &&
-	for p in alt_objects/pack/*.idx; do
+	for p in alt_objects/pack/*.idx
+	do
 		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
-	done | while read sha1 rest; do
-		if ! ( git verify-pack -v $myidx | grep "^$sha1" ); then
+	done | while read sha1 rest
+	do
+		if ! ( git verify-pack -v $myidx | grep "^$sha1" )
+		then
 			echo "Missing object in local pack: $sha1"
 			return 1
 		fi
@@ -119,10 +130,13 @@ test_expect_success 'packed obs in alt ODB are repacked when local repo has pack
 	git repack -a -d &&
 	myidx=$(ls -1 .git/objects/pack/*.idx) &&
 	test -f "$myidx" &&
-	for p in alt_objects/pack/*.idx; do
+	for p in alt_objects/pack/*.idx
+	do
 		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
-	done | while read sha1 rest; do
-		if ! ( git verify-pack -v $myidx | grep "^$sha1" ); then
+	done | while read sha1 rest
+	do
+		if ! ( git verify-pack -v $myidx | grep "^$sha1" )
+		then
 			echo "Missing object in local pack: $sha1"
 			return 1
 		fi
@@ -144,10 +158,13 @@ test_expect_success 'packed obs in alternate ODB kept pack are repacked' '
 	git repack -a -d &&
 	myidx=$(ls -1 .git/objects/pack/*.idx) &&
 	test -f "$myidx" &&
-	for p in alt_objects/pack/*.idx; do
+	for p in alt_objects/pack/*.idx
+	do
 		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
-	done | while read sha1 rest; do
-		if ! ( git verify-pack -v $myidx | grep "^$sha1" ); then
+	done | while read sha1 rest
+	do
+		if ! ( git verify-pack -v $myidx | grep "^$sha1" )
+		then
 			echo "Missing object in local pack: $sha1"
 			return 1
 		fi
-- 
2.24.0.450.g7a9a4598a9

