Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D09EC433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 21:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 505CA64E42
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 21:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhBPVtF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 16:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhBPVtB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 16:49:01 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5DEC061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 13:48:21 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id z190so5038142qka.9
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 13:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K26VOproB/cPhlsnRdtswsLYBL+3VVMUH15aicL9o0U=;
        b=nyPbAi8YeMrEtcgJkPm6IQ/pEBmi/B+ywH5EvIbAeRqI585YckAgLv4GrOzZHxC6ga
         UhPnXDzq7errOe8xyEbzft7LIxOd7jIp86ReyUnV/tSStlcEqghaN8248hIqdpR1+BUg
         Ek6hXtZyNbuHN7n9R4ptRJ1uqCpBdlITG3ckIknUtEdkp9cO07gHItahs1zRH13WMYR8
         Q67yPU7vYXyWq8RNe7XLpoBjGFXRG6s6/gc1lg3r1hgWIKTjmWHLzilucrI+UPh7yQjK
         ZwMue75gLwo+t/nU+BhPUTytl7yqLCE0uGFJzozt2+/e5ucgUj5C0TpPisn4+HAnu+O3
         7MHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K26VOproB/cPhlsnRdtswsLYBL+3VVMUH15aicL9o0U=;
        b=TaM5wQbdY/d1aDqtIFEFXg17QJqfRTZliHeLBx0ywo4pI1bbccrYxc0Ba5In4vnc5M
         J6WOWAMSO+PAPjF9fAHLOoLfUJ9uj5aB2FkRq6WxrUIOgOZLKWh9RgB1ij1frv/waiFb
         cUGVhB3bCcdxI0oBOe3y28vWQZ4Qup1I5pDjN2en411juQaimIGo8RDnJaeebkFnMaCY
         OS7f/YGwv6kW35eqyiifw5GWpObgi05337O2xXg5XXGPNDI0X1AHFSQxS8iQu3fVbOiR
         txqO06DYBHhJENPtezAeZ0Lc1+4UtHA7r362FPi+PRdp+wZKQcqj/dIl7wqWyvMXa+dt
         VDzw==
X-Gm-Message-State: AOAM530kbXI7gm7LD2bt8wNDj+P6u9ZM9yeireET4xY0q+GAm8wFKJ1p
        epDah2u5eB/nW+s543a+REmJBA==
X-Google-Smtp-Source: ABdhPJzjEFhAbGZ8NWAS9b1B0d5fo/03MnCJBovUt60QJ8zJ/tKjksCKvlIVaMcQNw/9UQngksW2Jg==
X-Received: by 2002:a37:a9d6:: with SMTP id s205mr22344664qke.162.1613512100344;
        Tue, 16 Feb 2021 13:48:20 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:aeda:db8b:7233:8f54])
        by smtp.gmail.com with ESMTPSA id r80sm163629qke.97.2021.02.16.13.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 13:48:19 -0800 (PST)
Date:   Tue, 16 Feb 2021 16:48:17 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v2 1/8] packfile: introduce 'find_kept_pack_entry()'
Message-ID: <YCw9oX9EEEzo5Kaj@nand.local>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1612411123.git.me@ttaylorr.com>
 <f7186147ebb0b2d01d8f1e0f742f367204d7d9c9.1612411123.git.me@ttaylorr.com>
 <YCw8TmDdEfcnZSOo@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCw8TmDdEfcnZSOo@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 16, 2021 at 04:42:38PM -0500, Jeff King wrote:
> On Wed, Feb 03, 2021 at 10:58:50PM -0500, Taylor Blau wrote:
>
> > Future callers will want a function to fill a 'struct pack_entry' for a
> > given object id but _only_ from its position in any kept pack(s).
> >
> > In particular, an new 'git repack' mode which ensures the resulting
>
> Nit (not worth re-rolling): s/an new/a new/

Oops. Good eyes.

> > There is a gotcha when looking up objects that are duplicated in kept
> > and non-kept packs, particularly when the MIDX stores the non-kept
> > version and the caller asked for kept objects only. This could be
> > resolved by teaching the MIDX to resolve duplicates by always favoring
> > the kept pack (if one exists), but this breaks an assumption in existing
> > MIDXs, and so it would require a format change.
>
> I don't think this would be possible without a major rethink of how
> midxs work. The "keep" property of a pack is not set in stone when the
> midx is created. You could add a ".keep" file to one of its packs later,
> or even mark one as an in-core keep on the fly. But the duplicate
> resolution happens at creation.
>
> So maybe your "breaks an assumption" is the notion that we do not store
> duplicate information at all in the midx. If so, then I agree. :) But
> I'd also call fixing that more than just a format change.

That's part of it, indeed. The part that I was referring to is that
existing MIDX readers expect duplicates to be resolved in a certain way
(effectively in favor of the pack with the lowest mtime). So the easy
part is indicating a format change which tells new readers how to expect
ties to be broken.

But (as you note) that's only part of the problem: even if we say "ties
are resolved in favor of the lowest mtime pack, or a .keep one, if it
exists", then which ones are kept and which aren't? Even *if* we wrote
that down (which I'm not suggesting we do), kept-ness isn't an immutable
property of the pack, and so I think relying on it is a tricky direction
to take.

> (None of which changes your point, which isn't that it isn't worth
> pursuing that direction).

Yeah; my hope in writing some of this down in the above paragraph is
that it would make clear to future readers that such a MIDX change would
resolve some complexity here, but the complexity it adds in the MIDX
code isn't worth the tradeoff.

> -Peff

Thanks,
Taylor
