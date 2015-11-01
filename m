From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] checkout: add --progress option
Date: Sun, 1 Nov 2015 14:19:03 -0500
Message-ID: <20151101191902.GA19594@sigill.intra.peff.net>
References: <1446400076-9983-1-git-send-email-eantoranz@gmail.com>
 <CAPig+cSLC_xkpXEznzPQdA=FE6GV5VSuwSrFy62Nzybv7jQf1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Edmundo Carmona Antoranz <eantoranz@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 20:19:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zsy9o-0004E0-52
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 20:19:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbbKATTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 14:19:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:51237 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751123AbbKATTG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 14:19:06 -0500
Received: (qmail 19591 invoked by uid 102); 1 Nov 2015 19:19:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 01 Nov 2015 13:19:05 -0600
Received: (qmail 7895 invoked by uid 107); 1 Nov 2015 19:19:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 01 Nov 2015 14:19:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 01 Nov 2015 14:19:03 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cSLC_xkpXEznzPQdA=FE6GV5VSuwSrFy62Nzybv7jQf1g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280655>

On Sun, Nov 01, 2015 at 12:52:57PM -0500, Eric Sunshine wrote:

> > diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> > index e269fb1..93ba35a 100644
> > --- a/Documentation/git-checkout.txt
> > +++ b/Documentation/git-checkout.txt
> > @@ -107,6 +107,12 @@ OPTIONS
> >  --quiet::
> >         Quiet, suppress feedback messages.
> >
> > +--progress::
> > +       Progress status is reported on the standard error stream
> > +       by default when it is attached to a terminal, unless -q
> > +       is specified. This flag forces progress status even if the
> > +       standard error stream is not directed to a terminal.
> 
> What this kind of implies, but neglects to say explicitly, is that the
> logic implemented by this patch also overrides --quiet. It probably
> should say so explicitly.
> 
> I realize that this text was copied from elsewhere (likely from
> git-clone.txt), but git-checkout.txt does try to do a bit better job
> with formatting, so it might be a good idea to quote -q with backticks
> (`-q` or `--quiet`).

I was the one who suggested originally that --progress should override
--quiet[1]. However, that was just based on what I thought was
reasonable. I didn't look at what clone or other commands do.
Consistency between commands is probably more important than any
particular behavior.

[1] To be honest, this is kind of a crazy corner case anyway. It was
more just that it has to do _something_.

> > +       /*
> > +        * Final processing of show_progress
> > +        * - User selected --progress: show progress
> > +        * - user selected --no-progress: skip progress
> > +        * - User didn't specify:
> > +        *     (check rules in order till finding the first matching one)
> > +        *     - user selected --quiet: skip progress
> > +        *     - stderr is connected to a terminal: show progress
> > +        *     - fallback: skip progress
> > +        */
> 
> It takes longer to read and digest this comment block than it does to
> comprehend the actual logic in code, which is pretty clear in its
> current form. Comment blocks which merely repeat easily digested code
> add little, if any, value, so it might be worthwhile to drop the
> comment altogether.

Yeah, I think I agree.

-Peff
