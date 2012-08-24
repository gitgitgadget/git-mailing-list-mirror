From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Support for HP NonStop
Date: Fri, 24 Aug 2012 13:12:52 -0700
Message-ID: <7v4nnsyrp7.fsf@alter.siamese.dyndns.org>
References: <005501cd822d$bf844bb0$3e8ce310$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Fri Aug 24 22:13:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T50Fa-0006g8-T6
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 22:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933214Ab2HXUM5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Aug 2012 16:12:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48808 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932890Ab2HXUMz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Aug 2012 16:12:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8693C85D9;
	Fri, 24 Aug 2012 16:12:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2JnZvC2cCNLn
	C29UlsGoNVL7+lY=; b=pdICTec9xwf/0O+7pv9zhgv/lDKfzHlPv242aofM+HEY
	pS4vh8MeZ/Wtmq74iWK5qMObqxrKBTEf+p31TC6v3tfwb1gMwHyXNa96fWZBAp5i
	dFlTUj987BNzAorJoio/mfrJV9Ku7PYStW5GwGthr6s08oh11/M28y2OqFlwkcA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=P9de9n
	6cPCjnffbUqjcC/Zlg3co84AljaHTLoYohpKPHdty3lYvKCyFurAOm2SFWCFxafs
	qJRWt2JgD/yTeFwHQffs2Mtu6fHg5ZlC4OUrC01ejzjFH8hU5/ujpzy9yE7SIeAm
	VrXIhVIN8H+pji9pBBUv32Ydf/hj6hjoOMjmo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7376485D8;
	Fri, 24 Aug 2012 16:12:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B4ACD85D7; Fri, 24 Aug 2012
 16:12:53 -0400 (EDT)
In-Reply-To: <005501cd822d$bf844bb0$3e8ce310$@schmitz-digital.de> (Joachim
 Schmitz's message of "Fri, 24 Aug 2012 21:22:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1643CAD2-EE28-11E1-B453-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204230>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

> Hi folks
>
> On top of the patches I=E2=80=99ve submitted so far, which were neede=
d for HP NonStop,=20
> but possibly useful for other platforms too, here is one that is at l=
east in parts NonStop specific
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index a047221..d6a142a 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -74,7 +74,8 @@
> # define _XOPEN_SOURCE 500
> # endif
> #elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__USLC=
__) && \
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !defined(_M_UNIX) && !defined(__sgi) =
&& !defined(__DragonFly__)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !defined(_M_UNIX) && !defined(__sgi) =
&& !defined(__DragonFly__) && \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !defined(__TANDEM)
> #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD ne=
eds 600 fo
> #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
> #endif
> +#ifdef __TANDEM /* or HAVE_STRINGS_H ? */
> +#include <strings.h> /* for strcasecmp() */
> +#endif
> #include <errno.h>
> #include <limits.h>
> #include <sys/param.h>

Yeah, it appears that glibc headers have strcasecmp() and friends in
the <string.h> and that was why majority of us were fine without
including <strings.h>.  A cursory look of /usr/include/strings.h on
a GNU system suggests that it is safe to include <strings.h> after
we incude <string.h> on that platform.

I think it is OK to leave it "__TANDEM /* or HAVE_STRINGS_H? */" for
now and let the next person who wants to port us to a platform that
needs this inclusion turn it to HAVE_STRINGS_H.  Alternatively, we
bite the bullet now and include <strings.h> on any platform that has
the header file and see if anybody complains (that reminds me; I at
least should get one flavor of BSD build environment for this kind
of thing myself).

> @@ -141,6 +145,10 @@
> #else
> #include <stdint.h>
> #endif
> +#ifdef __TANDEM /* or NO_INTPTR_T resp. NO_UINTPTR_T? */
> +typedef int intptr_t;
> +typedef unsigned int uintptr_t;
> +#endif

A bit wider context for this hunk is

	#ifndef NO_INTTYPES_H
        #include <inttypes.h>
        #else
        #include <stdint.h>
	#endif

So we have been assuming that <stdint.h> has intptr_t but __TANDEM
apparently doesn't.  POSIX requires intptr_t and uintptr_t to be
declared for systems conforming to XSI, but otherwise these are
optional (in other words, some XSI non-conforming platforms may have
them in <stdint.h>), so it would not help to check _XOPEN_UNIX to
see if the system is XSI X-<.  We would need NO_INTPTR_T as you
hinted above, perhaps like this.

	#ifndef NO_INTTYPES_H
        #include <inttypes.h>
        #else
        #include <stdint.h>
	#endif
	#ifdef NO_INTPTR_T
        typedef int intptr_t;
        typedef unsigned int uintptr_t;
	#endif

By the way, is "int" wide enough, or should they be "long"?
