From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: question about a merge result
Date: Thu, 30 Apr 2009 17:39:17 +0200
Message-ID: <20090430153917.GB18940@atjola.homenet>
References: <38b2ab8a0904300521m9e31867j7848135acfae0faa@mail.gmail.com> <49F99AE3.5090406@gmx.net> <20090430142635.GB23550@coredump.intra.peff.net> <38b2ab8a0904300805j5ce19617mdda3254c37d06d38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Michael Gaber <Michael.Gaber@gmx.net>,
	git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 17:39:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzYMM-0003MW-V9
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 17:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbZD3PjW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Apr 2009 11:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756649AbZD3PjV
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 11:39:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:48536 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754063AbZD3PjV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 11:39:21 -0400
Received: (qmail invoked by alias); 30 Apr 2009 15:39:18 -0000
Received: from i59F5732C.versanet.de (EHLO atjola.local) [89.245.115.44]
  by mail.gmx.net (mp061) with SMTP; 30 Apr 2009 17:39:18 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+vNtIRvSivIiOTKgavJXrDPVdIdZcNqCieO6fyYy
	Bl5IlLoiK8pqLn
Content-Disposition: inline
In-Reply-To: <38b2ab8a0904300805j5ce19617mdda3254c37d06d38@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118026>

On 2009.04.30 17:05:19 +0200, Francis Moreau wrote:
> On Thu, Apr 30, 2009 at 4:26 PM, Jeff King <peff@peff.net> wrote:
> > On Thu, Apr 30, 2009 at 02:34:43PM +0200, Michael Gaber wrote:
> >
> >> > So merging 'b1' into master removed the B file even if in branch=
 'b1'
> >> > I restored it.
> >> >
> >> > Could anybody explain me why this is the correct behaviour and w=
hy not
> >> > file 'B' is not restored as it was done in branch 'b1' ?
> >>
> >> well, I'd say the thing is, that in b1 there is no change at all t=
o the
> >> tree anymore, so when applied to master (without B) there is no b =
restored
> >
> > That is exactly it. Git's 3-way merge doesn't look at the interveni=
ng
> > history at all. It looks _only_ at the two endpoints and their
> > merge-base (well, that is a bit of a simplification, as there may b=
e
> > multiple merge-bases, but it is what is happening here).
> >
>=20
> Well, obviously it's how git works since it's what I got.
>=20
> But the question was more about if the cortectness of the end result:
> should 'B' removed after the merge.
>=20
> IOW if someone works on its own branch remove B file and thought it
> was a bad idea and restore it whereas another person remove B file bu=
t
> miss the fact that it was a bad idea, does the merge should silently
> remove B file ?

You can also have that in the opposite direction. You make a bugfix in
your "master" branch, then cherry-pick that to "maint", but later
realize that you actually can't backport it like and and revert the
cherry-pick.  Then, later, you go to merge "maint" to "master" (to get
other bugfixes that were done directly on "maint"): Should the bugfix b=
e
reverted on "master"? Obviously not.

git takes an approach that's easy to understand: Look at the changes
that the branch made compared to the common ancestor and apply those.
And for a "do it and then revert it" case, the answer is: There are no
changes.

Bj=F6rn
