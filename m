Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FECC35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 20:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58C320720
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 20:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZtoZcs1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgBEUM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 15:12:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33698 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgBEUMz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 15:12:55 -0500
Received: by mail-pf1-f194.google.com with SMTP id n7so1793715pfn.0
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 12:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wwiw/nninTJlLb+E+O1r+t4VyVLJDKkPGCpKKMu4ye4=;
        b=aZtoZcs1O+9cWtUpGXvSeP1VLXv2ivrC2j0NE6zpzXHMOGk5m6YavbDI9+WneGfAM1
         7tiohkKv3hPI3eC+i2/l8yEyr3HT6MyP38knN2+rD9VW6NObzJXr7IvLH2/Bnr5NaFmY
         VxfdcTv7Spe8/OiC7CpWUFS1gRx1Xp/G7zgLuBNfaSD47RUoEAVb59lOmlGpvkoaKFCk
         uiKMxW1oYLGJ+oX1ZRAKaSgZ1dVf6s3qZ2Kfv0ZXbZYO6vSNGz6t6KEcw4/MVO+o330m
         GLIQK7nY4aeC6vNGi7vdxPSldapDBrV/FmGayyqP2xd8pntC1axwFq3a982UE0Noogxd
         GQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wwiw/nninTJlLb+E+O1r+t4VyVLJDKkPGCpKKMu4ye4=;
        b=bjOeWYTeuCUigx+qEB6CtMYFkvThsxew9phxN+vfVq7IOQRbZ9IeeoNvZmma4wgpv/
         oRpvkq+AfxasHR2lLNbTdu49cxQ8KIfo57BrVCH8TLP3B500RNC+c+1J9EucQVh8NMMn
         ZxKXMcp/QiSDVp0xetiaADAc2bn1Mrci+nEgKiOUZqTSxyCJPd0jUkJDLDNdg9VxNQ+6
         GpmBC/25XCfJmZYfvR4Pzfi1dsSGplw2qPwlNeFll+WI0bQdclhU1/t8giRcBAixfmqk
         lft6n4V2BHHstvKWFtvLAd20tP63cRwV6KiH2uoatexJv1LkJS/BE++4rgi4SAS4s5ez
         R41g==
X-Gm-Message-State: APjAAAX+/DAogJfran/x4P2p2rgVZugUsv26VO98El2CE46VQUZ8xdzq
        tDa417wMV+ZadP90hVkMgbVIeWQPH+xQJ2Ocmq4=
X-Google-Smtp-Source: APXvYqzdjsQ00nEkAFm0tWf+N/BSHoYNQenucsLbYlJHDU8bZ+eq5dcRDnIQhpzigPVot/SZDVGCONAQgISUvIcEBPY=
X-Received: by 2002:a63:4282:: with SMTP id p124mr36808638pga.155.1580933573598;
 Wed, 05 Feb 2020 12:12:53 -0800 (PST)
MIME-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com>
 <20200124033436.81097-11-emilyshaffer@google.com> <CAN0heSo_Ois83gqNrHvNn2HSMMTXvKShxTb_RdG2qY6D7rnthA@mail.gmail.com>
 <20200205023127.GL87163@google.com>
In-Reply-To: <20200205023127.GL87163@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 5 Feb 2020 21:12:42 +0100
Message-ID: <CAN0heSpkjACrgz8T=-VoQxgMZhMM-oSSpVz4HAPB27b_h3fGpA@mail.gmail.com>
Subject: Re: [PATCH v5 10/15] bugreport: add config values from safelist
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 5 Feb 2020 at 03:31, Emily Shaffer <emilyshaffer@google.com> wrote:
>
> On Fri, Jan 31, 2020 at 10:25:06PM +0100, Martin =C3=85gren wrote:
> > On Fri, 24 Jan 2020 at 04:40, <emilyshaffer@google.com> wrote:
> > > Taking the build-time generated array and putting it into a set saves=
 us
> > > time - since git_config_bugreport() is called for every option the us=
er
> > > has configured, performing option lookup in constant time is a useful
> > > optimization.
> >
> > I'm sympathetic to your sending out what you have to obtain comments,
> > knowing that it's not perfect. It would have saved me some time and
> > effort if I'd known that this was the case though. An "[RFC]" tag,
> > perhaps. Or at least tweaking the above part of this commit message to
> > say that this might be over-engineered, with a reference to [1].
> >
> > [1] https://lore.kernel.org/git/20200124032905.GA37541@google.com/
>
> Yeah, you are right, and thanks for the feedback. I think I had wrapped
> up the series before I realized there were those significant outstanding
> comments, but I definitely should have said so in this patch.
>
> >
> > > +       int safelist_len =3D sizeof(bugreport_config_safelist) / size=
of(const char *);
> >
> > I was going to suggest ARRAY_SIZE, but then I realized there are some
> > outstanding questions around whether you need this stuff in the first
> > place. I'd be inclined to guess that the first version of this would be
> > "for each safelisted item, obtain it and include", ignoring any "a.*.b"
> > business. In which case you wouldn't really need this hashset stuff.
>
> Regardless, I think it's worth doing nicely for now.
>
> It seems to me that supporting wildcarding in the config safelist is a
> superset of supporting static strings in that safelist - that is, if I
> write it simply to support static strings, a later change to support
> wildcards would be welcome and non-breaking.

Yeah, agreed. Also, whatever magic the code for gathering the config
items knows, the annotations in Documentation/, i.e., the generated list
in bugreport-config-safelist.h will be "synced". That is, until we know
how to handle "a.*.b" in the safelist, we probably won't be marking
"a.*.b" as safe. And even if we have some crazy mixed build, it's a
*safe*list, so we should be fine. (Famous last words?)

On that topic though, and just so we don't mess up from the beginning,
in the documentation, we typically write something like
"branch.<name>.merge", i.e., not "branch.*.merge". So I guess the
"a.*.b" feature would be more like "look for '.<', something, something,
'>.'." Would that be sufficient? Or would we actually want more
fine-grained control, i.e., something like regexes?

If so, we'd need to provide those regexes somehow, e.g., as part of the
asciidoc macro notation. :-/ Do we need to prepare somehow for such a
future? I don't think we do.

> So I'm going to clean this up without making it more featureful, for
> now.
>
> Sorry about the confusion!
>  - Emily

No worries. :)

Martin
