Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A73CD6E7D
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 15:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbjJKPBU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 11:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjJKPBS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 11:01:18 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D01DC9
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 08:01:16 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-66afd39c8edso30962946d6.2
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 08:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697036475; x=1697641275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rkfDrCfZUL+oLmEyy72vwWbhGwQo1LEVTmuHXaxrtSE=;
        b=0ROOv/EHbtKhs+5HtKe8Ii2fAXXBS1S98qdY53RyDvvXtfQLzA4t3L6n6dsHpd8YDn
         hgn2LVHdysr4EaVAioG2WrRASiBwD/ozWSbHyVRDjZe94ObyurxVSyPqkP4sTwvNcNfq
         MdsgtnoT6OhzQQTfh6JTe41POBCQTin+nnE7S0BqqeAgX1smTZsJwnwfimpNVKr3TilK
         xrBwDpJKMwRTfj6qPhIuBg4XpLown93b+nrZHV1GcGw8xyh6YqxQ4XBAFStuaX7I8T9I
         jSa67l2zGr0apuZvSYTBDwSE9/00SvedTAcAk1J77f/8J7DM3YfdT5N5mvA66rzPEw8o
         Y0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697036475; x=1697641275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkfDrCfZUL+oLmEyy72vwWbhGwQo1LEVTmuHXaxrtSE=;
        b=K6ac/LptYqER97mjvrM/HV+hBbQ8DsQQ729j7OkdA+PIEa2e+da7Wb27RmGkvg2RI2
         91XsQJ1hm9O+EeTO8EEUQb8JHS0A4H+P9UBGXwx5BI4HyW+Io0JRrJDTG6ngovAjxKx6
         +LybxVNc4kJmc9zyaC+BQNmn31URuMNDRHvKetGwTu2fHHtAc2aohDz2vR08RZ3fsUAr
         lkcIahfoMSIXAEYJjAks+rNrhCMVevHbgxTQxRZ9OUQ0dkWa5PLanZwKZJqLwWiRitG+
         YiRpWeG2kxLke8eScfGlzU1RQL+xs3am6un53bfTAdRsvjTU5lav5N5u/k/uAeGwZCAJ
         GQ5w==
X-Gm-Message-State: AOJu0YzjJjKInKquNxcCwdet1qBedlnq5WGddHLuSX3sVJ1A8QljBrm/
        1szbTLBMQud/8DOiFMsrDb+DsA==
X-Google-Smtp-Source: AGHT+IG0eT1LdbKwchemYYpX9C0GzbVdEoG80zMSiyzIiDrkPl6oSxgb6Ijm7Bb/PybaBQxcje89hA==
X-Received: by 2002:a0c:e10a:0:b0:66c:fe64:a07e with SMTP id w10-20020a0ce10a000000b0066cfe64a07emr4607396qvk.40.1697036474938;
        Wed, 11 Oct 2023 08:01:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q27-20020a05620a039b00b007757eb88172sm5297935qkm.21.2023.10.11.08.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:01:13 -0700 (PDT)
Date:   Wed, 11 Oct 2023 11:01:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 08/20] midx: enforce chunk alignment on reading
Message-ID: <ZSa4tfG2NyM1s9Jz@nand.local>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <20231009210523.GH3282181@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009210523.GH3282181@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 05:05:23PM -0400, Jeff King wrote:
> @@ -120,6 +121,11 @@ int read_table_of_contents(struct chunkfile *cf,
>  			error(_("terminating chunk id appears earlier than expected"));
>  			return 1;
>  		}
> +		if (chunk_offset % expected_alignment != 0) {

Oops, I missed this in my first read. I'm definitely nit-picking here,
but this should probably be:

    if (chunk_offset % expected_alignment)

without the trailing "!= 0".

I don't have a strong preference here, since we are doing a comparison
of an arithmetic operation against an (un-)expected value. But I think
the CodingGuidelines would technically call this out of style...

> +			error(_("chunk id %"PRIx32" not %d-byte aligned"),
> +			      chunk_id, expected_alignment);
> +			return 1;
> +		}
>
>  		table_of_contents += CHUNK_TOC_ENTRY_SIZE;
>  		next_chunk_offset = get_be64(table_of_contents + 4);

Thanks,
Taylor
