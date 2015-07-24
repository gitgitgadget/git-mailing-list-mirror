From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] log: add log.firstparent option
Date: Fri, 24 Jul 2015 01:17:54 -0700
Message-ID: <20150724081753.GA29451@peff.net>
References: <20150723012343.GA21000@peff.net>
 <CAGZ79kbY8hAom+voAOourkDy34nwaACQEM-n=f25Qbg0+ha_8g@mail.gmail.com>
 <20150724074028.GE2111@peff.net>
 <CA+P7+xo11PwE+L3zCy8Nw=xt+ZWKadd_-ra7C-QvNV80B6dCGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Josh Bleecher Snyder <josharian@gmail.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 10:18:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIYBB-0000cw-1T
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 10:18:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbbGXISA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 04:18:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:34430 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753213AbbGXIR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 04:17:57 -0400
Received: (qmail 16473 invoked by uid 102); 24 Jul 2015 08:17:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jul 2015 03:17:57 -0500
Received: (qmail 18689 invoked by uid 107); 24 Jul 2015 08:18:01 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jul 2015 04:18:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jul 2015 01:17:54 -0700
Content-Disposition: inline
In-Reply-To: <CA+P7+xo11PwE+L3zCy8Nw=xt+ZWKadd_-ra7C-QvNV80B6dCGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274563>

On Fri, Jul 24, 2015 at 12:46:57AM -0700, Jacob Keller wrote:

> On Fri, Jul 24, 2015 at 12:40 AM, Jeff King <peff@peff.net> wrote:
> > Whoops. Usually I "format-patch -s" and then add any notes while
> > sending. But the wifi at OSCON was so abysmal that instead I wrote the
> > notes directly into the commit message to send the whole thing later.
> > And of course format-patch is not smart enough to know that I meant
> > everything after the "---" as notes. :)
> 
> Kind of a side track but...
> 
> I think it's up to the caller of git-am to use "--scissors" to cut the
> log? But maybe we could add an option to git-format patch which
> formats and cuts via scissors as it generates the message? Not sure
> the best way to interpret this, but I know I've had trouble where I
> wrote some notes into an email and lost it because I killed the email
> for some other edit. Keeping them inside my local commits before
> sending out email would be handy.. hmmmm

The "---" is orthogonal to "--scissors". With "--scissors", the full
format of the body is:

   some notes or cover letter

   -- >8 --
   the actual commit message

   ---
   more notes

   diff --git ...etc...

So here I was trying to use the "---" to add notes at the end (not
because --scissors is not used consistently, but because I wanted the
reader to see them after reading the commit message). So you could keep
notes in the commit message by writing:

  my notes here

  -- >8 --
  the real commit message

and then "format-patch -s" just works, because it is munging the end.
But if you want to be able to add commit notes at the end, you need
format-patch to realize that any trailers should go before the "---"
(i.e., to realize that the "---" is syntactically significant, and not
just part of your message).

Another option would be to teach git-commit to split the "---" from the
commit message itself, and put the bits after it into git-notes (and
then format-patch already knows how to handle that). I had a patch
series to do that long ago, but I found that I never used it (I usually
_do_ type my notes in the mailer as I'm sending), so I never seriously
pushed for inclusion. I might be able to dig it out of the archive if
you're interested.

-Peff
