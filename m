Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0484FC7EE2D
	for <git@archiver.kernel.org>; Sat,  3 Jun 2023 01:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbjFCBRT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 21:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjFCBRR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 21:17:17 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3FBD3
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 18:17:16 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b1adf27823so17305651fa.2
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 18:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685755034; x=1688347034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVNSqqP3LqZHsUPKK5kiE3UtUVjk1nD8pzgN6IKPJ+0=;
        b=MA4fblSei/3f/qh2oMn77SX+D7s07o9Vd04z845il3gpemVcriZbkSgP0yEDIDn2TD
         REfIxTYVMlyitif8A5dyHgyMhxVmB02IZnAWmdjr+uViy7uAGcuZWFnD25XMiCFygg/T
         nulxmlROHIGo8nNOvasizkZhSDobZ9/9Dr+nJdo1Q2vi48v7tiyQuY1Y14Ahl2nLxtYe
         91MGNvbMJGgkH/uXY0k5WMwC3l6K/17nHuMCwkhlinYyRIfZP66zb+E7F0jFwF3Wi+c4
         k4VZMykiqCz5bHG51VLK/JSwF8RQDz4ja4VaVRoxxAzCPGOy+f50JndKTDHyXhbQcDaW
         qtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685755034; x=1688347034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVNSqqP3LqZHsUPKK5kiE3UtUVjk1nD8pzgN6IKPJ+0=;
        b=gzlx6/uMvxc0Ydr1XzJPZL8AqL3DlWGpPeK2VK6A7BUPqnEwNv59aLWW/lPG7/0KBC
         pJYzdjPo+Sr5fHyEsyqbyhwulgDU+xoS+kXEd3QtPw6r+lBSd9/wEbmHMQeQJwbmPN6x
         OITOvtTVgT90x9wsN7A9yQ2CiJqI2xWJrjn0uqDux0uIONuja9OXGpzTjmzRJ2umPxpu
         IXppR6eAqt+yVzyrSm1oY/qzDFpxnOrphgIfBahtMTw0Taz9mdJ5sBe7QtNilXhXfvo7
         sapVuIbTR9hqJLFWdQ8dWE78p6cWVXypaUmT8ZqCRLoamMjKOqGqnSL5vsQVRIL6coGX
         ikcg==
X-Gm-Message-State: AC+VfDzaTajpEg30o5QyWnbPnNVr13AudIvzuwBeG+mc9RhSbbXe3nHU
        iFA+m+Gwb7PLI9rSIZdU35L/GYIDjPCdx94NR1Y=
X-Google-Smtp-Source: ACHHUZ6k0OME5agUeAiD9qfGkVwVBKXizK8NW82BOZ1IIIMtdCq5ru2QjRBVhEJELiLPWTzlDjK+IDKDv2wzisxakKs=
X-Received: by 2002:a2e:9c50:0:b0:2ad:509a:22b8 with SMTP id
 t16-20020a2e9c50000000b002ad509a22b8mr847443ljj.16.1685755034052; Fri, 02 Jun
 2023 18:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <b6f210da2c3cc7746b984b797ad89687cba2d1f8.camel@mad-scientist.net>
 <7aa2ab6714bd14671ba9cfff611dea2fa088c99e.camel@mad-scientist.net>
 <000501d99589$358d4850$a0a7d8f0$@nexbridge.com> <679863bd1ed8a54b48472ad310c2bae7f274e1ec.camel@mad-scientist.net>
 <000f01d9958d$347d6220$9d782660$@nexbridge.com>
In-Reply-To: <000f01d9958d$347d6220$9d782660$@nexbridge.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 2 Jun 2023 18:17:01 -0700
Message-ID: <CABPp-BF0VZzDbB87JNCfCxkCDZk7LGZ=1SfnxCyHwCpQ3ZFPoQ@mail.gmail.com>
Subject: Re: Anyone know why git ls-remote output might be corrupted?
To:     rsbecker@nexbridge.com
Cc:     paul@mad-scientist.net, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 2, 2023 at 1:26=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>
> On Friday, June 2, 2023 3:53 PM, Paul Smith wrote:
> >On Fri, 2023-06-02 at 15:34 -0400, rsbecker@nexbridge.com wrote:
> >> On Friday, June 2, 2023 3:13 PM, Paul Smith wrote:
> >> > On Fri, 2023-06-02 at 14:59 -0400, Paul Smith wrote:
> >> > > Also a bunch of the heads are missing.  It's pretty clear that
> >> > > right in the middle of printing one of the SHAs we suddenly lost a
> >> > > bunch of output, and started printing stuff from later (in the
> >> > > last instance 66 out of 131 heads were missing).
> >> >
> >> > I forgot to mention: git ls-remote does not exit with an error code.
> >> > The exit code is 0 (success).
> >> >
> >> > The reason I get this failure is that as I parse the output I notice
> >> > that the SHA is invalid (contains a non-hex character "i") and it
> >> > throws this error.
> >>
> >> Does your CI/CD system use sparse checkout or depth=3D1 or some other
> >> partial clone?
> >
> >Yes, the local copy of the repo is a sparse checkout.
> >
> >I'm surprised that matters to ls-remote... I would have expected that th=
e "sparseness"
> >of the local repo is irrelevant when listing the state of the remote's h=
eads?  Is that
> >the reason for the issue I'm seeing?
>
> I'm just wondering whether this might be an impact somehow and adding inf=
o to help the team diagnose. I have seen other commands have some issues in=
 the past with --depth=3Dn
> --Randall

I think if shallowness or sparseness affected ls-remote output in any
way whatsoever, that would itself be a bug.  Granted, I don't know
much about the protocol side of things, but I'd be very surprised if
either of these conditions mattered.
