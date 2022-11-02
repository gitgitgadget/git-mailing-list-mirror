Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824DAC433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 13:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiKBNw7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 09:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiKBNw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 09:52:57 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AAA22B02
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 06:52:53 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r18so16267479pgr.12
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 06:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSkUo0INibKp4sWAtD9EpkwWHYjrZKj8GQ8tHnlHIWs=;
        b=atHpu/0KQlGc/1z1DzhFVZw5Z14r4+ERu4Oobop0a+IJHNrmpNSNAt5OQMzHUHXL+6
         JjZPeVo4XDgVfpAukJZnKLqwWVgITXRNNRdgstLh33zbSSiOvPk+lHnA6eMd809fbGjn
         fBFMlT9pwdh1H8GWpEKcAe3Dakl4GsgekPUdiZunwjNI/t+Y8QH5TsVToTjwz/L5y2eV
         XOIrvgm+WGdExDW3+JUZCSL0i+K0Cu0B9Sgbs60RQMER5e+RdQBYxe8pv1x4J6aURTwr
         aMzqTfDLxF90t+ckLgbSEMOVYsRcMwCcOvn4J7ZRKV4kPZltPTXQQMb2VWkyINu0NXXO
         ahRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSkUo0INibKp4sWAtD9EpkwWHYjrZKj8GQ8tHnlHIWs=;
        b=fnlhZs2i6a6RnRlacGq5urRYtqmb8iCqcXpSOgpFzSAr+OGLNI1s+SnD9w2Lb/hp4Q
         m2LxKsArQXr5c383MajV54CcvjwnVbMzvCpxdrVEVnt8sUQ83bGd/oqH7CSy68w66l53
         Jg/7/cjtMfTpCIZrDe/ARg4OjgEOfYlfnn2QUDM8rTWmEwMTAP/XgzX/nAVftDHzbbOQ
         utFJsbLp7q+f8eaeEhmCv3MM7BpDOvXRixKiS47ka5YMKqz9KcqakL6VSyqaJkqFBOIp
         OCeJeOkHB6E7COt67ckZ9JT4UGGl4ZRb69QpZbhoMYTyg/e1My21HPwnxEzApkCW8Yzv
         xNfQ==
X-Gm-Message-State: ACrzQf1pbeTNn7wPk59BrIBb50UvuNc/G2bcF5RR1AqCvbmm8SH5m3jR
        g3xzYpPbps3719HXC2AAOdc=
X-Google-Smtp-Source: AMsMyM51l9A8TTBctiXNx4fbMfpbb0p88/xbKSfxWgLxGyFwmI8/Yf1y5TUBNO3RoJQ9Lc4OWJK3+A==
X-Received: by 2002:a05:6a02:10e:b0:43b:e57d:2bfa with SMTP id bg14-20020a056a02010e00b0043be57d2bfamr21345446pgb.263.1667397172700;
        Wed, 02 Nov 2022 06:52:52 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.48])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b00179e1f08634sm8283419plp.222.2022.11.02.06.52.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Nov 2022 06:52:51 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     peff@peff.net
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH 0/1] pack-bitmap.c: avoid exposing absolute paths
Date:   Wed,  2 Nov 2022 21:52:45 +0800
Message-Id: <20221102135245.97998-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.37.2.1.g87a494e5ac0.dirty
In-Reply-To: <Y2IiSU1L+bJPUioV@coredump.intra.peff.net>
References: <Y2IiSU1L+bJPUioV@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I mean that later in the process, if we need to find an object we may
> open the .idx file to look for it. So by opening them all up front, we
> _might_ just be doing work that would get done later.
>
> But it's not guaranteed. Imagine you have 10,000 small packs, and one
> big bitmapped pack. If you can serve the request from just the big pack,
> then you'd never need to open those other .idx files at all. However,
> the current code will open them anyway.
>
> I care less about mmap space, and more that it's work (syscalls, and
> examining the contents of the idx) to open each one. It's probably not
> even measurable unless you have a ton of packs, though.
>
> > > So it may not be worth worrying about. It does seem like it would be
> > > easy to reorder open_pack_bitmap_1() to look for a bitmap file first and
> > > only open the idx if it finds something.
> >
> > I think it may be worthy if we have lots of packs and the bitmap is refer to
> > an older one, but I didn't make the test. At least, the scenario is common, I
> > agree with that, so maybe we could shuffle the sort order in "open_pack_bitmap()".
>
> I don't mean the order in which we look at packs. I mean the order of
> operations in open_pack_bitmap_1(), something like:

Thank you for the explanation. Make sense.

I run a test under a repo with 3 packs and without bitmaps,it seems like now
will open every idx and failed at last:

➜  pack git:(master) git rev-list --test-bitmap HEAD
pack: /Users/tenglong.tl/Downloads/trace-test/.git/objects/pack/pack-c9fe9d2dc5d002d4a4b622626ffa282bcbccb7ee.pack
pack: /Users/tenglong.tl/Downloads/trace-test/.git/objects/pack/pack-08841c0c4c1fd176c354bdbd25c5a1b152ea95d0.pack
pack: /Users/tenglong.tl/Downloads/trace-test/.git/objects/pack/pack-3cea516b416961285fd8f519e12102b19bcf257e.pack
fatal: failed to load bitmap indexes

So we're now looping for packs first, then try to find the corresponded bitmap
of it. In that case, why can't we start the search from the bitmap files at
first? If this is possible, when we found the first bitmap file or an
appropriate one under some mechanism (biggest or newest maybe？I'm not deep into
it right now) then break the loop and open it.

> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 440407f1be..1df2f6c8b6 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -411,9 +411,6 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
>  	struct stat st;
>  	char *bitmap_name;
>
> -	if (open_pack_index(packfile))
> -		return -1;
> -
>  	bitmap_name = pack_bitmap_filename(packfile);
>  	fd = git_open(bitmap_name);
>
> @@ -438,6 +435,10 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
>  		return -1;
>  	}
>
> +	/* now we know we have a plausible bitmap; make sure the idx is OK, too */
> +	if (open_pack_index(packfile))
> +		return -1;
> +
>  	if (!is_pack_valid(packfile)) {
>  		close(fd);
>  		return -1;
>
> But we can further observe that the first thing is_pack_valid() will do
> is open the idx file. :) So we can really just drop this line entirely,
> I'd think.

I agree that and I think it could append to patch v3, maybe.

> BTW, another oddity I noticed in this function. We check:
>
>    if (bitmap_git->pack || bitmap_git->midx) {
> 	   /* ignore extra bitmap file; we can only handle one */
> 	   ...
>    }
>
> but it's impossible for bitmap_git->midx to be set here. If we opened
> the midx bitmap, we'll skip calling open_pack_bitmap() entirely.

Oh, I remember that and it's mentioned in another patchset at Tue, 29 Mar 2022:

https://public-inbox.org/git/20220329024949.62091-1-dyroneteng@gmail.com/

I agree with Taylor with
https://public-inbox.org/git/YkPGq0mDL4NG6D1o@nand.local/

But I'm ok if you think it should be solved.

Thank you very much for your help.
