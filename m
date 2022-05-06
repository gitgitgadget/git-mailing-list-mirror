Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEF7C433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 20:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392563AbiEFUGD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 16:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392501AbiEFUGC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 16:06:02 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EAF5F8D7
        for <git@vger.kernel.org>; Fri,  6 May 2022 13:02:18 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id x8so8180575vsg.11
        for <git@vger.kernel.org>; Fri, 06 May 2022 13:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E+63VM9VtuclzSirCdwqSeozJSX4wVOnr0friovvCy0=;
        b=RTy6mIWdRn6nx2Us0a2UrULj0fs9ZiGMSQPdcI1NSfEaev6Npl9wRwoArlbanxQkQb
         TAHzTmsr9YJLXtyj9ACAOR7PmlRWkLSy0rYIialwhuKwhShsm1JuSRhAscHNxF3VL9wX
         yLRrxKVJIDPQosaKWDLfPpVXluzdr0Rx9GRhEBl4uvio0q/gGwFdQ/fqtVSRv4rw99oQ
         3gjlopI3UuKUpaVNNIh3msB9PWLXFZBKMBT3NDYJv5du/BLsvPAGU34Q8LmKk2cemOLh
         qy+4c/QtjwBGYNRPE8oFiP0f/Tv51IjaGvSnSkRRAzo8JhiDi83AQHzVqE5VvNfIJ20u
         j9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E+63VM9VtuclzSirCdwqSeozJSX4wVOnr0friovvCy0=;
        b=6+EwuK0FdYjYpoRvNbMfHMBXAhgF8Pq65PRj7WfYWGrprRX3ZvwRjAbzB0wsNUSX8K
         kx15IjgCB/hyJL8SZK6zuSpyhrnTKSWygYrcKBB3S7uhyisrN+wNSL4gTrhvcvVQrpln
         znk6v72N6U4st++qbV6UAnBVRJ+PcXSNHQSPEn4lYN1jTJROWtbEdhvyfrN3foD/Flr4
         fVs5sE87xiQxDOkUMLUOgI4CJl7PnZf7cr9YHLILC6lSyBI7gkGO4/EA92lAM0dAEyPt
         /FGZByU4PVIaV0INbUn+HtUB8Tzv4DqPzB6kKW+biOg1qINcrQNJ4LpfGsswl4im8Y1r
         5kcg==
X-Gm-Message-State: AOAM533NqEwtlXgBB2uwA76MgXjxlrEpynBfuzxkTHJM3Ck+iPI5beal
        ibTLPj6heKaS0fR5s+PzlPtFKhAffgTekCgo4wY=
X-Google-Smtp-Source: ABdhPJwf0FRcogLlPa6zkgSpUhwhVUWeekX7926WTrN/xmYcjRgMn8tAR4G3Atkq81ak3Z7ZLjkpdvqyErcVE6K0Nqo=
X-Received: by 2002:a67:c78d:0:b0:32d:1e85:9337 with SMTP id
 t13-20020a67c78d000000b0032d1e859337mr1538607vsk.76.1651867337117; Fri, 06
 May 2022 13:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220428105852.94449-1-carenas@gmail.com> <20220503065442.95699-1-carenas@gmail.com>
 <20220503065442.95699-3-carenas@gmail.com> <nycvar.QRO.7.76.6.2205051545370.355@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2205051545370.355@tvgsbejvaqbjf.bet>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 6 May 2022 13:02:03 -0700
Message-ID: <CAPUEsphcyTDq1djqBMD3kX9eBK0exW-m8SGpjKBoGYaHuL-80g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] git-compat-util: avoid failing dir ownership
 checks if running privileged
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, gitster@pobox.com, bagasdotme@gmail.com,
        phillip.wood123@gmail.com, Guy Maurel <guy.j@maurel.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 5, 2022 at 7:01 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Mon, 2 May 2022, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> > bdc77d1d685 (Add a function to determine whether a path is owned by the
> > current user, 2022-03-02) checks for the effective uid of the running
> > process using geteuid() but didn't account for cases where that user wa=
s
> > root (because git was invoked through sudo or a compatible tool) and th=
e
> > original uid that repository trusted for its config was no longer known=
,
> > therefore failing the following otherwise safe call:
> >
> >   guy@renard ~/Software/uncrustify $ sudo git describe --always --dirty
> >   [sudo] password for guy:
> >   fatal: unsafe repository ('/home/guy/Software/uncrustify' is owned by=
 someone else)
> >
> > Attempt to detect those cases by using the environment variables that
> > those tools create to keep track of the original user id, and do the
> > ownership check using that instead.
> >
> > This assumes the environment the user is running on after going
> > privileged can't be tampered with, and also adds code to restrict that
> > the new behavior only applies if running as root, therefore keeping the
> > most common case, which runs unprivileged, from changing, but because o=
f
> > that, it will miss cases where sudo (or an equivalent) was used to chan=
ge
> > to another unprivileged user or where the equivalent tool used to raise
> > privileges didn't track the original id in a sudo compatible way.
>
> Hmm. I do realize that this is a quite common scenario, and I wish we
> would not need to rush for a fix here:

not sure what are you referring by "this", and I read the whole snip
just in case, but assuming is about the last paragraph

* sudo between unprivileged users is still safe because we only look
if we are running as root, my comment doesn't imply a regression
there, but just that the "feature" wouldn't work for them.
* doas is a common tool that is used sometimes as a sudo alternative
and I can see there might be even a version of it that would probably
provide a SUDO_UID for compatibility, once word goes out of how useful
that is for working with git, but until then only sudo is supported.

> Otherwise we could carefully design
> an "untrusted" mode in which Git errors out on spawning user-specified
> commands and on writing files (and avoids refreshing the index to avoid
> having to write a file), but runs normally if none of that is needed.

This seems like a useful feature to have, and would definitely make
this solution irrelevant, but this one is already implemented and I
don't see yet why there is concern, probably until "this" could be
clarified.

> > diff --git a/Documentation/config/safe.txt b/Documentation/config/safe.=
txt
> > index 6d764fe0ccf..ee558ced8c7 100644
> > --- a/Documentation/config/safe.txt
> > +++ b/Documentation/config/safe.txt
> > @@ -26,3 +26,12 @@ directory was listed in the `safe.directory` list. I=
f `safe.directory=3D*`
> >  is set in system config and you want to re-enable this protection, the=
n
> >  initialize your list with an empty value before listing the repositori=
es
> >  that you deem safe.
> > ++
> > +When git tries to check for ownership of git repositories, it will
> > +obviously do so with the uid of the user that is running git itself,
> > +but if git is running as root, it will check first if it might have
> > +been started through `sudo`, and if that is the case, will instead
> > +use the uid of the user that did so.
> > +If that is not what you would prefer and want git to only trust
> > +repositories that are owned by root instead, then you should remove
> > +the `SUDO_UID` variable from root's environment.
> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index 63ba89dd31d..dfdd3e4f81a 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -393,12 +393,50 @@ static inline int git_offset_1st_component(const =
char *path)
> >  #endif
> >
> >  #ifndef is_path_owned_by_current_user
> > +
> > +#ifdef __TANDEM
> > +#define ROOT_UID 65535
> > +#else
> > +#define ROOT_UID 0
> > +#endif
>
> I do wonder whether we have to play this kind of fragile game. Why not
> simply respect `SUDO_UID` if it is set? It's not like we expect attackers
> to have control over the environment and could set this maliciously.

The problem is that it indeed would lower the bar on how this feature
might weaken the current protections.

Getting an environment variable set "maliciously" is not that hard
with some social engineering, so making sure only root would have that
escape hatch, and knowing that there is a way to infer from the
environment what the relevant user is, is a powerful way to solve this
regression without making the protections weaker.

My original implementation did not use SUDO_UID but the owner of the
pty as that is harder to fake, and therefore safer even for non root
users, but it makes it much more intrusive for the same reason.

If your concern is the introduced regression where `sudo git` will no
longer work without adding a safe.directory exception or removing
SUDO_UID from the environment (or another of the workaround documented
in the test case), I would actually argue that it instead increases
the security of the original solution by implementing a mechanism that
user can use to communicate their intention and that would prefer the
lower privilege by default.

Still I am considering it as a "known bug" which will hopefully be
fixed soon, since Junio already provided the code to improve this one
so that a root user can access both repositories owned by them and by
their SUDO_UID.

Carlo
