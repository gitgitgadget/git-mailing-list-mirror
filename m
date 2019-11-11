Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 597F51F454
	for <e@80x24.org>; Mon, 11 Nov 2019 13:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfKKNmw (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 08:42:52 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36503 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfKKNmv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 08:42:51 -0500
Received: by mail-qk1-f194.google.com with SMTP id d13so11167923qko.3
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 05:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/WpilanZsS88nbWFy/JmL4We0kxwh7d7EjarrTNNX2M=;
        b=pDyg/i+4sdiOzZeyOSN7tSgYp7fp0VyJSGcLJMCOMQ9GQGs1FUp9CWcRm1ARjQ6DwN
         rdGc+Z/FY+64NHxx3J9aJJlCS365V8tys0Y3XdUy7SVbML7qowinBsDB+pbN4JIN2qix
         Za8bjPNYpq/p/PzdBVD/viVFJKi4dg0wwsoydwn9QFJEQbIEr8afdoxPaFr4GAKFNOhP
         lsaO8ydDaRobDan85kwpNaN7FxZE2ieC7ONQ/3A/5K/fCF/jKty66Wmom3fwfP1Mdemz
         ngZlp2rvookPFQVSNBS8/Z7IazNn6WvMtwsCxgd3iQwILK/3hcUE0zdLw79cKWZeW9MM
         WwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/WpilanZsS88nbWFy/JmL4We0kxwh7d7EjarrTNNX2M=;
        b=DnbJzzKy6utG+Q9v4Uhy0FRfAbzqRA6FD3pc7rFlDgr79YEn+hYTGAZ5R5Mmbeks9k
         Qruu3Sy3kihzaWu4ENfZOoBrKd6NxGwtzttDHlwQT0YLj8YbNBQKSEIeet9GeLJwCubN
         GJmOMNJ9KKo7RODRjgfZPblBU0vAo6IMThljB9Y2/Wm2xuF5kCIIJo3KS5HuH/kRTuLh
         GBLmHGRq3LpeiM6auzYG1yBdS4hZqj7hjJ9ufQkIJtn4muYolnoZCn3W24v6kBOI/uqx
         jHHfW4jKuzjfV/PXwaiXkyceltn2dgy+XrPuiv6ZhOX1hh0SZSiEdu31CqIzAVyF1v/S
         +YMg==
X-Gm-Message-State: APjAAAW31SxOJYPbwCDZa53U+fm2DWu4IilPy+EadpyK/YuVOTQAWt9B
        C+jEQfDyKf5/e+tbczK7Bs0=
X-Google-Smtp-Source: APXvYqxZ2w+uMSl+Q+duIHnnD6TpYRfx1w9ay4fQQ3U3E7dPUjfiLLSfav1WrK26XVAjrXQXU5iXOw==
X-Received: by 2002:a37:ba44:: with SMTP id k65mr10674494qkf.169.1573479770132;
        Mon, 11 Nov 2019 05:42:50 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:b46a:8c72:ec90:8e0a? ([2001:4898:a800:1010:65a0:8c72:ec90:8e0a])
        by smtp.gmail.com with ESMTPSA id g11sm3584203qkm.82.2019.11.11.05.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 05:42:49 -0800 (PST)
Subject: Re: [PATCH] pack-objects: avoid pointless oe_map_new_pack() calls
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20191111111249.GA31169@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <01605e2d-5ea7-037d-b25f-3774b88d059d@gmail.com>
Date:   Mon, 11 Nov 2019 08:42:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <20191111111249.GA31169@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/11/2019 6:12 AM, Jeff King wrote:
> This patch fixes an extreme slowdown in pack-objects when you have more
> than 1023 packs. See below for numbers.
> 
> Since 43fa44fa3b (pack-objects: move in_pack out of struct object_entry,
> 2018-04-14), we use a complicated system to save some per-object memory.
> 
> Each object_entry structs gets a 10-bit field to store the index of the
> pack it's in. We map those indices into pointers using
> packing_data->in_pack_by_idx, which we initialize at the start of the
> program. If we have 2^10 or more packs, then we instead create an array
> of pack pointers, one per object. This is packing_data->in_pack.
> 
> So far so good. But there's one other tricky case: if a new pack arrives
> after we've initialized in_pack_by_idx, it won't have an index yet. We
> solve that by calling oe_map_new_pack(), which just switches on the fly
> to the less-optimal in_pack mechanism, allocating the array and
> back-filling it for already-seen objects.
> 
> But that logic kicks in even when we've switched to it already (whether
> because we really did see a new pack, or because we had too many packs
> in the first place). The result doesn't produce a wrong outcome, but
> it's very slow. What happens is this:
> 
>   - imagine you have a repo with 500k objects and 2000 packs that you
>     want to repack.
> 
>   - before looking at any objects, we call prepare_in_pack_by_idx(). It
>     starts allocating an index for each pack. On the 1024th pack, it
>     sees there are too many, so it bails, leaving in_pack_by_idx as
>     NULL.
> 
>   - while actually adding objects to the packing list, we call
>     oe_set_in_pack(), which checks whether the pack already has an
>     index. If it's one of the packs after the first 1023, then it
>     doesn't have one, and we'll call oe_map_new_pack().
> 
>     But there's no useful work for that function to do. We're already
>     using in_pack, so it just uselessly walks over the complete list of
>     objects, trying to backfill in_pack.
> 
>     And we end up doing this for almost 1000 packs (each of which may be
>     triggered by more than one object). And each time it triggers, we
>     may iterate over up to 500k objects. So in the absolute worst case,
>     this is quadratic in the number of objects.

Quadratic is bad!

> The solution is simple: we don't need to bother checking whether the
> pack has an index if we've already converted to using in_pack, since by
> definition we're not going to use it. So we can just push the "does the
> pack have a valid index" check down into that half of the conditional,
> where we know we're going to use it.
> 
> The current test in p5303 sadly doesn't notice this problem, since it
> maxes out at 1000 packs. If we add a new test to it at 2000 packs, it
> does show the improvement:
> 
>   Test                      HEAD^               HEAD
>   ----------------------------------------------------------------------
>   5303.12: repack (2000)    26.72(39.68+0.67)   15.70(28.70+0.66) -41.2%

And these numbers don't really show a quadratic improvement, probably due
to the test itself needing to do the work to create 2000 packs.

> However, these many-pack test cases are rather expensive to run, so
> adding larger and larger numbers isn't appealing. Instead, we can show
> it off more easily by using GIT_TEST_FULL_IN_PACK_ARRAY, which forces us
> into the absolute worst case: no pack has an index, so we'll trigger
> oe_map_new_pack() pointlessly for every single object, making it truly
> quadratic.
> 
> Here are the numbers (on git.git) with the included change to p5303:
> 
>   Test                      HEAD^               HEAD
>   ----------------------------------------------------------------------
>   5303.3: rev-list (1)      2.05(1.98+0.06)     2.06(1.99+0.06) +0.5%
>   5303.4: repack (1)        33.45(33.46+0.19)   2.75(2.73+0.22) -91.8%
>   5303.6: rev-list (50)     2.07(2.01+0.06)     2.06(2.01+0.05) -0.5%
>   5303.7: repack (50)       34.21(35.18+0.16)   3.49(4.50+0.12) -89.8%
>   5303.9: rev-list (1000)   2.87(2.78+0.08)     2.88(2.80+0.07) +0.3%
>   5303.10: repack (1000)    41.26(51.30+0.47)   10.75(20.75+0.44) -73.9%

But these tests do!

> Again, those improvements aren't realistic for the 1-pack case (because
> in the real world, the full-array solution doesn't kick in), but it's
> more useful to be testing the more-complicated code path.

I think this is a reasonable adjustment to demonstrate the specific problem
at hand right now.

> While we're looking at this issue, we'll tweak one more thing: in
> oe_map_new_pack(), we call REALLOC_ARRAY(pack->in_pack). But we'd never
> expect to get here unless we're back-filling it for the first time, in
> which case it would be NULL. So let's switch that to ALLOC_ARRAY() for
> clarity, and add a BUG() to document the expectation. Unfortunately this
> code isn't well-covered in the test suite because it's inherently racy
> (it only kicks in if somebody else adds a new pack while we're in the
> middle of repacking).

Makes sense. We can't test everything.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  pack-objects.c             |  5 ++++-
>  pack-objects.h             | 19 ++++++++++++++-----
>  t/perf/p5303-many-packs.sh |  1 +
>  3 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/pack-objects.c b/pack-objects.c
> index c6250d77f4..5e5a3c62d9 100644
> --- a/pack-objects.c
> +++ b/pack-objects.c
> @@ -119,7 +119,10 @@ void oe_map_new_pack(struct packing_data *pack)
>  {
>  	uint32_t i;
>  
> -	REALLOC_ARRAY(pack->in_pack, pack->nr_alloc);
> +	if (pack->in_pack)
> +		BUG("packing_data has already been converted to pack array");
> +
> +	ALLOC_ARRAY(pack->in_pack, pack->nr_alloc);
>  
>  	for (i = 0; i < pack->nr_objects; i++)
>  		pack->in_pack[i] = oe_in_pack(pack, pack->objects + i);
> diff --git a/pack-objects.h b/pack-objects.h
> index 6fe6ae5ee8..d3975e079b 100644
> --- a/pack-objects.h
> +++ b/pack-objects.h
> @@ -251,12 +251,21 @@ static inline void oe_set_in_pack(struct packing_data *pack,
>  				  struct object_entry *e,
>  				  struct packed_git *p)
>  {
> -	if (!p->index)
> +	if (pack->in_pack_by_idx) {
> +		if (p->index) {
> +			e->in_pack_idx = p->index;
> +			return;
> +		}
> +		/*
> +		 * We're accessing packs by index, but this pack doesn't have
> +		 * an index (e.g., because it was added since we created the
> +		 * in_pack_by_idx array). Bail to oe_map_new_pack(), which
> +		 * will convert us to using the full in_pack array, and then
> +		 * fall through to our in_pack handling.
> +		 */
>  		oe_map_new_pack(pack);
> -	if (pack->in_pack_by_idx)
> -		e->in_pack_idx = p->index;
> -	else
> -		pack->in_pack[e - pack->objects] = p;
> +	}
> +	pack->in_pack[e - pack->objects] = p;
>  }

This change looks good, and matches the explanation. There is no way one
could look only at this method body and realize it would cause the performance
problem this change is solving.

>  
>  static inline struct object_entry *oe_delta(
> diff --git a/t/perf/p5303-many-packs.sh b/t/perf/p5303-many-packs.sh
> index 3779851941..a369152c47 100755
> --- a/t/perf/p5303-many-packs.sh
> +++ b/t/perf/p5303-many-packs.sh
> @@ -77,6 +77,7 @@ do
>  	# actual pack generation, without smudging the on-disk setup
>  	# between trials.
>  	test_perf "repack ($nr_packs)" '
> +		GIT_TEST_FULL_IN_PACK_ARRAY=1 \
>  		git pack-objects --keep-true-parents \
>  		  --honor-pack-keep --non-empty --all \
>  		  --reflog --indexed-objects --delta-base-offset \
> 

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
