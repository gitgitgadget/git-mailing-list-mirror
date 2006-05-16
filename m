From: Sam Song <samlinuxkernel@yahoo.com>
Subject: Fwd: [OT] Re: Git via a proxy server?
Date: Tue, 16 May 2006 05:13:56 -0700 (PDT)
Message-ID: <20060516121356.11646.qmail@web32002.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 16 14:14:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfyRK-0003Od-1e
	for gcvg-git@gmane.org; Tue, 16 May 2006 14:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbWEPMOA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 08:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbWEPMOA
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 08:14:00 -0400
Received: from web32002.mail.mud.yahoo.com ([68.142.207.99]:20819 "HELO
	web32002.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751788AbWEPMN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 May 2006 08:13:57 -0400
Received: (qmail 11648 invoked by uid 60001); 16 May 2006 12:13:56 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=dBeUgFJxJsetb4If88RhO82AbmqJNIV8Mgihj0Rd6McFIHyBxpmBtx561lD27NqX8azoHykgR209/2tyWszjoC7of7aWGeUfRs0qWOq40kkj1BH/wQd1t/k25FIECTQnFpVAmWdloEjCx1k1BvKPZtvnDvti4LP7BxEuegoxBq0=  ;
Received: from [61.152.162.133] by web32002.mail.mud.yahoo.com via HTTP; Tue, 16 May 2006 05:13:56 PDT
To: Petr Vandrovec <petr@vmware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20119>

Hello,

Petr Vandrovec <petr@vmware.com> wrote:
> Date:	Mon, 27 Feb 2006 00:35:00 +0100
> From:	Petr Vandrovec <petr@vmware.com>
> To:	Sergey Vlasov <vsu@altlinux.ru>
> CC:	"Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
> 	Kernel Mailing List 
> <linux-kernel@vger.kernel.org>
> > [snip]
> > I have successfully used transconnect
> > (http://sourceforge.net/projects/transconnect) for
> > tunnelling git
> > protocol through a HTTP proxy (squid in my case)
> > supporting the CONNECT method.
> >
> > [snip] 
> > Note: most HTTP proxy servers allow CONNECT method
> > to a very limited range of ports, and 
> > administrators will need to enable the git port
> > (9418) explicitly.
> > 
> I know I'm coming kinda late, but I'm using:
> 
> export GIT_PROXY_COMMAND=/usr/local/bin/proxy-cmd.sh
> 
> and proxy-cmd.sh is just single-line command glued
> from what I found available in /bin:
> 
> #! /bin/bash
> 
> (echo "CONNECT $1:$2 HTTP/1.0"; echo; cat ) | socket
> 
> proxy.ourcompany.com 3128 | (read a; read a; cat )
> 
> Replace socket's arguments 'proxy.ourcompany.com
> 3128' with your http proxy.  Fortunately our proxy
> does not see anything wrong with git's port.
> 		Best regards,
> 			Petr Vandrovec

With above usage on GIT_PROXY_COMMAND, I still have
problem on connection with remote git repository.

I also tried setting http_proxy directly but the same
result. It's first usage of git in our network. Well, 
need I enable the git port 9418 at proxy server? Or 
did I miss sth or what?

I use git-2006-05-14.tar.gz package on FC3. 

Method I : Use GIT_PROXY_COMMAND

[root@sam u-boot]# git clone \
git://www.denx.de/git/u-boot.git u-boot-denx.git

fatal: exec failed
fetch-pack from 'git://www.denx.de/git/u-boot.git' 
failed.

[root@sam u-boot]# git clone \
http://parisc-linux.org/git/linux-2.6.git/ parisc-2.6

Cannot get remote repository information.
Perhaps git-update-server-info needs to be run there?
[root@sam u-boot]#

/usr/local/bin/proxy-cmd.sh 

#! /bin/bash

(echo "CONNECT $1:$2 HTTP/1.0";echo;cat) | socket
<um> <pwd> 192.168.40.99 80 | (read a;read a;cat)

Method II : Use http_proxy directly

[root@sam u-boot]# export \
http_proxy="http://<username>:<pwd>@192.168.40.99:80"
[root@sam u-boot]# git clone \ 
http://parisc-linux.org/git/linux-2.6.git/ parisc-2.6

Cannot get remote repository information.
Perhaps git-update-server-info needs to be run there?

[root@sam u-boot]# git clone \
git://www.denx.de/git/u-boot.git u-boot-denx.git
fatal: unable to connect a socket (Connection timed 
out)
fetch-pack from 'git://www.denx.de/git/u-boot.git' 
failed.
[root@sam u-boot]#

Thanks in advance,

Sam

P.S. I forward this thread from LKML for better 
discussion. Hope Petr wouldn't mind.

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam
protection around 
http://mail.yahoo.com 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
