Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1B3CD6E7E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 14:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbjJKOwV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 10:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjJKOwU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 10:52:20 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3E294
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 07:52:16 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-7743448d88eso466271285a.2
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 07:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697035935; x=1697640735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u+HFyqwwMIzvHI7x8fUybRDGtwW2Ky8wKk3ke4VgzLA=;
        b=IgQd1qe8BrM41HZtmSpI5B5RLRi7BvC2GldrZJOEoCtevc2fWvoUU7ymvM356n0vHK
         tv8pil6AWxaSWa6PT6M0aVq0EziYzzyL0opJDAMzwo454jfcZkADk5h6C67bazNa/GaK
         RP7C6w/PEVo29q/H2F+B0cxsJvy3vWhFrUp9g3o+8Y+Bf/PtXmdEVNEvXMPwBs6jJdYV
         6UqIkQAKZ95KOr8Vpp8Wr/Ct0Ohsnbz8sJ6bdV+i76sp0LA2WgH3UfBEh6t6YRPz8LY8
         EzjvCWA58AW+Jd20zTQ7nPQ+W0p7/d7jZhYugR1RtdmL1BDBd3LAz9py/Oye5/nLHw3t
         qv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697035935; x=1697640735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+HFyqwwMIzvHI7x8fUybRDGtwW2Ky8wKk3ke4VgzLA=;
        b=H1KdenKcBmnWWr8Lnko8bjhdrY2pM7nFdL55AyXwoneWue2/EMaUmJsU3NlNLo+iQA
         yz7m5scxIuU6HPZYxOJn3sdVfj6iyDnbtvyFge32eXQfCIx+PySnW+m83mkeSiKDLocI
         zqhLZGfzymG9jp9LjtqZCdbpjFQNF0tSfL9fEnybMDh8BsFHFz4pMN6+Yo8PSmWWHywp
         LsCFgIX2l/dFouRU65NQEpftDDhWu2r8FzbptBVHSqlJ06uyosXDLXvK6GSwlJt8qPKL
         iJsHn5jiTCA3+1wNLhaMVz5kx2OHYKRq+VFfpk/3u+8IQyhIBkWR+R/WmpPaq7G9t4b/
         xRPw==
X-Gm-Message-State: AOJu0Yx26Zh8C0iTjlW9jh1ypZpWPP/AVHyrVEFcJfCc1ya00RfNvkWD
        5sz40SeKhd8dL9/OYRGVzGTGcA==
X-Google-Smtp-Source: AGHT+IFE4C+3FPNagoIxfSB50p/9GgH6KAxLaAUYEldWvFZlZcH8AzDVKOGB0PKzW1DNm/ai5Jzs6A==
X-Received: by 2002:a05:620a:21da:b0:76e:f320:9b52 with SMTP id h26-20020a05620a21da00b0076ef3209b52mr21072783qka.73.1697035935102;
        Wed, 11 Oct 2023 07:52:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i16-20020a05620a145000b00767dc4c539bsm5267858qkl.44.2023.10.11.07.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 07:52:14 -0700 (PDT)
Date:   Wed, 11 Oct 2023 10:52:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 07/20] midx: check size of pack names chunk
Message-ID: <ZSa2nbVDTXvFZvSx@nand.local>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <20231009210514.GG3282181@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009210514.GG3282181@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 05:05:14PM -0400, Jeff King wrote:
> @@ -176,9 +176,16 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
>
>  	cur_pack_name = (const char *)m->chunk_pack_names;
>  	for (i = 0; i < m->num_packs; i++) {
> +		const char *end;
> +		size_t avail = m->chunk_pack_names_len -
> +				(cur_pack_name - (const char *)m->chunk_pack_names);
> +

This patch all looks good to me, but reading this hunk gave me a little
bit of pause. I was wondering what might happen if chunk_pack_names_len
was zero, and subtracting some other non-zero size_t from it might cause
us to wrap around.

But I think that's a non-issue here, since we'd set cur_pack_name to the
beginning of the chunk, and compute avail as 0 - (m->chunk_pack_names -
m->chunk_pack_names), and get 0 back, causing our memchr() lookup below
to fail, and for us to report this chunk is garbage.

And since cur_pack_name monotonically increases, I think that there is
an inductive argument to be made that this subtraction is always safe to
do. But it couldn't hurt to do something like:

    size_t read = cur_pack_name - (const char *)m->chunk_pack_names;
    size_t avail = m->chunk_pack_names_len;

    if (read > avail)
        die("...");
    avail -= read;

to make absolutely sure that we would never underflow here.

Thanks,
Taylor
