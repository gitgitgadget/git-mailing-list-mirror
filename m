From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Fix "identifier redeclared" compilation error with SUN
	cc.
Date: Fri, 16 Nov 2007 13:55:27 +0100
Message-ID: <20071116125527.GB14473@atjola.homenet>
References: <7vy7d08her.fsf@gitster.siamese.dyndns.org> <1195089303-28085-1-git-send-email-B.Steinbrink@gmx.de> <7vd4ua3hww.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: raa.lkml@gmail.com, git@ostkamp.fastmail.fm, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 13:56:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It0jb-0007zt-EA
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 13:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757680AbXKPMzb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2007 07:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752105AbXKPMzb
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 07:55:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:46597 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756765AbXKPMza (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 07:55:30 -0500
Received: (qmail invoked by alias); 16 Nov 2007 12:55:28 -0000
Received: from i577B9BAC.versanet.de (EHLO localhost) [87.123.155.172]
  by mail.gmx.net (mp004) with SMTP; 16 Nov 2007 13:55:28 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/wx1Q5H0TwI036aLIsh8IqLWa5rCEwK3bxjhVvrE
	G4A2NNLA2cstha
Content-Disposition: inline
In-Reply-To: <7vd4ua3hww.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65221>

On 2007.11.15 20:58:55 -0800, Junio C Hamano wrote:
> How about doing it this way?
>=20
>   # ifndef FLEX_ARRAY
>   #   if defined(__GNUC__)
>   #     if (__GNUC__ < 3)
>   #       define FLEX_ARRAY 0
>   #     else
>   #       define FLEX_ARRAY /* empty */
>   #     endif
>   #   else
>         /* more cases we know we can use 0 or empty can come here */
>   #   endif
>   # endif
>=20
>   /* if still undefined, default to the safe, old fashioned way */
>   # ifndef FLEX_ARRAY
>   #   define FLEX_ARRAY 1
>   # endif

Yeah, looks a bit smarter.

> The basic idea is:
>=20
>  * The user (from Makefile command line, config.mak, or you
>    could add autoconf test) can pass -DFLEX_ARRAY=3D... to specify
>    exactly what should happen;

Eeeek! He said autoconf! Waaah! ... Ehrm, sorry where was I?

>  * Otherwise, if we happen to know for sure that we can use "0"
>    or "/* empty */" with the compiler, we define FLEX_ARRAY;
>    currently we know such things for gcc.
>=20
>  * For everybody else, we use safer default of "1".  IOW, if you
>    know your compiler does not grok "/* empty */" nor "0", you
>    do not have to do anything special but use the default case
>    as everybody else.

Yep, definitely better than my patch.

Bj=F6rn
