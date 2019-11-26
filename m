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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42522C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C26B2068F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Up4lfGNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfKZBSp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:18:45 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44456 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfKZBSo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:18:44 -0500
Received: by mail-pl1-f195.google.com with SMTP id az9so7329593plb.11
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 17:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FTtG2eg54HJ8MNXH5T8m8riTIBnJQi+iLgrelc3/uXs=;
        b=Up4lfGNtOlRof18NRcESa/fbxA2fbcTUHycA54jUWEFS3uQ2+mFVFgdsyqPo1q1RHh
         oIRSHKF4ftLB4lNJxtlcr/DrDO6i6x56wpk+jtnp3DYwM8UMuFfM2nwYHoreS8HvL/tG
         JDY2n9ec2l6udePhZZ0LpRyICQvZ9JHV9xs2L6dYn44R3O0Wd1xLUtbS6e3xR3hBcLxL
         S4lyfMriC8O6CJCBgrYqhMZysQQ7FbR7vYm1SwxDtZ7h5FsisU6Z4hZftPHtpi0akrhV
         v+5GyitbB3otuZqCbXYQm3doZw72zKYg4cgsp4kkKIlbe4xkF122qkx4QPDm7ZZpJ3d2
         YWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FTtG2eg54HJ8MNXH5T8m8riTIBnJQi+iLgrelc3/uXs=;
        b=TQTIYeS79ISeuR6j2Ek1gn+VCnKvDkf11IGCu1hCNFL1u/XfKoiIYDsJjRA8Iyrf1P
         fxbU57tq9KVWRjNWgj82arphupXDaWKS6hDN9sc/E+UObjClOZ61DmN/u8PPI9hu3swS
         ZszvY22C84luZ2esEijFngympfOV8LLOLKYrHBewQf8oDLmcJxTkyz1U2CkmYyRLYTte
         1qYtHQebL/WGKdibtuc4YZ16W2gzw7LYTNjRImu3uKlJL6X3OjZoz1O7ft3NAKHGxIzJ
         ozBKg+WSTA95QudBLJe7HfH8pM3PZTbgdyupVqd9RCJQ7rZBhVdTu4OE4h+XBlo/86TQ
         yBAA==
X-Gm-Message-State: APjAAAW8sbNxBMPcQioQ8POQm6ySUqc9aCUXqSOs5lNfHUQT/nYcWqXN
        cRFU9bOTmmiirA2OwUiJSz3OHf1P
X-Google-Smtp-Source: APXvYqwWGDXH6dHxkOi+xWzCUODGFSYqPraorb8UMIAHkZVDY0gX8WZX4U7BirrA0kJITnyfkvgRSw==
X-Received: by 2002:a17:90a:fa96:: with SMTP id cu22mr2764165pjb.121.1574731123751;
        Mon, 25 Nov 2019 17:18:43 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id h185sm9878304pgc.87.2019.11.25.17.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 17:18:43 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:18:41 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 24/27] t7700: consolidate code into
 test_has_duplicate_object()
Message-ID: <fa38d7e8f667e9d0773aa8b846a94a747097c394.1574731022.git.liu.denton@gmail.com>
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

