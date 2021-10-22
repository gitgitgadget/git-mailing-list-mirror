Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E727BC433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 03:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D167A61504
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 03:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhJVDHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 23:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbhJVDHS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 23:07:18 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12FAC061766
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 20:05:01 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id j6so2571881ila.1
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 20:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=79kj0Hz7G1C0b9kzA6orIiebN/l1XiuJDZGgCwfBBpE=;
        b=Mm6jGRA+gdpga0qHI19WcoDvVdyaE6jXTgsJrW5Uc/AY1c4QgpQKk/0/0EX3Viis2q
         TTzz4YD/By3V0tgG4lJ88l/vB6DTxevZP5nQa2bDurbVHx8kNAkckIfsjOE/55KBcBmB
         QpCXpu5PQNrtfngfeuZP0p2NIP9Y6yvdXem8guNM+ysZDR1H7l1TBcpduFdcIbELYgmr
         eIVZIZ3zPkjRj6F/QbKYWPiHjvKL8B46AH1x2/IRPsZGIdAB209vwoNsACyqgveX5TbR
         Kl5rjBggsuLPpc23/5SDIDBKEBiSwj53m9gFtWy6NtKWo3QNs0Vte+C/zNpJDeuKVwU5
         Hjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=79kj0Hz7G1C0b9kzA6orIiebN/l1XiuJDZGgCwfBBpE=;
        b=Sr0njA8nOhE9Cds+MmbhyCIGM+GKO/ygJX6EAymfMEf60uukcS9swWnaa6VlV2Oc4R
         oenQIRD8dg47my2yFu5UT9pQnZXEkQYvEICv8/awv9yUbB0cugMsu1pnBpp8lNrO8jYg
         Z2CImgymhZNEyvngeyzW9Sy95NCAx4ZA68JlGbYquT5Zr5V74W1wkw84Las47xx1bD+1
         YZtzO2E7rDgFKYmPS7UDQtI6reyAgpv1NJ6yWnaWhqHN+zYaFAwEq7oggyvrpKix3xua
         Cw8NyxtDQ4wfBJ8o+5dkR/XzDLswKwazlagENpOQS2n7kJMjU7hf0wYda2FqCO5u8cNF
         nunA==
X-Gm-Message-State: AOAM532cE0RbwoJcyCBWadOxFS2S5rDiyLA8WG/iYwBJstqmq1xzj1an
        c1lJk1deRmCc5LaJSnCNYvyguw==
X-Google-Smtp-Source: ABdhPJx4qVUhNovVxRN0EE80bqxWGDGdzB+5JtHJO2Spcjd573wzmI0mzZWLaHLXhkkH6NYa6XI6PQ==
X-Received: by 2002:a05:6e02:1445:: with SMTP id p5mr6351513ilo.11.1634871901309;
        Thu, 21 Oct 2021 20:05:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m5sm3559540ild.45.2021.10.21.20.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 20:05:00 -0700 (PDT)
Date:   Thu, 21 Oct 2021 23:04:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        peff@peff.net
Subject: Re: [PATCH 01/11] midx.c: clean up chunkfile after reading the MIDX
Message-ID: <YXIqW1yiaJTS/8in@nand.local>
References: <cover.1634787555.git.me@ttaylorr.com>
 <30f6f23daf49814f479865eea5f9ee68de209d5f.1634787555.git.me@ttaylorr.com>
 <xmqqy26mmjz8.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy26mmjz8.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 21, 2021 at 09:16:27AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >  cleanup_fail:
> >  	free(m);
> >  	free(midx_name);
> > -	free(cf);
> > +	free_chunkfile(cf);
> >  	if (midx_map)
> >  		munmap(midx_map, midx_size);
> >  	if (0 <= fd)
>
> Not a fault of this patch, but I think the code is calling close()
> on an already closed file descriptor in cleanup_fail codepath, when
> "goto cleanup_fail" is reached after xmmap() returned, e.g. when
> oid_version() does not match hash_version, when we failed to read
> the ToC.
>
> Also, it is not clear why is it a dying offence if we do not find
> packnames chunk, but it is just a "pretend as if we do not have this
> midx file and everybody else is happy" when we failed to read the
> ToC.

Yep, I agree with you on both of those. I would be happier to see fewer
die()s deep within midx.c. I'll start a list for myself of some
potential future cleanups in this area that don't involve memory leaks.

My hunch is that there's enough subtlty here that we shouldn't tie the
two (fixing leaks, and other general issues/tidiness in the MIDX code)
together. So I'll keep track of the latter separately and address those
in future series.

Thanks,
Taylor
