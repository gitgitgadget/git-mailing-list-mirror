Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA5FC433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1055F60E05
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239399AbhJZVGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 17:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239396AbhJZVGe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 17:06:34 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6657FC061570
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 14:04:07 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id d63so1039035iof.4
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 14:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3cKhC+xQ/hD03InkvuGCmSNPwJUa3aT1kRUo08FS+8U=;
        b=Rg42q8eLEj4jHk+MEcandOZ7vBNFssWMtImli8q6rg7L/ac1GS6Njghn4HQLcmGnjA
         Syy+Y2jLdCiwD+qrekfInKbb/ICbyG3GPl5d4f12S1z6q4l56j/nKL1hLqFRrf1ZHuH/
         H9gNhBWQaoK4EOCFt1KQfvCd5qqM7WJjLsPw6018+JSbH9/txr2ltLxJGylBUdZ9k9mA
         eWzfZ8Fios3iOLAqq31AgwPoHLJXXM0e2tNCSVbLxOM7twb8701ENjQWz53+5g6olpGi
         NXlSwqdOvkZX83KFqHQqeodEUoA5nkaFbUisAz29yCBmBXRlFUH6LWrb12IL+bbs62ys
         GDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3cKhC+xQ/hD03InkvuGCmSNPwJUa3aT1kRUo08FS+8U=;
        b=OaTM4hqyIQfmIVl6uwmfPBtDSfAQctrv1wAoFuCydSEdOm0WaTcRjW1dTKzS+nQMn1
         dQIx2xZOF8YjQ6rq3nyVyodNO7bO46wQnd9vCARJ3Ymg/cZnlHeYEz4/udKtI73AuidJ
         j794eJCgnwQ4pCosIWcIUtiqLYs3nENdFq2wnX679UA9Uv3PLRm0OKgrq9HwHbSt6GF2
         1Ukg3lyO0zTIW6njYshpo7reiWUneqUf+ZxwbEt8FJrvt92ac8m+/qczAujY4LaoPsvq
         GdSmPF+L9I3wXRykUMl8mmC7JvcsYxVatVJKbWSgMMjc8ByKAcZg0Kw6/2pNy0tfwDmx
         xEbw==
X-Gm-Message-State: AOAM532KOR9OF8R31DvbztVe009+6hB4PUVTNgflzyjHFThev5ogSXUA
        11/G+VXRwu6CIKqF8IPjD1IiSA==
X-Google-Smtp-Source: ABdhPJzaEAWG2nV8fTPjUjKv53K1Gd1cXYwJBNz2icHM7N4Y7FtZgdiwdnvMW7DOr/ZPaHGd6G5F0g==
X-Received: by 2002:a05:6602:20c3:: with SMTP id 3mr1835152ioz.145.1635282246861;
        Tue, 26 Oct 2021 14:04:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w11sm10422811ior.40.2021.10.26.14.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 14:04:06 -0700 (PDT)
Date:   Tue, 26 Oct 2021 17:04:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: tb/plug-pack-bitmap-leaks (was: What's cooking in git.git (Oct
 2021, #06; Mon, 25))
Message-ID: <YXhtRWDVzuWbQg+l@nand.local>
References: <xmqq5ytkzbt7.fsf@gitster.g>
 <211026.86tuh4yoa8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211026.86tuh4yoa8.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 26, 2021 at 02:13:44PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Mon, Oct 25 2021, Junio C Hamano wrote:
>
> > * tb/plug-pack-bitmap-leaks (2021-10-21) 9 commits
> >  - pack-bitmap.c: more aggressively free in free_bitmap_index()
> >  - pack-bitmap.c: don't leak type-level bitmaps
> >  - pack-bitmap.c: avoid leaking via midx_bitmap_filename()
> >  - builtin/multi-pack-index.c: don't leak concatenated options
> >  - builtin/repack.c: avoid leaking child arguments
> >  - builtin/pack-objects.c: don't leak memory via arguments
> >  - t/helper/test-read-midx.c: free MIDX within read_midx_file()
> >  - midx.c: don't leak MIDX from verify_midx_file
> >  - midx.c: clean up chunkfile after reading the MIDX
> >
> >  Leakfix.
> >
> >  Will merge to 'next'?
>
> These patches all look good to me.
>
> I see you peeled off 10/11 and 11/11 from Taylor's submitted
> patches. The 10/11 re-submitted a patch that's in my
> ab/only-single-progress-at-once, and I really preferred 11/11 not going
> in, and instead suggested [1].
>
> But since you've peeled off those two (I wouldn't have 10/11 at all) I
> think this is definitely ready for 'next'.
>
> 1. https://lore.kernel.org/git/patch-1.1-9190f3c128f-20211022T102725Z-avarab@gmail.com/

I sent a small updated version to fix a couple of things that I noticed
during review here:

    https://lore.kernel.org/git/cover.1635282024.git.me@ttaylorr.com/T/#t

Using either version is fine, of course, but the one above may be a
little nicer. (Apologies for the out-of-thread v2, I only noticed that I
hadn't set `--in-reply-to` until after I had sent out the cover letter).

Thanks,
Taylor
