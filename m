Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE435E95A8F
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 01:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344723AbjJIBZA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 21:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjJIBY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 21:24:59 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E7A99
        for <git@vger.kernel.org>; Sun,  8 Oct 2023 18:24:58 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4197fa36b6aso23219241cf.3
        for <git@vger.kernel.org>; Sun, 08 Oct 2023 18:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696814697; x=1697419497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D7iiq3X0V1HMLzXenXL+VkStiDsKqUld7hWUbzH1O3M=;
        b=hfNOOhv6GrbVAPjBMy89NCAXGWbFPBCpyfOEiWGct3hx6R5yAw7xY31w4N54xaKzNx
         gdqSWZA6U0iRgiKQapNaLrwtH/vFqvxaZHB1bvEx6nJvwxsw+1YWbr2833UxKpUJSve0
         46x06hfWaSGxJ3FgctdY8cXra5FieHoqX3PSQK0N+GaSneQPpwXvuJY9f1ny0kLmIKuF
         VxugF4LmByWrtKmhMGb9Uq+CY3QkcWdZ8uQJ8Excns23IamxMiSvIJj4QjdRzug/XdiP
         C6sIWoU3IfAvv29h42lVI47KdttrRZwW5TluVLPlnj7f+bODIYaaPwtLethMQysifIfU
         3GRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696814697; x=1697419497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7iiq3X0V1HMLzXenXL+VkStiDsKqUld7hWUbzH1O3M=;
        b=URcWlueJf/9Vmg2fRliUFafnD67nnA5gjUEXGHvFq0gQ2zcaBCsNmZJdGzoXBma79m
         Z2IgJ+7UlBo7b6AFaWgLUitJQgHgEJF3NV1bjS2mIf727oy/nuUjdOn11wGTJS08ceJ2
         gzRkaXNqe1NezAvosKeNkuC5wj+N0m8nNOSwpH3U4Pa+xTNAf2JBhvw575uqAXtXr2Ua
         /Ep/nvSqH0GnFUhDq/PoooVLhx9vWb+mh7q2nxl1o9Sw072CiwEFi9RJPWIoJxMWGmcZ
         3ug0U5cH0YuI+Z1TqzsyPNeBJ3q6Ci4JMrmT2D4nj9j0/77ERH84G4lgE5V/zRkVMygj
         kzaA==
X-Gm-Message-State: AOJu0YxzqFRn0XlKzBpRDDn5NCoT9uH0IzEGErs7jIjrkgkH+xjcE4Wf
        kGZW2ibt8RNPoObKssfDZfpJfm7+1/O6dRL+XfccvQ==
X-Google-Smtp-Source: AGHT+IHtE5gwf5PVzwkSdmrcyLqEi62nTprF+uEzvjNAnUk4NMYze0Hw6VPF6dGUgmnaw9267YKhZw==
X-Received: by 2002:ac8:7d4c:0:b0:418:1ae2:86e0 with SMTP id h12-20020ac87d4c000000b004181ae286e0mr16537835qtb.54.1696814697179;
        Sun, 08 Oct 2023 18:24:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cj20-20020a05622a259400b004197079f2f8sm3278458qtb.64.2023.10.08.18.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 18:24:56 -0700 (PDT)
Date:   Sun, 8 Oct 2023 21:24:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] repack: free existing_cruft array after use
Message-ID: <ZSNWZ9+Q2eOpy91A@nand.local>
References: <cover.1694123506.git.me@ttaylorr.com>
 <cover.1696293862.git.me@ttaylorr.com>
 <e7beb2060dad648ec5c3fa8984e432ee243ae012.1696293862.git.me@ttaylorr.com>
 <20231007172031.GA1524950@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231007172031.GA1524950@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 07, 2023 at 01:20:31PM -0400, Jeff King wrote:
> On Mon, Oct 02, 2023 at 08:44:32PM -0400, Taylor Blau wrote:
>
> > +static void collapse_small_cruft_packs(FILE *in, size_t max_size,
> > +				       struct existing_packs *existing)
> > +{
> > +	struct packed_git **existing_cruft, *p;
> > +	struct strbuf buf = STRBUF_INIT;
> > [...]
> > +
> > +	strbuf_release(&buf);
> > +}
>
> Coverity (using the just-merged-to-next version of the workflow file!)
> flagged a leak here. Since the topic (tb/repack-max-cruft-size) is in
> 'next', I think we'd want this on top:

Woohoo! I'm glad that this is already paying dividends.

> -- >8 --
> Subject: [PATCH] repack: free existing_cruft array after use
>
> We allocate an array of packed_git pointers so that we can sort the list
> of cruft packs, but we never free the array, causing a small leak. Note
> that we don't need to free the packed_git structs themselves; they're
> owned by the repository object.

Thanks, I can't believe I missed this when writing this function. The
fix looks obviously correct to me, so this has my:

    Acked-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
