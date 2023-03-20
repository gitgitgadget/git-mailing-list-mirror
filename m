Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EE0C7618A
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 14:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjCTOlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 10:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjCTOlh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 10:41:37 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880284230
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 07:41:36 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-544f7c176easo83395377b3.9
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 07:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679323296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixuK4VnMUqzjQTDsvFd+paBwxWl5JzQpHujsazwmVV0=;
        b=kOzWwmr2kSk7vvTNqTGQkwmrEPJH0VzUztCrYjOEIkq/Q2fPbhta88zNro644+0CFE
         j1k3sRRoEpkSabXiA/gF2XHzLMgnvhVPjamDgp+vEcIv24vKqiVKqzvPobsVWG8W+2AM
         d3KPCsbo+SmEVfm1ko8RBYwabWMpLzqDwZevqm6NboLza3c5Mf5Jp1g0NOoRRG6r2ZJa
         0LPATPl8jvs8aMT0Zy6TctdW2/Y527JS3NsW2O6htgbnuwz8yn3TouBDjaJcW6rO2eA/
         KKsm4LjMDbEpFd3eVc3BDSQJUW1KZQFqogZ4iSaw6x2MB3MZumCajfF2fMHNYN0jybxU
         zBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixuK4VnMUqzjQTDsvFd+paBwxWl5JzQpHujsazwmVV0=;
        b=lKSF9bpcGHOnlK/4eeDxoubAcYBBOKsXN7deSybdS1H0H0t2lI3zlr5QC+a702bwuP
         x7LxQdy2iRAWtBoNFBv9UIaz5GyVkcA2zjQT4IumMOXSs2htKSBpVRRivwQt2e+TahfS
         Hy8IVQNhuB4UOI25xMLyTqH1cu8tQaNDk/XDXLZpyZor/UF8wSwSWI++WeVva6eL1OFv
         r60YP5fSCkt5PqYrJm+LzcBIqQ5awAcNRUrRU+G7wCeg/1vdJe5u/I4X9ZKk/UxFMmsZ
         C2ygw7XU4z4YpTWlGJmVqLxLNJ17TUTHcdP9ecs5G+uvoCq46Fr7ZHKGiItnqgxjzWbK
         v4xw==
X-Gm-Message-State: AO0yUKV5U/zWWE7yGopkaZFzVhrVlv08Y78qiv4p9AdiTbmUDNNPsaoh
        iYYo4TTx5ewK2PtiIxjQPiZrrclwoSXhpiHFWSM=
X-Google-Smtp-Source: AK7set+MQnM+Y8d8ecnWg71bgiQRCmiLuV0XPNTOxtmNc1cF+CU4XwEmd1PbeEq+S3uRF+L5/FAikUbk8KKJjuLlvAc=
X-Received: by 2002:a81:ad1a:0:b0:52f:184a:da09 with SMTP id
 l26-20020a81ad1a000000b0052f184ada09mr7678962ywh.2.1679323295691; Mon, 20 Mar
 2023 07:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VfTQZ8vFQXZKgbsedG2BOad-pv9fCVkNkX+kFAxhnhhXQ@mail.gmail.com>
 <CAHp75VcZJPysc2-NXTC53XvOwbx-UfPO9SbsBJFb72JGHFyO1A@mail.gmail.com> <CAHp75Vc419vikJ184syJHN7rxyaspHzgtT9a_uFA=CT=cdqo-w@mail.gmail.com>
In-Reply-To: <CAHp75Vc419vikJ184syJHN7rxyaspHzgtT9a_uFA=CT=cdqo-w@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 20 Mar 2023 08:41:24 -0600
Message-ID: <CAMP44s2-hMXk0NSn0-SQWaxX3TOpYSbc17A-XGv0oi_D_Ws0dw@mail.gmail.com>
Subject: Re: git rebase issue
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2023 at 6:32=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Mar 13, 2023 at 2:58=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Mar 13, 2023 at 2:35=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > Hi!
> > >
> > > Recently Debian has updated the Git to 2.39.2 and broke my user case
> > > (I believe it's a problem in the Git itself and not Debian packaging
> > > or so).
> >
> > Forgot to add that last week it was working nicely (I don't remember
> > the version, but according to Debian changelog it looks like 2.38.4
> > was working fine to me.
> >
> > > So, my use case is to run
> > >
> > >   git rebase --rebase-merges -X ours --onto "$newbase" "$oldbase" "$b=
ranch"
> > >
> > > in the repository that is made out of bare + a few worktrees.
> > >
> > > Previously everything was working (my bare repository points to one o=
f
> > > the existing branch:
> > > In shell prompt: ...(BARE:netboot)]$
> > >
> > > With the new release I have got an error
> > >
> > >   fatal: 'netboot' is already checked out at ...
> > >
> > > To work around this I have to split the above to
> > >
> > >   git checkout --ignore-other-worktrees "$branch"
> > >   git rebase --rebase-merges -X ours --onto "$newbase" "$oldbase"
> > >
> > > which makes all these too inconvenient.
> > >
> > > Any suggestions?
>
> So, what should I do? Today I got again to help manually with my (used
> to working) scripts.

Do you have a sequence of steps to reproduce the issue?

With that it should be trivial to do `git bisect` and figure out which
commit introduced the regression.

--=20
Felipe Contreras
