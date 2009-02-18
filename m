From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Gforge's cvssh.pl script and git
Date: Wed, 18 Feb 2009 15:49:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902181547240.6274@intel-tinevez-2-302>
References: <2c0671440902180124v50570270gc40b745d4a8b1245@mail.gmail.com>  <alpine.DEB.1.00.0902181417510.6274@intel-tinevez-2-302> <2c0671440902180631lbf08d5egb003082a3c683f62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bosko Ivanisevic <bosko.ivanisevic@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 15:51:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZnlN-0004IN-DC
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 15:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbZBROtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 09:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752214AbZBROtc
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 09:49:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:35301 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752124AbZBROtb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 09:49:31 -0500
Received: (qmail invoked by alias); 18 Feb 2009 14:49:29 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp017) with SMTP; 18 Feb 2009 15:49:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX192ytZM7J52dipUxgHdREUPrcPs6NkCfa7qQpfE5J
	PR5n1eI2//8bsT
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <2c0671440902180631lbf08d5egb003082a3c683f62@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110548>

Hi,

On Wed, 18 Feb 2009, Bosko Ivanisevic wrote:

> On Wed, Feb 18, 2009 at 2:24 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Wed, 18 Feb 2009, Bosko Ivanisevic wrote:
> >
> >> In the company I'm working someone has restricted access to all users 
> >> to only use cvs via cvssh.pl script (source at the end of message) 
> >> taken from gforge. This script is set as a shell for all users. Now I 
> >> would like to change it so I can run git too. I've tried by adding 
> >> 'git', 'git-upload-pack', 'git-receive-pack' and 'git-shell' in the 
> >> array @allowed_commands. After that if I try to clone existing 
> >> repository with:
> >>
> >> git clone ssh://testuser@server_name/tmp/test.git
> >>
> >> I get following error:
> >>
> >> fatal: ''/tmp/test.git'': unable to chdir or not a git archive
> >> fatal: The remote end hung up unexpectedly
> >>
> >> I first thought that testuser doesn't have permissions to read
> >> directory /tmp/test.git so I changed mode and gave r+w permissions
> >> recursively on that folder, but result was same.
> >
> > r+w?  Not a+rwx?
> >
> > And only on /tmp/test.git/, or also on /tmp/?
> >
> > A better way would be to use 'sudo -u testuser git ls-remote
> > /tmp/test.git' if sudo is available (you haven't revealed useful
> > information about the host).
> 
> Thanks for your reply. Here are more data. System is SuSe 10.3. On the 
> test server which has same setup but I can change shell when I change 
> testuser's shell to /bin/bash I can regularly clone git repository from 
> remote machine, so all permissions are set correctly. Besides, output 
> of:
> 
> git ls-remote ssh://testuser@server_name:/tmp/test.git
> 
> is:
> 
> 3446c5347e0563cb87e1d8951c57b7f36996f44b        HEAD
> 3446c5347e0563cb87e1d8951c57b7f36996f44b        refs/heads/master
> 
> That leads me to conclusion that perl's exec command makes some mess
> which prevents git of running correctly.

Maybe.  Maybe it is also unsetting ENV which causes grief.

> >> There is no way I can avoid this perl script (company policy) but I 
> >> can change it. Problem is that I do not know Perl so much and I do 
> >> not know what git is exactly doing behind the scene when it is run 
> >> via ssh.
> >
> > I'd use 'system("some shell >&2");' to try to debug it.
> >
> I didn't understand this part. If I change
> 
> exec @cmd;
> 
> command from perl script to:
> 
> system("/bin/bash >&2);
> 
> git clone just hangs on the client side. I guess I did something wrong
> but don't know what.

I did not mean to replace the exec.  Rather, I meant you could do 
something like

	system('ls -l /tmp/test.git >&2');

to see what is actually happening.  I mean, it could be that for some 
reason I do not understand, the whole thing runs in a chroot or some such.

Ciao,
Dscho
