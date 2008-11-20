From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: Challenge of setting up git server (repository). Please help!
Date: Thu, 20 Nov 2008 15:59:50 -0800
Message-ID: <1227225590.2709.10.camel@localhost.localdomain>
References: <636576.92732.qm@web37905.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Deskin Miller <deskinm@umich.edu>, git@vger.kernel.org
To: garyyang6@yahoo.com
X-From: git-owner@vger.kernel.org Fri Nov 21 01:01:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3JSQ-0002fK-E5
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 01:01:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072AbYKTX7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 18:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753896AbYKTX7z
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 18:59:55 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:47669 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867AbYKTX7y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 18:59:54 -0500
Received: from [172.19.0.93] (c-67-164-30-157.hsd1.ca.comcast.net [67.164.30.157])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id mAKNxnqG027554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 20 Nov 2008 15:59:50 -0800
In-Reply-To: <636576.92732.qm@web37905.mail.mud.yahoo.com>
X-Mailer: Evolution 2.12.3 (2.12.3-5.fc8) 
X-Virus-Scanned: ClamAV 0.88.7/8656/Thu Nov 20 14:12:54 2008 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.1.12 (shards.monkeyblade.net [198.137.202.13]); Thu, 20 Nov 2008 15:59:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101480>

Yes.

- John 'Warthog9' Hawley
Chief Kernel.org Administrator


On Thu, 2008-11-20 at 15:54 -0800, Gary Yang wrote:
> Do I need to restart  xinetd after I made changes in /etc/xinetd.d/git-daemon?
> 
> 
> --- On Thu, 11/20/08, Gary Yang <garyyang6@yahoo.com> wrote:
> 
> > From: Gary Yang <garyyang6@yahoo.com>
> > Subject: Re: Challenge of setting up git server (repository). Please help!
> > To: "Deskin Miller" <deskinm@umich.edu>
> > Cc: git@vger.kernel.org
> > Date: Thursday, November 20, 2008, 3:48 PM
> > I ran the command,"sudo
> > /usr/local/libexec/git-core/git-daemon git-daemon
> > --export-all /pub/git &" at public repository
> > machine.
> > 
> > At my private machine, I ran, git pull
> > git://svdcgit01.amcc.com/pub/git/u-boot.git HEAD"
> > 
> > I got: "fatal: The remote end hung up
> > unexpectedly"
> > 
> > At the public repository server, I got
> > "'/pub/git/u-boot.git': repository not
> > exported." Any idea of this error?
> > 
> > 
> > ps -A | grep inetd
> >  8874 ?        00:00:00 xinetd
> > 
> > It means it uses xinetd.
> > 
> > I copied git-daemon back to /etc/xinetd.d and added
> > git-daemon to the server_args. See below:
> > 
> > cat /etc/xinetd.d/git-daemon
> > # default: off
> > # description: The git server offers access to git
> > repositories
> > service git
> > {
> >         disable = no
> >         type            = UNLISTED
> >         port            = 9418
> >         socket_type     = stream
> >         wait            = no
> >         user            = nobody
> >         server          =
> > /usr/local/libexec/git-core/git-daemon
> >         server_args     = git-daemon --inetd --export-all
> > --base-path=/pub/git
> >         log_on_failure  += USERID
> > }
> > 
> > 
> > I kill the daemon
> > "/usr/local/libexec/git-core/git-daemon git-daemon
> > --export-all /pub/git &". 
> > 
> > Back to my private box, and did git pull. I got Connection
> > refused again. what I did wrong?
> > 
> > git pull git://svdcgit01.amcc.com/pub/git/u-boot.git HEAD
> > svdcgit01.amcc.com[0: 10.66.4.168]: errno=Connection
> > refused
> > fatal: unable to connect a socket (Connection refused)
> > 
> > 
> > 
> > 
> > --- On Thu, 11/20/08, Deskin Miller
> > <deskinm@umich.edu> wrote:
> > 
> > > From: Deskin Miller <deskinm@umich.edu>
> > > Subject: Re: Challenge of setting up git server
> > (repository). Please help!
> > > To: "Gary Yang" <garyyang6@yahoo.com>
> > > Cc: git@vger.kernel.org
> > > Date: Thursday, November 20, 2008, 3:08 PM
> > > On Thu, Nov 20, 2008 at 02:43:30PM -0800, Gary Yang
> > wrote:
> > > > Many thanks for your explanation. I hope I
> > understand
> > > what you said. I deleted /etc/xinetd.d/git-daemon.
> > Then, I
> > > tried to git pull. But, I got connection refused. git
> > uses
> > > port 9418. Should I request IT Admin to open the port
> > 9418
> > > for me?
> > > 
> > > You'll need port 9418 open, yes; but since
> > it's an
> > > unprivileged port (1024 or
> > > higher), you can use it as a regular user and
> > don't
> > > need IT intervention unless you have some firewall set
> > up
> > > which they need to override for you.
> > > 
> > > > git pull
> > git://git.mycompany.com/pub/git/u-boot.git
> > > HEAD
> > > > git.mycompany.com[0: 10.66.4.168]:
> > errno=Connection
> > > refused
> > > > fatal: unable to connect a socket (Connection
> > refused)
> > > 
> > > It's possible, and likely simpler, to use
> > git-daemon
> > > directly, instead of
> > > having it be managed by inetd; especially for initial
> > > debugging, I'd recommend
> > > getting that working before trying to determine if
> > > you're having issues with
> > > inetd configuration: to do so, just run git-daemon
> > with all
> > > the same arguments
> > > except for --inetd.
> > > 
> > > You said you deleted the xinetd config, but that's
> > only
> > > relevant if your
> > > machine actually uses inetd as its super-server.  You
> > > should do 'ps -A | grep
> > > inetd' (which will match either inetd or xinetd),
> > and
> > > see which one is running.
> > > If it's inetd, you should be all set, and the
> > issue
> > > doesn't look like inetd
> > > (assuming you sent it a signal to reload its config
> > file). 
> > > If on the other
> > > hand xinetd is running, you need to use the xinetd
> > config
> > > file, and fix the
> > > server_args to look like the arguments which exist in
> > the
> > > inetd file.  Again,
> > > you need to signal xinetd at this point to reload its
> > > configuration.
> > > 
> > > Based on the linux kernel version you're
> > reporting,
> > > I'm guessing you have some
> > > sort of Red Hat based system, which uses xinetd to the
> > best
> > > of my knowledge.
> > > 
> > > > Another question, I got no output of
> > "netstat |
> > > grep 9418". It means no program runs at port 9418
> > at
> > > the public repository machine. Is it correct?
> > > > 
> > > > netstat | grep 9418
> > > 
> > > netstat translates IP addresses to dns names, and
> > ports to
> > > service names by
> > > default; so, given the line listed in /etc/services,
> > this
> > > will show
> > > '0.0.0.0:git' or something.  Also, it lists
> > > established connections, not
> > > listening sockets, by default.  I'd recommend
> > spending
> > > some time with the man
> > > page if you're going to use it to debug your
> > setup.
> > > 
> > > Deskin Miller
> > 
> > 
> >       
> > --
> > To unsubscribe from this list: send the line
> > "unsubscribe git" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> > http://vger.kernel.org/majordomo-info.html
> 
> 
>       
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
