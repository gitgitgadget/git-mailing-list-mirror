Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 898E42021E
	for <e@80x24.org>; Tue, 15 Nov 2016 17:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752456AbcKORwf (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 12:52:35 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34085 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbcKORwe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 12:52:34 -0500
Received: by mail-pg0-f54.google.com with SMTP id x23so66212293pgx.1
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 09:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/UZd9L+Phtd5m10Gkn6E9zI5CS4voEf/lu5Ssfz4woE=;
        b=gvc25AWaJstym2oMQe9d3J82tgKlxR+fUBA2x3VvkuTXSAX3K90trXgXFeZWG6tLCd
         7Aot5COEhvEsRMxwi8iHRkg2Ln7VOZym1fSb2Y5FODxTFD3+XNSz4IIcHv1QVA9Ec0Kc
         AfMiZ3dMPbeHS5N11a+h2jA5iWLN/buKyNfQsFwTZNWaOpSX2OlPBkdUdDuIrIQQUD0Q
         vXUVcT6BMWe1xhCazGJsFbJ43IqfI2sUvZl4E3xEs55VEZZuQCnFj33nHu2TFhEOjE1L
         ezDBilFTHJNtSuDf/IqSBkHVe4CalX7maXg4+ETLWzrmEZoZuVVcEW7KQmHB9oo8eYLN
         xvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/UZd9L+Phtd5m10Gkn6E9zI5CS4voEf/lu5Ssfz4woE=;
        b=RbRFWbvkNT4RiZSup5dEe95mFiFMo1xiNZZ6IbMjXHey/rP6iIGn24Az7YyzW/yh5W
         6WC/MPrB/46LBsk2yipHdsCvVU7NLn+4cfhb2evRNKcSlcVSEq4RPnGhN7eczDhyLtWD
         YMC1JPTdE00GNAwMz+kLjWY6TrIjwu6EDfDD+W9iWqKx5ytulF5pfgZejftckh2/yC7u
         EAzCzBgKfK6DE5TqbKtap9e29DC0R/v3y0bU9TqDdZBkp/KjvtWhqCtMaH4VODAdPqUJ
         ZVhl4nHHQ+u8CWJjWIZLxkaHtNb4C3BMh1+UlYsuhduqBSrQjUaceX9MYi24f9rxfgq/
         sOXw==
X-Gm-Message-State: ABUngvfV60tAl+TE/S7N7ULtia5yWXut3Nn5iIn+wcPv/T3rV1aTKqJNBcbtdJFBFF4dq+gZ
X-Received: by 10.99.126.6 with SMTP id z6mr72604pgc.182.1479232353657;
        Tue, 15 Nov 2016 09:52:33 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:f0a8:aad3:5a98:9829])
        by smtp.gmail.com with ESMTPSA id e7sm45022273pfa.65.2016.11.15.09.52.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 09:52:32 -0800 (PST)
Date:   Tue, 15 Nov 2016 09:52:31 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH v3 0/4] Speedup finding of unpushed submodules
Message-ID: <20161115175231.GB66382@google.com>
References: <cover.1479221071.git.hvoigt@hvoigt.net>
 <CAGZ79kawQOO98GFYZBnUhN_A8jKDVopTDHMjsM=rrG_5ekyidQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kawQOO98GFYZBnUhN_A8jKDVopTDHMjsM=rrG_5ekyidQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/15, Stefan Beller wrote:
> On Tue, Nov 15, 2016 at 6:56 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > You can find the second iteration of this series here:
> >
> > http://public-inbox.org/git/cover.1475851621.git.hvoigt@hvoigt.net/
> >
> > All mentioned issues should be fixed. I put the NEEDSWORK comment in a
> > seperate patch since it seemed to me as if we did not fully agree on
> > that. So in case we decide against it we can just drop that patch.
> >
> > Cheers Heiko
> >
> 
> +cc Brandon who started building a series on top of yours.

I don't think there should be too much I'll have to change with my
series, I'll just rebase against these changes once Junio updates his
branch.

If you want to take a look at my series its here:
https://public-inbox.org/git/1479172735-698-1-git-send-email-bmwill@google.com/

Thanks for the heads up Stefan.

-- 
Brandon Williams
