Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4941EC433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 21:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C57764DEB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 21:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhBOVqB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 16:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhBOVp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 16:45:58 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BC4C061574
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 13:45:17 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id z32so5810370qtd.8
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 13:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JC3OuP65G+bAeq7vEGvw+fIEfqm0Ww4hqHlOT9GQe0I=;
        b=gc0lddTnoX4J6niTzEovyAuYweEar+vzVcaKky07NJAnkXTKHqiR1GLv7XU2gaGv8y
         bVg2c7tFytYrFKIDpaOGGeDocneOAewcGMSwmad6ZqKsxGSVXplutPMmUUp1QYSREIjy
         5LTXLY5YfYVNXzFqNCeF3LYljBKI5fiR2kYtw7RLzhtmmEOgZVibI3Yxf+LT9vP89LGR
         qmfXK/SBDlxAndBnYDzRmT3yAWwAQcgyp3gW5wiMrnbK91UrfwQGEhX060OQV0nlEqxE
         PETwHQkZ/I3PaimzUY8Z3rMUxQmZGi4+jUWWFKCVF5s7ev5U1dP/IUQuVlHyVh8ZG0oe
         Mqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JC3OuP65G+bAeq7vEGvw+fIEfqm0Ww4hqHlOT9GQe0I=;
        b=Cf5T+EsToOdvA03ZCj9rwiHbKj0iHH29HfV8NlwqfPHwxbc3VROfEwRZU4pGMeNu6Q
         tC1txLBaak7m2EEsRo/k4wIC9IMQUyPB5wW2UWG/3nWSL4E0coWzZi0XOnlulJ/QJX62
         cMg8NXKS7Oit/7O10Ei+vJpH2k7Oy1HLODBQZg3Y2msgP1Otdmkq/C3nA3O4efa+pnrK
         OX4H4EkSs1GZtyZAO+hM1ox2+xZF2ad0XkLICLIoMLkRsMd0r7NqOmNAc5zSTkWT9yoO
         t1O2yXaxr+ON0i2mH9vLVQOWK/4uK+67FlJBRzO4Ik002oyagqa5qRtxyTxDVFramv40
         EXow==
X-Gm-Message-State: AOAM530G5ulxIxROIp++/jnskHV0jITcrcCmG3KvnAeA5zuBlKT7FNsK
        +2s1HAvzQjjbLexbjXpI3VbInA==
X-Google-Smtp-Source: ABdhPJwNdnKDPXwYLqIxhPPq3JA5gq/W4YzjalKQW2nXikuEtQA4moP4f9/6QnzvnM6dko1uicQR0A==
X-Received: by 2002:ac8:6d3b:: with SMTP id r27mr16283278qtu.21.1613425516929;
        Mon, 15 Feb 2021 13:45:16 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:c1ff:146e:b5:8cba])
        by smtp.gmail.com with ESMTPSA id e4sm11906873qtp.48.2021.02.15.13.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 13:45:16 -0800 (PST)
Date:   Mon, 15 Feb 2021 16:45:14 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        szeder.dev@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 2/4] builtin/multi-pack-index.c: don't handle
 'progress' separately
Message-ID: <YCrrauGOiVkpM2fP@nand.local>
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <cover.1613422804.git.me@ttaylorr.com>
 <abcc7fb7312b349562fe6d13e2250496e107c9ed.1613422804.git.me@ttaylorr.com>
 <87a6s5au4b.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a6s5au4b.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 15, 2021 at 10:39:16PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
> On Mon, Feb 15 2021, Taylor Blau wrote:
>
> > @@ -31,15 +30,14 @@ int cmd_multi_pack_index(int argc, const char **argv,
> >
> >  	git_config(git_default_config, NULL);
> >
> > -	opts.progress = isatty(2);
> > +	if (isatty(2))
> > +		opts.flags |= MIDX_PROGRESS;
> >  	argc = parse_options(argc, argv, prefix,
> >  			     builtin_multi_pack_index_options,
> >  			     builtin_multi_pack_index_usage, 0);
> >
> >  	if (!opts.object_dir)
> >  		opts.object_dir = get_object_directory();
> > -	if (opts.progress)
> > -		opts.flags |= MIDX_PROGRESS;
>
>
> Funnily enough we could also just do:
>
>     opts.flags = isatty(2);
>
> Since there's a grand total of one flag it knows about, and
> MIDX_PROGRESS is defined as 1.

:-). I have a handful of branches that add some new flags (including the
original series I sent down-thread), so I'm not sure that I'm in favor
of this (admittedly cute) hack.

> Not the problem of this series really, just a nit: In efbc3aee08d (midx:
> add MIDX_PROGRESS flag, 2019-10-21) we added this flag, and around the
> same time the similar commit-graph code got refactored to have an enum
> of flags in 5af80394521 (commit-graph: collapse parameters into flags,
> 2019-06-12).

Hmm. I don't really have a strong opinion either way. I'd like to avoid
steering too far away from my original goal of multi-pack reverse
indexes, at least for now...

> I prefer the commit-graph way of having a clean boundary between the two
> a bit more, and then just setting a flag based on an OPT_BOOL...

Me too. But if you can part ways with it, it cuts down on the code
duplication (since callers in the sub-commands don't have to set that
bit on the flags themselves).

OTOH, we could keep half of this change and store the flags in the
options structure in addition to the progress field, then set the
appropriate bit in "flags" in cmd_builtin_multi_pack_index().

But I think at that point you're already sharing the flags field
everywhere, so you're just as well off to have something like what's
written in this patch here.

I don't have strong feelings either way.

Thanks,
Taylor
