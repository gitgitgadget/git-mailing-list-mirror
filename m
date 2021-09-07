Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F77C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C99D36109D
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347075AbhIGVTS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 17:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347095AbhIGVTN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 17:19:13 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C4CC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 14:18:07 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id b7so360572iob.4
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 14:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0jxaBzaJ0i1Rifbh6WEqYdrAqvQUpMBbIaLDN8B5rKA=;
        b=Y7j+0QoDKfVbd05S41ziLzr29gzJkdIMQMInfg/DoLrbsnfYojuhhWzlp207HRrfMH
         UIWhfJpaIuSFz7M9ZU+JXxFewCOgOhWOl8gnY5OD+RbpoeKNIe+7k5FowkV+sAccYAm3
         JumTqMlOQOtNCbd24kSDsDNBoxUu4jIIAQeeWdI6uBkULlvNbC1k/ImEjfTolJXna7+7
         a70/cJPMDi0wHuxgqwyNXGORqA0RKIpvAsnC87LYN9FJ6d1tZlEF6GvvFGpDNk/WkP4z
         WgHbsDl2Zg09KOUl8ZnbjlZYKv6oUVyfSD2IjTswl47yhYkfH3o7QIxJsLaHY2h3+i0B
         hdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0jxaBzaJ0i1Rifbh6WEqYdrAqvQUpMBbIaLDN8B5rKA=;
        b=N+MnCZ/JDqhNFiXiiBglcJLhjwTFfkowSI60vQQnKxE1ziwQUyPBLiJcjInBhXYITO
         0JiGIYnA5mfukG//5U+3JQwf8cJZFZ+hYSEupl8mfbs9m/FERfm9T6ORsyBESHXYTeDr
         sm+j0koLdBSKkSUjjZwk8cytMhep5a6DkbP2gr0/GqN79KD8JFqMA7jqY9XcyoOGLP48
         oxxFiNBLVvLBUyb0jKVKgr99/+iJTfV2ENLye19Sf8Z1H23kaDJaJaBFSGhQvlqrUNlZ
         oMyAFNpHJ36mJiighNIuDGlsIDDDjVXH1MZ2sC+8QC7WEFEmbBTTdi9hz4qfrECx4mNT
         Syvw==
X-Gm-Message-State: AOAM5303UWK0kK+CLEjfvO1h/kCdGde9SvZNXkRlagh1Vj7an4tI4eoK
        3XYFYzf9LwiNWX9H4G7wY3JrKTMrTbltKmt2
X-Google-Smtp-Source: ABdhPJwY2h3MWbbkgZlIvcBQH1J4GIS2GJ91eJVaJ7s2/UOLrYkdwi5zu9oq/B6SOUbh2KSAYgT8QA==
X-Received: by 2002:a02:cf05:: with SMTP id q5mr341976jar.132.1631049486580;
        Tue, 07 Sep 2021 14:18:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a14sm59687iol.24.2021.09.07.14.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 14:18:06 -0700 (PDT)
Date:   Tue, 7 Sep 2021 17:18:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH 4/4] t5326: test propagating hashcache values
Message-ID: <acf3ec60cb6f151a9f121d242f38fef6711cced4.1631049462.git.me@ttaylorr.com>
References: <cover.1631049462.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631049462.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we both can propagate values from the hashcache, and respect
the configuration to enable the hashcache at all, test that both of
these function correctly by hardening their behavior with a test.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5326-multi-pack-bitmaps.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 4ad7c2c969..24148ca35b 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -283,4 +283,36 @@ test_expect_success 'pack.preferBitmapTips' '
 	)
 '
 
+test_expect_success 'hash-cache values are propagated from pack bitmaps' '
+	rm -fr repo &&
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		git config pack.writeBitmapHashCache true &&
+
+		test_commit base &&
+		test_commit base2 &&
+		git repack -adb &&
+
+		test-tool bitmap dump-hashes >pack.raw &&
+		test_file_not_empty pack.raw &&
+		sort pack.raw >pack.hashes &&
+
+		test_commit new &&
+		git repack &&
+		git multi-pack-index write --bitmap &&
+
+		test-tool bitmap dump-hashes >midx.raw &&
+		sort midx.raw >midx.hashes &&
+
+		# ensure that every namehash in the pack bitmap can be found in
+		# the midx bitmap (i.e., that there are no oid-namehash pairs
+		# unique to the pack bitmap).
+		comm -23 pack.hashes midx.hashes >dropped.hashes &&
+		test_must_be_empty dropped.hashes
+	)
+'
+
 test_done
-- 
2.33.0.96.g73915697e6
