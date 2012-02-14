From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff-highlight: Work for multiline changes too
Date: Mon, 13 Feb 2012 19:22:09 -0500
Message-ID: <20120214002209.GA23171@sigill.intra.peff.net>
References: <20120210213209.GA7582@sigill.intra.peff.net>
 <1328910433-2539-1-git-send-email-michal.kiedrowicz@gmail.com>
 <20120213222702.GA19393@sigill.intra.peff.net>
 <7v8vk6b7pq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 01:22:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx69y-0005KK-4P
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 01:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815Ab2BNAWN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Feb 2012 19:22:13 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34530
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898Ab2BNAWN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 19:22:13 -0500
Received: (qmail 2753 invoked by uid 107); 14 Feb 2012 00:29:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 13 Feb 2012 19:29:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Feb 2012 19:22:09 -0500
Content-Disposition: inline
In-Reply-To: <7v8vk6b7pq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190693>

On Mon, Feb 13, 2012 at 04:05:05PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>=20
> > I ended up pulling your changes out into a few distinct commits. Th=
at
> > made it easier for me to review and understand what was going on (a=
nd
> > hopefully ditto for other reviewers, or people who end up bisecting=
 or
> > reading the log later). I'll post that series in a moment.
>=20
> This is all nice.  As I am lazy and this is a long neglected contrib/
> material I didn't even know it existed ;-), I am tempted to apply the=
m
> directly on top of 'master'.

Yeah, given the contrib nature, I'm comfortable just applying. I wanted
to wait on the attribution question from Micha=C5=82 before sending a f=
inal
version, though.

> This shows the first hunk of your "diff-highlight: refactor to prepar=
e for
> multi-line hunks" like this to me, by the way.
>=20
> @@ -23,7 +23,7 @@ while (<>) {
>             $window[2] =3D~ /^$COLOR*\+/ &&
>             $window[3] !~ /^$COLOR*\+/) {
>                 print shift @window;
> {-               show_pair}(shift @window, shift @window);
> +               show_{hunk}(shift @window, shift @window);
>         }
>         else {
>                 print shift @window;
>=20
> Is this intended, or is setting "diff.color.old =3D red reverse" not
> supported (without the custom configuration, the leading blank on the=
 old
> line is not highlighted)?

No, it's not intended, and should be:

   -                show-{pair}...
   +                show+{hunk}...

(and appears that way with my config).  I suspect it is because the
default highlight color is a subset of your "old" configured color. It
is ANSI "reverse video", but sadly that does not work as a toggle (i.e.=
,
it does not reverse your reverse, but simply is a no-op).

I chose reverse because I like the way it looks, and because it should
Just Work if people have selected alternate colors (I never dreamed
somebody would use "reverse" all the time, as I find it horribly ugly.
But to each his own).  We could read the highlight color from
diff.highlight{Old,New}. That would also let people highlight in purple
or something if they care.

-Peff
