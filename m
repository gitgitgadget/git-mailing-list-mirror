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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37439C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E732071B
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vISSiJKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfKVTAj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:00:39 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37540 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfKVTAj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 14:00:39 -0500
Received: by mail-pf1-f196.google.com with SMTP id p24so3900160pfn.4
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 11:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kIh+R8Tz4hH5QOc8aeYi+rj5cve1OTMotpEx1MjIA7k=;
        b=vISSiJKgXEPCAH1Yqdx7UEqPE/QXKdKvHzBpOYKGC9qT+68EiJVfquqtCCAcSpNBP0
         oERoCoWB61v/G0jTfZxkfUSmyQ64FAmPNdTWWz/3256DYapfcSONQw/uKw5R4xS4Npyz
         g9+tf0Db0zgb89U9YRhM0PonxAbL03OsIwb7kb1uol8ZPH3yDLL2sHAtSDbFsK4QuvoI
         JhO2Cs8nvKMUYisTAeu0G4gjtY3h/LQixLu7UXuoiyox1a0mcret6YKt9juX/iRuZp86
         qKWvkYvaKD5ukkts5vEw8tZPw5t+4BZXDr7C9m3ivJvESMkgYx16nQGSPW5KoU2L2Zq9
         a7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kIh+R8Tz4hH5QOc8aeYi+rj5cve1OTMotpEx1MjIA7k=;
        b=O6YOXJWx15Rc4jdFx1a7cNnK00P6PnCDXe7JclTv2a3lrDJzT2NPfa0wuze5fpgnrs
         GrTDp+ItruFwexILL+D9FB4dcSFQRBon13id98n1bYDJ7feSEJIoXzlo1WE6Yfr2vu60
         TPLrY5PyLTDxJebos9CzOKdfEhrS+rGOCuCuQsJ2Cl6g70N6uiY5abfZ92aGupqDpJVn
         r7dY263ItfEm7pHdcP5SY5DceTEel3aZ0Ym0Ew7pv0PWSYfODVAF/FYHtfBllPvTbwdz
         X9ITnf0xB0ewWExBS5w47CR/8s8dV/s10jvEun2YsTWvtwv+MT4Ykj0+veOL2/qGxPPo
         iIUA==
X-Gm-Message-State: APjAAAVnzZh+rXfPC44dD+Z36FV4AxFdJu+tXvo2zQx1pqrUgvbMTagJ
        u7zxq4KAPIdMVpQbFrUSB79SEAMT
X-Google-Smtp-Source: APXvYqxJpcfq7MFTYCpq0yT/61LcYuWEhPYn5v0TQPeP877nfGbZjjjtNLejC4YUPovGTZfuMvrwbw==
X-Received: by 2002:a62:2f01:: with SMTP id v1mr19454907pfv.73.1574449237439;
        Fri, 22 Nov 2019 11:00:37 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id c16sm7966945pfo.34.2019.11.22.11.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 11:00:36 -0800 (PST)
Date:   Fri, 22 Nov 2019 11:00:35 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 22/22] t7700: stop losing return codes of git commands
Message-ID: <e9835b85427a3486e2dba136bbf34506e521d355.1574449072.git.liu.denton@gmail.com>
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

In a pipe, only the return code of the last command is used. Thus, all
other commands will have their return codes masked. Rewrite pipes so
that there are no git commands upstream so that we will know if a
command fails.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7700-repack.sh | 64 ++++++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 1d14ddcbdb..ff50722e26 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -18,14 +18,13 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 	git commit -m initial_commit &&
 	# Create two packs
 	# The first pack will contain all of the objects except one
-	git rev-list --objects --all | grep -v file2 |
-		git pack-objects pack &&
+	git rev-list --objects --all >objs &&
+	grep -v file2 objs | git pack-objects pack &&
 	# The second pack will contain the excluded object
-	packsha1=$(git rev-list --objects --all | grep file2 |
-		git pack-objects pack) &&
+	packsha1=$(grep file2 objs | git pack-objects pack) &&
 	>pack-$packsha1.keep &&
-	objsha1=$(git verify-pack -v pack-$packsha1.idx | head -n 1 |
-		sed -e "s/^\([0-9a-f]\{40\}\).*/\1/") &&
+	git verify-pack -v pack-$packsha1.idx >packlist &&
+	objsha1=$(head -n 1 packlist | sed -e "s/^\([0-9a-f]\{40\}\).*/\1/") &&
 	mv pack-* .git/objects/pack/ &&
 	git repack -A -d -l &&
 	git prune-packed &&
@@ -33,7 +32,8 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 	do
 		idx=$(basename $p)
 		test "pack-$packsha1.idx" = "$idx" && continue
-		if git verify-pack -v $p | egrep "^$objsha1"
+		git verify-pack -v $p >packlist || return $?
+		if egrep "^$objsha1" packlist
 		then
 			found_duplicate_object=1
 			echo "DUPLICATE OBJECT FOUND"
@@ -51,7 +51,8 @@ test_expect_success 'writing bitmaps via command-line can duplicate .keep object
 	do
 		idx=$(basename $p)
 		test "pack-$packsha1.idx" = "$idx" && continue
-		if git verify-pack -v $p | egrep "^$objsha1"
+		git verify-pack -v $p >packlist || return $?
+		if egrep "^$objsha1" packlist
 		then
 			found_duplicate_object=1
 			echo "DUPLICATE OBJECT FOUND"
@@ -69,7 +70,8 @@ test_expect_success 'writing bitmaps via config can duplicate .keep objects' '
 	do
 		idx=$(basename $p)
 		test "pack-$packsha1.idx" = "$idx" && continue
-		if git verify-pack -v $p | egrep "^$objsha1"
+		git verify-pack -v $p >packlist || return $?
+		if egrep "^$objsha1" packlist
 		then
 			found_duplicate_object=1
 			echo "DUPLICATE OBJECT FOUND"
@@ -91,7 +93,8 @@ test_expect_success 'loose objects in alternate ODB are not repacked' '
 	git prune-packed &&
 	for p in .git/objects/pack/*.idx
 	do
-		if git verify-pack -v $p | egrep "^$objsha1"
+		git verify-pack -v $p >packlist || return $?
+		if egrep "^$objsha1" packlist
 		then
 			found_duplicate_object=1
 			echo "DUPLICATE OBJECT FOUND"
@@ -109,15 +112,18 @@ test_expect_success 'packed obs in alt ODB are repacked even when local repo is
 	test_path_is_file "$myidx" &&
 	for p in alt_objects/pack/*.idx
 	do
-		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
-	done | while read sha1 rest
+		git verify-pack -v $p >packlist || return $?
+		sed -n -e "/^[0-9a-f]\{40\}/p"
+	done >packs &&
+	git verify-pack -v $myidx >mypacklist &&
+	while read sha1 rest
 	do
-		if ! ( git verify-pack -v $myidx | grep "^$sha1" )
+		if ! grep "^$sha1" mypacklist
 		then
 			echo "Missing object in local pack: $sha1"
 			return 1
 		fi
-	done
+	done <packs
 '
 
 test_expect_success 'packed obs in alt ODB are repacked when local repo has packs' '
@@ -132,15 +138,18 @@ test_expect_success 'packed obs in alt ODB are repacked when local repo has pack
 	test_path_is_file "$myidx" &&
 	for p in alt_objects/pack/*.idx
 	do
-		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
-	done | while read sha1 rest
+		git verify-pack -v $p >packlist || return $?
+		sed -n -e "/^[0-9a-f]\{40\}/p" packlist
+	done >packs &&
+	git verify-pack -v $myidx >mypacklist &&
+	while read sha1 rest
 	do
-		if ! ( git verify-pack -v $myidx | grep "^$sha1" )
+		if ! grep "^$sha1" mypacklist
 		then
 			echo "Missing object in local pack: $sha1"
 			return 1
 		fi
-	done
+	done <packs
 '
 
 test_expect_success 'packed obs in alternate ODB kept pack are repacked' '
@@ -160,15 +169,18 @@ test_expect_success 'packed obs in alternate ODB kept pack are repacked' '
 	test_path_is_file "$myidx" &&
 	for p in alt_objects/pack/*.idx
 	do
-		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
-	done | while read sha1 rest
+		git verify-pack -v $p >packlist || return $?
+		sed -n -e "/^[0-9a-f]\{40\}/p" packlist
+	done >packs &&
+	git verify-pack -v $myidx >mypacklist &&
+	while read sha1 rest
 	do
-		if ! ( git verify-pack -v $myidx | grep "^$sha1" )
+		if ! grep "^$sha1" mypacklist
 		then
 			echo "Missing object in local pack: $sha1"
 			return 1
 		fi
-	done
+	done <packs
 '
 
 test_expect_success 'packed unreachable obs in alternate ODB are not loosened' '
@@ -184,8 +196,8 @@ test_expect_success 'packed unreachable obs in alternate ODB are not loosened' '
 	    --unpack-unreachable </dev/null pack &&
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
-	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
-		egrep "^$csha1 " | sort | uniq | wc -l) &&
+	git verify-pack -v -- .git/objects/pack/*.idx >packlist &&
+	! egrep "^$csha1 " packlist &&
 	echo >.git/objects/info/alternates &&
 	test_must_fail git show $csha1
 '
@@ -201,8 +213,8 @@ test_expect_success 'local packed unreachable obs that exist in alternate ODB ar
 	    --unpack-unreachable </dev/null pack &&
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
-	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
-		egrep "^$csha1 " | sort | uniq | wc -l) &&
+	git verify-pack -v -- .git/objects/pack/*.idx >packlist &&
+	! egrep "^$csha1 " &&
 	echo >.git/objects/info/alternates &&
 	test_must_fail git show $csha1
 '
-- 
2.24.0.497.g17aadd8971

