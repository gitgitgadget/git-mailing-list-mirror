From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: t7006 sometimes hangs in cronjobs on OS X
Date: Wed, 9 Feb 2011 20:16:54 +0100
Message-ID: <201102092016.55078.trast@student.ethz.ch>
References: <201102091538.46594.trast@student.ethz.ch> <20110209190900.GA8314@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 09 20:17:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnFXC-0006vi-3A
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 20:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524Ab1BITQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 14:16:57 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:25397 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067Ab1BITQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 14:16:57 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.270.1; Wed, 9 Feb
 2011 20:16:55 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.270.1; Wed, 9 Feb
 2011 20:16:55 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <20110209190900.GA8314@sigill.intra.peff.net>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166436>

Jeff King wrote:
> On Wed, Feb 09, 2011 at 03:38:46PM +0100, Thomas Rast wrote:
> 
> > I have been running a nightly next&pu smoke tester each on RHEL5 and
> > OS X.  For quite some time (at least a month), t7006 gets stuck
> > randomly (i.e., not every night).

BTW, I just noticed when re-reading this that it's a bit confusing.
It never hangs on RHEL (i.e. Linux), only on OS X.  (And I only
reported it now because I only just noticed that I had a month's worth
of zombies hanging around. :-)

> >   65211   ??  SN     0:00.03 /bin/sh t7006-pager.sh
> >   65798   ??  SN     0:00.04 /usr/bin/perl /Users/trast/git-smoke/t/test-terminal.perl git --no-pager log
> >   65846   ??  ZN     0:00.00 (git)
> >   65847   ??  ZN     0:00.00 (perl5.10.0)
> 
> Hmm. The zombie git process implies to me that git has exited, but for
> some reason we are still stuck in the copy-to-terminal loop and haven't
> reaped it. But the zombie perl process confuses me.  We fork a second
> time so that one process copies stderr and the other one copies stdout.
> Is the second perl process the stderr copier, and we are still blocking
> on copying stdout for some reason?

How do I find out?

> But then why is the command name
> different? Is /usr/bin/perl a wrapper script on your platform?

No, it's your average OS X binary (i.e., 'file' says it has an image
for every platform etc.).

The command name apparently just changes when it becomes a zombie:
when I run perl -e 'if (fork) {sleep 10;} else {sleep 5;}' they first
share the command line, but as soon as the child's sleep expires its
command line changes to '(perl5.10.0)'.

I'll have to put off the more involved experimentation somewhat :-(

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
