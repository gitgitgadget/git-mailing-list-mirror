From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fsck: warn about ".git" in trees
Date: Fri, 30 Nov 2012 14:55:09 -0500
Message-ID: <20121130195509.GA8591@sigill.intra.peff.net>
References: <20121128213529.GA16518@sigill.intra.peff.net>
 <50B90E11.8090501@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Nov 30 20:55:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeWgL-0002pu-SS
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 20:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223Ab2K3TzM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Nov 2012 14:55:12 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47845 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030207Ab2K3TzM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 14:55:12 -0500
Received: (qmail 5957 invoked by uid 107); 30 Nov 2012 19:56:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Nov 2012 14:56:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Nov 2012 14:55:09 -0500
Content-Disposition: inline
In-Reply-To: <50B90E11.8090501@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210943>

On Fri, Nov 30, 2012 at 08:50:41PM +0100, Torsten B=C3=B6gershausen wro=
te:

> >Having a ".git" entry inside a tree can cause confusing
> >results on checkout. At the top-level, you could not
> >checkout such a tree, as it would complain about overwriting
> >the real ".git" directory. In a subdirectory, you might
> >check it out, but performing operations in the subdirectory
> >would confusingly consider the in-tree ".git" directory as
> >the repository.
> [snip]
> >+	int has_dotgit =3D 0;
>=20
> Name like "." or ".." are handled as directories by the OS.

Right. In theory git could run on a system that does not treat them
specially, but in practice they are going to be problematic on most
systems.

> ".git" could be a file or a directory, at least in theory, and from
> the OS point of view, but we want to have this as a reserved name.

Exactly.

> Looking at bad directory names, which gives trouble when checking out=
:
>=20
> Should we check for "/" or "../blabla" as well?

We do already (the error is "contains full pathnames"). We also cover
empty pathnames and some other cases.

-Peff
