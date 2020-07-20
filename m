Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F31C433DF
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 20:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1030C22C7B
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 20:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="wLw7iISn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbgGTUHn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbgGTUHm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 16:07:42 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6281BC061794
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 13:07:42 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e12so14271153qtr.9
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 13:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3oteajJBgIxkj41jx9tC/NDj4jCUMZ6z5LjMRsMBiqA=;
        b=wLw7iISn4mq1qZ0sJ619C5Ob4R81zqh4deeGFKewI1l8qW1zQxTloP7WZ1imnvus/3
         I9cP+QyJYS1iDwtGaUfwu3sYHEUqOtQRkTPKmUJQ1XaSHhLHdORZYzyHMSVGiByp53bM
         grPWOyiaCFGcfQ+9v5pom4At+RPXYWeaI9eEZUQ4Qrv3sFeQuGqJVy225wWMzKOl4nd4
         Xoy6IzjwjyBgNx/Fjt9bEkTaZZddv6EsYLbfTKmaJPcsZmTJvTJfQEYYMoYkAqzIOuNY
         Dre6Me0Xfp9AQJrTs88Bxvl3B89FhdOmP39vC8MLNmmzUQ8zo7QWcSRfgDyj7Lt3sNfT
         cUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3oteajJBgIxkj41jx9tC/NDj4jCUMZ6z5LjMRsMBiqA=;
        b=Lf+cOMFULSJ/6CdxXrwueHGSY/OQ314IdiKbulCQANztPSfy9jYSesxub0whZTzuFr
         iQDmd/3vAsA9UBoF5GIpFn6yBqQj/NKMzHsNTnhP4xvOTLJDmR/rJB+g3Hl4LgJ4Os/a
         z5l4pWsmiTAolKWDJaZWPm4fU6iq50YXltOXrZD/dp6ehOwiXBdsbGh1eK8vkGqHdi2P
         HeHVehEgkXGyqOPyAjkwQUuN4n902o3LIp1JoFBdFtLH8UdlZDrrA1GS8Jz/CJBavzEa
         K5HZVMcUuec3JfTjAoEs/gbnrNpyW3P3k5lxYgGpg2zDv7mdcNp+V19rAwXyUsecG5ew
         +6lg==
X-Gm-Message-State: AOAM533hh7XcEeFjmz3hcbIYbXUgJmpiogqXKcqZ2qOOg5f4sDMaSUYp
        V/hUzkUV2dxH/8TluJyNWWIXkw==
X-Google-Smtp-Source: ABdhPJwuohSpBvUldqlKNxfzj3XlT9uNqVi1KumsUXpqDOF/co7BsENpDXJuSj8HbencFT/GZUX3HQ==
X-Received: by 2002:aed:3762:: with SMTP id i89mr694604qtb.390.1595275661506;
        Mon, 20 Jul 2020 13:07:41 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1456:25db:8327:2471])
        by smtp.gmail.com with ESMTPSA id b125sm531891qkf.71.2020.07.20.13.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 13:07:40 -0700 (PDT)
Date:   Mon, 20 Jul 2020 16:07:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        chriscool@tuxfamily.org
Subject: Re: [PATCH 2/4] upload-pack.c: allow banning certain object filter(s)
Message-ID: <20200720200739.GB91942@syl.lan>
References: <cover.1593720075.git.me@ttaylorr.com>
 <f0982d24e74155f6c0e405e5e3ae8c3e579f798a.1593720075.git.me@ttaylorr.com>
 <20200715100043.GG11341@szeder.dev>
 <20200715105521.GB3262157@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715105521.GB3262157@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 15, 2020 at 06:55:21AM -0400, Jeff King wrote:
> On Wed, Jul 15, 2020 at 12:00:43PM +0200, SZEDER Gábor wrote:
>
> > Once upon a time I had a PoC patch to deal with 'git upload-pack'
> > aborting while 'git fetch' is still send_request()-ing, by catching
> > the write error to the closed connection and trying read any pending
> > ERR packets; Christian cleaned it up and submitted it with a proper
> > commit message in
> >
> >   https://public-inbox.org/git/20200422163357.27056-1-chriscool@tuxfamily.org/
> >
> > but it haven't been picked up yet.  Disappointingly, that patch
> > doesn't solve these issues...  I haven't looked what's going on
> > (perhaps 'git clone' does something differently than 'git fetch'?  no
> > idea)
>
> I suspect it is that fetch ignores SIGPIPE, but clone does not. So even
> when we see a 141 exit code from fetch, it is probably generated
> synthetically from exit(141) after we saw EPIPE. And your patch works
> there because we have a chance to pump the read-side of the pipe,
> whereas in git-clone we die immediately via the signal.

Heh. I was hoping to be rid of those errors with Christian's patches,
but it sounds like the problem is coming from outside of 'upload-pack'
and instead in 'clone'.

That reasoning seems sound to me, but I'd rather not touch clone in this
patch series if I don't have to. What I'd rather do is something like:

  - Introduce this patch series with the 'test_must_fail ok=sigpipe',
    and no error checking.

  - Modify clone to swallow these errors and eat a packet or two.

  - Then, drop the 'ok=sigpipe' from t5616 after 'git clone' is a little
    bit smarter here.

Maybe more steps than is strictly necessary, but I think it keeps the
scope of the review on this series reasonable, which is a tradeoff that
I'm willing to make.

> Probably git-clone should ignore SIGPIPE during the network transfer
> portion of the process for the same reasons given in 143588949c (fetch:
> ignore SIGPIPE during network operation, 2019-03-03).
>
> -Peff

Thanks,
Taylor
