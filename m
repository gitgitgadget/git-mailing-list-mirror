From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Copy resolve_ref() return value for longer use
Date: Mon, 14 Nov 2011 06:24:40 -0500
Message-ID: <20111114112440.GD10847@sigill.intra.peff.net>
References: <7vobwgo3l5.fsf@alter.siamese.dyndns.org>
 <1321179735-21890-1-git-send-email-pclouds@gmail.com>
 <1321179735-21890-2-git-send-email-pclouds@gmail.com>
 <7vbosfoiuy.fsf@alter.siamese.dyndns.org>
 <CACsJy8BnqoPVJiM6mbq7p3gKtLh-KGUuTshcukGokC3istTxMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 12:24:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPuee-000192-U0
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 12:24:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754529Ab1KNLYo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Nov 2011 06:24:44 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41005
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754052Ab1KNLYn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 06:24:43 -0500
Received: (qmail 28222 invoked by uid 107); 14 Nov 2011 11:24:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Nov 2011 06:24:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Nov 2011 06:24:40 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8BnqoPVJiM6mbq7p3gKtLh-KGUuTshcukGokC3istTxMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185378>

On Mon, Nov 14, 2011 at 10:32:11AM +0700, Nguyen Thai Ngoc Duy wrote:

> 2011/11/14 Junio C Hamano <gitster@pobox.com>:
> >> diff --git a/builtin/branch.c b/builtin/branch.c
> >> index 0fe9c4d..5b6d839 100644
> >> --- a/builtin/branch.c
> >> +++ b/builtin/branch.c
> >> @@ -115,8 +115,10 @@ static int branch_merged(int kind, const char=
 *name,
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bra=
nch->merge[0] &&
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bra=
nch->merge[0]->dst &&
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (re=
ference_name =3D
> >> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0re=
solve_ref(branch->merge[0]->dst, sha1, 1, NULL)) !=3D NULL)
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0re=
solve_ref(branch->merge[0]->dst, sha1, 1, NULL)) !=3D NULL) {
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 reference_name =3D xstrdup(reference_name);
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 reference_rev =3D lookup_commit_reference(sha1);
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> >> =C2=A0 =C2=A0 =C2=A0 }
> >> =C2=A0 =C2=A0 =C2=A0 if (!reference_rev)
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reference_rev =3D=
 head_rev;
> >> @@ -141,6 +143,7 @@ static int branch_merged(int kind, const char =
*name,
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 " =C2=A0 =C2=A0 =C2=A0 =C2=A0 '%=
s', even though it is merged to HEAD."),
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name, reference_name);
> >> =C2=A0 =C2=A0 =C2=A0 }
> >> + =C2=A0 =C2=A0 free((char*)reference_name);
> >> =C2=A0 =C2=A0 =C2=A0 return merged;
> >> =C2=A0}
> >
> > Now reference_name stores the result of xstrdup(), it does not have=
 reason
> > to be of type "const char *". It is preferable to lose the cast her=
e, I
> > think. The same comment applies to the remainder of the patch.
>=20
> But resolve_ref() returns "const char *", we need to type cast at
> least once, either at resolve_ref() assignment or at free(), until we
> change resolve_ref(). Or should we change resolve_ref() to return
> "char *" now?

Your problem is that you are using the same variable for two different
things: storing the pointer to non-owned memory returned from
resolve_ref, and then storing the owned memory that comes from xstrdup.
Those two things have different types, since we use "const" on non-owne=
d
memory. Thus you end up casting.

So your code isn't wrong, but I do think it would be more obviously
correct to a reader if it used two variables and dropped the cast.

-Peff
