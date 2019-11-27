Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F0EC432C3
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD4920835
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrgmezLU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfK0TyA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:54:00 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39685 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfK0TyA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:54:00 -0500
Received: by mail-pg1-f193.google.com with SMTP id b137so9149248pga.6
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 11:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FTtG2eg54HJ8MNXH5T8m8riTIBnJQi+iLgrelc3/uXs=;
        b=XrgmezLU3qXvF5GtEBR9dO/IUJ82cwYFq6Di9BuQFt12tmc2tsbI4o3iz7zyLJzBan
         cn7wO/jAMTvTn79hXY251I4dG+a7DJQ2Rxrw+Upvrv+4RlTK2yv1HekdQSQ7+awnZUmU
         ARrdg8O7xx+b7L+rbrtVQP6m1SGUctbAOJpwfLf0dBclVFAf41nSgF8woUXTOf9ebiMX
         VSVHRPBuFai5d2OlBLQwUj9829nq6H2f/fAuv25Vi/d3aZCzWHU8OX1987GXoM0ZekSo
         IBfr64AUd8Yhgs/v0dPke0f3SsXi0XAILNnoTYMWS8ZdIK9w/QaBdDPltJUvDgkJEJXU
         UfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FTtG2eg54HJ8MNXH5T8m8riTIBnJQi+iLgrelc3/uXs=;
        b=F3fO9afanCtZ/pnl+JmtkvIMcHZSx2FOvbG0J7HMjKq3504sRxsTrTpbttONazmIk0
         lkY8beF/seG4P097InMkIdot+FEmmi0c78LTmMYpZmUI8kCa+0r1HpCALrtoflPnspCx
         w0VzVXOruUn728lRzTXx1B/90VtszPPgPTkqYgA9cywxw9xl65Y3Sn8OJJcYIbadpGn8
         g2xrznuPTXznxiHVxyX84hQbKvSaiCgd5TONgeA2hdVJClnaseb+5M50uRQZzuHho8WH
         TMp5E1x3HFLl3/YS8KPU2x1QAJc1t59fvlf2iXyfoUugPbsbGOkFJrN/KsqSotlaI7h5
         5vfg==
X-Gm-Message-State: APjAAAUp+SyKk6dwZ6Zi30BOzAdniP4zZTbUa/sMpJ2HphY0ZjdCMobV
        TLZhMtGb0slOzDnv/F179L8Sh8u4
X-Google-Smtp-Source: APXvYqxpukd674Pf1Qnp4SBfsufYvdLairz7HQ09zqh5FCZ94lpG/Sy61xunMLwF/VO9Ui250W5LuQ==
X-Received: by 2002:a63:e316:: with SMTP id f22mr6915329pgh.102.1574884439257;
        Wed, 27 Nov 2019 11:53:59 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id x190sm17542528pfc.89.2019.11.27.11.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:53:58 -0800 (PST)
Date:   Wed, 27 Nov 2019 11:53:56 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 23/26] t7700: consolidate code into
 test_has_duplicate_object()
Message-ID: <f79240e937300febc468363bb8e96160e7683b7f.1574884302.git.liu.denton@gmail.com>
References: <cover.1574731022.git.liu.denton@gmail.com>
 <cover.1574884302.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574884302.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code to test that objects were not duplicated from the packfile was
duplicated many times. Extract the duplicated code into
test_has_duplicate_object() and use that instead.

Refactor the resulting extraction so that if the git command fails,
the return code is not silently lost.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7700-repack.sh | 71 +++++++++++++++--------------------------------
 1 file changed, 23 insertions(+), 48 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 4bcd9fcc80..5bbed02fe5 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -21,6 +21,25 @@ test_no_missing_in_packs () {
 	test_must_be_empty missing
 }
 
+# we expect $packsha1 and $objsha1 to be defined
+test_has_duplicate_object () {
+	want_duplicate_object="$1"
+	found_duplicate_object=false
+	for p in .git/objects/pack/*.idx
+	do
+		idx=$(basename $p)
+		test "pack-$packsha1.idx" = "$idx" && continue
+		git verify-pack -v $p >packlist || return $?
+		if egrep "^$objsha1" packlist
+		then
+			found_duplicate_object=true
+			echo "DUPLICATE OBJECT FOUND"
+			break
+		fi
+	done &&
+	test "$want_duplicate_object" = "$found_duplicate_object"
+}
+
 test_expect_success 'objects in packs marked .keep are not repacked' '
 	echo content1 >file1 &&
 	echo content2 >file2 &&
@@ -40,54 +59,19 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 	mv pack-* .git/objects/pack/ &&
 	git repack -A -d -l &&
 	git prune-packed &&
-	for p in .git/objects/pack/*.idx
-	do
-		idx=$(basename $p)
-		test "pack-$packsha1.idx" = "$idx" && continue
-		if git verify-pack -v $p | egrep "^$objsha1"
-		then
-			found_duplicate_object=1
-			echo "DUPLICATE OBJECT FOUND"
-			break
-		fi
-	done &&
-	test -z "$found_duplicate_object"
+	test_has_duplicate_object false
 '
 
 test_expect_success 'writing bitmaps via command-line can duplicate .keep objects' '
 	# build on $objsha1, $packsha1, and .keep state from previous
 	git repack -Adbl &&
-	test_when_finished "found_duplicate_object=" &&
-	for p in .git/objects/pack/*.idx
-	do
-		idx=$(basename $p)
-		test "pack-$packsha1.idx" = "$idx" && continue
-		if git verify-pack -v $p | egrep "^$objsha1"
-		then
-			found_duplicate_object=1
-			echo "DUPLICATE OBJECT FOUND"
-			break
-		fi
-	done &&
-	test "$found_duplicate_object" = 1
+	test_has_duplicate_object true
 '
 
 test_expect_success 'writing bitmaps via config can duplicate .keep objects' '
 	# build on $objsha1, $packsha1, and .keep state from previous
 	git -c repack.writebitmaps=true repack -Adl &&
-	test_when_finished "found_duplicate_object=" &&
-	for p in .git/objects/pack/*.idx
-	do
-		idx=$(basename $p)
-		test "pack-$packsha1.idx" = "$idx" && continue
-		if git verify-pack -v $p | egrep "^$objsha1"
-		then
-			found_duplicate_object=1
-			echo "DUPLICATE OBJECT FOUND"
-			break
-		fi
-	done &&
-	test "$found_duplicate_object" = 1
+	test_has_duplicate_object true
 '
 
 test_expect_success 'loose objects in alternate ODB are not repacked' '
@@ -100,16 +84,7 @@ test_expect_success 'loose objects in alternate ODB are not repacked' '
 	git commit -m commit_file3 &&
 	git repack -a -d -l &&
 	git prune-packed &&
-	for p in .git/objects/pack/*.idx
-	do
-		if git verify-pack -v $p | egrep "^$objsha1"
-		then
-			found_duplicate_object=1
-			echo "DUPLICATE OBJECT FOUND"
-			break
-		fi
-	done &&
-	test -z "$found_duplicate_object"
+	test_has_duplicate_object false
 '
 
 test_expect_success 'packed obs in alt ODB are repacked even when local repo is packless' '
-- 
2.24.0.504.g3cd56eb17d

