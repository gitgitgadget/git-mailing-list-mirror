Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EBFC33C99
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 05:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67EDC207FF
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 05:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DwZdEGlg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbgAGFPT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 00:15:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22044 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725267AbgAGFPT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 00:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578374117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GKBDc0WM+grIdl4O3GBSam3kcjFm3OkBCyg5aH+sYvA=;
        b=DwZdEGlg/VZVbUmhfZQG5zJeWWrUOGWgZ1928Bg72nlUnrhnMd5CUDNRWRDs7kxEqHTKfL
        4RZgaflmF/UIp2pEt5tNHMx7cdj2GcL1MUtejK4BgPP5YB/sHcUhTN6kj6mlDHrvROW+/S
        Ih6ifUyE3SANkcVyek3xN4zMQZr92cU=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-7vhxjD_HPzSpJwpILfK-GA-1; Tue, 07 Jan 2020 00:15:16 -0500
X-MC-Unique: 7vhxjD_HPzSpJwpILfK-GA-1
Received: by mail-oi1-f198.google.com with SMTP id m127so11597151oig.19
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 21:15:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GKBDc0WM+grIdl4O3GBSam3kcjFm3OkBCyg5aH+sYvA=;
        b=oOndgUzUI4i4LQpGVEq1MSBgUUjh8yIVmrhwcfBSKkLGlt5ymIeAu4ykBoaaJXzIIe
         Kw9qU1j53Al2wpASXNQBBsx9f7S/EkMURuoPNv1IY5NyMg62dEP7ecqpvKEjb7T7xLHC
         X8+CncobLds1b6eoFxXQcYyI0A9sN0ONr5YuwuBeQHXm2lB59ceT9agNhQpl9CP8L1xJ
         Z/q7BDCaHVfT9wMVpxRnH1tVH8KItlnifUfTVcQuolCx4uCocbsYDbrGYQGl5opB4JJk
         2Qs5V0wQyjTTXMs4IaMtt1Ctuc2ZsBbsWcn9t3rG76FJJajWMqbNSB2NIwX+lPNINOjB
         2mwQ==
X-Gm-Message-State: APjAAAUBUL3YJPSMxtkDjhgjRxZkS+KvnwxUJcsHXptyDZi0CYKszOvr
        Vsh/0nuHOwmnPcJHGovEnDGIIo6XLCDT9YZYmoDJzl1uHBgqaUg9L5dMoiysVZ5F1Y2Ai/iGkPE
        qD/A6vEceBqui6xfurOUrrI5Sdfsz
X-Received: by 2002:a9d:60c4:: with SMTP id b4mr97503425otk.166.1578374115382;
        Mon, 06 Jan 2020 21:15:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqyNpRpjjHBpBcySsVdjJZ6GRE8iuKic3rVfxucK3PkG0T2vTJ8luCC9YaqSu3+WrttwubrL6/EYPjIMm9iYs9A=
X-Received: by 2002:a9d:60c4:: with SMTP id b4mr97503402otk.166.1578374115072;
 Mon, 06 Jan 2020 21:15:15 -0800 (PST)
MIME-Version: 1.0
References: <20200103120613.1063828-1-marcandre.lureau@redhat.com>
 <20200104004516.GB130883@google.com> <CAMxuvayT8FtovVnWU4bjQCP26drN37yuPG2+G2jAUsm0Ns_AYA@mail.gmail.com>
 <20200107000551.GE92456@google.com>
In-Reply-To: <20200107000551.GE92456@google.com>
From:   =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date:   Tue, 7 Jan 2020 09:15:03 +0400
Message-ID: <CAMxuvaxpoH_rLLyPENLtnBqcUq_RrwgP2GM6=P8QMA309wqFNg@mail.gmail.com>
Subject: Re: [PATCH] RFC: commit: add a commit.all-ignore-submodules config option
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On Tue, Jan 7, 2020 at 4:05 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Marc-Andr=C3=A9 Lureau wrote:
> > On Sat, Jan 4, 2020 at 4:45 AM Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> >> Marc-Andr=C3=A9 Lureau wrote:
>
> >>> One of my most frequent mistake is to commit undesired submodules
> >>> changes when doing "commit -a", and I have seen a number of people do=
ing
> >>> the same mistake in various projects. I wish there would be a config =
to
> >>> change this default behaviour.
> >>
> >> Can you say more about the overall workflow this is part of?  What
> >> causes the submodules to change state in the first place here?
> >
> > The most common case is, I guess, when you work on different branches
> > that have different (compatible) versions of the submodules.
>
> Ah!  This is because "git checkout" defaults to --no-recurse-submodules,
> which is a terrible default.

Thanks for the hint, I'll give it a try for a while and let you know.

> Does "git config submodule.recurse true" help?  If so, we can look
> into which it would take to flip that default.
>
> Thanks,
> Jonathan
>

