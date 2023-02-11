Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82273C05027
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 01:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjBKBo1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 20:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKBo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 20:44:26 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3288E2A6EE
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 17:44:25 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-142b72a728fso8931875fac.9
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 17:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jade-fyi.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nzKVbVJguxId+Fmj1b2IvSWroKqcTWTl/vDhiGYDfg=;
        b=Cn8GMPEHYm/dA22vCaRgcKJe1iD52DaKhQ37v+/tCYaxX4bRgNx9KL3aEQfcQoY+Tl
         A9d2d06Ea41KeF8hNhmKcNubBNeqOCst9dVoshrjPXQGdiBuOshfhKAYt0G1TG4ovmIv
         9VfdDJeRZpoB5bzzmZMAjt8W15OieAwghAK0l3ja/r0E4EbbT8cQRoSiBRBZi9qgytgw
         wQeibVOby2+ET2+ycHIYrwGkFtVOJNE0pfl1Vr0LykLrymTGbUq7uqUn9xabOhfOhrvW
         H5doOCSGAzWbM1c0Bgumy9jYqH9+z/GI1bNvFRNxeda6vOg+TSlEYXpqGCyBzCn+60fm
         C3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nzKVbVJguxId+Fmj1b2IvSWroKqcTWTl/vDhiGYDfg=;
        b=X0UzcpBL2+knj8MyPYpfvLspNiQC2IIDcWbvvd2/XWWbymfd+wCojUr1FlKNUGdyYt
         nAHc4vUv4QqTQ5ZyqXs/Ahmbc1cvUlEtm4xRdWMewnDyRLj8cmvxFYAOVVCxaZYDAooA
         fB7M9RH76Y0cI1drDnSnb44dELL/5H2HiCf1n7OnThl57azVQ2i1Q3iCLewxts2PX25p
         QWxmpiU96IAU41HsJr5wM0ejKYFd9xhCl3wQTwLXvVLdV9u7VXC0RuWu6eo1IOxvCyKn
         G7iUkeyuQvNmCVWtoZ7clzVLOyVrJRpHT9unUm/rWJKJ5Ecdh4eH/V/R3vvKo8mmFqyb
         Q6VQ==
X-Gm-Message-State: AO0yUKVJ/dWxFWFaps+FIrLPXclNDn+zT3oCgMTmUuHuJJhswAMbHkqy
        HvM36b01FqpvEktHuND8UWdjuV09PGyVcHMvlwE2dQ==
X-Google-Smtp-Source: AK7set/Rml/pyw5KsaWPBOd8oDXqPFJAqkeYZzBBEH3BV/KRDl8LZruLySCftMx6ylzJk8Mm18ZTHxU9nSHsvCWRoZ0=
X-Received: by 2002:a05:6871:721:b0:16a:941e:d2fe with SMTP id
 f33-20020a056871072100b0016a941ed2femr1110293oap.171.1676079864541; Fri, 10
 Feb 2023 17:44:24 -0800 (PST)
MIME-Version: 1.0
References: <CAFA9we-QLQRzJdGMMCPatmfrk1oHeiUu9msMRXXk1MLE5HRxBQ@mail.gmail.com>
 <xmqqsffdf0ji.fsf@gitster.g>
In-Reply-To: <xmqqsffdf0ji.fsf@gitster.g>
From:   Jade Lovelace <jade@jade.fyi>
Date:   Fri, 10 Feb 2023 17:44:13 -0800
Message-ID: <CAFA9we---t=uMy3LmxnU0Hz_9XAR-YFsDqDX16CoNpkiPitFnA@mail.gmail.com>
Subject: Re: BUG: git config --global --get ITEM ignores ~/.config/git/config
 when ~/.gitconfig is present
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the reply.

=C2=BB git config --get-all --global user.name ; echo $#
0

Same result, no output, exit code zero.

Jade

On Fri, Feb 10, 2023 at 5:33 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jade Lovelace <lists@jade.fyi> writes:
>
> > Then:
> >
> >  =C2=BB git config --global --get user.name
> >  =C2=BB git config --show-scope --show-origin --get user.name
> > global  file:/home/jade/.config/git/config      Jade Lovelace
>
> With "--get" replaced with "--get-all", what do you see?
>
