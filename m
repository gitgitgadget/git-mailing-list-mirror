From: Gary Yang <garyyang6@yahoo.com>
Subject: Challenge of setting up git server (repository). Please help!
Date: Thu, 20 Nov 2008 13:39:12 -0800 (PST)
Message-ID: <829533.97868.qm@web37906.mail.mud.yahoo.com>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 20 22:40:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3HGI-0004GA-5C
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 22:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185AbYKTVjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 16:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752807AbYKTVjO
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 16:39:14 -0500
Received: from web37906.mail.mud.yahoo.com ([209.191.91.168]:47108 "HELO
	web37906.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751308AbYKTVjN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Nov 2008 16:39:13 -0500
Received: (qmail 97926 invoked by uid 60001); 20 Nov 2008 21:39:12 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Message-ID;
  b=kElELUaPcIH5CX0KQzHjQUg+ojdxhvD6XDbpQ3oVsVWh3wDerxSfZeXy7Ht8+CDI6deexprcjyPiTSA0aV3OPGGYiLxa3Z4hItpoG8NT+toO9e9qYQ0fTzc0/f9vL4RccnKoVIjswoIRjKLbQEku1qauzi3rTodYHpx0e2ZQWm0=;
X-YMail-OSG: g_SQPYoVM1n4oQrMiZ8EAbk43iYkm4njSyj9o.lk48T4ASWReKotNj9QAYjxG.TNmb7Mi6YhV41a_2qfblg_un781XqPudF13a6dLw2uWuO_mSFpbkNTrq3Yg1CMwBND.4gIORgk4U9M6JX._nvJzlVAfhvhw8NesctxPmEuVF9GbIX8HVMHXfru9sdz
Received: from [76.195.33.70] by web37906.mail.mud.yahoo.com via HTTP; Thu, 20 Nov 2008 13:39:12 PST
X-Mailer: YahooMailWebService/0.7.260.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101472>


I am working on setting up a git server so that people can clone, pull and push their code at git.mycompany.com/pub/git+project path. 
However, I am having challenges. For people who setup their git servers, please share your experneces with me and tell me what I did wrong.
I greatly appreciate it.

After I made configurations, I ran the command, git update-server-info at the public repository machine. But, I got the error.

git pull http://git.mycompany.com/pub/git/u-boot.git HEAD
fatal: http://git.mycompany.com/pub/git/u-boot.git/info/refs not found: did you run git update-server-info on the server?

The file /pub/git/u-boot.git/info/refs dose exist.

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




      
