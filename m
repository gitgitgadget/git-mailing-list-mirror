From: Jeff King <peff@peff.net>
Subject: Re: stash-p broken?
Date: Tue, 29 Jul 2014 13:43:57 -0400
Message-ID: <20140729174357.GA20042@peff.net>
References: <CAJWZfo6j2E2qu1n6JTmtPw109tAjnEfWBvKxwGfTrKSF6MZ2Uw@mail.gmail.com>
 <CAJWZfo741u8KqZax4ReTEg8hy1BKWR2_PofxAQtE4wU=ikRsPw@mail.gmail.com>
 <20140729025940.GA8640@vauxhall.crustytoothpaste.net>
 <20140729092301.GA13134@peff.net>
 <xmqq61ig3xsp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Migdol <michael-spam@migdol.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 19:44:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCBRY-0003CS-En
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 19:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbaG2RoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 13:44:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:42591 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750989AbaG2RoC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 13:44:02 -0400
Received: (qmail 1614 invoked by uid 102); 29 Jul 2014 17:44:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jul 2014 12:44:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jul 2014 13:43:57 -0400
Content-Disposition: inline
In-Reply-To: <xmqq61ig3xsp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254448>

On Tue, Jul 29, 2014 at 10:00:22AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So perhaps we could do something better on the viewing side, and
> > "simplify" combined merges for files with all-identical parents.
> 
> Or you can ask to show the difference with the first parent, no?

Yeah, though there is no way to do the other thing (--second-parent to
show only the index side). I doubt anybody wants that, though. Just
passing --first-parent would probably be fine (that would match "git
stash show", too, though like that "stash show" it is impossible to
override to see the index portion then).

But...

> I do not think giving a single-parent diff when --cc/-c is asked
> for, which is a clear indication that the caller is aware that the
> commit in question is a merge, is such a good idea.

I think that is my point, though. The user is _not_ aware that the
commit in question is a merge. They stashed some stuff, and now they
want to see the result. I'd like to show them a vanilla commit if the
index is irrelevant, and otherwise show them something more interesting.

I definitely don't think that should be the default behavior, but I
don't see a problem with it being part of stash. We pick apart the stash
already in git-stash.sh, so for "git stash show" we can do it ourselves.
But during a traversal, we need support from "git log", since the answer
is different for each stash (and even for each path).

-Peff
