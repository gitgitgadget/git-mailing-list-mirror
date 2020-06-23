Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C92C433E1
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D41320702
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391742AbgFWUfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:35:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55579 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391059AbgFWUfu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 16:35:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id g75so91903wme.5
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 13:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9FWs85BKplA0Hi4MFZjU7A4AU44neQQNn2X3Bce4rOI=;
        b=hf2LM6syYCeyqvdeRVRsYQ9OAcyTJZ10drSxISYL78PcGw0XC0LUO0mCtPcNhp18h8
         f6tCCFynEcE0b+sgmiS83mKYe10HprR7FrslW1xVqDdFGXpicg/T35c6WZU95IVpMEnr
         3BOQEJhpHe29ZSuomYDDNQ1t9pkuN1S/BWIgb0Mip4BqNOw8VQgDzXgGDQoF8FzTJyUC
         9rTJowhRafXzwQxd8iTEwxXn58yuU/9zz0Lcvl31wTEIi/p7gagTWDEc0SnKrCdP4ZNG
         lvFg4EFopgWKPn4p/TNLg6Fx1vF7mv0S1fY6DdW2mUjfiRUtBGI2rvtDtjgW9uIuArbq
         3f8A==
X-Gm-Message-State: AOAM531ZzEh2UCp4fyXR6Yy7fOi8+CwUFNIwUVadylG96EK5onUGY8kQ
        +NV45IA7elqILaWX7vJvsRScG06fiiu5dE/ULq4=
X-Google-Smtp-Source: ABdhPJwqMYAhCgqDBMBGzGmlaO/TTyGF/Ej5PTxZtUPsh+oyVG7PKGXLv0JVeCJmndPYd7z+4QO2Nuim3yyjfXgeNEA=
X-Received: by 2002:a1c:1d1:: with SMTP id 200mr25663616wmb.11.1592944549159;
 Tue, 23 Jun 2020 13:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200623152436.GA50925@coredump.intra.peff.net>
 <20200623152505.GI1435482@coredump.intra.peff.net> <CAPig+cQ1EGR6_8NJ+U3MQEseU1yT9k_AwdL8Mg7qZAB8Ev4y3g@mail.gmail.com>
 <20200623183525.GB1444619@coredump.intra.peff.net>
In-Reply-To: <20200623183525.GB1444619@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 23 Jun 2020 16:35:37 -0400
Message-ID: <CAPig+cTBwZJnUYqeEjXp-hAOjHb783B+9kyy+h+HtiOTy_c_hg@mail.gmail.com>
Subject: Re: [PATCH 09/10] fast-export: allow seeding the anonymized mapping
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 23, 2020 at 2:35 PM Jeff King <peff@peff.net> wrote:
> On Tue, Jun 23, 2020 at 02:11:51PM -0400, Eric Sunshine wrote:
> > By the way (possible bikeshedding ahead), "seed anonymous" seems
> > overly technical. I wonder if a name such as
> > '--anonymize-to=<from>[:<to>]' might be clearer and easier for people
> > to understand.
>
> I wrestled with the name, and I agree "seed" is overly technical. And I
> came up with many similar variations of "anonymize-to", but they all
> seemed ambiguous (e.g., it could be "to" a file that we're storing the
> data in).
>
> Perhaps "--anonymize-map" would be less technical?

That's not too bad. It is better than --seed-anonymized. I haven't
come up with any name which improves upon it.

> > In fact, in an earlier email, I asked whether --seed-anonymized should
> > imply --anonymize. Thinking further on this, I wonder if we even need
> > the second option name. It should be possible to overload the existing
> > --anonymize to handle all functions. For instance:
> >
> >   git fast-export --all \
> >     --anonymize=foo.c:secret.c \
> >     --anonymize=mybranch >stream
> >
> > Or is that too cryptic?
>
> Yeah, that was another one I considered, but it both seemed cryptic
> (after all, we're saying what _not_ to anonymize), and it squats on the
> "anonymize" option. So imagine we had another option later, like
> "anonymize blobs and paths, but not refs", that could easily be
> "--anonymize=blobs,path" or "--anonymize=!refs". I'd rather not paint
> ourselves in a corner.

Okay, makes sense.
