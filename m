Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E50DC433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C26961007
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbhDISMg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbhDISM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:12:29 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B513C061764
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:12:16 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id d12so2685923iod.12
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P9XhA576oXjIKXlNHfQ5aXRwRaVis24OihjlRxxBAZs=;
        b=U4WQ+N1qd+HJtmsCdtzy/3mf0mquDM+3mTr32e+0bIAg0XEtCSvDcSh5Rij0iqkFPl
         IdECOnrohgJtULYUEiH6V835kZEaxQjwJ/4CJBwcbncvLgS11UpUAzz9UoHXgD/eacXc
         0Vg4btfazENKj+vGiKJFL0L6e6DK1TsBhxZeBWqJAL3p0+DkCm3wWKua5atTNuJ2iHIR
         j+Zq1cQbuMds0rNAbKTq4BSiPbRtx+oJkpjyBDSh5wEUPcylzlxBe0Py55xSjpCQu2fK
         F9w76JttRMBpI2RKTuube8S93d5ubZOBD8zpSLfNCp261so5um3DVTtQb5w0CEDY6ChN
         nVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P9XhA576oXjIKXlNHfQ5aXRwRaVis24OihjlRxxBAZs=;
        b=M0zuFxkYGdU5NBG94Uk3UwQqLXB4MVbqghZo4+M+Km6zWFREPsRliIcQhjslNtk0vQ
         oZcyiDFf7VDd4b3GMwxPG5oo5ycY3ifVayZgIC1t9A4f/UTt8n/sFeUE+Mz8t4TBeKTV
         GKzS07yQ2v5+r4+A1SygxWf1jy7Y83y3OQKVdUUckzWNe7wArXesGVk/bA0FyFr5kBop
         aNSq9C/89dKutic2Y9KY1kl6rYnlxn7Adh5st7+O2EBB5xZMOpPO8nYmSSx3lHJlJwKV
         JZAStbdBLB2Ud885XuP1GRKw+Y4kiC7NbasqJaTVAZt65bn9XjHZilEmJDY+fvkmGZn0
         077w==
X-Gm-Message-State: AOAM531qBBd4030KPGD4zZXQQN+mU5XwhRbNuDbebP+7MLsxvUxPKZ1E
        6ltpWLpidxnoDBqV77nGnWmc9AXTIbcsUhMA
X-Google-Smtp-Source: ABdhPJyKnfI3hPuCPZyva18RBeJEKCIsk7pjmXN/FC64fnqv6qoz7QoCOV+urtOl/R5mp20bdJeSEA==
X-Received: by 2002:a05:6638:22a:: with SMTP id f10mr16080798jaq.38.1617991935470;
        Fri, 09 Apr 2021 11:12:15 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:64f1:fbc0:31eb:386a])
        by smtp.gmail.com with ESMTPSA id y15sm1368212ilv.70.2021.04.09.11.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:12:15 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:12:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH 19/22] t7700: update to work with MIDX bitmap test knob
Message-ID: <ee952e43007b9fd7481ad0e51aafe241e27bd8b1.1617991824.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617991824.git.me@ttaylorr.com>
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

