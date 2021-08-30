Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98D1C43214
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 13:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAC2960295
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 13:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbhH3NWz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 09:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbhH3NWy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 09:22:54 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D44FC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 06:22:01 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id i21so31158156ejd.2
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 06:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=xVGblh7pUoMVCvXm3v7QPOfU89ZEsEG/Fc/kPSsd4do=;
        b=K07hoRzdRAJJXWnl4RB4eMRDhE4Z0lfp14p9YQ6vF+gYdNgkHzDl6RV21TxOQ6/Gj9
         GqB/ktiiGUcJrdtvRfV5Bav0M0JHplSYmZWlqrxEpnkZYzXxOwUWF3rb1ExGR8/spqs8
         h/rWBIIHJJlC2jh5uyJ46Tzmw5TcWe/8glqk+lIAbXmYTcOb4F4A+Sfed2XNz1HE1H4J
         lGCqVxjYoR3IjSCf+rTQxdVxaTHs9iXXfsBcdGWkQBPiwhVVb8ZrH4/dHFypGL8vrs51
         P0m7NRqynsAa7+X5JbiKboSvacEHJOsENDiDUd8Y7hwehJfeUpI9zlg5u9e+Pq9lYFZz
         s9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=xVGblh7pUoMVCvXm3v7QPOfU89ZEsEG/Fc/kPSsd4do=;
        b=cQoOPNJXJB2/kLOPtEL2rREBGD5PVaDLECpB36R1dBav05+5d5RwzBT5/hOdSY/ls1
         uo6irLNiuGUrtB6/oDwTDQGPAWZ5ZKYGOyrV0iCT91YW1sBYBnkFRKOyCXFJBnJfHutP
         WciAMJ2PsTBNgYQUFitKXXJZfLrnUWuxBX4SE5co3WDyjGddC7N6PqGB3tgU0kzsx6FG
         aWTIbMcUvEoWwc7yRkWtmEhI+hScmR/TBAY2mmK9Glm9a5iIGv1jPNyn/MJuO9QTDQkC
         EXGLpDljH3zq5um+Z83+6QuI+92JH08dNJ6ufQdCwqITQunlfdPyFXJ5zlzEMvmv6ri9
         V+2g==
X-Gm-Message-State: AOAM532TZzqIXjDbdIj2wnnp1wNtCu27aGC9X+mqkUJ9ggf5NmKUmV1p
        sepCKkUUmfqmVhzu5L8Qrog=
X-Google-Smtp-Source: ABdhPJyO692Czu76ObIbRdlcXuqqfa2hIespNblaJjjusa/xAoe20gvMKRzDM0Wkmpq0vPjRBo7VAA==
X-Received: by 2002:a17:907:2d8b:: with SMTP id gt11mr25604023ejc.432.1630329719234;
        Mon, 30 Aug 2021 06:21:59 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id lb12sm6772985ejc.28.2021.08.30.06.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 06:21:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v4 27/28] reftable: fixup for new base topic 2/3
Date:   Mon, 30 Aug 2021 15:01:50 +0200
References: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
 <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
 <patch-v4-27.28-c4f9fb42d9e-20210823T120208Z-avarab@gmail.com>
 <CAFQ2z_MnJr58Cu970Be7SXE1jFkgOGThQ0Geq2+kNihJE3_BvQ@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CAFQ2z_MnJr58Cu970Be7SXE1jFkgOGThQ0Geq2+kNihJE3_BvQ@mail.gmail.com>
Message-ID: <87r1ebxe2y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 30 2021, Han-Wen Nienhuys wrote:

> On Mon, Aug 23, 2021 at 2:13 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> Since my "refs API: remove OID argument to reflog_expire()" we don't
>> have the "oid" as part of the reflog_expire() signature. Instead the
>> reflog_expire() should pass the OID of the tip of the "locked" ref to
>> the prepare_fn().
>>
>> In files_reflog_expire() we do that by getting the OID from
>> lock_ref_oid_basic(). I'm assuming (but am not familiar enough with
>> reftable...) that by the time we get here we've got a locked ref
>> already in some way, so let's just use
>> refs_resolve_ref_unsafe_with_errno() to lookup the current OID of that
>> presumably-locked ref.
>
> I quickly looked at the files code, but I don't understand why the OID
> needs to be passed-in (before your refactoring): in builtin/reflog.c
> (before), the current OID is read, with any protection. This means
> that its value can't be trusted.
>
> After your refactoring, you lock the ref. I guess in the files backend
> this protects against non-atomic update of (ref, reflog) racing with a
> concurrent reflog expiry? In reftable, the (ref,reflog) update is
> atomic, so there is no need for locking to properly sequence
> operations.

Before my [1] we'd do:

 1. Read the OID for the branch in builtin/reflog.c
 2. Pass it to refs/files-backend.c, it would lock at that OID (or fail if =
it changed)
 3. Pass the OID with the now-locked OID to the builtin/reflog.c code

After that [1] we do:

 1. Lock the branch in refs/files-backend.c
 2. Pass the OID with the now-locked OID to the builtin/reflog.c code
    (ditto #3 above)

Whatever reftable itself does with updates doesn't change that we need
to do that 2nd step of passing the OID to builtin/reflog.c, as it makes
use of it.

That code is a bit confusing, if you want to understand it I recommend
reading it at the tip of my yet-unsubmitted
avar/cleanup-refs-api-and-reflog-expire-post-no-eisdir, it makes the
control flow a lot cleaner.

So as far as what we do here is concerned, we're stuck with the refs
files backend inherently wanting to pass "I locked this for you, here's
the OID".

I guess it could also pass "OK, now go ahead and expire" and pass no
OID. We'd then in builtin/reflog.c lookup the current OID for the logic
there, but just having the reftable backend appease the common API by
looking up the OID and passing it seemed like the most straightforward
thing to do.

I haven't tested this or thought it through, but I don't understand how
reftable isn't going to race in reflog expiry then. Sure, the ref/reflog
update itself is atomic, so it won't suffer from the needing-a-lock
problem of two concurrent file backend writers doing the equivalent of:

    echo $NEW_SHA1 >.git/refs/heads/some-branch

But we will need at least the optimistic locking of code like
builtin/reflog.c wanting to do an expiry, and deciding whether to do
that expiry based on a given state of the ref/reflog. I.e. we don't
want:

    1. Start reflog expiry
    2. Code in builtin/reflog.c looks up the OID
    3. Code in builtin/reflog.c decides whether expire the reflog
    4. Concurrent with #4, another writer updates the ref/reflog pair
    5. Code in builtin/reflog.c says "OK, expire it!"
    6. Reftable queues a delete/prune of the reflog per #5.

This would be a sequente of updates to the ref/reflog, none of whom were
racy as far as the reftable semantics itself are concerneb, but where
we'd do the wrong thing because the writer thought we had A when we
really had B. So we need the equivalent of an "git update-ref" with the
"<oldvalue>".

Is there a better way to do that in this case that I'm missing?

1. https://lore.kernel.org/git/patch-v5-09.13-aba12606cea-20210823T113115Z-=
avarab@gmail.com/
2. https://github.com/avar/git/compare/avar/files-backend-remove-dead-errno=
-eisdir-6...avar:avar/cleanup-refs-api-and-reflog-expire-post-no-eisdir
