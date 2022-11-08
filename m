Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06559C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 02:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbiKHCOa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 21:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiKHCO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 21:14:28 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47927205D5
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 18:14:28 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id o13so6825134ilq.6
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 18:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fb14d0CB4L3b1FVdmVh7UMtZveB61T20NBiwnUMkJ9w=;
        b=Z/ZaKLen9YictOHAFXAl56E8rGWAxzyyTyS1lcJKjbpBCADpysO+tPaRtQd63M9oT+
         gsH2baq09tEVYleUJxyES2sp9oFDyKGbHVrhc8/B/SHBEUWmjlIZhhC3XThQ9HxHG/d2
         nZR015/3pr4v8/G+otGl6G+qZoIQgn5/3mT45uj+sKMybF1UuHewWz73wcZF0NrL+zyI
         DhJ6ny5HrzRYHoWY5nEreDetvhm9m5tf6mg0NtUHw7XedDv4ryiD5kzKgByL9kUaep/Q
         3Kndsd+AnsE+6F1keCZi0b3E5fpg8Or+qAI0mwjfzZbNtz1NDzIDoHBS7PW5KYIn0Nf4
         XlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fb14d0CB4L3b1FVdmVh7UMtZveB61T20NBiwnUMkJ9w=;
        b=4NN00VB6XGQRuhkPrtinDwjs5uAhu5XWpARxH4LdVX1WaT0kkvL3CfyoUSwBdJRaC7
         QSGyu+qo5bmrRzXH0zK4/nMaXGRprQ7EfZbKWdemouydpKfN/mWX6ShH+6wSBSOuCT0q
         o3KK7BoAIAweRkMb2y2VIZzFEBVXeekqo3PAH5eYp4JzzTnQYvhZmUvCq8RVUfQ6RBDT
         ki+dcp7hLBWaLe4LcpuChV/auJAIoBorjjEMMeeZuk3PCrwMatrQH45Ea3YNIzpDJUmK
         ICA17j4T00eTQM4hFT9rwR8zOzkrR2p5Jj3rhrRyZ7wLRk8PGy8HgkqSRkY7rBjvbFSq
         V9Lw==
X-Gm-Message-State: ACrzQf0nfTEXPPjYW40voB8hAdPicTX5eit9mWyApOuKcvDiip+F9CfD
        XZbMptXFGsYcEU7+jIlRtevW4w==
X-Google-Smtp-Source: AMsMyM4INZ6DeqqracnfGywpMImZlTuux6cESzS25JMHRIGk/UrQi0G0h6CAz8yT9jDaRlUB3Qj3Xg==
X-Received: by 2002:a05:6e02:1ca6:b0:2ff:e76e:d914 with SMTP id x6-20020a056e021ca600b002ffe76ed914mr29966683ill.143.1667873667644;
        Mon, 07 Nov 2022 18:14:27 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w5-20020a056e021a6500b002f916f15625sm3404418ilv.23.2022.11.07.18.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 18:14:27 -0800 (PST)
Date:   Mon, 7 Nov 2022 21:14:26 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        man dog <dogman888888@gmail.com>
Subject: Re: [PATCH 1/3] line-log: free diff queue when processing non-merge
 commits
Message-ID: <Y2m7gielFOvTYbvi@nand.local>
References: <Y2BElOFGJ8JinYxC@nand.local>
 <20221102220142.574890-1-szeder.dev@gmail.com>
 <20221102220142.574890-2-szeder.dev@gmail.com>
 <Y2MJRRfwG7rSp6Ra@nand.local>
 <20221107151115.GA1951@szeder.dev>
 <221107.86r0yevkt5.gmgdl@evledraar.gmail.com>
 <20221107155721.GB1951@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221107155721.GB1951@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2022 at 04:57:21PM +0100, SZEDER Gábor wrote:
> On Mon, Nov 07, 2022 at 04:29:39PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >
> > On Mon, Nov 07 2022, SZEDER Gábor wrote:
> >
> > > On Wed, Nov 02, 2022 at 08:20:21PM -0400, Taylor Blau wrote:
> > >> > +void diff_free_queue(struct diff_queue_struct *q)
> > >> > +{
> > >> > +	for (int i = 0; i < q->nr; i++)
> > >> > +		diff_free_filepair(q->queue[i]);
> > >> > +	free(q->queue);
> > >> > +}
> > >>
> > >> Though I wonder, should diff_free_queue() be a noop when q is NULL? The
> > >> caller in process_ranges_ordinary_commit() doesn't care, of course,
> > >> since q is always non-NULL there.
> > >>
> > >> But if we're making it part of the diff API, we should probably err on
> > >> the side of flexibility.
> > >
> > > On one hand, strbuf_reset(), string_list_clear(), or strvec_clear()
> > > would all segfault on a NULL strbuf, string_list, or strvec pointer.
> >
> > But the reason we do that is because those APIs will always ensure that
> > the struct is never in an inconsistent state, as opposed to the
> > destructor you're adding here.
>
> Taylor's suggestion quoted above is not about the internal state of
> the diff queue, but about a NULL pointer passed to diff_free_queue().

I think your perspective that strbuf_reset(), string_list_clear(), etc.
all segfault on a NULL argument is extremely reasonable. Let's start
merging this down.

Thanks,
Taylor
