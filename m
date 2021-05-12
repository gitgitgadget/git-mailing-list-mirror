Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1D7C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 03:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C888861177
	for <git@archiver.kernel.org>; Wed, 12 May 2021 03:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhELDW5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 23:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELDW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 23:22:56 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8663CC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 20:21:49 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id v14-20020a4ae6ce0000b02901fe68cd377fso4655732oot.13
        for <git@vger.kernel.org>; Tue, 11 May 2021 20:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=0y/9iiK///smKxcA3KmBf7PixwDOR2XbB4h8aDqOQi4=;
        b=syZdTRbBBve9SyCTXjULZV2OAZ7mPsZt3f6aujl9DCgaMh3x3zEQcgO+pkOTSkGEDr
         M0qSaYaaF77Xf1+2vzDcG2WRgXL+Mr5LPfAQeVmTGNGKKkThXBFUVTxcIOMWkt7LtrSw
         UKVt0KcJqfOmK9Y8Bnew15i1b3D03+ySM98oxRKMAovACdh0IwYXwcy7LtiWsF5wUhxZ
         vOo0XsWn6zDJfA1ygbBVd2C4dxJgqq38DmhuxPaCfLHpviSweklWhm/1bdFZml/RWOMX
         vGpXQNDHnReYHTwjuz7msxMaoVnxOMzPat8B4W1t5gdgMx6vMvtg2XqIjr6d9JENeQFq
         obcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=0y/9iiK///smKxcA3KmBf7PixwDOR2XbB4h8aDqOQi4=;
        b=EzOqJDqPPwgd439CAc+4oU/tCmvnEgFuugCt9h5PFpIzEqTbmm+A5HTBdCmII87vKa
         KKbEhmUBAnGHelrYKaXTEA1LtrLIMWihVQU9nTyk7bUhg1gD2rESD95i3UtYhStSZEdQ
         MkvMevGRZw98ZY+hBxab/d0rXVW1xkHD/lHxrrBwCaElI9hr/21mLGZrlVXUGEmTKZfu
         28xvKWFHnrH6OglWwloYW8ggrNrRmvEA9mQoGz3Mex+HsTjiaglPKpAP5j5p1Yse7sio
         8EMMQfM2rYye+ghb72yIqQwD/0DTJaITs3n97FWH1lt/lq5N0LBDLSI48iz8F/I6hQsT
         5CdQ==
X-Gm-Message-State: AOAM531WrOcUpDg8k8g44z5hltsciQSF6TKsj23jtX1JEgaHJWx/9Mls
        yITTp6XHr6IPPAD7chyjEwg=
X-Google-Smtp-Source: ABdhPJwAHeMoIoFyZmMuD494B1WJADJnwt8w2Rgvs0GCp4KLcjfjd3gJXBOBKGZ8JAdxwxhcgffISg==
X-Received: by 2002:a4a:8311:: with SMTP id f17mr22980857oog.83.1620789708958;
        Tue, 11 May 2021 20:21:48 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id r83sm810429oih.48.2021.05.11.20.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 20:21:48 -0700 (PDT)
Date:   Tue, 11 May 2021 22:21:44 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Varun Varada <varuncvarada@gmail.com>, git@vger.kernel.org
Message-ID: <609b49c85d761_678ff208cd@natae.notmuch>
In-Reply-To: <20210511202502.GM12700@kitsune.suse.cz>
References: <CAD2i4DBj6fNvq=Lc3KiXJj5uBpteyKfEKp7ATOWrTE36KUeRww@mail.gmail.com>
 <20210406092440.GZ6564@kitsune.suse.cz>
 <CAD2i4DDr3Ftk6RE8cA74iSsJTpC9nEb=Cqvr79pF51BpcWEnsA@mail.gmail.com>
 <609ae224aa509_6064920851@natae.notmuch>
 <20210511202502.GM12700@kitsune.suse.cz>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Such=C3=A1nek wrote:
> On Tue, May 11, 2021 at 02:59:32PM -0500, Felipe Contreras wrote:
> > Varun Varada wrote:
> > > On Tue, 6 Apr 2021 at 04:24, Michal Such=C3=A1nek <msuchanek@suse.d=
e> wrote:
> > > > while using "will not impact" in an incorrect or unclear way may =
be a
> > > > problem the word "impact" in itself is not "jargon".
> > > =

> > > The word means "to have a strong or marked effect on" (v.) and "a
> > > strong or market influence" (n.) when used figuratively; it is not
> > > synonymous with "affect" and "effect", respectively, as shown even =
by
> > > all of the entries you've cited. Using it as such is the incorrect
> > > part, so those are the instances I've changed in the diff.
> > =

> > There are two ways impact can be used as a verb: transitive and
> > intransitive, but git doesn't seem to be using the intransitive form.=
 In
> > the transitive form it usually means to strike "the car impacted the
> > tree". But it can also mean to have a desired effect "reducing CO2
> > emissions impacted climate change".
> =

> I don't know where you find the 'desired' effect meaning. Certainly non=
e
> of the dictionaries I consulted at random provides such definition.

You yourself consulted Merriam-Webster [1]:

  impact _verb_
  : to have a direct effect or impact on : impinge on

Did you not? [2]

> > None of these are used in the documentation, we have things like:
> > =

> >   the index does not impact the outcome
> > =

> > Which is clearly wrong (unless we are talking about possitive outcome=
 of
> > the outcome, which makes no sense).
> =

> It is not clearly wrong. To me it makes perfect sense. If you want to
> claim it's wrong please provide a source for your claim.

Merriam-Webster [1].

> > As a noun it can mean a siginificant or major effect: "the impact of
> > science".
> > =

> > However, the documentation is not using it that way:
> > =

> >   the runtime impact of tracking all omitted objects
> > =

> > The noun usage is less wrong than the verb usage, but it's still wron=
g.
> =

> Why is that wrong?

Because it's not a "a significant or major effect" [1].

> How did you infer that the effect is insignificant or minor?

I did not.

If I claim temperature $x is not hot, that doesn't mean I'm claiming
it's cold.

> In fact while some dictionaries list 'impact' as 'have strong effect'
> the Oxford dicrionary lists is as simply synonymous to 'affect'.

Synonymous doesn't mean equal. In fact, the Oxford dictionary defines
"impact" as [3]:

 the powerful effect that something has on somebody/something

Note: *powerful*.

> > But why bother? The word "affect" is a much superior choice.
> =

> Why bother with a chenge at all?

Because it's better.

Do you have any evidence that it's worse?

[1] https://www.merriam-webster.com/dictionary/impact
[2] https://lore.kernel.org/git/20210406092440.GZ6564@kitsune.suse.cz/
[3] https://www.oxfordlearnersdictionaries.com/definition/english/impact_=
1

-- =

Felipe Contreras=
