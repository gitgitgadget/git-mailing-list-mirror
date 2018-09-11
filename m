Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FCA61F404
	for <e@80x24.org>; Tue, 11 Sep 2018 02:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbeIKHR0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 03:17:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:47090 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeIKHR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 03:17:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id u24-v6so11403631pfn.13
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 19:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0dogG6MEP83a8Za0UGp84mUKoaKN5CPXOWtLt2o9KnA=;
        b=PZe1wqtsUW+N7UURYMSQolmLcTU7jhQ7iykPicwK1DlU01S4a3JMHH0aFYUmEY2rPY
         6PiGhzTwcrdVV3V7f/VowO36GJJjvom3vIIzsQARbaOwBkAXRgH8zGr+zhcrN/9wVLCR
         6c7BJfSB4LLCGsUR72mHMBZ6FYxqPnosXHgh15DQ342qNDtOjpCtNQLJAzXm5RJP/+nk
         AreIoNqnayedL3PL4aHnOqK1rUn2t4muYJGC61FBZ2o+a1iF6SSr8OAyrg3M+76UGcpf
         2/oxYxEJXCd95UbXvgxJLKi8Ni3xhdFQFNks5EJgmI6eGtosXPSELr7tj+3YnWDZJH9J
         hOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0dogG6MEP83a8Za0UGp84mUKoaKN5CPXOWtLt2o9KnA=;
        b=f0UZNxBt7hLAvl00JVjuWo9Pl3F8INHWa8ccseN2Uqh2PLS2S+okDGP0GY180jrhBT
         TAO1ToHM1xieBx/XIIr/kvTSsZzERDfQDaPuc6eZb/ehIr9nK8U+klgbxs+qpvmeO9Ex
         Y3mgwveRUgXFHwXSNSeAHOPFlzQEjU2xWW/1nck9ZF0lVo6lIZPQyAJZjcZkfd4Snq2W
         HWP6cXH+fNU8jQwAHI5TL8+3EwiNBMaPoCGSXLSHfZaBLe5GCldKfVuEHX5z+e8goOl1
         KiYo9xL3Sga0mWG/rwIUMXrKGYipDpiUSzAhDRbjfyI4Mc5LlYCu6b9CKjhY2XsTl/Ev
         6KAw==
X-Gm-Message-State: APzg51CGs8y8PvpKXMWSRQEhoeBnygZCihLkfq1EeiWnR3K2F16c7mKf
        3QAyfneB+Z96NWEZzpJVGsiHWjES
X-Google-Smtp-Source: ANB0VdZ0T1SYqaJf8nVDe5MXF4CEH3wCUP/koErV8nU07Vqr0iewLOW0HgOeg8A/8fDxcNLetSj6UA==
X-Received: by 2002:a63:cf52:: with SMTP id b18-v6mr25207046pgj.194.1536632430739;
        Mon, 10 Sep 2018 19:20:30 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id f4-v6sm33094296pfj.46.2018.09.10.19.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 19:20:30 -0700 (PDT)
Date:   Mon, 10 Sep 2018 19:20:28 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Max Kirillov <max@max630.net>, git@vger.kernel.org,
        Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>
Subject: Re: [PATCH] http-backend: Treat empty CONTENT_LENGTH as zero
Message-ID: <20180911022028.GA20518@aiede.svl.corp.google.com>
References: <20180910052558.GB55941@aiede.svl.corp.google.com>
 <20180910205359.32332-1-max@max630.net>
 <20180910212221.GG26356@aiede.svl.corp.google.com>
 <20180911015553.GA5838@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911015553.GA5838@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, Sep 10, 2018 at 02:22:21PM -0700, Jonathan Nieder wrote:

>> Thanks.  I am wondering if we should go all the way and do
>>
>> 	ssize_t val;
>> 	const char *str = getenv("CONTENT_LENGTH");
>>
>> 	if (!str || !*str)
>> 		return 0;
>> 	if (!git_parse_ssize_t(str, &val))
>> 		die(...);
>> 	return val;
>>
>> That would match the RFC, but it seems to make t5510-fetch.sh hang,
[...]
>> Do you know why?
>
> Yes. :)
>
> It's due to this comment in the patch you are replying to:
>
> +       if (!str) {
> +               /*
> +                * RFC3875 says this must mean "no body", but in practice we
> +                * receive chunked encodings with no CONTENT_LENGTH. Tell the
> +                * caller to read until EOF.
> +                */
> +               val = -1;

Ah!  So "in practice" includes "in Apache".  An old discussion[1] on
Apache's httpd-users list agrees.

The question then becomes: what does IIS do for zero-length requests?
Does any other web server fail to support "read until EOF" in general?

The CGI standard does not cover chunked encoding so we can't lean on
the standard for advice.  It's not clear to me yet whether this patch
improves on what's in "master".

Thanks,
Jonathan

[1] http://mail-archives.apache.org/mod_mbox/httpd-users/200909.mbox/%3C4AAACC38.3070200@rowe-clan.net%3E
