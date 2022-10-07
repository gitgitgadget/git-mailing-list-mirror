Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231FAC433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 14:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJGO62 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 10:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiJGO6I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 10:58:08 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC25D102DE5
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 07:57:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id 13so11920666ejn.3
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 07:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Xlgz//yTzmutVW4iG34RksxokZbpsFQ/j88HqsAojo=;
        b=kxFBAJcojUrvLXvnkGnklPTm6PT0On47w25TB8zgjxWQYgkYkf6itbxhaMiU2NHnn3
         Y9RnJuAbQNdOBxuNUSPtdOobjZ/GwPp4ttGB1nADyZ2X91VJZpon3h1fNRZuP1j07dT7
         TEzKj7wIA/IrzT7jmEDdvXH+VRMmBQa/XgICLqjlZCPAXuc4rA6/czHtWfbkQq1QUfYM
         hhRBjywGLsLrjr1u2yyIZKd7snFeyEoYisVIROQdozB1gDPiz6q0v+UAyjtCCwBIY1l+
         yT9O8+fu0fIzC9xXDxmU/EWiLgFMmHOSey10Qb6lUubxANVUs/dt/4F+GVBqz+efL85B
         UnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Xlgz//yTzmutVW4iG34RksxokZbpsFQ/j88HqsAojo=;
        b=pf9QZ7+NsMmdOLgb0aRq4EHeLhmjciNha4FyfGiy5dFaT12m9m+W8jJhQ5BYJnolm8
         4LRASHblG+mE++aZoReKEeA+QvtmZ0XvODZBdeM6I5njXvtYLZyI3cztibZoX+lY3MH+
         VkbEIcLG7/1Gsn3dvBlePyDtpYmKMk98AcwI01mtoWPiY/U/idhGOd04/nT9LHbt6e8d
         71mOPAHzKNARzxICtSul3G2yvRSqBPlIXpr6ixxAbVvY2REJ/Yc7itvVs8+faxFBiXDg
         jO2OfaAtFnPnl34yXu+ezR1wVx07YDwAJj8Ajk//qjZoKOQE4Ao6p4hJBvmvi0XmI1af
         a1AA==
X-Gm-Message-State: ACrzQf2mA7zyKn9xjRQIy15tS2ofPD23PXVEgQVzDPHXyzGqIlArLgd2
        qdXP1uriTbYerqByQO+kWGLa0TE+BcVRkKSBwwyV8kyA2/Q=
X-Google-Smtp-Source: AMsMyM7OWJaqY7V1TNtExXLUkOYOFCTQuxXsw8B3WKdft6k5TUW7bTPkHVhA73iMwDiNUrf4+eLF0Ej+Bx6vhhfeths=
X-Received: by 2002:a17:907:e94:b0:782:1b85:f887 with SMTP id
 ho20-20020a1709070e9400b007821b85f887mr4564016ejc.222.1665154644161; Fri, 07
 Oct 2022 07:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAApTLm9DJW6zARsbJOCEcahkuLHA23tCF=rJ1Vy0J+kufBfTGA@mail.gmail.com>
 <CA+JQ7M9082jsYsVtRCocAkXU5-C-=gs3vOvgP8G3CKbyz872KQ@mail.gmail.com>
 <CAApTLm9ME2GAvqa2+F7ZL8oLjOEdYPrgC2hP3uZLdypP-1fxAQ@mail.gmail.com> <CA+JQ7M-rdFomPh106KFFCgEdHPKNTQZTUZz7Vu1Hx5GKdtY7qA@mail.gmail.com>
In-Reply-To: <CA+JQ7M-rdFomPh106KFFCgEdHPKNTQZTUZz7Vu1Hx5GKdtY7qA@mail.gmail.com>
From:   ddady <ddady1@gmail.com>
Date:   Fri, 7 Oct 2022 17:57:13 +0300
Message-ID: <CAApTLm-C_rJOx5LgAk+XvZYTzWq5_ceGdVos7WXYQYHYF57tDg@mail.gmail.com>
Subject: Re: A possibly mistake on the "Git Commands - Setup and Config page"
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've looked in progit2 repository and under "First-Time Git Setup" :
https://github.com/progit/progit2/blob/main/book/01-introduction/sections/f=
irst-time-setup.asc

It says: In the case of Notepad++, a popular programming editor, you
are likely to want to use the 32-bit version, since at the time of
writing the 64-bit version doesn=E2=80=99t support all plug-ins. If you are=
 on
a 32-bit Windows system, or you have a 64-bit editor on a 64-bit
system, you=E2=80=99ll type something like this:
$ git config --global core.editor "'C:/Program
Files/Notepad++/notepad++.exe' -multiInst -notabbar -nosession
-noPlugin"

which work perfectly on my computer. i'm using 64 bit ver. I don't
know what plug-ins it doesn't support (maybe along the way i'll find
out), but as long for open if i commit without the -m flag, it works.

On Fri, Oct 7, 2022 at 1:27 PM Erik Cervin Edin <erik@cervined.in> wrote:
>
> On Fri, Oct 7, 2022 at 11:45 AM ddady <ddady1@gmail.com> wrote:
> > On Fri, Oct 7, 2022 at 10:13 AM Erik Cervin Edin <erik@cervined.in> wro=
te:
> > >
> > > On Fri, Oct 7, 2022 at 8:12 AM ddady <ddady1@gmail.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > If i'm not mistaken, the path of configuring Notepad++ as default t=
ext
> > > > editor 64 bit version is: "C:\ProgramFiles\Notepad++\notepad++.exe"
> > >
> > > Can confirm this seems to be the default path for the 64-bit installe=
r
> > I didn't quite understand. It was a question?
>
> No I mean that I can confirm that this seems to be the default path
