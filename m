From: Jeff King <peff@peff.net>
Subject: Re: Which file is older in history?
Date: Thu, 21 Mar 2013 08:21:30 -0400
Message-ID: <20130321122130.GA22607@sigill.intra.peff.net>
References: <CALkWK0nTjoR9qBY-hnkrDKnyf8088ZDJ1LK_zNqAoAB7ndvaww@mail.gmail.com>
 <7vobeddcjq.fsf@alter.siamese.dyndns.org>
 <CALkWK0nRgzNYViKSx97OyHVOQmFN61Ex9EUvr1JK-0=GX=uX0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 13:22:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIeVP-00017b-Sy
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 13:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840Ab3CUMVi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Mar 2013 08:21:38 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33745 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755728Ab3CUMVh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 08:21:37 -0400
Received: (qmail 21944 invoked by uid 107); 21 Mar 2013 12:23:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Mar 2013 08:23:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Mar 2013 08:21:30 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0nRgzNYViKSx97OyHVOQmFN61Ex9EUvr1JK-0=GX=uX0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218715>

On Thu, Mar 21, 2013 at 05:29:39PM +0530, Ramkumar Ramachandra wrote:

> > This must be a trick question but the na=C3=AFve way I think of is
> >
> >         git log --diff-filter=3DA -- path1 path2
>=20
> Thanks, I didn't know about --diff-filter.  I'll need one extra step
> to figure out which commit corresponds to the introduction of which
> file, no?

Maybe

  git log --format=3D%H --name-status --diff-filter=3DA -- path1 path2 =
|
  perl -lne '
    if (/[0-9a-f]{40}/) { $commit =3D $& }
    elsif (/^A\t(.*)/) { $h{$1} =3D $commit }
    END { print "$h{$_} $_" for keys(%h) }
  '

?

-Peff
