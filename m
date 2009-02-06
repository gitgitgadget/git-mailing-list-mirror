From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] valgrind: do not require valgrind 3.4.0 or newer
Date: Fri, 6 Feb 2009 01:40:02 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902060139490.10279@pacific.mpi-cbg.de>
References: <7vzlh0bp6f.fsf@gitster.siamese.dyndns.org> <349b2bb9b8f5a6762cccb7834d82125ee4382436.1233867737u.git.johannes.schindelin@gmx.de> <7vljska0ep.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 01:40:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVEm6-0001jD-Dv
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 01:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325AbZBFAj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 19:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753189AbZBFAj1
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 19:39:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:38930 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752121AbZBFAj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 19:39:27 -0500
Received: (qmail invoked by alias); 06 Feb 2009 00:39:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp048) with SMTP; 06 Feb 2009 01:39:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/m+0pqgDfmZySeotvb1Za6gA9VhGMh9USyf8vIYh
	yBH2A9UajxtVjs
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vljska0ep.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108639>

Hi,

On Thu, 5 Feb 2009, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Valgrind 3.4.0 is pretty new, and even if --track-origins is a nice
> > feature, it is not the end of the world if that is not available.  So
> > play nice and use that option only when only an older version of
> > valgrind is available.
> >
> > In the same spirit, refrain from the use of '...' in suppression
> > files, which is also a feature only valgrind 3.4 and newer understand.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Thanks.
> 
> > +TRACK_ORIGINS=
> > +
> > +VALGRIND_VERSION=$(valgrind --version)
> > +VALGRIND_MAJOR=$(expr "$VALGRIND_VERSION" : '[^0-9]*\([0-9]*\)')
> > +VALGRIND_MINOR=$(expr "$VALGRIND_VERSION" : '[^0-9]*[0-9]*\.\([0-9]*\)')
> > +test 3 -gt "$VALGRIND_MAJOR" ||
> > +test 3 -eq "$VALGRIND_MAJOR" -a 4 -gt "$VALGRIND_MINOR" ||
> > +TRACK_ORIGINS=--track-origins=yes
> 
> It took me a while to convince myself that
> 
> 	"3 > major || (3 == major && 4 > minor) || do-this"
> 
> is equivalent to
> 
> 	"if (3 < major || (3 == major && 4 <= minor)) { do-this }"
> 
> which would be:
> 
> 	if test 3 -lt "$VALGRIND_MAJOR" ||
>            test 3 -eq "$VALGRIND_MAJOR" -a 4 -le "$VALGRIND_MINOR"
>         then
> 		TRACK_ORIGINS=--track-origins=yes
> 	fi
>         
> or more commonly:
> 
> 	if test "$VALGRIND_MAJOR" -gt 3 ||
>            test "$VALGRIND_MAJOR" -eq 3 -a "$VALGRIND_MINOR" -ge 4
>         then
> 		TRACK_ORIGINS=--track-origins=yes
> 	fi

Okay.  Want me to resubmit?

Ciao,
Dscho
