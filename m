Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637B5C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 16:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41B496105A
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 16:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbhIHQd0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 12:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhIHQdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 12:33:25 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6DBC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 09:32:17 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 192-20020a1c04c9000000b002f7a4ab0a49so1579748wme.0
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 09:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jHYb27Qnvc2im57MC6/ZcgYc4Q3jEXdo80GrokRoQRo=;
        b=yk8bsX3+BeJ/6fpYd0HfCeH7rEJ9wpA4TK6fUxfs/SJNmtk9p/LdqP/eZLPOzuuP39
         Lzv9aoliQWAtui0tpM6NGQsXV7YWhz56S8SqtSefPfs/tc0tiiixK1nLffu+Ht8aQ8O1
         QbRDfU/kkP3CTomshVFj3dPXP3IaQVjCSJdFhrU78DPsnFwbtJS8Jr3lyXIRgfWDQBhZ
         kKDTEDAurJK4T2+4IceMAPs7y5wTRJ7zLQZhMKXAPeVpVR3BkSXduS2lZeygOVypwSik
         X7zbBhSC7oFCl6qn6vr34puBnsbkB2BF0mvGNFM+qEuohMm+6GL6UnihKr+WbjevEECa
         UrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jHYb27Qnvc2im57MC6/ZcgYc4Q3jEXdo80GrokRoQRo=;
        b=Cdx0TiCMdVnZFjJ4bGv/zuNT+lR87h739VpdXFXrzRatTJv1qvknA55J2EoSPzHrfc
         tlhGQdMzUDkdDKFJaaU3i/vqM8ubxacvEqThJm1hZXaYFU+7+vTwumNfU0rrmaA24Rkq
         wvRMwollMZl/UYGZoeLaRcSqfvKhBGQ0wwFRBnSjKaPtHL2dcdeIzLrYWrtwS+dOhMSS
         EegkCUbLGGiG/UvXgXL517pXwquSI4Yv6fW+tPTzuT76QlOXSO8abphVbvQKoGoDaZNP
         tUiZ/P0vOVJcGe55KvEh/xuXVf6pnM88XVsemsWgeW4C/yTdcL/ud1drr4MUYRdgamfl
         5FSQ==
X-Gm-Message-State: AOAM5333Jvtu//yRClV0WkcrcTLfwtQrvHXmLKn1/9ZaAaOMXeXCtBCq
        5IzWP0/I8tEAja02o1pAxREGXw==
X-Google-Smtp-Source: ABdhPJxAt4QzzUOmPMSpSMavM/EgJfaD/aAa2X8AkpVIrHm9bGxA+ABYftCi+edI6H66OGBuO62yxA==
X-Received: by 2002:a7b:c408:: with SMTP id k8mr4390282wmi.184.1631118736037;
        Wed, 08 Sep 2021 09:32:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u25sm2548523wmj.10.2021.09.08.09.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 09:32:15 -0700 (PDT)
Date:   Wed, 8 Sep 2021 12:32:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] pack-write: skip *.rev work when not writing *.rev
Message-ID: <YTjljc0kU2WhmTzU@nand.local>
References: <9f40019eb3d3315cb03440e6237bced4feb6cf67.1617116623.git.me@ttaylorr.com>
 <patch-1.1-366ba928bd-20210908T010743Z-avarab@gmail.com>
 <YTglEreI7nFCII/b@nand.local>
 <YTgy85aiCL1bJjKE@nand.local>
 <87r1dziczs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r1dziczs.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 08, 2021 at 12:18:38PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Tue, Sep 07 2021, Taylor Blau wrote:
>
> > On Tue, Sep 07, 2021 at 10:50:58PM -0400, Taylor Blau wrote:
> >> Of the two, I think the former is more appealing (since no other
> >> functions called by finish_tmp_packfile() are guarded like that; they
> >> conditionally behave as noops depending on `flags`).
> >
> > Sorry; this is nonsensical. The only other function we call is
> > write_idx_file() which merely changes its behavior based on flags, but
> > it never behaves as a noop.
> >
> > That doesn't change my thinking about preferring the former of my two
> > suggestions, but just wanted to correct my error.
>
> I agree that this code is very confusing overall, but would prefer to
> wait on refactoring further until the two topics in flight (this and the
> other pack-write topic) settle.

I'm fine to wait on any further refactorings. And I agree that this code
is confusing, since when I read it last night I thought that the check
in write_rev_file_order() was a duplicate of the one you introduced, but
it is not:

    if ((flags & WRITE_REV) && (flags & WRITE_REV_VERIFY))
      die(_("cannot both write and verify reverse index"));

and that check is different than the one you added, which I think is
appropriate.

So this patch looks good to me, and sorry for the confusion.

Thanks,
Taylor
