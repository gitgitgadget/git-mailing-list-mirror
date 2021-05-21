Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C90C4707E
	for <git@archiver.kernel.org>; Fri, 21 May 2021 20:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18919613EA
	for <git@archiver.kernel.org>; Fri, 21 May 2021 20:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhEUU13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 16:27:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:33762 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhEUU12 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 16:27:28 -0400
Received: (qmail 6330 invoked by uid 109); 21 May 2021 20:26:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 May 2021 20:26:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12837 invoked by uid 111); 21 May 2021 20:26:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 May 2021 16:26:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 May 2021 16:26:04 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Leah Neukirchen <leah@vuxu.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v4] help: colorize man pages
Message-ID: <YKgXXCvWYI9rjKJT@coredump.intra.peff.net>
References: <20210520040725.133848-1-felipe.contreras@gmail.com>
 <842221d6-51c4-e08a-4299-c4efb8bf1dcb@gmail.com>
 <xmqqbl94smjb.fsf@gitster.g>
 <YKdy5jhHgG2who27@coredump.intra.peff.net>
 <60a7f57fe3301_5503920831@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60a7f57fe3301_5503920831@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 21, 2021 at 01:01:35PM -0500, Felipe Contreras wrote:

> > I still don't understand what we gain by making this a Git feature,
> 
> What do we gain by making `git diff` output color?

Huh? Git is outputting the diff. Who else would output the color?

> > Why would we do that versus saying: if you want to change the colors in
> > the tool that Git calls, then configure the tool?
> 
> Once again... How?

By exporting the environment variables that ask it to do so, just like
you showed already?

> > If you like to see colors in manpages, why not configure "man" (either
> > by setting these environment variables all the time, or by triggering
> > them in MANPAGER)?
> 
> Let me try that...
> 
>   MANPAGER="less -Dd+r -Du+b -Ds+m" git help git
> 
> It doesn't work.

  ESC=$(printf '\33')
  export MANCOLORS="LESS_TERMCAP_md=$ESC[31m LESS_TERMCAP_me=$ESC[0m"
  export MANPAGER='sh -c "eval $MANCOLORS less"'
  man ls
  git help git

At least on Linux, $MANPAGER is some weird limbo that is not run with
the shell, but not just a simple command. Hence the extra layer of "sh".

If I were actually planning to use this myself, I'd probably put it in a
"manpager" script in my $PATH and just do MANPAGER=manpager.

-Peff
