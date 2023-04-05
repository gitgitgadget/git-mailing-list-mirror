Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE59AC76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 17:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbjDERJ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 13:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbjDERJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 13:09:57 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEFD35A1
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 10:09:51 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id m16so23058491ybk.0
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 10:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680714590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKKbGI9IcatIovMCFKXex9GUY69NzLLL9uCsmeOV0RY=;
        b=dLRnuirhdA13r7qU50HpoMby4lOzF5eVv1VocXtHjjAoa/SUIsXyP2TcpS52QCKe3+
         CTsWqq7K3nI2T6OHrc7AEu7z/TF5d9qMQRHgPhrquQ/4QJI0QmpVS48H0NSdvnelkDew
         Pke2nH5YUcq2y6ErkToi2SNqDWFxLa79mGREMcKbbftSU3WfF8IK6eY88YXOTEb0pel8
         qhq1DgzkE43mZEueCCJergrSnfA6soRYvGU5dvxnIDN55wW+8ADd7i+rMhiLMe5HlISp
         CiIhQ+nlK9ND5KQ7tHfH9wwgqrx01s2ULpG5CF2WVnn+HeEqJt47Wr+8QjVebbM+XR3i
         OUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680714590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKKbGI9IcatIovMCFKXex9GUY69NzLLL9uCsmeOV0RY=;
        b=alcurAPJTn4TD24Id0klsjVjSNqjkXHq1Za4zo30JRXPvZEjQ/RNZpbD8NMJav01im
         WCnAude623OWOlhdum/ZZ463tQsE/OBWJ7DY5o7jrZo/+j1M02jUcHf/dfuzDl9ggrVO
         EaPZbc5ttYOfyDL+ZODOfwhNjnwd400pnZGBZQ5KTVY/5+kvrVtoBQYKFA5zJvGF8a7V
         BOBsbQSxY30NbbcJ+xIMio+ij+qJaE1tQOVxn67RuqB5U88/kRebjIrGNJWuMQJlPOx2
         uFGsaF98LP0gPRZcCcWVv0FDTM5HWb64pVYDRxDfkXJJhmnwWqCNAwHmydR9yo69qECm
         2Hhw==
X-Gm-Message-State: AAQBX9cHCe16o2pyej9Fh/1BHo96yKupdVayt7t581ms04qb8s7TiGPE
        EEaBkY0ELOTYB/GXxIFC6x8emyVa7pxDG54dYw62MjePgnM=
X-Google-Smtp-Source: AKy350aP0Opo6MlH642ZC8ZzZRe0q07Xavg6VByms8UEy0QI+j0W8BCT8/mQUith9huOC43HAyzUUnxZsnCzi6zRrLA=
X-Received: by 2002:a25:7491:0:b0:b48:5eaa:a804 with SMTP id
 p139-20020a257491000000b00b485eaaa804mr28636ybc.0.1680714590534; Wed, 05 Apr
 2023 10:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
 <ZC2I7CfVzY6Tl7Pk@pobox.com> <ZC2LOAwycdaUawxM@ncase> <ZC2ZyTTZFbd_gNtw@pobox.com>
In-Reply-To: <ZC2ZyTTZFbd_gNtw@pobox.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 5 Apr 2023 12:09:38 -0500
Message-ID: <CAMP44s1V3nGnqCjoCi2xuH59APVPiAoQ82LQx3KNnsdDNfcoPg@mail.gmail.com>
Subject: Re: [PATCH] global: resolve Perl executable via PATH
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2023 at 11:31=E2=80=AFAM Todd Zullinger <tmz@pobox.com> wrot=
e:
>
> Patrick Steinhardt wrote:
> > On Wed, Apr 05, 2023 at 10:42:52AM -0400, Todd Zullinger wrote:
> >> Is there a reason to not set PERL_PATH, which is the
> >> documented method to handle this?  From the Makefike:
> >>
> >> # Define PERL_PATH to the path of your Perl binary (usually /usr/bin/p=
erl).
> >
> > Setting PERL_PATH helps with a subset of invocations where the Makefile
> > either executes Perl directly or where it writes the shebang itself. Bu=
t
> > the majority of scripts I'm touching have `#!/usr/bin/perl` as shebang,
> > and that path is not adjusted by setting PERL_PATH.
>
> Ahh.  I wonder if that's intentional?  I haven't dug into
> the history, so I'm not sure.  It seems like an oversight,
> as an initial reaction.

Generally the people interested in setting PERL_PATH are packagers,
and it's so the installed scripts have the desired hardcoded path.

So a script that is never installed isn't considered.

> > I'd be happy to amend the patch series to only fix up shebangs which
> > would not be helped by setting PERL_PATH. But if we can make it work
> > without having to set PERL_PATH at all I don't quite see the point.
>
> It's certainly debatable whether using /path/to/env perl is
> better than hard-coding it at build time (forgetting about
> the usage of RUNTIME_PREFIX). [Debatable in a friendly
> sense, of course.]

It's better because it allows the user to choose another version
dynamically, for example:

    PATH=3D/opt/perl7/bin:$PATH script

> As a distribution packager, I prefer to set the path at
> build time to help ensure that an end user can't easily
> break things by installing a different perl in PATH.

And as a user I would rather packagers don't treat me like a child.

I decide how to use *my* system.

And BTW, newer generations of developers use all kinds of version
managers like RVM and nvm, and perl has one as well: perlbrew [1]. Not
to mention docker, for which the Perl official image installs into
/usr/local/bin/perl.

> The Fedora build system will munge /path/to/env perl
> shebangs to /usr/bin/perl and it won't effect us much.

So you can override '#!/usr/bin/env perl' instead of overriding
`#!/usr/bin/perl`, which the Git Makefile does by default anyway.

What's the difference to you?

> That may not be true for other distributions and they may
> care more if they want to keep using a hard-coded path to
> perl.

Arch Linux does whatever upstream does by default.

> I don't know how it may affects the Windows folks either, who are
> further askew from our other, more UNIX-like targets.

Windows doesn't use shebangs, you have to do `perl script`.

> I don't know what the right choice is for upstream Git, it
> can easily be argued in either direction. :)

I don't think it matters to packagers how people developing Git run
the internal scripts.

Cheers.

[1] https://metacpan.org/pod/perlbrew

--=20
Felipe Contreras
