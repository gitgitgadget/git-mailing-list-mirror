Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E20C4332F
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 13:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354038AbiDONkY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 09:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354039AbiDONkI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 09:40:08 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ADB2DEA
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 06:37:05 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b15so9952371edn.4
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 06:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=LBN3uKyLD0diekh8TmG+4aCESoUkq22a57EjFHP08i0=;
        b=CEfu4NwQoGh+aCAypXh7jAf2J4LCnyFDOh0suuRJh9867XrcUOuGcvpRjAimjfLf9C
         vBr344o7QAvBpcn5F1/syHREtlo8wpvt+KuFsMo6aHBfWyZBVrmFuucJXXlk56QHKK1t
         mMo8Co+nl8+BBOqivYekbNJ2eIzjFsyA7kGOn7+T3VUcrGgpL0+kycFFhcDAH4Bb1X3o
         yxIFqxL5YwFJ+rnFHx3UGyCJGKLM9uvIVx7Jw6ruB3/sbqp+qoeOZ4lc3cTHjX5UJZC1
         2FzlUEqlI6MXTBgm/XKFavF1+G3yMeay2besKdVJNBL/BdLPQfhd5MZs9vd63WNJ3FnL
         3Nhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=LBN3uKyLD0diekh8TmG+4aCESoUkq22a57EjFHP08i0=;
        b=qK3SL6HRgxBEHvwaqEsA/8DsZuO4OW2lUBjirTAxH7LH4SQW9HvsYEADIPjBw3VF4S
         GaEdccYVpVWSSsvDtcSg0IhTOoEZUNFg/RF344PTqboDzkonqFC5epJc3r6xplIs4QSf
         odlR0dBddhj2LBduLr19Gl39vIDxJE3TLt1HIr1r5Gw7EdvpsOtqgrFMGEBkdO2eAxYx
         JcEzxjUQdx05sZcw5kiD9M9X2BZTHtTmBNzQBp+NMcZEF+nvjcb0yKAL7KBjNUXRlrbB
         H7yQD/nJmAlhPyY6rV7hvm/SE3WrUgwcV8RdDqVodnP4hnZi0h1yVgQplaw1xuiVu22U
         3N4g==
X-Gm-Message-State: AOAM530wILtRNl4edjzT3cYPipiBAXBlPIsIXeb3Q9mm2dfUcttepVWd
        eYLrFjTFy/fXoo0KpU/1UfbB/P/hBZ7IHA==
X-Google-Smtp-Source: ABdhPJwpbOs5ETJtGmClie5gb+F3++MDQzn06B9rCZx1kFgwoGUZHLDyP32j1zYNjqNaeZS+5pJBCw==
X-Received: by 2002:a05:6402:11d4:b0:419:5a50:75a4 with SMTP id j20-20020a05640211d400b004195a5075a4mr8328815edw.226.1650029823942;
        Fri, 15 Apr 2022 06:37:03 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id dd6-20020a1709069b8600b006df08710d00sm1696279ejc.85.2022.04.15.06.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 06:37:03 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nfM8E-005f5U-Qy;
        Fri, 15 Apr 2022 15:37:02 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] http API: fix dangling pointer issue noted by GCC 12.0
Date:   Fri, 15 Apr 2022 15:30:42 +0200
References: <patch-v2-1.1-777838267a5-20220225T090816Z-avarab@gmail.com>
 <patch-v3-1.1-69190804c67-20220325T143322Z-avarab@gmail.com>
 <Yj4FwuyEW0b5ImEC@nand.local> <xmqqy20x7eqv.fsf@gitster.g>
 <220414.86h76vd69t.gmgdl@evledraar.gmail.com> <xmqqo8131tr8.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqo8131tr8.fsf@gitster.g>
Message-ID: <220415.86o812bh8h.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 14 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Having spelunked in the GCC docs, source, commits involved & in their
>> bugtracker I don't think they'd consider this broken. It's working as
>> designed.
>>
>> Now, of course as with any new compiler warning you might argue that
>> it's too overzealous, but in this case it's included it a -Wall in GCC
>> 12.0.
>
> Whatever.  I do not care if this is a broken or wai from GCC's point
> of view.
>
> I care more about the correct operation of the production code of
> ours, than a workaround to squelch a warning, overzealous or not, by
> a compiler, and if it is not clear that the workaround is obviously
> free of negative side effect, we do not want to deliberately introduce
> potential breakage in our code base just for that.
>
> And I still do not see how it is safe to unconditionally clearing
> the pointer in the slot instance to NULL.  It was asked late January
> in https://lore.kernel.org/git/xmqqv8y52g3a.fsf@gitster.g/

The v3 re-roll at
https://lore.kernel.org/git/patch-v3-1.1-69190804c67-20220325T143322Z-avara=
b@gmail.com/
(see range diff) was intended to address both your question there &
Taylor's at https://lore.kernel.org/git/YhprAb1f1WYIktCV@nand.local/.

> In other words, what we should have been spelunking is *not* in the
> GCC docs and code, but the http codepath in our code that depends on
> the slot not being cleared when we didn't set up the pointer in the
> current recursion of that function.  With a clear description on how
> this change is safe, with a clear understanding on why the pointer
> member "finished" was added in the first place to avoid the same
> mistake as an earlier round of this patch [*1*], it would become an
> acceptable patch, with or without GCC warning.
>
> Namely, the finding in this part of a review comment [*2*]
>
>     The only way the separation could make a difference is while
>     step_active_slots(), the current slot is completed, our local
>     "finished" gets marked as such thanks to the pointer-ness of the
>     finished member, and then another pending request is started
>     reusing the same slot object (properly initialized for that new
>     request).  In such a case, the while loop we want to see exit
>     will see that slot->in_use member is _still_ true, even though
>     it is true only because it is now about a separate and unrelated
>     request that is still waiting for completion, and the original
>     request the caller is waiting for has already finished.
>
> that was made to explain why the pointer member is there, and a
> possible case that the code before the introduction of the pointer
> would misbehave and today's code would behave better, worries me the
> most, as unconditionally assigning NULL there like this patch does
> without any guard would mean that we are breaking the code exactly
> in such a case, I would think.

I think that accurately describes a logic error in the v1 of this patch,
i.e. we can't remove the "finished" member, but per the v3 explanation I
believe (re-)setting it to NULL is safe.

> In short, I do not care who takes the credit, I care more about the
> correctness of the code than a warning by a version of a compiler, I
> do not care at all if the compiler writers considers the warning a
> bug, and I worry that the change proposed, while it may certainly
> squelch the bug, may break the code that has been working happily,
> and I haven't seen a clear explanation why it is not the case.
>
> As long as the same slot is never passed to run_active_slot()
> recursively, clearing the member unconditionally when the control
> leaves the function should not break the code.  Nobody seems to have
> explained how it is the case.

I tried to explain that in the v3, but that was part of what you
edited/amended in your applied version of it.

I don't know how to answer your concerns/questions other than as I've
already done there.
