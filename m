From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] reflog: make the 'show' subcommand really the
 default
Date: Thu, 22 Apr 2010 10:40:59 -0400
Message-ID: <20100422144059.GA28923@coredump.intra.peff.net>
References: <1271670750-30297-1-git-send-email-szeder@ira.uka.de>
 <7veiiblzn9.fsf@alter.siamese.dyndns.org>
 <20100420113736.GA22907@coredump.intra.peff.net>
 <20100422135731.GS4440@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Apr 22 16:41:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4xb0-00066s-Qy
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 16:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369Ab0DVOlc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 10:41:32 -0400
Received: from peff.net ([208.65.91.99]:56594 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754964Ab0DVOlb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 10:41:31 -0400
Received: (qmail 1733 invoked by uid 107); 22 Apr 2010 14:41:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 22 Apr 2010 10:41:38 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Apr 2010 10:40:59 -0400
Content-Disposition: inline
In-Reply-To: <20100422135731.GS4440@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145535>

On Thu, Apr 22, 2010 at 03:57:31PM +0200, SZEDER G=C3=A1bor wrote:

> > That being said, we tried this same experiment with "git stash [sho=
w]
> > <msg>" and ended up rejecting it. However, the main complaint with =
that
> > was the failure mode for typos. Typing "git stash sohw" would make =
a new
> > stash.
>=20
> I think you meant "git stash [save] <msg>" here, right?
>=20
> http://thread.gmane.org/gmane.comp.version-control.git/63566/focus=3D=
63645

Er, yeah, that is what I meant. Sorry, thinko on my part.

> > In this case, typing "git reflog exipre" would get you:
> >=20
> >   fatal: ambiguous argument 'exipre': unknown revision or path not =
in
> >   the working tree.
> >   Use '--' to separate paths from revisions
> >=20
> > and you would repeat the command with the typo fixed, which is perh=
aps
> > not as bad. And unlike stash, "show" is really the dominant command=
 (I
> > don't think I have ever manually used 'delete' or 'expire'), so it =
is
> > more likely to be right than not.
>=20
> If I understood Junio correctly, he is concerned about a different
> case.
>=20
> With my patch "git reflog foo" would show foo's reflog, assuming ther=
e
> is a branch named "foo".  This is what people would expect according
> to the documentation.  However, once we implement the subcommand
> "foo", "git reflog foo" will no longer print foo's reflog but instead
> will perform whatever the subcommand "foo" is supposed to do by
> default, which might be difficult to recover from.

Right, what you quoted from me was not Junio's concern. But I argued
against Junio's concern earlier in the mail. Basically, it is a corner
case. _If_ we add a new command to "git reflog", and _if_ that command
is the same as the name of your ref, you must stop using the short form
for that ref, and instead use "git reflog show $ref".

So for things like scripts that don't know what $ref will be, and want
to be on the safe side, they should continue to use the explicit "git
reflog show $ref" form. But there is no reason that humans typing a
command need to be bound by that restriction when it is unlikely to
happen (and even if it did, they would recover from it easily).

Personally, I don't care either way whether the documentation is update=
d
to match the behavior of vice versa. But I just don't see what your
original patch did as very harmful, and I can see how it would be
helpful (on the few occassions when I did use "git reflog show", I firs=
t
typed it forgetting the "show").

-Peff
