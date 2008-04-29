From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-daemon: fix for rotating logs
Date: Tue, 29 Apr 2008 16:16:03 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804291615000.27457@eeepc-johanness>
References: <alpine.DEB.1.00.0804281523040.5399@eeepc-johanness> <7vtzhmaqpd.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804281908290.19187@eeepc-johanness> <20080428182114.GF26880@genesis.frugalware.org> <20080428182917.GA4794@glandium.org>
 <4816BD77.1060709@op5.se> <alpine.DEB.1.00.0804291153230.27457@eeepc-johanness> <4816FFEB.8050308@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Apr 29 17:17:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqrZV-00034o-Us
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 17:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbYD2PPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 11:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbYD2PPy
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 11:15:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:35297 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932401AbYD2PPv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 11:15:51 -0400
Received: (qmail invoked by alias); 29 Apr 2008 15:15:49 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp036) with SMTP; 29 Apr 2008 17:15:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Puu5KiH/PTsnIrg4Okaa+bsTTpVgkcoBFgpKYCK
	7JN7zdgQUcFwwZ
X-X-Sender: user@eeepc-johanness
In-Reply-To: <4816FFEB.8050308@op5.se>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80689>

Hi,

On Tue, 29 Apr 2008, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
> 
> > On Tue, 29 Apr 2008, Andreas Ericsson wrote:
> > 
> > > Mike Hommey wrote:
> > > > On Mon, Apr 28, 2008 at 08:21:14PM +0200, Miklos Vajna wrote:
> > > > > On Mon, Apr 28, 2008 at 07:08:50PM +0100, Johannes Schindelin 
> > > > > <Johannes.Schindelin@gmx.de> wrote:
> > > > > > > > With rotating logs, there is a problem when the syslog is 
> > > > > > > > opened only once (in the beginning).  So open the log 
> > > > > > > > everytime we write something, and close it directly after 
> > > > > > > > writing.
> > > > > > > Gaah, this is ugly.
> > > > > > >
> > > > > > > Is this something all the daemons need to deal with?
> > > > > > I have no idea, but it seems to fix a real issue.
> > > > > logrotate supports sending a signal (typically SIGHUP) to the 
> > > > > process after it rotated the log. Couldn't we just re-open the 
> > > > > log on SIGHUP?
> > > > Isn't the problem that git-daemon loses its connection to the 
> > > > syslog daemon when logrotate sighups syslog?
> > > >
> > > It really shouldn't. The connection to the syslog daemon is just a 
> > > unix socket (/dev/log) which is used to send whatever passes for UDP 
> > > packets on unix domain sockets. Since the socket isn't re-created by 
> > > syslogd (well, a sane syslogd anyways), but rather just open()'ed 
> > > for reading, no program should ever need to reconnect.
> > 
> > What can I say?  The problem just went away with my workaround.  Is it 
> > possible that I have to catch SIGHUP, and closelog() && openlog()?  
> > But why do other daemons seem to not have that problem at all?
> > 
> 
> Other daemons don't get SIGHUP'ed when logs are rotated. I think 
> something else is going on there.
> 
> What syslogd are you using? Perhaps it insists on re-creating the 
> socket. That might cause the behaviour you're seeing, but then you 
> should probably see it in a ton of other daemons as well.

This is sysklogd from Ubuntu, compiled for amd64.  The timestamp on 
/dev/log is older than a month.

Thanks,
Dscho
