Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7BDC433EF
	for <git@archiver.kernel.org>; Sat, 14 May 2022 13:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbiENNer (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 May 2022 09:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiENNeq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 May 2022 09:34:46 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B282251B
        for <git@vger.kernel.org>; Sat, 14 May 2022 06:34:45 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id n10so8903143qvi.5
        for <git@vger.kernel.org>; Sat, 14 May 2022 06:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5VU4B9Wx8Fh7xNXpdRhHI5VCDoWNI+WW+cmHLVOZ3aA=;
        b=IVnoDIuMaK1FwCY2hyywIS5qD5VO5ebOiZw171I+V63fxGVBZkWa4BZFZj6Z1Ph0w2
         T8bLGNnTwuAxeIRv76chQd3rbAx5vjmNG1zxk/7zd1H0XYN2o9InpZwZZuMjEhdpkz1G
         ANUWvwB7lQ+yK2fLB+tcuZFRW1TslsSVwHA6oh9M37jnFDHYCdbvo0lHCwM4/bYKTHVe
         KXEaNoN6X2KBbU2LcsF+LHgzPGluGr94hlW+Z1GtWWYQk8HGhd2L4Pbj++wqn7m0W/Va
         Kz5G5sU8JPM4tQ5cAf0cWfzCNg0gmpvPpsWwgYa8sM5L9zaBU1wAMoKtxAdDsh/8K/Q0
         q6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5VU4B9Wx8Fh7xNXpdRhHI5VCDoWNI+WW+cmHLVOZ3aA=;
        b=76/A8j5zmrYOrA7MCQ94BLZPDvgz+ZZU8E6BecITxQEvULaxVVPVsD3IFk7J1XXbjl
         fIJVK10sBg9FlNX2SllIY7l9bgOir0ln7fKWPWd+bv/JtcpJJteVTTmL3lwZ4Cbtsz64
         GjSLWzFdQ765r9ZQLZP/lezsu3a5yOlkBka2xtTVG28oPgAwesuHTFKHiKHhcnRcpDN8
         ffMb8fUcY/ch2gj/slzeckFq+tK59lEeEfz/0KFMvRvqH/soYBsCdShZgGrI/eY9h4RZ
         FpsUkSFlmDDXuozPdULiTL3p4N8HjdG5D6qLOhnp/7nGQabe7ei14ihkn2qdvtl5QiI1
         8yaA==
X-Gm-Message-State: AOAM530kBaBswEnEsvRh7jqYeB1o6C4hpFK6EUnkmZZWTBJYboERLW7s
        L9P9Pa7wELI0DBfs11nTKiGqow==
X-Google-Smtp-Source: ABdhPJwpjxl0wRHNST+WAZzgQ6VlW7cw/l+KP4snQ9XmhF5V6rJuWRJYmWzjil+GNQAbYfm6Kk8m0A==
X-Received: by 2002:a05:6214:1cc3:b0:456:56d:f2c5 with SMTP id g3-20020a0562141cc300b00456056df2c5mr8495570qvd.119.1652535284175;
        Sat, 14 May 2022 06:34:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 84-20020a370957000000b0069fc13ce211sm2736959qkj.66.2022.05.14.06.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 06:34:43 -0700 (PDT)
Date:   Sat, 14 May 2022 09:34:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, vdye@github.com, gitster@pobox.com
Subject: Re: [PATCH 2/2] builtin/pack-objects.c: ensure pack validity from
 MIDX bitmap objects
Message-ID: <Yn+v8mEHm2sfo4sn@nand.local>
References: <bcc48004450769410d7e6d8a6e56f08bfa9a02a3.1652458395.git.me@ttaylorr.com>
 <20220513230639.1099955-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220513230639.1099955-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 13, 2022 at 04:06:39PM -0700, Jonathan Tan wrote:
> (An alternative to the change in this patch may be to reset *found_pack
> to NULL when it is found that the pack is invalid, but I haven't
> investigated all the callers to see if they can tolerate *found_pack
> moving changing non-NULL to NULL, so the change in this patch is
> probably more practical.)

I haven't either, but I think that this points out a flaw in the patch I
originally posted.

Consider this:

  - `want_object_in_pack()` calls `want_found_object()` with a pack that
    has gone away and has zero open fds, and `want_found_object()`
    returns -1
  - `want_object_in_pack()` continues and calls
    `want_object_in_pack_one()` later on, with some pack that is the
    same as `*found_pack`
  - `want_object_in_pack_one()` then _doesn't_ call `is_pack_valid()`
    (since `p == *found_pack`), leaving us in the same situation as
    before.

I think that would be sufficient to hit this race even after this patch.

I'll take a look to see if `want_object_in_pack()` callers can handle
`*found_pack` being set back to NULL. They should be able to, but I want
to do a little more careful analysis to be sure.

Thanks for pointing this out, I am so glad for your review! :-)

Thanks,
Taylor
