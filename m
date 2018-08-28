Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C1761F404
	for <e@80x24.org>; Tue, 28 Aug 2018 19:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeH1XSu (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 19:18:50 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:32999 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbeH1XSu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 19:18:50 -0400
Received: by mail-io0-f195.google.com with SMTP id r196-v6so2464376iod.0
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 12:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mir4wiyXTowL4KwQ5m2kOc6CyccJfu8QBvlksh1VlhY=;
        b=esPrGpQuv04cDI/vaFc4XXKsVGRg9jObO6A0mHeI8IZ3uQmswxWOvHLhkMJfN4O92E
         jv+1fL1Fju4SWrw8vyn0bBeECrpryouL/NWwiY+xsqcgR2Chsx5pWoZOUDduBNeAUq3U
         QrYf4qTXSmVYolXgEnU50cM6phY1S7BQwlMMCRPjB5VMaSqkN10a8aTB55FRndXDikgY
         P4uuoLQdoW19HedH5ZdQX30gQ3B6PlhEI8brgu286r7LsAmJY9rzyibOTKRIr/qYENiR
         m5GOUlB4Uaf15SNANKMprTg3gDyZm6B2HWMCwl3xDK81IVwOIR7x1C5XAgioYAM22fRU
         M6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mir4wiyXTowL4KwQ5m2kOc6CyccJfu8QBvlksh1VlhY=;
        b=rmPXxfVoLpfe9mlMN5JXzrtpfewyCHYtZwanEe5paou06q9IfZyUPta1OfRoSIm6EJ
         z/AoUn8ZyVksoB86CXotrmC1sqB0IlCMgjsigtjXDuKhs4kxArwtPgmTKhT8Rg4hY3dn
         NjqZ7BOz3PuBYGDFPaROL3FKypO9Uy6mUe5EVynVE9vrZLvvvjP4Jbdfx96teEu06aRs
         RocaAkFrqvWfLGLkZt+Y+4te7xdgWn/i/CXMQ72WXI+00EprCDTiE+JwIAWQvvOI1T1X
         1Na6z6GqZd/ne2R9nPYjyob+PV5AMkO/z2G/qAoN5/+PkFbc429PNUjXS7wNNyDwuh4/
         QRpg==
X-Gm-Message-State: APzg51AhpU3oTFw2JRTHqXBu03DbDjnqLMIZsylkzMpjrXAGVGI59jan
        iYMn036Csg+fjzL9uSdLRFb6F6UtlAcgULR1Ybg=
X-Google-Smtp-Source: ANB0VdYRL/2+xTcrmpkimSntOt0vIQ8pI8mG4GByIIm4TYtVU6Kx3QvR12Fc6es41RuL7frsoDFwH/nvSwcwxyfuneE=
X-Received: by 2002:a5e:d803:: with SMTP id l3-v6mr2526889iok.236.1535484345775;
 Tue, 28 Aug 2018 12:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180824155734.GA6170@duynguyen.home> <20180825064458.28484-1-pclouds@gmail.com>
 <xmqqwosbiouc.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwosbiouc.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 28 Aug 2018 21:25:19 +0200
Message-ID: <CACsJy8B38QAW8qq-CctLJyJNaC329o6Rr1gs0kd=EkV+ARAaVw@mail.gmail.com>
Subject: Re: [PATCH] read-cache.c: optimize reading index format v4
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <peartben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 27, 2018 at 9:36 PM Junio C Hamano <gitster@pobox.com> wrote:
> > PS. I notice that v4 does not pad to align entries at 4 byte boundary
> > like v2/v3. This could cause a slight slow down on x86 and segfault on
> > some other platforms.
>
> Care to elaborate?
>
> Long time ago, we used to mmap and read directly from the index file
> contents, requiring either an unaligned read or padded entries.  But
> that was eons ago and we first read and convert from on-disk using
> get_be32() etc. to in-core structure, so I am not sure what you mean
> by "segfault" here.
>

My bad. I saw this line

#define get_be16(p) ntohs(*(unsigned short *)(p))

and jumped to conclusion without realizing that block is for safe
unaligned access.

> > @@ -1898,7 +1884,8 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
> >       struct cache_header *hdr;
> >       void *mmap;
> >       size_t mmap_size;
> > -     struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
> > +     const struct cache_entry *previous_ce = NULL;
> > +     struct cache_entry *dummy_entry = NULL;
> >
> >       if (istate->initialized)
> >               return istate->cache_nr;
> > @@ -1936,11 +1923,10 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
> >       istate->initialized = 1;
> >
> >       if (istate->version == 4) {
> > -             previous_name = &previous_name_buf;
> > +             previous_ce = dummy_entry = make_empty_transient_cache_entry(0);
>
> I do like the idea of passing the previous ce around to tell the
> next one what the previous name was, but I would have preferred to
> see this done a bit more cleanly without requiring us to support "a
> dummy entry with name whose length is 0"; a real cache entry never
> has zero-length name, and our code may want to enforce it as a
> sanity check.
>
> I think we can just call create_from_disk() with NULL set to
> previous_ce in the first round; of course, the logic to assign the
> one we just created to previous_ce must check istate->version,
> instead of "is previous_ce NULL?" (which is an indirect way to check
> the same thing used in this patch).

Yeah I kinda hated dummy_entry too but the feeling wasn't strong
enough to move towards the index->version check. I guess I'm going to
do it now.
-- 
Duy
