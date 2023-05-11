Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB26C7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 20:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238914AbjEKU7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 16:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbjEKU7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 16:59:25 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454A47EF1
        for <git@vger.kernel.org>; Thu, 11 May 2023 13:59:24 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-38ef6217221so5026964b6e.3
        for <git@vger.kernel.org>; Thu, 11 May 2023 13:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683838763; x=1686430763;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56XY7tthaYOxeB3xRCslTBPHbTczs2b78vxw6E8uBCM=;
        b=msR9/Ad4eIr5Fy8HL3sCbGBFUMzsTjCW7zV4+71owZ5fFkt6AwBjbDciJ/eIZvMGJS
         TufiMKgbpUyqwq2y/UQzORt9TxacnSzhZXFOjOUjVlrmmG2hPs4O3oUWftjEBkEYy6cm
         v7Bf59oaax/rQWVDwryT4ESTSUx96Qrm3hhtgrfu+mTujdMKFScPtEzxDihrzuTX5oQ0
         7bYlyObqGlzGuifI6WVMx6Zz64wTEObCEN0Zni5Ynv07gsHqc12KCP6XVJunzJFDUfPc
         7G/cxTUEuvRdo9mpgGST1H9gPs3RLJkq17ZYTsmTkZUVrCZ72m2NvotSH5GvoI+veYwV
         awQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683838763; x=1686430763;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=56XY7tthaYOxeB3xRCslTBPHbTczs2b78vxw6E8uBCM=;
        b=gnDMK68OGf8Cv4ozS8N1KNLldZ+eofk7yCaZ8sZeeHPuguSUkuFErrNbJr8tJAhrLW
         Obn/8GwpJCd850svqU1yPshHstnqyxc6x6DfAhHN59HqQlLuW4gVafNIE8x2jEvhMhcO
         IBRD52M9Dxlb0STYzIJsNCYWZ9VwqaH69otaQ8Vmiv2s9sPzti3G/kuz0swPNZqkSB/5
         Bavb/AB/sMKTgK9GP7RPCwijg7a2KSmIuqM2eNv1U4o0Xb8nrW+X9Lalkw8TLcfWrpvE
         zyCtnD6L7arG8SrdOvaQNvM0i5evhS/swnVG02mBLoaehWzLB8hmqS/TnamOKGDAku6X
         k4lg==
X-Gm-Message-State: AC+VfDwhBnUdg6LI/JicF6qvf4BWha2XX6xe/+Df8pwRSyVwFjFAMbCl
        zqS5N8GCuy9NzbLnTiKIoKADK7O2YJY=
X-Google-Smtp-Source: ACHHUZ6eZ3+jjvhIFtVPSE1XRH5rzDhJwtabPpQqvnclXnAD6B4d4EjR7zbDcxL49VzQSWnaDG0VZg==
X-Received: by 2002:aca:6747:0:b0:38e:1ee1:982 with SMTP id b7-20020aca6747000000b0038e1ee10982mr5494383oiy.7.1683838763540;
        Thu, 11 May 2023 13:59:23 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id q24-20020a4a3018000000b00524f381f681sm8199289oof.27.2023.05.11.13.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 13:59:22 -0700 (PDT)
Date:   Thu, 11 May 2023 14:59:22 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Matthieu Moy <matthieu.moy@univ-lyon1.fr>
Message-ID: <645d572a47e5b_57c4e294dc@chronos.notmuch>
In-Reply-To: <87mt2azkdp.fsf@osv.gnss.ru>
References: <645c5da0981c1_16961a29455@chronos.notmuch>
 <871qjn2i63.fsf@osv.gnss.ru>
 <645d28e112294_26011a294b2@chronos.notmuch>
 <877cte200m.fsf@osv.gnss.ru>
 <645d3dbf785a5_26069229463@chronos.notmuch>
 <87wn1ezms9.fsf@osv.gnss.ru>
 <645d480be344d_260ff5294c@chronos.notmuch>
 <87mt2azkdp.fsf@osv.gnss.ru>
Subject: Re: Can we clarify the purpose of `git diff -s`?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Sergey Organov wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >> 
> >> > Sergey Organov wrote:
> >> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >> >> > Sergey Organov wrote:
> >> >> >
> >> >> >> I'd rather think about generic interface for setting/clearing
> >> >> >> (multiple) bits through CI than resorting to such convenience
> >> >> >> tricks. Once that is in place, one will be able to say "I need these
> >> >> >> bits only", "I need to turn these bit(s) on", and "I need to turn
> >> >> >> these bit(s) off" conveniently and universally in any part of Git CI
> >> >> >> where it's needed.
> >> >> >
> >> >> > It's possible to achieve both.
> >> >> >
> >> >> > Imagine your ideal explicit interface. In that interface the default
> >> >> > is no output, so you *have* to specify all the bits, for example:
> >> >> >
> >> >> >   git show --patch
> >> >> 
> >> >> No, that's not what I meant. There is no point in making "git show" to
> >> >> have no output by default, please see below.
> >> >> 
> >> >> >
> >> >> > Or:
> >> >> >
> >> >> >   git show --raw
> >> >> >
> >> >> > In this ideal interface it's clear what the user wants to do, because
> >> >> > it's explicit.
> >> >> >
> >> >> >   git show --patch --raw --no-patch
> >> >> >
> >> >> > Agreed?
> >> >> >
> >> >> > My proposal achieves your ideal explicit interface, except when no
> >> >> > format is specified (e.g. `git show`), a default format is chosen for
> >> >> > the user, but that's *only* if the user hasn't specified any format.
> >> >> 
> >> >> My point is that the default format should be selected as if it has been
> >> >> provided by existing options, rather than by some magic hidden in the
> >> >> code.
> >> >
> >> > But why?
> >> >
> >> > I don't see any benefit, only drawbacks.
> >> >
> >> >> > If you explicitely specify the output format that you want, then the
> >> >> > default is irrelevant to you, thus you have your ideal explicit
> >> >> > interface.
> >> >> 
> >> >> That's not what I had in mind, sorry. It'd rather be something like:
> >> >> 
> >> >>   --raw: set "raw" bit and clear all the rest
> >> >>   --+raw set "raw" bit  (== current --raw)
> >> >>   ---raw clear "raw" bit (== --no-raw)
> >> >> 
> >> >> In this model
> >> >> 
> >> >>   git show
> >> >> 
> >> >> would be just an alias for
> >> >> 
> >> >>   git log -n1 --patch --cc
> >> >> 
> >> >> and no support for a separate command would be need in the first place.
> >> >> 
> >> >>   git show --raw
> >> >> 
> >> >> would then produce expected output that makes sense due to the common
> >> >> option processing rules, not because somebody had implemented some
> >> >> arbitrary "defaults" for the command.
> >> >
> >> > But now you are at the mercy of those "arbitrary defaults".
> >> 
> >> No, see below.
> >> 
> >> >
> >> > Let's say those defaults change, and now the default output of `git show` is
> >> > `--stat`.
> >> >
> >> > Now to generate the same output you have to do:
> >> >
> >> >   git show --raw
> >> >
> >> > in one version of git, and:
> >> >
> >> >   git show --no-stat --patch --raw
> >> >
> >> > in another.
> >> 
> >> No: --raw in my model clears all the flags but --raw, so
> >> 
> >>   git show --raw
> >> 
> >> will produce exactly the same result: raw output only.
> >
> > But that {--,--+,---} notion doesn't exist, and I think it's safe to say it
> > will never exist. So, could we limit or solution-space to those solutions that
> > could have the potential to be merged?
> 
> I didn't expect it to exist any time soon, just showed a different way
> of options design.
> 
> >
> > What you suggest could be easily achieved with:
> >
> >   git show --silent --raw
> >
> > But because no other format is explicitely specified, following my notion of
> > defaults, that's the same as:
> 
> The problem that I tried to fight is this notion of defaults that is
> somewhat special, so, if I allow for it, the rest of my suggestions
> becomes pointless,

No, they don't, all you need to do is specify the default explicitely.

> and without the "defaults" with non-trivial behavior[*]
> 
>    git show --raw
> 
> won't work as expected provided --raw still just sets "raw" bit and
> doesn't clear all the rest.

It works perfectly fine. There are no bits to clear, because there are no bits
set.

That's the whole point of defaults: you don't have to use them. If you don't
like the notion of defaults, then don't use them.

If you specify *any* format option, then the defaults are ignored and no bits
are set other than the ones that you explicitly specified.

> [*] Defaults with trivial behavior is just initializing of internal
> variable holding flags with specific value, that is exactly the same as
> putting corresponding option(s) at the beginning.

Those are not default arguments, those are initial arguments. In many cases
they behave the same, but not all.

-- 
Felipe Contreras
