Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17371C83F2D
	for <git@archiver.kernel.org>; Sun,  3 Sep 2023 07:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjICHQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Sep 2023 03:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjICHQR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Sep 2023 03:16:17 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A745B197
        for <git@vger.kernel.org>; Sun,  3 Sep 2023 00:16:13 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-500bb392ab7so801391e87.1
        for <git@vger.kernel.org>; Sun, 03 Sep 2023 00:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1693725372; x=1694330172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjQ84uyU8BqP/zeALnmK968kAT/ihAczSeH2nXp6Tp8=;
        b=PQRbFsIQqxMYU80TCO0YjlA2raD/MiLAUgDI0T1ZRf7xKtEsqMAhEO6Jn22pK8oT+a
         zDH+R/JzqPezWY8ce6q8skB+Yf5H6egZp91+9I9G2dVn7dy8OVjz4ZjXXKozy4ldx572
         YPaei1D/2r2DkfO8R4NXwxArX2paTc9ZcbTeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693725372; x=1694330172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjQ84uyU8BqP/zeALnmK968kAT/ihAczSeH2nXp6Tp8=;
        b=gVMmqUmZwQ+3+K2+slmqfgovS4qz2szdVyHzUeRBPX6xORLL1s9/HK1Li5z2StMufw
         k9Kro0Uw7jogMSyeQkTcpu9aopq64g8guhPlBymwOpdfOaE8u7vLyT1XVZ5HippqhxFd
         ztuBve5bdhInQrL7m09kVCswZh6K7n5PQo9sXmx0QYbFBFiNYa6ZjnBKRWwNJdOQEqAM
         Ny++nS05uJSIS/LIk+UhQFYbeBv85ozAcgDE4vvR5BUaBXP2YfMrn8XvP7zOEayzkA9y
         rWBvC01GgNCCIJ6nrSpcUetJ8miWNvSZGsrd2l/N/+kaKHAUphvqrIVy6wkhkzODYBKe
         gX3w==
X-Gm-Message-State: AOJu0Yz53RqraTT60ksAUXPMBoyUbPYS+tLM9WYRKfNHQUS4mc5MKqhz
        Xhs5pBMfoL68NdgDZR4tOzIPoZLIFOo1wmqJN7ZmPg==
X-Google-Smtp-Source: AGHT+IEKqK+iTEqF81CDIWKmTK3amxNzDoFb2p/Linoc57UZM7LVrmnWEoyC4kAeFuE9ejuxaYeE8wGYgcMivISTXZc=
X-Received: by 2002:a05:6512:3148:b0:500:808c:91f7 with SMTP id
 s8-20020a056512314800b00500808c91f7mr3681795lfi.13.1693725371676; Sun, 03 Sep
 2023 00:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpogUxq59zj+=7UDiURYbydAwvymOqhEWaheT9fkU8HaP4Q@mail.gmail.com>
 <xmqqilp1znn1.fsf@gitster.g> <nycvar.QRO.7.76.6.2206182358350.349@tvgsbejvaqbjf.bet>
 <xmqqczf5lgk3.fsf@gitster.g>
In-Reply-To: <xmqqczf5lgk3.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Sun, 3 Sep 2023 09:16:00 +0200
Message-ID: <CAPMMpojUrfSmpgWVh3TTn_uamPCcyHRQf2R3APSpEjsqujNXvA@mail.gmail.com>
Subject: Re: Plumbing for mapping from a remote tracking ref to the remote ref?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 19, 2022 at 1:04=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >>      $ git refmap refs/remotes/somepath/{branch-A,branch-B}
> >>      origin refs/heads/branch-A
> >>      origin refs/heads/branch-B
> >>
> >> IOW, you give name(s) of remote-tracking branches and then you get
> >> the remote and their ref for these?
> >
> > Modulo introducing a new top-level command (a subcommand of `git remote=
`
> > would make much more sense and make the feature eminently more
> > discoverable), and modulo allowing patterns in the ref to match, I agre=
e.
>
> "git remote" is primarily about "I have this remote---tell me more
> about it", but this query goes in the other direction, and that is
> why I threw a non-existing command to solicit alternatives that are
> potentially better than "git remote".

Thank you for the responses here, and my apologies for not following
up (much) earlier.

Given that "git remote" already deals with different types of args
(remotes, URLs, remote branches), could it make sense to introduce a
dedicated new subcommand, not directly related to "set-branches", eg
"map-refs"? I agree with Dscho that keeping it under "git remote"
would help with discoverability and avoid clutter in the global
namespace: Git already has many top-level commands, the "theme" under
which this one fits is definitely "remote stuff", and "git remote"
already does a number of substantially-different things all related
with *remote configuration*.

In fact that's another way of seeing things: most of "git remote"'s
current subcommands are just syntactic sugar over "git config" (the
two that operate outside of the config are "set-head" and "update"),
and this new one would be config-focused in exactly the same way.

To Junio's question along the lines of "what if someone mapped
multiple remote namespaces to a single 'tracking namespace' location
in the local repo?" (which I hope is rare - I seem to recall there are
at least some operations that warn when this is detected), this
ambiguity would be absent in a "git remote" subcommand, as it would
take a remote name.

I had also considered some new weird "@{remotemapping}"-style syntax
to rev-parse, but here precisely there *would* be no implicit remote
context, and so getting more than one answer would be an option, and
that doesn't make sense for rev-parse.

Regarding patterns and wildcards, for *my* purpose at least, they
don't make much sense: The whole purpose of the exercise is to say "I
know the ref I want updated in my repo, I know what remote that it is
mapped to or that I want to update it from, I want to know exactly
what to put in a "git fetch <remote_name> <remote_ref>..." call, to
get that ref updated correctly/consistently for the current repo,
without affecting any other refs that this repo has mapped for that
remote.

Would something like the following be mutually agreeable?

       $ git remote origin map-ref
refs/remotes/my-favorite-remotes/origin/someref
      refs/heads/someref

       $ git remote origin map-ref
refs/remotes/my-favorite-remotes/origin/someref
refs/remotes/my-favorite-remotes/origin/someotherref
      refs/heads/someref
      refs/heads/someotherref

     $ git remote origin map-ref refs/remotes/someotherpath/someref
      error: the ref "refs/remotes/someotherpath/someref" is not
mapped in any configured refspec of remote "origin".


Thanks,
Tao
