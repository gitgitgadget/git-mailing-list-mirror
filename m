Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CDEC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 16:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA6EB611CB
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 16:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbhIIQYd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 12:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbhIIQYb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 12:24:31 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D938C061574
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 09:23:22 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id b10so3037144ioq.9
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 09:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bc8baCofuRZeGPfcnJTiKB1cWGiYozKdmMFFpsfqVlE=;
        b=bnZGGrci7m8muLtZVIIYta7uBcqF6Q1sWdJwTU/nstcSASqA+n5mVa9GM6Aib/KbI0
         wPk3JSwPSOU5Q0AgeBDVHGyRxFmt/jaZLrh+1LVbNFihwz3QrCc++EzMFkHt5xxMLsFQ
         JWy3pF2fj2FH1/admAFExbxbKAyeI5kL+FtJRzuxaDNVUdpqDWe8t1cLiMOlZYsWrm94
         7Qt8qnz8VJ3QDPwGeNUJuI6VaEs71IDn6BvAP1ynf60oLJ8MI2Pl4mX3kD2HfhrrkAt7
         E6nOyePcat67AB/Y5DAEm3PyafElXfd9Rb9qNIlIQWd20HVXpGPineaJbnQ86xOI8vKt
         tV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bc8baCofuRZeGPfcnJTiKB1cWGiYozKdmMFFpsfqVlE=;
        b=ZgOiERDwOGz71BgP3VXeKsdZKezy4ZYe8RlMyTonuWYYZbqtJziavvOpcvBUXBwK8j
         y8ToFHWNNvc8a/EUesWupjgbGEEBx2Z11PTQqJ2xxKsfUxgI3SdfdLeDCBysxgWUf/w2
         3947DZejqgVExXM6XbgdfAE4qqRoNuqPL0NJrwwjuPV+HkngDhRzX6Grsi5gPt5r9cra
         02ak5YXIYWVIqCCQmpOVl3AghL3Audmq5dKeDQ277yEoGL7nniCATtE1dk24raCnf9ci
         dGcYFTHrsRQB2xN4GKoAB0n4dx3uMIj9J9NIDG+xFwPN1hhLoQ2P1BEGJNirUh00fzxL
         ffuQ==
X-Gm-Message-State: AOAM531TXfDZhhmzZBjCJ3WKMLSufCqoXv2Ez4ff1YZH7JPjN4WDumpK
        epx6aTeLHcqTeGioWgMLAyGeDn1qrVCpqTQz
X-Google-Smtp-Source: ABdhPJz90IAF4DkKTkxQ3DtKjvQVldP44G2U8w80RLDXTTjb5LBPdg/wXC2ghH1i4F1ntGKWClLQhQ==
X-Received: by 2002:a05:6638:2257:: with SMTP id m23mr556144jas.137.1631204601659;
        Thu, 09 Sep 2021 09:23:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b10sm1089648ils.13.2021.09.09.09.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 09:23:21 -0700 (PDT)
Date:   Thu, 9 Sep 2021 12:23:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 3/4] midx.c: respect 'pack.writeBitmapHashcache' when
 writing bitmaps
Message-ID: <YTo0+FzYjpYG7B5I@nand.local>
References: <cover.1631049462.git.me@ttaylorr.com>
 <be8f47e13c612f2fbe4d5f4f49794529b9424664.1631049462.git.me@ttaylorr.com>
 <874kavkfjg.fsf@evledraar.gmail.com>
 <YTgfuAKJv1rXXm7i@nand.local>
 <87zgsmdu6d.fsf@evledraar.gmail.com>
 <87v93adr8r.fsf@evledraar.gmail.com>
 <YTogUpdtjsFlbqYM@nand.local>
 <8735qdeoa0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8735qdeoa0.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 09, 2021 at 05:50:47PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> I may have discovered a subtle bug in the process, in
> >> cmd_multi_pack_index_repack() we end up calling write_midx_internal(),
> >> which cares about MIDX_WRITE_REV_INDEX, but only
> >> cmd_multi_pack_index_write() will set that flag, both before & after my
> >> patch. Are we using the wrong flags during repack as a result?
> >
> > Only the `write` sub-command would ever want to set that flag, since we
> > don't support writing a bitmap after `expire`. So that part seems right,
> > but perhaps there is a another problem you're seeing?
>
> In midx_repack() we'll call write_midx_internal(). That function gets
> the "flags" we pass to midx_repack() and will check
> MIDX_WRITE_REV_INDEX. I haven't checked whether we actually reach that,
> but that's what I was wondering, i.e. whether the repack routine would
> "write" when repacking, and we missed the flag option there.

I don't think it's a problem in practice. We would never have
MIDX_WRITE_REV_INDEX set when executing cmd_multi_pack_index_repack(),
(and the same is true for all other subcommands besides `write`) because
the default value for flags is just MIDX_PROGRESS (if isatty(2)), and we
only add the WRITE_REV_INDEX bit from within the write handler.

More generally, that is to say "we only support writing a bitmap from
the `write` sub-command". There is no reason that we couldn't lift this
limitation and support writing a bitmap on the resulting MIDX after
`expire` or `repack` we just haven't done so.

But I don't see any problems with not getting the right flags, etc.

Thanks,
Taylor
