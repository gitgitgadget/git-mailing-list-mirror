From: Jeff King <peff@peff.net>
Subject: Re: imap-send badly handles commit bodies beginning with "From <"
Date: Tue, 1 Nov 2011 08:38:03 -0700
Message-ID: <20111101153803.GB5552@sigill.intra.peff.net>
References: <20111028180044.GA3966@foghorn.codeweavers.com>
 <20111028203256.GA15082@sigill.intra.peff.net>
 <20111030090111.GA1624@jpl.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Andrew Eikum <aeikum@codeweavers.com>
To: Magnus =?utf-8?B?QsOkY2s=?= <magnus.back@sonyericsson.com>
X-From: git-owner@vger.kernel.org Tue Nov 01 16:38:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLGPk-0004Yu-1y
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 16:38:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755153Ab1KAPiG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Nov 2011 11:38:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59331
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170Ab1KAPiF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 11:38:05 -0400
Received: (qmail 4852 invoked by uid 107); 1 Nov 2011 15:43:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Nov 2011 11:43:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Nov 2011 08:38:03 -0700
Content-Disposition: inline
In-Reply-To: <20111030090111.GA1624@jpl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184572>

On Sun, Oct 30, 2011 at 10:01:11AM +0100, Magnus B=C3=A4ck wrote:

> > Mbox does have this problem, but I think in this case it is a
> > particularly crappy implementation of mbox in imap-send. Look at
> > imap-send.c:split_msg; it just looks for "From ".
>=20
> While there seems to be about a million different implementations of
> mbox creation and parsing, the relevant RFC[0] points to [1] as an
> authoritative source. The latter claims that lines matching "^From "
> denote a message boundary and that lines within a message that match
> the same pattern should be quoted with ">". That would suggest that
> the problem isn't imap-send.c but whatever code produces the mbox
> file in the first place. Of course, if that software isn't part of
> Git I guess we'll have to deal with the situation anyway. And whateve=
r
> the RFCs say, we still need to be as compatible is possible with
> whatever software is out there.

Right. If you properly quote and unquote "From " lines, then mbox can b=
e
unambiguous. But many pieces of software don't quote them (including
git, I think, but I didn't check), so it's prudent when reading to look
for something that actually appears to be a "From" line.

If somebody wants to tackle >From quoting of commit messages in
git-format-patch, they can certainly do so. In practice, it doesn't ten=
d
to come up (because sane readers expect there to be a date at the end o=
f
the line), so nobody has put forth the effort.

-Peff
