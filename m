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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27085C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA23D2068F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4F+IS+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKZBSv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:18:51 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39431 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfKZBSu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:18:50 -0500
Received: by mail-pf1-f195.google.com with SMTP id x28so8304476pfo.6
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 17:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DiqKgUsboSwYzVhrkU4texgiVXAXQSsL2asPDjXURf0=;
        b=R4F+IS+9mxT0yasHsB7mrsdkOrz8/a8oirf+u6rd8dKvgRbuF2q8iggn3iziFzLdw1
         3/053NcGQv1JdtP/hIetCyGViGG9bC7UxxqQ976XCBo4NfWhJbHZF7LYy+K1Xipce9BF
         AQ73ziSTJ1DdIKGXJauahP0DxsfRfHcrKBmDimHjysoO09PM9uoudxwW421fiNVNp88/
         lDwMOeSA9YaaYvjC4wDAZgnhH+09lqkFlsyLc3NQ0cgx0joy41TbwKQEiuxpCXiK9T8z
         7yzjWG/Hsp6ZyVk8nhKdDEqkfY8Mpd7sSHA4qIG1ctlEGKt/fUOXQipZS1PF42XmFaP2
         wCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DiqKgUsboSwYzVhrkU4texgiVXAXQSsL2asPDjXURf0=;
        b=D2WDOhfoXuqr+6+qS6VvA/prditoE3j1qlAHH3kj+3tNjgK/k6nI0jLEN0io4znZJ8
         QjMeBgsrFE7B0nlKX6XkaadOyhtvOlcD2/kY5awsj6jOpUvqz3JxE4d+T9RWwib0MdeN
         fZ9gIc+EewRJpBysjJNsKFMn4u7g64gwu0nqxW66oww86gpKp4U1G8YesszSHPnQ8EZN
         y/9tX9f8dFvK4LbfplrfDqS5Nssr6/r/LrNl6u7rXqC9gpJOAjT2w2slTpczoYlvTiJx
         ofTmESwRWzsBNvc4lLWf4ZqUvWkGteZemtZR8VK9yThaPlZw7qpERVAT5+YvhOYAUbsG
         u2Qw==
X-Gm-Message-State: APjAAAVe681/5Tpnc4uOaMQWm8js+w/Qf9tqBbFpPhuGH4dd/Co2vWqQ
        hUuE7H2nxvBxP92407lVcOMUv7Vz
X-Google-Smtp-Source: APXvYqxWe5NDX6o3QlYvfGWnLjw1IM9LEEXZ8rrO2mYmCWY77lGG0FibkVU8ct3KL8gEmi3s5vTZKQ==
X-Received: by 2002:a63:5715:: with SMTP id l21mr35207911pgb.266.1574731128203;
        Mon, 25 Nov 2019 17:18:48 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id c2sm9806873pfn.55.2019.11.25.17.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 17:18:47 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:18:46 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 26/27] t7700: make references to SHA-1 generic
Message-ID: <a747fbd08b46f394c4dc1e9f9b8399d13d294273.1574731022.git.liu.denton@gmail.com>
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

Make the test more hash-agnostic by renaming variables from "sha1" to
"oid" (case-insensitively). Also, replace the regex, `[0-9a-f]\{40\}`
with `$OID_REGEX`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7700-repack.sh | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 2493cc4e9b..d96b1a5949 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -6,31 +6,31 @@ test_description='git repack works correctly'
 
 commit_and_pack () {
 	test_commit "$@" 1>&2 &&
-	SHA1=$(git pack-objects --all --unpacked --incremental .git/objects/pack/pack </dev/null) &&
-	echo pack-${SHA1}.pack
+	OID=$(git pack-objects --all --unpacked --incremental .git/objects/pack/pack </dev/null) &&
+	echo pack-${OID}.pack
 }
 
 test_no_missing_in_packs () {
 	myidx=$(ls -1 .git/objects/pack/*.idx) &&
 	test_path_is_file "$myidx" &&
 	git verify-pack -v alt_objects/pack/*.idx >orig.raw &&
-	grep "^[0-9a-f]\{40\}" orig.raw | cut -d" " -f1 | sort >orig &&
+	grep "^$OID_REGEX" orig.raw | cut -d" " -f1 | sort >orig &&
 	git verify-pack -v $myidx >dest.raw &&
 	cut -d" " -f1 dest.raw | sort >dest &&
 	comm -23 orig dest >missing &&
 	test_must_be_empty missing
 }
 
-# we expect $packsha1 and $objsha1 to be defined
+# we expect $packoid and $objoid to be defined
 test_has_duplicate_object () {
 	want_duplicate_object="$1"
 	found_duplicate_object=false
 	for p in .git/objects/pack/*.idx
 	do
 		idx=$(basename $p)
-		test "pack-$packsha1.idx" = "$idx" && continue
+		test "pack-$packoid.idx" = "$idx" && continue
 		git verify-pack -v $p >packlist || return $?
-		if grep "^$objsha1" packlist
+		if grep "^$objoid" packlist
 		then
 			found_duplicate_object=true
 			echo "DUPLICATE OBJECT FOUND"
@@ -51,11 +51,11 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 	git rev-list --objects --all | grep -v file2 |
 		git pack-objects pack &&
 	# The second pack will contain the excluded object
-	packsha1=$(git rev-list --objects --all | grep file2 |
+	packoid=$(git rev-list --objects --all | grep file2 |
 		git pack-objects pack) &&
-	>pack-$packsha1.keep &&
-	objsha1=$(git verify-pack -v pack-$packsha1.idx | head -n 1 |
-		sed -e "s/^\([0-9a-f]\{40\}\).*/\1/") &&
+	>pack-$packoid.keep &&
+	objoid=$(git verify-pack -v pack-$packoid.idx | head -n 1 |
+		sed -e "s/^\($OID_REGEX\).*/\1/") &&
 	mv pack-* .git/objects/pack/ &&
 	git repack -A -d -l &&
 	git prune-packed &&
@@ -63,13 +63,13 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 '
 
 test_expect_success 'writing bitmaps via command-line can duplicate .keep objects' '
-	# build on $objsha1, $packsha1, and .keep state from previous
+	# build on $objoid, $packoid, and .keep state from previous
 	git repack -Adbl &&
 	test_has_duplicate_object true
 '
 
 test_expect_success 'writing bitmaps via config can duplicate .keep objects' '
-	# build on $objsha1, $packsha1, and .keep state from previous
+	# build on $objoid, $packoid, and .keep state from previous
 	git -c repack.writebitmaps=true repack -Adl &&
 	test_has_duplicate_object true
 '
@@ -78,7 +78,7 @@ test_expect_success 'loose objects in alternate ODB are not repacked' '
 	mkdir alt_objects &&
 	echo $(pwd)/alt_objects >.git/objects/info/alternates &&
 	echo content3 >file3 &&
-	objsha1=$(GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w file3) &&
+	objoid=$(GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w file3) &&
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
2.24.0.504.g3cd56eb17d

