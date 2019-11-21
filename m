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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69801C432C3
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3334B20855
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHjNreiA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfKUAqk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:46:40 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43885 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfKUAqj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 19:46:39 -0500
Received: by mail-pl1-f194.google.com with SMTP id a18so665354plm.10
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 16:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bBWELYv/YWei75f1eRIQEVZNFwUObIm1cuZgkKTpF/8=;
        b=SHjNreiA89Ja8ObyduhMn0HkqteCGsxiSs0oAti26N88ItqBfUU1ZTTVMwi8jm9duB
         AJ8E0urNwRIGhP7GrbUKHiVoS6tgBVUQM3TjcJMcEYLUP8fjXuVGdLNBRE/icnNUXtl1
         VsIhKQX4y6hKkH9uAp9VxTB5/KKZJQjem/MI2/sPWMe+cYbIhW9ZHJ1aqPxl3AgtUfs6
         uk615oqUiLPTqh+TH1WqrGY2Jk60CjNgxvzILm5fEWSyasHdcQKpFbeF8l30J8tlNStk
         ugR3EPKB9zWUD3dwFwpStHOWcrcfxc1TiESf8dvHp5bvskXgUCcCVl/PCG+TZZJVzfHL
         iC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bBWELYv/YWei75f1eRIQEVZNFwUObIm1cuZgkKTpF/8=;
        b=OQ1Hj/1++ugJ4+6Xg2fl2gIGpQSelgXwoGpEOztYcgI3cN8vQZC0q3AgnSVeowNz9o
         08sfq9+S2grrtU6V+l/yoshYDmMDLNI8Tc98ZI5xH3rNyRd6HnhOkJUSwl2Hmh+uifQa
         idJCHh0RfRHh99pdYicRJBDuXP1ltoY1l6D9ta04OOgTA9WRMvguUPAu6Yh+lFFsQgEn
         8gGq5d+fPKp2ABcLydWuFXQc9TJ6y04m7H+Qe2ueqLNvizcU7uK3ZJDhHiSjQ+6pf8RP
         QyxmpFoyDTLcS2SSxlqw8lVmQ+5XVTfTPQ4PK6r1GBYHwfS1AbRJUDEDNxcg831oITzn
         pn9Q==
X-Gm-Message-State: APjAAAWJiF2lFX26bSWAlsBsuAwWtadmP3ELlKgIc8ksw/r51CgdmVeF
        gGqZr1ckNqefclspp6pwJ7GQPbEW
X-Google-Smtp-Source: APXvYqzoawOQ5ppvEEsojgGfwU4PPBrmAnblNp7iQ1OVbXv2+J8QISiz6JNGPY00v4q561ZdwIJW5g==
X-Received: by 2002:a17:902:70c1:: with SMTP id l1mr5862276plt.109.1574297198498;
        Wed, 20 Nov 2019 16:46:38 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id q200sm605805pfq.87.2019.11.20.16.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 16:46:37 -0800 (PST)
Date:   Wed, 20 Nov 2019 16:46:36 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 21/21] t7700: stop losing return codes of git commands
Message-ID: <a455fbb625bf33111c67dd3bd7bb03d5d47d0c0a.1574296987.git.liu.denton@gmail.com>
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
2.24.0.450.g7a9a4598a9

