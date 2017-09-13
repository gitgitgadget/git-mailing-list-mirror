Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 227C620286
	for <e@80x24.org>; Wed, 13 Sep 2017 21:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbdIMVOf (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 17:14:35 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:45492 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbdIMVOe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 17:14:34 -0400
Received: by mail-pg0-f51.google.com with SMTP id 188so2640863pgb.2
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 14:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A6sPIYROFoxDi215VTltw6mJiqp9Bn0JYkSEkghInNQ=;
        b=pHLNbgiTH7fQvpoTGypgyT0Aj7pEBmvtXGIGmuxPCX5JOqOETlhBiRbD4wtvs02+Q2
         CDu9tpJDXoHUX2H2GEfpmGseMFQH40+OfYRp2Dg6D1OREfdbo+HXMew+Hfu/NcoFPOCp
         z2zV2DsIvt2ANEtW7e36crYFwwzdmy7+Vv743r4lApo7MdoRH2C/kJjNrKp7po+T4eTy
         fKw3qws9kcl3WJGpvexaWVvlhqQ1ubEAjBPYZb6urqh+TqDhO7JK3sJjrMNfrSCRozF4
         1BbA0GUXtBYsBTffH3vdC1W0+aOhHlnqe/LJV0YfgU1dcRSu++V1Uy4Xv1lL054poXLF
         RP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A6sPIYROFoxDi215VTltw6mJiqp9Bn0JYkSEkghInNQ=;
        b=W5UElUND8WxxzAd4a8/itelHf7Pg8lHKkDGTsvjGJJuaxvOguyfY2wvWZD/VHGw8jy
         1JBqwejydeVn62cyaYNzppFUli/tPcL0lrmndEJfBSaofycVl+7TT322tsvD1saHPgvk
         68oSXLYrpZ9wEsmzTFDgricIciAngrtN4UOCHgZvvxoKpo8lmQ1uilXyDUp0I5SJao1y
         weqGvLmDTpLmScycd+r+rtJA3hLT2M2Dk3MF4GsMlhjDoadOVER0oyz4Bub3K0XXzUKd
         CxYs7PsI7vqpLT001M6gZZvFtL3MmmcoviYy9UdMOAdaYdhDOtw4IcdXVSN7GhrTYjVt
         VcKg==
X-Gm-Message-State: AHPjjUjV9SHmIBdsJ8q84f0ax+/TEPpDfzTsIZjhfNFj9DVOUjWMcvpA
        fdVXHterTrIMhQ==
X-Google-Smtp-Source: AOwi7QB2Dpe1unvILHS52xk7M24FnubUImsRHE/BrL9KG3XojUcXZjUsgNMVD1dPXsAffMgj5446Pw==
X-Received: by 10.99.110.12 with SMTP id j12mr2685851pgc.163.1505337273323;
        Wed, 13 Sep 2017 14:14:33 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:d132:98b:3ff1:a635])
        by smtp.gmail.com with ESMTPSA id d21sm26766016pfe.68.2017.09.13.14.14.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 14:14:32 -0700 (PDT)
Date:   Wed, 13 Sep 2017 14:14:30 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 3/7] avoid "write_in_full(fd, buf, len) != len" pattern
Message-ID: <20170913211430.GK27425@aiede.mtv.corp.google.com>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
 <20170913171603.3whuql7l5da3ynrn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913171603.3whuql7l5da3ynrn@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> The return value of write_in_full() is either "-1", or the
> requested number of bytes[1]. If we make a partial write
> before seeing an error, we still return -1, not a partial
> value. This goes back to f6aa66cb95 (write_in_full: really
> write in full or return error on disk full., 2007-01-11).
>
> So checking anything except "was the return value negative"
> is pointless. And there are a couple of reasons not to do
> so:
>
>   1. It can do a funny signed/unsigned comparison. If your
[...]
>   2. Checking for a negative value is shorter to type,
>      especially when the length is an expression.
>
>   3. Linus says so. In d34cf19b89 (Clean up write_in_full()
>      users, 2007-01-11), right after the write_in_full()
>      semantics were changed, he wrote:
>
>        I really wish every "write_in_full()" user would just
>        check against "<0" now, but this fixes the nasty and
>        stupid ones.

Ok, you convinced me.

Should we add a comment to cache.h as well encouraging this?

[...]
> [1] A careful reader may notice there is one way that
>     write_in_full() can return a different value. If we ask
>     write() to write N bytes and get a return value that is
>     _larger_ than N, we could return a larger total. But
>     besides the fact that this would imply a totally broken
>     version of write(), it would already invoke undefined
>     behavior. Our internal remaining counter is an unsigned
>     size_t, which means that subtracting too many byte will
>     wrap it around to a very large number. So we'll instantly
>     begin reading off the end of the buffer, trying to write
>     gigabytes (or petabytes) of data.

This footnote just leaves me more confused, since as you mention,
write() never would return a value greater than N.  Are you saying we
need to defend against a broken platform where that isn't true?

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/receive-pack.c | 2 +-
>  builtin/rerere.c       | 2 +-
>  builtin/unpack-file.c  | 2 +-
>  config.c               | 4 ++--
>  diff.c                 | 2 +-
>  fast-import.c          | 2 +-
>  http-backend.c         | 4 ++--
>  ll-merge.c             | 2 +-
>  read-cache.c           | 6 +++---
>  refs.c                 | 2 +-
>  refs/files-backend.c   | 8 ++++----
>  rerere.c               | 2 +-
>  shallow.c              | 6 +++---
>  t/helper/test-delta.c  | 2 +-
>  transport-helper.c     | 5 ++---
>  wrapper.c              | 2 +-
>  16 files changed, 26 insertions(+), 27 deletions(-)

All of these look correctly done.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
