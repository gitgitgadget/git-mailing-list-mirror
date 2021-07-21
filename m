Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2CEC12002
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 17:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E646061241
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 17:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhGUQnB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 12:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhGUQnB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 12:43:01 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B22AC061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 10:23:36 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id m20so2942094ili.9
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 10:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=shrXtHjZaZd3hhMLkDMcpPv+5lUdMxZO2ey0cNYtTxY=;
        b=QtZA6yi50ExJTjETuUSimSfh5bnRh8af2P8DHnZltAAu9ok5zlmqUzCZBo/I5ISJT3
         UMGOedoQr/+Bnpn4hQSjsAAYGUcl6PlYFQkNO8h6bOSOmPYqb3qhwWyKT613Ad8PaTjs
         CWVQ1UuzWO+f6Ll7H9zihFrK0/CXN0G+jXz+6GoVH43f5cH7SKSCm5UMymlmT+2FfwvC
         rJnvDICKbZNdjPPgW/hJBncEtZqGtR3Y/2/4pIxyjQYbpAc3yX/dp8YjrCKdqUY25v4d
         3lPc0ewhjVorEYJGwmhOYfOVI3WZDyJCYf6/m3bY3YAVZIHgB+MqrDgMCK5rByCM3Njf
         xqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=shrXtHjZaZd3hhMLkDMcpPv+5lUdMxZO2ey0cNYtTxY=;
        b=SSTg30RMWXxQRkKBZnWZyVNfTdq2t1TI5aFrtzBjGSd1bm8IPovMXlGfBpD0CENL7J
         SLfQOCjf25uhsYZxkXO7DO0KAERX+++kcH5L92XiDspxJqiQVfzfogVs7iubCLVZmWkQ
         DysiHVMstMwfHCOPVyUclqROxmMy3qjsHbL9lRkrJiUwOBR/WxFSGwPjubwjP2onz0M2
         Sgye76CWGfXEXnGui6U1ermlqnoCAY/oFObv4QJybJ118fJ7eMfvK5HYyct4qcpzMgOo
         /A65hEE7CGNvIX/zJtJOnWk/vT5As74QlY1R0eEtr91AzljoDu6xhCbe4Q4WBagCBjX8
         YLog==
X-Gm-Message-State: AOAM531Hx6V3rYJMUDKa6HlinFTnbvSB7jeVKXu/WQuDE+Kvw/N5a1CR
        5136UODQhJ2C4YIEal+wE+MU3A==
X-Google-Smtp-Source: ABdhPJzC2Dwum7i9EN4oqKYXCMKOeCcvDZQKQWEz4dnA2WjGoost6If8qAsDNvNGosGsErB5Kkircw==
X-Received: by 2002:a92:cb52:: with SMTP id f18mr24935536ilq.97.1626888215305;
        Wed, 21 Jul 2021 10:23:35 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:2c46:d8ae:a4c3:9466])
        by smtp.gmail.com with ESMTPSA id z24sm8541509iog.46.2021.07.21.10.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 10:23:35 -0700 (PDT)
Date:   Wed, 21 Jul 2021 13:23:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 04/24] Documentation: build 'technical/bitmap-format'
 by default
Message-ID: <YPhYFnudmHJ9lQek@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <b0bb2e8051f19ec47140fda6500e092e37c6bea8.1624314293.git.me@ttaylorr.com>
 <YPfv0YoLtpYp9866@coredump.intra.peff.net>
 <YPfyEiXw7szt5mjl@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPfyEiXw7szt5mjl@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 21, 2021 at 06:08:18AM -0400, Jeff King wrote:
> On Wed, Jul 21, 2021 at 05:58:41AM -0400, Jeff King wrote:
>
> > On Mon, Jun 21, 2021 at 06:25:07PM -0400, Taylor Blau wrote:
> >
> > > Even though the 'TECH_DOCS' variable was introduced all the way back in
> > > 5e00439f0a (Documentation: build html for all files in technical and
> > > howto, 2012-10-23), the 'bitmap-format' document was never added to that
> > > list when it was created.
> > >
> > > Prepare for changes to this file by including it in the list of
> > > technical documentation that 'make doc' will build by default.
> >
> > OK. I don't care that much about being able to format this as html, but
> > I agree it's good to be consistent with the other stuff in technical/.
> >
> > The big question is whether it looks OK rendered by asciidoc, and the
> > answer seems to be "yes" (from a cursory look I gave it).
>
> Actually, I take it back. After looking more carefully, it renders quite
> poorly. There's a lot of structural indentation that ends up being
> confused as code blocks.
>
> I don't know if it's better to have a poorly-formatted HTML file, or
> none at all. :)
>
> Personally, I would just read the source. And I have a slight concern
> that if we start "cleaning it up" to render as asciidoc, the source
> might end up a lot less readable (though I'd reserve judgement until
> actually seeing it).

Yeah, the actual source is pretty readable (and it's what I had been
looking at, although it is sometimes convenient to have a version I can
read in my web browser). But it's definitely not good Asciidoc.

I briefly considered cleaning it up, but decided against it. Usually I
would opt to clean it up, but this series is already so large that I
figured it would make a negative impact on the reviewer experience to
read a clean-up patch here.

I wouldn't be opposed to coming back to it in the future, once the dust
settles. I guess we can consider this #leftoverbits until then.

Thanks,
Taylor
