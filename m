Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A4EC1FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 19:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753126AbdBNTIJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 14:08:09 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:33412 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753221AbdBNTIH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 14:08:07 -0500
Received: by mail-ot0-f193.google.com with SMTP id t47so3251795ota.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 11:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aj0f5v4v7jXiAevRKTs9MmUZc1mwLpnTszto9WtdDOI=;
        b=ZW9yVo4lBP/kjTDwKN1SZ4mXrCtsTL6HCWL9xs28gPBxWnr+9z4jcSF0TKxeKV8HLh
         n6f0HxsQDBpFrJBIWdpmr/A2SgLT89roO3gVVfduA1L1o1Cphh3Gbm//0tT18vY78Lf0
         /FtBxwgpnZFqjEdVoRwXN1NmgooY6Vuobyh8PHTuhPZKd3cA64+L1b5IGpkrOr5m57Ui
         FTHnhfSi7YgCNDwv0LnqFj9owsZVTyA2/Qg/yYCjBLNLonTzSTb1UaSQ8efJ4Xf3ZsiL
         HbVbb71RqrW44jcmV5Eleqw//zhbcnO/l5CtslLtIkr7ugtLgdZxg7xfdeZFnCsSr0yJ
         8e/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aj0f5v4v7jXiAevRKTs9MmUZc1mwLpnTszto9WtdDOI=;
        b=W0VlSEGrhOHZXmkUzhuoNvKX5pxdu9FDGgK29vA8aFQI6vsaVon7k5iCbcP93J4FqD
         oDV8HLfODbG21S9BviXfHIwdsHl5tQBC71g+eukSXqRvdROi57lahdRBvkaMcD69Z+Yn
         67dL97lrNx4sw8l4am26Ck5ruOez1sqw10bH0mi95XK+t56+TkZa885fxOq39znpB/8X
         pBGZqHKPJDO7uFrapEbMS5U+2r7WpmCwI0PF2OoCYhHSKQxTt6sliIHj+OIc2dYfMAMG
         uxX3kBglN+73okdy39TxTjCdfXcJIyLBRZZiD4DoDVlzfJJZsgAwc8Q4RKd5iZGs/kkz
         B1VQ==
X-Gm-Message-State: AMke39mF1H3GjAWmZotqbAAs15njYha+bxu82mfOGuYgoMo7wo44T3wBLxw0duJxFRcTqA==
X-Received: by 10.98.86.68 with SMTP id k65mr33156356pfb.13.1487099286713;
        Tue, 14 Feb 2017 11:08:06 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:2447:f72c:8fdf:75c6])
        by smtp.gmail.com with ESMTPSA id t87sm2729292pfe.59.2017.02.14.11.08.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 11:08:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] remote helpers: avoid blind fall-back to ".git" when setting GIT_DIR
References: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
        <20161020062430.rxupwheaeydtcvf3@sigill.intra.peff.net>
        <20161122004421.GA12263@google.com>
        <20161122024102.otlnl6jcrb3pejux@sigill.intra.peff.net>
        <20161230001114.GB7883@aiede.mtv.corp.google.com>
        <20161230004845.rknafqsyosmyr6z2@sigill.intra.peff.net>
        <20170214061607.qyucfue335aqgji2@sigill.intra.peff.net>
Date:   Tue, 14 Feb 2017 11:08:05 -0800
In-Reply-To: <20170214061607.qyucfue335aqgji2@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 14 Feb 2017 01:16:07 -0500")
Message-ID: <xmqqtw7w8uay.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Dec 29, 2016 at 07:48:45PM -0500, Jeff King wrote:
>
>> On Thu, Dec 29, 2016 at 04:11:14PM -0800, Jonathan Nieder wrote:
>> 
>> > Thanks.  Here's the patch again, now with commit messages and a test.
>> > Thanks for the analysis and sorry for the slow turnaround.
>> 
>> Thanks for following up. While working on a similar one recently, I had
>> the nagging feeling that there was a case we had found that was still to
>> be dealt with, and I think this was it. :)
>> 
>> The patch to the C code looks good. I have a few comments on the tests:
>
> I happened to run into this problem myself today, so I thought I'd prod
> you. I think your patch looks good. Hopefully I didn't scare you off
> with my comments. :)

Thanks for prodding.  I'm tempted to just rip out everything other
than the 5-liner fix to transport.c and apply it, expecting that a
follow-up patch with updated tests to come sometime not in too
distant future.

