From: Jeff King <peff@peff.net>
Subject: Re: t5551 hangs ?
Date: Wed, 11 May 2016 23:16:28 -0400
Message-ID: <20160512031628.GA2741@sigill.intra.peff.net>
References: <cover.1462774709.git.johannes.schindelin@gmx.de>
 <cover.1462863934.git.johannes.schindelin@gmx.de>
 <ff8cbab7e62211b13835e520d402fbd89b90849e.1462863934.git.johannes.schindelin@gmx.de>
 <db56fae5-799a-29af-3a0f-a7b5c671063a@web.de>
 <20160511173130.GA29731@sigill.intra.peff.net>
 <5f285a5f-f66a-ed35-ecf9-0fece19ee5ca@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu May 12 05:16:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0h78-0000qu-At
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 05:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbcELDQc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2016 23:16:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:38330 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750954AbcELDQc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 23:16:32 -0400
Received: (qmail 22130 invoked by uid 102); 12 May 2016 03:16:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 May 2016 23:16:31 -0400
Received: (qmail 5640 invoked by uid 107); 12 May 2016 03:16:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 May 2016 23:16:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 May 2016 23:16:28 -0400
Content-Disposition: inline
In-Reply-To: <5f285a5f-f66a-ed35-ecf9-0fece19ee5ca@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294382>

On Wed, May 11, 2016 at 10:03:45PM +0200, Torsten B=C3=B6gershausen wro=
te:

> > If you are, can you confirm that it's actually hanging, and not jus=
t
> > slow? On my system, test 26 takes about a minute to run (which is w=
hy we
> > don't do it by default).
> Nearly sure. After 10 minutes, the test was still running.
>=20
> Yesterday another machine was running even longer.
>=20
> Any tips, how to debug, are welcome.

Try running with "-x" to see what the test is doing. It will probably b=
e
in:

   + git -C too-many-refs fetch -q --tags

after a while. Check "ps" to see if you have a fetch-pack sub-process
running. It should be writing "have" lines and reading lots of ACK
lines, which you can check via strace.

If it's blocked on read() or write(), then it's probably some kind of
I/O deadlock.

-Peff
