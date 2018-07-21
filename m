Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52DC81F597
	for <e@80x24.org>; Sat, 21 Jul 2018 04:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeGUFPN (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 01:15:13 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:39099 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbeGUFPN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 01:15:13 -0400
Received: by mail-it0-f67.google.com with SMTP id g141-v6so14790086ita.4
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 21:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K0BF22LFBuwgXWDuCipOpUt42oZSfKs14qls8BzqtDE=;
        b=ZTkru1QKlPImbXuFn/iRLl0hO1x4AJX2KRTFmiJ4YaSzHrcCFsb2QcN8ZMxlp5jAcM
         N6CIKe6iDm/TBfuh8SoT76edmZv7Hk4NvvE1VP0Z5Y02YkD73WL6dpG8ThvgnmXPJR+v
         pIcrwtPlIeu+xnNEtsilFDBGDWE+85NQo6cu8e6Io8UKjgotBnThbvNxicCz4jxSFzth
         5r1yeT9aR8stP9UbD8UkxX4fQmAan3uLijlv0ukn4mVnM1Wvl8lp5I4+uaMn3jIhIulY
         HQ8wIhgFMPEU19HiX7VZZTuy7M2C8Y0F+mZRKiipQMg4sCpYioni+SvVXWDmrBFrJd2G
         AZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K0BF22LFBuwgXWDuCipOpUt42oZSfKs14qls8BzqtDE=;
        b=L2O4WeGTF8uHqKP9I+BOVXoayq3S9niiAQuaoPVTxPlL7/kfGzH8e4vmu6eJXKueLi
         Uld48oofnHoy85FYgnggSJwBD2M90XVP3SUmR8SmfSoCAsuR7vS17+D7qLQa/dqFA6We
         XcSJNSDck60y0bBFcolpfqCq7n35uf3W6wGPO88w1U0DmqB0xYXNhDe3fvgdMuTxYOMZ
         RQhneX6PBYzOHHlLQ2jaPFRUyI6zhp7yS+Wr0F3oCIpSYNKQ1JA9QPcCODtBIbCrrLib
         AN/AG2NdqWmG8VrIOeAWtXr/8WeDSM02n91GvL+FWxzsFTQM4x+jtVtVyUwJhQwqo+oK
         r+wQ==
X-Gm-Message-State: AOUpUlFt6vhU7B2AVyCUVTsL9NEh90+y6O+hhSVcT9B64HOpbZPOUHBg
        4YWQbt/2aSvoXIx5iQxfwhP1r1e7VCyMjxFsba0=
X-Google-Smtp-Source: AAOMgpfthFJl3kbcmCbiu+YQM+BaVEqrm9SWu3MCWFaGEa2ezZKrxMt1P2y90foTXevFnaMB7aKyORsm5+XOE3XVghY=
X-Received: by 2002:a24:b101:: with SMTP id o1-v6mr3795990itf.121.1532147038512;
 Fri, 20 Jul 2018 21:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180718225110.17639-1-newren@gmail.com> <20180720153943.575-1-pclouds@gmail.com>
 <20180720174004.GA22486@sigill.intra.peff.net>
In-Reply-To: <20180720174004.GA22486@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 21 Jul 2018 06:23:32 +0200
Message-ID: <CACsJy8AcDqNtV1VfHB+ZD=wvOxRyhobacreaNpjSm3NcLCMKWA@mail.gmail.com>
Subject: Re: [PATCH] pack-objects: fix performance issues on packing large deltas
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 20, 2018 at 7:40 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Jul 20, 2018 at 05:39:43PM +0200, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
> > Let's start with some background about oe_delta_size() and
> > oe_set_delta_size(). If you already know, skip the next paragraph.
> >
> > These two are added in 0aca34e826 (pack-objects: shrink delta_size
> > field in struct object_entry - 2018-04-14) to help reduce 'struct
> > object_entry' size. The delta size field in this struct is reduced to
> > only contain max 2MB. So if any new delta is produced and larger than
> > 2MB, it's dropped because we can't really save such a large size
> > anywhere. Fallback is provided in case existingpackfiles already have
> > large deltas, then we can retrieve it from the pack.
>
> Minor nit, but isn't this 1MB (it was 2MB after one of your patches, but
> I think v2.18.0 has 20 bits)?

Argh.. I think I thought "2 ** 20" in my mind then typed "2 << 20" in
python. And I thought I made a mistake in my previous commit message
because it does mention 1MB...

> > With this, we do not have to drop deltas in try_delta() anymore. Of
> > course the downside is we use slightly more memory, even compared to
> > 2.17.0. But since this is considered an uncommon case, a bit more
> > memory consumption should not be a problem.
>
> I wondered how common this might be. The easiest way to see the largest
> delta sizes is:
>
>   git cat-file --batch-all-objects \
>                --batch-check=3D'%(objectsize:disk) %(deltabase)' |
>   grep -v 0000000000000000000000000000000000000000 |
>   sort -rn | head
>
> The biggest one in the kernel is ~300k. Which is about what I'd expect
> for a normal source code repo. Even some private repos I have with a lot
> of binary artifacts top out at about 3MB. So the new 32MB is probably

I'll keep these numbers in v2 commit message, easier to find later.

> > [1] With a small tweak. 2.17.0 on 64-bit linux can hold 2^64 byte
> >     deltas, which is absolutely insane. But windows builds, even
> >     64-bit version, only hold 2^32. So reducing it to 2^32 should be
> >     quite safe.
>
> I'm not sure I completely agree with this. While 4GB deltas should be
> pretty rare, the nice thing about 64-bit is that you never have to even
> think about whether the variable is large enough. I think the 2^32
> limitations on Windows are something we should be fixing in the long
> term (though there it is even worse because it is not just deltas, but
> entire objects).

I guess that means we stick to uint64_t then? It does increase more
memory on 32-bit architecture (and probably processing cost as well
because 64-bit uses up 2 registers).

> > @@ -2278,6 +2274,8 @@ static void init_threaded_search(void)
> >       pthread_mutex_init(&cache_mutex, NULL);
> >       pthread_mutex_init(&progress_mutex, NULL);
> >       pthread_cond_init(&progress_cond, NULL);
> > +     pthread_mutex_init(&to_pack.lock, NULL);
> > +     to_pack.lock_initialized =3D 1;
> >       old_try_to_free_routine =3D set_try_to_free_routine(try_to_free_f=
rom_threads);
> >  }
>
> This is new in this iteration. I guess this is to cover the case where
> we are built with pthread support, but --threads=3D1?

If you mean the "lock_initialized" variable, not really. the other
_lock() macros in builtin/ call pthread_mutex_lock() unconditionally,
which is fine. But I feel a bit uncomfortable doing the same in
pack-objects.h which technically is library code (but yes practically
is a long arm of builtin/pack-objects.c), so lock_initialized is there
to make sure we don't touch uninitialized locks if somebody forgets to
init them first.

> Given that we no longer have to touch this lock during the realloc, is
> it worth actually putting it into to_pack? Instead, we could keep it
> local to pack-objects, alongside all the other locks (and use the
> lock_mutex() helper which handles the single-thread case).

You probably notice the lock name is not "delta_size_lock". I intended
to reuse this for locking other fields in struct packing_data as well.
But that might be a bad idea.

I have no strong opinion about this, so if we still end up locking the
whole functions, I'll just move the lock back close to the others in
builtin/pack-objects.c

> Your original patch had to copy the oe_* helpers into the file to handle
> that. But I think we're essentially just locking the whole functions:

I'll try to avoid this lock when deltas are small and see if it helps
the linux.git case on Elijah's machine. So we may end up locking just
a part of these functions.
--=20
Duy
