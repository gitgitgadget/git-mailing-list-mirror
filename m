Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2B7C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60A72068F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtXmVRd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfKZBSg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:18:36 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32924 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfKZBSg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:18:36 -0500
Received: by mail-pl1-f193.google.com with SMTP id ay6so7366464plb.0
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 17:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d1AG+rPKY26gU4AjXr/WO4BMUs1TbXq2102nCb0bGWo=;
        b=RtXmVRd392nwmNhQgTNlYZeX7GdkSDEq9t3alEpGJQcjLHWdYBzhwBm7XfPvwcffhM
         lf6By7BQGbYfjexs/wTplMJpG8gvfz8WyMSwlW1Ih5t49nYpUn1Wv2/jRl9mG7F/XPJB
         1wvrG/hLtcXiI/28qfcZgngeyuXJYSrgBFV8cmPk2IgQlO/8Jk+mlQ2a/SeOalhIi0vx
         CkqOiGDTYoDWKWU0VsPfeZ62Jn1PJ7NoJM66qCVOzuiAaxNeoRbrBB3jDTS2+i0SASsy
         kq70FIolqcLIIACX6JUK+VVrwJMtZb6oBtzBps8rdDeIXZ6ZIzdixLGB6fEPNUa5a9+D
         0wGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d1AG+rPKY26gU4AjXr/WO4BMUs1TbXq2102nCb0bGWo=;
        b=YSuP6VNstlzSfWRHZzMc3tlRZq4iNyAu3ukYLHCxs9UNV/naVYyqXNFtn1gdJ4pXeD
         eKbxoiUBNP2XkuPq4ELqOjgLGctHgWjC3UXEALzr9kgepJLXdvhYvJBugNZEnhotdfHZ
         /C1G7y2RPslWbiFPxUJKRcXG7KvD2Tt0JdijN9M42pcivd2ov7epZCM+KQzF4cxe4iRs
         Dcq9NJy0aL0eVFvYqhtPbogzPqC+5tYJ2TfUrLkhH18TLDcmxCA8B7OsocccR3gJXyk4
         YXzK7qK+3q7FUZYIEXm7ZNDP+4Qm+W9vyj6AUUamBt0MCLiAVKEmzL4WVlTFksKLWHSQ
         1qvw==
X-Gm-Message-State: APjAAAVylnULNJOn8ZENiNp4EOEYT++0/FSbteK2g5wBLpdgvznj6LVv
        UZ/EMtO5tmUeHBFghvyZhzFMxRDF
X-Google-Smtp-Source: APXvYqyxZLg5yO22Kkqu/lX78vMchW0hGitezvb3NPF9eW4LuHdHQa5OyIPFPJs1k/U+gFDRs2z2Ww==
X-Received: by 2002:a17:902:8bc8:: with SMTP id r8mr32211452plo.189.1574731114536;
        Mon, 25 Nov 2019 17:18:34 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id w69sm10002093pfc.164.2019.11.25.17.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 17:18:34 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:18:32 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 20/27] t7700: move keywords onto their own line
Message-ID: <82bf24d06ab663d404a717ae9091dd272d1c3396.1574731022.git.liu.denton@gmail.com>
References: <cover.1574449072.git.liu.denton@gmail.com>
 <cover.1574731022.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574731022.git.liu.denton@gmail.com>
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
2.24.0.504.g3cd56eb17d

