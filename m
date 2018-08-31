Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 118101F404
	for <e@80x24.org>; Fri, 31 Aug 2018 21:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeIABdx (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 21:33:53 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41591 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbeIABdx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 21:33:53 -0400
Received: by mail-qt0-f194.google.com with SMTP id t39-v6so16099371qtc.8
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 14:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNNcKqhMCSComvz82Mq0W1vnZBNMQmXWLNwKibogvNM=;
        b=fzrEjmQBgskoW/Ii6ADmdNQrOm07YC2J2ptjibgAZ8squi7fQms6ciN/qhUgVgdGTF
         8xUZLCNB3VxgFMdd/wMiBSAcc7zaGIQC5MeXgzbV2rNAHYe2qMDmLuBOyt53jIlQC9tr
         pAsCvSKgJIj6VshaTXyZlpT8joAAorXmKqfl0sept7nQiNJIJ2gwavMr38iTyqVE5d2g
         AFlTkcjn2QvzOjItVROlI+tUinRI1mhonjBu6iI/R5Rms6oqW1HLG2oJmnizi0AQd/1J
         XBmg1gnY/X5mgpNEnzFVwa6YhG8eT8mSwAODK/i8BR6n+LBp/jhxSs6B8ohMztm0oOnw
         FTLA==
X-Gm-Message-State: APzg51Bj7xLz6YWq1qmuiuv5Yz9pL9XU8OtcCwdF8fLa2/pAqHcmaxsw
        7yYwyiA6cZ4g6Nh6H3BqGlPGkgr0pOm1Zw6cfj49YQ==
X-Google-Smtp-Source: ANB0VdaTkyUR4utCii3jePaP54Alguz4H+VdPj/M3cXXTiOPksQKaDw2YbsxaFDvJd++EopwzusIykok5lBmQ/Xz0bI=
X-Received: by 2002:aed:24c3:: with SMTP id u3-v6mr17812994qtc.50.1535750673423;
 Fri, 31 Aug 2018 14:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180830195546.GA22407@sigill.intra.peff.net> <20180831063318.33373-1-sunshine@sunshineco.com>
 <20180831063318.33373-3-sunshine@sunshineco.com> <20180831200135.GC5120@sigill.intra.peff.net>
In-Reply-To: <20180831200135.GC5120@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 31 Aug 2018 17:24:21 -0400
Message-ID: <CAPig+cRoOYZaDU-bPeCpabLVY3MiZwyE-Afc2AMZk7ksyj3tTQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] doc-diff: add --clean mode to remove temporary
 working gunk
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 31, 2018 at 4:01 PM Jeff King <peff@peff.net> wrote:
> On Fri, Aug 31, 2018 at 02:33:17AM -0400, Eric Sunshine wrote:
> >  OPTIONS_SPEC="\
> >  doc-diff [options] <from> <to> [-- <diff-options>]
> > +doc-diff (-c|--clean)
> >  --
> >  j=n  parallel argument to pass to make
> >  f    force rebuild; do not rely on cached results
> > +c,clean      cleanup temporary working files
> >  "
>
> This will cause parseopt to normalize "--clean" to "-c" (along with
> "--cle", etc).

Good to know. The documentation for git-sh-setup didn't talk about
that at all, and while git-rev-parse documentation says that it
"normalizes" options, that word didn't really convey this specific
meaning to me, so I missed it.

> >  while test $# -gt 0
> >  do
> >       case "$1" in
> >       -j)
> >               parallel=$2; shift ;;
> > +     -c|--clean)
> > +             clean=t ;;
>
> So this part can just test for "-c". AFAICT this is how "rev-parse
> --parseopt" has always worked, though the documentation is quite
> unclear. Other scripts seem to also use these redundant long options.
> I'm not opposed to including it as a defensive measure (or simply an
> annotation for the reader).

I'm fine leaving it as-is too since it seems that every other client
of git-sh-setup does the same (and to save a re-roll).
