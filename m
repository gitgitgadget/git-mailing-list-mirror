Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6619D2035B
	for <e@80x24.org>; Wed, 12 Jul 2017 18:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753307AbdGLSyP (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 14:54:15 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36861 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753114AbdGLSyO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 14:54:14 -0400
Received: by mail-pf0-f180.google.com with SMTP id q86so17140390pfl.3
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 11:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=079ji/to8GOjdWdke6Qr1xo/LAENQhugX9LJN4UfeRc=;
        b=HScEBVYKuUOq9MwN5AqlYUq1Z6RlDwCQHDnUWUtX9smALtsHy4e6tQan5MqVL++SGu
         42e8Eyp2oaBIH6J0qlmTBEV7L7OqkQoDKRpAB/MjK3TIJ394jwjjeFPy4WAyfWiallbJ
         HaxwXUHFqVY+bqtbkJcTishHg/LKWG69j7nzYrO5JIje3WAnkpywZ1QDhON7EmGPFYhw
         AlwAvcH5CIZwh5LNsd8jPDPkhRSbmbGsc7tcuqBetK9CLgCPKF/OpIoGnQWZ8OTCvk92
         p3qCOIuLf3Iv/6u6w8Hubb0EUT2lNTcRXeDBOkvjJ3xO7PNDX00I8LqGmNBzvLgf6d4Z
         YNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=079ji/to8GOjdWdke6Qr1xo/LAENQhugX9LJN4UfeRc=;
        b=HMYsjWy/5nkIrBdV+0O8ILn6bIqr4TZ+gxEUVXC/d5KDqFUNwv6h0QQ90TSD+r3z1/
         DfPDH0RNqT51NUpLZsucFB12hwzHMv5fP1uidJhAmH5xu/HhfWx5JaIzX0WaO2xIFIKv
         aRUnFU+hWCCqKbpuwUv7myU2Du/oKu+Q4Mmoyf7IBRgLl3pMyex11bTy0kLJpNO8jklv
         GWsucb3PQvIU9xzceVWi3MShYs0C6dyJw/72A578hXWcGSRiEqH2CTjCTBx+xTHoLPiF
         qZAYpz1w3jfi6PF1EhbsSLMOjXtdz8r1kVKro7AY5xyx0AHC58x8THY9I/+n/m1AVRgS
         ERBg==
X-Gm-Message-State: AIVw1114chnbRanRrVd7FVYvyWO99fo8s1wJTFCCKdqRkJ77KS27lriZ
        2RIsvalK+nyKVn0B
X-Received: by 10.84.132.104 with SMTP id 95mr5643092ple.228.1499885653665;
        Wed, 12 Jul 2017 11:54:13 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:3d1f:bb9:8897:56b4])
        by smtp.gmail.com with ESMTPSA id 28sm7313671pfq.125.2017.07.12.11.54.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 11:54:12 -0700 (PDT)
Date:   Wed, 12 Jul 2017 11:54:11 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/3] grep: recurse in-process using 'struct repository'
Message-ID: <20170712185411.GG65927@google.com>
References: <20170711220408.173269-1-bmwill@google.com>
 <20170711220408.173269-4-bmwill@google.com>
 <CA+P7+xqxkPxcmLSYVLodEwucdkQb1jqN0SiAy_dBeOshTjOyjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+P7+xqxkPxcmLSYVLodEwucdkQb1jqN0SiAy_dBeOshTjOyjg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/11, Jacob Keller wrote:
> On Tue, Jul 11, 2017 at 3:04 PM, Brandon Williams <bmwill@google.com> wrote:
> > Convert grep to use 'struct repository' which enables recursing into
> > submodules to be handled in-process.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  Documentation/git-grep.txt |   7 -
> >  builtin/grep.c             | 390 +++++++++------------------------------------
> >  cache.h                    |   1 -
> >  git.c                      |   2 +-
> >  grep.c                     |  13 --
> >  grep.h                     |   1 -
> >  setup.c                    |  12 +-
> >  7 files changed, 81 insertions(+), 345 deletions(-)
> >
> 
> No real indepth comments here, but it's nice to see how much code
> reduction this has enabled!

Yeah overall, with this and the ls-files conversion, I'm really pleased
with how much cleaner the code looks moving to working in-process.

-- 
Brandon Williams
