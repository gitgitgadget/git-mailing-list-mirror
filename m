Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 402F81F404
	for <e@80x24.org>; Sat,  8 Sep 2018 13:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeIHSFA (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 14:05:00 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34236 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbeIHSFA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 14:05:00 -0400
Received: by mail-io1-f65.google.com with SMTP id c22-v6so3605848iob.1
        for <git@vger.kernel.org>; Sat, 08 Sep 2018 06:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2A79mbJ4OsSZvv7pvCyaJWvFfR4VW41lRaeOjkuagHI=;
        b=mZj+pVyzAAbjK9KB0Sl7thKwgQ8sys4eSTMx5Q5A+zgjpnaKVJ4yQiIMyWk88xdATB
         tXiJcNkJO9XAgMjriYkOPRc2HchLQ++/gTcl/IpWn8XWrWiQpu5FvRC1czllKeygS1g0
         VZKXwcaMveezT7voMtjNAluTHWEnXXSXJbZVIwVipn5NO3a8HbXfHADxXdT4MUqg6DZQ
         JpTLZJ3TiZISDtmu4r1FgZerQHt/LNF9HmmjGtmpLSGKDg6qVmEUjWCDRtWAbzPWGO5G
         irrjUVEfhbg8ADlJig5IS/+O6WIRpDczmk2Psj4M1Ifj1bBEFufd54nBVzHvK1I29Ypc
         YQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2A79mbJ4OsSZvv7pvCyaJWvFfR4VW41lRaeOjkuagHI=;
        b=UJdLP/qGAa2ptYnGutwjQnYWZwxyRe+GRrlKR5heTBpfDCn44OvY5+el6dzsbNMMsA
         p5uOxfv2i53kItBZLJ4sq2Mj61Day5KnuzKQQ8sdrEtv5e/HMnWdXDnD02JOjE3AlcK9
         gReKP9zuADlTLuyNu2BMYk8iRT7uLWeASlD8cvR0MhguL9IRuKRjqO4R3z0hr7o4QLw4
         vNvdCPb+F3QZKv8N/dGiRd2GXcoLwCXQapZ5tlIAkLJW762/h19PoSecrShI5I3Tfr0x
         Y7QJLtUj3Ufq8GC0djPJZIXFT8/erF7EQW5L179ce+6A5G4VKCcMgG0kY26yDZ2kWBHK
         jT2Q==
X-Gm-Message-State: APzg51DGKgNQlORLHTQT3l3cYvZEtarNA5EWYv5R35oIMnn042mvVzTX
        q3ivkS60zgCGfTUYJmhnFPGZ6FQDsQpk6RjtZnSbuxhj
X-Google-Smtp-Source: ANB0Vdbn4AC0hG5bJC3CUPgzwemj+SaMQj0G2Zr66BmIUYGEm1CDjJGAjR1NScYDQ7hDFlS+EIILqBZUyUs7l0zm5xM=
X-Received: by 2002:a6b:9885:: with SMTP id a127-v6mr9263014ioe.282.1536412753446;
 Sat, 08 Sep 2018 06:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180906210227.54368-1-benpeart@microsoft.com> <xmqq5zzhxlxm.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq5zzhxlxm.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 8 Sep 2018 15:18:47 +0200
Message-ID: <CACsJy8DF1YgXNixLxhQXkTyGdmzhF=GWyJR2_1-BxmmO0wc+2w@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] read-cache: speed up index load through parallelization
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <benpeart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <Ben.Peart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 7, 2018 at 7:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Ben Peart <benpeart@microsoft.com> writes:
>
> > On further investigation with the previous patch, I noticed that my test
> > repos didn't contain the cache tree extension in their index. After doing a
> > commit to ensure they existed, I realized that in some instances, the time
> > to load the cache tree exceeded the time to load all the cache entries in
> > parallel.  Because the thread to read the cache tree was started last (due
> > to having to parse through all the cache entries first) we weren't always
> > getting optimal performance.
> >
> > To better optimize for this case, I decided to write the EOIE extension
> > as suggested by Junio [1] in response to my earlier multithreading patch
> > series [2].  This enables me to spin up the thread to load the extensions
> > earlier as it no longer has to parse through all the cache entries first.
>
> Hmph. I kinda liked the simplicity of the previous one, but if we
> need to start reading the extension sections sooner by eliminating
> the overhead to scan the cache entries, perhaps we should bite the
> bullet now.

My view is slightly different. If we have to optimize might as well
try to squeeze the best out of it. Simplicity is already out of the
window at this point (but maintainability remains).

> > The big changes in this iteration are:
> >
> > - add the EOIE extension
> > - update the index extension worker thread to start first
>
> I guess I'd need to see the actual patch to find this out, but once
> we rely on a new extension, then we could omit scanning the main
> index even to partition the work among workers (i.e. like the topic
> long ago, you can have list of pointers into the main index to help
> partitioning, plus reset the prefix compression used in v4).  I
> think you didn't get that far in this round, which is good.  If the
> gain with EOIE alone (and starting the worker for the extension
> section early) is large enough without such a pre-computed work
> partition table, the simplicity of this round may give us a good
> stopping point.

I suspect the reduced gain in 1M files case compared to 100k files in
4/4 is because of scanning the index to split work to worker threads.
Since the index is now larger, the scanning takes more time before we
can start worker threads and we gain less from parallelization. I have
not experimented to see if this is true or there is something else.

> > This patch conflicts with Duy's patch to remove the double memory copy and
> > pass in the previous ce instead.  The two will need to be merged/reconciled
> > once they settle down a bit.
>
> Thanks.  I have a feeling that 67922abb ("read-cache.c: optimize
> reading index format v4", 2018-09-02) is already 'next'-worthy
> and ready to be built on, but I'd prefer to hear from Duy to double
> check.

Yes I think it's good. I ran the entire test suite with v4 just to
double check (and thinking of testing v4 version in travis too).
-- 
Duy
