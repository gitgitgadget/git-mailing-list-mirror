Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C18C433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 13:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3ABE6193A
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 13:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhC2NZq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 09:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhC2NZN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 09:25:13 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E90C061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 06:25:12 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id r12so19441224ejr.5
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 06:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=bbBi2KsVqw3sxTZcMw2KLYO+k21j9JWiWFU/8ayKmHE=;
        b=m1Z8QwWLr9UVKFAoSGuV7N7aCnkVFL/1PvxT8bUT6SPluCH/zdA8WJGp2MdwIpVOCz
         XAb9oQWsVKpzta3uU/AxXQlJ4gie9yiG4V9E7K4g2d9x7Wo3D2s+Bt0rGVZqm28TY6Vv
         65z5N59OAKvgq1Cb1CWNUKzK7fxwHXmgHbQZxhoZQtQeFt8l4wR4UJYQA2EE2tOpCCyJ
         Lvzx4GwQbzhGjYGz6DXwqqVjm5uMf37fyFUaW8htzHgsnDcuYpUOSemxHq9tt/+X0dOA
         WZwLEyZxaLKAvqjGibXqcLBVsSTRWQBbV+8STtWl5W8JuGzwmbz3KbUX29dI8laa7au2
         ZIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=bbBi2KsVqw3sxTZcMw2KLYO+k21j9JWiWFU/8ayKmHE=;
        b=jjOF4Mf/4lBnKA1uJmSDba8QCUVjDIKbiWe/Ijz+DsVqFNBiKQbp46chkkT1zjOzoS
         pccUiQEELi+id23onDqYcklApEoVG8HTjv00FppluHTrQiPSvGd9OIhVhTv3ow793Ffh
         G8rdXtbTr9T64fXZ5fn5E4MYXldIQS3D7djio8aPyta2cSja2V+USVeYS8YZYGxYPMTc
         OYm7BQ9c4BR4m+Q62Oud38FaXASjCHWd2GNT+1HV4NLlD3mNI2c7TpjzXHuC2Z8w0SIP
         lCXbTZoVtR1JrZsvdzC1OyvIKQ7ZzSUkgrJWYPIZOtztQJNnfcDiU7J2uDaLPZFxhSCD
         z4+w==
X-Gm-Message-State: AOAM532I4ZA1rs46bVFRrRwztqtVeUCt4zv5436p3gnBaHJUUfbkVSVU
        anybZc4ur7/T5ukTE7LtkJMKXvtzMzk=
X-Google-Smtp-Source: ABdhPJxelR83/R4x6B+B5wPEqX1eFI8wSlqKsDRR/QSnXiwSndm2zJVZSIfaohvOEF/FuueqEjax5w==
X-Received: by 2002:a17:906:b817:: with SMTP id dv23mr29055287ejb.281.1617024310663;
        Mon, 29 Mar 2021 06:25:10 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id kj3sm8309653ejc.117.2021.03.29.06.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 06:25:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 4/4] usage.c: add a non-fatal bug() function to go with
 BUG()
References: <cover-0.5-00000000000-20210328T022343Z-avarab@gmail.com>
 <patch-4.5-515d146cac8-20210328T022343Z-avarab@gmail.com>
 <xmqqh7kvolgn.fsf@gitster.g> <YGAtkW2YWNbcAn8m@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YGAtkW2YWNbcAn8m@coredump.intra.peff.net>
Date:   Mon, 29 Mar 2021 15:25:09 +0200
Message-ID: <87tuoum6ru.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 28 2021, Jeff King wrote:

> On Sat, Mar 27, 2021 at 11:12:40PM -0700, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>=20
>> > Add a bug() function that works like error() except the message is
>> > prefixed with "bug:" instead of "error:".
>> >
>> > The reason this is needed is for e.g. the fsck code. If we encounter
>> > what we'd consider a BUG() in the middle of fsck traversal we'd still
>> > like to try as hard as possible to go past that object and complete
>> > the fsck, instead of hard dying. A follow-up commit will introduce
>> > such a use in object-file.c.
>>=20
>> Reading the description above, i.e. "to go past that object", the
>> assumed use case seems to be to deal with a data error, not a
>> program bug (which is where we use BUG()---e.g. one helper function
>> in the fsck code detected that the caller wasn't careful enough to
>> vet the data it has and called it with incoherent data).  If we find
>> a tree entry whose mode bits implies that the object recorded in the
>> entry ought to be a blob, and later find out that the object turns
>> out to be a tree, that is a corrupt repository and the code that
>> detected is not buggy (and we shouldn't use BUG(), of course).
>>=20
>> So, ... I am skeptical.  If the code is prepared to handle breakage,
>> we would not want to die, but then I am not sure why it has to be
>> different from error().
>
> Yeah, this seems like it is missing the point of BUG() completely.  I
> took a peek at patch 5/5 of the follow-on, which uses bug(). It looks
> like it should really be an error() return or similar. The root cause
> would be open_istream() on a loose object failing (which might be
> corruption, or might even be a transient OS error!).

I don't feel strongly about this bug() thing, I'll drop it if you two
don't like it.

But that's not why I added it, yes you can now carefully read the code
and reason that this code is unreachable now, as I think it is.

But it may not stay that way, refactoring how we handle I/O errors
etc. further down the stack is the sort of thing that if this bug()
wasn't there would cause us to otherwise silently lose the
error. I.e. does check_object_signature() always promise to return
non-zero *only* if the signature isn't OK?

So maybe we are happy to just make that promise, in which case yes, this
should/could be an error() in this case.

But isn't this also useful for multi-threaded code? E.g. let's say fsck
learns to map-reduce its fsck-ing of objects across threads. One of them
encounters a BUG(). Do we want to hard kill the whole thing or try to
limp ahead and report partial results from the other thread(s)?

We have than now with pack-objects/grep, but I'm struggling to find a
use-case for a partial grep result if e.g. PCRE fails with a BUG(...)
...

