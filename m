Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59A8C4742C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 21:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B6782068E
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 21:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="rgUVGeiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgKMVte (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 16:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgKMVtd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 16:49:33 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08B6C0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 13:49:31 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 11so10429247qkd.5
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 13:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lcCxrdw5Guv6J8mEHkQYsNFhg6vAHifyEqCOgZL/AlE=;
        b=rgUVGeiO3RdJHWcIOoCG27QydhEkp6nB51rOoPV6auUcososZz4j6AxfhzrEVLhNjj
         MM3S+6W/kCjPErKFXXx2duIs7Q0iglSthnEohLyXSZknxfThhMbV5gX8lpl/jmlGyh6Z
         EABzmXZf0F/C3m70u92ZY1VpRBrbJvEbBIvXKAAUzQuRLlzGdhWfUnt6Nv7tjEEELMt3
         be35TNKblUNCINqes+Zr6CWT7jvl3VPM3hrqxDK/anNULGKbhbcmIUePtPDLNCJgCRfP
         mTOhjtgz0nagsf+Dgit3k3LHD7rrWyQKwG5kmIlHtSUnmzvKlxHq99PpU3UgEiFlkhwd
         zM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lcCxrdw5Guv6J8mEHkQYsNFhg6vAHifyEqCOgZL/AlE=;
        b=KOsBW1ks1kFHEvIi7+mg9ld/fVOCYPFNHvX2YPwtl/DyoMaq7AI2HTyGCjtmi4t+JF
         5CztcW3EYEbrYkEskofB0qGS3FAuLcpooKxHNm1wkd9dkC45I3tSqaw+A27t2W/duXAP
         eUcwQkuuaAmROfvuc1FQM/dVYhnl9TNF47n1ZOZyKuloXuj3Ie3lXUxfgOh5JyKpsfoL
         qeSVOq3cLmW8IUDxql4jhq3ai5kBJlpWLbo6Av5wxxSLaqhu/NCvRxHM/8wqkICHNX2K
         9gADuC/ZKtIs+hKS8iRX2Z/0MqEOu4dpQobD8efqumOZ1XDkkDDuq6igthK4Oyw/2XIL
         MZvA==
X-Gm-Message-State: AOAM530k0cBkDm1RSWmveI6gD/sFtM+NeJrUdA1zKgpXbcieZLathA7Z
        RRyxP8dvw3umLjK6LBJoRxB/QQ==
X-Google-Smtp-Source: ABdhPJxoXfoDA9WmFLyrtRTNb7pNfPP18LA7bbYurdH8mAPaZXlj1laVzl+FOlZdU1y8nREGzsIEaA==
X-Received: by 2002:a05:620a:10ac:: with SMTP id h12mr4092731qkk.165.1605304170855;
        Fri, 13 Nov 2020 13:49:30 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:51df:232c:7a24:7fb0])
        by smtp.gmail.com with ESMTPSA id s68sm7599706qkc.43.2020.11.13.13.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 13:49:30 -0800 (PST)
Date:   Fri, 13 Nov 2020 16:49:28 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/23] pack-bitmap: bounds-check size of cache extension
Message-ID: <X67/aExL78Fxyobl@nand.local>
References: <cover.1605123652.git.me@ttaylorr.com>
 <1573902df00e8a14a9cb68c37f55474388b1dc2e.1605123652.git.me@ttaylorr.com>
 <CAN0heSqiiMZgT+rEgWVVR_cEmPK2bS3QNnJuHahrqVQet7_Qug@mail.gmail.com>
 <20201113045700.GA743619@coredump.intra.peff.net>
 <X6760infcF0hRYTG@nand.local>
 <20201113213942.GB780435@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201113213942.GB780435@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 13, 2020 at 04:39:42PM -0500, Jeff King wrote:
> The problem is this hunk from patch 2:
>
> > +       size_t header_size = sizeof(*header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz;
> >
> > -       if (index->map_size < sizeof(*header) + the_hash_algo->rawsz)
> > +       if (index->map_size < header_size)
> >                 return error("Corrupted bitmap index (missing header data)");
>
> The header struct contains a field for the hash of the pack. So the
> original code as taking that full header, and adding in another
> current-algo rawsz to account for the trailer.
>
> Afterwards, we adjust header_size to swap out the MAX_RAWSZ for the
> current-algo rawsz. So header_size is a correct substitution for
> sizeof(*header) now. But we still have to add back in
> the_hash_algo->rawsz to account for the trailer. The second "+" line is
> wrong to have removed it.

Thanks for your patient explanation. This hunk should instead read:

+       size_t header_size = sizeof(*header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz;

-       if (index->map_size < sizeof(*header) + the_hash_algo->rawsz)
+       if (index->map_size < header_size + the_hash_algo->rawsz)
                return error("Corrupted bitmap index (missing header data)");

That error might not necessarily be right (it could say "missing header
or trailer data"), though. I'm open to if you think it should be
changed or not.

Since we didn't realize this bug at the time, the rest of the patch
message is worded correctly, I believe.

> The later line we adjust:
>
> > -       index->map_pos += sizeof(*header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz;
> > +       index->map_pos += header_size;
>
> is correct. It's just skipping past the header, and doesn't care about
> the trailer at all (and confusing the two is probably what led me to
> write the bug in the first place).

Right, makes sense.

> -Peff

Thanks,
Taylor
