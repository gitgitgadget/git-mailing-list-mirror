Return-Path: <SRS0=aDBb=CX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AE6C433E2
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 20:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FE4B21741
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 20:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2RF+/WI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgINUb6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 16:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbgINUbF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 16:31:05 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C97C06178A
        for <git@vger.kernel.org>; Mon, 14 Sep 2020 13:31:05 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c18so1225976qtw.5
        for <git@vger.kernel.org>; Mon, 14 Sep 2020 13:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JRMKcM+ST8VdPsGg3GPtilZE1dCCsImQ9f0qSaQXhko=;
        b=X2RF+/WIvQc/CxnpBajoakDJzqVEeAnnEvXTuFV2slvNylbJNCc+rGuVHYHxNcFW/R
         /j5Ohom8RbGGPu8BYN4dksXhUeWE8avg3uPqP526Sque9XYfRUrBihC20zqqQy2Zrk78
         EDkMY7N8nQ46ZIWhRTX4P7nF3C7p0eRuqsd+vsO3Ou1sc1aJU9kjQLjL8KUdT1B/knKn
         81zdPSWQUKC3fBERyZSjtqergLrSSXwoPuQOJsh9gdpVOlAqoR6G4tk8aNfVp8vGitsC
         cN5N0mNfO4o72ueiI1n60q2gehQDXf8fh2Pni1GJbBotKLGkLuQ/MgHoqUnTGlO+3BXK
         Wb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JRMKcM+ST8VdPsGg3GPtilZE1dCCsImQ9f0qSaQXhko=;
        b=Kiz1s21rOzft++l9RgqWi5XmXtr4UXyr3TcNB49kGUbJd+M5xzgADoy38f9l80UN0c
         s+KeBoVrK7v92Nzo2RboPO2O/ujqvOoMzSIpeygl8ry/wGlftQOg6Dst9Q0PrxocODix
         8tc3xOE5Nm473k7Q6tu6iwWtCV/UYTZiM0Swh/biegtXhEUa6rJiuSjxiTgo0crSEkYa
         qeYiGMiHkbCwVcQ9Nw64YUejL9wq98TvCUFsUKSzullexhlbS+67a7Gvyje+vMFYykEv
         ITVWtSkuH2R+3Cx89b2zjiQLH7KZJsSpyW6aga7F5lIy5pVDS/9iZTY1wzeSd+PXnEPl
         i4tA==
X-Gm-Message-State: AOAM531nvWoZADsUGEjjz9yFMca656c8XQlfzFQ1dqHyazufv1qPihL0
        z1XJKnD1obfqY9SVQmflBIFFQxeFOXxxGg==
X-Google-Smtp-Source: ABdhPJzeZytfdA06CFZnRcMx6fz7ipm4ZimZXeauQCcVahfigTuyOUZSqnB9LWdcussqs6wG8F1aGw==
X-Received: by 2002:ac8:fb3:: with SMTP id b48mr15530864qtk.16.1600115464312;
        Mon, 14 Sep 2020 13:31:04 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:6091:313a:250c:77ff? ([2600:1700:e72:80a0:6091:313a:250c:77ff])
        by smtp.gmail.com with ESMTPSA id f13sm15279688qko.122.2020.09.14.13.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 13:31:03 -0700 (PDT)
Subject: Re: [PATCH 12/12] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
To:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, szeder.dev@gmail.com,
        Jeff King <peff@peff.net>
References: <cover.1599664389.git.me@ttaylorr.com>
 <4ff11cec37d17d788a3ee076b7c3de1c873a5fbd.1599664389.git.me@ttaylorr.com>
 <20200911175216.GA2693949@coredump.intra.peff.net>
 <20200911185934.GA2871@xor.lan> <20200911192555.GA3612@nand.local>
 <20200914201258.GA12431@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <134d64a0-abb6-bdc9-2c05-7aded01a906a@gmail.com>
Date:   Mon, 14 Sep 2020 16:31:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <20200914201258.GA12431@nand.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/14/2020 4:12 PM, Taylor Blau wrote:
> On Fri, Sep 11, 2020 at 03:25:55PM -0400, Taylor Blau wrote:
>> On Fri, Sep 11, 2020 at 02:59:34PM -0400, Taylor Blau wrote:
>>> On Fri, Sep 11, 2020 at 01:52:16PM -0400, Jeff King wrote:
>>>> On Wed, Sep 09, 2020 at 11:24:00AM -0400, Taylor Blau wrote:
>>>>> +With the `--max-new-filters=<n>` option, generate at most `n` new Bloom
>>>>> +filters (if `--changed-paths` is specified). If `n` is `-1`, no limit is
>>>>> +enforced. Commits whose filters are not calculated are stored as a
>>>>> +length zero Bloom filter, and their bit is marked in the `BFXL` chunk.
>>>>> +Overrides the `commitGraph.maxNewFilters` configuration.
>>>>
>>>> The BFXL chunk doesn't exist anymore in this iteration, right?
>>>
>>> Ack; I'll have to drop that.
>>
>> Junio, I know that I've already sent one replacement patch. If you don't
>> mind, here's another (and if you do mind, I'm happy to re-roll the
>> series).
> 
> Just kidding. Let's use *this* version which fixes a bug reading the
> commitGraph.maxNewFilters configuration. At this point, the
> fix-ups are:
> 
>   - This patch (attached below the scisors) instead of 12/12, and
> 
>   - This [1] patch instead of 10/12.
> 
> [1]: https://lore.kernel.org/git/20200910154516.GA32117@nand.local/
> 
> Let me know if you'd rather have a full re-roll.

It's getting a bit difficult to track all of these "use this instead"
patches. But, I'm not the one applying them, so maybe that's not actually
a problem.

You might need a re-roll, anyway, as I have a few comments here:

> --- 8< ---
> 
> Subject: [PATCH] builtin/commit-graph.c: introduce '--max-new-filters=<n>'

You also introduce commitGraph.maxNewFitlers here, which is not
mentioned in the commit message anywhere. In fact, it might be
good to include it as a separate patch so its implementation and
tests can be isolated from the command-line functionality.

> +length zero Bloom filter. Overrides the `commitGraph.maxNewFilters`
> +configuration.

We have found it valuable to demonstrate these overrides in tests.
Let's inspect your tests for this.

> +test_bloom_filters_computed () {
> +	commit_graph_args=$1
> +	rm -f "$TRASH_DIRECTORY/trace.event" &&
> +	GIT_TRACE2_EVENT="$TRASH_DIRECTORY/trace.event" git commit-graph write \
> +		$commit_graph_args &&
> +	grep "\"filter_not_computed\":$2" "$TRASH_DIRECTORY/trace.event" &&
> +	grep "\"filter_trunc_large\":$3" "$TRASH_DIRECTORY/trace.event" &&
> +	grep "\"filter_computed\":$4" "$TRASH_DIRECTORY/trace.event"
> +}

If the arguments were moved to the last parameter, then we could do a few
interesting things here.

test_bloom_filters_computed () {
	NOT_COMPUTED="\"filter_not_computed\":$1" &&
	shift &&
	TRUNCATED="\"filter_trunc_large\":$1" &&
	shift &&
	COMPUTED="\"filter_computed\":$1" &&
	shift &&
	rm -f "$TRASH_DIRECTORY/trace.event" &&
	GIT_TRACE2_EVENT="$TRASH_DIRECTORY/trace.event" git commit-graph write $@ &&
	grep "$NOT_COMPUTED" "$TRASH_DIRECTORY/trace.event" &&
	grep "$TRUNCATED" "$TRASH_DIRECTORY/trace.event" &&
	grep "$COMPUTED" "$TRASH_DIRECTORY/trace.event"
}


(I have not tested this script. It might need some work.)
This would make your callers a bit cleaner-looking, for example:

test_expect_success 'Bloom generation is limited by --max-new-filters' '
	(
		cd limits &&
		test_commit c2 filter &&
		test_commit c3 filter &&
		test_commit c4 no-filter &&
		test_bloom_filters_computed 3 0 2 \
			--reachable --changed-paths --split=replace --max-new-filters=2
	)
'

At least, this looks nicer to me.

> +test_expect_success 'Bloom generation backfills previously-skipped filters' '
> +	# Check specifying commitGraph.maxNewFilters over "git config" works.
> +	test_config -C limits commitGraph.maxNewFilters 1 &&
> +	(
> +		cd limits &&
> +		test_bloom_filters_computed "--reachable --changed-paths --split=replace" \
> +			4 0 1
> +	)
> +'

Adding a case for `commitGraph.maxNewFilters=1` and `--max-new-filters=2` might
be interesting for the override rules.

> +
> +test_expect_success 'Bloom generation backfills empty commits' '
> +	git init empty &&
> +	test_when_finished "rm -fr empty" &&
> +	(
> +		cd empty &&
> +		for i in $(test_seq 1 6)
> +		do
> +			git commit --allow-empty -m "$i"
> +		done &&
> +
> +		# Generate Bloom filters for empty commits 1-6, two at a time.
> +		test_bloom_filters_computed "--reachable --changed-paths --max-new-filters=2" \
> +			4 0 2 &&
> +		test_bloom_filters_computed "--reachable --changed-paths --max-new-filters=2" \
> +			4 0 2 &&
> +		test_bloom_filters_computed "--reachable --changed-paths --max-new-filters=2" \
> +			4 0 2 &&

I'm concerned that the max-new-filters limit (2) is a divisor
of the full number of commits (6). It might be good to add one
more commit here and test again with a limit of 2. That would
handle both "equal to limit" and "less than limit" cases.

> +		# Finally, make sure that once all commits have filters, that
> +		# none are subsequently recomputed.
> +		test_bloom_filters_computed "--reachable --changed-paths --max-new-filters=2" \
> +			6 0 0
> +	)
> +'

Thanks,
-Stolee

