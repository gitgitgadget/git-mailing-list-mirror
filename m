From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: About detached heads
Date: Fri, 14 Mar 2008 19:37:31 +0100
Message-ID: <20080314183731.GA2994@atjola.homenet>
References: <93c3eada0803140246k53408c74m21f9dc277857202d@mail.gmail.com> <alpine.LFD.1.00.0803141041080.3557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Geoff Russell <geoffrey.russell@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 14 19:38:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaEnF-0006bM-PN
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 19:38:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbYCNShe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Mar 2008 14:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753201AbYCNShe
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 14:37:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:34731 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751416AbYCNShe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 14:37:34 -0400
Received: (qmail invoked by alias); 14 Mar 2008 18:37:32 -0000
Received: from i577BA224.versanet.de (EHLO atjola.local) [87.123.162.36]
  by mail.gmx.net (mp037) with SMTP; 14 Mar 2008 19:37:32 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19H/ssPu2dHwq+OppC4vVt3y3Jf5fE0UBf0Vab5/A
	bn+sgLMzE0RYLm
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0803141041080.3557@woody.linux-foundation.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77270>

On 2008.03.14 10:53:25 -0700, Linus Torvalds wrote:
>=20
>=20
> On Fri, 14 Mar 2008, Geoff Russell wrote:
> >
> > This should be simple! I have a series of commits:
> >=20
> >            1---2---3---4---5
> >=20
> > I want to go back to 3 but not branch, so I want
> >=20
> >            1---2---3---4---5---3
>=20
> This is actually an uncommonly easy operation for core git, but it's =
a=20
> very unusual thing to want to do in general, so I don't think there i=
s any=20
> high-level command to do it directly. But it's really easy to do with=
=20
> a single so-called "plumbing" command, namely "git read-tree".
>=20
> So the "core git" way to do it is to literally just do
>=20
> 	git read-tree -u -m 3
> 	git commit
>=20
> (or use "--reset" instead of "-m" if you want to do it even in the=20
> presense unmerged entries).
>=20
> What the above does is to literally just read the tree state at "3", =
and=20
> make it the new index: the "-u" means that we also want to update the=
=20
> working tree to that state, and the "-m" means that we will merge in =
the=20
> old index stat information.
>=20
> The commit then will then create the actual new commit: it will have =
the=20
> exact same tree as your commit '3', but it will be a new commit (so c=
all=20
> it 3').
>=20
> Of course, people have already pointed out that another easy way to d=
o it=20
> is to just revert 5 and 4. That may be the more high-level way to do =
it,=20
> but the git-read-tree approach actually has the advantage that it wil=
l=20
> work even across merges etc, and it will be very unambiguous: we want=
=20
> *exactly* the state at commit 3 back, nothing else.

Hm, that's just squashing revert commit. Squashing can be done via:
git reset --soft HEAD~5    # Or wherever your squashed commit should st=
art
git commit -m "Squashed from HEAD~5 onwards"

Now the "revert" version of that:
git reset --hard HEAD~5      # Go back to the state that we want
git reset --soft ORIG_HEAD   # Move HEAD back, but keep the index as is
git commit -m "Back at the state of HEAD~5"

AFAICT that should have the same advantages as using read-tree, but
doesn't feel so low-level :-)

Bj=F6rn
