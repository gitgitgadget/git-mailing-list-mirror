From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH] Support non-WIN32 system lacking poll() while keeping the WIN32 part intact
Date: Wed, 22 Aug 2012 21:59:03 +0200
Message-ID: <004301cd80a0$94fddc00$bef99400$@schmitz-digital.de>
References: <002101cd8078$eb2eb4f0$c18c1ed0$@schmitz-digital.de> <7vd32ialzo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "'Erik Faye-Lund'" <kusmabite@gmail.com>,
	"'Johannes Sixt'" <j6t@kdbg.org>,
	"'Marius Storm-Olsen'" <mstormo@gmail.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 21:59:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4H5E-0001qY-UH
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 21:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724Ab2HVT7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 15:59:15 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:61312 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170Ab2HVT7N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 15:59:13 -0400
Received: from DualCore (dsdf-4d0a052e.pool.mediaWays.net [77.10.5.46])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MOCMW-1SylJ40JaG-005WUk; Wed, 22 Aug 2012 21:59:10 +0200
In-Reply-To: 
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQD/eQtdRAcjQut3cNsfzSYRhS9vOQEpqCMymPjV2GCAACrf0A==
Content-Language: de
X-Provags-ID: V02:K0:gkIiKc7p7+ZNEITM1r36Nr8lIv0S4J6GrVx/2mVSw7B
 5HxSNQC3HRNAtqjSWF0EKbWcqybDnSUIVpo2sicxC4HnQ0e1EA
 dihK5umTyVF8Gv+2CfJ8QWwEl55l+haGONkXkn4JzpzU0QIux7
 u6xKVeLqJd6BXn43KV5BHYsDcQYfYm2jH3oj9MAd68WyDalGca
 hPF65WmaiqR7JVhrqpmRfmArEdgBkiVhyQJwcFJqmC8WVLaz1n
 PI+BVUoEeIh0Hq58I2kbtRd8uDfTLwsRdGxmorPQyU0MRaqkGQ
 C35y+Kco9amf+znWWK6AhIBnkBz6AQOa5rMEd/5LNqeBEmZA+y
 oMhnAw+NHYbIIBPL5O12L/+zuy9cLRiU8PfFai71rk4z3R7+x3
 K7iQ6B3xOwHng==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204088>

> From: Joachim Schmitz [mailto:jojo@schmitz-digital.de]
> Sent: Wednesday, August 22, 2012 7:44 PM
> To: 'Junio C Hamano'
> Cc: 'git@vger.kernel.org'; 'Erik Faye-Lund'; 'Johannes Sixt'; 'Marius
Storm-
> Olsen'
> Subject: RE: [PATCH] Support non-WIN32 system lacking poll() while keeping
> the WIN32 part intact
> 
> > From: Junio C Hamano [mailto:gitster@pobox.com]
> > Sent: Wednesday, August 22, 2012 7:13 PM
> > To: Joachim Schmitz
> > Cc: git@vger.kernel.org; Erik Faye-Lund; Johannes Sixt; Marius
> > Storm-Olsen
> > Subject: Re: [PATCH] Support non-WIN32 system lacking poll() while
> > keeping the WIN32 part intact
> >
> > "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> >
> > > Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
> > > ---
> > >  Makefile            | 18 ++++++++++++++----
> > >  compat/win32/poll.c |  8 ++++++--
> > >  2 files changed, 20 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/Makefile b/Makefile
...
> > > @@ -1601,6 +1606,11 @@ ifdef NO_GETTEXT ...
> > > +ifdef NO_POLL
> > > +       NO_SYS_POLL_H = YesPlease
> > > +       COMPAT_CFLAGS += -DNO_POLL -Icompat/win32 # so it find poll.h
> > > +       COMPAT_OBJS += compat/win32/poll.c

This is of course wrong! Needs to be poll.o, not poll.c

> > > endif
> >
> > In general, I think this is a good direction to go.  If the existing
> > emulation in win32/poll.c turns out to be usable across platforms and
> > not windows specific, sharing it would be a good idea.
> >
> > But if the emulation is no longer windows specific, shouldn't you also
> > move it outside compat/win32/ and somewhere more generic?
> 
> Should be possible. Esp. as with the current setup make issues a warning:
> 
> Makefile:2329: target `compat/win32/poll.c' doesn't match the target
pattern
> 
> Haven't yet been able to spot where that comes from.

See above.
 
