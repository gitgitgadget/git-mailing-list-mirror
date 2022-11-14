Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F1DC4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 22:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbiKNWus (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 17:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237543AbiKNWuq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 17:50:46 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC90C17068
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 14:50:45 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id m15so6536265ilq.2
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 14:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J8CEQalS+5RvNyEGdYR1fzZ/XdS0NQjy/42E4OjfwiI=;
        b=pKZByidSgcb48s13yRLhVRyYpWAh/t/5E06Euu7oI3lNIDpvfspD13VchNKpa2CEQE
         zUwRG49cj+tp3SW3v2QRPDyen595Sl3WIMZpFfm5/iQyUf2uuL6FpN9PJDCj3H5ovfCe
         aMpGdqfzgPBJqZ3t4IVw7vPlByAEUMx0K8HRnA2MP9ngW8IKDCoBe1dgceCPsBYZOdk6
         byxdNitGWCJO51iEyLIepcLCfktr1O3ItsOv6mglL1EVTLQgZoKEuFpqmk+YjRMgBdVc
         qZ4pSZ1x3asCXAeJBpwfIsSWYXynSK8I0yIAQ6PTW+q5jOM5k/na+aA7H0+hvCSsY3Hc
         U3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8CEQalS+5RvNyEGdYR1fzZ/XdS0NQjy/42E4OjfwiI=;
        b=8HZqC00yDDK8ECIQOwSSAGqtP5G02nDMduh93F/osCpPGE0Hw7mTMiuoj0+XtvTze3
         D8Fkpx6MbNSCTdbMcqKzCNEL4ip6VBlEdzPUX4OqMuTkRZjpp2SonD2iDmw2kEZIQe5N
         Jz2ytb3jkco/iAy33exJl63ha81csBp6SqcRFAFtCgoaHJ5YMApbjgDcxjdgQdUkR7l7
         xdeNo2We7STLA2QouiduFSucN5E0eFAsvs0HrPiDNGY7tqXCwd8015Fxv2DiEUHQWnZX
         4FHl0AYpu4F0S9GKTz6P+0JSfBUCGEWf1zryvJg3MsrDfr52mzdKC0olQ4jr4V8tQTYu
         Kofg==
X-Gm-Message-State: ANoB5pkZ+6h0zfWo1mItEZTQe8UTOx9skhoc2xis6L9VY7NW5usJwZZF
        baRVHcGMipuv1zrA+ypftGKFLw==
X-Google-Smtp-Source: AA0mqf5ZZ/iqqg9ZkztD2egehU8WTCtkq4UV+rDrcMKyKWE8X3NyD5McA0btbDgegtLq1L6xmxcaCg==
X-Received: by 2002:a92:c108:0:b0:300:ee15:9973 with SMTP id p8-20020a92c108000000b00300ee159973mr7334497ile.234.1668466245051;
        Mon, 14 Nov 2022 14:50:45 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u18-20020a92d1d2000000b00300b6effa1dsm4311133ilg.31.2022.11.14.14.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 14:50:44 -0800 (PST)
Date:   Mon, 14 Nov 2022 17:50:43 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Teng Long <dyroneteng@gmail.com>,
        avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 1/2] pack-bitmap.c: remove unnecessary
 "open_pack_index()" calls
Message-ID: <Y3LGQ+yV1lJiWR21@nand.local>
References: <cover.1668063122.git.dyroneteng@gmail.com>
 <aaeb021538cdfeb83dc6004fe7b3ac35a23aef49.1668063122.git.dyroneteng@gmail.com>
 <Y3K7TEpB8EzczjTb@coredump.intra.peff.net>
 <Y3K9zVx7L9K85NrE@nand.local>
 <Y3LBtl+x2rCzsoIh@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3LBtl+x2rCzsoIh@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 14, 2022 at 05:31:18PM -0500, Jeff King wrote:
> Yeah, I agree that 1k is a lot more compelling. The big impractical
> thing I think is that if the bitmapped pack is older (and it usually
> is), then we'd often open all the other packs anyway:
>
>   - if the start of the traversal is in the bitmapped pack, then we
>     fruitlessly open each of the others looking for the object (since
>     the bitmapped one will come last in the reverse-chronological
>     sorting)
>
>   - if it isn't in the bitmapped pack, then we'll end up opening all
>     those other packs anyway to fill out the bitmap (since by definition
>     it can't be included in the on-disk bitmaps)
>
> So I'd be surprised if it ever mattered in the real world. Though again,
> I think the new code is less surprising in general, and could matter if
> we changed other things (e.g., if we prioritized lookups in a pack with
> a .bitmap).

I completely agree. It's definitely worth doing purely based on the
principle of least-surprise. But the potential performance improvements
are just gravy on top ;-).

Thanks,
Taylor
