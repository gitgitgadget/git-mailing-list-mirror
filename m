Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2CCC433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 20:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 647F922BF3
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 20:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rc3UHZ4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgHCUAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbgHCUAO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 16:00:14 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C3FC06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 13:00:14 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s16so25789824ljc.8
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 13:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5HWPD2jJcfpXOEx7+AEBgGxlbMf+IjOPgUcXhKOwj9U=;
        b=rc3UHZ4tHziv2EJg/iqe69wkR5kNVwuoJgT6qm3uzXu9mVVVgtkBa3Cw43fKX28SYg
         nPlh+8jRpUeY9v0VFX1Np+UMtNIB0j5c0TfH3W7w3aSFwHkDQLDdslVEq5H1nNch1BDv
         56aALQzIrNrOCKQ6rLZYASu/lFrwlUNF+4NZrRaEs6u1ZCAHSpG1qxjMHkAZPs/f5rnF
         0glZydJMCL1DIcEVOoCu4oCi8wgRqcTPgxw9qTSHcjuHdzKFe+2VN2QE7Z9N88DHYerk
         wps/ChbHzi0DS4Zemt8otSLZrckZ+jPXzzIVYjq7L3vW6r9jMENP8qe02uMiLHE54e0k
         Cd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=5HWPD2jJcfpXOEx7+AEBgGxlbMf+IjOPgUcXhKOwj9U=;
        b=UFt/WCUQfntBn6YudqofU8NPRCcafPWyLfodTnrSAzAa9EEhDXgtOMsqyrV3zrsXOY
         3Mvjxo1k2dSP4q4/FyIbj8jqHi03t/R6b7JOK5tFZ2n7i8aXymjKtxS/LCMhs6nuqFBF
         IjoKwx4Y+WYD/Z677VP3qD9dkw9fxfCxg9EoA8h1FSfeXueqscTrhOXTCtx0sni5zl8D
         8Stp/MbRgB4z/QDmeN4Pe0njfWyg7XeSvkRZrdYAumk2DkCshNsGYKJhAHYOvI8reDhv
         Naid9No8Q0SgpYiytDIxoGTJ5VJOMPXtUGvFyIoOc5rNBELn21V3OliGSoA5xW4urAnR
         pR6g==
X-Gm-Message-State: AOAM5334+nwt4ZFTfvAM7dSSI0t26OvSj1bHHC9xX+Xm5aTEGbePRip0
        +mQzPJxBTDfJ5Im2EO9yA74=
X-Google-Smtp-Source: ABdhPJwN+4iHq6WaXqZmiSozSId0wXQTYB7upEHnxgc28xP2KO3/p+PkowP0+f4t2E+czx0mxi9PDQ==
X-Received: by 2002:a05:651c:1349:: with SMTP id j9mr8103592ljb.392.1596484812918;
        Mon, 03 Aug 2020 13:00:12 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id s4sm5231532lfc.56.2020.08.03.13.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 13:00:11 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200728163617.GA2649887@coredump.intra.peff.net>
        <20200729201002.GA2989059@coredump.intra.peff.net>
        <871rku3soc.fsf@osv.gnss.ru>
        <20200731230858.GA1461090@coredump.intra.peff.net>
        <87mu3drynx.fsf@osv.gnss.ru> <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
        <87o8nrybnb.fsf@osv.gnss.ru>
        <20200803180824.GA2711830@coredump.intra.peff.net>
Date:   Mon, 03 Aug 2020 23:00:11 +0300
In-Reply-To: <20200803180824.GA2711830@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 3 Aug 2020 14:08:24 -0400")
Message-ID: <871rknsdo4.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Aug 03, 2020 at 06:47:20PM +0300, Sergey Organov wrote:
>
>> > A command line option that takes _optional_ argument is evil; it
>> > hurts teachability (e.g. "why does this option always require
>> > "--opt=val" and refuses '--opt val'?").
>> 
>> Yeah, I sympathize.
>
> Sorry, the optional argument was my suggestion. I don't think they're
> that evil, but I agree they require extra knowledge for the user. I
> don't mind avoiding them when possible (and it's definitely possible
> here).
>
>> > Introduce --diff-parent=(none|<parent-number>|c|cc|all) that is
>> > different from --diff-merges, and -m and --[no-]diff-merges can be
>> > defined in terms of that, at which point we can gradually deprecate
>> > them if we wanted to, no?
>> 
>> Sounds great, I only hoped we can do it right now, with this new
>> --diff-merges option, maybe as a pre-requisite to the patches in
>> question, but Jeff said it's too late, dunno why.
>
> It's too late for "-m" to change semantics (we could do a long
> deprecation, but I don't see much point in doing so).

I thought not of changing semantics of -m. Suppose we introduce

  --diff-merges=(none|<parent-number>|c|cc|all)

before your patch(es). Then your patch would read: "making --first-parent
imply --diff-merges=1" and it'd miss that --[no-]diff-merges part, no?

> But --diff-merges is definitely still changeable until we release
> v2.29. My resistance was mostly that I didn't want to complicate my
> series by adding new elements. But we could do something on top.

Can't we do yours on top instead? I'd expect it'd then be even simpler.

Thanks,
-- Sergey
