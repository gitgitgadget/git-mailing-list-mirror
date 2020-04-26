Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95FBC55185
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 00:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C557F20724
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 00:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzoaLpCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgDZA2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 20:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725962AbgDZA2G (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Apr 2020 20:28:06 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03855C061A0C
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 17:28:04 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mq3so5730511pjb.1
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 17:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CevOVUJht+M0MCRHXfpx7dhNLqiAsDiUdMOgqm8ONIA=;
        b=FzoaLpCQJAeNLRDbMwYePXg8MLxvQzkRcDqtp2zecXqrA1wvZ6SENRL9xA2qPA6sCC
         RGmjRA3BqcHAWC/43VBHhNcuPqrhdIikBwceo+E01eY8waBO38JV6pQXiM1UwM4c+Dsh
         nI1zCLy4x3MFOTqJdy0Dm9CzfC0p53ZDLTEnGEfj05TNzPbdKLHssZWLwixNF8wboktu
         7yUbyV/21BYMN0LPUjWWmhUhwcV1mGWkLVxpoBuK+c/UvSWQIZFiWb8OpqCdYxsy8fJw
         /QLTQeDwUYnUtLU87nGzUInWzPYRSHuHe8dSHvPr1lsdUd2BD7DIQQ+Z2zZblqI30X4d
         /e6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CevOVUJht+M0MCRHXfpx7dhNLqiAsDiUdMOgqm8ONIA=;
        b=RT3aRpkjkoi1VDtpCR3MquGwbIc6UeaRQ/57hZ9S/yyJHQ+cWmza/vU7uy3HjOSrus
         HqGEPRSSLx8szUwOuJ4tQAUxOE6t5b+gChOIpmMj/3rER9jkdRVzKMrgqhwvOhUKPPqQ
         vyuQHJXcvTDQz613f/VxIVuCl1FJWA8FNwxbryCKdC2440mZsyDKvFLVHkJy1n/L+TJ6
         NmUbHLqmRKwPezJNqaj9G8sr588K7VzvNOqWMaX3YlOW4YrVl7I/nJYVJwfSvWoFgC/E
         nFdvYjqCA4HDVycSHbiIrwqu+UIZOb5NmTiaWwXlPxnVFKqPp8Q+w9H4SEavdudzno5A
         K4nw==
X-Gm-Message-State: AGi0PuYcrgpGPbNGr0UaSf/TFHDDRyAUAOwawEUFO2+tvdoifuY1CYIp
        oykg/+mg5VDeScgSRQR01JBPEerA
X-Google-Smtp-Source: APiQypJR+yR9Ezvp9F3guBoYLNx01tkzyc793ho1Y6JthYtWNq6mKpshIAxCce1+sk/oAwKRc+aAbw==
X-Received: by 2002:a17:90a:780d:: with SMTP id w13mr15744409pjk.20.1587860884371;
        Sat, 25 Apr 2020 17:28:04 -0700 (PDT)
Received: from gmail.com (174.247.233.35.bc.googleusercontent.com. [35.233.247.174])
        by smtp.gmail.com with ESMTPSA id a12sm8828411pfr.28.2020.04.25.17.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 17:28:03 -0700 (PDT)
Date:   Sat, 25 Apr 2020 17:28:02 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH 1/2] fetch-pack: in protocol v2, in_vain only after ACK
Message-ID: <20200426002802.GD877@gmail.com>
References: <cover.1587775989.git.jonathantanmy@google.com>
 <51174e53527f9b29bb0a5ebb8726f07333113dfb.1587775989.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51174e53527f9b29bb0a5ebb8726f07333113dfb.1587775989.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> When fetching, Git stops negotiation when it has sent at least
> MAX_IN_VAIN (which is 256) "have" lines without having any of them
> ACK-ed. But this is supposed to trigger only after the first ACK, as
> pack-protocol.txt says:
> 
>   However, the 256 limit *only* turns on in the canonical client
>   implementation if we have received at least one "ACK %s continue"
>   during a prior round.  This helps to ensure that at least one common
>   ancestor is found before we give up entirely.
> 
> The code path for protocol v0 observes this, but not protocol v2,
> resulting in shorter negotiation rounds but significantly larger
> packfiles. Teach the code path for protocol v2 to check this criterion
> only after at least one ACK was received.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  fetch-pack.c          | 13 +++++++++----
>  t/t5500-fetch-pack.sh | 19 +++++++++++++++++++
>  2 files changed, 28 insertions(+), 4 deletions(-)

Makes a lot of sense.  Good find.

[...]
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
[...]
> @@ -1513,6 +1517,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  				break;
>  			case 1:
>  				in_vain = 0;
> +				seen_ack = 1;

not about this patch: can these return values from process_acks be made
into an enum with named enumerators?  That would make what's happening
in the call site more obvious.

>  				/* fallthrough */
>  			default:
>  				state = FETCH_SEND_REQUEST;
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index baa1a99f45..fcc5cc8ab0 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -385,6 +385,25 @@ test_expect_success 'clone shallow with packed refs' '
>  	test_cmp count8.expected count8.actual
>  '
>  
> +test_expect_success 'in_vain not triggered before first ACK' '
> +	rm -rf myserver myclient trace &&
> +	git init myserver &&
> +	test_commit -C myserver foo &&
> +	git clone "file://$(pwd)/myserver" myclient &&
> +
> +	# MAX_IN_VAIN is 256. Because of batching, the client will send 496
> +	# (16+32+64+128+256) commits, not 256, before giving up. So create 496
> +	# irrelevant commits.
> +	test_commit_bulk -C myclient 496 &&
> +
> +	# The new commit that the client wants to fetch.
> +	test_commit -C myserver bar &&
> +
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C myclient fetch --progress origin &&
> +	cp trace /tmp/x &&

Leftover debugging line?

> +	test_i18ngrep "Total 3 " trace

Clever.

In some sense this is a fragile test, since the server could change
how it reports progress some day.  Would it make sense (perhaps as a
followup patch) for this to use a trace2 log instead?  For example,
if we turn on tracing in the server, then since 9ed8790282
(pack-objects: write objects packed to trace2, 2019-04-11) it will
report how many objects were in the pack it wrote.

After removing the "cp trace /tmp/x" line,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
