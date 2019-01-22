Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4F3E1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 13:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfAVNOT (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 08:14:19 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39135 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbfAVNOT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 08:14:19 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so19241350edt.6
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 05:14:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f7E4o/Aydy5lL4Uoim2HWsn+Lygg6wx+TNH90aVjP5Q=;
        b=GrCG7rCAsAX0MVl1x4QbNpnF9WHHkjcacXeIDa0z2ew0tk0LvgFNvZby1R7vVUk1DL
         oHN9erp7KWce0cC8q8YyXV8JU5f98UtIMy7GG7ViAONrHFqcxJ97hHSDndEt5B83+4VH
         Roq7nwIhMUfwKpP2y5rA0Qz/m1SYuDn+DPyxHJbdmfevba/ZpIH6Gwn8HGU/e6vVbspV
         eBMQ2tCSanyLz4ZmeIKv5DW0KikGOLz/vX0YTN8nENESKTvxN9DtuDX8ohBpYX1bg4Bm
         jHIijycO1boFiVmiXwimRUedZddiplrtm9K1DQv0QvtujV+FYkjuZ1qZLAYTrYNjDa1D
         X0rA==
X-Gm-Message-State: AJcUukdjK5ccZzOsnf7SIiDl0VEN0Gx3YrZMQK5vkyd0j4mzQZBHILYp
        5/0t3yuDxGcFPvq5lrzsfKn4vNVddA==
X-Google-Smtp-Source: ALg8bN41O05W6iNRPX3m6vMsEmuvjGOWA+QigBowM7rB4rAs1QdWS1+EM6KMwCZkQY/E/q9La9HCXA==
X-Received: by 2002:a50:a3d1:: with SMTP id t17mr31573947edb.238.1548162857179;
        Tue, 22 Jan 2019 05:14:17 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id q4sm9586810eda.50.2019.01.22.05.14.15
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 05:14:16 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id h15so19261921edb.4
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 05:14:15 -0800 (PST)
X-Received: by 2002:a50:bf02:: with SMTP id f2mr30188443edk.157.1548162855638;
 Tue, 22 Jan 2019 05:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20190119154337.6556-1-phogg@novamoon.net> <CACsJy8AWCP+enBVVVga7jJZ-gxD=fxcushrk0D+xGSRAcZw_qg@mail.gmail.com>
 <20190122072809.GA28975@sigill.intra.peff.net> <CACsJy8Cdc-AcPDRquxHu-LmHUjzHmR2GEmARbnPcwXgjp8+HMQ@mail.gmail.com>
In-Reply-To: <CACsJy8Cdc-AcPDRquxHu-LmHUjzHmR2GEmARbnPcwXgjp8+HMQ@mail.gmail.com>
From:   Patrick Hogg <phogg@novamoon.net>
Date:   Tue, 22 Jan 2019 08:13:37 -0500
X-Gmail-Original-Message-ID: <CAFOcBzmYd8gHNHEioFbGJiJ3i1xq0Les=r+irVx-o8gCoyYKKw@mail.gmail.com>
Message-ID: <CAFOcBzmYd8gHNHEioFbGJiJ3i1xq0Les=r+irVx-o8gCoyYKKw@mail.gmail.com>
Subject: Re: [PATCH v2] pack-objects: Use packing_data lock instead of read_mutex
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 22, 2019 at 5:26 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Tue, Jan 22, 2019 at 2:28 PM Jeff King <peff@peff.net> wrote:
> >
> > On Mon, Jan 21, 2019 at 05:02:33PM +0700, Duy Nguyen wrote:
> >
> > > > As I mentioned in the prior thread I think that it will be simpler
> > > > to simply use the existing lock in packing_data instead of moving
> > > > read_mutex. I can go back to simply moving read_mutex to the
> > > > packing_data struct if that that is preferable, though.
> > >
> > > In early iterations of these changes, I think we hit high contention
> > > when sharing the mutex [1]. I don't know if we will hit the same
> > > performance problem again with this patch. It would be great if Elijah
> > > with his zillion core machine could test this out. Otherwise it may be
> > > just safer to keep the two mutexes separate.
> > >
> > > [1] http://public-inbox.org/git/20180720052829.GA3852@sigill.intra.peff.net/
> >
> > I haven't been following this thread closely, but I still have access to
> > a 40-core machine if you'd like me to time anything.
> >
> > It sounds like _this_ patch is the more fine-grained one. Is the more
> > coarse-grained one already written?
>
> A more fine-grained one would be 'master' where we use two separate
> mutexes for different code. I guess if repack performance with this
> patch is still the same as 'master', we're good to go. You may need to
> lower $GIT_TEST_OE_SIZE and $GIT_TEST_OE_DELTA_SIZE to force more lock
> contention.

I do have a patch prepared which simply moves read_mutex to the
packing_data struct instead (and renames it read_lock for consistency
with the exiting mutex named "lock"), but I wanted to wait for the
testing regarding lock contention first. I'm prepared either way it
goes.

-Patrick
