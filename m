Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A50A1F404
	for <e@80x24.org>; Mon, 10 Sep 2018 21:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeIKCSX (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 22:18:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42366 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbeIKCSW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 22:18:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so11096686pgp.9
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 14:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=40BkNhu1HPyd9Pn5K89zldjSocotCuWe2hoR2mBavX4=;
        b=PTLKtIbgmIPXBQAI1yyUTmYQ3+RLaqAztKilEoxV51lmO3FhTWR3eWG5TsgdW8Pl6w
         4FIoYFQ1N2qlpFG/aNKeeCu++2AN6IYtth8vIwq0cTi/NZo+s9O7G/ALwaUpyuaJS3/v
         lAGgXmJ9QBXhbw7dZYY/MuDK4D/BCJgOTOnQc7pJzxsdu4RKU9YDZgZ3g+zZ/NsqS2+o
         Djdo6DO9PO3+VzA1+1Aze18MonmZX1pphEFnBCUsdQn0fUfnMnp6ivwSzZ0bHS4ODAC3
         eEk3zYvy4RUH4my4jjAlY/fKWRqoq41+WVTiyfGy0P/PZiSkeYOIH8+nrdMCynNdVYaJ
         xKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=40BkNhu1HPyd9Pn5K89zldjSocotCuWe2hoR2mBavX4=;
        b=hw0MylvBE2RCGMo+sUd5ETVs4ZqMNX7IKv+AxpDdLjHe0Jy0RxVGi+aDtlQLW5H3Fn
         AN5O0VYWWaRGuMPfUZUEPgGUWseUzPs0W9thIixqKRhm4fxzmBWSbswMpe2HE0P+RliL
         TGCNlMY7cOIna4ymQkDjjsiiwaHDwuMmWPW7uueHjFnUlx7U76qx+ETrFB8+73tg1S3m
         psr7lXI7nrFzq/8sMOoc91MdaQfoV+x15BaP1N1gUJxMnSLAMUJyBQBKEZFWfRPTvKDt
         ihtU1Vxq25H5Oe0pyeIR1F1ZB4L2zGgCMKwporvvBVaPNoIL6IOgEqMmY5kISfUtQYtb
         MOgQ==
X-Gm-Message-State: APzg51CC+tQkNOPPwIGoulllQKnKmLM1/ThdNq1aLrzu861hqS5CiF81
        Q4AVv6mrf72t9Fcc+UMgclyiF3B3
X-Google-Smtp-Source: ANB0VdZUTRxep2oHX8rZJP0ZhWxKlcAHaay+7N4AEo9yfO4bYb8KYQ6s4MYnneeUNWH2enYyyHVc2w==
X-Received: by 2002:a62:63c2:: with SMTP id x185-v6mr25738797pfb.13.1536614544000;
        Mon, 10 Sep 2018 14:22:24 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id k126-v6sm37708843pgk.26.2018.09.10.14.22.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 14:22:23 -0700 (PDT)
Date:   Mon, 10 Sep 2018 14:22:21 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Max Kirillov <max@max630.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>
Subject: Re: [PATCH] http-backend: Treat empty CONTENT_LENGTH as zero
Message-ID: <20180910212221.GG26356@aiede.svl.corp.google.com>
References: <20180910052558.GB55941@aiede.svl.corp.google.com>
 <20180910205359.32332-1-max@max630.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910205359.32332-1-max@max630.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Max Kirillov wrote:

> From: Jeff King <peff@peff.net>
> Subject: [PATCH] http-backend: Treat empty CONTENT_LENGTH as zero

micronit: s/Treat/treat/

> There is no known case where empty body it used by a server as
> instruction to read until EOF, so there is no need to violate the RFC.
> Make get_content_length() return 0 in this case.
>
> Currently there is no practical difference, as the GET request
> where it can be empty is handled without actual reading the body
> (in get_info_refs() function), but it is better to stick to the correct
> behavior.
>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
> The incremental. Hopefully I described the reason right. Needs "signed-off-by"

Thanks.  I am wondering if we should go all the way and do

	ssize_t val;
	const char *str = getenv("CONTENT_LENGTH");

	if (!str || !*str)
		return 0;
	if (!git_parse_ssize_t(str, &val))
		die(...);
	return val;

That would match the RFC, but it seems to make t5510-fetch.sh hang,
right after

  ok 165 - --negotiation-tip understands abbreviated SHA-1

When I run with -v -i -x, it stalls at

  ++ git -C '/usr/local/google/home/jrn/src/git/t/trash directory.t5510-fetch/httpd/www/server' tag -d alpha_1 alpha_2 beta_1 beta_2
  Deleted tag 'alpha_1' (was a84e4a9)
  Deleted tag 'alpha_2' (was 7dd5cf4)
  Deleted tag 'beta_1' (was bcb5c65)
  Deleted tag 'beta_2' (was d3b6dcd)
  +++ pwd
  ++ GIT_TRACE_PACKET='/usr/local/google/home/jrn/src/git/t/trash directory.t5510-fetch/trace'
  ++ git -C client fetch --negotiation-tip=alpha_1 --negotiation-tip=beta_1 origin alpha_s beta_s

Do you know why?

Thanks,
Jonathan
