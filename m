From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Ensure that SSH runs in non-interactive mode
Date: Sun, 20 Jul 2008 12:27:38 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807201214060.3305@eeepc-johanness>
References: <1216487215-6927-1-git-send-email-fredrik@dolda2000.com>  <1216490252.10694.58.camel@koto.keithp.com> <1216491512.3911.9.camel@pc7.dolda2000.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Keith Packard <keithp@keithp.com>, git@vger.kernel.org,
	"Edward Z. Yang" <edwardzyang@thewritingpot.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Fredrik Tolf <fredrik@dolda2000.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 12:27:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKW8w-00041m-VA
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 12:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755743AbYGTK0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 06:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755837AbYGTK0z
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 06:26:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:49015 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755688AbYGTK0y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 06:26:54 -0400
Received: (qmail invoked by alias); 20 Jul 2008 10:26:49 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp011) with SMTP; 20 Jul 2008 12:26:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19YxYEMnKJY6bhcmA4zhSfc/aWuYIJh9i5yO4uSLI
	evAcAnv+INe8/V
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1216491512.3911.9.camel@pc7.dolda2000.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89179>

Hi,

On Sat, 19 Jul 2008, Fredrik Tolf wrote:

> On Sat, 2008-07-19 at 10:57 -0700, Keith Packard wrote:
> > On Sat, 2008-07-19 at 19:06 +0200, Fredrik Tolf wrote:
> > >  By removing the DISPLAY env variable before forking, SSH
> > > can thus be forced into non-interactive mode, without any obvious
> > > ill effects.
> > 
> > This will keep ssh-askpass from using any X-based password input
> > program.
> 
> Ah, right. Would it be OK to add the `-x' flag to ssh instead?

I think this would be the correct way, together with "-T".

> I imagine that that might make git less portable to SSH implementations 
> other than OpenSSH, but I don't know if that is considered a problem.

Well, this was to be expected, after what I wrote in response to 3. in
http://thread.gmane.org/gmane.comp.version-control.git/76650/focus=2598

Reality always catches up with you, and here again we see that plink and 
other siblings of OpenSSH should be best handled with scripts, preferably 
ones that strip out options they do not recognize.

IOW something like

-- snip --
#!/bin/bash

plinkopt=
while test $# != 0
do
	case "$1" in
	-p)
		plinkopt="$plinkopt -P $2"
		shift
	;;
	-*)
		# unrecognized; strip out
	;;
	*)
		break
	;;
	esac
	shift
done

exec plink $plinkopt "$@"
-- snap --

Ciao,
Dscho
