Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5838DC433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 05:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiBXFOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 00:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiBXFOw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 00:14:52 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9FC1662EE
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 21:14:23 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id vz16so2017888ejb.0
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 21:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UZMJf7Ay/bLdYJUnZk3E/Ut0xBDX9EafrRLkuxrBE3M=;
        b=IIdUbyhL4XY7HD9Iqlo2NF0/Sdx1WqiEgjU3Tafigd168tm3VVnKX7b+vnTpALttuw
         43X2PRS+72D/U1GB1hptme5PyrrcHVefVlLG5ARHWIr3MZ7Ya/f/T7HwqJOs529/DgZL
         huzgrxlY9n3JHS91ENvgktAmqvBGMFV1/tKqE9iOxKBvbjfcdaH8+HpSk59vSkhiaKtB
         ZxE0jRDwWb4InDrIkYGzhI+H2MNO+r/zzNyMTdYxzZUGLtNKlKZ5ElHUzZ3AUf3YW+L5
         dPrh6ZF7CS5mV5pJHoaunE25fzkRPE8P7J77e1rzolKPYvEqTmeEWfejj2ZCNn5fI+xB
         zxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UZMJf7Ay/bLdYJUnZk3E/Ut0xBDX9EafrRLkuxrBE3M=;
        b=ofZRVrQmqSymYegYKx7NMCDdVBIw2RGbsGiwExe7Nn0vhANzhcJr10SarSHJ+xXX/s
         +9yRw8B/EGkBcTwwQgr63W/oxWGc44i+ZbBl7nkbTrIQKgK7dM166aQRzx+x/rl3GCDB
         fNu2CG0wqx5U4mEQTpqyyZQgZ07+QEX6HwcDFwlE7oo8rNhlMnM0mrZ89oj/QOmsuHAo
         FTeiK+gz/JNj4CYqE90KgLGOC1uAaaLzsMEUS1rBpsDYthJZYaiiGpPJcCduRAWiGVUp
         ywP1ftfUE/79ZVY8AeYbxNR6meiowF45n1RYoEA6GFGZQLwIbsdnAWApHqthM5anHHps
         EfJw==
X-Gm-Message-State: AOAM532R/JGi271zSdRoA2gEP1FgW9DzHVpg3xjkOw22nCMUjU64vukN
        WGal1xyt0w6ZGl0JWfpiMKveU7yBcSfEOKGMBt4=
X-Google-Smtp-Source: ABdhPJzUYHkDuHB6MHqHFE4ZwsaLmml1z85DtXyaQwcAXGkteyc89URPAcTVIwhRus+c0O6vaRGFKJ3VQpZu8ErusHc=
X-Received: by 2002:a17:906:370f:b0:6ce:6e7:7344 with SMTP id
 d15-20020a170906370f00b006ce06e77344mr840033ejc.654.1645679661923; Wed, 23
 Feb 2022 21:14:21 -0800 (PST)
MIME-Version: 1.0
References: <20220222114313.14921-1-shivam828787@gmail.com>
 <20220223115347.3083-1-shivam828787@gmail.com> <20220223115347.3083-2-shivam828787@gmail.com>
 <xmqqo82xthjy.fsf@gitster.g>
In-Reply-To: <xmqqo82xthjy.fsf@gitster.g>
From:   Shubham Mishra <shivam828787@gmail.com>
Date:   Thu, 24 Feb 2022 10:44:09 +0530
Message-ID: <CAC316V7QDgZL0jOzgE-Ae86Phmf4XpeQdbKfNS3uA8uL_0uzKw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] t0001: avoid pipes with Git on LHS
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

HI Junio,
 I acknowledge, this patch is here by mistake, we don't need to merge it.

Thanks,
Shubham

On Thu, Feb 24, 2022 at 2:40 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Shubham Mishra <shivam828787@gmail.com> writes:
>
> > Pipes ignore error codes of LHS command and thu`s we should not use
> > them with Git in tests. As an alternative, use a 'tmp' file to write
> > the Git output so we can test the exit code.
>
> I do not know what thu`s is, but the above describes a sensible
> criterion to decide which pipe to touch and which pipe to leave
> alone.
>
> > -             find .git/worktrees -print | sort >expected &&
> > +             find .git/worktrees -print >tmp &&
> > +             sort tmp >expected &&
>
> And this change or ...
>
> >               git -C ../linked-worktree init &&
> >               test_cmp expected-exclude .git/info/exclude &&
> >               test_cmp expected-config .git/config &&
> > -             find .git/worktrees -print | sort >actual &&
> > +             find .git/worktrees -print >tmp &&
> > +             sort tmp >actual &&
>
> ... this change squarely contradict the reasoning written in the
> proposed log message.  These pipelines place "find" on the upstream
> of their pipe, and "find" is not something we are worried about
> introducing new bug into.
>
> >               test_cmp expected actual
> >       )
> >  '
