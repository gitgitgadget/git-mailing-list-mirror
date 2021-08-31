Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2F6C4320E
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 829546103A
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241212AbhHaUxv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241322AbhHaUxi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:53:38 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F24C061796
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:42 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id l10so683566ilh.8
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dXZ7G+IY/SOmjuoLnf7Th919pFizsyLyvUA/yEhVAVM=;
        b=K1385AgmSe7ICr84laxGhC5PK6d6bBFBavOWWccDBIWteLvjtfOdppaW7JXsW9TAh0
         nr5k1ZT+HMFvYgHFQxW7LofK/D+QPYWxMXKxNF4owrJebQDScLBfs6C/18YcgdJJRTUr
         pT6ng0wEosbcpzkmKmqc6zgODAjNv1Ai0bnYFGn4InEdNy7QCeD7gH/tcQ81JHzOEVen
         ey5w9r9piUrejA1nVgUWkCEliQS0ErXjsUOYJvqijPus7gWCf3+0o2OlIqGS2XIBSLq+
         s8O4dvKa6bXhWQGIX4KA6TbQBE+LtUl+mSdJJMEMHX25kBAJBjU+Fge8ok1pMyCNUzxe
         Dn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dXZ7G+IY/SOmjuoLnf7Th919pFizsyLyvUA/yEhVAVM=;
        b=Lau8RDCXH2EfE/qDQRFS6TMGEz950L5DTbnVm9559mLTEFnMMtuOoVjL3SlGgl73J+
         XGJqVKPmJDikjbJz6IIQY3MtWIsIxhAMacVJhOk4nGZH2ABVaTo7fe1rn7yEK2cENaG3
         o/XiBjpOzqB4Ov4kRKWkp4rgPko4cTNLnJQKU1b8RC3JL9gJRhFIx3B7CPK2x/G2db6i
         1SP5vVbUqnBbuTjQK1DUUC+iBER+BBvopeUN56Siyq0QsmXh55ocaoIleGv3weWI5FZQ
         2h/G/u5EHpOkfFdA13vNp9vlq3tQLLymWCpwSpIT8hVJhyCqoArrdWu2kQGf/XjPBF1M
         bP6g==
X-Gm-Message-State: AOAM531Tc96id/Ajk1atxJmRBunJ7suNZpFdzJ1SrGXZujg+3klbF+q/
        dZQ+KP5SNaaI2Tj4+z0oFJTurJy0/te2k3MC
X-Google-Smtp-Source: ABdhPJxRwgIs3VRHwzm/EcbbTIExoPlobQ97JIsU0w1fW9R0DOXKD9Kg3wz/bqjm2dy73zaAqxNTpw==
X-Received: by 2002:a92:c151:: with SMTP id b17mr21800088ilh.1.1630443162023;
        Tue, 31 Aug 2021 13:52:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s7sm9668245ioc.42.2021.08.31.13.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:52:41 -0700 (PDT)
Date:   Tue, 31 Aug 2021 16:52:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v5 24/27] t7700: update to work with MIDX bitmap test knob
Message-ID: <c49dc46fb2d123090918869cd1307f8b3f8ffd06.1630443072.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1630443072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630443072.git.me@ttaylorr.com>
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
2.33.0.96.g73915697e6

