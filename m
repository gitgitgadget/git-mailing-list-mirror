From: Jeff King <peff@peff.net>
Subject: Re: Clone fails on a repo with too many heads/tags
Date: Sun, 18 Mar 2012 22:32:31 -0400
Message-ID: <20120319023231.GA10426@sigill.intra.peff.net>
References: <loom.20120318T083216-96@post.gmane.org>
 <m3fwd550j3.fsf@localhost.localdomain>
 <20120318190659.GA24829@sigill.intra.peff.net>
 <201203182307.43599.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ivan Todoroski <grnch_lists@gmx.net>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 03:33:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9SP4-0008TD-Vn
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 03:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757537Ab2CSCce convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Mar 2012 22:32:34 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51935
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753507Ab2CSCce (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 22:32:34 -0400
Received: (qmail 26458 invoked by uid 107); 19 Mar 2012 02:32:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 18 Mar 2012 22:32:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Mar 2012 22:32:31 -0400
Content-Disposition: inline
In-Reply-To: <201203182307.43599.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193410>

On Sun, Mar 18, 2012 at 11:07:42PM +0100, Jakub Narebski wrote:

> > I think the only sane solution is to write the values to a temporar=
y
> > file, and do something like:
> >=20
> > =C2=A0 git fetch-pack --stateless-rpc --refs-from=3D$tmpfile
> >=20
> > Even if you put the tmpfile in $GIT_DIR, I don't think this should =
run
> > afoul of any read-only repositories, since by definition you are
> > fetching into the repository (but you could also just put it in /tm=
p).
>=20
>    git fetch-pack --stateless-rpc --refs-fd=3D$n
>=20
> and there would be no need for temporary file.

Yeah. That is a slightly more awkward interface for command-line users,
but this is really meant to be an internal-to-git thing (just like
stateless-rpc is in the first place). And avoiding a tempfile is a good
thing.

However, I think you would need to teach the run-command API how to ope=
n
extra pipes to a child beyond stdout/stdin/stderr.

-Peff
