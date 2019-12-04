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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBF0C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC792073C
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1N0Qcjk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbfLDWDU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:03:20 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35374 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfLDWDU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 17:03:20 -0500
Received: by mail-pg1-f194.google.com with SMTP id l24so521794pgk.2
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 14:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b60uezCEopvQvo36hmyWSpQLOhAgYwOufKH99W8KA34=;
        b=a1N0Qcjk5RO/Bdt2TZv/UVoUvlthAsRVKC8iVO6X0UjFS7ZoMTtAmr7jJ6sJ/02Gyk
         R051DRMIvi+KdhiLzpL1XOPVlsBWibny+xeVxNauP/cJPwTpnB/FAJ01NEK4Q9xIZT/q
         Sr4u1P/ymSqLaMQfTZiZdTngJOQ+o45E6YihiI33SD8USBAuPC6BvrTQkzk9JS1aHM35
         wXC7Hcw2mX8LEbfqMcogkS5hU+I4gSe/EtYl40sJByBq7ns36wbgw+MaBLLJ3kDYp4mU
         IbOJRM9LWucWFnEtrVHL2e7bSR5AtOdXwjHvCGyxAo7sSIPlaBVql0GL6hOdsGDu15LK
         Okkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b60uezCEopvQvo36hmyWSpQLOhAgYwOufKH99W8KA34=;
        b=AbwIFiLKPIIlCXjdyVOZaqWMSRFdVAHNmRgCpKDnIwuAk5ySIvwPDm31kts5GuOGyK
         Rfz13P6CeIXW+eh55s2Wd4acJ+36LAIMwoo7WzGon9RZ8HLXYxpC7YXNTI28wpiUWFWz
         I9ovoXl61vSXIRWsm1C+SuyD8ySYy8tk/dFpK6+FLeo06qOh1jNmIaqqQ9MTk3N4hJx1
         l2Y/yf7L+zzBnJL2PvpUSCY5FDjKmgG6Di30uOFz/VWlBwubgDxcPGdNX0mCpTsIKV3q
         ezajDhvBWVcnF8YYS3Ti4nsAbEoNmxUjn26vk4V9vZTO5x8XODf2lvVghH78/TFXXIGm
         YW4w==
X-Gm-Message-State: APjAAAUIAnZfjz6iklj/o+kR+FP57mxDGQFVjekJCIWBM1AcIJR3w1db
        QKlsBYr10nEN0gMkBM25v0Rx8uWN
X-Google-Smtp-Source: APXvYqzh0afnatYvp5UTvmVvf9vFbNqZrIAhAQwF9ADfewzYvoz6tirFO5oG1lvm6aOGNIVIlGO39w==
X-Received: by 2002:a63:a449:: with SMTP id c9mr5788709pgp.53.1575496999377;
        Wed, 04 Dec 2019 14:03:19 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id v8sm7873925pfn.76.2019.12.04.14.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 14:03:18 -0800 (PST)
Date:   Wed, 4 Dec 2019 14:03:14 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v6 2/5] t7700: consolidate code into
 test_has_duplicate_object()
Message-ID: <f3a0470edc7816bda151b0d11ddff8657b56cdfa.1575496684.git.liu.denton@gmail.com>
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
index 5fb9e99f34..80ded48088 100755
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
2.24.0.578.g4820254054

