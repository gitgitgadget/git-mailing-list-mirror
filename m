Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0C7C433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 07:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241586AbiDGHT0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 03:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241799AbiDGHTO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 03:19:14 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B7825AEFD
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 00:16:57 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t13so4233452pgn.8
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 00:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kmc21K7FeqgXMxdzhbT2k9TXEIkMXjI6cV+b5uRvCqI=;
        b=plZxeo3dOG3qAD8v/W9UXE+fexh6mJgQps16JdGIw66r49UPgbuKibIlVgmM62H/fa
         srZa+HOEgPTQWxuSqM1f5xkKzJWxW5hXkqeG4qCvKDcbFIlpXGtHYfuUbw3Pe5EcuG9W
         Q19fNOZoNWjX6o2hjuDtKxdTGTJKuXTI0jxCddubg/pRsmjWcwQFO7JlNtUdgRmyuow+
         qoaXtUBCNPNOv+K1rkx6TKyXB7yeQQT5BR8AqLHlTNJlfiZV5l+juZgMDYb0NWH36kDM
         Xj8cCiBnJRr1wiw6JXvPEYj/KGEcANKeQZ+XF0qmLxXuPhfgqaxHfUWM7U7aVtKkFshg
         Gp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kmc21K7FeqgXMxdzhbT2k9TXEIkMXjI6cV+b5uRvCqI=;
        b=TUeK2qMMtPYOyxvD1bRfMb55Sq9XyjWXecYS5LewhaIKav3uQWV4lDErsCbMwgQzcd
         igpKufnD3YXRutu4i+GLaaD+zs1yPF7TTWv3Kipa8dl543iImZHf/MZbAHr+ySG5Y6ut
         jQeZZsZiNuWp8Jp95tLnHeJoG0Q+TFmtIGPdJLham4zOulp4V/4Rd9hPtC9OIKoERlw9
         uFK/+ioTir6tbqeVdOomb5aQT17McZPmmQTp3gE7KL72r7/yS9kE483DiKwiz5VUZ7ae
         Du2tgVyDwnynh95R02G7Brnj09+da2ObSGz4N40bvQQvTN6G1zTxNFmKzP+w/65DGKsb
         qREw==
X-Gm-Message-State: AOAM5339wbQsGWCDbK9gCe+YsZki4cFzGdeUsR+xrJ/oGO2jht3XAJgO
        LtvJzj7JiXQTJ1mGegqZqvzXtffOV0aCYd+PBfSKM/YtEP0=
X-Google-Smtp-Source: ABdhPJz7/55F7VxP9rTkgl+gB+orwZ7/RiGVYJiqaZwJ49vJr1caPZo7hAZK2VqYTrt03Wnv0KYEickbBFltBc/UoHg=
X-Received: by 2002:aa7:8893:0:b0:4fb:10e1:8976 with SMTP id
 z19-20020aa78893000000b004fb10e18976mr12713683pfe.36.1649315816684; Thu, 07
 Apr 2022 00:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAO2gv81zCGbxNN_7a2j7sJZ_fbHiFXf4YxagddWLBWw7-ki5zw@mail.gmail.com>
 <Yky7xb7nQRR8Vqtj@nand.local> <CAP8UFD1Y+4XDARoK_T_c2eMUou4senhQLnjJE4zyz2KHuZGsFw@mail.gmail.com>
 <Yk21JvirO6FyQ3Va@nand.local> <e312b18b-f0d6-8980-9cad-74602043a1db@gmail.com>
In-Reply-To: <e312b18b-f0d6-8980-9cad-74602043a1db@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 7 Apr 2022 09:16:44 +0200
Message-ID: <CAP8UFD1x-JEX8MAmpabK4RbKgmVm1VQYNJdX3fP8Op5WMfUgVg@mail.gmail.com>
Subject: Re: [GSoC] Contributor candidate introduction
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Plato Kiorpelidis <kioplato@gmail.com>,
        git <git@vger.kernel.org>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 6, 2022 at 10:12 PM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> On 06/04/22 21:13, Taylor Blau wrote:
> > Thanks for this information, it's exactly the sort of thing that I was
> > hoping for from your response ;-).

;-) Note that my answers are based on what I know from previous years.
Rules sometimes change from year to year though, so everyone is
welcome to check.

> > Like I said in my other message, let's play it by ear whether or not we
> > need to split the project. If we get closer to the next deadline and we
> > have >1 potential GSoC students interested, then I'm happy to split it
> > up.
> >
> > One thing that I worry about a little bit is that I think a new on-disk
> > .bitmap format will be necessary for both of the projects that Plato an=
d
> > Shubham are interested in (though I could be wrong). Since GSoC forbids
> > students from working together, it may be difficult to feasibly split
> > the bitmaps project into multiple, smaller ones.
> >
> > That said, if we do end up splitting the bitmaps GSoC project in two,
> > when would we need to do it by?
>
> To the best of my knowledge, Google does not require the proposal ideas t=
o
> be laid out by organization before the proposal deadline (which is April =
19).
> This gives the flexibility for mentors and GSoC contributors to collabora=
te
> and come up with a project ideas that are not present in the initial idea=
s
> list and write proposals for them.

I agree with this, but please keep in mind that in
https://git.github.io/General-Application-Information/ we ask
applicants to "Discuss their project by posting drafts of their
application on the mailing-list long before the deadline." So
splitting the bitmap project should be done soon, so that applicants
have time to prepare and discuss their proposals based on the splitted
project.

See also the "Note about getting involved early" section in the
document, which has information about what applicants should do when
they get involved quite late.

On https://google.github.io/gsocguides/mentor/selecting-a-student.html
there is also:

"Don=E2=80=99t Be That Person: Don=E2=80=99t even think about selecting a G=
SoC
contributor with whom you=E2=80=99ve had no contact. You should establish a=
n
active back-and-forth prior to making a decision. If you or your GSoC
contributor have failed to make this happen, do not proceed."

Best,
Christian.
