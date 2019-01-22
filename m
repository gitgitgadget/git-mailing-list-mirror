Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8542C1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 10:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfAVK0T (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 05:26:19 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52733 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfAVK0T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 05:26:19 -0500
Received: by mail-it1-f196.google.com with SMTP id g76so20592814itg.2
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 02:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fma7r5G1qMaiMidtGOFaBqth9QLLQ3iN3AyCYwJQgU4=;
        b=SWFhKf/Xa9PI8Naa/dJrO/iVWQvZOnrxuCFq/rGMY3RJZZ3vGNTPr8o2TKMQ8Gws0E
         M0T6NjWbQsnruEVjcd+Hj42ZviilwXG7k65Bmw+Rxr5MIElZTSQnp87Ig6Qx4GLEUcc6
         08OVDb083TEZveUkHfuKj/ukeniw0sMPMRNv3eTQV6tgOC7n+K6KDTN5+W28/KaL9MZj
         Sm77u9U6gVtl6TSloS+wX2DWGT0hY4ousPgFtdh8Il1rylmv4jYFpla7TCPLyh+BsJkW
         acUyYsqLdZj5884Ug+SVkQSb2e8HYv4imhu52OgUpbcXnSv8XylyYt56VP/drS2wTaj1
         oqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fma7r5G1qMaiMidtGOFaBqth9QLLQ3iN3AyCYwJQgU4=;
        b=jtzbDFRcvxOstH7RkYIbqN0ylzZL9pLgrMXxhNb9IaDMcTF/dT3VT2gsGOoFGB0qXX
         /jJ1Qo8KHtdzyu1xFP0BaTkYPNaWF4otlwcjfYT+s1ryasQIxevAChNi2EnlN91kR46u
         UD9JigwnK+iWhZzXYrJ+guWYrOXsvoapjxyE9ZaV04fYJwiXx1+d/MdfMEpb613xN80h
         BNNaL8ElwBWrqZQB2jVxWp/hS88k6wohpxX9SouVQPQr3TcEeHKFHe7u2Tapa7gZErrD
         oOVa1feD2ZjuNvA3bIXrc2uSUUSCLOy9QN6LMKW+xy2wcIw7RIM+IueCMCaSynOpgGTh
         6Cng==
X-Gm-Message-State: AJcUukdpr/WyB1fGopWhqn62UYQ4s8jxE0QNE9wHGmquQnmcIydcWCa2
        Jqk48w2Sp48X4Z8JXFEqv4Du2CC/5cIOrOpWMWY=
X-Google-Smtp-Source: ALg8bN5UdR/QyBlHY8lqn30rqlVtyuZ0Ex32TqA7tW313pUrYm/1rFzBZPJC5C1AFLi6sSbLkSmRrGgKs4Q1IpYRIaA=
X-Received: by 2002:a02:8943:: with SMTP id u3mr19084051jaj.92.1548152778506;
 Tue, 22 Jan 2019 02:26:18 -0800 (PST)
MIME-Version: 1.0
References: <20190119154337.6556-1-phogg@novamoon.net> <CACsJy8AWCP+enBVVVga7jJZ-gxD=fxcushrk0D+xGSRAcZw_qg@mail.gmail.com>
 <20190122072809.GA28975@sigill.intra.peff.net>
In-Reply-To: <20190122072809.GA28975@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 22 Jan 2019 17:25:52 +0700
Message-ID: <CACsJy8Cdc-AcPDRquxHu-LmHUjzHmR2GEmARbnPcwXgjp8+HMQ@mail.gmail.com>
Subject: Re: [PATCH v2] pack-objects: Use packing_data lock instead of read_mutex
To:     Jeff King <peff@peff.net>
Cc:     Patrick Hogg <phogg@novamoon.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 22, 2019 at 2:28 PM Jeff King <peff@peff.net> wrote:
>
> On Mon, Jan 21, 2019 at 05:02:33PM +0700, Duy Nguyen wrote:
>
> > > As I mentioned in the prior thread I think that it will be simpler
> > > to simply use the existing lock in packing_data instead of moving
> > > read_mutex. I can go back to simply moving read_mutex to the
> > > packing_data struct if that that is preferable, though.
> >
> > In early iterations of these changes, I think we hit high contention
> > when sharing the mutex [1]. I don't know if we will hit the same
> > performance problem again with this patch. It would be great if Elijah
> > with his zillion core machine could test this out. Otherwise it may be
> > just safer to keep the two mutexes separate.
> >
> > [1] http://public-inbox.org/git/20180720052829.GA3852@sigill.intra.peff.net/
>
> I haven't been following this thread closely, but I still have access to
> a 40-core machine if you'd like me to time anything.
>
> It sounds like _this_ patch is the more fine-grained one. Is the more
> coarse-grained one already written?

A more fine-grained one would be 'master' where we use two separate
mutexes for different code. I guess if repack performance with this
patch is still the same as 'master', we're good to go. You may need to
lower $GIT_TEST_OE_SIZE and $GIT_TEST_OE_DELTA_SIZE to force more lock
contention.
-- 
Duy
