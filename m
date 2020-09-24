Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62D1C4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 12:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C7AC20708
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 12:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1TKrlZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgIXMxc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 08:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbgIXMxc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 08:53:32 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E52C0613CE
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 05:53:31 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id d190so3177154iof.3
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 05:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Br53X07a3SBjs9a7kYeF7OylY5p03gjXgRy20ObPPIo=;
        b=i1TKrlZKHk53/ssPPeabiQYpwB5HStbq/RuZ3l37AXjWUbawwgywturNr11leZFRCF
         8JUUMv9gYMETFRRC+K7bKuUN67x3Lf9bz+PXjLD+I6LWAmokuK2aWjGvpy+Ox8wTSCO9
         QgUiF3V3qg99izuh+1YUOqvA+OXUFmeGe/F+15sR5b3vKYKJax0nL5i28qAje/5ggLE9
         TzYCeO2NNYd8D+7+VoP+LVPRUoHJu1CxnPpUzcKvogpleWV/aD7OfVEL3spod8r7g6Vj
         ufP1R9vQJN94LBbd2tTLDoGEk4kcA9sk6ojjZmIajSLw244QEOw+Whi5PunjZGGPtQ8s
         TkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Br53X07a3SBjs9a7kYeF7OylY5p03gjXgRy20ObPPIo=;
        b=kG7CSPayGhynOfwb0VpwAG1KtqTeVA817odPmmX24v2gD9rX2RATqyczmbDL9XnJE/
         DzmCaEY9C7vLwym3m0lEGN4sn8LBpYXwdyFlz8R6n+1oOmKKfNsgbnPQn3PDzjG6dMfR
         WtzFfijKiM1HWwcuOX+KYmF0rNBSDbrTZRC3WkHV/ekYXHWvL1lqdHjlBxzMNBT1Hbk8
         QY6mwM5iggM8xJyj8ynHIU3zdsS5OZ8qifgz06pxCp3oCc/LAZhyShY4PBjvtosbv1IV
         Qv1VEvf6jeEsoVtONCbSviCTMqLDHXuke3J2XkHoC3GYTfi8dZTeZF6nf2E1zzXMWFfx
         +1uA==
X-Gm-Message-State: AOAM530CC1SkMM1y+Yx1yCSN8aFxYfmQGi1StLCGo1j12KQT3Ad4fFAW
        kwW1rVLibUYhRuN4Z8zUFPsqlQTkIR80cEdcmeA=
X-Google-Smtp-Source: ABdhPJzjiwfiHiwzOveqPF+/UiwHoFVipDBqJL/37B/f4xyJM7Nm86Z4DrWgTYHSnDxzUacaMWE9tszAdZ+9YT1T340=
X-Received: by 2002:a02:2b2f:: with SMTP id h47mr3577701jaa.79.1600952011170;
 Thu, 24 Sep 2020 05:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200831105043.97665-1-mirucam@gmail.com> <nycvar.QRO.7.76.6.2009031403510.56@tvgsbejvaqbjf.bet>
 <CAN7CjDDVp_i7dhpbAq5zrGW69nE6+SfivJQ-dembmu+WyqKiQQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2009231647370.5061@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2009232316570.5061@tvgsbejvaqbjf.bet>
 <CAP8UFD1fXBChG3691HrKmbN-4vThCE7=0bL+Ty8-u4FFGTn2tQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2009240952300.5061@tvgsbejvaqbjf.bet> <CAP8UFD3rLTLkbq+gYPSD3dmGituWr1g8ZtQDQmPYDdEBtHkU0Q@mail.gmail.com>
In-Reply-To: <CAP8UFD3rLTLkbq+gYPSD3dmGituWr1g8ZtQDQmPYDdEBtHkU0Q@mail.gmail.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Thu, 24 Sep 2020 14:53:20 +0200
Message-ID: <CAN7CjDA5d4o0RxFmGZkMOiG12AqgxMp5uWf0-qUwYpVNb-oj1Q@mail.gmail.com>
Subject: Re: [PATCH v7 00/13] Finish converting git bisect to C part 2
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

El jue., 24 sept. 2020 a las 12:46, Christian Couder
(<christian.couder@gmail.com>) escribi=C3=B3:
>
> Hi Dscho,
>
> On Thu, Sep 24, 2020 at 12:06 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Thu, 24 Sep 2020, Christian Couder wrote:
> >
> > > On Wed, Sep 23, 2020 at 11:26 PM Johannes Schindelin
> > > <Johannes.Schindelin@gmx.de> wrote:
>
> > > > Instead, those `eval` calls are required because the arguments are
> > > > provided in quoted form. For example, during the execution of t6030=
.68,
> > > > the `eval` would expand the call
> > > >
> > > >         eval "git bisect--helper --bisect-start $rev $tail"
> > > >
> > > > to
> > > >
> > > >         git bisect--helper --bisect-start '--term-old' 'term2' '--t=
erm-new' 'term1'
> > >
> > > Yeah, that was also what I found (along with the bug I sent a patch f=
or).
> >
> > I suspected that you had found that out, but I really wanted a record o=
n
> > the Git mailing list about our findings.
> >
> > It might be a good idea to add a paragraph to the respective patches,
> > along these lines:
> >
> >         Note that the `eval` in the changed line of `git-bisect.sh` can=
not be
> >         dropped: it is necessary because the `rev` and the `tail`
> >         variables may contain multiple, quoted arguments that need to b=
e
> >         passed to `bisect--helper` (without the quotes, naturally).
>
> Yeah, sure. Hopefully Miriam will send this in the commit message of
> the right patch which is in the subset of the patch series she hasn't
> sent.
Ok. Noted!!
>
> > > > Therefore, the `eval` really needs to stay in place (also the other=
 `eval`
> > > > I had originally suggested to remove, for the same reason).
> > > >
> > > > I would still recommend appending `|| exit`, even if it just so hap=
pens
> > > > that we will eventually abort when the `bisect--helper` command fai=
led
> > > > anyway, because the next command will then fail, and abort. But it'=
s
> > > > cleaner to abort already when this invocation failed rather than re=
lying
> > > > on that side effect.
> > >
> > > Yeah, I think it's a good solution.
> >
> > Excellent. I think we can actually move forward with the entire patch
> > series now, not just the first subset, right?
>
> Yeah, I think so too.
Oops, I have already sent the first subset.

Best,
Miriam
>
> Thanks,
> Christian.
