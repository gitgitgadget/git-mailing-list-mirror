Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F43C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E45C2071C
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Txznz56x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfKVTAe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:00:34 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38611 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfKVTAd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 14:00:33 -0500
Received: by mail-pf1-f193.google.com with SMTP id c13so3898350pfp.5
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 11:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tsIB/+cSNaUA1F0hjmI9MQtuOgOcTbyuHKrhclzlKk4=;
        b=Txznz56xwPqcEPRGTBJHFhhWmDZ9SW8YSm56aaaL7hD/lkL3a9/LplJPthDrqF/tyf
         Q7baqYfXDS/OAth6n6c2JmlBTID8Muz5J8k/d802ipDxqg0meh1rCy+DWydOnJcChYS0
         ZzcALnsYWFxmeANhpnDR2nogaFk8ypUs+AVEbDOQfFWaFs8OimLDfpdYdKjzQwKL+i6P
         2rNlPkU3Ky8cH2IKNYGPxzoopKybpDjeW5mWVJCEBurZHQw9G7iBL8ozL59PwOdMbwky
         mcxew8AvdfTCS0WBOreI+8sIpVMzY9AOBU+JRV2noZEo/NBim+03DCMYPxZJvZXs22fj
         awCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tsIB/+cSNaUA1F0hjmI9MQtuOgOcTbyuHKrhclzlKk4=;
        b=ufLs4muMrHYJaIo2UvLKG82iMwNWZRa3+pgEVp0KGqzyXMl9qmDr1LDKKvPMpYRl3p
         Vr7eSpCCbSMbOZxjiqIOtIjVJcg29BQ4bjoNCKe4YjhazB/6H5KEp2V/WPCeUo2xkxMc
         /b/C7lVZEJ9O1YrU9LLEhbKXe/RkeW95XHAkCHi7BCc6MoItFkZS95KWzsb4GqBleB0H
         11DMLDJX54/Ck8SkMVpOAx+HCUTF5E7rRyTQcyvqGsVz4rbhfSG4uXbUtrCaznvSYWWE
         4SRtSC5oQmvOezHeX0X0NPlrNWNk+oeF2xDA7iiMMU9vHeHXxCmcHM9CpnnNqcqCvXIH
         0GuA==
X-Gm-Message-State: APjAAAX1/m6j5Dnq8rLR4LUmL7l1QG+I4NzetRQh2ob+kJGqTPASx6+x
        hnjIPa+pwkiVbbMtHs5oMkZASEuV
X-Google-Smtp-Source: APXvYqyT+WT22Dd9fik4aOQ+fwZJOBB+J86GyLCFMtLyz1EfsEW+3o1hzbiu35xZzsVRkf48pIJaGA==
X-Received: by 2002:a63:201b:: with SMTP id g27mr17489728pgg.56.1574449232735;
        Fri, 22 Nov 2019 11:00:32 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id c9sm8059326pfb.114.2019.11.22.11.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 11:00:32 -0800 (PST)
Date:   Fri, 22 Nov 2019 11:00:30 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 20/22] t7700: move keywords onto their own line
Message-ID: <560f6183345593558e7f8d9ca2064947b537d7a0.1574449072.git.liu.denton@gmail.com>
References: <cover.1574296987.git.liu.denton@gmail.com>
 <cover.1574449072.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574449072.git.liu.denton@gmail.com>
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
2.24.0.497.g17aadd8971

