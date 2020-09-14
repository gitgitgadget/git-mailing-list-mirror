Return-Path: <SRS0=aDBb=CX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7F3C43461
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 20:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A64D921741
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 20:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="g7+6qT9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgINUhG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 16:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgINUhD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 16:37:03 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8BFC06174A
        for <git@vger.kernel.org>; Mon, 14 Sep 2020 13:37:03 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id ef16so538639qvb.8
        for <git@vger.kernel.org>; Mon, 14 Sep 2020 13:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZDWhizkTH4SNEgpOBIwjAsZvqYbIHwZueShOWjR5ikQ=;
        b=g7+6qT9w3TU+EZD/MjUcW0jhTqWWjgTmgSmg70pp6/BrdgLuLzpYcXiqeIppsFu8Pc
         1wI1syutvITWly2thnhRAG7usvX/vNjMjuAK9Zr/iD5vKPerykxdOx0Pi6OzFHIoi9H+
         W1i7pefK9jMLq6/dVGZzY/q5qAwe8NB91mL9CPO59zgOGLtwuuFNOnCRMwC1wl23WRr8
         BzsqydthVcct4MtXsW74+zIytE/zfS/L4U07lyVgr7Y0EsHVYIUlbLemVOMxAUbh8bWB
         T6nUoX5pUkzDbpPxXP24uVtsRcjrxYKlnVEzDgg5+iOkisD7k+yUoKgtVkwxtCuSLHHb
         sgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZDWhizkTH4SNEgpOBIwjAsZvqYbIHwZueShOWjR5ikQ=;
        b=YiA69onqAYE00ptX5Fe1K879VyWvo3K2Pd0xubuen0oIYhgZs3Nszu9EpEjBEa4jsU
         BhEoWUF1eenoeHKnMQcoD4AU9tOejRLbYvGqpErEhzxh5ELM4BYp1O/nDdqB4krvHf+v
         YzEgCRO/CUj5T21ZP/NlNwI5KRxTh2+OyS9sKdb2aGcQZL4gjRndyEalplhaLDgAX/ZQ
         z3pvFV6HoDVG8CbpbUatfuFnYNw5MUgfxTE4Ap2cFKuHwqaWZeN58w4Fr/dkWmpZDpkU
         rX2p/Gw2tjQHg94i5/hQYRMZIlAE62vEc95Dbrh++2NM+/cjYM01AV+fXl4Go1mX2cd7
         bf6w==
X-Gm-Message-State: AOAM533VOcGL6psfTX2D5kt6gq5HJ/56FTDouheScWBiMhC48GQsS/Pb
        jSRpLkbTBOZNgb16t7UAEXFMaQ==
X-Google-Smtp-Source: ABdhPJz2UE3QrNx7Vgx9LBeSEwdTsHmRui3IB64LBAWVky3ltA4nmLnJG/6WLAHnXs4aW3rSv6ha8w==
X-Received: by 2002:a0c:d682:: with SMTP id k2mr15379331qvi.27.1600115822316;
        Mon, 14 Sep 2020 13:37:02 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:bc05:1f7d:98e:e354])
        by smtp.gmail.com with ESMTPSA id t140sm15650187qke.125.2020.09.14.13.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:37:01 -0700 (PDT)
Date:   Mon, 14 Sep 2020 16:36:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        dstolee@microsoft.com, szeder.dev@gmail.com,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 12/12] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
Message-ID: <20200914203659.GA12855@nand.local>
References: <cover.1599664389.git.me@ttaylorr.com>
 <4ff11cec37d17d788a3ee076b7c3de1c873a5fbd.1599664389.git.me@ttaylorr.com>
 <20200911175216.GA2693949@coredump.intra.peff.net>
 <20200911185934.GA2871@xor.lan>
 <20200911192555.GA3612@nand.local>
 <20200914201258.GA12431@nand.local>
 <134d64a0-abb6-bdc9-2c05-7aded01a906a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <134d64a0-abb6-bdc9-2c05-7aded01a906a@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 14, 2020 at 04:31:03PM -0400, Derrick Stolee wrote:
> On 9/14/2020 4:12 PM, Taylor Blau wrote:
> >   - This patch (attached below the scisors) instead of 12/12, and
> >
> >   - This [1] patch instead of 10/12.
> >
> > [1]: https://lore.kernel.org/git/20200910154516.GA32117@nand.local/
> >
> > Let me know if you'd rather have a full re-roll.
>
> It's getting a bit difficult to track all of these "use this instead"
> patches. But, I'm not the one applying them, so maybe that's not actually
> a problem.

The above list is the only changes that I've made, so I'm happy if Junio
wants to follow what's written there, but I'm equally happy to send a
new reroll.

> You might need a re-roll, anyway, as I have a few comments here:

Let's take a look...

> You also introduce commitGraph.maxNewFitlers here, which is not
> mentioned in the commit message anywhere. In fact, it might be
> good to include it as a separate patch so its implementation and
> tests can be isolated from the command-line functionality.

I could go either way on both of these, to be honest. I don't think
there's anything interesting that isn't said in the documentation
changes introduced by that commit that is worth convering there, so I'm
not sue 'commitGraph.maxNewFilters' needs the additional call-out.

> > +length zero Bloom filter. Overrides the `commitGraph.maxNewFilters`
> > +configuration.
>
> We have found it valuable to demonstrate these overrides in tests.
> Let's inspect your tests for this.
>
> > +test_bloom_filters_computed () {
> > +	commit_graph_args=$1
> > +	rm -f "$TRASH_DIRECTORY/trace.event" &&
> > +	GIT_TRACE2_EVENT="$TRASH_DIRECTORY/trace.event" git commit-graph write \
> > +		$commit_graph_args &&
> > +	grep "\"filter_not_computed\":$2" "$TRASH_DIRECTORY/trace.event" &&
> > +	grep "\"filter_trunc_large\":$3" "$TRASH_DIRECTORY/trace.event" &&
> > +	grep "\"filter_computed\":$4" "$TRASH_DIRECTORY/trace.event"
> > +}
>
> If the arguments were moved to the last parameter, then we could do a few
> interesting things here.
>
> test_bloom_filters_computed () {
> 	NOT_COMPUTED="\"filter_not_computed\":$1" &&
> 	shift &&
> 	TRUNCATED="\"filter_trunc_large\":$1" &&
> 	shift &&
> 	COMPUTED="\"filter_computed\":$1" &&
> 	shift &&
> 	rm -f "$TRASH_DIRECTORY/trace.event" &&
> 	GIT_TRACE2_EVENT="$TRASH_DIRECTORY/trace.event" git commit-graph write $@ &&
> 	grep "$NOT_COMPUTED" "$TRASH_DIRECTORY/trace.event" &&
> 	grep "$TRUNCATED" "$TRASH_DIRECTORY/trace.event" &&
> 	grep "$COMPUTED" "$TRASH_DIRECTORY/trace.event"
> }
>
>
> (I have not tested this script. It might need some work.)
> This would make your callers a bit cleaner-looking, for example:
>
> test_expect_success 'Bloom generation is limited by --max-new-filters' '
> 	(
> 		cd limits &&
> 		test_commit c2 filter &&
> 		test_commit c3 filter &&
> 		test_commit c4 no-filter &&
> 		test_bloom_filters_computed 3 0 2 \
> 			--reachable --changed-paths --split=replace --max-new-filters=2
> 	)
> '
>
> At least, this looks nicer to me.

Yeah, but I think we're still stuck with the test_config below unless
you write "git $@" instead of "git commit-graph write $@". I don't think
that I have strong feelings about this unless you do.

> > +test_expect_success 'Bloom generation backfills previously-skipped filters' '
> > +	# Check specifying commitGraph.maxNewFilters over "git config" works.
> > +	test_config -C limits commitGraph.maxNewFilters 1 &&
> > +	(
> > +		cd limits &&
> > +		test_bloom_filters_computed "--reachable --changed-paths --split=replace" \
> > +			4 0 1
> > +	)
> > +'
>
> Adding a case for `commitGraph.maxNewFilters=1` and `--max-new-filters=2` might
> be interesting for the override rules.

Potentially. I'm equally happy to do it in a follow-up series. I worry
slightly about adding too many test-cases for somewhat trivial behavior.

> > +
> > +test_expect_success 'Bloom generation backfills empty commits' '
> > +	git init empty &&
> > +	test_when_finished "rm -fr empty" &&
> > +	(
> > +		cd empty &&
> > +		for i in $(test_seq 1 6)
> > +		do
> > +			git commit --allow-empty -m "$i"
> > +		done &&
> > +
> > +		# Generate Bloom filters for empty commits 1-6, two at a time.
> > +		test_bloom_filters_computed "--reachable --changed-paths --max-new-filters=2" \
> > +			4 0 2 &&
> > +		test_bloom_filters_computed "--reachable --changed-paths --max-new-filters=2" \
> > +			4 0 2 &&
> > +		test_bloom_filters_computed "--reachable --changed-paths --max-new-filters=2" \
> > +			4 0 2 &&
>
> I'm concerned that the max-new-filters limit (2) is a divisor
> of the full number of commits (6). It might be good to add one
> more commit here and test again with a limit of 2. That would
> handle both "equal to limit" and "less than limit" cases.

That case is already covered in the test two above this one ("Bloom
generation is limited by --max-new-filters").

> Thanks,
> -Stolee

Thanks,
Taylor
