Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3522D1F454
	for <e@80x24.org>; Fri,  1 Nov 2019 16:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfKAQ47 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 12:56:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:36302 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727582AbfKAQ46 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 12:56:58 -0400
Received: (qmail 27751 invoked by uid 109); 1 Nov 2019 16:56:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Nov 2019 16:56:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12359 invoked by uid 111); 1 Nov 2019 17:00:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Nov 2019 13:00:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 Nov 2019 12:56:57 -0400
From:   Jeff King <peff@peff.net>
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] configure.ac: define ICONV_OMITS_BOM if necessary
Message-ID: <20191101165657.GC26219@sigill.intra.peff.net>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <cover.1572596278.git.congdanhqx@gmail.com>
 <7c2c6f060393abf3ac831837e4bf8ed366c2fa69.1572596278.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c2c6f060393abf3ac831837e4bf8ed366c2fa69.1572596278.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 01, 2019 at 03:25:10PM +0700, Doan Tran Cong Danh wrote:

> From commit 79444c9294, ("utf8: handle systems that don't write BOM for
> UTF-16", 2019-02-12), we're supporting those systems with iconv that
> omits BOM with:
> 
>     make ICONV_OMITS_BOM=Yes
> 
> However, typing the flag all the time is cumbersome and error-prone.
> 
> Add a checking into configure script to detect this flag automatically.

s/checking/check/

The patch looks good to me, though my knowledge of both iconv and
autoconf is relatively lacking. I'll assume it works on your system,
though. :)

One thing I noticed:

> +	v = (unsigned char)(out[0]) + (unsigned char)(out[1]);
> +	return v != 0xfe + 0xff;

I wondered at first why not just:

  return v[0] != 0xfe || v[1] != 0xff;

but the answer is that you are catching BOMs of either endianness. We
might at some point need to distinguish the two, but I think for the
purposes of OMITS_BOM, we don't have to care. So we can worry about that
later (if ever).

-Peff
