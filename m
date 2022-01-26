Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461C0C5DF62
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 20:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiAZUXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 15:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiAZUXM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 15:23:12 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C3CC06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 12:23:12 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id s1so701158ilj.7
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 12:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Re4i1sZ9p9MImKSFNKdSAEQ89iZ7XDThNwXOhpqhKH4=;
        b=t9DHw5Y7oxQtz1jxi3EevFwjHPwrEG0llTgml6F5xDqbs4VS9WxinCgJj0dCjRxGAa
         U7gvIEAWBrBzKIt9LU2KSzgU3dtvwLnbEtpgYnJU3GWB0uRmLc/rm/b2BlFug/nZiVit
         T4cGdDDOquXfQf9zOqwAW3BX5SI2meODzPN4cveItk2Em/WiOikIorSU7cTef93NhMZk
         eyTY50WXpefYW1SDl3l5RL9YTEO7tx09xDkEC4bzarQ3YI4uxhZcvWTUH9Gpw4bwivYd
         2jYAiveZ5HUsho/5ROyPshVzq/yFIFQxYSjsbqlZDvqe5UfIeEU11rHblW8Lz5eeL5Jw
         ov2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Re4i1sZ9p9MImKSFNKdSAEQ89iZ7XDThNwXOhpqhKH4=;
        b=5unfycbbGPNLS0CYdzJP9KeTbFWzPfkruFGpSZiJxyIh8czxMnXbhE5s8uU3BOKQQI
         mUJHf/DJKEBrz8IP687jEnUihJ47azmroZE8lSDFKsP/gs7FdQw6DGAe6hVZYORnaM0m
         Wx5Ou/J0O0UFBF7VvWug8q9ypzJrded+KYHco8m6hxNuZLdGHz/lL8S5dvUt7fRLGyJG
         B6cYWwYk1siqw/2ZfSROxH5eBHnawLNM1kojHx/busML5MfCXjoG1rktIOcXhDd5XcpS
         VP5D99HEQJKjPPCLfju+PP95r2Je/sLyoRHPzd39Owxio29KhvQcAwfVS8y5XmNe5rAH
         EWzw==
X-Gm-Message-State: AOAM533/agNqo8mqdozU/o45HLCAOyHJLv58RMplU9tKstyRzXvM7YRX
        e6QUCnxSj4gEeKUDRrWv7IyYcg==
X-Google-Smtp-Source: ABdhPJyLwomOCF7lWqvd41LJQNqAX8BelShlX1tij659pyXIkcx3Zp5PWq4hGQC9GYEai68t1Uxt9w==
X-Received: by 2002:a92:cacd:: with SMTP id m13mr534373ilq.125.1643228591418;
        Wed, 26 Jan 2022 12:23:11 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k8sm3489784ilo.45.2022.01.26.12.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 12:23:11 -0800 (PST)
Date:   Wed, 26 Jan 2022 15:23:10 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 8/9] midx: read `RIDX` chunk when present
Message-ID: <YfGtruutEDPZlvTE@nand.local>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1643150456.git.me@ttaylorr.com>
 <94563cf038722852d801bd0a8e744a569799f354.1643150456.git.me@ttaylorr.com>
 <220126.86lez2edae.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220126.86lez2edae.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 26, 2022 at 04:10:08PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
> On Tue, Jan 25 2022, Taylor Blau wrote:
>
> > @@ -298,9 +298,26 @@ int load_midx_revindex(struct multi_pack_index *m)
> >  {
> >  	struct strbuf revindex_name = STRBUF_INIT;
> >  	int ret;
> > +
>
> nit: good addition for style in general, but a stay whitespace change in
> an otherwise narrowly focused patch.
>
> >  	if (m->revindex_data)
> >  		return 0;
> >
> > +	if (m->chunk_revindex) {
> > +		/*
> > +		 * If the MIDX `m` has a `RIDX` chunk, then use its contents for
> > +		 * the reverse index instead of trying to load a separate `.rev`
> > +		 * file.
> > +		 *
> > +		 * Note that we do *not* set `m->revindex_map` here, since we do
> > +		 * not want to accidentally call munmap() in the middle of the
> > +		 * MIDX.
> > +		 */
> > +		trace2_data_string("load_midx_revindex", the_repository,
> > +				   "source", "midx");
> > +		m->revindex_data = (const uint32_t *)m->chunk_revindex;
> > +		return 0;
> > +	}
> > +
> >  	trace2_data_string("load_midx_revindex", the_repository,
> >  			   "source", "rev");
>
> This trace2_data_string() is repeated with just "midx" v.s. "rev"
> parameters.
>
> I was going to suggest that maybe we should add a "goto" here, since
> you're trying to juggle the early return and logging this.

Right; that matches how we handle the two cases separately here. I'm not
sure exactly what you're suggesting with by adding a "goto" label; I
think it would make things more awkward rather than more readable, but
it's certainly possible that I'm missing something.

> But wouldn't this be both simpler and give you better logging if it was
> the usual region start/end pattern, with just the "data string"
> in-between?
>
> Then you'd get both performance data on the index loading, and the
> source.
>
> Or maybe it's overkill in this case, I don't know...

I think it's overkill; in the "embedded" case (which we expect to be
pretty common in the future) we're not really measuring anything except
for the pointer assignment.

We *could* instrument pack-revindex.c::load_revindex_from_disk(), but I
think that's a separate issue from this one.

Thanks,
Taylor
