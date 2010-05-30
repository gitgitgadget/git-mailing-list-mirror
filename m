From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 0/5] Add internationalization support to Git
Date: Sun, 30 May 2010 17:23:48 -0500
Message-ID: <20100530222347.GB477@progeny.tock>
References: <1275173125-21010-1-git-send-email-avarab@gmail.com>
 <20100530014607.GA27387@progeny.tock>
 <AANLkTimI5xGiq_GNF_H2bOLECw0NxOiCPsnRqOS39H32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff Epler <jepler@unpythonic.net>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 31 00:23:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIquZ-0006zc-M2
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 00:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973Ab0E3WXJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 May 2010 18:23:09 -0400
Received: from mail-yw0-f179.google.com ([209.85.211.179]:49477 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330Ab0E3WXI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 18:23:08 -0400
Received: by ywh9 with SMTP id 9so2077156ywh.17
        for <git@vger.kernel.org>; Sun, 30 May 2010 15:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=B1Iu+9fFlUFodKuak/lPtj0SYGnyT9+/ZZ8FNz0B9H8=;
        b=iRPqIv1U/Z+IYGMSn8RBAg6Igett8H/ldUTptlh7ARyWog6LlGMtiMcgZA0mMO+z1D
         nxcbQD4sM24MBKfeQyQodYud35m6WRiSHBM2zevzj+W1IEzXxDnbXL3xu7BnURRCJ60q
         ueK3tMcuc3UODGCcX0OZs+F8KNhn3EhImCZyo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Vs1rOw48FVUtzZIEMHe3iCd9WZI1sA3PNgxV5vJL/TEWyG3vNDlghoCTYzbABN7wMa
         6gjx4oO8QW6h1w7JxC0ObcNtjBKJ3vePC9X1FW4gQ0YRbd2M4bAltWSms7PF1e14z4wv
         SyqXH1xzAdOSE8/zVbK4jl0oxDfAGdLmqOLHE=
Received: by 10.231.176.16 with SMTP id bc16mr4666913ibb.4.1275258185815;
        Sun, 30 May 2010 15:23:05 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id d9sm23049079ibl.22.2010.05.30.15.23.04
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 30 May 2010 15:23:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimI5xGiq_GNF_H2bOLECw0NxOiCPsnRqOS39H32@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148026>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> And even though gettext tries to make cases like these fast
> (http://www.gnu.org/software/hello/manual/gettext/Optimized-gettext.h=
tml)
> it's still a lot slower than hardcoded English:
>=20
>     perl -MBenchmark=3D:all -MData::Dump=3Ddump -E 'cmpthese(10, {
>          outside =3D> sub { system "./test-outside-loop >/dev/null" }=
,
>          inside =3D>  sub { system "./test-in-loop >/dev/null" },
>     });'
>=20
>             s/iter  inside outside
>     inside    13.4      --    -83%
>     outside   2.26    495%      --

Given:

-- 8< --
#include <stdio.h>
#include <stdlib.h>
#include <locale.h>
#include <libintl.h>
#include "gettext.h"

int foo(long int x) {
	return x * x;
}

int main(void) {
	const char *podir =3D "/usr/local/share/locale";
	long int i;

	bindtextdomain("git", podir);
	setlocale(LC_MESSAGES, "");
	setlocale(LC_CTYPE, "");
	textdomain("git");

	for (i =3D 0; i < 1000000; i++)
		printf(_("Some interesting label: %ld\n"), foo(i));

	return 0;
}
-- >8 --

No message catalog is installed here, and I compile with gcc-4.5 -Wall =
-W -O2.
The results are similar.

A: the standard way.  gettext.h contains "#define _(s) gettext(s)" or
| static inline char *_(const char *s) __attribute__((__format_arg(1)__=
))
| {
|	return gettext(s);
| }

 6.74user 0.02system 0:06.78elapsed 99%CPU (0avgtext+0avgdata 2304maxre=
sident)k
 0inputs+0outputs (0major+182minor)pagefaults 0swaps

 (about 7 seconds.)

B: noop.  gettext.h contains "#define _(s) s"

 1.35user 0.01system 0:01.37elapsed 99%CPU (0avgtext+0avgdata 2192maxre=
sident)k
 0inputs+0outputs (0major+172minor)pagefaults 0swaps

 (about 1.5 seconds.)

It would seem that __attribute__((__pure__)) should let the compiler gi=
ve
us the best of both worlds, but no luck.  Even __attribute__((__const__=
))
is ignored; the compiler inlines the body of _() before it has a chance
to notice.

We can fool the compiler into paying attention by making it not
inlinable: if gettext.h contains

| extern char *_(const char *s) __attribute__((__format_arg__(1), __con=
st__));

and a separate gettext.c contains

| #include <libintl.h>
| #include "gettext.h"
| char *_(const char *s) { return gettext(s); }

we get the performance of B again:

 1.36user 0.01system 0:01.38elapsed 98%CPU (0avgtext+0avgdata 2304maxre=
sident)k
 0inputs+0outputs (0major+180minor)pagefaults 0swaps

This amounts to lying to the compiler, since it is possible for the str=
ing
pointed to by a single address s to differ between calls to _.  The __p=
ure__
attribute would be more honest, but for reasons I don=E2=80=99t underst=
and it
suppresses the optimization.

Moral of the story: at least in simple cases, we can keep the performan=
ce
and the typechecking.  Phew.

HTH,
Jonathan
