From: Jeff King <peff@peff.net>
Subject: Re: git-archive and tar options
Date: Thu, 14 Jul 2011 13:27:18 -0400
Message-ID: <20110714172718.GA21341@sigill.intra.peff.net>
References: <ivla29$liu$1@dough.gmane.org>
 <20110714015656.GA20136@sigill.intra.peff.net>
 <4E1F2468.6080409@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jul 14 19:27:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhPh8-0005BF-Se
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 19:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169Ab1GNR1W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jul 2011 13:27:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49513
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932134Ab1GNR1V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 13:27:21 -0400
Received: (qmail 8114 invoked by uid 107); 14 Jul 2011 17:27:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Jul 2011 13:27:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2011 13:27:18 -0400
Content-Disposition: inline
In-Reply-To: <4E1F2468.6080409@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177136>

On Thu, Jul 14, 2011 at 07:16:24PM +0200, Ren=C3=A9 Scharfe wrote:

> >> git archive --format=3Dtar -o my.tar --transform=20
> >> 's,^Web/Templates/,myPath/myWeb/Templates/,' HEAD WebPortal/Templa=
tes/
> >> error: unknown option `transform'
> >=20
> > Yeah, that won't work, because there is no such option. We do have
> > "--prefix", but I suspect that's not flexible enough for what you w=
ant.
>=20
> If you only need a single subdirectory with a custom prefix you could=
 do
> something like this (variables only used to keep the lines short):
>=20
> 	$ subdir=3DWebPortal/Templates
> 	$ prefix=3DmyPath/myWeb/Templates/
> 	$ (cd "$subdir" && git archive --prefix=3D"$prefix" HEAD) >my.tar
>=20
> The output file can be specified with -o as well, of course, but you'=
d
> either need to use an absolute path or add "../" for each directory
> level you descend into (-o ../../my.tar in this case).

Couldn't you also do:

  git archive --prefix=3D$prefix HEAD:$subdir >my.tar

? I guess that loses the pax header with the commit sha1 in it, though,
because you are feeding a straight tree instead of a commit.

We didn't when git-archive was written, but these days we have
get_sha1_with_context to remember incidental things about an object we
look up. It should perhaps remember the commit (if any) we used to reac=
h
a treeish, and then the above command line could still insert the pax
header.

-Peff
