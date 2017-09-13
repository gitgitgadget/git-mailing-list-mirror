Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D462C20286
	for <e@80x24.org>; Wed, 13 Sep 2017 17:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751179AbdIMRrd (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 13:47:33 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:46152 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbdIMRrb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 13:47:31 -0400
Received: by mail-pg0-f41.google.com with SMTP id i130so1709599pgc.3
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 10:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gYpicr8k8OfTs5AlF2nIHEztrRYU75pYKcaIqPnEqzs=;
        b=sK+j1il63ePjZ8pzHmgas3jkEdEOiV/VJuAbJ0pvwwMnV1BxTqB8BD7E7pIHBPcCnS
         8FJKmRvHAeUSeoVWxKHpVw0IGfwvYdDgG9cQEPJqTCJe+B3Nchm/C3/mCyFEfSOCf2ur
         vDgU7kvftbLJKDTy6N78N81wW0cBBzIRvZ2ui18FNiY1H5A9SYSPQOhk1YLQNEYSzqoC
         Scn6/ttRFJcrK57xuwICkyylPMRh3T6J0Obr3N6qThahSXw7hn8nTuJw8lCa9sNEDBgV
         VVpbLLxEIHubT2L+dwomm9s9rBJsgDrNZvmNyrCpV8M9x+95Qlm5d8O+I9b1pET4O/gd
         enuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gYpicr8k8OfTs5AlF2nIHEztrRYU75pYKcaIqPnEqzs=;
        b=HRFwFWExnIv/RtPp9YzLpAe14iv2HNsRgvi6DlpMRXUPZ3YnZWTyTuAj8KrGiONp2A
         Hcu6Yd5/poeNeoJMEifFfWPLftoRxt1nhcWRqA3lSdWqjBrCZYfe4D9eelmpjbu4BAFc
         y2RYrLY1b8DIcw/rccRGCpVoFn5l6sf9Qf6ef+6M0a59xl7VyTgC0jxIghyuIiX3lJiS
         Yem5ewz5TPcZRNzCsXDZmALUZb/zFtL14dFHO41k7Sablm5dlrk09IQbwceX6C2W6Rpe
         L3JdPvMz02QzdlyvEku80Mnc2boK7r9IrcfIwuhE+8EV3a5tsrs6v3DxHxVEPjWUotEv
         1Qjw==
X-Gm-Message-State: AHPjjUgypiU4fiQNUlBL6KdngQ5Y2WuXSWPBm3+McTpVSNK5vL9ieNRy
        xXEwNBDyVT5zQg==
X-Google-Smtp-Source: ADKCNb6gPic19nceMSUEXxm5SDDxuf6KI16kLilBKg0fy1D9zWDj0c3tlPK1XuWNP/PUAZFo5b8IUA==
X-Received: by 10.98.211.200 with SMTP id z69mr18417776pfk.112.1505324851007;
        Wed, 13 Sep 2017 10:47:31 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:513d:47d2:882:8efc])
        by smtp.gmail.com with ESMTPSA id z125sm26936227pfz.155.2017.09.13.10.47.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 10:47:30 -0700 (PDT)
Date:   Wed, 13 Sep 2017 10:47:28 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/7] config: avoid "write_in_full(fd, buf, len) < len"
 pattern
Message-ID: <20170913174728.GB27425@aiede.mtv.corp.google.com>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
 <20170913171104.yu7ags4aq2zdwz6r@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913171104.yu7ags4aq2zdwz6r@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:

> I scoured the code base for cases of this, but it turns out
> that these two in git_config_set_multivar_in_file_gently()
> are the only ones. This case is actually quite interesting:
> we don't have a size_t, but rather use the subtraction of
> two pointers. Which you might think would be a signed
> ptrdiff_t, but clearly both gcc and clang treat it as
> unsigned (possibly because the conditional just above
> guarantees that the result is greater than zero).

Do you have more detail about this?  I get worried when I read
something like this that sounds like a compiler bug.

C99 sayeth:

	When two pointers are subtracted, both shall point to elements
	of the same array object, or one past the last element of the
	array object; the result is the difference of the subscripts
	of the two array elements. The size of the result is
	implementation-defined, and its type (a signed integer type)
	is ptrdiff_t defined in the <stddef.h> header.

How can I reproduce the problem?

> We can avoid the whole question by just checking for a
> negative return value directly, as write_in_full() will
> never return any value except -1 or the full count.
>
> There's no addition to the test suite here, since you need
> to convince write() to fail in order to see the problem. The
> simplest reproduction recipe I came up with is to trigger
> ENOSPC (this only works on Linux, obviously):

Does /dev/full make it simpler to reproduce?

Thanks,
Jonathan
