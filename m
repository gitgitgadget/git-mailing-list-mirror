Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480C7C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB076125F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhHXQR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhHXQRe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 12:17:34 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04A0C061292
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:45 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id i13so9902358ilm.4
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2mzrFOmq8LqcO2yiS8+HdtGhGLR0MAR0Eqdi1I0JImE=;
        b=y3Yfs9BB9utaOw8ZEU9JRiFckjfvxOUguTDDlU27647v/uyzzbe7njIdTbxs0TcpMo
         0WZ6Ff40NocrgGiPVu1eIn2HMlD/qMWI9iKcI2QPI8fZ+/4Afa+jIKMBTOkmeq2sBjB4
         pioBFov1vLuF5lZN1gXgfrZXwHul2YCD0SYZ1A7TvkuHe7vxR6hCVlLqu80yUSukpVoX
         tviVTN9nBOJL5CsQuZI40D+YcSIUJa4gk84D8VEb/tlaHxthQUsbg7p4zptpXe04K1NX
         kJgsPfkxzkXo9RdiMc1MIDEleEot0rRo8j6WTkNLjqDd7VtK+Gsy0E8km/T1Ivayld/7
         vgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2mzrFOmq8LqcO2yiS8+HdtGhGLR0MAR0Eqdi1I0JImE=;
        b=koS1K2QNLAtLl0dJSlZSLhU5n8297qB7Z7PsefzgY9J6dBQLvtg4zVFJzwqXz1BHc0
         fCOYHOsnukZnAfp79F3a43VU7zBKu5t1WWinQNv7jt9T0regoxKuiKZtvtVZZXXIC38K
         jYho3D6pbB8+yty5KuKriN5hnmlBmVtkclYncPhfRp82LG2Z+PUgaZdMoMP3Fm5PyfkY
         ON2ePX36SIYS7Bb7u3Y/Mu3exWzLbbWuPd5flJ3c0soumzgztbLsffEMxbC9BfFQFqO9
         hjer5wB0zwz3tbbeVTu1QrmKq+PZvl3pVrwH3uML/WBqgTTCRKQIlBWgTULVFylZ3UGl
         jnVA==
X-Gm-Message-State: AOAM533g+99KKnQFo5eqSYDFgnu/T4j0R92SjFlcOh6ANPlPgwrW/R+w
        OD1/olf2CVKZQgJAeytxuC+VXVjfKQvTv7ab
X-Google-Smtp-Source: ABdhPJxNMSfYC8h83rPFrDP9mzZYEx6Y1I2bHfn43fxv7TLYeeAxwTUrom6qjvO9aQDaghZY9ugzfA==
X-Received: by 2002:a92:c5cf:: with SMTP id s15mr26623091ilt.62.1629821805009;
        Tue, 24 Aug 2021 09:16:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c8sm10106971ilk.64.2021.08.24.09.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:16:44 -0700 (PDT)
Date:   Tue, 24 Aug 2021 12:16:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v4 21/25] t5319: don't write MIDX bitmaps in t5319
Message-ID: <47eba8ecf93e6e220ffbb98ebdb7e958db2c2d53.1629821743.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1629821743.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test is specifically about generating a midx still respecting a
pack-based bitmap file. Generating a MIDX bitmap would confuse the test.
Let's override the 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP' variable to
make sure we don't do so.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5319-multi-pack-index.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 9b184bd45e..a81375d920 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -504,7 +504,8 @@ test_expect_success 'repack preserves multi-pack-index when creating packs' '
 compare_results_with_midx "after repack"
 
 test_expect_success 'multi-pack-index and pack-bitmap' '
-	git -c repack.writeBitmaps=true repack -ad &&
+	GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 \
+		git -c repack.writeBitmaps=true repack -ad &&
 	git multi-pack-index write &&
 	git rev-list --test-bitmap HEAD
 '
-- 
2.31.1.163.ga65ce7f831

