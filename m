Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8754ECAAD3
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 07:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiHaHhi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 03:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHaHhh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 03:37:37 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3943ACA15
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 00:37:34 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id cr9so10339272qtb.13
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 00:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=Bh8tAlDaSp9nTgdmuOpjDhE37Q9uORhiPcXkcFph6a4=;
        b=Y+5RKKrPAYaegN13jTelNopbIFIm8S9+MjULiSls1oDc30GUWnhbflhCbEID/LHJfV
         BoUh8VKaYlyQhQywNXEu3sfqKPhhdCHOeZ6tZ0hrBQLbf0V7HVLO5yUaMexouQutCOdH
         H9ZyyADPqP7QoOdNr6xyVVc/7fNJI1JfMYTAWt76mx4nrPewXhaPnrJrHBBw13TBaOZq
         aZwnnoRitLeqAaGOgN2RFHI7ufzIeUZxNPOf5TQDvQfipLuiygGVlUpGz5B2RYw/0Lda
         8Nxc6Hc7iRb6+8/iPvhBXHLdC3eNjr4QeOdlApj2xcF+liFHY7QlNa5cjDd5n8POEqRy
         zSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=Bh8tAlDaSp9nTgdmuOpjDhE37Q9uORhiPcXkcFph6a4=;
        b=FZYBt0/79quZpZTfgoEY3Is5e/6X30imwUXjtsnXhnDtLXU5DlMs2/BuG+ecCa//oN
         kiVIJzg6d7asnMl2ti04aYFkBtd1IrPtYIelZZGfhY0v1tfD1kvZ/snQ7AEv1DQFJ7SM
         C3w9aOQlsgKr/6UPK9Hi5DG0vI7Yywzc+SUfvpuY65adIIfL4yLr1pvjjVyEOdVXbPZo
         1La+h+iYyMfbEEEoD8CtUqguyW1A8p8h6VJ8Sh7NxJ4IvJPB96eCrXdzpys2yBfGcz+d
         khcOBP1MNCSNrdl1Yrtq4vrUDzC3YQviZgwHRs7M7CJ5oHW3j6W+ip/bVBP6Ml7z10v0
         PTfw==
X-Gm-Message-State: ACgBeo0sv1eqZNdyQZtWsCBAIqAhcwSV917b4Ie0ubOeOCx/PMfm2/b8
        sx0LnodoXYNjGiAk2+kPy6y6ER9wxhCdK706aYU=
X-Google-Smtp-Source: AA6agR6SOI6zhksheVOfEyV2okcLfDp1Jr7vWSI00vmEIb/BdKy59p6Qlp6JqtrBPzxdWa1W94IggcdzQeFuOw7ijvM=
X-Received: by 2002:ac8:5b06:0:b0:344:6481:86cb with SMTP id
 m6-20020ac85b06000000b00344648186cbmr17467502qtw.523.1661931454058; Wed, 31
 Aug 2022 00:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <43cf2a1d-058a-fd79-befe-7d9bc62581ed@gmail.com>
 <CABPp-BEkC8xEkNa+hyKFKhO=cbBZqNqGWehqxbRzE6-BVR27NQ@mail.gmail.com>
 <b19c7090-109c-8988-56cf-4f8887de3845@gmail.com> <CABPp-BGxN=9f4ODeRsX5TMuKRujCuhmRxCm4br43HNqm3Vmanw@mail.gmail.com>
In-Reply-To: <CABPp-BGxN=9f4ODeRsX5TMuKRujCuhmRxCm4br43HNqm3Vmanw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 31 Aug 2022 00:37:23 -0700
Message-ID: <CABPp-BGxPTz3tZtjGNH1MAVCKtHpjYzNVwtmux5WzuMXWphV5A@mail.gmail.com>
Subject: Re: Bug in 'git log --remerge-diff' when used with '--find-object'
 and '--submodule=log|diff'
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 29, 2022 at 7:51 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, Aug 29, 2022 at 9:36 AM Philippe Blain
> <levraiphilippeblain@gmail.com> wrote:
> >
> > Hi Elijah,
> >
> > Le 2022-08-24 =C3=A0 03:36, Elijah Newren a =C3=A9crit :
> > > Hi Philippe,
> > >
> > > On Mon, Aug 22, 2022 at 4:58 PM Philippe Blain
> > > <levraiphilippeblain@gmail.com> wrote:
> > >>
> > >> Hi Elijah,
> > >>
> > >> I found two bugs in '--remerge-diff' when combined with both '--find=
-object' and
> > >> '--submodule=3Dlog|diff'. I don't know if they have the same cause.
[...]
> > >> This artificial example reproduces the bug:
[...]
> > > Thanks for the report, and the steps to reproduce.  Very helpful.
> > >
> > > After some digging, it appears the remerge-diff headers are
> > > misinterpreted by the submodule code.
[...]
> >
> > Thanks for digging into this.
> > From what I understand in the case of a remerge-diff, both modes are al=
l-zero, and this is
> > not expected by the submodule diff code. Were you planning to submit a =
proper
> > patch ? I could get to it eventually, but not before mid/end of Septemb=
er...
>
> I intend to submit a proper patch; I've just been busy.

I have some patches that I think fix all the --remerge-diff issues;
see https://lore.kernel.org/git/pull.1342.git.1661926908.gitgitgadget@gmail=
.com/

I looked briefly at the same issue affecting --cc and -c, but only
enough to find it appears to have a different codepath and I don't see
any obvious similar fixes for it.
