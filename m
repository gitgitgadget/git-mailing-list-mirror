Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F371C2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 23:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1594206A5
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 23:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHRdSsRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfLUXN7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 18:13:59 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39304 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfLUXN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 18:13:58 -0500
Received: by mail-ed1-f66.google.com with SMTP id t17so12092165eds.6
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 15:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PT1NK5VJZ/9quBU5utD7cPWKbWaO3GDmbnjBdH0SovY=;
        b=tHRdSsRUEPaxkzeuKmfNLzkjA/ySuPvzZdrKyUa6+yyz6rcAaqpwwzu00hTno9FvEC
         1+V1wviTuvl9fSGAx8njkEqMZhtPz2+SjrjjGUnRTypkdE/H3o7BvRB8ajokkhY1sRUz
         IFZjAHapObSad4I0sqV3kW6iICCw4WN8V50WNxwTLjkx3Lg1Lo2XyO8SBNp8dQnQ0Sri
         KPtFJG9DLJN9YFuXafkXGhnUkxrS3CEFcJMrCbEfCFFEIu+6OsUXkt8VkDtRRXcQyJwY
         0BcAcYMNjMVF62trQxt41xr6LQ7vJxBfAAaxkD94Nx3IvnYyepHgMnf3Pw1r9Qm446YT
         LCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PT1NK5VJZ/9quBU5utD7cPWKbWaO3GDmbnjBdH0SovY=;
        b=LeIfJdlK37tnP2ACtuAXt5m4dLzeT5g06R11kB/59A6ea6tksXyKGyrJk3CLc7piKp
         ONp/UA5NnwLXSBiKSczu0efqoEI6S6niy/unFrDXmYQ+5OfVZIrHtHyCxMl6fhCKXapp
         sqNztIiUfr3hOQXP+0yb00lV2goGZpBCvyVTvr1itnav/mj7ay8mMqA9Xnboie++ftHK
         LwhyYTlxegNjN2y/V5YPmiXGx1WBVVQzb/2M+w0zEja8XY/ywA02EOlmVMERgzCYMbpo
         kwr9ytkb/kvvt3jqRkOjthp+PAnAmrPVGhq3p3hSEIhh8g7VZxLTP5Dy+inT3goMyPVi
         MMgg==
X-Gm-Message-State: APjAAAVODB47pUt6y3d6FBHRG8KtIO5PCGE9iGq4bP/nNsNQpforvWug
        B5vzhxTuQGR/QCroMNAwKpu4dpYBjIp5LTvU3hQ=
X-Google-Smtp-Source: APXvYqym9f8E7gSXGEARRIWXjOM1JnJ7Ldm2ngA3YaT6g7Bn3lwoCqDXUOLKsOLD8Tl8keO7d+fjG+9s4xxfJvZIg8Y=
X-Received: by 2002:a17:906:8595:: with SMTP id v21mr23749663ejx.28.1576970036976;
 Sat, 21 Dec 2019 15:13:56 -0800 (PST)
MIME-Version: 1.0
References: <CAAHpriOh=9Mh7_moxWCzXBHYTtNi9TOQQPBxa4CX=uLgOnpNtw@mail.gmail.com>
 <20191220231840.GD163225@camp.crustytoothpaste.net> <236e2b6b-d1ce-b0f2-ff56-4ca5e0dfb8e8@drbeat.li>
In-Reply-To: <236e2b6b-d1ce-b0f2-ff56-4ca5e0dfb8e8@drbeat.li>
From:   Keith Thompson <Keith.S.Thompson@gmail.com>
Date:   Sat, 21 Dec 2019 15:13:45 -0800
Message-ID: <CAAHpriN4qyCymvuW=o5NO63TixqwCQZxrC26e8WyDQH1+=D7SA@mail.gmail.com>
Subject: Re: Cygwin git with schannel ("native Windows Secure Channel library")
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Keith Thompson <Keith.S.Thompson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 21, 2019 at 3:51 AM Beat Bolli <dev+git@drbeat.li> wrote:
> On 21.12.19 00:18, brian m. carlson wrote:
> > On 2019-12-20 at 01:52:04, Keith Thompson wrote:
> >> I've posted this on Stack Overflow
> >> https://stackoverflow.com/q/59381061/827263
> >> but I haven't gotten any responses yet.
> >>
> >> When I install "Git for Windows" on Windows 10, the installation
> >> wizard offers the choice of using either the OpenSSL library or the
> >> "native Windows Secure Channel library".  (Whether that's offered
> >> seems to depend on what's available on the Windows 10 system.)
> >> I believe this is referred to in the git sources as "schannel".
> >>
> >> Is there a way to configure git under Cygwin to use the native
> >> Windows Secure Channel library?  An ideal solution would be a
> >> modification to my .gitconfig, but something that lets me build git
> >> (and possibly curl) from source would also be good.  See my Stack
> >> Overflow question for more details, including some things that I
> >> tried that didn't work.
> >>
> >> The problem I'm trying to solve: In my work environment, I can
> >> use Cygwin git for local operations, but I have to use Windows git
> >> for anything that talks to a remote (push, pull).I'd prefer to use
> >> Cygwin git exclusively.
> >
> > I'm not 100% certain here, but I believe the answer is no.  In order to
> > use SChannel, you'll need to link against MSVCRT or a compatible
> > runtime, but it's not possible to link against both that and Cygwin at
> > the same time (probably because they both provide the same symbols).
> >
> > If your constraint is that you need to interact with the Windows
> > certificate store or such, you could see if there's an OpenSSL or GnuTLS
> > plugin that will do that for you and then build against that library or
> > plugin.
>
> There is the OpenSSL "CAPI" engine which interfaces with the Windows
> CryptoAPI. However, I don't know if the Cygwin OpenSSL build includes
> this engine.

That's interesting.  I just tried building OpenSSL from source on
Cygwin (openssl-1.1.1d.tar.gz).  It installed lib/engines-1.1/capi.dll
under the installation directory, and I see references to capi in the
output of "make".  The Cygwin-installed OpenSSL (currently 1.1.1d)
doesn't provide that file.  I don't know whether or not that means
the Cygwin-installed OpenSSL doesn't support CAPI.

Is there an openssl command I can run to tell whether it supports CAPI?
(Disclaimer: I had never heard of CAPI before.)  With both the Cygwin-installed
OpenSSL and the one I built from source, I get:

$ openssl engine capi
25769803792:error:260B606D:engine routines:dynamic_load:init
failed:crypto/engine/eng_dyn.c:485:
25769803792:error:2606A074:engine routines:ENGINE_by_id:no such
engine:crypto/engine/eng_list.c:334:id=capi

*Maybe* if I compile OpenSSL from source, then compile curl
from source using my compiled OpenSSL, then compile Windows Git
from source using my compiled OpenSSL and curl, it *might* work?
It's worth a shot.

And if the Cygwin-installed OpenSSL doesn't support CAPI, I wonder
why it doesn't.
