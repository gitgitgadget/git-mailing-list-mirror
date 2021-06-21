Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F47C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 528646124B
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhFUW2L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 18:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbhFUW2K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 18:28:10 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6188FC061760
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:55 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id b14so17664751iow.13
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P9XhA576oXjIKXlNHfQ5aXRwRaVis24OihjlRxxBAZs=;
        b=cKxZU7CbG0f7L0G7KM+nx9II/+dZ7S/RI6FYaGvCdeDUxDT6gEH3R3m+G44RTR21mV
         xm0Kjeu4R/sGKGE0ACTiDBSFYOxJhzVh+GdQxrVRHSJKvYwuqTdI2S9fbQ6clitY4pYJ
         5O6jibnCyWg+WoWhlyWQfolockCyE+IKT0mASOzOrePEV3yH+Kd/8wyZXDlItV+/Zu2n
         sB9mX6P2DNpaR8UPVOPZ3LSOmrFMUjecI/bw49mlqd/8TpwsfoL2b5aNXNxKCIXWLpz4
         Gjn4tggPnTYYjG5mvsaH04agjwrUmguKXQmuVMKSE8NTfIq+jJalG6Z9Qr3wW3+D0eGr
         aK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P9XhA576oXjIKXlNHfQ5aXRwRaVis24OihjlRxxBAZs=;
        b=EaI/CmCLyw9dd0DH9xnrLKqRC3+D3gEiUN9a5zXYbefuk5+icxV5efH/WGl0Vqr4xC
         HEEJy3UTgxJVBCDDD0LszXppssZ6G1Yw2+cMlHniMV3ZKqRjdAw3T60vEmtHcZ1e93rM
         UGwal1pkXGwgy/1uc+tXQLf2XjCb+EbmzBBSil2ASJW3/fyIG7kY1l4ckMZna5V22T9m
         yBXX6FSoW5QajBEbmxhDdmq3SNgb8IFxR4PqqLVWL6oOng8AL3tGYirUNOwAUYFHOyoZ
         RQprL0mAJjkuKE6EH7oCp0TWgJ2lHP7fAH+yvqTsEtKHAOOhUOocRCUsVYS0uCGxX4o3
         4PJw==
X-Gm-Message-State: AOAM533v1U11ksdsov+6BKcLgsv5PCVMdjdBu3bTqj4VTuIRECgcX/+z
        r+P9/1opNclqpEZdKUT39ym2qiiBceLpYWL6
X-Google-Smtp-Source: ABdhPJyhs6Ag7MPYwQARXfE4J7u3T+raYnL2/jhGdHHBwyNcxb2ju00+YW1aytqL44FpADpjQaemgw==
X-Received: by 2002:a6b:7009:: with SMTP id l9mr251987ioc.82.1624314354588;
        Mon, 21 Jun 2021 15:25:54 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:f6bb:34fc:22a7:6a3])
        by smtp.gmail.com with ESMTPSA id j18sm10636340ioo.3.2021.06.21.15.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 15:25:54 -0700 (PDT)
Date:   Mon, 21 Jun 2021 18:25:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v2 21/24] t7700: update to work with MIDX bitmap test knob
Message-ID: <839a7a79eb1fedd25948213a5d64c97e34d38a31.1624314293.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1624314293.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A number of these tests are focused only on pack-based bitmaps and need
to be updated to disable 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP' where
necessary.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t7700-repack.sh | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 25b235c063..98eda3bfeb 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -63,13 +63,14 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 
 test_expect_success 'writing bitmaps via command-line can duplicate .keep objects' '
 	# build on $oid, $packid, and .keep state from previous
-	git repack -Adbl &&
+	GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 git repack -Adbl &&
 	test_has_duplicate_object true
 '
 
 test_expect_success 'writing bitmaps via config can duplicate .keep objects' '
 	# build on $oid, $packid, and .keep state from previous
-	git -c repack.writebitmaps=true repack -Adl &&
+	GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 \
+		git -c repack.writebitmaps=true repack -Adl &&
 	test_has_duplicate_object true
 '
 
@@ -189,7 +190,9 @@ test_expect_success 'repack --keep-pack' '
 
 test_expect_success 'bitmaps are created by default in bare repos' '
 	git clone --bare .git bare.git &&
-	git -C bare.git repack -ad &&
+	rm -f bare.git/objects/pack/*.bitmap &&
+	GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 \
+		git -C bare.git repack -ad &&
 	bitmap=$(ls bare.git/objects/pack/*.bitmap) &&
 	test_path_is_file "$bitmap"
 '
@@ -200,7 +203,8 @@ test_expect_success 'incremental repack does not complain' '
 '
 
 test_expect_success 'bitmaps can be disabled on bare repos' '
-	git -c repack.writeBitmaps=false -C bare.git repack -ad &&
+	GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 \
+		git -c repack.writeBitmaps=false -C bare.git repack -ad &&
 	bitmap=$(ls bare.git/objects/pack/*.bitmap || :) &&
 	test -z "$bitmap"
 '
@@ -211,7 +215,8 @@ test_expect_success 'no bitmaps created if .keep files present' '
 	keep=${pack%.pack}.keep &&
 	test_when_finished "rm -f \"\$keep\"" &&
 	>"$keep" &&
-	git -C bare.git repack -ad 2>stderr &&
+	GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 \
+		git -C bare.git repack -ad 2>stderr &&
 	test_must_be_empty stderr &&
 	find bare.git/objects/pack/ -type f -name "*.bitmap" >actual &&
 	test_must_be_empty actual
@@ -222,7 +227,8 @@ test_expect_success 'auto-bitmaps do not complain if unavailable' '
 	blob=$(test-tool genrandom big $((1024*1024)) |
 	       git -C bare.git hash-object -w --stdin) &&
 	git -C bare.git update-ref refs/tags/big $blob &&
-	git -C bare.git repack -ad 2>stderr &&
+	GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 \
+		git -C bare.git repack -ad 2>stderr &&
 	test_must_be_empty stderr &&
 	find bare.git/objects/pack -type f -name "*.bitmap" >actual &&
 	test_must_be_empty actual
-- 
2.31.1.163.ga65ce7f831

