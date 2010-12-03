From: Jeff King <peff@peff.net>
Subject: Re: Q about git rev-parse {--is-inside-work-tree, --show-cdup}
Date: Fri, 3 Dec 2010 16:20:35 -0500
Message-ID: <20101203212035.GB2632@sigill.intra.peff.net>
References: <4CF95BDC.60506@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Fri Dec 03 22:20:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POd3f-0002hG-CT
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 22:20:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672Ab0LCVUj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Dec 2010 16:20:39 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:41412 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753581Ab0LCVUj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 16:20:39 -0500
Received: (qmail 26178 invoked by uid 111); 3 Dec 2010 21:20:36 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (129.79.255.205)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 03 Dec 2010 21:20:36 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Dec 2010 16:20:35 -0500
Content-Disposition: inline
In-Reply-To: <4CF95BDC.60506@dirk.my1.cc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162858>

On Fri, Dec 03, 2010 at 10:06:36PM +0100, Dirk S=C3=BCsserott wrote:

> I wrote some shell scripts that do sth with my git repositories. I pl=
ace
> my scripts in my ~/bin folder (not in the repo). So the first step in=
 my
> scripts is always to check whether they get called from whithin a git
> repo and bail out if they don't.
>=20
> I do this like so:
>=20
> ---------------------
> if [ "$(git rev-parse --is-inside-work-tree)" =3D "true" ] # (1)
> then
>      here=3D$(pwd)
>      cdup=3D$(git rev-parse --show-cdup);    # (2a)
>      cdup=3D${cdup:-"."}                     # (2b)
>      cd $cdup                              # (2c)
>=20
>      [do sth useful from the topdir]
>=20
>      cd $here
>      exit 0;
> else
>      echo "Not inside a git working tree."
>      exit 1;
> fi
> ---------------------

Since you are writing shell scripts, you may be interested in doing:

  . git-sh-setup
  require_work_tree
  cd_to_toplevel

> 1. Wouldn't it be useful, if "git rev-parse" (1) had an option "-q" t=
hat
> simply indicates whether "--is-inside-work-tree" is true by means of =
the
> return code? Actually it has an option "-q" but that doesn't work wit=
h
> "--is-inside-work-tree".

Yeah, in general rev-parse's "-q" is annoying. It only works with
checking revisions (like "git rev-parse -q --verify HEAD"), and it
probably should apply to a lot more. Patches welcome.

> 2. Wouldn't it be useful, if "git rev-parse --show-cdup" (2a) would
> return a dot "." instead of nothing if we are already in the topdir?
> That would make the steps (2a), (2b), (2c) to a simple "cd $(git
> rev-parse --show-cdup)".

I'm hesitant to change it, as that is a public interface for shell
scripts. However, there is also "--show-toplevel" which will do what yo=
u
want in one line (or just cd_to_toplevel as I mentioned above).

> What do you think? If appreciated, I'd like to work on a patch for (1=
).

Please do.

-Peff
