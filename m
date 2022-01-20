Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57601C433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 22:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378027AbiATWLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 17:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378018AbiATWLw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 17:11:52 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA07C061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 14:11:52 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id h23so8627760iol.11
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 14:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yVLX37F2SHE9pdsMDuRoC7Ej8BDm/LIWpbduFLqwqRo=;
        b=7RcRiDE3YHasnWuaekFc8FomZCtnicMyuLj2b8XkuemawDV5NGWkVI/VFpWT6n9A1L
         x2mdXNMbqZ4dVNbu6n9etuIOKOzoVmvmd2lUHJWOtGBavuK0rN7Ldarc5RWO2PxKVq1O
         NMRajQ6KGfJd81eZGNedYauYXqgtQHBqfJwZls4emhPvcVVYusMhk6NQRSrqmXkOfbyK
         lec9ms7Y67GKBE4N+VnfyrLz3OQlDFuxeDpB+pKc3x7Z1W1myBT4c8Y5mN0DuVgb+nSd
         d9Td77M2fGUfWeOUiZnjfQsSTF6cw/I+0KrAUUaJkfgsFKyJe/GGMBg3Yd2Jjc9v2NUP
         3iVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yVLX37F2SHE9pdsMDuRoC7Ej8BDm/LIWpbduFLqwqRo=;
        b=AetSgzZ5/Xv7RJCs+lWAKcG2JfyR2yK157F1he1/tLDqRfk6xad1FnZmIzaPv0lJvt
         /RaaN+fW6sHdojbeaOQDxB+NY2WIBqlQiTSg8ChIITCKf0xOQnoshljknpZPNqvx4zQ6
         Qf3f5Rpzkog+bxfxJeo5e0AEUsv3pTAbyfNBWVfiuCZQWw+/NwU/VMUHTb5l5wZyhYd6
         7t8UGqeLcwlSseSXqji8MasgHxEtH7U0ojHa2E8kzS7eNB85AII1ao0Qdr7n3ivyopPd
         feyaAmpx+zrcXyDkNBP749c5Sf84+oG6iodAvRjCWKdcREt67jGttZEnNoFxBHr5yHgS
         XuvA==
X-Gm-Message-State: AOAM532HyqtB/N7tAoaqsYdnp6uX9llDb5g+KUr/fH36QeE3YcFix7S/
        velUmh82qe8Zs5V5EE0R5Vg9LQ==
X-Google-Smtp-Source: ABdhPJxyVjcAmPqNBl0Dhd/gKPFSTA56xLQKPKvwGH9TvtRVfyQpqrE8r6fN+SrXjJg1UvNPUM+oEQ==
X-Received: by 2002:a02:852e:: with SMTP id g43mr414674jai.9.1642716711822;
        Thu, 20 Jan 2022 14:11:51 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v6sm1779261ilu.60.2022.01.20.14.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 14:11:51 -0800 (PST)
Date:   Thu, 20 Jan 2022 17:11:50 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com
Subject: Re: [PATCH v3 1/9] t5326: demonstrate bitmap corruption after
 permutation
Message-ID: <YeneJrzjp160edGG@nand.local>
References: <babce7d29a85df0da54cb651433111bc33097a4e.1641320129.git.me@ttaylorr.com>
 <20220120175541.3099054-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220120175541.3099054-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 20, 2022 at 09:55:41AM -0800, Jonathan Tan wrote:
> As an effort to ensure that Git reads coherent .midx, .rev, and .bitmap
> files, both the .rev and .bitmap files are keyed on the checksum of the
> .midx file. But the issue here is that a .rev and a .bitmap could both
> refer to the same .midx checksum when the .rev and .bitmap files are not
> coherent with respect to each other (e.g. when a Git process has written
> the .rev, but not the .bitmap yet - but this would appear perfectly
> ordinary to another concurrently running Git process, since the .midx
> checksum in the .rev and .bitmap files match).

Kind of, and it's possible that we're saying the same thing here using
different words.

But seeing an out-of-sync .bitmap and .rev is really a symptom of the
underlying problem, which is that the MIDX checksum could (prior to
these patches) be unchanged even when the object order it represents
_does_ change (e.g., in the case of swapping the preferred pack around
like the test here demonstrates).

> This problem is exacerbated by the fact that the .rev has its .midx
> checksum in its filename, whereas the .bitmap has its .midx checksum in
> its file contents. When generating .midx+.rev+.bitmap, it would write
> the .bitmap but not the .rev, since a .rev of the same filename already
> exists.

This isn't quite right: both have the MIDX's checksum in their filename.
For example after running `git repack --write-midx --write-bitmap-index`
on a random repository, I get these MIDX-related files:

    $ find .git/objects/pack -type f -name 'multi-pack-index*'
    .git/objects/pack/multi-pack-index-fd71600b4ceb4caf23a538c7829b9284f2b66d73.rev
    .git/objects/pack/multi-pack-index-fd71600b4ceb4caf23a538c7829b9284f2b66d73.bitmap
    .git/objects/pack/multi-pack-index

Before these patches, it was possible for the MIDX's object order to
change but for its checksum to remain the same. The problem here is that
we rename(2)'d the .bitmap into place, but only link(2)'d the .rev into
place.

So one of the two was updated, and the other was left behind. That does
make them incoherent with respect to each other; but I find it more
useful to think of it as the .rev being out-of-sync with the MIDX.

> The solution is to embed the .rev in the .midx. This means that the
> checksum stored in .bitmap takes into account the contents of what would
> have been in .rev, solving the coherency issue. (There are other
> solutions like storing the name of the preferred pack in .midx, but I
> think that putting the contents of .rev in the .midx is best.)

Right. The problem being that it's possible to change the MIDX's
object order without changing its checksum. Since the .rev file's
contents encodes the pseudo-pack order, embedding it into the MIDX is
sufficient to guarantee that the MIDX's checksum changes whenever the
object order does.

Apologies if that all exactly matched up with your understanding, and I
was just telling you stuff that you already knew. But I figure that this
bug is subtle enough that a little bit of hair-splitting doesn't hurt
;).

Thanks,
Taylor
