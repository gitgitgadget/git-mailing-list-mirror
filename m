Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42474C433DF
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 18:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C84D2072F
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 18:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iySdhN+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgFBSAB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgFBR77 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 13:59:59 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F386C05BD1E
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 10:59:59 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c3so4265826wru.12
        for <git@vger.kernel.org>; Tue, 02 Jun 2020 10:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tY4GYCyttAHykUVk5DPz9vL0rWUOnbk6UZG1Or1PZko=;
        b=iySdhN+CXrCuZM7jRbyuA+Pu4PhUuSG1LZPDUqZFQwkHHVT4am8wF4ILLalkc2AmrL
         zY2pIzIj83IH1rwmnXoFpKdb8K+eTWDLrli9Xni8cmsAM4rsosnzJe01UL82aAKXuQTC
         csQoJJJiLUaIWbDsOVVqoihga8LgdTAWm6SYbWse33wYGWYohmwQkxCzyh+TJj1tLatD
         EbLr3cMsjpHugMZl5V07VzeFEoUVpZDiqTIqmhoYpkdjkoBH5M5JjzXJ7LtXUh0QpYUQ
         Cuh3ECM+7z3idxgSv132rzxBl/fAPU5qAPrsfB+htpC5r/RQtNFhCRJ6xHi9MH2Ff+qC
         hLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tY4GYCyttAHykUVk5DPz9vL0rWUOnbk6UZG1Or1PZko=;
        b=icc6zWa8UuLx/NZ/6V2WTc2BWDKUNlTWV/Y+J8FGVKFloAcA8lG9BTgZttcvskAxiG
         bdfeEptOMS4S9U2iRAR1ujz/LuePSU7Jj93FE4uUqKJM4I7IrzB/gFFHxvLfGtAS1FTj
         gYjBj7grFiyJN8KvPQmM/1RX+/Z+NFzPivSbXGuFWITbI6087HGx+deCZTJnZACQhLjj
         y8fcUS370fmCBafA8LCpFtrm0UuSLa+MTpjz0ySoaFgipL2PtyWb1Naa6i76jHLrjbXk
         v5BhQrdnaXxrVcSNN9L9M907GRYzZquPz1KQvyszkaF8o9ruLpOVcqcxNjcUNr+wHRUv
         SHfA==
X-Gm-Message-State: AOAM530YdkExymcfksqIbJWfmKQ/l4fbvGzlsR5i60lXcJ3RTxZtOvS7
        XiR7KAze9bfO80G3MfHDXs4xdglQ
X-Google-Smtp-Source: ABdhPJzhkhC+0f1CE8WRE60BHHPivJ4ddMI5Cz7P9/v6MaiXzpfdVU3bKMORnzk2G0e6GzJczXhyCg==
X-Received: by 2002:adf:ce02:: with SMTP id p2mr29557179wrn.152.1591120797949;
        Tue, 02 Jun 2020 10:59:57 -0700 (PDT)
Received: from szeder.dev (78-131-14-185.pool.digikabel.hu. [78.131.14.185])
        by smtp.gmail.com with ESMTPSA id k64sm770516wmf.34.2020.06.02.10.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2020 10:59:57 -0700 (PDT)
Date:   Tue, 2 Jun 2020 19:59:49 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 15/34] commit-graph-format.txt: document the modified
 path Bloom filter chunks
Message-ID: <20200602175949.GA2898@szeder.dev>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
 <20200529085038.26008-16-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200529085038.26008-16-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 29, 2020 at 10:50:19AM +0200, SZEDER Gábor wrote:
> Modified Path Bloom Filters

> Each modified path Bloom filter consists of:
> 
>   - 4 bytes specifying the number of bits in the Bloom filter's bit
>     array.
> 
>     For practical purposes 32 bit is more than sufficient to store the
>     number of bits in the Bloom filter's array.  When using k = 7
>     hashes, i.e. 10 bits per path, then we could store over 400
>     million paths in a single Bloom filter; with k = 32 hashes we'd
>     use 46 bit per path, which is still over 93 million paths.

> Alternatives considered
> -----------------------
> 
> Here are some alternatives that I've considered but discarded and
> ideas that I haven't (yet) followed through:

>   - Varints.  Using 4 bytes for the size of each Bloom filter in the
>     Modified Path Bloom Filters chunk is a lot more than necessary.
>     How much space can be saved by using varints?

Not that much, at least compared to the whole commit-graph file.

Since 63 bit modified path Bloom filters are embedded in the index
entries, it's pointless to store smaller Bloom filters, so the size of
non-embedded Bloom filters can be defined as

  nr_bits = 64 + decode_varint(...)

A one byte varint can encode values up to 127, while a two bytes
varint can encode values up to 16511.  So the max nr_bits is 191 and
16575, respectively, which means max 19 or 1657 paths with 7 hashes,
i.e. 10 bits per path.  The table below shows the percentage of
commits with embedded modified path Bloom filters and commits with
non-embedded Bloom filters with one byte and two bytes varints, and
how much space is saved.

                    Percentage of commits   |
                    modifying <= N paths    |   varint   commit-graph
                  compared to first parent  | size diff    file size
                  <=6      <=19     <=1657  |  (bytes)     (ls -lh)
  ------------------------------------------+-------------------------------
  elasticsearch  18.32%   65.56%    99.79%  |   -90158       9.5M      -0.9%
  jdk            26.62%   70.46%    97.94%  |   -90262        16M      -0.6%
  webkit         38.42%   82.24%    99.92%  |  -298824        19M      -1.6%
  android-base   42.32%   88.02%    99.98%  |  -132327        30M      -0.5%
  llvm-project   53.60%   93.86%    99.99%  |  -344239        24M      -1.4%
  gecko-dev      54.54%   87.15%    99.87%  |  -625029        63M      -1.0%
  tensorflow     55.17%   90.76%    99.52%  |   -83758       9.0M      -0.9%
  rails          58.71%   95.13%    99.99%  |   -53153       6.0M      -0.9%
  rust           59.29%   88.03%    99.96%  |   -90677       8.2M      -1.1%
  glibc          61.59%   91.11%    99.96%  |   -38422       3.8M      -1.0%
  gcc            63.80%   95.39%    99.97%  |  -179463        18M      -1.0%
  go             65.31%   95.19%    99.99%  |   -39109       3.2M      -1.2%
  cmssw          67.58%   93.02%    99.91%  |  -154440        23M      -0.7%
  linux          72.79%   95.27%    99.78%  |  -527045        78M      -0.7%
  cpython        81.91%   97.78%   100.00%  |   -40678       7.8M      -0.5%
  git            90.28%   98.56%   100.00%  |   -13406       3.9M      -0.4%
  homebrew-cask  98.61%   99.58%    99.99%  |    -2992       6.6M      -0.1%
  homebrew-core  99.81%   99.93%   100.00%  |     -810        11M      -0.1%

>     How much is the runtime overhead of decoding those varints?

Not enough to be above noise level.  ("a lot of paths",
MurmurHash3, k = 7, enhanced double hashing, 32 bit uint arithmetic)

                                       |   Average time spent
                   Average runtime     |  loading and querying
                                       |      Bloom filters
                  uint32     varint    |   uint32     varint
  -------------------------------------+-----------------------------
  android-base    0.1456s   0.144172s  |  0.01550s   0.01571s    1.3%
  cmssw           0.0313s   0.032046s  |  0.00383s   0.00395s    3.1%
  cpython         0.0810s   0.081649s  |  0.00765s   0.00785s    2.6%
  elasticsearch   0.0136s   0.013899s  |  0.00246s   0.00258s    4.8%
  gcc             0.2114s   0.211080s  |  0.02259s   0.02261s      0%
  gecko-dev       0.4815s   0.474903s  |  0.06004s   0.06028s    0.3%
  git             0.0310s   0.031156s  |  0.00192s   0.00195s    1.5%
  glibc           0.0282s   0.029032s  |  0.00320s   0.00342s    6.8%
  go              0.0403s   0.039408s  |  0.00428s   0.00414s   -3.3%
  jdk             0.0068s   0.006666s  |  0.00117s   0.00113s   -3.5%
  linux           0.0873s   0.087438s  |  0.01109s   0.01133s    2.1%
  llvm-project    0.4135s   0.418390s  |  0.04716s   0.04834s    2.5%
  rails           0.0391s   0.038997s  |  0.00449s   0.00448s   -0.3%
  rust            0.0439s   0.044569s  |  0.00444s   0.00461s    3.8%
  tensorflow      0.0487s   0.049166s  |  0.00618s   0.00634s    2.5%
  webkit          0.2420s   0.241807s  |  0.03353s   0.03379s    0.7%

>     How can we ensure that varint decoding doesn't read past the end
>     of the mmapped memory region?

With a decode_varint() variant that takes the max number of bytes to
read as an additional parameter, and returns 0 if the varint is too
long.

