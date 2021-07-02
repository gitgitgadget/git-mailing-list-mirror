Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09437C07E95
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 19:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD23B613DF
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 19:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhGBTbT convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 2 Jul 2021 15:31:19 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:45657 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhGBTbT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 15:31:19 -0400
Received: by mail-ej1-f42.google.com with SMTP id hc16so17819860ejc.12
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 12:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fHKYiqxfBRF8kOsywhbae+S/zsJ0nQHRUA/t3iWXYtE=;
        b=XUlyOLg0jnQiHfu2aRjHA+y7wTx0vLlFCmGbIHV8uDwSLlJwZCUg4NabXCW23AGYTE
         vnJDt9uqv17zcTxTQoFw1Sgx3T9aJvtlpQVloeCbu3YgfalImVn+V98tLsbueDrvHEgP
         0NeiJjxE52EpvJUvhEQ+JrMgXT0FiO4r01KX2sq3ri/A0/S+W1y26dr3hetL7O0F6xBV
         iAhxafzYDtDZi0oOolD97FDgAWa6W5vCO2Wpb6oAE5Zf9M/ugEwuHZDrQmLYOgv0INWw
         aMxgaKh6cqRfrcReQmepZuDJZMHcfnYVTyaZe4VxdjZ8Nwe9TnAfMX2ZK5vbvayivLg3
         mjPA==
X-Gm-Message-State: AOAM531n5VlK1uiVCC5sPZ2o6tWnqYUP2hFJ/c5Barm5a9nfChZQGsxJ
        KWEfuiNhcae03SclgVYzFgFppukOSG3YMSBA4P4=
X-Google-Smtp-Source: ABdhPJySTEDFifbjSy1QJH6QMuIEJNAf84cagoqK0zeKURY1QoePrWp58Ob1TTlB7ZSIkBkQYxvFvf/JJS0JWUIC+IM=
X-Received: by 2002:a17:907:7d8c:: with SMTP id oz12mr1377563ejc.202.1625254124987;
 Fri, 02 Jul 2021 12:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
 <9568baf5dddcc0637c15f698aea24d230c4d01b2.1625155693.git.gitgitgadget@gmail.com>
 <87czs0alhg.fsf@evledraar.gmail.com>
In-Reply-To: <87czs0alhg.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 2 Jul 2021 15:28:33 -0400
Message-ID: <CAPig+cQinUsEZqEDb2_zhi37SdYuBCVEznmFbXPJuFB5cFznKg@mail.gmail.com>
Subject: Re: [PATCH 08/15] [GSOC] ref-filter: add cat_file_mode in struct ref_format
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 2, 2021 at 9:33 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Thu, Jul 01 2021, ZheNing Hu via GitGitGadget wrote:
> > +             if ((!format->cat_file_mode && used_atom[at].atom_type == ATOM_REST) ||
> > +                 (format->cat_file_mode && (used_atom[at].atom_type == ATOM_FLAG ||
> > +                                            used_atom[at].atom_type == ATOM_HEAD ||
> > +                                            used_atom[at].atom_type == ATOM_PUSH ||
> > +                                            used_atom[at].atom_type == ATOM_REFNAME ||
> > +                                            used_atom[at].atom_type == ATOM_SYMREF ||
> > +                                            used_atom[at].atom_type == ATOM_UPSTREAM ||
> > +                                            used_atom[at].atom_type == ATOM_WORKTREEPATH)))
> > +                     die(_("this command reject atom %%(%.*s)"), (int)(ep - sp - 2), sp + 2);
>
> Maybe it was brought up already, but those ATOM_* are mostly continuous
> where they're declared, Maybe worth making it so having a comment like:
>
>     /* These need to be in order, used in verify_ref_format */
>
> And then just doing:
>
>     used_atom[at].atom_type >= FIRST_OF_THOSE &&
>     used_atom[at].atom_type >= LAST_OF_THOSE
>
> Maybe it's too magical and peeking under the hood of an enum...

Aside from the potential maintenance burden of the `atom_type >= ...
&& atom_type <= ...` approach, another problem is that it increases
cognitive load. The reader has to go reference the enum to fully
understand the cases to which this code applies. On the other hand,
the way the patch mentions the enumeration items explicitly, it is
obvious at-a-glance to which cases the code applies. An additional
downside of the suggestion is that the range specified by `>=` and
`<=` may cause some readers to think that there is some sort of
implicit relationship between the items in the range, which doesn't
seem to be the case. So, I find the way it's done in the patch
presently easier to comprehend.
