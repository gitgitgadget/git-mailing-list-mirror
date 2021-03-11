Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F66C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B96964FEC
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhCKRFw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhCKRFU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 12:05:20 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAFEC061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:05:20 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id v14so19537518ilj.11
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m59jTgUtPTE+tTllhj5RaUNUSio2EyIO756R58/KdLU=;
        b=OVbKj0b8fbywmLr1ZIXmW2etGMMXcRxNuBvgacyMrW4P+l1VkbRvnu0d3lpSJ+cHhb
         sAsZIt0rySCQ9diC8zpN3+n29mzyz1xP+ExnhPf7sDwn82VzinCpIxD7KmsXO3pXumDh
         dZt74POBN8oqH9j5/uAJfCTZn8jZ3mBdz+O+Pyjb2egd9ZXMjntfxSwpQ4EGhklrNt3Z
         P/kAEqwn0H7iWEy4TVjFxyHjRI0DHOTZDWdPz4V5r5yR5LzhaB6eKtlunqj6X9/h01Xn
         OQwT3nMpZ7XEZAFtBtGMTgcDwreuBNDqDLJHZqDTfwku40J0p+akdGwDSSeqy72JJ+dq
         NqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m59jTgUtPTE+tTllhj5RaUNUSio2EyIO756R58/KdLU=;
        b=fF8Z/WGJFOcQ+QwGHv6/bnvb4WkKyT/o2Rq1JnVY2kMMIB5oV18u1jMkIQijQ/MJtr
         Fc7vP++Wv1BvCYi/APALKv9KCP6FOI3avyNr5cToJ9e4YaVPnn+VPFCJlWh3mFxV/8sG
         3WJsvx76ZhA0q10DQvJPsExa/YO53G4Dr3xVu9l/lMCqi8a8y7ThuoP/mEd7PZVsLuvl
         W+1nvq/SNbARjbaFs7XvqUTC/c89XpY2Xl/7dot8T1EdvozhN3x6fx7ZZhjmtrtBLczD
         poGvaEupIlq57GIr0+WjGWWO7KtjCg9WrRsKAnUppFYc3PsLNhIWNFWjAA7BgeCqn44U
         zJUw==
X-Gm-Message-State: AOAM533YKA+c4QYJTt5qCI4Thm/m0AaJvCIney7X/3gZ3BT/iX9addHP
        P37pfzMTv5ljHvzx0UH+4aTvLd7H6nDMdXma
X-Google-Smtp-Source: ABdhPJwt4a/WXBh+lbG+8o7BSCctXTnrwQnSryzW7IPiwgGEjHd+Y+Fezxkumi+5qENlheHUGrnALg==
X-Received: by 2002:a92:d5d2:: with SMTP id d18mr7016977ilq.50.1615482319668;
        Thu, 11 Mar 2021 09:05:19 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f947:1686:6ada:db5b])
        by smtp.gmail.com with ESMTPSA id r3sm1574197ilq.42.2021.03.11.09.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:05:19 -0800 (PST)
Date:   Thu, 11 Mar 2021 12:05:17 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com, peff@peff.net
Subject: [PATCH v3 10/16] midx: keep track of the checksum
Message-ID: <a22a1463a547e60ceba4a0abda21a1188c5002ee.1615482270.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1615482270.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

write_midx_internal() uses a hashfile to write the multi-pack index, but
discards its checksum. This makes sense, since nothing that takes place
after writing the MIDX cares about its checksum.

That is about to change in a subsequent patch, when the optional
reverse index corresponding to the MIDX will want to include the MIDX's
checksum.

Store the checksum of the MIDX in preparation for that.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index e0009d3314..31e6d3d2df 100644
--- a/midx.c
+++ b/midx.c
@@ -821,6 +821,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 			       unsigned flags)
 {
 	char *midx_name;
+	unsigned char midx_hash[GIT_MAX_RAWSZ];
 	uint32_t i;
 	struct hashfile *f = NULL;
 	struct lock_file lk;
@@ -997,7 +998,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	write_midx_header(f, get_num_chunks(cf), ctx.nr - dropped_packs);
 	write_chunkfile(cf, &ctx);
 
-	finalize_hashfile(f, NULL, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
+	finalize_hashfile(f, midx_hash, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 	free_chunkfile(cf);
 	commit_lock_file(&lk);
 
-- 
2.30.0.667.g81c0cbc6fd

