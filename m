From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] autoconf: Test FREAD_READS_DIRECTORIES
Date: Tue, 4 Mar 2008 16:01:44 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803041558020.22527@racer.site>
References: <200803041514.42783.michal.rokos@nextsoft.cz> <alpine.LSU.1.00.0803041458220.22527@racer.site> <200803041630.07585.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>
To: Michal Rokos <michal.rokos@nextsoft.cz>
X-From: git-owner@vger.kernel.org Tue Mar 04 17:03:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWZbk-00054Z-37
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 17:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756948AbYCDQCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 11:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754700AbYCDQCd
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 11:02:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:42894 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756843AbYCDQCd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 11:02:33 -0500
Received: (qmail invoked by alias); 04 Mar 2008 16:02:30 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp018) with SMTP; 04 Mar 2008 17:02:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+q6nMW7VOqPrBfR/e+lVswl9mcYBotHWvND7pVoJ
	A7rWYJdUIYpBo9
X-X-Sender: gene099@racer.site
In-Reply-To: <200803041630.07585.michal.rokos@nextsoft.cz>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76105>

Hi,

On Tue, 4 Mar 2008, Michal Rokos wrote:

> On Tuesday 04 March 2008 15:59:02 Johannes Schindelin wrote:
> > On Tue, 4 Mar 2008, Michal Rokos wrote:
> > > +AC_RUN_IFELSE(
> > > +	[AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT],
> > > +		[[char c;
> > > +		FILE *f = fopen(".", "r");
> > > +		if (! f) return 0;
> > > +		if (f && fread(&c, 1, 1, f) > 0) return 1]])],
> > > +	[ac_cv_fread_reads_directories=no],
> > > +	[ac_cv_fread_reads_directories=yes])
> >
> > I do not see the issue addressed that I saw on msysGit.
> 
> ahh, sorry I've included some old one. Now it's
> +AC_RUN_IFELSE(
> +	[AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT],
> +		[[char c;
> +		FILE *f = fopen(".", "r");
> +		return f && fread(&c, 1, 1, f)]])],
> +	[ac_cv_fread_reads_directories=no],
> +	[ac_cv_fread_reads_directories=yes])
> 
> I've tried to reproduce, but I failed to do so. When I put "return 0;" it 
> detect that "no"; when I return something else, "yes" is detected - as it 
> should.

I finally figured out what is going wrong.

But first let me say what a PITA it is to debug configure.  It is utterly, 
completely painful!  When you insert random "exit"s, like you usually do 
with scripts that are too garbled and complex and ugly to understand (the 
worst Perl code I ever saw was not as ugly), it does not exit _at all_!

Turns out that the compilation fails:

	...\ld.exe: cannot find -lsocket 1 exit status

Nice.

FWIW it tries to link with

	cc -o conftest.exe -g -O2   conftest.c  -liconv -lsocket >&5

Hth,
Dscho

