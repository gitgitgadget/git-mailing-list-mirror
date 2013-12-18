From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: I have end-of-lifed cvsps
Date: Wed, 18 Dec 2013 11:27:10 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20131218162710.GA3573@thyrsus.com>
References: <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
 <20131212042624.GB8909@thyrsus.com>
 <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
 <52B02DFF.5010408@gmail.com>
 <20131217140746.GB15010@thyrsus.com>
 <CANQwDwe8AcbCYG5GZcY1tn9BN0x5KWux_CNQY2OWG+qZJ5rS4Q@mail.gmail.com>
 <20131217210255.GA18217@thyrsus.com>
 <CANQwDwdQZGhR=hhFHe7wRAeNej_F5fHspN7+f-LiJu06utwC-w@mail.gmail.com>
 <20131218002122.GA20152@thyrsus.com>
 <CANQwDwdgZUWcgyZCWoDni+e9jgQ+8j0Yn_HMxiMn5OHzsRzjwQ@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 17:27:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtJxs-00007n-6i
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 17:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243Ab3LRQ1M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Dec 2013 11:27:12 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:44900
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896Ab3LRQ1M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 11:27:12 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 457FE380488; Wed, 18 Dec 2013 11:27:10 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CANQwDwdgZUWcgyZCWoDni+e9jgQ+8j0Yn_HMxiMn5OHzsRzjwQ@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239454>

Jakub Nar=C4=99bski <jnareb@gmail.com>:
> It is a bit strange that markfile has explicitly SHA-1 (":markid <SHA=
-1>"),
> instead of generic reference to commit, in the case of CVS it would b=
e
> commitid (what to do for older repositories, though?), in case of Baz=
aar
> its revision id (GUID), etc.  Can we assume that SCM v1 fast-export a=
nd
> SCM v2 fast-import markfile uses compatibile commit names in markfile=
?

=46or use in reposurgeon I have defined a generic cross-VCS reference t=
o
commit I call an "action stamp"; it consists of an RFC3339 date followe=
d by=20
a committer email address. Here's an example:

	 2013-02-06T09:35:10Z!esr@thyrsus.com

In any VCS with changesets (git, Subversion, bzr, Mercurial) this
almost always suffices to uniquely identify a commit. The "almost" is
because in these systems it is possible for a user to do multiple commi=
ts
in the same second.

And now you know why I wish git had subsecond timestamp resolution!  If=
 it
did, uniqueness of these in a git stream could be guaranteed.

The implied model completely breaks for CVS, of course.  There you have=
 to=20
use commitids and plain give up when those don't exist.
=20
> I think it would be possible for remote-helper for cvs-fast-export to=
 find
> this cutoff date automatically (perhaps with some safety margin), for
> fetching (incremental import).

Yes.
=20
> > As I tried to explain previously in my response to John Herland, it=
's
> > incremental output only.  There is *no* CVS exporter known to me, o=
r
> > him, that supports incremental work.  That would be at best be impr=
actically
> > difficult; given CVS's limitations it may be actually impossible. I=
 wouldn't
> > bet against impossible.
>=20
> Even with saving (or re-calculating from git import) guesses about CV=
S
> history made so far?

Even with that.  cvsps-2.x tried to do something like this.  It was a l=
ose.
=20
> Anyway I hope that incremental CVS import would be needed less
> and less as CVS is replaced by any more modern version control system=
=2E

I agree.  I have never understood why people on this list are attached =
to it.

> I was thinking about creating remote-helper for cvs-fast-export, so t=
hat
> git can use local CVS repository as "remote", using e.g. "cvsroot::<p=
ath>"
> as repo URL, and using this mechanism for incremental import (aka fet=
ch).
> (Or even "cvssync::<URL>" for automatic cvssync + cvs-fast-export).
>=20
> But from what I understand this is not as easy as it seems, even with
> remote-helper API having support for fast-import stream.

It's a swamp I wouldn't want to walk into.
--=20
		<a href=3D"http://www.catb.org/~esr/">Eric S. Raymond</a>
