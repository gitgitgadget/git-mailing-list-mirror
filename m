Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D537C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 15:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D9820774
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 15:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="fnUZp+pD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgC0PQL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:16:11 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39151 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgC0PQL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 11:16:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id m1so3557617pll.6
        for <git@vger.kernel.org>; Fri, 27 Mar 2020 08:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pGa6uPNz6atPgDij/IPBg39R0j1dzzNBF4tiGyR3uts=;
        b=fnUZp+pDq2oD1DZeqsIBcifJq9TFspr3eOncOvkq+nnVGx8VzOLdW9Nzo6/0DWbBJw
         SZltZgKbWg9wP5bxKmnvgJu3huZ3OpZoEeOlGlMfhmMxOX2KonhlT+v7HrDON52xtwm+
         7e4PmF6BQDKDvrpGf3mCo8vc6O1D5rbdM2cFizSHxhjUjDCKSaUIFKPFghsvD8ipyqbr
         ZlgOcEP+55gdChwRrCq1SHFmap32mtk3iAv8K3IhZ38ni3cwHHj12PmDyZ9o86YflS40
         y/KjsJecPutQ2NHrN2WinoB2cKyzATBbJr+hS/vrVTzf02an81O94YVvkUTBNjnOJoyL
         9qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pGa6uPNz6atPgDij/IPBg39R0j1dzzNBF4tiGyR3uts=;
        b=bvO8cA/M2ua7/R9BUJ6zUfjqM5ybXnofrGixgtxEfNQEehNDsExIoB4vZahZlthwCu
         FndlMm5vP2eBDwpM3osVW2p3HUtjJ/WjzQqOWXTnY5MJWkgqUEk1sauDQda657OQtBej
         swUXP3jEPh/vq2pydojxNODLl7Ldx8IveE/+edIVFyuBZABASV2worhkbW968EaDlI/g
         5iNX3RGdBWR48I1BLePEGYKq1RIzHDDwAmodAipDAMo6+YT4elXlMVO9L1JaQ3GiTgsK
         DT0FkK5vvqgOmrR8x4dNb/j5kPLq/3xnhM9N3fNBqR9ZAxlnSZuubg+1CzGMtt+P9/jW
         s57w==
X-Gm-Message-State: ANhLgQ0AIpSDjmYZiM4nOEEeSfPIqYAyn6Z9yqhI3o5vKTQkpQVKnRqH
        nUf/B6RINgWDt1hj1vO7c1KckQ==
X-Google-Smtp-Source: ADFU+vsYoqO2+5vunPX4YLY4cTLs+cZfNV0G4menI17dJoFWxagQmg0stwuzdSzve4+vArRZOK0Jrw==
X-Received: by 2002:a17:902:444:: with SMTP id 62mr13672672ple.109.1585322169266;
        Fri, 27 Mar 2020 08:16:09 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id b133sm2838459pfb.180.2020.03.27.08.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 08:16:08 -0700 (PDT)
Date:   Fri, 27 Mar 2020 09:16:07 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] test-lib-functions: make packetize() more efficient
Message-ID: <20200327151607.GA30419@syl.local>
References: <20200327080210.GA604725@coredump.intra.peff.net>
 <20200327080300.GA605934@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200327080300.GA605934@coredump.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 27, 2020 at 04:03:00AM -0400, Jeff King wrote:
> The packetize() function takes its input on stdin, and requires 4
> separate sub-processes to format a simple string. We can do much better
> by getting the length via the shell's "${#packet}" construct. The one
> caveat is that the shell can't put a NUL into a variable, so we'll have
> to continue to provide the stdin form for a few calls.
>
> There are a few other cleanups here in the touched code:
>
>  - the stdin form of packetize() had an extra stray "%s" when printing
>    the packet
>
>  - the converted calls in t5562 can be made simpler by redirecting
>    output as a block, rather than repeated appending
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t5562-http-backend-content-length.sh | 19 ++++++++++++-------
>  t/test-lib-functions.sh                | 23 ++++++++++++++++-------
>  2 files changed, 28 insertions(+), 14 deletions(-)
>
> diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
> index 4a110b307e..3f4ac71f83 100755
> --- a/t/t5562-http-backend-content-length.sh
> +++ b/t/t5562-http-backend-content-length.sh
> @@ -53,15 +53,20 @@ test_expect_success 'setup' '
>  	test_commit c1 &&
>  	hash_head=$(git rev-parse HEAD) &&
>  	hash_prev=$(git rev-parse HEAD~1) &&
> -	printf "want %s" "$hash_head" | packetize >fetch_body &&
> -	printf 0000 >>fetch_body &&
> -	printf "have %s" "$hash_prev" | packetize >>fetch_body &&
> -	printf done | packetize >>fetch_body &&
> +	{
> +		packetize "want $hash_head" &&
> +		printf 0000 &&
> +		packetize "have $hash_prev" &&
> +		packetize "done"
> +	} >fetch_body &&

Nicely done, this is an obvious improvement in clarity over the
appending '>>' that was here before. The new version reads mouch more
cleanly.

>  	test_copy_bytes 10 <fetch_body >fetch_body.trunc &&
>  	hash_next=$(git commit-tree -p HEAD -m next HEAD^{tree}) &&
> -	printf "%s %s refs/heads/newbranch\\0report-status\\n" "$ZERO_OID" "$hash_next" | packetize >push_body &&
> -	printf 0000 >>push_body &&
> -	echo "$hash_next" | git pack-objects --stdout >>push_body &&
> +	{
> +		printf "%s %s refs/heads/newbranch\\0report-status\\n" \
> +			"$ZERO_OID" "$hash_next" | packetize &&
> +		printf 0000 &&
> +		echo "$hash_next" | git pack-objects --stdout
> +	} >push_body &&
>  	test_copy_bytes 10 <push_body >push_body.trunc &&
>  	: >empty_body
>  '
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 352c213d52..216918a58c 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1362,14 +1362,23 @@ nongit () {
>  	)
>  } 7>&2 2>&4
>
> -# convert stdin to pktline representation; note that empty input becomes an
> -# empty packet, not a flush packet (for that you can just print 0000 yourself).
> +# convert function arguments or stdin (if not arguments given) to pktline
> +# representation. If multiple arguments are given, they are separated by
> +# whitespace and put in a single packet. Note that data containing NULs must be
> +# given on stdin, and that empty input becomes an empty packet, not a flush
> +# packet (for that you can just print 0000 yourself).
>  packetize() {
> -	cat >packetize.tmp &&
> -	len=$(wc -c <packetize.tmp) &&
> -	printf '%04x%s' "$(($len + 4))" &&
> -	cat packetize.tmp &&
> -	rm -f packetize.tmp
> +	if test $# -gt 0
> +	then
> +		packet="$*"

Mentioned off-list in a discussion already, but: though I find this
behavior of joining multiple arguments by a whitespace character a
little confusing (i.e., what would callers thing this function does if
they hadn't read the documentation?) I think that this is probably the
most sane thing that you could do here.

On the other hand, nowhere in this patch do we currently call packetize
with multiple arguments, so perhaps it would be made simpler if we
instead wrote "$1" anywhere there was "$packet".

> +		printf '%04x%s' "$((4 + ${#packet}))" "$packet"
> +	else
> +		cat >packetize.tmp &&
> +		len=$(wc -c <packetize.tmp) &&
> +		printf '%04x' "$(($len + 4))" &&
> +		cat packetize.tmp &&
> +		rm -f packetize.tmp
> +	fi
>  }

Right: if the contents contains an unrepresentable byte, then it has to
be passed over stdin. This part is obviously correct.

>  # Parse the input as a series of pktlines, writing the result to stdout.
> --
> 2.26.0.581.g322f77c0ee

Thanks,
Taylor
