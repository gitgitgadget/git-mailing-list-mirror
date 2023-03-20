Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEEFC6FD1C
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 20:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjCTUDQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 16:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjCTUDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 16:03:09 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A2D15572
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 13:02:48 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id k17so5990576iob.1
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 13:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1679342567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xnsltWRRFw2DqseSJzOximSHpgRGcQT4Zd+BJx5DlCE=;
        b=JWIpwQ4rCRwf4NYXUWoQBGeWseF3ZDRdMnx/+hAKy7lMb0+P2J8yF2OiN0l4Knct2p
         Y6ltvUgNTbSDSE8RjtDnj+f3FGVSaiA1wrD/YXQQ9TtgrFHmoAin4S18qcCZJwxHLpJC
         iwxcihIZR8kOFylZYCSWXZb6KSjZlls18lanaHQNWCyWEDiT9UuOvwwjq8b0gy8mlBzw
         rT+TbiBZyf/ClZrPiASBlUgxf9JBnd2QvTrEwgDw7/hgcugRSMGqCjwsv+lbq06/UQZR
         lJwCTsL847useECquK3WmJ/3wwxJRYocWqH+l58glDlNGQHBaJC0rgk2VJbng3zildXT
         rxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679342567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnsltWRRFw2DqseSJzOximSHpgRGcQT4Zd+BJx5DlCE=;
        b=Nwq0EEov7ZksBfqs0pw+biIK0ixG/BqChrxOfunf2dMv2n0lS13JfOTcKdGS7AfNtP
         QXYefzeCLu9EJ/qvgbeHpJXl7tcL8YN5aSOiYO4/aWoWIWHh8DVmrzAVaPmUdZwN5PfX
         M8xmBX51jjjNfRXN/jFIrfmBxcUAnUU5hG1iBA8+dS7KttKAbLGxceCwzf6qqFaJeBFZ
         wYN4e7bED66QXBp/KLbvbNPbI0RUDiv3X1iRNp4jpN7D1/evhoibVN0jSAT+HOcC2boE
         M8LN6xBIe7/1dus/7r+VEVJ2RH5W8KX2rAHJAPX6x6GThk4P4kBn33K6iE1ilhOXL7kK
         zNJA==
X-Gm-Message-State: AO0yUKVIXauKGOL6/imoRZWxQXHWAj53cCqSw17RxG6WK5iBTNNnAf4d
        YqaiS41Psbp7Ec2+1LoaLYT/+H5djI8CtFR2Pj4F8A==
X-Google-Smtp-Source: AK7set+mmwBviT8rS17UMeBdckp8kb0RNtTgKYtYWAahwO0fFkWSUS7tt3qBh2rifp7hJNwZmSKB5w==
X-Received: by 2002:a5d:9342:0:b0:6df:fa5a:fa05 with SMTP id i2-20020a5d9342000000b006dffa5afa05mr151689ioo.0.1679342567551;
        Mon, 20 Mar 2023 13:02:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z5-20020a027a45000000b0040535426261sm3472830jad.37.2023.03.20.13.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 13:02:47 -0700 (PDT)
Date:   Mon, 20 Mar 2023 16:02:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 3/6] pack-bitmap.c: drop unnecessary 'inline's
Message-ID: <2e3e3a7145a5851fcf5c485b38d14344c9b824d7.1679342296.git.me@ttaylorr.com>
References: <cover.1679342296.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1679342296.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Both `read_be32()` and `read_u8()` are defined as inline dating back
to b5007211b6 (pack-bitmap: do not use gcc packed attribute,
2014-11-27), though that commit does not hint at why the functions were
defined with that attribute.

However (at least with GCC 12.2.0, at the time of writing), the
resulting pack-bitmap.o contains the same instructions with or without
the inline attribute applied to these functions:

    $ make O=3 pack-bitmap.o && mv pack-bitmap.o{,.before}
    [ apply this patch ]
    $ make O=3 pack-bitmap.o && mv pack-bitmap.o{,.after}
    $ objdump -d pack-bitmap.o.before >before
    $ objdump -d pack-bitmap.o.after >after
    $ diff -u pack-bitmap.o.{before,after}
    --- before	2023-03-15 18:54:17.021580095 -0400
    +++ after	2023-03-15 18:54:21.853552218 -0400
    @@ -1,5 +1,5 @@

    -pack-bitmap.o.before:     file format elf64-x86-64
    +pack-bitmap.o.after:     file format elf64-x86-64

     Disassembly of section .text:

So defining these functions as inline is at best a noop, and at worst
confuses the reader into thinking that there is some trickier reason
that they are defined as inline when there isn't.

Since this pair of functions does not need to be inlined, let's drop
that attribute from both `read_u8()` and `read_be32()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 794aaf5b02..1d12f90ff9 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -244,14 +244,14 @@ static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
 	return stored;
 }
 
-static inline uint32_t read_be32(struct bitmap_index *bitmap_git)
+static uint32_t read_be32(struct bitmap_index *bitmap_git)
 {
 	uint32_t result = get_be32(bitmap_git->map + bitmap_git->map_pos);
 	bitmap_git->map_pos += sizeof(result);
 	return result;
 }
 
-static inline uint8_t read_u8(struct bitmap_index *bitmap_git)
+static uint8_t read_u8(struct bitmap_index *bitmap_git)
 {
 	return bitmap_git->map[bitmap_git->map_pos++];
 }
-- 
2.40.0.77.gd564125b3f

