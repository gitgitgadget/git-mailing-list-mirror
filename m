Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A982C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 00:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B498A64E46
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 00:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhBCAZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 19:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbhBCAZI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 19:25:08 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F61AC061573
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 16:24:27 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id l12so26257508ljc.3
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 16:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b6m6PqES3CuBssZZ3vF4+0/ihqMvokohv0xs5siqfgU=;
        b=I8e87N7Y9ycCq72FQSgUpiB7OB5+AfrBpzVi3T84kqQG1N9LZ3EndMXetQoeGgzLJU
         V7sNGx6KjHB6ZKJJIFH3o3dycfj5rvS9wkGA/ogknJHOC96HMdjhcmKrj1ZzenI7Xth7
         yoFmGpO6oznTERA4MFw+G5z5/Mz1bVkJIDmzSVPynVu5szOJspt71aNGmNxZrP3ge2Ob
         0xOHJiCMEyTYtfZePkLac3KQp4jfCdMU6WMrvvVscpELM85OdXWitvYj85r7dbNuNOsK
         mSahYtxbhtoxP/RA0yQGUGhR2aHiLRQYpHpPicM3xn0ZD8aFYRM2Dyd5oHJYB3Yf0bUN
         aV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b6m6PqES3CuBssZZ3vF4+0/ihqMvokohv0xs5siqfgU=;
        b=UpzM3o6drFmkwFcp6OC6yVZdPKuA+IbZnsptjXQ9L6d3Yv2WRzSbqLXolJ24jPwMv4
         mTJUSKEn0Y71GsPpTXyjnxDxWCfORZwahB7tyD3EE7+U/+XFicVSwU4Sc+b2XwYa+h4c
         GiAMt4C5vMZAOaX48MEj+xD44Pi+0w/9i1VQ/LULxz698KkPszZ0wrNKu5WljwI1Jnml
         Qm06Kt2JcG2KWfqnDlZU6Q78jqxQ3eoTVG7PEh7OFVwC0su/1rjmtMFxmtQAcy+pkkdz
         zpPr/NNyxyhFnRY4GUGw1fzPNSNb1EgC6GiLE89PCqUB6JxiwwRQL5UzL3tokZxfb02Z
         DUZw==
X-Gm-Message-State: AOAM530P6k5x0P0eKhcA5ym5tyHcTIzwBMPtV+UITJhlzh2C/8A2a0n1
        36ykcEeiNYCStgeb8/iXfMV7cityGgpAzNdcTxuNLSH84tycmgRtdn0=
X-Google-Smtp-Source: ABdhPJxoo5qwJ3GE8I/XlOqiLo1TsGY8dsG+2ZGbd2gP9Xfuv8F8cOzq5+43KcxotkZ/xeEEMxM4/BzCzJZ9XiZhRm0=
X-Received: by 2002:a2e:98ce:: with SMTP id s14mr144033ljj.447.1612311865136;
 Tue, 02 Feb 2021 16:24:25 -0800 (PST)
MIME-Version: 1.0
References: <CAGP6POK1s5fdzY74HyE9=0CV_B+HpbM9gU2qKuYtQAaPuc7XgQ@mail.gmail.com>
 <CAPc5daUtOMQB9YqOTQL4mrHpfyATe=FM01cW9Ngd1iy8aWwMmg@mail.gmail.com>
 <CAGP6POJ62-HG88uRv7yHHGy3Uu+T57APQ6GiNU3nQDW2eT4cXw@mail.gmail.com>
 <YBkUJP2u4NcldpOp@coredump.intra.peff.net> <CAGP6POKxr6k5KaC0xNaFGt=mBoEMkObNGHhDpUHQdEbsokrHhQ@mail.gmail.com>
 <YBkZZrDzBo0UC+SQ@coredump.intra.peff.net> <CAGP6POJStLEGwiU6yobaA6ag1q1ametFoe2AVkOAs6zDQ5bk3A@mail.gmail.com>
 <20210202222339.GA20119@dcvr>
In-Reply-To: <20210202222339.GA20119@dcvr>
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Wed, 3 Feb 2021 08:24:13 +0800
Message-ID: <CAGP6POKb4uPFECJ7Ghu-jZ+fe_S2oR_OdPDVQeMwnswp7KX_=g@mail.gmail.com>
Subject: Re: Only receive the topics I participated in or initiated on this
 mailing list.
To:     Eric Wong <e@80x24.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 3, 2021 at 6:23 AM Eric Wong <e@80x24.org> wrote:
>
> Hongyi Zhao <hongyi.zhao@gmail.com> wrote:
> > On Tue, Feb 2, 2021 at 5:20 PM Jeff King <peff@peff.net> wrote:
> > >
> > > On Tue, Feb 02, 2021 at 05:02:53PM +0800, Hongyi Zhao wrote:
> > >
> > > > > If you only care about topics that you have participated in, the easiest
> > > > > thing is to simply unsubscribe from the list.
> > > >
> > > > Do you mean I still can post to this list without subscription to it?
> > >
> > > Yes.
> >
> > Does this rule apply to all the lists residing on <http://vger.kernel.org/>?
>
> Yes, and any exceptions would be documented.
>
> > > You can also read the archive at https://lore.kernel.org/git if you
> > > later feel like checking for threads you might have missed.
>
> Btw, you can use the "tc:" prefix to search To/Cc: fields
> as documented in https://lore.kernel.org/git/_/text/help/
>
> You can get all the messages sent to you in gzipped mboxrd
> format via:
>
>   curl -sSf -d '' 'https://lore.kernel.org/git/?q=tc:hongyi&x=m' >mboxrd.gz
>
> And public-inbox.org/git still exists for redundancy and dogfooding:
>
>   curl -sSf -d '' 'https://public-inbox.org/git/?q=tc:hongyi&x=m' >mboxrd.gz

Thank you for telling me this. But why the content can't be directly
print on the stdout as shown below:

werner@X10DAi:~$ curl -sSf -d '' 'https://lore.kernel.org/git/?q=tc:hongyi&x=m'
werner@X10DAi:~$ curl -sSf -d '' 'https://public-inbox.org/git/?q=tc:hongyi&x=m'
werner@X10DAi:~$

As you can see, nothing is shown to me.

> There may be a CLI tool for dealing with that in the near future
> that lets you keep track of which messages you've read/unread or tagged :>



-- 
Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
Theory and Simulation of Materials
Hebei Polytechnic University of Science and Technology engineering
NO. 552 North Gangtie Road, Xingtai, China
