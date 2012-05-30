From: Jeff King <peff@peff.net>
Subject: Re: Finding a branch point in git
Date: Wed, 30 May 2012 17:54:15 -0400
Message-ID: <20120530215415.GB3237@sigill.intra.peff.net>
References: <CAMP44s0f7AJPQSTDgvy0U7vx8nxzq2a3vMhSr2Tcc61fetFkJA@mail.gmail.com>
 <20120528062026.GB11174@sigill.intra.peff.net>
 <CAMP44s04msWMOaaH8U30XXg5yXJnEd=bULJ7VPxWSD0Wfh2=EA@mail.gmail.com>
 <20120528190639.GA2478@sigill.intra.peff.net>
 <CAMP44s0UBsVicuEcwACsm1zTT_jGau_Q20hJv4J_6uvancYJRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 30 23:54:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZqqU-00055D-7G
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 23:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757216Ab2E3VyS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 May 2012 17:54:18 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:36576
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757055Ab2E3VyR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 17:54:17 -0400
Received: (qmail 10411 invoked by uid 107); 30 May 2012 21:54:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 May 2012 17:54:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 May 2012 17:54:15 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s0UBsVicuEcwACsm1zTT_jGau_Q20hJv4J_6uvancYJRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198840>

On Wed, May 30, 2012 at 07:07:39PM +0200, Felipe Contreras wrote:

> On Mon, May 28, 2012 at 9:06 PM, Jeff King <peff@peff.net> wrote:
> > On Mon, May 28, 2012 at 02:36:04PM +0200, Felipe Contreras wrote:
> >
> >> > What about a history with multiple branches?
> >> >
> >> > --X--A--B--C--D----E =C2=A0(master)
> >> > =C2=A0 =C2=A0 =C2=A0\ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /
> >> > =C2=A0 =C2=A0 =C2=A0 G--H--I---J =C2=A0 (branch X)
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 =C2=A0/
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0K--L =C2=A0 =C2=A0(bran=
ch Y)
> >> [...]
> >>
> >> Yes, but then you would need to specify a second branch. I would a=
void
> >> that if possible.
> >
> > I agree that is less nice. But I don't think the operation is
> > well-defined with a single branch. If you ask for "when did branch =
X
> > split", then in the above graph it is unclear if you meant "split f=
rom
> > master", or "split from Y".
>=20
> If you look from the context that I explained in the first mail; it
> would be from *any* branch; IOW; find the first commit from branch X
> (G), and then find the parent. That would be the first commit where
> branch X started.

I'm not sure that's possible, though, in the face of criss-cross merges=
=2E
How do we distinguish the history above from one in which branch Y was
forked from master at G, and then branch X was forked from branch Y at
H?

> I think it would be easy to support this case if somehow there was a
> way to find all the commits that comprise a branch;
>=20
>  % git log branch ^<any-other-branch>
>=20
> I could swear I saw such an option, but I've been looking for days an=
d
> I can't find it.

I don't think there is such an option. You have to do something like:

  {
    echo "--not"
    git for-each-ref --format=3D'%(refname)' | grep -v "^$branch\$"
  } |
  git rev-list --stdin $branch

-Peff
