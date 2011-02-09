From: Jeff King <peff@peff.net>
Subject: Re: Advices to imlement update hook
Date: Wed, 9 Feb 2011 12:05:35 -0500
Message-ID: <20110209170535.GA5254@sigill.intra.peff.net>
References: <AANLkTimdsCgNBAnJmnzGj3M3Q4RPb==fiWu1+ZQhWenO@mail.gmail.com>
 <4D52C2FA.2030103@viscovery.net>
 <4D52C403.30501@viscovery.net>
 <AANLkTik=Xw3b1i-AranJtfngOsfLvEDSzrMq3jKTy-Yy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 18:05:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnDU9-0007Jv-E6
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 18:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773Ab1BIRFk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 12:05:40 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:41825 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753039Ab1BIRFk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 12:05:40 -0500
Received: (qmail 10869 invoked by uid 111); 9 Feb 2011 17:05:37 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 09 Feb 2011 17:05:37 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Feb 2011 12:05:35 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTik=Xw3b1i-AranJtfngOsfLvEDSzrMq3jKTy-Yy@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166433>

On Wed, Feb 09, 2011 at 05:51:24PM +0100, Francis Moreau wrote:

> >>> =C2=A0 =C2=A0git diff-tree <oldref> <newref> -- ^b || exit 1
> >>>
> >>> but it doesn't work.
> >>
> >> =C2=A0 git diff-tree --quiet <oldref> <newref> -- b
> >
> > should do it; it sets the exit code.
>=20
> but does that work if a commit modify b/ and another directory ?

No, it just looks for commits that modified b. There is currently no wa=
y
to specify a path to say "commit that did not modify b". You need to
check the output of:

  git rev-list | git diff-tree --stdin -m --name-only

which should list all paths modified by all commits. And then you can
either blacklist or whitelist as appropriate (note that the names can b=
e
quoted; you might want to look at the "-z" option and do your
list-checking in perl).

> > But don't you also want to inspect all commits between oldref and n=
ewref?
>=20
> Yes I want to inspect all commits in the range.

see above.

> > Someone could have modified the directory, and then reverted the
> > modification in a later commit. If these commits arrive in a single=
 push,
> > the above code wouldn't notice this.
>=20
> I agree but I thought that git diff-tree would list all changes made
> between the 2 refs.

Between the two endpoints. It won't even look at the commits in the
middle, so as long as a later middle commit reverts the change of an
earlier middle commit, the endpoints won't be affected.

-Peff
