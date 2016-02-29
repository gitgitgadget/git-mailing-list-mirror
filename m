From: Jeff King <peff@peff.net>
Subject: Re: git cat-file -e behavior
Date: Mon, 29 Feb 2016 07:36:45 -0500
Message-ID: <20160229123645.GA20754@sigill.intra.peff.net>
References: <56D41645.4050800@cihar.com>
 <20160229114455.GD29769@sigill.intra.peff.net>
 <56D436A2.4090202@cihar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michal =?utf-8?B?xIxpaGHFmQ==?= <michal@cihar.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 13:36:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaN4K-0004vw-6I
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 13:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbcB2Mgw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 07:36:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:51365 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752129AbcB2Mgv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 07:36:51 -0500
Received: (qmail 17510 invoked by uid 102); 29 Feb 2016 12:36:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 07:36:47 -0500
Received: (qmail 25874 invoked by uid 107); 29 Feb 2016 12:36:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 07:36:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Feb 2016 07:36:45 -0500
Content-Disposition: inline
In-Reply-To: <56D436A2.4090202@cihar.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287832>

On Mon, Feb 29, 2016 at 01:16:34PM +0100, Michal =C4=8Ciha=C5=99 wrote:

> Dne 29.2.2016 v 12:44 Jeff King napsal(a):
> > It looks like it has been this way forever. The first thing we do w=
ith
> > the object is resolve its name to a sha1, and that's where the erro=
r you
> > see comes from. And then we actually check whether we have the obje=
ct.
> >=20
> > I think the intended use was to feed it a sha1 to see if it exists.=
 Then
> > the name-resolution step is a noop.
>=20
> I found this as best way to check whether file exists in branch.
> Checking git ls-tree output seems less error prone than checking retu=
rn
> value of git cat-file -e...

I think the usual way to do that would be:

  git rev-parse --verify $branch:$path >/dev/null

which just resolves the name (not that what you are doing is wrong, I
just think rev-parse is the way we usually do it in our scripts).

That _will_ write a message to stderr when the name doesn't resolve.

-Peff
