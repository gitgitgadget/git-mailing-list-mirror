Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3E6C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D543A21826
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnMFMVnd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbfLDWDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:03:31 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33447 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfLDWDa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 17:03:30 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so527397pgk.0
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 14:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1bxwgvNh24W16drycVbxRAjN5TPRSPl8CyG6Jhhqxj0=;
        b=KnMFMVnduXxJM5afpaA4f23CP1O0l2D1y21cYY2FO/rCc8TxHfgpRs5Zc8LWESL33p
         obcIcytYIaoqSY/CttGNEn3jjICt/7JC0rMQ08O3KcNBJmX0wdBnf5KmqNJ2E9piSWFo
         OPBz1xg9p5p2aQD7KBXcSa1iAVZWKOiXvApdbJfvjdbcu4nlyWCAJErTvbqP8E/uZCX4
         CdiWhlwYfreUDUGv+W+Qlyh5+V7+l8xPFoMMCnjF7EU1FarwuLmArxfX7ms4yh/HmYvD
         14h/61+0pGQ+OqcgKzovlZf11mPdBdym7cEMyCX8hhFQbQhDP2PDp7qwqYVAAiseed1o
         wYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1bxwgvNh24W16drycVbxRAjN5TPRSPl8CyG6Jhhqxj0=;
        b=XV9K38iqgAcSDmpaNPoDO32jzB35BMtORoPq2PS36bGpCUlKpw6T+D6vV6dw9bBvKy
         SCmRcZxfWZi8nD3Cv397WOe0GmfMwDfajbMZg9SRQNMPfyexZs/ruhUkvWQHZ2jPbg5G
         Z5q5rX5CfF+HZLv9lfmpAry2CEfe2diy+r8J8Cb9b1ljEmdLNyvEi7m398Zn1cD2vYPd
         o5BUcalUPju33qtT63Q0qWHHxwkYCIokAcuFeVJVzUhfnxixppfTN2JbncIrIJTHB3NC
         RDyfDefajAjUiCO/zPZs0mVD0N6B7PGEEedElIPWyO40x1T7dnDqnlP9GXw/9pIEr9dh
         LDMQ==
X-Gm-Message-State: APjAAAU/U6qzZ+QQTP8sjAjAbMDcSAhAhj5BD2N0AmMa2hQ7ZFaDw8KP
        FCAdPFsxLocomzSG355yld9ELiF8
X-Google-Smtp-Source: APXvYqyqBBxPewaV9gM7RpVmN7MC/I0uU6AJIakdPY2QE7X5IVLoX3kJwZZS2me0+wOUjDOENQS2NA==
X-Received: by 2002:a63:ff5c:: with SMTP id s28mr5751869pgk.196.1575497009575;
        Wed, 04 Dec 2019 14:03:29 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id w12sm2706983pfd.58.2019.12.04.14.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 14:03:29 -0800 (PST)
Date:   Wed, 4 Dec 2019 14:03:24 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v6 4/5] t7700: make references to SHA-1 generic
Message-ID: <113f375192655c3cb566770cb7f1c4f993e51b47.1575496684.git.liu.denton@gmail.com>
References: <xmqq1rtk557e.fsf@gitster-ct.c.googlers.com>
 <cover.1575496683.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575496683.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the test more hash-agnostic by renaming variables from "sha1" to
some variation of "oid" or "packid". Also, replace the regex,
`[0-9a-f]\{40\}` with `$OID_REGEX`.

A better name for "incrpackid" (incremental pack-id) might have been
just "packid". However, later in the test suite, we have other uses of
"packid". Although the scopes of these variables don't conflict, a
future developer may think that commit_and_pack() and
test_has_duplicate_object() are semantically related somehow since they
share the same variable name. Give them distinct names so that it's
clear these uses are unrelated.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7700-repack.sh | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index bfef5888a2..5229999d77 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -6,31 +6,31 @@ test_description='git repack works correctly'
 
 commit_and_pack () {
 	test_commit "$@" 1>&2 &&
-	SHA1=$(git pack-objects --all --unpacked --incremental .git/objects/pack/pack </dev/null) &&
-	echo pack-${SHA1}.pack
+	incrpackid=$(git pack-objects --all --unpacked --incremental .git/objects/pack/pack </dev/null) &&
+	echo pack-${incrpackid}.pack
 }
 
 test_no_missing_in_packs () {
 	myidx=$(ls -1 .git/objects/pack/*.idx) &&
 	test_path_is_file "$myidx" &&
 	git verify-pack -v alt_objects/pack/*.idx >orig.raw &&
-	sed -n -e "s/^\([0-9a-f]\{40\}\).*/\1/p" orig.raw | sort >orig &&
+	sed -n -e "s/^\($OID_REGEX\).*/\1/p" orig.raw | sort >orig &&
 	git verify-pack -v $myidx >dest.raw &&
 	cut -d" " -f1 dest.raw | sort >dest &&
 	comm -23 orig dest >missing &&
 	test_must_be_empty missing
 }
 
-# we expect $packsha1 and $objsha1 to be defined
+# we expect $packid and $oid to be defined
 test_has_duplicate_object () {
 	want_duplicate_object="$1"
 	found_duplicate_object=false
 	for p in .git/objects/pack/*.idx
 	do
 		idx=$(basename $p)
-		test "pack-$packsha1.idx" = "$idx" && continue
+		test "pack-$packid.idx" = "$idx" && continue
 		git verify-pack -v $p >packlist || return $?
-		if grep "^$objsha1" packlist
+		if grep "^$oid" packlist
 		then
 			found_duplicate_object=true
 			echo "DUPLICATE OBJECT FOUND"
@@ -51,11 +51,11 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 	git rev-list --objects --all | grep -v file2 |
 		git pack-objects pack &&
 	# The second pack will contain the excluded object
-	packsha1=$(git rev-list --objects --all | grep file2 |
+	packid=$(git rev-list --objects --all | grep file2 |
 		git pack-objects pack) &&
-	>pack-$packsha1.keep &&
-	objsha1=$(git verify-pack -v pack-$packsha1.idx | head -n 1 |
-		sed -e "s/^\([0-9a-f]\{40\}\).*/\1/") &&
+	>pack-$packid.keep &&
+	oid=$(git verify-pack -v pack-$packid.idx | head -n 1 |
+		sed -e "s/^\($OID_REGEX\).*/\1/") &&
 	mv pack-* .git/objects/pack/ &&
 	git repack -A -d -l &&
 	git prune-packed &&
@@ -63,13 +63,13 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 '
 
 test_expect_success 'writing bitmaps via command-line can duplicate .keep objects' '
-	# build on $objsha1, $packsha1, and .keep state from previous
+	# build on $oid, $packid, and .keep state from previous
 	git repack -Adbl &&
 	test_has_duplicate_object true
 '
 
 test_expect_success 'writing bitmaps via config can duplicate .keep objects' '
-	# build on $objsha1, $packsha1, and .keep state from previous
+	# build on $oid, $packid, and .keep state from previous
 	git -c repack.writebitmaps=true repack -Adl &&
 	test_has_duplicate_object true
 '
@@ -78,7 +78,7 @@ test_expect_success 'loose objects in alternate ODB are not repacked' '
 	mkdir alt_objects &&
 	echo $(pwd)/alt_objects >.git/objects/info/alternates &&
 	echo content3 >file3 &&
-	objsha1=$(GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w file3) &&
+	oid=$(GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w file3) &&
 	git add file3 &&
 	test_tick &&
 	git commit -m commit_file3 &&
@@ -124,7 +124,7 @@ test_expect_success 'packed obs in alternate ODB kept pack are repacked' '
 test_expect_success 'packed unreachable obs in alternate ODB are not loosened' '
 	rm -f alt_objects/pack/*.keep &&
 	mv .git/objects/pack/* alt_objects/pack/ &&
-	csha1=$(git rev-parse HEAD^{commit}) &&
+	coid=$(git rev-parse HEAD^{commit}) &&
 	git reset --hard HEAD^ &&
 	test_tick &&
 	git reflog expire --expire=$test_tick --expire-unreachable=$test_tick --all &&
@@ -135,14 +135,14 @@ test_expect_success 'packed unreachable obs in alternate ODB are not loosened' '
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
 	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
-		grep "^$csha1 " | sort | uniq | wc -l) &&
+		grep "^$coid " | sort | uniq | wc -l) &&
 	echo >.git/objects/info/alternates &&
-	test_must_fail git show $csha1
+	test_must_fail git show $coid
 '
 
 test_expect_success 'local packed unreachable obs that exist in alternate ODB are not loosened' '
 	echo $(pwd)/alt_objects >.git/objects/info/alternates &&
-	echo "$csha1" | git pack-objects --non-empty --all --reflog pack &&
+	echo "$coid" | git pack-objects --non-empty --all --reflog pack &&
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
 	# The pack-objects call on the next line is equivalent to
@@ -152,9 +152,9 @@ test_expect_success 'local packed unreachable obs that exist in alternate ODB ar
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
 	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
-		grep "^$csha1 " | sort | uniq | wc -l) &&
+		grep "^$coid " | sort | uniq | wc -l) &&
 	echo >.git/objects/info/alternates &&
-	test_must_fail git show $csha1
+	test_must_fail git show $coid
 '
 
 test_expect_success 'objects made unreachable by grafts only are kept' '
-- 
2.24.0.578.g4820254054

