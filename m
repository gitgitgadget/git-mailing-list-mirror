From: Jeff King <peff@peff.net>
Subject: Re: git log doesn't allow %x00 in custom format anymore?
Date: Thu, 7 Oct 2010 14:13:49 -0400
Message-ID: <20101007181349.GD18518@sigill.intra.peff.net>
References: <D9157D2F-31D5-44EF-8FB4-F0E62BBF8017@jetbrains.com>
 <20101007141015.GB8162@sigill.intra.peff.net>
 <5BA0D807-C5C0-4797-82CD-5D5087496D6F@jetbrains.com>
 <4CADE232.8030801@viscovery.net>
 <FF2FF369-0B1C-457E-A86E-8651BF0A82CB@jetbrains.com>
 <20101007172939.GA12130@sigill.intra.peff.net>
 <AANLkTimYVNNjhaqUHjoVOV-fQBhcENKn7cyj10qcZ+MW@mail.gmail.com>
 <vpqaamp3n6d.fsf@bauges.imag.fr>
 <20101007175358.GD12130@sigill.intra.peff.net>
 <AANLkTinu6fhd9DwfJpjiaxOUu_MrTym_RepR9f44=vrv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 20:13:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3uyP-0007GR-MG
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 20:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754342Ab0JGSNi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 14:13:38 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:56619 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754312Ab0JGSNi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 14:13:38 -0400
Received: (qmail 19732 invoked by uid 111); 7 Oct 2010 18:13:36 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (129.79.255.184)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 07 Oct 2010 18:13:36 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Oct 2010 14:13:49 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinu6fhd9DwfJpjiaxOUu_MrTym_RepR9f44=vrv@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158423>

On Thu, Oct 07, 2010 at 08:05:20PM +0200, Erik Faye-Lund wrote:

> >> I don't know which one would be most portable, but if fwrite is th=
e
> >> problem, then
> >>
> >> =C2=A0 printf("%*s%c", buf.buf, buf.len, info->hdr_termination);
> >>
> >> should do the trick.
> >
> > It does work, but you have to cast the buf.len size_t to an int.
> >
> I'm not sure how portable it is, though. This is what K&R has to say
> on the matter: "characters from the string are printed until a =C2=B4=
\0=C2=B4 is
> reached or until the number of characters indicated by the precision
> have been printed". To me it's not clear if that means that either
> cases can terminate the printing when the precision has been
> specified.

I take it back. It doesn't actually work (I thought I had done this jus=
t
recently, but clearly not). Try:

  #include <stdio.h>
  int main()
  {
    char buf[] =3D "123456789";
    buf[2] =3D '\0';
    printf("%.*s\n", 5, buf);
    return 0;
  }

It prints just "12" for me.

-Peff
