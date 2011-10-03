From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] transport: do not allow to push over git:// protocol
Date: Mon, 3 Oct 2011 05:47:30 -0400
Message-ID: <20111003094730.GA21610@sigill.intra.peff.net>
References: <1317432415-9459-1-git-send-email-pclouds@gmail.com>
 <20111003074250.GB9455@sigill.intra.peff.net>
 <4E8975E7.2040804@viscovery.net>
 <20111003093912.GA16078@sigill.intra.peff.net>
 <CACsJy8B7Z-fT+ED=4F-Ug-bhvCagSxr0X6vZqn5PGRfB7KnUTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 11:47:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAf7Y-0005n3-ND
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 11:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754326Ab1JCJrd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 05:47:33 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51510
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753093Ab1JCJrc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 05:47:32 -0400
Received: (qmail 26616 invoked by uid 107); 3 Oct 2011 09:52:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 03 Oct 2011 05:52:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2011 05:47:30 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8B7Z-fT+ED=4F-Ug-bhvCagSxr0X6vZqn5PGRfB7KnUTA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182644>

On Mon, Oct 03, 2011 at 08:44:22PM +1100, Nguyen Thai Ngoc Duy wrote:

> > GitHub uses it to make nice messages:
> >
> > =C2=A0$ git push origin
> > =C2=A0fatal: remote error:
> > =C2=A0 =C2=A0You can't push to git://github.com/gitster/git.git
> > =C2=A0 =C2=A0Use git@github.com:gitster/git.git
> >
> > We should maybe do something like the patch below:
>=20
> Jonathan also mentions another patch
>=20
> http://article.gmane.org/gmane.comp.version-control.git/182536

Yeah, I was just reading that. Sorry, I should have read the rest of th=
e
thread more carefully. :)

> > =C2=A01. There is some information leakage there. In particular, on=
e can
> > =C2=A0 =C2=A0 tell the difference now between "repo does not exist"=
 and
> > =C2=A0 =C2=A0 "receive-pack is not turned on". Personally, I think =
the tradeoff
> > =C2=A0 =C2=A0 to have actual error messages is worth it. HTTP has h=
ad real error
> > =C2=A0 =C2=A0 codes for decades, and I don't think anybody is too u=
p-in-arms that
> > =C2=A0 =C2=A0 I can probe which pages are 404, and which are 401.
>=20
> To me, just "<service>: access denied" is enough. Not particularly
> friendly but should be a good enough clue.

Yeah, maybe. Certainly it's better than "the remote end hung up
unexpectedly".

However, the leakage is still there. You would get "the remote hung up"
for no-such-repo, and "access denied" for this. Or were you just
proposing that _all_ errors give "access denied". Certainly it's better
than just hanging up, too, and there is no leakage there.

It might be nice to default to that, and let sites easily enable
friendlier messages, though.

-Peff
