Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7B5C35242
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 02:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E61F2081E
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 02:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ZRMLKAU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgBOCOt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 21:14:49 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46229 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbgBOCOt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 21:14:49 -0500
Received: by mail-pg1-f195.google.com with SMTP id b35so5715937pgm.13
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 18:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FGeUllnsafoJuSEeISJ2TaLnmZ+ufm2YVUhjsUw7NHM=;
        b=ZRMLKAU0ZWiiDdVIxvL7h13fLIVzE6a7IOIGeum1unJknwuBUiUUGfNU1Eg5EjD1Ik
         yohO1Bh8d9Z0KIXH1k9KE6WKzudSB+eAZwr/Pd1uvXwQZmBPdCzr/fQ2NL+iB5X27qxU
         NHwWXUo5ViFZaQiZUDpwUDdbnD72FYu5Kst+2LoqQF/+iEDrtEzrMKGVPrhLIQMkzUDH
         KZg6rf7e6IkiFCkPRCyuTlQKKVyLaakTCTvLIhovxguCicbtmN06Imk84q6RXxNcwVtT
         TWxg+tXA/oMRlIPSXMnwBeKbveIx0YbmHJTZqXaZ3FQHjag5NURh3DZ9Yiszu3eDWS0e
         UHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FGeUllnsafoJuSEeISJ2TaLnmZ+ufm2YVUhjsUw7NHM=;
        b=T6fmqax6rTKtZWKcmcg5iiY2/jVgYCBU12O1GcwjDHAGB03f+5GW/cenmRUKuXbuLM
         KWUHVBWpbCSK0xUUt0HjwwFb/aPxJSIt5ojkJi3jYT15aIYFOj+GoSidDVkeaAVUkJ+D
         bFUso2WCEa+FR6ePpPxrZq3Jlf659mQiE5M3fpAFB6kiMPH9t3Mdt32NviW9eTvvSwgn
         SnjGRUOFq6JkIwWwuWIORe4VUtXtdSb9mWganqS+t0NzByzhwt6nYqEu4V+SsjhNcXUx
         9eoxRIqAoLFL+Xmag6Yak4CuOTmjl8BtJcbWl8c/3TJo+fRRXtxGmxO8+Cujt1qrKlIt
         I3Pg==
X-Gm-Message-State: APjAAAWlMKN2O28Zkd8VL5OnQnC/HVQ/D0qcgl5aA/ZsRjf4c48JOKQ9
        HbKiaQnsPcvZUsIaF+RYFep8Xg==
X-Google-Smtp-Source: APXvYqxKKvM95hTH8RaAjBTquSNFx/gA29UFJYjI9mpSR1/ZLdw4Ow9y36da9zpEDfA/RzPnCbZC0g==
X-Received: by 2002:a62:1c88:: with SMTP id c130mr6362397pfc.195.1581732888367;
        Fri, 14 Feb 2020 18:14:48 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:1564:53e1:f83e:5062])
        by smtp.gmail.com with ESMTPSA id v5sm8477460pgc.11.2020.02.14.18.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 18:14:47 -0800 (PST)
Date:   Fri, 14 Feb 2020 18:14:46 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 08/15] t5310: factor out bitmap traversal comparison
Message-ID: <20200215021446.GA16515@syl.local>
References: <20200214182147.GA654525@coredump.intra.peff.net>
 <20200214182225.GH150965@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214182225.GH150965@coredump.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 14, 2020 at 01:22:25PM -0500, Jeff King wrote:
> We check the results of "rev-list --use-bitmap-index" by comparing it to
> the same traversal without the bitmap option. However, this is a little
> tricky to do because of some output differences (see the included
> comment for details). Let's pull this out into a helper function, since
> we'll be adding some similar tests.
>
> While we're at it, let's also try to confirm that the bitmap output did
> indeed use bitmaps. Since the code internally falls back to the
> non-bitmap path in some cases, the tests are at risk of becoming trivial
> noops.
>
> This is a bit fragile, as not all outputs will differ (e.g., looking at
> only the commits from a fully-bitmapped pack will end up exactly the
> same as the normal traversal order, since it also matches the pack
> order). So we'll provide an escape hatch by which tests can disable this
> check (which should only be used after manually confirming that bitmaps
> kicked in).

Thanks for pointing out the rationale behind this.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t5310-pack-bitmaps.sh | 10 +++-------
>  t/test-lib-functions.sh | 27 +++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 7 deletions(-)
>
> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index 7ba7d294a5..b8645ae070 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -81,13 +81,9 @@ rev_list_tests() {
>  	'
>
>  	test_expect_success "enumerate --objects ($state)" '
> -		git rev-list --objects --use-bitmap-index HEAD >tmp &&
> -		cut -d" " -f1 <tmp >tmp2 &&
> -		sort <tmp2 >actual &&
> -		git rev-list --objects HEAD >tmp &&
> -		cut -d" " -f1 <tmp >tmp2 &&
> -		sort <tmp2 >expect &&
> -		test_cmp expect actual
> +		git rev-list --objects --use-bitmap-index HEAD >actual &&
> +		git rev-list --objects HEAD >expect &&
> +		test_bitmap_traversal expect actual
>  	'
>
>  	test_expect_success "bitmap --objects handles non-commit objects ($state)" '
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 284c52d076..352c213d52 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1516,3 +1516,30 @@ test_set_port () {
>  	port=$(($port + ${GIT_TEST_STRESS_JOB_NR:-0}))
>  	eval $var=$port
>  }
> +
> +# Compare a file containing rev-list bitmap traversal output to its non-bitmap
> +# counterpart. You can't just use test_cmp for this, because the two produce
> +# subtly different output:
> +#
> +#   - regular output is in traversal order, whereas bitmap is split by type,
> +#     with non-packed objects at the end
> +#
> +#   - regular output has a space and the pathname appended to non-commit
> +#     objects; bitmap output omits this
> +#
> +# This function normalizes and compares the two. The second file should
> +# always be the bitmap output.
> +test_bitmap_traversal () {
> +	if test "$1" = "--no-confirm-bitmaps"
> +	then
> +		shift
> +	elif cmp "$1" "$2"

Any reason to prefer 'cmp' here and then use 'test_cmp' below? I can't
think of a good reason one way or another, especially in places where
GIT_TEST_CMP is just 'cmp', but I think the two usages should be
consistent with one another.

If there *is* a favorable argument for 'test_cmp' (instead of a bare
'cmp'), I think that it'd be that the original code a couple of hunks up
uses it.

> +	then
> +		echo >&2 "identical raw outputs; are you sure bitmaps were used?"
> +		return 1
> +	fi &&
> +	cut -d' ' -f1 "$1" | sort >"$1.normalized" &&
> +	sort "$2" >"$2.normalized" &&
> +	test_cmp "$1.normalized" "$2.normalized" &&
> +	rm -f "$1.normalized" "$2.normalized"

This implementation looks good to me.

> +}
> --
> 2.25.0.796.gcc29325708

Thanks,
Taylor
