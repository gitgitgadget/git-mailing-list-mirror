Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4BBE1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 04:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbeIKJBE (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 05:01:04 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36377 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbeIKJBE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 05:01:04 -0400
Received: by mail-pl1-f193.google.com with SMTP id p5-v6so3230811plk.3
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 21:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TjvJBuKmUrLciZimeIvZQP2mobjsSw30D5KEQ36oCpE=;
        b=dUcI+voWzb+oXKkVewXiLOO7Btm+J4FF/e5TEtXTOJg8UlAUd8OMrJLGeRUr+opfSS
         5jZqSZAqYm3IzyNovTwvBQzplngwJBhDt/fncV/nCnxUFlUv/nVNKMPawr1O1NGS9AEB
         oHxJAeandOruT9WOozFY0QQYWr/01gQ76b7t0l+XVzCtgFGdQ7uvs5MsaO18vSQPKS5l
         dxqJv6E6g6hXZTMt3V+kGl/sL1rzQGh2UH2WR3DgFkWCpfGjDo9CP/laDcaMFzpTpIDJ
         nofeUs85+xfdNPAYEzuPDVH7jnz2RNzaa78ky5vaF1lRpnEnZ3Y50Ks32WslCB1/SVAg
         TYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TjvJBuKmUrLciZimeIvZQP2mobjsSw30D5KEQ36oCpE=;
        b=KDx8cHQ4pvxFKEe4ach9Aglsr/qKZzeWSpnQsOHHVsghDPNH98Voer82AjKeAx0npZ
         oJkYpqIJgRjPq9RyMa10qRXnLnSKPDM/Gi4ukR1thcUHagTNwT6//5qi9tUbWBfMZe/z
         dnjoHq9DlN8df6k7pBYOyMg3sbd6L/XQohioAPv1zqAVwTo6yGguj/+q6mRVusJQimIf
         +M6X9IykaubgwtrcKURShB8vug3eDfpOMXPeU7yWrwoEdO3AIp4WCUnwmcWcXvCQdBAU
         3w1ct4AIhed9jungsZbtry6PwfNedJqIhfxl6K+bN68xr5cL3lqTw33GNys/yDYAbo3/
         /dRQ==
X-Gm-Message-State: APzg51AK1rVW4WDtjFVug+soFz5Knf7qbTZ3L91gBHrCakCOkK12qKfN
        kUE+qEDKTxNbDV2upLXUs34=
X-Google-Smtp-Source: ANB0VdbNbILFT9A3tgrJon+zm3UImDrphxFHJmWqBI8A5dwXqUmCVFaaC/UbO5M/RLtTJLv+BUWsiQ==
X-Received: by 2002:a17:902:1001:: with SMTP id b1-v6mr25166207pla.155.1536638626472;
        Mon, 10 Sep 2018 21:03:46 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id y7-v6sm23435992pge.8.2018.09.10.21.03.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 21:03:45 -0700 (PDT)
Date:   Mon, 10 Sep 2018 21:03:43 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Max Kirillov <max@max630.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>
Subject: Re: [PATCH] http-backend: treat empty CONTENT_LENGTH as zero
Message-ID: <20180911040343.GC20518@aiede.svl.corp.google.com>
References: <20180910052558.GB55941@aiede.svl.corp.google.com>
 <20180910205359.32332-1-max@max630.net>
 <20180911034227.GB20518@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911034227.GB20518@aiede.svl.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kicking off the reviews: ;-)

Jonathan Nieder wrote:

> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -350,10 +350,25 @@ static ssize_t read_request_fixed_len(int fd, ssize_t req_len, unsigned char **o
>  
>  static ssize_t get_content_length(void)
[...]
> +		/*
> +		 * According to RFC 3875, an empty or missing
> +		 * CONTENT_LENGTH means "no body", but RFC 3875
> +		 * precedes HTTP/1.1 and chunked encoding. Apache and
> +		 * its imitators leave CONTENT_LENGTH unset for

Which imitators?  Maybe this should just say "Apache leaves [...]".

> +		 * chunked requests, for which we should use EOF to
> +		 * detect the end of the request.
> +		 */
> +		str = getenv("HTTP_TRANSFER_ENCODING");
> +		if (str && !strcmp(str, "chunked"))

RFC 2616 says Transfer-Encoding is a list of transfer-codings applied,
in the order that they were applied, and that "chunked" is always
applied last.  That means a transfer-encoding like

	Transfer-Encoding: identity chunked

would be permitted, or e.g.

	Transfer-Encoding: gzip chunked

Does that means we should be using a check like

	str && (!strcmp(str, "chunked") || ends_with(str, " chunked"))

?

That said, a quick search of codesearch.debian.net mostly finds
examples using straight comparison, so maybe the patch is fine as-is.

Thanks,
Jonathan
