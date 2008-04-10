From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.11
Date: Thu, 10 Apr 2008 10:56:04 +0200
Message-ID: <20080410085604.GA21998@diku.dk>
References: <20080406200533.GA20537@diku.dk> <20080410040213.GA29618@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 10 10:56:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjsaW-0004xx-13
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 10:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755573AbYDJI4L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Apr 2008 04:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755530AbYDJI4L
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 04:56:11 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:43002 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755413AbYDJI4J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 04:56:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id EBEE319BB82;
	Thu, 10 Apr 2008 10:56:07 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 03727-11; Thu, 10 Apr 2008 10:56:05 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 49E9A19BB58;
	Thu, 10 Apr 2008 10:56:05 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id AD8506DFB5B; Thu, 10 Apr 2008 10:54:37 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id DAEC61DC936; Thu, 10 Apr 2008 10:56:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080410040213.GA29618@sigill.intra.peff.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79200>

Jeff King <peff@peff.net> wrote Thu, Apr 10, 2008:
> On Sun, Apr 06, 2008 at 10:05:33PM +0200, Jonas Fonseca wrote:
>=20
> > stay up to date. Finally, add a blame view accessible from the comm=
and
> > line (tig blame [rev] file), status view as well as the tree view (=
by
> > pressing 'B').
>=20
> Hi Jonas,

Hello Jeff,

> Thanks for all your hard work.  I have really been enjoying the new
> blame view; blame was the only reason I ever used git-gui, and now I =
can
> stay in the terminal all the time.

That is great to hear.

> One feature that I have often wanted when using the blame view is to
> restart the blame from the parent commit of a blamed commit. That is,
> given a line like:
>=20
>   2007-08-22 19:36 Jonas Fonseca       776bf2a   15=E2=94=82 #include=
 "config.h"
>=20
> I look at 776bf2a, and realize that there was some other interesting
> form of the line _before_ that commit. So I want to start reblaming a=
t
> 776bf2a^.

The current blame capability is very basic and this sounds like a good
idea for extending it.

> Below is an initial attempt at a patch, but it has some problems:
>=20
>   - the interface is a bit klunky. Since commits may have multiple
>     parents, it seemed wrong to always just choose the first parent.
>     I chose '1' to reblame from the first parent and '2' from the sec=
ond
>     (and obviously 3-9 could do the same).
>=20
>     My thought was that the same functionality could be applied to th=
e
>     commit viewer to jump to the parent. But maybe grabbing a string =
and
>     appending it to the commit id would make the most sense.

Either that or there could be an option to show parent commit lines in =
the
diff view =C3=A0 la gitk:

	Parent: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa (Do something)
	Parent: bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb (Do something else)

and then make pressing 'B' on one of them start it. At least this shoul=
d
solve the problem of having the option for all parents. Using '1', '2',
=2E..  or '^' + a number could still work as a short hand.

>   - it reloads the blame view with new parameters, which will put the
>     cursor back at line 1. It would be nice to stay at approximately =
the
>     same line (approximate because the line numbers will change; just
>     staying at the same line number makes sense to me).
>=20
>     I tried a few things, but it looks like we throw out the line
>     numbers when we do a reload. I tried saving the line number and
>     trying to scroll to it afterwards, but there is some trickery
>     required because we have to wait until the view is loaded again. =
Is
>     there any sane way to do this within the current framework?

There is currently no way to do this. Some views have their own hacks t=
o
restore the position. But a general way to preserve the position in a
view across reloads is something that will come in handy for the status
and staging area as well.

>   - opening a blame view, blaming a parent, and then opening the diff
>     viewer can cause a segfault. I assume I'm violating some assumpti=
on
>     through my open_view() call. Since the patch is only about 15 lin=
es,
>     I'm hoping there's something obvious you can comment on.

Oops. I will look into it when I get more time. Thanks for the ideas an=
d
the clean patch.

--=20
Jonas Fonseca
