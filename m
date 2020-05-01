Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B58C47256
	for <git@archiver.kernel.org>; Fri,  1 May 2020 22:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFAB5206B8
	for <git@archiver.kernel.org>; Fri,  1 May 2020 22:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="AI5/kqsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgEAWzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 18:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726045AbgEAWzC (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 May 2020 18:55:02 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6242CC061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 15:55:02 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 145so2177968pfw.13
        for <git@vger.kernel.org>; Fri, 01 May 2020 15:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mOB3/PxBNnmfPCHpn1WAWEulRYW0+5D5H4Dij5PCFU8=;
        b=AI5/kqszXspFvcRZCTHEiM5ZD6nBcZJQMH9mqJ58u4bvspMpGTucRqAXvjhD/XrQnN
         +vHhLqd9RQmNl5r6SbnLDfrjo4d+4EuRlVLPDK2UIMSh4hO6qsX3l60qC9iuoWJGzZ+R
         wbBgXN3cNUo+LbUYgPSzniW3pSO2VwdchAGJdXRCxTLARqOGa1JR956A0Cs8TmYzV4Nk
         4mCoYUmi6HoT9MT2Dl41ckio+rO8PeOzd3oRnhnYpkFwbMJZuS+RExHWm4A4ZmHO3aR0
         /TkorHJY7flcKJQRkliMMKnTnZuiIZ35jATyN834Xxo94eOGIIcwhkwnw0347TKVrmwf
         AHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mOB3/PxBNnmfPCHpn1WAWEulRYW0+5D5H4Dij5PCFU8=;
        b=kCxjGOzDlLWMjKU94c3RaTMArcdjedKqguGp4bHW4LV0+xipP+5Eiuz99EwGBYiA7S
         7GQx6YAvDafzDMEm6o5f7SgjK/3SD9BLZC2NpJlpADAW9rtoBlvTULkXjUeyGb6dH409
         LHO8e0wX/bfztfZ9ho5W7r6dP3aXNpKNDDUtjvythXu/0F8dSEVanNP3RILp/gkgB5Mi
         1Ly7aVWZTXHry7cOUWK5FyV5RQUV2GtUtRr4abK92ulw/rXPE82LRIqdD2uWqd2FNFQm
         se72C43YHNylph+kPiZ5eItQ1bnCoDtcZrU+k5Gldf9IlIQtOLcH3tZvkbvhnhlWSLa1
         /qMA==
X-Gm-Message-State: AGi0PuZ54xFDacb3Z0T4GOFwRGr9DFKODGW4C9epY0Bk4WAejUUcNXfP
        GUPquWyAeWvLNoAWFVqQaPU9Sw==
X-Google-Smtp-Source: APiQypLDJraVPVUDgwawUfrkggiFlvfO2On/YawH/fVDgJkx9o/hoM3s+x4CdhWQmXJXxUw/xPVuRQ==
X-Received: by 2002:a63:5c24:: with SMTP id q36mr6013356pgb.377.1588373701658;
        Fri, 01 May 2020 15:55:01 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id y21sm3005134pfm.219.2020.05.01.15.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 15:55:01 -0700 (PDT)
Date:   Fri, 1 May 2020 16:55:00 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        garimasigit@gmail.com, szeder.dev@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 03/12] Documentation: changed-path Bloom filters use byte
 words
Message-ID: <20200501225500.GA46146@syl.local>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
 <03b2c84db36754b321dd15cd8a9e1a22b7c11c36.1588347029.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <03b2c84db36754b321dd15cd8a9e1a22b7c11c36.1588347029.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 01, 2020 at 03:30:20PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> In Documentation/technical/commit-graph-format.txt, the definition
> of the BIDX chunk specifies the length is a number of 8-byte words.
> During development we discovered that using 8-byte words in the
> Murmur3 hash algorithm causes issues with Big-Endian versus Little-
> Endian machines. Thus, the hash algorithm was adapted to work on a

I'm nit-picking here, but I believe that "Little Endian" is usually
spelled "little endian", right?

At least, 'git log --oneline -Gendian | wc -l' doesn't return many/any
results for me, but '-GEndian' does.

> byte-by-byte basis. However, this caused a change in the definition
> of a "word" in bloom.h. Now, a "word" is a single byte, which allows
> filters to be as small as two bytes. These length-two filters are
> demonstrated in t0095-bloom.sh, and a larger filter of length 25 is
> demonstrated as well.
>
> The original point of using 8-byte words was for alignment reasons.
> It also presented opportunities for extremely sparse Bloom filters
> when there were a small number of changes at a commit, creating a
> very low false-positive rate. However, modifying the format at this
> point is unlikely to be a valuable exercise. Also, this use of
> single-byte granularity does present opportunities to save space.
> It is unclear if 8-byte alignment of the filters would present any
> meaningful performance benefits.
>
> Modify the format document to reflect reality.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

The rest of this patch looks good, and indeed matches reality ;).

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

> ---
>  Documentation/technical/commit-graph-format.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
> index de56f9f1efd..1beef171822 100644
> --- a/Documentation/technical/commit-graph-format.txt
> +++ b/Documentation/technical/commit-graph-format.txt
> @@ -97,10 +97,10 @@ CHUNK DATA:
>        bit on. The other bits correspond to the position of the last parent.
>
>    Bloom Filter Index (ID: {'B', 'I', 'D', 'X'}) (N * 4 bytes) [Optional]
> -    * The ith entry, BIDX[i], stores the number of 8-byte word blocks in all
> -      Bloom filters from commit 0 to commit i (inclusive) in lexicographic
> -      order. The Bloom filter for the i-th commit spans from BIDX[i-1] to
> -      BIDX[i] (plus header length), where BIDX[-1] is 0.
> +    * The ith entry, BIDX[i], stores the number of bytes in all Bloom filters
> +      from commit 0 to commit i (inclusive) in lexicographic order. The Bloom
> +      filter for the i-th commit spans from BIDX[i-1] to BIDX[i] (plus header
> +      length), where BIDX[-1] is 0.
>      * The BIDX chunk is ignored if the BDAT chunk is not present.
>
>    Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
> --
> gitgitgadget

Thanks,
Taylor
