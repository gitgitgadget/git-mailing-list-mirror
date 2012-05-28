From: Jeff King <peff@peff.net>
Subject: Re: Finding a branch point in git
Date: Mon, 28 May 2012 15:06:39 -0400
Message-ID: <20120528190639.GA2478@sigill.intra.peff.net>
References: <CAMP44s0f7AJPQSTDgvy0U7vx8nxzq2a3vMhSr2Tcc61fetFkJA@mail.gmail.com>
 <20120528062026.GB11174@sigill.intra.peff.net>
 <CAMP44s04msWMOaaH8U30XXg5yXJnEd=bULJ7VPxWSD0Wfh2=EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 28 21:06:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZ5HG-0002PP-Fk
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 21:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885Ab2E1TGq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 15:06:46 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:34403
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753567Ab2E1TGq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 15:06:46 -0400
Received: (qmail 15101 invoked by uid 107); 28 May 2012 19:06:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 May 2012 15:06:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 May 2012 15:06:39 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s04msWMOaaH8U30XXg5yXJnEd=bULJ7VPxWSD0Wfh2=EA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198714>

On Mon, May 28, 2012 at 02:36:04PM +0200, Felipe Contreras wrote:

> > What about a history with multiple branches?
> >
> > --X--A--B--C--D----E =C2=A0(master)
> > =C2=A0 =C2=A0 =C2=A0\ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /
> > =C2=A0 =C2=A0 =C2=A0 G--H--I---J =C2=A0 (branch X)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 =C2=A0/
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0K--L =C2=A0 =C2=A0(branch =
Y)
> [...]
>=20
> Yes, but then you would need to specify a second branch. I would avoi=
d
> that if possible.

I agree that is less nice. But I don't think the operation is
well-defined with a single branch. If you ask for "when did branch X
split", then in the above graph it is unclear if you meant "split from
master", or "split from Y".

Maybe you could assume "master", or assume "git symbolic-ref HEAD" as
the second branch?

> There's also another case that doesn't work:
>=20
> -- X -- A -- B (master)
>          \
>           \
>            C (branch A)
>=20
> Shouldn't be hard to add checks for those cases I think.

Actually, I think that one extends naturally. They are never merged, so
your rev-list never finds a merge commit, and you can just take the
merge base of the branch tips.

-Peff
