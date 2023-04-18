Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4375C77B71
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 08:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjDRI71 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 04:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjDRI7X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 04:59:23 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8973440D2
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 01:59:22 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id w22-20020a4ad036000000b00541e4028218so3354125oor.4
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 01:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681808362; x=1684400362;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqhMgpG3QcmjECPVWL58xIURN8k5qcBfwkKtGYwQcRI=;
        b=EPlHNNew3lHiKnHtcANl3w7s+JHJ6lSlWrzLfHkk85NoQbnAbPwZqsYCsZ4TG6Gzn/
         KsmPH6bnSShPdkbCpJzb5oc2QcPlCVnJiNZx34V+WV1Hrli2pFcMfLJz2M33YaqmmBS5
         UXelETPyjY7i4ReePWMtTOai4GphFzrNn+suOJfwmNOD/60TvUNJiWvf13Z+7OaygTfS
         t3G/8qNOHioLVLDhb3LSgbMdGrUQXcOmNZY5+Avn/YhLzbSYibxXciN12aYfYFX/fwdu
         dW9Ro44g0TnK7vGwDWNlx8F+HXYWkKYPUG2vRkUzP9Djcuz+yK2JHYPy8uZWfzTHDnIK
         XEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681808362; x=1684400362;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MqhMgpG3QcmjECPVWL58xIURN8k5qcBfwkKtGYwQcRI=;
        b=dtP2gV7mMmyAsO4PonCaQAZahcCkvicwp5CjTMjkOgYQDLunUFI1fpdrvN/vyyIdAc
         p35xpDpH9/bOyEPPmnoPCzP9Lwczfr21kf5Iabncmlkek3u0uqItGchdrWgz0lg4p/au
         1MQGCzklUN+5JQFOlxWXiNXKeNVfUjaHgZrtzUUnwM3BoDdgtRPwa+wjHmrj3AckeTUD
         bf/OeTLlYqK3o5/JlrlcyROjzvySjICHbV3i9XW1f9A2IzRA1tPszOMvwHt51V4qdyx6
         4R1t1mTy31D53LztPnnLQt7CMTCGmHVuZ3QNcuwfbnQcdwfCPEKfpFOC4Gk4+9nQVZr2
         faxw==
X-Gm-Message-State: AAQBX9cRNp+rqo1I8ZTj8Wi/ZojuCbc/uZGTsUGTiu10Ky03IttwY04s
        06JY96OsUWzJEmp7C0LIm0A=
X-Google-Smtp-Source: AKy350bS2F9vt4NcXZx+vXVl0IRI1aQ1quoFHGV3hKyWCIIYrSTEp9n5Pj6eeWkAF/Kxuqc8C4RgTg==
X-Received: by 2002:a4a:4f03:0:b0:546:47de:cdd with SMTP id c3-20020a4a4f03000000b0054647de0cddmr3337901oob.2.1681808361736;
        Tue, 18 Apr 2023 01:59:21 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id n34-20020a056870822200b00187b776253dsm1951211oae.38.2023.04.18.01.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 01:59:21 -0700 (PDT)
Date:   Tue, 18 Apr 2023 02:59:20 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Patrick Steinhardt <ps@pks.im>, Todd Zullinger <tmz@pobox.com>,
        git@vger.kernel.org
Message-ID: <643e5be864894_21c9542949d@chronos.notmuch>
In-Reply-To: <230406.86y1n5tnvk.gmgdl@evledraar.gmail.com>
References: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
 <ZC2I7CfVzY6Tl7Pk@pobox.com>
 <ZC2LOAwycdaUawxM@ncase>
 <20230405165414.GA497301@coredump.intra.peff.net>
 <ZC2wppC62E7wOcqM@xps>
 <20230405181505.GA517608@coredump.intra.peff.net>
 <CAMP44s2_b0=Bm-NmDQ7ZVBen27ZtK9DpaF0gs965k1wXzzhARQ@mail.gmail.com>
 <20230406033507.GA2092122@coredump.intra.peff.net>
 <230406.86y1n5tnvk.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH] global: resolve Perl executable via PATH
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Wed, Apr 05 2023, Jeff King wrote:
> =

> > On Wed, Apr 05, 2023 at 09:18:20PM -0500, Felipe Contreras wrote:
> >
> >> On Wed, Apr 5, 2023 at 2:09=E2=80=AFPM Jeff King <peff@peff.net> wro=
te:
> >> > On Wed, Apr 05, 2023 at 07:32:22PM +0200, Patrick Steinhardt wrote=
:
> >> =

> >> > IMHO we should aim for fixing those inconsistencies, and then lett=
ing
> >> > people set PERL_PATH as appropriate (even to something that will f=
ind it
> >> > via $PATH if they want to).
> >> =

> >> We can aim to fix all those inconsistencies *eventually* while in th=
e
> >> meantime make them runnable for most people *today*.
> >> =

> >> It's not a dichotomy.
> >
> > It is if the proposed patches change the behavior in such a way as to=

> > make things less consistent.
> >
> > There are three plausible perls to run (whether intentionally or
> > accidentally):
> >
> >   1. the one in PERL_PATH
> >
> >   2. /usr/bin/perl
> >
> >   3. the first one in $PATH
> >
> > What the code tries to do now is to consistently use (1). If there ar=
e
> > cases that accidentally use (2), which is what I took Patrick's patch=
 to
> > mean, then that is a problem for people who set PERL_PATH to somethin=
g
> > else, but not for people who leave it as /usr/bin/perl. If we "fix"
> > those cases by switching them to (3), then now things are less
> > consistent for such people than when we started.
> >
> > But I am not clear on what those cases are (if any), and we have not
> > seen Patrick's follow-up proposed patch.
> >
> > I did find one case that is accidentally doing (3), and posted a patc=
h
> > elsewhere in the thread to convert it to (1). If you prefer behavior
> > (3), you might consider that a regression, but it seems meaningless
> > given the 99% of other cases that are using (1). If you want (3) to b=
e
> > the behavior everywhere, then we'd need to completely change our stan=
ce
> > on how we invoke perl, or we need to teach PERL_PATH to handle this c=
ase
> > so that people building Git can choose their own preference (sadly I
> > don't think "make PERL_PATH=3D'/usr/bin/env perl'" quite works becaus=
e we
> > have to shell-quote it in some contexts before evaluating).
> =

> I just want to chime in to say that I've read this whole
> thread-at-large, and I think what you're pointing out here is correct,
> and that we should keep hardcoding "#!/usr/bin/perl", and then just hav=
e
> "PERL_PATH" set.
> =

> I.e. most of Patrick's original patch is unnecessary, as we either use
> "$PERL_PATH" in the Makefile already, or munge the shebang when we
> install.
> =

> Then the only change we should need is the one you suggested in
> <20230406032647.GA2092142@coredump.intra.peff.net> in the side-thread.

That is true, however, the fact that something isn't *necessary* doesn't =
mean
it isn't good.

> Using "env" liket his is also incorrect.

No, it's not.

> I might have a "perl" in my "$PATH" which I expect to use for e.g. by
> .bashrc, but I don't want that perl to take priority over "$PERL_PATH" =
for
> git when I run some test script.

And you can keep doing that as Patrick's patch does not change that prior=
ity.


I applied both Patrick's patch and Jeff's patch, and then did:

  ln -s /bin/false ~/bin/perl

Guess what... Everything works fine (as it should). $PEARL_PATH should ov=
erride
the shebangs (and it does), so it does not matter what `/usr/bin/env perl=
`
returns... unless somebody does run the offending scripts manually, in wh=
ich
case they are on their own.

So, I think Patrick's patch should still be applied, but in practice make=
s no
difference, because Jeff's patch fixes the actual problems.

Or another way to put it: Patrick's patch is unnecessary, but in my opini=
on
still desirable.

Cheers.

-- =

Felipe Contreras=
