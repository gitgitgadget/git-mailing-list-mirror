Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC7DC2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 16:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 924CB20717
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 16:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="qXT2mzdP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732936AbgKWQty (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 11:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbgKWQty (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 11:49:54 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F1EC0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 08:49:53 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id l17so4327434pgk.1
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 08:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QQ9QlvxKVZLXiGuZhW8Hed/ynfFCLLNKTD4dG14wbBo=;
        b=qXT2mzdPA/PPC+S8Mi/6a2VLo6MDHsvWCywzwhUr8jVx8n+WrkiAzj21u406kfuCiD
         qgsBzAEBwdS2M8EsMFc9c5+Su5NcelaU3xPFmvg8+ha3sgA0TyTNrx3xobfS3B1RYpJK
         PYAwvZjz2L6hZkv7lyYKpNQteaiXL+il2KOkVZ8oGoi1N5SUKSLspk1yv5uyrjDNscXN
         NmCoSrN5rRkLcD1nJ4V/o7/DOm0pLp1030kiRAl0eyNfb3IKVlDWVLDLyd92hVawNBQ8
         Zf22me1I8A9zFhqcwOJ/Zo12GDki3jpkFBVzqrV9uY2wj42QuDof4d28RwD4gZNA5aCG
         XU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QQ9QlvxKVZLXiGuZhW8Hed/ynfFCLLNKTD4dG14wbBo=;
        b=bYLSSyn6Bg5RkO1gp3ZiKFuq6VGlhZM7y3B6mZ1t8jvuVfc8qnRZSmv9mwk2IP1jhB
         zn6EhxS4u+p4eiUgmebVDp3Sf7CVAryG0l1N4n7FmSJtyQBqQ/VLpEOpzzNYU40OLrOo
         F2Jtghv8OvuG9S/ZbaSlQT9R0PxCm39bb/v5UnRKTr8U0HwoE2GRB4kzxWXqwRANMz1c
         a1KyNKMkKOCK9bgAsDbSByN68gZcO4Sg0zJXrGFEYwrGpfld6r4yvgHi08pUqkjr8+FO
         i5jVu+BoskbNrm/XaYQc0QfuVsZlwUoI3ZPJYWmoEkO/MJmBiPM1POw6k24JPgP11Sb8
         g/Vg==
X-Gm-Message-State: AOAM530/hsGM878WibhT5mljbWdl9jXXYBHMtLj8iDpXrvD7GYrG0+Ck
        W5Nd89WVkO8M0qpX/KdqtrYe7g==
X-Google-Smtp-Source: ABdhPJy82FOHmWnAw+XJPRCCQN5zhRieQ+0hpmoNS9AI35L7kds7Mig0+0kqOi4OFHekAlzKCJOXWA==
X-Received: by 2002:a17:90a:ea05:: with SMTP id w5mr681288pjy.204.1606150192829;
        Mon, 23 Nov 2020 08:49:52 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id o1sm10777435pgk.60.2020.11.23.08.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 08:49:52 -0800 (PST)
Date:   Mon, 23 Nov 2020 11:49:49 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net
Subject: Re: [PATCH 07/23] ewah: make bitmap growth less aggressive
Message-ID: <X7voLUlevHygqFg/@nand.local>
References: <cover.1605123652.git.me@ttaylorr.com>
 <c7db594fae4d0447a55a92e830475d9bc418ae7f.1605123652.git.me@ttaylorr.com>
 <xmqq7dqdqgji.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7dqdqgji.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 22, 2020 at 12:32:01PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >  - a geometric increase in existing size; we'll switch to 3/2 instead of
> >    2 here. That's less aggressive and may help avoid fragmenting memory
> >    (N + 3N/2 > 9N/4, so old chunks can be reused as we scale up).
>
> I am sure this is something obvious to bitmap folks, but where does
> 9N/4 come from (I get that the left-hand-side of the comparison is
> the memory necessary to hold both the old and the new copy while
> reallocating the words[] array)?

I thought that I was in the group of "bitmap folks", but since it's not
obvious to me either, I guess I'll have to hand in my bitmap folks
membership card ;).

Peff: where does 9N/4 come from? On a similar note: we could certainly
use ALLOC_GROW here, too, but it would change the behavior slightly (by
using alloc_nr()'s "add-16-first" behavior). Maybe we should be using
it, but I'll defer to your judgement.

> Thanks.

Thanks,
Taylor
