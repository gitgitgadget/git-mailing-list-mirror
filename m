From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Remove noreturn function pointers in usage.c
Date: Thu, 9 Jun 2011 01:52:24 -0400
Message-ID: <20110609055224.GA27780@sigill.intra.peff.net>
References: <1307569417-8924-1-git-send-email-andi@firstfloor.org>
 <7v4o3z264s.fsf@alter.siamese.dyndns.org>
 <20110609045915.GA15448@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Thu Jun 09 07:52:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUYAU-0004Gc-8v
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 07:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341Ab1FIFw3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 01:52:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:32939
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315Ab1FIFw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 01:52:28 -0400
Received: (qmail 7742 invoked by uid 107); 9 Jun 2011 05:52:35 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jun 2011 01:52:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2011 01:52:24 -0400
Content-Disposition: inline
In-Reply-To: <20110609045915.GA15448@one.firstfloor.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175490>

On Thu, Jun 09, 2011 at 06:59:15AM +0200, Andi Kleen wrote:

> >  - Potential impact to people who do not use Gcc 4.6 with profile f=
eedback
> >    is not explained away well, except for "Doesn't seem to make any
> >    difference."
>=20
> I merely went by "there are no new warnings" (I assume that's the mai=
n
> motivation)

On your compiler and settings, perhaps. With your patch I get:

  usage.c: In function =E2=80=98die=E2=80=99:
  usage.c:70:1: error: =E2=80=98noreturn=E2=80=99 function does return =
[-Werror]

And rightfully so:

void NORETURN die(const char *err, ...)
{
        va_list params;

        va_start(params, err);
        die_routine(err, params);
        va_end(params);
}

You've stripped the NORETURN from die_routine, so of course it looks li=
ke we
end up returning.

This is with:

  $ gcc --version | head -n 1
  gcc (Debian 4.6.0-11) 4.6.1 20110604 (prerelease)

-Peff
