From: Jeff King <peff@peff.net>
Subject: Re: stash-p broken?
Date: Wed, 30 Jul 2014 20:16:27 -0400
Message-ID: <20140731001627.GB22297@peff.net>
References: <CAJWZfo6j2E2qu1n6JTmtPw109tAjnEfWBvKxwGfTrKSF6MZ2Uw@mail.gmail.com>
 <CAJWZfo741u8KqZax4ReTEg8hy1BKWR2_PofxAQtE4wU=ikRsPw@mail.gmail.com>
 <20140729025940.GA8640@vauxhall.crustytoothpaste.net>
 <20140729092301.GA13134@peff.net>
 <xmqq61ig3xsp.fsf@gitster.dls.corp.google.com>
 <20140729174357.GA20042@peff.net>
 <xmqqlhrc2cfo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Migdol <michael-spam@migdol.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 02:16:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCe31-0006vN-3a
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 02:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331AbaGaAQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 20:16:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:43371 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751976AbaGaAQj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 20:16:39 -0400
Received: (qmail 28204 invoked by uid 102); 31 Jul 2014 00:16:39 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Jul 2014 19:16:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Jul 2014 20:16:27 -0400
Content-Disposition: inline
In-Reply-To: <xmqqlhrc2cfo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254532>

On Tue, Jul 29, 2014 at 12:27:07PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think that is my point, though. The user is _not_ aware that the
> > commit in question is a merge. They stashed some stuff, and now they
> > want to see the result. I'd like to show them a vanilla commit if the
> > index is irrelevant, and otherwise show them something more interesting.
> 
> I actually think "git stash list" users should be made very aware
> that they are looking at merge commits, and also what two states
> each of these merge commits represents.

Yeah, I kind of agree, but I also am not optimistic about most users
understanding that. I was trying to gamble on the fact that:

  1. Naive users who do not understand the index will not stage files
     and then stash in the first place.  To them, the stash would be a
     simple diff between two states, the commit and the working tree.

  2. Advanced users would see the more complicated diff, but only
     because they were doing more interesting things with the index.
     They know what the index is, and therefore know that stash must be
     saving it somehow.

Of course that breaks down when the naive user somehow ends up with
staged content in the index (e.g., they are resolving a merge and try to
stash). Then they are thrust into the more complicated situation either
way.

I dunno. I suspect that gamble would work _most_ of the time, and makes
an OK default. On the other hand, "git stash list" was completely
useless for showing diffs for many years, and since becoming useful has
required "--cc" to show anything good. And this is the first complaint
we've seen on the list. Maybe people don't actually care, and educating
people to use "--cc -p" (or "--first-parent -p") is fine.

-Peff
