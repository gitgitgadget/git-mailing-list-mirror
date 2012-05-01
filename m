From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitweb-lib.sh: Set up PATH to use perl from /usr/bin
Date: Tue, 1 May 2012 12:34:20 -0400
Message-ID: <20120501163420.GB15614@sigill.intra.peff.net>
References: <201205011323.45190.tboegi@web.de>
 <4FA00E09.2090708@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	jnareb@gmail.com, git@vger.kernel.org
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue May 01 18:34:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPG21-0003JO-P1
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 18:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754029Ab2EAQeZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 12:34:25 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53435
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752492Ab2EAQeY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 12:34:24 -0400
Received: (qmail 6651 invoked by uid 107); 1 May 2012 16:34:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 May 2012 12:34:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 May 2012 12:34:20 -0400
Content-Disposition: inline
In-Reply-To: <4FA00E09.2090708@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196691>

On Tue, May 01, 2012 at 06:23:37PM +0200, Zbigniew J=C4=99drzejewski-Sz=
mek wrote:

> On 05/01/2012 01:23 PM, Torsten B=C3=B6gershausen wrote:
> > When there are different version of perl installed on the machine,
> > the $PATH may point out a different version of perl than /usr/bin.
> > One example is to have /opt/local/bin/perl before /usr/bin/perl.
> >=20
> > Sanitize the PATH by adding /usr/bin at the beginning
> Hm, I see that most scripts have #!/usr/bin/perl, and only two have
> #!env perl [1]. So in general we usally rely on using perl in /usr/bi=
n.

The Makefile substitutes $PERL_PATH on the #!-line of each perl script
during its "build" step (which is really just copying the file to its
final name and running "chmod +x").

So even though the source files say /usr/bin/perl, we are not relying o=
n
that. If you look at the Makefile rule carefully, you will see that eve=
n
"#!/usr/bin/env perl" gets replaced, too. Those scripts should probably
be updated, since the mention of env is simply confusing.

> But your patch affects other stuff than perl, and unconditionally
> changing PATH set by the user is not nice, as it affect programs call=
ed
> recursively. Wouldn't simply replacing all calls to bare perl in
> t/gitweb-lib.sh with invocations of /usr/bin/perl be better?

Yes, although they should use $PERL_PATH rather than hardcoding
/usr/bin.

-Peff
