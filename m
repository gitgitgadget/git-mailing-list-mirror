Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892E6C2B9F7
	for <git@archiver.kernel.org>; Tue, 25 May 2021 01:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BF85613F6
	for <git@archiver.kernel.org>; Tue, 25 May 2021 01:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhEYBZf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 21:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhEYBZf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 21:25:35 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B6AC061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 18:24:05 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so2760189otl.3
        for <git@vger.kernel.org>; Mon, 24 May 2021 18:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=lEiYkV9Zvqq0wSDruuTQc/CD+uUNgESsxEzEWKw6AHw=;
        b=uaGjXBntsFNt3G8ZZy8K5pKoG0w85DG9AnWMk1PmyKP86RJIDcrK5bAzLs5xG5vCqe
         mItEzqa6x8f4yk8rYtJLvdT1OEimIHaImfI9rY6dZIuuei9aeIO4emWqTpTMTmo/SSw1
         9GUV+yzoI1pyl6jP6jqp19QTrfhktAw1n5M+3P7OVmItEmjN5DNNByQEGRGrgOiE1QqF
         wmCYsIwfgWM/i5Cbjpm0kKDmUVLtuSi3ZGlLoJ4F2dwfWgqFNDue8IdX0i84skS2RJXD
         FkU7M5wRcu6+Tu8dOYOnwr29jdqL+ChjrNyj3MjRHBTGrf6RrxkYap90cCb5bctTuLu0
         2ZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=lEiYkV9Zvqq0wSDruuTQc/CD+uUNgESsxEzEWKw6AHw=;
        b=DIAY7BdHN6yFqkWrhIFKSktXEA6zl+hwdZgDx0WNna0A9nH/68qj4Ie7EoZEy1jFcJ
         owWs7R+ac568Fl9dm0dpvh+5yptRrqJldaERbv44BhqIsSwMwLKCmVfmZaOVN4114FQ6
         kSv6oau4uEj3TbZSZaqFPdX+t1zytQZyNCXOTzzxq7TCZd+z4tnoCV6FQA7UfnH6O44j
         7inGEAMdG+34jZLcOmUBCmSUWOvZpx1BIwP5TWRyppUMjGpqwzyC892QC6TV4nnVmYW0
         9GOTyOa/3Wr7TcggZJMCN9LEKBdmG0V32mVdMSwz2l1dOxCx483BaDiCg0jvBCpqyWJz
         8qAw==
X-Gm-Message-State: AOAM533zvzr/knRgzhTfr//3InCJ8Rrmi+BCLnX4NV/d/rpoFTlBdQok
        hpoQYoyrL8HA3G0noEwqjTiK4ZewuxgLyA==
X-Google-Smtp-Source: ABdhPJyBhZuwCWas/GNwiOtbsprBDMzW2UZUFVJQ6JIIxVv51JLl8UWuET1r+nspadvNENWbJh5/Ww==
X-Received: by 2002:a9d:70c8:: with SMTP id w8mr20510242otj.22.1621905844001;
        Mon, 24 May 2021 18:24:04 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id w10sm3165148oou.35.2021.05.24.18.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 18:24:03 -0700 (PDT)
Date:   Mon, 24 May 2021 20:23:51 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Siavash <siavash.askari.nasr@gmail.com>, git@vger.kernel.org
Message-ID: <60ac51a7ecf74_1f8f720843@natae.notmuch>
In-Reply-To: <87a6ojogvp.fsf@evledraar.gmail.com>
References: <87k0nt3f8i.fsf@gmail.com>
 <YKcTFDgW4etXFpOR@camp.crustytoothpaste.net>
 <YKeFxcTDp4tHSRu8@coredump.intra.peff.net>
 <YKgzvFHOcUgPjbj/@camp.crustytoothpaste.net>
 <YKqzj/DZU8m9AaI/@coredump.intra.peff.net>
 <60ab17018efee_1691c20832@natae.notmuch>
 <87o8d0o2or.fsf@evledraar.gmail.com>
 <60abe0b32dfa1_1b2092081d@natae.notmuch>
 <87a6ojogvp.fsf@evledraar.gmail.com>
Subject: Re: Renaming "non-contrib" things out of contrib/* (was "Re: [Bug]
 git-credential-netrc.perl[...]")
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, May 24 2021, Felipe Contreras wrote:
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> >> I'm not sure s/shared/contrib/g is the best naming though, but maybe=
 I'm
> >> contributing to needless bikeshedding by mentioning that.
> >
> > It is the best location because that's where completions go.
> >
> > You can check the location bash-completion suggests to install
> > completions to:
> >
> >   % pkg-config --variable=3Dcompletionsdir bash-completion
> >   /usr/share/bash-completion/completions
> >
> > In the case of zsh it's /usr/share/zsh/site-functions.
> >
> > Additionally, if you install them in your home directory, it should b=
e
> > $XDG_DATA_HOME/bash-completion/completions.
> >
> > $XDG_DATA_HOME is $HOME/.local/share (analogous to /usr/share).
> =

> *Nod* I mean just because it ends up there in the FHS doesn't mean it's=

>  best for us to mirror that structure in git.git.

It's not just that it ends there, it's how it ends there.

Right now the Arch Linux's git package does this:

  find contrib/ -name '.gitignore' -delete
  cp -a ./contrib/* "$pkgdir"/usr/share/git/

I would rather have an install-shared target to populate /usr/share/git.
Having a standar location for distributions would allow scripts to
simplify instructions, like:

  source /usr/share/git/completion/prompt.sh

Sure, how install-shared populates /usr/share/git is kind of orthogonal,
but it would make sense for install-shared to install stuff from shared/.=


> >> You apparently named it like that to match where distros usually ins=
tall
> >> it (/usr/share), but we also have docs there, locale, and the perl/
> >> directory usually (well, at least on my distro) ends up there.
> >
> > Distributions install them there, because that's where they are expec=
ted
> > (by bash-completion and zsh).
> >
> >> I wonder if just a top-level completion/* wouldn't be best, or if we=

> >> want to group them all together something like
> >> optional/{completion,credential}/ or other name suggesting that thes=
e
> >> are meant to interact with not-always-present 3rd party software. Ma=
ybe
> >> integrations/* ?
> >
> > extra/ is a better name.
> >
> > However, there's already many things that are optional, like gitk and=

> > git-gui, do they belong there too? For that matter locales are option=
al
> > too.
> >
> > I think if such a decison to have an extra/ directory is made, it sho=
uld
> > be orthogonal to the completion graduation.
> =

> The line I was attempting to draw was components that optionally
> interact with optional 3rd party software.
> =

> The i18n framework isn't like that because we build it and interact wit=
h
> ourselves, ditto for say PCRE. Optional, but /usr/bin/git is using it.
> =

> As opposed to bash/zsh completions, git will run just fine without
> either of those shells installed.

git will also run fine without git-send-email, git-instaweb, and git-p4.

> The git-gui and gitk programs are also first-party software, just like
> git-send-email or whatever. We just have knobs not to build them becaus=
e
> of the dependencies. It looks like we might be spinning them away from
> git.git entirely in slow-motion, but so far they're first-class
> commands.

I know what is the status quo, but when talking about suggestions for
improvement the status quo does not matter. Either the status quo makes
sense, or it doesn't.

I know gitk is "first-class", but *should* it? If so, why?

And I know git-completion.bash isn't "first-class", but shouldn't it? If
so, why not?

We even run git-completion.bash tests by default, gitk doesn't have
tests. We don't even track its history; all the commits are squashed
into a single "merge". And surely bash is a much more likely dependency
to be present in the user's system than Tcl/Tk.

So I don't really see what gitk has, that git-completion.bash hasn't.

Either both belong in extra/, or none of them do (and if one does an the
other doesn't, to me it's clear which is which).

Cheers.

-- =

Felipe Contreras=
