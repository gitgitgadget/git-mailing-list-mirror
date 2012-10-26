From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fixes handling of --reference argument.
Date: Thu, 25 Oct 2012 20:39:34 -0400
Message-ID: <20121026003934.GA20064@sigill.intra.peff.net>
References: <5088c5a4.L25tOcUVCSwBRpYF%szager@google.com>
 <20121025083625.GA8390@sigill.intra.peff.net>
 <20121025104519.GA3816@odin.tremily.us>
 <5089AFED.7060404@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "W. Trevor King" <wking@tremily.us>, szager@google.com,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Oct 26 02:39:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRXxt-0007mk-DS
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 02:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754190Ab2JZAjk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Oct 2012 20:39:40 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56648 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753591Ab2JZAjh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 20:39:37 -0400
Received: (qmail 17331 invoked by uid 107); 26 Oct 2012 00:40:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Oct 2012 20:40:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2012 20:39:34 -0400
Content-Disposition: inline
In-Reply-To: <5089AFED.7060404@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208428>

On Thu, Oct 25, 2012 at 11:32:29PM +0200, Jens Lehmann wrote:

> >>> @@ -270,7 +270,6 @@ cmd_add()
> >>>  			;;
> >>>  		--reference=3D*)
> >>>  			reference=3D"$1"
> >>> -			shift
> >>>  			;;
> >>
> >> Is that right? We'll unconditionally do a "shift" at the end of th=
e
> >> loop. If it were a two-part argument like "--reference foo", the e=
xtra
> >> shift would make sense, but for "--reference=3D*", no extra shift =
should
> >> be neccessary. Am I missing something?
> >=20
> > Both the patch and Jeff's analysis are right.  You only need an
> > in-case shift if you consume "$2", or you're on =E2=80=98--=E2=80=99=
 and you're
> > breaking before the end-of-case shift.
>=20
> Right you are. The shift there is wrong, as there is no extra argumen=
t
> to consume for "--reference=3D<repo>" (opposed to "--reference <repo>=
",
> also see cmd_update() where this is done right).

Oh, the problem is that I'm an idiot, and for some reason read it as
_adding_ the bogus shift, not removing it. Patch is clearly correct.

> So tested and Acked-By me, but me thinks the subject should read:
>=20
>    [PATCH] submodule add: Fix handling of the --reference=3D<repo> op=
tion
>=20
> and the commit message should begin with:
>=20
>    Doing a shift there is wrong because there is no extra argument
>    to consume when "--reference=3D<repo>" is used (note the '=3D' ins=
tead
>    of a space).

Yeah, I think it makes sense to explain why it is wrong in the commit
message (I'll blame that for my lack of common sense above :) ).

> Peff, is it ok for you to squash that in or do you want Stefan to res=
end?

I can squash it in. Thanks all.

-Peff
