From: Jeff King <peff@peff.net>
Subject: Re: Which file is older in history?
Date: Thu, 21 Mar 2013 08:24:28 -0400
Message-ID: <20130321122428.GB22607@sigill.intra.peff.net>
References: <CALkWK0nTjoR9qBY-hnkrDKnyf8088ZDJ1LK_zNqAoAB7ndvaww@mail.gmail.com>
 <7vobeddcjq.fsf@alter.siamese.dyndns.org>
 <CALkWK0nRgzNYViKSx97OyHVOQmFN61Ex9EUvr1JK-0=GX=uX0w@mail.gmail.com>
 <20130321122130.GA22607@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 13:25:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIeYI-00035s-Sk
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 13:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757998Ab3CUMYf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Mar 2013 08:24:35 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33753 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757727Ab3CUMYf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 08:24:35 -0400
Received: (qmail 21985 invoked by uid 107); 21 Mar 2013 12:26:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Mar 2013 08:26:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Mar 2013 08:24:28 -0400
Content-Disposition: inline
In-Reply-To: <20130321122130.GA22607@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218716>

On Thu, Mar 21, 2013 at 08:21:30AM -0400, Jeff King wrote:

> On Thu, Mar 21, 2013 at 05:29:39PM +0530, Ramkumar Ramachandra wrote:
>=20
> > > This must be a trick question but the na=C3=AFve way I think of i=
s
> > >
> > >         git log --diff-filter=3DA -- path1 path2
> >=20
> > Thanks, I didn't know about --diff-filter.  I'll need one extra ste=
p
> > to figure out which commit corresponds to the introduction of which
> > file, no?
>=20
> Maybe
>=20
>   git log --format=3D%H --name-status --diff-filter=3DA -- path1 path=
2 |
>   perl -lne '
>     if (/[0-9a-f]{40}/) { $commit =3D $& }
>     elsif (/^A\t(.*)/) { $h{$1} =3D $commit }
>     END { print "$h{$_} $_" for keys(%h) }
>   '

Actually, I only looked at your question, not the original point, which
was not which commit was which, but which one was older. If you just
want to know which is older, then just:

  git log --format=3D%H --name-status --diff-filter=3DA -- path1 path2 =
|
  grep ^A |
  tail -1

which uses the regular traversal order (i.e., mostly following commit
timestamps). You can use --topo-order if you want to make sure it
follows the graph structure.

-Peff
