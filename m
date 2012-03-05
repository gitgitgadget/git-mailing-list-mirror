From: Jeff King <peff@peff.net>
Subject: Re: Bug: pull --rebase with =?utf-8?B?w6kg?= =?utf-8?Q?in?= name
Date: Mon, 5 Mar 2012 08:29:13 -0500
Message-ID: <20120305132913.GA15004@sigill.intra.peff.net>
References: <FECFDD4D-6EC3-4DE1-8A08-B4477345C4AA@habr.de>
 <20120305102657.GB29061@sigill.intra.peff.net>
 <87399nqqog.fsf@thomas.inf.ethz.ch>
 <F5A485EA-7EAD-4D8B-87C4-7185F713318C@habr.de>
 <20120305115815.GA4550@sigill.intra.peff.net>
 <0E2B8DE3-1ABD-453F-BCAA-0D693ECA5987@habr.de>
 <87ipijkxlm.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Haber <rene@habr.de>, git@vger.kernel.org,
	Will Palmer <wmpalmer@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 05 14:29:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Xyb-0005uX-5K
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 14:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242Ab2CEN3Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Mar 2012 08:29:16 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37698
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932194Ab2CEN3P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 08:29:15 -0500
Received: (qmail 30246 invoked by uid 107); 5 Mar 2012 13:29:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 05 Mar 2012 08:29:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Mar 2012 08:29:13 -0500
Content-Disposition: inline
In-Reply-To: <87ipijkxlm.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192235>

On Mon, Mar 05, 2012 at 02:04:37PM +0100, Thomas Rast wrote:

> Ren=C3=A9 Haber <rene@habr.de> writes:
>=20
> > sh -c '                                  =20
> >    . /sw/lib/git-core/git-sh-setup
> >     get_author_ident_from_commit 16b94413cbce12531e8f94628685159844=
9d3913
> >  '
> > GIT_AUTHOR_NAME=3D'Ren'=C3=A9 Haber
> > GIT_AUTHOR_EMAIL=3D'rene@habr.de'
> > GIT_AUTHOR_DATE=3D'@1329212923 +0100'
> [...]
> That is, the garbage (if you try to read it as UTF-8) in the printf
> string was matched and replaced byte-by-byte with 'x'.  However,
> Will was getting the unreplaced results
>=20
>   0000000: f89d 849e 0a                             .....
>=20
> I'm not sure he has followed up on that problem; the only hope may be=
 to
> get a better 'sed'.

Long ago, 47c9739e replaced the shell quoting in git-am with "git
rev-parse --sq-quote" (instead of sed). Maybe we can do the same for
get_author_ident_from_commit (though it is a little trickier there, as
we are also parsing values directly out of --pretty=3Draw).

It would be nice if the --pretty format placeholders had a "shell-quote=
"
modifier, and we could just do:

  git show --format=3D'GIT_AUTHOR_NAME=3D%(an:shell)'

or something similar. for-each-ref knows about shell-quoting, but we
can't use it here, because we are looking at arbitrary commits, not jus=
t
ones pointed to by refs.

-Peff
