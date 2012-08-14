From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: Porting git to HP NonStop
Date: Tue, 14 Aug 2012 09:05:18 +0200
Message-ID: <000f01cd79eb$2a0b6e00$7e224a00$@schmitz-digital.de>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de> <CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 14 09:05:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1BBy-0005wC-Sv
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 09:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529Ab2HNHFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 03:05:24 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:56432 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218Ab2HNHFX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 03:05:23 -0400
Received: from DualCore (dsdf-4d0a02a3.pool.mediaWays.net [77.10.2.163])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0M7hzg-1Tw9UQ2wWu-00vPWr; Tue, 14 Aug 2012 09:05:22 +0200
In-Reply-To: 
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJtb+yK82c1fE/4VXt1krEuodTb9QKmN7Eflf4hv7CAADBEQIAFcByQ
Content-Language: de
X-Provags-ID: V02:K0:hLGedzv/11rA03hbDebJwtBsjQozNHHdwwh+2ueLiiy
 94WOBCntG8zqVYRFqzuQFJSUX7wMNyKNPpv2Hx1pyf4r9QRvsf
 sBdMyVMrwr+UXNsu6So8oO9kUgw//rn/QqmymrLa+2Wb4fLhts
 4FiQwEt3unUGRz9QS6xarS5bdvd/gnsZ1mVBC4lgbw2GBNgKST
 AGLKJxagnMurQ99X1hFxCgAWKOoUAVZi1XRkZ/L/0Kt6FGW0P9
 p1cPF6b9udgkKckydGjLvj3xvGeokHKBqmXrv5uAvHqMDKGG6X
 TBkwTPgtS1FV0ynWoAOpcX8UMhYqp0Aow6hZcMBQXT80xZNxBP
 ErQTFYrfZAK/c3w0Ed5RgvwPU0THgAU3tGj9vCMP0Z83CgfSZX
 Z52fXiImc2n8g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203386>

> From: Joachim Schmitz [mailto:jojo@schmitz-digital.de]
> Sent: Friday, August 10, 2012 10:09 PM
> To: 'Shawn Pearce'
> Cc: 'git@vger.kernel.org'; 'rsbecker@nexbridge.com'
> Subject: RE: Porting git to HP NonStop
> 
> > From: Joachim Schmitz [mailto:jojo@schmitz-digital.de]
> > Sent: Friday, August 10, 2012 7:33 PM
> > To: 'Shawn Pearce'
> > Cc: 'git@vger.kernel.org'; 'rsbecker@nexbridge.com'
> > Subject: RE: Porting git to HP NonStop
> >
> > > From: Shawn Pearce [mailto:spearce@spearce.org]
> > > Sent: Friday, August 10, 2012 6:28 PM
> > > To: Joachim Schmitz
> > > Cc: git@vger.kernel.org; rsbecker@nexbridge.com
> > > Subject: Re: Porting git to HP NonStop
> > >
> > > On Fri, Aug 10, 2012 at 8:04 AM, Joachim Schmitz
> > > <jojo@schmitz-digital.de>
> > > wrote:
> <snip>
> > > >> - HP NonStop doesn't have stat.st_?time.nsec, there are several
> > > >> places
> > > > what an
> > > >> "#ifdef USE_NSEC" is missing, I can provide a diff if needed
> > > >> (offending
> > > >> files: builtin/fetch-pack.c and read-cache.c).
> > >
> > > I think this would be appreciated by anyone else that has a similar
> > > problem where the platform lacks nsec.
> >
> > Will do.
> 
> OK, here we go:
> 
> /usr/local/bin/diff -EBbu ./builtin/fetch-pack.c.orig
./builtin/fetch-pack.c
<snip>

Sorry, this is not needed if I just set NO_NSEC, so just forget about it
(and thanks to Junio for telling be)

> /usr/local/bin/diff -EBbu ./git-compat-util.h.orig ./git-compat-util.h
> --- ./git-compat-util.h.orig    2012-07-30 15:50:38 -0500
> +++ ./git-compat-util.h 2012-08-10 09:59:56 -0500
> @@ -74,7 +74,8 @@
>  # define _XOPEN_SOURCE 500
>  # endif
>  #elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__USLC__)
> && \
> -      !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__)
> +      !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__) &&
\
> +      !defined(__TANDEM)
>  #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD
> needs 600 for S_ISLNK() */  #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L
> needs this */  #endif @@ -98,6 +99,11 @@  #include <stdlib.h>  #include
> <stdarg.h>  #include <string.h>
> +#ifdef __TANDEM
> +# include <strings.h> /* for strcasecmp() */
> +  typedef long int intptr_t;
> +  typedef unsigned long int uintptr_t;
> +#endif
>  #include <errno.h>
>  #include <limits.h>
>  #include <sys/param.h>

This one still stands though, unless someone can come up with a better idea?

Bye, Jojo
