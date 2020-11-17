Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A850EC2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63AE4241A7
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="jErih8+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgKQVqt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbgKQVqt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:46:49 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9459C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:46:47 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id u4so22344484qkk.10
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JtHKqRC+mJFp8b40zjnzmvm8xtAum+EmraJL4uzwst0=;
        b=jErih8+TIfvG4xvDTWIZO2JDJl2trrVXjm88991M+982/C+HuWRqf1Yhc9Xcf+jO7E
         dqVoJqQUKzSCaTvIPqicyxiJY5zzZDgQ539UyFRgIbqCo6t+x/NgSVxce9C8qpB2cCD5
         +24ORzJOZx6yP8PcXsiyYxsV3Dwvf7VmBYO5tjSP3zvZpqBBF36xc8Ilm6YrS0NPf8oQ
         IEtDJrbxyAhyujhmDapFWjL12KUIlPjtzPqugUgKeF2WK6B4M5spwHUZpknXVniCefE5
         2lf2vHpoiNGzoYjAUDJp4oz+vUquJcgak20OVJw6s7WCj3yR1fvvbPomeSc4BVNYcjtc
         7daQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JtHKqRC+mJFp8b40zjnzmvm8xtAum+EmraJL4uzwst0=;
        b=n20bDkuO9FjJmnxSUS2cLEnL/zTdly1eexHT42tn3A7qcju1zZVh0fde8gheNSgobz
         UmYoaW6Cw2k7Lecp7n0Vq+23B2cSqipYPN3RnvgRLlkXuJTK2F3DbE6fBjEScGFHcN1P
         +OV9X84fR5TPqt4PdPsaJtR4EjWdDYNE9edT84ZyXn4B69y8HBJTbrpOSNdkOEHdfCkJ
         9c3VWLzELlN6aE1toYiJ/YJNS5NqUYdyuSPJ5MIo1X8TPqnD684s1kgGvY+ObfHFJDmg
         nXnYkUoypC4lVmmPv4LkwANH07GDOY4YKoFRx2P97XM5OroLQ7ILPJdlV0coWF0oDaY7
         HctA==
X-Gm-Message-State: AOAM532O2ljSiFZxe++ByV48nNiYRpi3UxvenyFTFX7DWacBVjSqjFg4
        8aMstoyRdly0Esvz2qIbE1TdTS4JxmHWbI4A
X-Google-Smtp-Source: ABdhPJy1DQmUB5hvbOP+xlyuEeatVbs1zf+PkKrJv3UbHcCwc6SmoJvQccBZqQEoFGszCKxlcZ3J0g==
X-Received: by 2002:ae9:e919:: with SMTP id x25mr1808698qkf.50.1605649606718;
        Tue, 17 Nov 2020 13:46:46 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7fe5:c4d6:f587:dc1f])
        by smtp.gmail.com with ESMTPSA id q32sm10615354qtb.71.2020.11.17.13.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:46:46 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:46:44 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v2 04/24] t5310: drop size of truncated ewah bitmap
Message-ID: <f779e76f82bd2684e835affa45583063772d1c1b.1605649533.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1605649533.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605649533.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We truncate the .bitmap file to 512 bytes and expect to run into
problems reading an individual ewah file. But this length is somewhat
arbitrary, and just happened to work when the test was added in
9d2e330b17 (ewah_read_mmap: bounds-check mmap reads, 2018-06-14).

An upcoming commit will change the size of the history we create in the
test repo, which will cause this test to fail. We can future-proof it a
bit more by reducing the size of the truncated bitmap file.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5310-pack-bitmaps.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index e2c3907a68..70a4fc4843 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -349,7 +349,7 @@ test_expect_success 'truncated bitmap fails gracefully (ewah)' '
 	git rev-list --use-bitmap-index --count --all >expect &&
 	bitmap=$(ls .git/objects/pack/*.bitmap) &&
 	test_when_finished "rm -f $bitmap" &&
-	test_copy_bytes 512 <$bitmap >$bitmap.tmp &&
+	test_copy_bytes 256 <$bitmap >$bitmap.tmp &&
 	mv -f $bitmap.tmp $bitmap &&
 	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
 	test_cmp expect actual &&
-- 
2.29.2.312.gabc4d358d8

