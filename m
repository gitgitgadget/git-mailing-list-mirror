From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH v7 1/4] make poll available for other platforms lacking it
Date: Tue, 18 Sep 2012 08:28:52 +0200
Message-ID: <000101cd9566$df8b8d00$9ea2a700$@schmitz-digital.de>
References: <004b01cd9519$ba991cd0$2fcb5670$@schmitz-digital.de> <7vmx0oqner.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 08:29:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDrJP-0001oZ-0Z
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 08:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756564Ab2IRG3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 02:29:09 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:63420 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160Ab2IRG3I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 02:29:08 -0400
Received: from DualCore (dsdf-4d0a151d.pool.mediaWays.net [77.10.21.29])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0LbCQQ-1TuO7P3lfO-00kwIW; Tue, 18 Sep 2012 08:29:06 +0200
In-Reply-To: <7vmx0oqner.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQE7S4bKL3XYacfchY9p2RUlHA0wYQMPaYwWmJu5qyA=
Content-Language: de
X-Provags-ID: V02:K0:D+bRSJx2EEzqUoD+HnsJhZxVYTEoIXRsI9BSmP1ONUY
 b8N+KCvNhnk+bsWmex91iLLt+aJ4qVpUhWtSNq3i0tyFd/q88w
 TVVw9ytEIGEMmhCrVIzLhmR5SK3PoP0wYy0EuU2JpUqMR5Jsnu
 uyQ9kUORQ6taGlX7pomOVEUQULM31WEFuZvSOZ2nzbbHgQjFpH
 +2AHwQLoRcnXO6PCDkCv0/BCHAGChBY63WCea0TrE7ouaBjgpR
 h+00ORYpD9AivCc8TgO4GF+/+Ybec00aRpEW8QlcjcHtJ9+EZb
 pV3luHIkkhEYC1/yxwl3lTUuABFzZHjfbKzJBuGqswxlZUoxtx
 z0IgwS/QTrDsGy/VAu6T3qPm1zO2/3fYMc9e4BaClhT8qmNoY3
 jYpLU4QBGZukw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205795>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Tuesday, September 18, 2012 12:42 AM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH v7 1/4] make poll available for other platforms lacking it
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> > move poll.[ch] out of compat/win32/ into compat/poll/ and adjust
> > Makefile with the changed paths. Adding comments to Makefile about
> > how/when to enable it and add logic for this
> >
> > Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
> > ---
> >  Makefile                      | 20 +++++++++++++++-----
> >  compat/{win32 => poll}/poll.c |  0
> >  compat/{win32 => poll}/poll.h |  0
> >  3 files changed, 15 insertions(+), 5 deletions(-)
> >  rename compat/{win32 => poll}/poll.c (100%)
> >  rename compat/{win32 => poll}/poll.h (100%)
> >
> > diff --git a/Makefile b/Makefile
> > index ac49320..7893297 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -152,6 +152,11 @@ all::
> >  #
> >  # Define NO_MMAP if you want to avoid mmap.
> >  #
> > +# Define NO_SYS_POLL_H if you don't have sys/poll.h.
> > +#
> > +# Define NO_POLL if you do not have or don't want to use poll().
> > +# This also implies NO_SYS_POLL_H.
> 
> Sensible.
> 
> > @@ -1220,7 +1225,7 @@ ifeq ($(uname_S),Windows)
> >  	NO_PREAD = YesPlease
> >  	NEEDS_CRYPTO_WITH_SSL = YesPlease
> >  	NO_LIBGEN_H = YesPlease
> > -	NO_SYS_POLL_H = YesPlease
> > +	NO_POLL_H = YesPlease
> 
> Should this be NO_POLL, not NO_POLL_H?
> 
> > -DSTRIP_EXTENSION=\".exe\"
> >  	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
> >  	EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib
> > @@ -1316,7 +1321,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
> >  	NO_PREAD = YesPlease
> >  	NEEDS_CRYPTO_WITH_SSL = YesPlease
> >  	NO_LIBGEN_H = YesPlease
> > -	NO_SYS_POLL_H = YesPlease
> > +	NO_POLL_H = YesPlease
> 
> Likewise.
> 
> > @@ -1605,6 +1610,11 @@ ifdef NO_GETTEXT
> >  	BASIC_CFLAGS += -DNO_GETTEXT
> >  	USE_GETTEXT_SCHEME ?= fallthrough
> >  endif
> > +ifdef NO_POLL
> > +	NO_SYS_POLL_H = YesPlease
> > +	COMPAT_CFLAGS += -DNO_POLL -Icompat/poll
> > +	COMPAT_OBJS += compat/poll/poll.o
> > +endif
> 
> I think my guesses above are correct, so will queue with the trivial
> and obvious fixup.

Well I was unde the impression that is <sys/poll.h> isn't available, there might be a <poll.h> and it that isn't available either we
use compat/.../poll.[ch]. But rethinking your changed does makes perfect sense.

OK, so I guess I'm ready for the 'final touch', my NonStop specific changes, will post them shortly...

Bye, Jojo
