Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DC7C35247
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 17:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C941120721
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 17:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="dmSsWLSr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgBCRxN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 12:53:13 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54561 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgBCRxN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 12:53:13 -0500
Received: by mail-pj1-f68.google.com with SMTP id dw13so78143pjb.4
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 09:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KTNNqW7UEZlpXXq0pfXyBtW3bO8PpU94D8yVQQ9dcUU=;
        b=dmSsWLSr3qFzG/CXY0vk5p0E0KTR4DK1LEeKOON9TGRoqX9goAnb0isNJ9qggnnxWb
         a+OP/8RESiSzl1Qxa0RvMFbcPDZJqcpE7CATBV1poIRESqXnh1uANuSVvtDqDtmGzZOq
         Y4EgQBkNYhj3ymg1yBdWi2x4ynmZJ383N4Jf00lIfwx/o3nVnLCv5OzKt5Utr+cgSpMP
         /CE2Usr1JJao0MQdS4xpLN8GmeYet+UCJPMV55ldETjGIKCPRRvkHRSoR6AlolbpQ35r
         Zq78Tjx+cDOmt9YFj4QVmAFJIm+qjiStUlBlrZMA4GyfPIjfDQ5MQ9uB8ta/tuGSnyqb
         RuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KTNNqW7UEZlpXXq0pfXyBtW3bO8PpU94D8yVQQ9dcUU=;
        b=A8LgFjIzvnU9NZ+GISLxD3jZMxf2cwoNs5CeL06swHOeLadPEQpgtok1a9jB4Ib7B2
         kSv8y/YP2LTmQCD4skhUDS7xxYIge2goG3PSQG9dG4goCqEp2GEdjVLPXgjwkqAVoJJg
         7H47M6WUB9qFbdSv7pGKkm1UX/WApj8z6EPvqJIwHnNhZTBFzwDMfOmfcIxP5eNLrmRV
         BxlglyjwcvhXLqj6O6JpIeJQY2tmUslriVhzK+ZOehOc4UWhGYcalpdB4fmU/Y6aLLsF
         IMQ8MM3VPh6JAdHEgcsFZI56hgIVlaa6LSKRWjec9D2i45mKeuF6C3XliU7pJOC4mCtl
         2z0g==
X-Gm-Message-State: APjAAAV/B5tygateL+P+u5zEWxDARDH6QKYFOjMevRX1+Aacpaua8J0F
        07oZyDmy1lt8F9fBafBssz9bLA==
X-Google-Smtp-Source: APXvYqwbXV/JJ72luCxKfuUzLM/DDcPn2I9I8DI3GzKjMhku13JMp9EyGzEvRuKixiI/AoeRGnf4Rg==
X-Received: by 2002:a17:902:6ac2:: with SMTP id i2mr24347859plt.221.1580752392112;
        Mon, 03 Feb 2020 09:53:12 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:ac09:c6e5:fcdd:b79b])
        by smtp.gmail.com with ESMTPSA id r66sm22044166pfc.74.2020.02.03.09.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 09:53:11 -0800 (PST)
Date:   Mon, 3 Feb 2020 09:53:10 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] index-pack: downgrade twice-resolved REF_DELTA to die()
Message-ID: <20200203175310.GA54832@syl.local>
References: <85e71c97-9e0a-863e-179f-a6e1f14365ce@voucoux.fr>
 <20200203144055.GA4170731@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200203144055.GA4170731@coredump.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 03, 2020 at 09:40:55AM -0500, Jeff King wrote:
> When we're resolving a REF_DELTA, we compare-and-swap its type from
> REF_DELTA to whatever real type the base object has, as discussed in
> ab791dd138 (index-pack: fix race condition with duplicate bases,
> 2014-08-29). If the old type wasn't a REF_DELTA, we consider that a
> BUG(). But as discussed in that commit, we might see this case whenever
> we try to resolve an object twice, which may happen because we have
> multiple copies of the base object.
>
> So this isn't a bug at all, but rather a sign that the input pack is
> broken. And indeed, this case is triggered already in t5309.5 and
> t5309.6, which create packs with delta cycles and duplicate bases. But
> we never noticed because those tests are marked expect_failure.
>
> Those tests were added by b2ef3d9ebb (test index-pack on packs with
> recoverable delta cycles, 2013-08-23), which was leaving the door open
> for cases that we theoretically _could_ handle. And when we see an
> already-resolved object like this, in theory we could keep going after
> confirming that the previously resolved child->real_type matches
> base->obj->real_type. But:
>
>   - enforcing the "only resolve once" rule here saves us from an
>     infinite loop in other parts of the code. If we keep going, then the
>     delta cycle in t5309.5 causes us to loop infinitely, as
>     find_ref_delta_children() doesn't realize which objects have already
>     been resolved. So there would be more changes needed to make this
>     case work, and in the meantime we'd be worse off.
>
>   - any pack that triggers this is broken anyway. It either has a
>     duplicate base object, or it has a cycle which causes us to bring in
>     a duplicate via --fix-thin. In either case, we'd end up rejecting
>     the pack in write_idx_file(), which also detects duplicates.
>
> So the tests have little value in documenting what we _could_ be doing
> (and have been neglected for 6+ years). Let's switch them to confirming
> that we handle this case cleanly (and switch out the BUG() for a more
> informative die() so that we do so).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Noticed while running the tests in an environment that complains about
> SIGABRT deaths. Arguably the test suite should be looking for these even
> in test_expect_failure, but it would be a little convoluted to do so
> (e.g., teaching BUG() to write to a marker file, and then checking the
> file). And I think we're better off phrasing things as much as possible
> as expect_success anyway.
>
>  builtin/index-pack.c         | 4 +++-
>  t/t5309-pack-delta-cycles.sh | 8 ++++----
>  2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 60a5591039..41a7c11c8e 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1003,7 +1003,9 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
>
>  		if (!compare_and_swap_type(&child->real_type, OBJ_REF_DELTA,
>  					   base->obj->real_type))
> -			BUG("child->real_type != OBJ_REF_DELTA");
> +			die("REF_DELTA at offset %"PRIuMAX" already resolved (duplicate base %s?)",
> +			    (uintmax_t)child->idx.offset,
> +			    oid_to_hex(&base->obj->idx.oid));

This error message is informative, and matches what you described in the
patch message.

>  		resolve_delta(child, base, result);
>  		if (base->ref_first == base->ref_last && base->ofs_last == -1)
> diff --git a/t/t5309-pack-delta-cycles.sh b/t/t5309-pack-delta-cycles.sh
> index 491556dad9..6c209ad45c 100755
> --- a/t/t5309-pack-delta-cycles.sh
> +++ b/t/t5309-pack-delta-cycles.sh
> @@ -62,13 +62,13 @@ test_expect_success 'index-pack detects REF_DELTA cycles' '
>  	test_must_fail git index-pack --fix-thin --stdin <cycle.pack
>  '
>
> -test_expect_failure 'failover to an object in another pack' '
> +test_expect_success 'failover to an object in another pack' '
>  	clear_packs &&
>  	git index-pack --stdin <ab.pack &&
> -	git index-pack --stdin --fix-thin <cycle.pack
> +	test_must_fail git index-pack --stdin --fix-thin <cycle.pack
>  '
>
> -test_expect_failure 'failover to a duplicate object in the same pack' '
> +test_expect_success 'failover to a duplicate object in the same pack' '
>  	clear_packs &&
>  	{
>  		pack_header 3 &&
> @@ -77,7 +77,7 @@ test_expect_failure 'failover to a duplicate object in the same pack' '
>  		pack_obj $A
>  	} >recoverable.pack &&
>  	pack_trailer recoverable.pack &&
> -	git index-pack --fix-thin --stdin <recoverable.pack
> +	test_must_fail git index-pack --fix-thin --stdin <recoverable.pack
>  '

And these hunks all make sense, too.

>  test_done
> --
> 2.25.0.541.gdfd61ebb85

This looks great, thanks :-)

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
