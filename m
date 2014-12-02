From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] introduce git root
Date: Tue, 2 Dec 2014 02:04:15 -0500
Message-ID: <20141202070415.GC1948@peff.net>
References: <1417291211-32268-1-git-send-email-arjun024@gmail.com>
 <2AC7B765F56B4AA8A0DB76E8C670A889@PhilipOakley>
 <CAJFMrCEciWXhBb36MVeFPi7Y7D=9zQ2xGPpiyUz9y4_hOh_taw@mail.gmail.com>
 <vpqoaro99xd.fsf@anie.imag.fr>
 <xmqqd284rryz.fsf@gitster.dls.corp.google.com>
 <CAP8UFD2jES1i+6zOt1gXqTWFy1UHu2GBwAisQktd_Ymbj9Db2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Arjun Sreedharan <arjun024@gmail.com>,
	Philip Oakley <philipoakley@iee.org>, Git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 08:04:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvhVS-0006TV-MW
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 08:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754283AbaLBHEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 02:04:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:46993 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752642AbaLBHEO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 02:04:14 -0500
Received: (qmail 26365 invoked by uid 102); 2 Dec 2014 07:04:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Dec 2014 01:04:14 -0600
Received: (qmail 13410 invoked by uid 107); 2 Dec 2014 07:04:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Dec 2014 02:04:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Dec 2014 02:04:15 -0500
Content-Disposition: inline
In-Reply-To: <CAP8UFD2jES1i+6zOt1gXqTWFy1UHu2GBwAisQktd_Ymbj9Db2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260543>

On Mon, Dec 01, 2014 at 05:17:22AM +0100, Christian Couder wrote:

> On Mon, Dec 1, 2014 at 4:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > If I were redoing this today, I would probably nominate the "git"
> > potty as such a "kitchen synk" command.  We have "--man-path" that
> > shows the location of the manual pages, "--exec-path[=path]" that
> > either shows or allows us to override the path to the subcommands,
> > and "--show-prefix", "--show-toplevel", and friends may feel quite
> > at home there.
> 
> I wonder if we could reuse "git config" which is already a "kitchen
> synk" command to get/set a lot of parameters.
> Maybe we could dedicate a "git" or "virtual" or "proc" or "sys" (like
> /proc or /sys  in Linux) namespace for these special config parameters
> that would not necessarily reflect something in the config file.
> 
> "git config git.man-path" would be the same as "git --man-path".
> "git config git.root" would be the same as "git rev-parse --show-toplevel".
> "git config git.exec-path mypath" would allow us to override the path
> to the subcommands, probably by saving something in the config file.

What would:

  git config git.root foo
  git config git.root

output? No matter what the answer is, I do not relish the thought of
trying to explain it in the documentation. :)

There is also "git var", which is a catch-all for printing some deduced
environmental defaults. I'd be just as happy to see it go away, though.
Having:

  git --exec-path
  git --toplevel
  git --author-ident

all work would make sense to me (I often get confused between "git
--foo" and "git rev-parse --foo" when trying to get the exec-path and
git-dir). And I don't think it's too late to move in this direction.
We'd have to keep the old interfaces around, of course, but it would
immediately improve discoverability and consistency.

-Peff
