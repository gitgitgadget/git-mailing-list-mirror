From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] clone: do not ignore --no-hardlinks
Date: Fri, 27 Feb 2009 06:35:59 -0500
Message-ID: <20090227113558.GA19756@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0902262352380.10279@pacific.mpi-cbg.de> <da2c9173f403c4fb509609fb823b6be0728d94f3.1235690903u.git.johannes.schindelin@gmx.de> <20090227025829.GA22060@coredump.intra.peff.net> <7vy6vsmjeo.fsf@gitster.siamese.dyndns.org> <7vr61kmht9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 12:37:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld11x-0007LZ-24
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 12:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754672AbZB0Lf4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2009 06:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754654AbZB0Lfz
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 06:35:55 -0500
Received: from peff.net ([208.65.91.99]:44251 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754649AbZB0Lfz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 06:35:55 -0500
Received: (qmail 12151 invoked by uid 107); 27 Feb 2009 11:36:16 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.0.130)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 27 Feb 2009 06:36:16 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Feb 2009 06:35:59 -0500
Content-Disposition: inline
In-Reply-To: <7vr61kmht9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111663>

On Thu, Feb 26, 2009 at 11:59:14PM -0800, Junio C Hamano wrote:

> Except that it does not work.
>=20
> Initializing option_local to -1 and then feeding it to parse_options(=
) via
> OPT_BOOLEAN() is a cute idea, but when parse_options() sees a command=
 line
> like this:

Ah, sorry. I didn't really test it thoroughly (though I did try
--no-local, I obviously did not test --local with a hardlink failure).

> Damn it, it is called BOOLEAN, and na=C3=AFvely I would think --optio=
n would
> set it to 1, --no-option would set it to 0, and not having --option n=
or
> --no-option would leave the associated variable alone, but apparently=
 that
> is not what is happening.

That is exactly what I expected as a caller (and it sounds like you did=
,
too), which perhaps argues in favor of changing it.

Upon seeing this, I guessed (as you did in the next email) that it was
about bumping up levels of a boolean for things like verbosity. And I
agree that sould not be OPT_BOOLEAN, but rather OPT_INCREMENT or
whatever.

However, I did some grepping and it doesn't look like anybody is
actually making use of the incrementing behavior (I was just looking fo=
r
"verbose", though, so it's possible some unrelated boolean is using it)=
=2E
So it may be that the behavior can be changed now while no callers care=
,
and we can get away without OPT_INCREMENT until somebody actually needs
it.

-Peff
