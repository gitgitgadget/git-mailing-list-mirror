Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9A6C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 19:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6AE860E99
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 19:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhGWTDi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 15:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhGWTDh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 15:03:37 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDEBC061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 12:44:09 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id he41so5281553ejc.6
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 12:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=EOvQhAFTLOCBBLx2TJTjeudSbfYgThnPY7EKhDVH0yE=;
        b=WCC9jigLPm4rXu37cuouxZ1fZ73jzWpaIGldmkso7Z3sbM7py3ljx147gTWRukudzV
         4FRv3LO8agGwH/VxFEB9+kdGdNbppHcEtEUfE+se6W/zGjYGHDZ+eb0wkmS4i8ADdVWC
         sh9IMfLWZCjrtwN0Rvhgd7iKv7JfjNpz0npjEpvlVCL9hUnUS4d65Rll5aq//RuSFrvu
         oLUHvEc3V9o3w5UjBkC+YXRRDoyV1aDsQMxKYsMadpJrn6t5zp0CFYOty3ZYCJMHHRN/
         m7y5MRrdK9PaUESuG1xArFafADuq2q9bS2q7xHxNOOFVPH+A9pR3eY4LaENAEVLS8+Ly
         kD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=EOvQhAFTLOCBBLx2TJTjeudSbfYgThnPY7EKhDVH0yE=;
        b=eCIgarGfmsJjes8lrQmfMQKi+s+oI6ORSSH5ndlzKNPAriLfoAYYlIADYIZwpb6Xur
         BovGtGsIL2NGPtw0hrJswOFy42qvg2qfna+kLNrBtG3IXTqrAAPvtOE8f51Nd9us0Xxn
         0x1W+D/+Z89wVMRulvZEdvhvgmFIAzgFLp2sM0mg8AIs/eOk9ve2O0g/oCA/kf0l9VdL
         lS6s7dNzvVyASmC6VOSSeYU2b3RvSaJg6uXnulHTFqiddiloocyZ6/I7M+gDIsbWGo6k
         xnCinrKueMhDiK6rogCMC9nMulVrnFASyVQDiTgbknYXZU9LUBMvjBUkR1tjvUKtvcNy
         Xnlw==
X-Gm-Message-State: AOAM531jNMI3eZW8XCInIxs9SNLDKf1NmDCWujFdgpj42WevrsMjHmcD
        zZwFWjLE89B2LEFgd/YaTeY=
X-Google-Smtp-Source: ABdhPJy7k6P4QeWZCbPUSglYP0rCtgX984ExYrxJsNC66rQzMqp90Tm57o57KPUEWCQvjebEnrREsw==
X-Received: by 2002:a17:906:696:: with SMTP id u22mr6167621ejb.77.1627069447911;
        Fri, 23 Jul 2021 12:44:07 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id a25sm14520251edr.21.2021.07.23.12.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 12:44:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 06/12] refs API: pass the "lock OID" to reflog "prepare"
Date:   Fri, 23 Jul 2021 21:41:47 +0200
References: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
 <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
 <patch-06.12-295594fe8ae-20210720T102051Z-avarab@gmail.com>
 <xmqq35s7efb3.fsf@gitster.g> <xmqqy29zd0dv.fsf@gitster.g>
 <CAFQ2z_PuNJ_KtS_O9R2s0jdGbNNKnKdS3=_-nEu6367pteCxwA@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CAFQ2z_PuNJ_KtS_O9R2s0jdGbNNKnKdS3=_-nEu6367pteCxwA@mail.gmail.com>
Message-ID: <87lf5wstlv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 21 2021, Han-Wen Nienhuys wrote:

> On Wed, Jul 21, 2021 at 7:48 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>  Junio C Hamano <gitster@pobox.com> writes:
>
>  > This obviously breaks the latest round of reftable topic, as it
>  > still wants this type to take const oid, and I do not think using
>  > on-filesystem lock as if we are using the files backend is not a
>  > good solution.
>
>  Sorry for redundant negation.  "I do not think it is a good solution
>  to have everybody pretend as if they are files backend when they
>  lock refs." was what I meant.
>
> Reftable could easily read the current OID for the reference, if necessary. 

(I'm replying to a mail of Han-Wen's that didn't make it on-list due to
inline HTML, quoted here in its entirety sans signature, see
https://lore.kernel.org/git/87eebptr7i.fsf@evledraar.gmail.com/)

Junio: I can change the const around if desired. I thought we weren't
particularly concerned about it in general except to avoid the verbosity
of frequent casting, and in this case the lock API doesn't have "const".

But as for the reftable incompatibility it seems to me irrespective of
backend that a reflog API that supports expiry is going to want to have
a callback for "give me a lock to expire this branch" and give you a
reply of "OK, you have the lock, you can expire the log, and it's at
this OID".

Why would it be file-backend specific?



