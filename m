Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFD0C001E0
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 20:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjGaUSS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 16:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGaUSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 16:18:16 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F0B133
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 13:18:15 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-56c87f89178so1665645eaf.1
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 13:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690834695; x=1691439495;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mY9/4PTiP8egwbM9TI8d50PcGBcDQVoe8Oj8Qk1aVF4=;
        b=JiFxG8ctPxfcSTpI/QzKGRdW4Jmx70l38/7aO/W+FmKYYKmwqRrBLeiES83O9EZvY3
         AFPEuXyVLvmZ2eeSoHlwrh8u226TENyH4rK9Idesjug7pRIrYL3KBluPZJPGme4dFJe9
         Ih/tJgzrLRwWjbtZLJqJny08/NwgxBqARE42NJIJQ2XfcwpDw+CoPVbEmt2wgU9xzBZb
         ldti02jwj7sDAyAX0xb+B6U6PQqcfZv4q1AntJ3cJasKoR+YyhSbEne9h/hsMunfL8H8
         3d0cY0JRQ7bhXNL9vb2fZDyh7Hw6lXXQ48IGD/NJ0oH9BviVlv9q8cozcihP7lUzVRAE
         YpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690834695; x=1691439495;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mY9/4PTiP8egwbM9TI8d50PcGBcDQVoe8Oj8Qk1aVF4=;
        b=Z6ec5sej23tGkSFX9Igpr9tlCNi7T8D7B3dBhvXXkUG6xpebxRd3+uv6i+6M8ElP8c
         2excY7fkKhkweQVXHNupSj16VmmQgB2Oxr3Gm+CJDk7kpacq1oq9MaxV71YakI0sToML
         pBx0HSLnY0leToLQWjwuABeNGpqqzGLUyL6RsCu9W6e625Begc1grasQFWOGOvk6tQLE
         gvRJIyKiun8X2gozae4rgwGEDIBsD0XJch1urWmvcG0IfprT/kUVnmXwA2gF4/Lv+Kiu
         FBrg5hlHplJv5o7hmM1k2GmcjeZpbAyEf/5B3ixhNwcP8woK7C2t8yvt5Orw55vwztJo
         IUOw==
X-Gm-Message-State: ABy/qLaaFZ5ndTbfraMnirl55RS76/eTlQWq8knHSlpeEyzDSBzwS8vE
        LtSR3zbuYGpozY02TRnTsfWp3g==
X-Google-Smtp-Source: APBJJlEJm5wtA7n1DMQZZtAAzWcKnhMS71zjCVH9wKd1pHK/LzlYDjb+TvVOcWpmF5KZjf4E0xmx8w==
X-Received: by 2002:a05:6358:7215:b0:134:c37f:4b5c with SMTP id h21-20020a056358721500b00134c37f4b5cmr1199666rwa.22.1690834695007;
        Mon, 31 Jul 2023 13:18:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h2-20020a81b402000000b005707d7686ddsm3200518ywi.76.2023.07.31.13.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 13:18:14 -0700 (PDT)
Date:   Mon, 31 Jul 2023 16:18:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git@vger.kernel.org
Subject: Re: What is the status of GSoC 2022 work on making Git use roaring
 bitmaps?
Message-ID: <ZMgXBc5idN+sR3o1@nand.local>
References: <858rfnb770.fsf@gmail.com>
 <ZBy18EBE7WM/E4KF@nand.local>
 <851qlfazzp.fsf@gmail.com>
 <CAPOJW5x+yQsPxdwCWMT9AkMQhJyxKp5BiPXp_1PT6WwF7yF4YQ@mail.gmail.com>
 <85tty8afvy.fsf@gmail.com>
 <CAFQ2z_P2HkT8grAFk=6Mr05rJRfsh_sXypVFPyHr0v5xkcjYTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFQ2z_P2HkT8grAFk=6Mr05rJRfsh_sXypVFPyHr0v5xkcjYTA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 31, 2023 at 07:46:18PM +0200, Han-Wen Nienhuys wrote:
> On Sat, Mar 25, 2023 at 6:40 PM Jakub Narębski <jnareb@gmail.com> wrote:
> > >>> Abhradeep promised[1] that he'd include some performance work in his
> > >>> next version of that series. I think the main things we'd be interested
> > >>> in are:
> > >>>
> > >>>   - Does using Roaring provide a file-size advantage over
> > >>>     EWAH-compressed bitmaps?
>
> I modified JGit to write Roaring bitmaps instead of EWAH bitmaps. The
> resulting difference in file sizes are small, and actually favor EWAH:
>
> $ ls -l {ewah-repos,roaring-repos}/*.git/objects/pack/*.bitmap
> -r--r----- 1 hanwen primarygroup 26257386 Jul 31 15:04
> ewah-repos/android-pfb.git/objects/pack/pack-b14c35ec7fc3bb20884abe51a81c832be5983fdc.bitmap
> -r--r----- 1 hanwen primarygroup 27621579 Jul 31 15:20
> roaring-repos/android-pfb.git/objects/pack/pack-b14c35ec7fc3bb20884abe51a81c832be5983fdc.bitmap
>
> -r--r----- 1 hanwen primarygroup  1037356 Jul 31 14:46
> ewah-repos/gerrit.git/objects/pack/pack-fe46c7f96a2910f5775a2ff3bef7e4fa0e779f91.bitmap
> -r--r----- 1 hanwen primarygroup  1242608 Jul 31 14:45
> roaring-repos/gerrit.git/objects/pack/pack-fe46c7f96a2910f5775a2ff3bef7e4fa0e779f91.bitmap

This was one of my hopes with Roaring+Run, too, but I think that it's a
non-starter with our current object ordering for reachability bitmaps.

I did the same experiment a few months ago in my fork of git.git, and
consistently was able to produce smaller bitmaps when EWAH compressed as
compared to Roaring+Run. I think the reason is that our bitmaps are
pretty sparse, and so often have a lot of 0's, interspersed with a few
1's.

Depending on container alignment, a single 1's bit surrounded by zeros
will often get encoded as a length 0 "run" container. This means that
instead of storing that information in a single bit like we would with
EWAH, we use two 16-bit unsigned values to store (a) the position[^1],
and (b) length of the run.

The length is entirely wasted space, since the bytes are zeros, and
storing the position is significantly less efficient than storing a
sparse bit position in EWAH.

I haven't proved conclusively one way or the other where Roaring+Run is
significantly faster than EWAH or vice-versa. There are some cases where
the former is a clear winner, and other cases where it's the latter.

In any event, my extremely WIP patches to make this mostly work are
available here:

  https://github.com/ttaylorr/git/compare/tb/roaring-bitmaps

One thing that I was able to do to produce slightly smaller Roaring+Run
encoded .bitmap files is to store some of the bitmaps as XORs against
earlier bitmaps, similar to what we do with EWAH. Often XORing the raw
bits, and then compressing that with Roaring+Run can be significantly
smaller than storing another full Roaring+Run bitset.

That's the only part that I've had trouble getting to make it
consistently work, and I haven't had time to get back to it, so it's
been collecting dust since the end of May.

Thanks,
Taylor

[^1]: Not the bit position, exactly, but rather the 16 least-significant
  bits of the bit position, since all values in the same container share
  the 16 most-significant bits being a multiple of 2^16.
