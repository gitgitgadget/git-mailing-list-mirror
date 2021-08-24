Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE30C432BE
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82ADF6125F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhHXQSN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhHXQRh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 12:17:37 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170EBC0612A4
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:48 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id g9so27066118ioq.11
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P9XhA576oXjIKXlNHfQ5aXRwRaVis24OihjlRxxBAZs=;
        b=whWa2weoXqE7kxD7y9U6XutT3EXx4jE+YrcUfb4AMQL2Yf8tadgJCV0+hvp6YE5Jrg
         GxUVuzd3XxhaQGCI/m313OM8CD4sE8HGwXUbqyQ16XOEOmobVDR5aCtd+YRUhM32fZ6C
         TECUt0YHlEFsx7PdJ8iC9gF1bTwmbdNVmAV26WC9VIKxUA93FF9d1uDeh5Zm57xMvtKC
         9qOSume3aDhnGwUWFms/XJdqZaE+uM/qLtIq4jLMzwVIPeJDFZwJuEYt8uQPncqeysur
         WG85jLcvm/sYtJrWmrT4hEWutb/+tt56b2sUTLq6TTrAKmeV//PsOYDwbV2zdtdsg+lT
         eEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P9XhA576oXjIKXlNHfQ5aXRwRaVis24OihjlRxxBAZs=;
        b=HXVBpE15w00Q5prYWRQ6n+z5CVd55Jm+zV+pwCIHI6zmuHl9tlJrOKk42p/4za+vx8
         hy2wozNm5/xa82r8EhZCFilzNYZ/pca0qoE+VyNkbbBVY+9DkrulswQJ5gwuOvOKQ2hN
         Tx6E2fQG9Yxp+XMW1DzX61eV+vtCWqLlP3svokHzdLwlEhg0vRLrkkoipWY+GaKUMT8S
         4x6dGNS+LNz5t27Edn945P6qwlbF3jnxO6QOeLoZtobSwkBMbNK+Sc9C2xjTvS3tHjdz
         kKNU3O21X++qC+2ruqpfpOBt7MFKKMnAiu+W+uY3t98TezGQD/hbHVaAg+PhvUHGHJAI
         NLWA==
X-Gm-Message-State: AOAM533ELg4HfhfNfDa6wcib16plHH3nyR/e/J7uOKc2AnqiUcZ7Mx6h
        g5N3FTsnHBq4EydshNk942OdDHKnZD2Hq3I1
X-Google-Smtp-Source: ABdhPJy8Rim6MoOFCx0BYba/PASqdstE4+h3akB367Ak9UGN3qs+JpfPI/JrYYzaOEid5OokavQW/Q==
X-Received: by 2002:a02:3b1b:: with SMTP id c27mr5473452jaa.103.1629821807389;
        Tue, 24 Aug 2021 09:16:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b18sm10300400iln.8.2021.08.24.09.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:16:47 -0700 (PDT)
Date:   Tue, 24 Aug 2021 12:16:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v4 22/25] t7700: update to work with MIDX bitmap test knob
Message-ID: <3d78afa2ad35b96886af78a295f1fecc3d7e6170.1629821743.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1629821743.git.me@ttaylorr.com>
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

