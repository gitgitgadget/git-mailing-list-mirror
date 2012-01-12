From: Jeff King <peff@peff.net>
Subject: Re: [BUG] multi-commit cherry-pick messes up the order of commits
Date: Thu, 12 Jan 2012 11:53:29 -0500
Message-ID: <20120112165329.GA17173@sigill.intra.peff.net>
References: <20120111173101.GQ30469@goldbirke>
 <CAP8UFD2uLoqzXRxssjwwW1Vk8RuNF_5OT1d7Z7hiRQ+Rq=UM1A@mail.gmail.com>
 <20120112144409.GV30469@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Jan 12 17:53:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlNuM-000388-Oc
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 17:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754385Ab2ALQxe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jan 2012 11:53:34 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36102
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754325Ab2ALQxd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 11:53:33 -0500
Received: (qmail 32572 invoked by uid 107); 12 Jan 2012 17:00:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Jan 2012 12:00:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jan 2012 11:53:29 -0500
Content-Disposition: inline
In-Reply-To: <20120112144409.GV30469@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188454>

On Thu, Jan 12, 2012 at 03:44:09PM +0100, SZEDER G=C3=A1bor wrote:

> > Thanks for the very detailed report!
> >=20
> > I didn't test nor even compiled anything but maybe this can be fixe=
d
> > by adding something like:
> >=20
> > opts->revs->topo_order =3D 1;
> >=20
> > in parse_args() or in prepare_revs()
> >=20
> > I will try to have a look tonight.
>=20
> [Beware, I'm mostly clueless about git internals.]
>=20
> I don't think that any commit reordering, whether it's based on
> committer date, topology, or whatever, is acceptable.  Commits must b=
e
> picked in the exact order they are specified on the command line.

I thought the multi-commit cherry-pick was supposed to take arbitrary
revision arguments, so you can do:

  git cherry-pick master..topic

and likewise you can spell it:

  git cherry-pick topic ^master

or:

  git cherry-pick ^master topic

So the order of arguments isn't relevant in those cases; the graph
ordering is. I agree it would be nice to make:

  git cherry-pick commit1 commit3 commit2

work in the order specified, but how does that interact with existing
cases that provide more traditional revision arguments?

-Peff
