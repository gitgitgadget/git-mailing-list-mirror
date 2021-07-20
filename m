Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42095C636CA
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 21:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E11A61106
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 21:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbhGTUbB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 16:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbhGTUZU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 16:25:20 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A51C0613DE
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 14:05:44 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id s5so519307ild.5
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 14:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uco8gkGZZaGn4BVb1pbwImdhDA1Iv6++DAr3k5301pc=;
        b=Ex1z/z2idChnkb3xVWK0X7pOVGFRKgqBtQY4u6B92AxbvRJQD94FJh6GdtLdVR4+Jk
         3glWeH+27ryqSMsMEHS4aWSxOHHdAzLLop5rmh/yVbLfnnkG+ZV6hBaoYLb1Vf82mqMu
         mfiKuqWAVu/1HHfQEM1Q6ksXhiw6Lqy3QwWhaAxOe/kHZ29VfF0tA/Bht2blP1XXvaKP
         AZF4P3o27SpjnoXNWV7SqPBAZmtzdxZfJphHKhqwjtdQ7GdAYJYJO3MCXN5ieswtzSHX
         XTrzZyWzgic7gH8P0P+H63RAAJAv3lYcsOwtXtdNTdVOSUEVHEmTBK0+v6CBt3zDH6s4
         Zj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uco8gkGZZaGn4BVb1pbwImdhDA1Iv6++DAr3k5301pc=;
        b=p2BUtQtaJrvvGyrhWfanxtLb3YtwZvYwSJyWoJfy7MnNjwIhCkEOfoEbnd0BSwSZaZ
         dZN7mJ79QkEuurM48H6cnBFH+LVW0VYLc6xnBzPeYAU8fF6Qo4R2lcgujC8RZplGpMSM
         p7YXd4uI9WdOG2wGtYMKOTpgbo3h00pYyGtUJuV10ylDaJFwIKBhOA9y82WN5wcSi1j+
         94wVkduJ/hlxpk9AWKDBBpPSKe/yPqeqR2j4L0C0DaG3V/ILTv4pf2Z94NBuCwa9ta6B
         tlNCNfurDZqbxim+zyPnv0tpnmauYwtEuhpbaxjWn9NOf2YLSEKeuDc3ALN8yg+Af86R
         Zg2Q==
X-Gm-Message-State: AOAM531NytK9bgRIYh7hJmEnbgdPLwncrbv35abNnCjY3e12Ml+eyyXs
        R/3ch/gZCYkaNbGEQce3Bc5mQg==
X-Google-Smtp-Source: ABdhPJyK2drOTXv6iu8rEDxvRYUD5xUvvjXtPEJ4kQwou5tsKiDWeVC5v0NhYAJjA8730pQ3WK6v3Q==
X-Received: by 2002:a92:c10c:: with SMTP id p12mr21165585ile.92.1626815144041;
        Tue, 20 Jul 2021 14:05:44 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:9f71:89c7:e095:b8eb])
        by smtp.gmail.com with ESMTPSA id h8sm2593609iov.1.2021.07.20.14.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 14:05:43 -0700 (PDT)
Date:   Tue, 20 Jul 2021 17:05:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jonathantanmy@google.com
Subject: Re: [PATCH] pack-bitmap: clarify comment in
 filter_bitmap_exclude_type()
Message-ID: <YPc6p1lxX2AUggEu@nand.local>
References: <0d52628985bf4f499e0d5622ea40cdf499e73ebe.1626812121.git.me@ttaylorr.com>
 <YPc54AdUqD6T31ad@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPc54AdUqD6T31ad@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 20, 2021 at 05:02:24PM -0400, Jeff King wrote:
> Yep, this looks good. I wrote a near-identical patch while working on
> [1], but that topic got stalled on "how is this part of partial clones
> even supposed to work?". But there's no reason not to make this trivial
> fix in isolation.

I'm not sure exactly which thread [1] is referring to, but I do recall
the discussion now that you mention it.

I'm happy to add an "Original-patch-by" trailer or similar, although I
suspect that you do not care ;).

Thanks,
Taylor
