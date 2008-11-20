From: Gary Yang <garyyang6@yahoo.com>
Subject: Re: fatal: did you run git update-server-info on the server? mv post-update.sample post-update
Date: Thu, 20 Nov 2008 13:25:19 -0800 (PST)
Message-ID: <694807.23593.qm@web37908.mail.mud.yahoo.com>
References: <alpine.DEB.1.00.0811201204300.30769@pacific.mpi-cbg.de>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 20 22:26:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3H2s-0007Ko-0L
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 22:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755467AbYKTVZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 16:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755468AbYKTVZV
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 16:25:21 -0500
Received: from web37908.mail.mud.yahoo.com ([209.191.91.170]:37379 "HELO
	web37908.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755185AbYKTVZU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Nov 2008 16:25:20 -0500
Received: (qmail 23740 invoked by uid 60001); 20 Nov 2008 21:25:19 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Message-ID;
  b=SLGKIXzrE5FTTudBS59yKVWQu6p3ikwQ8S+K9m+cy6YcTBqiXK54RrHe4my2MIMipJKmZ0LjkV4Fii8KPyznUZxsUa+PJPFSslIIxDDTpnbc+c+eFO3jU9Kc7zMCPH+rRRuEla0oOM10ATIp51LnOD6ppyiQVUGttX8BNhi4yBI=;
X-YMail-OSG: L87Yjn0VM1k0M9uTFtsWtG9swBBfPP9JOxtzM1rw3xiIkbJ3rC4OpLNFmWSm2rK.KvTFdWCfOZl5jTzpxGqo3fEC3wahEQO6jeg4OFlBoMtp3DLlK0dYtGHrQMsNMDjoarePEIWqO3mLl6QfsPFOyJNlT6SbuAA1ctqRl3kybALkHY2qRzTzuu8C_p.D
Received: from [76.195.33.70] by web37908.mail.mud.yahoo.com via HTTP; Thu, 20 Nov 2008 13:25:19 PST
X-Mailer: YahooMailWebService/0.7.260.1
In-Reply-To: <alpine.DEB.1.00.0811201204300.30769@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101471>


I ran the command, git update-server-info at the public repository machine. But, I still got the same error.

git pull http://git.mycompany.com/pub/git/u-boot.git HEAD
fatal: http://git.mycompany.com/pub/git/u-boot.git/info/refs not found: did you run git update-server-info on the server?

The file /pub/git/u-boot.git/info/refs do exist.

cat /pub/git/u-boot.git/info/refs
87ee4576c4c31b7046fe2bbbdf309eaba5c3f346        refs/heads/master

My question:

Is the contet of /pub/git/u-boot.git/hooks/post-update correct? Should I change "exec git-update-server-info" to "exec git update-server-info"?

cat /pub/git/u-boot.git/hooks/post-update
#!/bin/sh
#
# An example hook script to prepare a packed repository for use over
# dumb transports.
#
# To enable this hook, rename this file to "post-update".
exec git-update-server-info

I tried and changed "exec git-update-server-info" to "exec git update-server-info" in /pub/git/u-boot.git/hooks/post-update. But, I still got same error.
git pull http://git.mycompany.com/pub/git/u-boot.git HEAD
fatal: http://git.mycompany.com/pub/git/u-boot.git/info/refs not found: did you run git update-server-info on the server?

Which one is correct? "exec git-update-server-info" or "exec git update-server-info"? Eventhogh none of them working.

Below are my settings:

grep 9418 /etc/services
git             9418/tcp                        # Git Version Control System


grep git /etc/inetd.conf
git     stream  tcp     nowait  nobody  /usr/local/libexec/git-core/git-daemon git-daemon --inetd --export-all /pub/git


cat /etc/xinetd.d/git-daemon
# default: off
# description: The git server offers access to git repositories
service git
{
        disable = no
        type            = UNLISTED
        port            = 9418
        socket_type     = stream
        wait            = no
        user            = nobody
        server          = /usr/local/libexec/git-core/git-daemon
        server_args     = --inetd --export-all --base-path=/pub/git
        log_on_failure  += USERID
}


I am running git at Linux box:
uname -a
Linux svdclw004 2.6.9-67.ELsmp #1 SMP Wed Nov 7 13:56:44 EST 2007 x86_64 GNU/Linux

Are there anything wrong? Please let me know.







--- On Thu, 11/20/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Subject: Re: fatal: did you run git update-server-info on the server? mv post-update.sample post-update
> To: "Gary Yang" <garyyang6@yahoo.com>
> Cc: git@vger.kernel.org
> Date: Thursday, November 20, 2008, 3:05 AM
> Hi,
> 
> On Wed, 19 Nov 2008, Gary Yang wrote:
> 
> > I did not run post-update at public repository
> manually. Do I need to 
> > run it for the very first time?
> 
> You need to run it when you installed the hook _after_
> seeing the message 
> "did you run...".
> 
> Ciao,
> Dscho
> --
> To unsubscribe from this list: send the line
> "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html


      
