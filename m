From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [RFC] Support for HP NonStop
Date: Fri, 24 Aug 2012 22:43:22 +0200
Message-ID: <005701cd8239$1a828300$4f878900$@schmitz-digital.de>
References: <005501cd822d$bf844bb0$3e8ce310$@schmitz-digital.de> <7v4nnsyrp7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 22:43:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T50jJ-0008RS-RY
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 22:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933372Ab2HXUnk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Aug 2012 16:43:40 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:53400 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933305Ab2HXUni convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Aug 2012 16:43:38 -0400
Received: from DualCore (dsdf-4db5d8d2.pool.mediaWays.net [77.181.216.210])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0M40YM-1Tv37G2pbG-00ra3V; Fri, 24 Aug 2012 22:43:33 +0200
In-Reply-To: <7v4nnsyrp7.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJdqfapyoHz4H9Ne772bOxBhhZ91QJGkyzrljbilfA=
Content-Language: de
X-Provags-ID: V02:K0:PhKE5XY+Z48zPi1NBffWojPTUFWqJwKCjfcgZf+0WM5
 0WK3wIe3ClXf/6Ci45QfUaqD+YJoKRM/NuXHslsUsF9AzVGpDF
 HbVmdRF/CPrEpjHyL8QTGoXd6Ss+xa69revndZbI83K3etVGsm
 ZV4f1iLHJCzmPVoiCP7zi7qg1UEVZ4+2AyywSBAR3XRqv/XF7v
 +6p3sSZjgjiPlvq+QonO8ErE77+iSaj8tws4pJgGFmDAjHMY8P
 3EhrFYAwic8fwRDoOoGWnBZsGjAlUZE1ruXcY7GbwzLAKWSBjw
 uG6g0T8nmsceVQ7KFzCbMrh+OOm9s9zutWaRLp93tMFXsRh3LM
 knyPJ9tdoR2q+JK+fEj7zjmqG2VsMqmRa9Cwf7DZma0ALCqWQl
 fpCeCkQK3lZ/w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204232>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Friday, August 24, 2012 10:13 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: [RFC] Support for HP NonStop
>=20
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
>=20
> > Hi folks
> >
> > On top of the patches I=E2=80=99ve submitted so far, which were nee=
ded for HP NonStop,
> > but possibly useful for other platforms too, here is one that is at=
 least in parts NonStop specific
> >
> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index a047221..d6a142a 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -74,7 +74,8 @@
> > # define _XOPEN_SOURCE 500
> > # endif
> > #elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__US=
LC__) && \
> > -      !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly=
__)
> > +      !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly=
__) && \
> > +      !defined(__TANDEM)
> > #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD =
needs 600 fo
> > #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
> > #endif
> > +#ifdef __TANDEM /* or HAVE_STRINGS_H ? */
> > +#include <strings.h> /* for strcasecmp() */
> > +#endif
> > #include <errno.h>
> > #include <limits.h>
> > #include <sys/param.h>
>=20
> Yeah, it appears that glibc headers have strcasecmp() and friends in
> the <string.h> and that was why majority of us were fine without
> including <strings.h>.  A cursory look of /usr/include/strings.h on
> a GNU system suggests that it is safe to include <strings.h> after
> we incude <string.h> on that platform.
>=20
> I think it is OK to leave it "__TANDEM /* or HAVE_STRINGS_H? */" for
> now and let the next person who wants to port us to a platform that
> needs this inclusion turn it to HAVE_STRINGS_H.  Alternatively, we
> bite the bullet now and include <strings.h> on any platform that has
> the header file and see if anybody complains

That's exaclty why I'm asking here ;-), seems a decision needs to be ma=
de.
How would one differentiate platrots that have strings.h from those tha=
t don't?
Guess it wont'f work without some ifdef. But it could be NO_STRINGS_H a=
nd=20
force the platforms that don't have to update this in Makefile?

Reminds me of a related issue: in compat/fnmatch/fnmatch.c there is thi=
s:
#if HAVE_STRING_H || defined _LIBC
# include <string.h>
#else
# include <strings.h>
#endif

There's no place where HAVE_STRING_H get set
This looks wrong to me, as here, at least for NonStop, I have to takes =
measure in Makefile,=20
because there's no other place where HAVE_STRING_H ever gets set:
       COMPAT_CFLAGS +=3D -DHAVE_STRING_H=3D1 # needed in compat/fnmatc=
h/fnmatch.c

Do platforms exist without string.h?
Maybe fnmatch.c should look like this instead?
#if HAVE_STRING_H || defined _LIBC
# include <string.h>
#endif
# ifndef NO_STRINGS_H
# include <strings.h>
#endif

> (that reminds me; I at
> least should get one flavor of BSD build environment for this kind
> of thing myself).
>=20
> > @@ -141,6 +145,10 @@
> > #else
> > #include <stdint.h>
> > #endif
> > +#ifdef __TANDEM /* or NO_INTPTR_T resp. NO_UINTPTR_T? */
> > +typedef int intptr_t;
> > +typedef unsigned int uintptr_t;
> > +#endif
>=20
> A bit wider context for this hunk is
>=20
> 	#ifndef NO_INTTYPES_H
>         #include <inttypes.h>
>         #else
>         #include <stdint.h>
> 	#endif
>=20
> So we have been assuming that <stdint.h> has intptr_t but __TANDEM
> apparently doesn't.=20

Exactly. Our stdint.h says:
/*
 *  Special integer types (optional types intptr_t/uintptr_t not define=
d)
 */

This may change in the future though. One reason why __TANDEM might not=
 be the best check :-)

> POSIX requires intptr_t and uintptr_t to be
> declared for systems conforming to XSI, but otherwise these are
> optional (in other words, some XSI non-conforming platforms may have
> them in <stdint.h>), so it would not help to check _XOPEN_UNIX to
> see if the system is XSI X-<.  We would need NO_INTPTR_T as you
> hinted above, perhaps like this.
>=20
> 	#ifndef NO_INTTYPES_H
>         #include <inttypes.h>
>         #else
>         #include <stdint.h>
> 	#endif
> 	#ifdef NO_INTPTR_T
>         typedef int intptr_t;
>         typedef unsigned int uintptr_t;
> 	#endif

NO_INTPTR_T for both types?
OK by me.
If need be an NOUINTPTR could get added later, I guess

> By the way, is "int" wide enough, or should they be "long"?

int and long have the same size, 32-bit, here on NonStop.
But we do have 64-bit types too. Not sure which to take though.

Bye, Jojo
