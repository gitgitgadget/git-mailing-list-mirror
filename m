From: Mike Galbraith <efault@gmx.de>
Subject: Re: Challenge of setting up git server (repository). Please help!
Date: Fri, 21 Nov 2008 08:22:24 +0100
Message-ID: <1227252144.4879.90.camel@marge.simson.net>
References: <546971.60895.qm@web37907.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog19@eaglescrag.net>,
	Deskin Miller <deskinm@umich.edu>, git@vger.kernel.org
To: garyyang6@yahoo.com
X-From: git-owner@vger.kernel.org Fri Nov 21 08:23:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3QMj-0006B8-8K
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 08:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbYKUHW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 02:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbYKUHW3
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 02:22:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:43944 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751178AbYKUHW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 02:22:29 -0500
Received: (qmail invoked by alias); 21 Nov 2008 07:22:26 -0000
Received: from p54B5A124.dip0.t-ipconnect.de (EHLO [192.168.178.27]) [84.181.161.36]
  by mail.gmx.net (mp054) with SMTP; 21 Nov 2008 08:22:26 +0100
X-Authenticated: #14349625
X-Provags-ID: V01U2FsdGVkX1/PDogMufLPQnxcBhQ9ylIW7Crg3i4ffcEfXIGa/h
	Y4cSnQO2TQAS3p
In-Reply-To: <546971.60895.qm@web37907.mail.mud.yahoo.com>
X-Mailer: Evolution 2.22.1.1 
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101497>

On Thu, 2008-11-20 at 16:39 -0800, Gary Yang wrote:
> I killed xinetd. Restarted with sudo xinetd -stayalive -pidfile /var/run/xinetd.pid. 
> 
> I back to my private box. I did 
> 
> git pull git://git.mycompany.com/pub/git/u-boot.git HEAD
> 
> This command hangs for over half hour and is still hanging. Again, below is the content of /etc/xinetd.d/git-daemon. What I did wrong?
> 
> cat /etc/xinetd.d/git-daemon
> # default: off
> # description: The git server offers access to git repositories
> service git
> {
>         disable = no
>         type            = UNLISTED
>         port            = 9418
>         socket_type     = stream
>         wait            = no
>         user            = nobody
>         server          = /usr/local/libexec/git-core/git-daemon
>         server_args     = git-daemon --inetd --export-all --base-path=/pub/git
>         log_on_failure  += USERID
> }

The way I set it up was to create a user 'git' who is my central
repository owner/manager.  All repositories live in ~git.

service git
{
        socket_type     = stream
        protocol        = tcp
        wait            = no
        user            = git
        group           = daemon
        server          = /usr/bin/git
        server_args     = daemon --inetd --export-all --user-path --reuseaddr --detach
        type            = UNLISTED
        port            = 9418
        log_on_failure  += USERID
}

marge:..kernel/linux-2.6.28 # git remote -v
master  git://localhost/~git/linux-2.6

>From host homer, with a hole poked in marge's firewall, works fine.

	-Mike
