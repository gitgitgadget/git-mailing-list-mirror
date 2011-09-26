From: Jeff King <peff@peff.net>
Subject: Re: config-file includes
Date: Mon, 26 Sep 2011 16:05:53 -0400
Message-ID: <20110926200553.GA492@sigill.intra.peff.net>
References: <20110923195829.GA27677@sigill.intra.peff.net>
 <CACsJy8BAVRAct=sxTpZ+b-ft1OjbY9oZG6uEXrcsTXw3CXnwSg@mail.gmail.com>
 <20110926192126.GA55743@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 26 22:06:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8HRA-0004du-9h
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 22:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182Ab1IZUFz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 16:05:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44712
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752535Ab1IZUFz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 16:05:55 -0400
Received: (qmail 14689 invoked by uid 107); 26 Sep 2011 20:10:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Sep 2011 16:10:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Sep 2011 16:05:53 -0400
Content-Disposition: inline
In-Reply-To: <20110926192126.GA55743@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182159>

On Mon, Sep 26, 2011 at 09:21:27PM +0200, David Aguilar wrote:

> > > =C2=A0 =C2=A0[include-ifdef "has-pager-scripts"]
> > > =C2=A0 =C2=A0path =3D ~/.gitconfig-pager
> > >
> > > =C2=A0 =C2=A0where "has-pager-scripts" would be a magic flag comp=
iled into git
> > > =C2=A0 =C2=A0versions that understand that config.
> >=20
> > But how far would you go with conditional expressions?
>=20
> This syntax is simple yet would solve one problem I run into
> often.  It could be used for the case where some settings
> (e.g. diff.tool, merge.tool) are different on OS X and Linux.
>=20
> [include-ifdef "darwin"]
> 	path =3D ~/.gitconfig-darwin

Thanks for another concrete example.

I'm not sure how that would be implemented, though. I don't think git
knows that it is compiled for darwin. Would it just be running "uname
-s" behind the scenes? Should it happen at runtime, or as part of the
compile process?

We could allow arbitrary shell code like:

  [include-if "test `uname -s` -eq Darwin"]

Very flexible, though it makes me think we are getting a little
overboard.  And it's an extra shell invocation whenever we read the
config, which is ugly.

-Peff
