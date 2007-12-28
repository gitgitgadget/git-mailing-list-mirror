From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Anomalous conflicts during git rebase
Date: Fri, 28 Dec 2007 19:54:49 +0100
Message-ID: <20071228185449.GA30574@atjola.homenet>
References: <m3ir2ju5ce.fsf@euroclydon.lan> <alpine.LNX.1.00.0712271840030.13593@iabervon.org> <m3k5my7r1u.fsf@euroclydon.lan> <alpine.LNX.1.00.0712281246330.13593@iabervon.org> <m3fxxm7jp6.fsf@euroclydon.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: adr3nald0s@gmail.com
X-From: git-owner@vger.kernel.org Fri Dec 28 19:55:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8KMb-0006wP-Jf
	for gcvg-git-2@gmane.org; Fri, 28 Dec 2007 19:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbXL1Syz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Dec 2007 13:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752304AbXL1Syy
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 13:54:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:43398 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751619AbXL1Syy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 13:54:54 -0500
Received: (qmail invoked by alias); 28 Dec 2007 18:54:51 -0000
Received: from i577ACD85.versanet.de (EHLO localhost) [87.122.205.133]
  by mail.gmx.net (mp027) with SMTP; 28 Dec 2007 19:54:51 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/Axqxo1lDANtXmiP7YJGQjOea8+Rz5WD1uOJT22g
	xSaHU4ijGl5Dix
Content-Disposition: inline
In-Reply-To: <m3fxxm7jp6.fsf@euroclydon.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69294>

On 2007.12.28 12:33:41 -0600, adr3nald0s@gmail.com wrote:
> Daniel Barkalow <barkalow@iabervon.org> writes:
>=20
> > On Fri, 28 Dec 2007, adr3nald0s@gmail.com wrote:
> >
> >> When you say it linearizes history how is this done.
> >
> > Rebase takes a list of commits that are in the current branch and=20
> > aren't in the origin branch as what it's going to work on; these ar=
e=20
> > ordered in some arbitrary way such that children always follow pare=
nts. It=20
> > then resets to the origin branch's commit, and, in sequence, cherry=
-picks=20
> > each of the commits in the working list.
>=20
> Thanks again for the clear explanation.
>=20
> > In theory, of course, it could try to resolve conflicts by looking =
through=20
> > the rest of the list for merges which would have those conflicts an=
d using=20
> > what that merge did. =20
>=20
> Given the implementation, this would be just plain ugly.  I would not
> want to attempt to implement something like this, nor would I expect
> anyone else to do so.

I wouldn't make sense either. The conflict resolution that was done in
the merge commit might need stuff from commits that haven't been rebase=
d
yet. For example a new function that was introduced later, it was
available for the merge, but is still missing from the rebased linear
history.

That said, what _might_ make sense is to teach interactive rebase with
-p to use "cherry-pick -m1" or whatever instead of "merge" to recreate
the merge commits (or maybe it does that already now? didn't check...).
That way, it wouldn't have to rely on rerere being enabled to avoid the
repeated resolving of the merge conflicts. I'm not sure how that would
need to interact with new changes introduces into one of the rewritten
branches.

Bj=F6rn
